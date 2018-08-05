using Test
using MPI

MPI.Init()

comm = MPI.COMM_WORLD

const rank = MPI.Comm_rank(comm)
const N = MPI.Comm_size(comm)

if N < 2
    error("This test needs at least 2 processes")
    exit(1)
end

const winio = WindowIO(comm)
const writer = WindowWriter(winio, 0)

# directly test the different read functions
if rank == 1
    write(writer, UInt8(5))
    flush(writer) # Must flush to trigger communication
elseif rank == 0
    @test MPI.wait_nb_available(winio) == 1
    @test read(winio, UInt8) == UInt8(5)
    @test nb_available(winio) == 0
end

MPI.Barrier(comm)

if rank == 1
    write(writer, "hello")
    flush(writer) # Must flush to trigger communication
elseif rank == 0
    @test MPI.wait_nb_available(winio) == 5
    arr = Vector{UInt8}(undef,5)
    readbytes!(winio, arr)
    @test String(arr) == "hello"
    @test nb_available(winio) == 0
end

MPI.Barrier(comm)

if rank == 1
    write(writer, "hello")
    flush(writer) # Must flush to trigger communication
elseif rank == 0
    @test MPI.wait_nb_available(winio) == 5
    arr = Vector{UInt8}(undef,5)
    unsafe_read(winio, pointer(arr), 2)
    @test nb_available(winio) == 3
    unsafe_read(winio, pointer(arr,3), 3)
    @test String(arr) == "hello"
    @test nb_available(winio) == 0
end

MPI.Barrier(comm)

if rank == 1
    write(writer, "hello")
    flush(writer) # Must flush to trigger communication
elseif rank == 0
    arr = Vector{UInt8}(undef,3)
    readbytes!(winio, arr) # waits for data
    @test nb_available(winio) == 2
    @test String(copy(arr)) == "hel"
    fill!(arr, UInt8('a'))
    readbytes!(winio, arr, all=false) # reads what's available
    @test String(arr) == "loa"
    @test nb_available(winio) == 0
end

MPI.Barrier(comm)

if rank == 1
    write(writer, "hello")
    flush(writer) # Must flush to trigger communication
elseif rank == 0
    result = "hello"
    for i in 1:5
        @test read(winio, Char) == result[i]
        @test nb_available(winio) == 5 - i
    end
end

MPI.Barrier(comm)

if rank != 0
    write(writer, 1, 2.0, Cint(3))
    flush(writer) # Must flush to trigger communication
else
    expected_nb_recv = sizeof(1) + sizeof(2.0) + sizeof(Cint(3))
    result = read(winio, (N-1)*expected_nb_recv)
    @test nb_available(winio) == 0
    @test length(result) == (N-1)*expected_nb_recv
end

MPI.Barrier(comm)

# Test blocking read
if rank != 0
    write(writer, rank)
    flush(writer) # Must flush to trigger communication
else
    result = read(winio, (N-1)*sizeof(Int)) # Blocks until all required data is read
    @test sort(reinterpret(Int,result)) == collect(1:N-1)
    @test nb_available(winio) == 0
end

MPI.Barrier(comm)

# Timing
if rank == 1
    const arr = ones(UInt8,100000)
    println("write and flush timings:")
    @time write(writer, arr)
    @time flush(writer)
    @time write(writer, arr)
    @time flush(writer)
    @time write(writer, arr)
    @time flush(writer)
    MPI.Barrier(comm)
elseif rank == 0
    const recarr = Vector{UInt8}(undef,100000)
    MPI.Barrier(comm)

    println("read timings:")
    @time read!(winio, recarr)
    @time read!(winio, recarr)
    @time read!(winio, recarr)
    @test recarr == ones(UInt8,100000)
else
    MPI.Barrier(comm)
end

MPI.Barrier(comm)

# Test readline
message = "Hi from rank "
if rank != 0
    println(writer, message*string(rank))
    flush(writer) # Must flush to trigger communication
else
    global nb_received = 0
    while nb_received != N-1
        line = readline(winio)
        @test startswith(line, message)
        @test line[length(message)+1:end] ∈ string.(1:N)
        global nb_received += 1
    end
end

MPI.Barrier(comm)
close(winio)
MPI.Barrier(comm)

# Send more than the buffer can contain
BS = 24
const winio2 = WindowIO(comm, BS+sizeof(MPI.WinCountT))
const writer2 = WindowWriter(winio2, 0)
if rank != 0
    write(writer2, rank*ones(BS))
    flush(writer2) # Must flush to trigger communication
else
    result = Vector{Float64}(undef,BS*(N-1))
    read!(winio2, result)
    header = winio2.header
    @test nb_available(winio2) == 0
    @test header.count == 0
    @test header.length == header.needed_length
    @test header.length > BS+sizeof(MPI.WinCountT)    
    @test sum(result) == sum((1:N-1)*BS)
end

close(winio2)
MPI.Finalize()
