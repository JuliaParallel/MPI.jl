export WindowIO, WindowWriter

# Type of the number of available entries
const WinCountT = Cint

mutable struct BufferHeader
    count::WinCountT # Number of elements in the buffer
    address::Cptrdiff_t
    length::WinCountT # Current size of the buffer
    needed_length::WinCountT # Size the buffer should have to handle all pending writes
end

"""

    WindowIO(target::Integer, comm=MPI.COMM_WORLD, bufsize=1024^2)

Expose an MPI RMA window using the IO interface. Must be constructed on all ranks in the communicator.
The target is the rank to which data is sent when calling write, comm is the communicator to use and
bufsize is the initial size of the buffer. A target may be written to by multiple ranks concurrently,
and the receive buffer will be grown as needed, but never shrinks.
Communication happens only when flush is called.
"""
mutable struct WindowIO <: IO
    comm::MPI.Comm
    myrank::Int
    # Represents the received data. First elements contain a counter with the total number of entries in the buffer
    buffer::Array{UInt8,1}
    win::Win
    header::BufferHeader
    remote_header::BufferHeader
    header_win::Win
    header_cwin::CWin
    is_open::Bool
    # Current read position
    ptr::WinCountT
    data_available::Condition
    read_requested::Condition
    lock::ReentrantLock # Needed for Base
    waiter

    function WindowIO(comm=MPI.COMM_WORLD, bufsize=1024^2)
        buffer = Array{UInt8,1}(bufsize)
        header_win = MPI.Win()
        header = BufferHeader(0, MPI.Get_address(buffer), bufsize, bufsize)
        remote_header = BufferHeader(0, MPI.Get_address(buffer), bufsize, bufsize)
        header_arr = unsafe_wrap(Vector{UInt8}, Ptr{UInt8}(pointer_from_objref(header)), sizeof(BufferHeader))
        MPI.Win_create(header_arr, MPI.INFO_NULL, comm, header_win)
        win = MPI.Win()
        MPI.Win_create_dynamic(MPI.INFO_NULL, comm, win)
        MPI.Win_attach(win, buffer)

        w = new(comm,
            MPI.Comm_rank(comm),
            buffer,
            win,
            header,
            remote_header,
            header_win,
            CWin(header_win),
            true,
            0,
            Condition(),
            Condition(),
            ReentrantLock(),
            nothing)

        w.waiter = Task(function()
            wait(w.read_requested)
            while w.is_open
                while !has_data_available(w) && w.is_open
                    yield()
                end
                if w.is_open
                    notify(w.data_available)
                    wait(w.read_requested)
                end
            end
        end)

        yield(w.waiter)
        
        return w
    end
end


Base.nb_available(w::WindowIO)::WinCountT = w.header.count - w.ptr

# Checks if data is available and grows the buffer if needed by the writing side
function has_data_available(w::WindowIO)
    if !w.is_open
        return false
    end

    if w.header.count > w.ptr && w.header.needed_length == w.header.length # fast check without window sync
        return true
    end

    # Check if we need to grow the buffer
    MPI.Win_lock(MPI.LOCK_EXCLUSIVE, w.myrank, 0, w.header_win)
    MPI.Win_sync(w.header_cwin) # CWin version doesn't allocate
    if w.header.needed_length > w.header.length
        MPI.Win_detach(w.win, w.buffer)
        resize!(w.buffer, w.header.needed_length)
        MPI.Win_attach(w.win, w.buffer)
        w.header.address = MPI.Get_address(w.buffer)
        w.header.length = w.header.needed_length
    end
    MPI.Win_unlock(w.myrank, w.header_win)
    
    return w.header.count > w.ptr
end

function Base.wait(w::WindowIO)
    notify(w.read_requested)
    wait(w.data_available)
end

# Waits for data and returns the number of available bytes
function wait_nb_available(w)
    if !has_data_available(w)
        wait(w)
    end
    return nb_available(w)
end

# wait until the specified number of bytes is available or the stream is closed
function wait_nb_available(w, nb)
    nb_found = wait_nb_available(w)
    while nb_found < nb && w.is_open
        MPI.Win_lock(MPI.LOCK_SHARED, w.myrank, 0, w.header_win)
        MPI.Win_sync(w.header_cwin) # sync every loop, to make sure we get updates
        MPI.Win_unlock(w.myrank, w.header_win)
        nb_found = wait_nb_available(w)
    end
    return nb_found
end

mutable struct WindowWriter <: IO
    winio::WindowIO
    target::Int
    # Writes are buffered to only lock and communicate upon flush
    write_buffer::Vector{UInt8}
    lock::ReentrantLock
    nb_written::Int

    function WindowWriter(w::WindowIO, target::Integer)
        return new(w, target, Vector{UInt8}(1024^2), ReentrantLock(), 0)
    end
end

@inline Base.isopen(w::WindowIO)::Bool = w.is_open
@inline Base.isopen(s::WindowWriter)::Bool = s.winio.is_open

function Base.eof(w::WindowIO)
    if !isopen(w)
        return true
    else
        wait_nb_available(w)
    end
    return !isopen(w)
