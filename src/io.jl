@mpi_handle FileHandle MPI_File
const FILE_NULL = _FileHandle(MPI_FILE_NULL)
FileHandle() = FileHandle(FILE_NULL.val)

module File

import MPI: MPI, @mpichk, _doc_external, MPIPtr, libmpi, refcount_inc, refcount_dec,
    Comm, MPI_Comm, FileHandle, MPI_File, Info, MPI_Info, FILE_NULL,
    Datatype, MPI_Datatype, MPI_Offset, Status, Buffer, Buffer_send
import Base: close

function open(comm::Comm, filename::AbstractString, amode::Cint, info::Info)
    file = FileHandle()
    # int MPI_File_open(MPI_Comm comm, const char *filename, int amode,
    #                   MPI_Info info, MPI_File *fh)
    @mpichk ccall((:MPI_File_open, libmpi), Cint,
                  (MPI_Comm, Cstring, Cint, MPI_Info, Ptr{MPI_File}),
                  comm, filename, amode, info, file)
    refcount_inc()
    finalizer(close, file)
    file
end

"""
    MPI.File.open(comm::Comm, filename::AbstractString; keywords...)

Open the file identified by `filename`. This is a collective operation on `comm`.

Supported keywords are as follows:
 - `read`, `write`, `create`, `append` have the same behaviour and defaults as `Base.open`.
 - `sequential`: file will only be accessed sequentially (default: `false`)
 - `uniqueopen`: file will not be concurrently opened elsewhere (default: `false`)
 - `deleteonclose`: delete file on close (default: `false`)

Any additional keywords are passed via an [`Info`](@ref) object, and are implementation dependent.

# External links
$(_doc_external("MPI_File_open"))
"""
function open(comm::Comm, filename::AbstractString;
              read=nothing, write=nothing, create=nothing, append=nothing,
              sequential=false, uniqueopen=false, deleteonclose=false,
              infokws...)
    flags = Base.open_flags(read=read, write=write, create=create, truncate=nothing, append=append)
    amode = flags.read ? (flags.write ? MPI.MPI_MODE_RDWR : MPI.MPI_MODE_RDONLY) : (flags.write ? MPI.MPI_MODE_WRONLY : zero(Cint))
    if flags.write
        amode |= flags.create ? MPI.MPI_MODE_CREATE : MPI.MPI_MODE_EXCL
    end
    if flags.append
        amode |= MPI.MPI_MODE_APPEND
    end
    if sequential
        amode |= MPI.MPI_MODE_SEQUENTIAL
    end
    if uniqueopen
        amode |= MPI.MPI_MODE_UNIQUE_OPEN
    end
    if deleteonclose
        amode |= MPI.MPI_MODE_DELETE_ON_CLOSE
    end
    open(comm, filename, amode, Info(infokws...))
end

function close(file::FileHandle)
    if file.val != FILE_NULL.val
        # int MPI_File_close(MPI_File *fh)
        @mpichk ccall((:MPI_File_close, libmpi), Cint,
                      (Ptr{MPI_File},), file)
        refcount_dec()
    end
    return nothing
end

# View
"""
    MPI.File.set_view!(file::FileHandle, disp::Integer, etype::Datatype, filetype::Datatype, datarep::AbstractString; kwargs...)

Set the current process's view of `file`.

The start of the view is set to `disp`; the type of data is set to `etype`; the
distribution of data to processes is set to `filetype`; and the representation of data in
the file is set to `datarep`: one of `"native"` (default), `"internal"`, or `"external32"`.

# External links
$(_doc_external("MPI_File_set_view"))
"""
function set_view!(file::FileHandle, disp::Integer, etype::Datatype, filetype::Datatype, datarep::AbstractString, info::Info)
    # int MPI_File_set_view(MPI_File fh, MPI_Offset disp, MPI_Datatype etype,
    #                       MPI_Datatype filetype, const char *datarep, MPI_Info info)
    @mpichk ccall((:MPI_File_set_view, libmpi), Cint,
                  (MPI_File, MPI_Offset,  MPI_Datatype, MPI_Datatype, Cstring, MPI_Info),
                  file, disp, etype, filetype, datarep, info)
    return file
end

function set_view!(file::FileHandle, disp::Integer, etype::Datatype, filetype::Datatype, datarep="native"; infokwargs...)
    set_view!(file, disp, etype, filetype, datarep, Info(infokwargs...))
end


