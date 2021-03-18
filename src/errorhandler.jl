"""
    MPI.Errhandler

An MPI error handler object. Currently only two are supported:

- `ERRORS_ARE_FATAL` (default): program will immediately abort
- `ERRORS_RETURN`: program will throw an `MPIError`.
"""
@mpi_handle ErrorHandler MPI_Errhandler

const ERRORS_ARE_FATAL = _ErrorHandler(MPI_ERRORS_ARE_FATAL)
const ERRORS_RETURN = _ErrorHandler(MPI_ERRORS_RETURN)

function free(errh::ErrorHandler)
    if !Finalized()
        # int MPI_Errhandler_free(MPI_Errhandler *errhandler)
        @mpichk ccall((:MPI_Errhandler_free, libmpi), Cint, (Ptr{MPI_Errhandler},), errh)
    end
    return nothing
end

"""
    MPI.get_errorhandler(comm::MPI.Comm)
    MPI.get_errorhandler(win::MPI.Win)
    MPI.get_errorhandler(file::MPI.File.FileHandle)

Get the current [`ErrorHandler`](@ref) for the relevant MPI object.

# See also
- [`set_errorhandler!`](@ref)
"""
function get_errorhandler(comm::Comm)
    errh = ErrorHandler(ERRORS_ARE_FATAL.val)
    @mpichk ccall((:MPI_Comm_get_errhandler, libmpi), Cint, (MPI_Comm, Ptr{MPI_Errhandler}), comm, errh)
    finalizer(free, errh)
    return errh
end
function get_errorhandler(win::Win)
    errh = ErrorHandler(ERRORS_ARE_FATAL.val)
    @mpichk ccall((:MPI_Win_get_errhandler, libmpi), Cint, (MPI_Win, Ptr{MPI_Errhandler}), win, errh)
    return errh
end
function get_errorhandler(file::File.FileHandle)
    errh = ErrorHandler(ERRORS_ARE_FATAL.val)
    @mpichk ccall((:MPI_File_get_errhandler, libmpi), Cint, (MPI_File, Ptr{MPI_Errhandler}), file, errh)
    return errh
end

"""
    MPI.set_errorhandler!(comm::MPI.Comm, errh::ErrorHandler)
    MPI.set_errorhandler!(win::MPI.Win, errh::ErrorHandler)
    MPI.set_errorhandler!(file::MPI.File.FileHandle, errh::ErrorHandler)

Set the [`ErrorHandler`](@ref) for the relevant MPI object.

# See also
- [`get_errorhandler`](@ref)
"""
function set_errorhandler!(comm::Comm, errh::ErrorHandler)
    @mpichk ccall((:MPI_Comm_set_errhandler, libmpi), Cint, (MPI_Comm, MPI_Errhandler), comm, errh)
    return nothing
end
function set_errorhandler!(win::Win, errh::ErrorHandler)
    @mpichk ccall((:MPI_Win_set_errhandler, libmpi), Cint, (MPI_Win, MPI_Errhandler), win, errh)
    return nothing
end
function set_errorhandler!(file::File.FileHandle, errh::ErrorHandler)
    @mpichk ccall((:MPI_File_set_errhandler, libmpi), Cint, (MPI_File, MPI_Errhandler), file, errh)
    return nothing
end