end

Base.iswritable(::WindowIO) = false
Base.isreadable(::WindowIO) = true
Base.iswritable(::WindowWriter) = true
Base.isreadable(::WindowWriter) = false

function Base.close(w::WindowIO)
    w.is_open = false
    notify(w.read_requested)
    wait(w.waiter) # Wait for the data notification loop to finish
    MPI.Win_lock(MPI.LOCK_EXCLUSIVE, w.myrank, 0, w.header_win)
    w.header.count = 0
    w.ptr = 0
    MPI.Win_unlock(w.myrank, w.header_win)
    MPI.Barrier(w.comm)
    MPI.Win_free(w.win)
    MPI.Win_free(w.header_win)
end
Base.close(s::WindowWriter) = nothing

# Checks if all available data is read, and if so resets the counter with the number of written bytes to 0
function complete_read(w::WindowIO)
    if w.header.count != 0 && w.header.count == w.ptr
        MPI.Win_lock(MPI.LOCK_EXCLUSIVE, w.myrank, 0, w.header_win)
        if w.header.count != 0 && w.header.count == w.ptr #  Check again after locking
            w.header.count = 0
            w.ptr = 0
        end
        MPI.Win_unlock(w.myrank, w.header_win)
    end
end

function Base.read(w::WindowIO, ::Type{UInt8})
    if wait_nb_available(w) < 1
        throw(EOFError())
    end

    w.ptr += 1
    result = w.buffer[w.ptr]
    complete_read(w)
    return result
end

function Base.readbytes!(w::WindowIO, b::AbstractVector{UInt8}, nb=length(b); all::Bool=true)
    nb_obtained = nb_available(w)
    if all
        nb_obtained = wait_nb_available(w,nb)
        if nb_obtained < nb
            throw(EOFError())
        end
        resize!(b, nb)
    end
    nb_read = min(nb_obtained, nb)
    if nb_read == 0
        return 0
    end
    copy!(b, 1, w.buffer, w.ptr+1, nb_read)
    w.ptr += nb_read
    complete_read(w)
    return nb_read
end

Base.readavailable(w::WindowIO) = read!(w, Vector{UInt8}(nb_available(w)))

@inline function Base.unsafe_read(w::WindowIO, p::Ptr{UInt8}, nb::UInt)
    nb_obtained = wait_nb_available(w,nb)
    nb_read = min(nb_obtained, nb)
    unsafe_copy!(p, pointer(w.buffer, w.ptr+1), nb_read)
    w.ptr += nb_read
    complete_read(w)
    if nb_read != nb
        throw(EOFError())
    end
    return
end

function Base.read(w::WindowIO, nb::Integer; all::Bool=true)
    buf = Vector{UInt8}(nb)
    readbytes!(w, buf, nb, all=all)
    return buf
end

function ensureroom(w::WindowWriter)
    if w.nb_written > length(w.write_buffer)
        resize!(w.write_buffer, w.nb_written)
    end
end

function Base.write(w::WindowWriter, b::UInt8)
    w.nb_written += 1
    ensureroom(w)
    w.write_buffer[w.nb_written] = b
    return sizeof(UInt8)
end
function Base.unsafe_write(w::WindowWriter, p::Ptr{UInt8}, nb::UInt)
    offset = w.nb_written+1
    w.nb_written += nb
    ensureroom(w)
    copy!(w.write_buffer, offset, unsafe_wrap(Array{UInt8}, p, nb), 1, nb)
    return nb
end

Base.flush(::WindowIO) = error("WindowIO is read-only, did you mean to flush an associated WindowWriter?")

function Base.flush(s::WindowWriter)
    if !isopen(s)
        throw(EOFError())
    end
    nb_to_write = s.nb_written
    free = 0
    header = s.winio.remote_header
    header_win = s.winio.header_win
    while free < nb_to_write
        MPI.Win_lock(MPI.LOCK_EXCLUSIVE, s.target, 0, header_win)
        MPI.Get(Ptr{UInt8}(pointer_from_objref(header)), sizeof(BufferHeader), s.target, 0, header_win)
        MPI.Win_flush(s.target, header_win)
        free = header.length - header.count
        if free >= nb_to_write
            MPI.Win_lock(MPI.LOCK_EXCLUSIVE, s.target, 0, s.winio.win)
            MPI.Put(pointer(s.write_buffer), nb_to_write, s.target, header.address + header.count, s.winio.win)
            MPI.Win_unlock(s.target, s.winio.win)
            MPI.Put(Ref{WinCountT}(header.count + nb_to_write), s.target, header_win)
            s.nb_written = 0
        else
            # Request to grow buffer, if not done already
            new_needed_length = max(header.needed_length, header.count + nb_to_write)
            if (new_needed_length > header.needed_length)
                header.needed_length = new_needed_length
                MPI.Put(Ptr{UInt8}(pointer_from_objref(header)), sizeof(BufferHeader), s.target, 0, header_win)
            end
        end
        MPI.Win_unlock(s.target, header_win)
    end
end