function sync(file::FileHandle)
    # int MPI_File_sync(MPI_File fh)
    @mpichk ccall((:MPI_File_sync, libmpi), Cint, (MPI_File,), file)
    return nothing
end


# Explicit offsets
"""
    MPI.File.read_at!(file::FileHandle, offset::Integer, data)

Reads from `file` at position `offset` into `data`. `data` can be a [`Buffer`](@ref), or
any object for which `Buffer(data)` is defined.

# See also
- [`MPI.File.read_at_all!`](@ref) for the collective operation

# External links
$(_doc_external("MPI_File_read_at"))
"""
function read_at!(file::FileHandle, offset::Integer, buf::Buffer)
    stat_ref = Ref{Status}(MPI.STATUS_EMPTY)
    # int MPI_File_read_at(MPI_File fh, MPI_Offset offset, void *buf, int count,
    #                      MPI_Datatype datatype, MPI_Status *status)
    @mpichk ccall((:MPI_File_read_at, libmpi), Cint,
                  (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype, Ptr{Status}),
                  file, offset, buf.data, buf.count, buf.datatype, stat_ref)
    return stat_ref[]
end
read_at!(file::FileHandle, offset::Integer, data) = read_at!(file, offset, Buffer(data))

"""
    MPI.File.read_at_all!(file::FileHandle, offset::Integer, data)

Reads from `file` at position `offset` into `data`. `data` can be a [`Buffer`](@ref), or
any object for which `Buffer(data)` is defined. This is a collective operation, so must be
called on all ranks in the communicator on which `file` was opened.

# See also
- [`MPI.File.read_at!`](@ref) for the noncollective operation

# External links
$(_doc_external("MPI_File_read_at_all"))
"""
function read_at_all!(file::FileHandle, offset::Integer, buf::Buffer)
    stat_ref = Ref{Status}(MPI.STATUS_EMPTY)

    # int MPI_File_read_at_all(MPI_File fh, MPI_Offset offset, void *buf,
    #                          int count, MPI_Datatype datatype, MPI_Status *status)
    @mpichk ccall((:MPI_File_read_at_all, libmpi), Cint,
                  (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype, Ptr{Status}),
                  file, offset, buf.data, buf.count, buf.datatype, stat_ref)
    return stat_ref[]
end
read_at_all!(file::FileHandle, offset::Integer, data) = read_at_all!(file, offset, Buffer(data))

"""
    MPI.File.write_at(file::FileHandle, offset::Integer, data)

Writes `data` to `file` at position `offset`. `data` can be a [`Buffer`](@ref), or any
object for which [`Buffer_send(data)`](@ref) is defined.

# See also
- [`MPI.File.write_at_all`](@ref) for the collective operation

# External links
$(_doc_external("MPI_File_write_at"))
"""
function write_at(file::FileHandle, offset::Integer, buf::Buffer)
    stat_ref = Ref{Status}(MPI.STATUS_EMPTY)
    # int MPI_File_write_at(MPI_File fh, MPI_Offset offset, const void *buf,
    #                       int count, MPI_Datatype datatype, MPI_Status *status)
    @mpichk ccall((:MPI_File_write_at, libmpi), Cint,
                  (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype, Ptr{Status}),
                  file, offset, buf.data, buf.count, buf.datatype, stat_ref)
    return stat_ref[]
end
write_at(file::FileHandle, offset::Integer, data) = write_at(file, offset, Buffer_send(data))

"""
    MPI.File.write_at_all(file::FileHandle, offset::Integer, data)

Writes from `data` to `file` at position `offset`. `data` can be a [`Buffer`](@ref), or
any object for which [`Buffer_send(data)`](@ref) is defined. This is a collective
operation, so must be called on all ranks in the communicator on which `file` was opened.

# See also
- [`MPI.File.write_at`](@ref) for the noncollective operation

# External links
$(_doc_external("MPI_File_write_at_all"))
"""
function write_at_all(file::FileHandle, offset::Integer, buf::Buffer)
    stat_ref = Ref{Status}(MPI.STATUS_EMPTY)
    # int MPI_File_write_at_all(MPI_File fh, MPI_Offset offset, const void *buf,
    #                           int count, MPI_Datatype datatype, MPI_Status *status)
    @mpichk ccall((:MPI_File_write_at_all, libmpi), Cint,
                  (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype, Ptr{Status}),
                  file, offset, buf.data, buf.count, buf.datatype, stat_ref)
    return stat_ref[]
end
write_at_all(file::FileHandle, offset::Integer, data) = write_at_all(file, offset, Buffer_send(data))




end # module
