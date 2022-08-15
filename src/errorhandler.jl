"""
    MPI.ErrorHandler

An MPI error handler object. Currently only two are supported:

- `ERRORS_ARE_FATAL` (default): program will immediately abort
- `ERRORS_RETURN`: program will throw an `MPIError`.
"""
mutable struct ErrorHandler
    val::MPI_Errhandler
end
Base.:(==)(a::ErrorHandler, b::ErrorHandler) = a.val == b.val
Base.cconvert(::Type{MPI_Errhandler}, errhandler::ErrorHandler) = errhandler
Base.unsafe_convert(::Type{MPI_Errhandler}, errhandler::ErrorHandler) = errhandler.val
Base.unsafe_convert(::Type{Ptr{MPI_ErrorHandler}}, errhandler::ErrorHandler) = convert(Ptr{MPI_Errhandler}, pointer_from_objref(errhandler))

const ERRHANDLER_NULL  = ErrorHandler(Consts.MPI_ERRHANDLER_NULL[])
const ERRORS_ARE_FATAL = ErrorHandler(Consts.MPI_ERRORS_ARE_FATAL[])
const ERRORS_RETURN    = ErrorHandler(Consts.MPI_ERRORS_RETURN[]   )
add_load_time_hook!(() -> ERRHANDLER_NULL.val  = Consts.MPI_ERRHANDLER_NULL[] )
add_load_time_hook!(() -> ERRORS_ARE_FATAL.val = Consts.MPI_ERRORS_ARE_FATAL[])
add_load_time_hook!(() -> ERRORS_RETURN.val    = Consts.MPI_ERRORS_RETURN[]   )

ErrorHandler() = ErrorHandler(ERRHANDLER_NULL.val)

function free(errh::ErrorHandler)
    if errh != ERRHANDLER_NULL && errh != ERRORS_ARE_FATAL && errh != ERRORS_RETURN && !Finalized()
        # int MPI_Errhandler_free(MPI_Errhandler *errhandler)
        @mpichk ccall((:MPI_Errhandler_free, libmpi), Cint, (Ptr{MPI_Errhandler},), errh)
    end
    return nothing
end

function set_default_error_handler_return()
    set_error_handler!(COMM_SELF, ERRORS_RETURN)
    set_error_handler!(COMM_WORLD, ERRORS_RETURN)
end

"""
    MPI.get_error_handler(comm::MPI.Comm)
    MPI.get_error_handler(win::MPI.Win)
    MPI.get_error_handler(file::MPI.File.FileHandle)

Get the current [`ErrorHandler`](@ref) for the relevant MPI object.

# See also
- [`set_error_handler!`](@ref)
"""
function get_error_handler(comm::Comm)
    errh = ErrorHandler()
    @mpichk ccall((:MPI_Comm_get_errhandler, libmpi), Cint, (MPI_Comm, Ptr{MPI_Errhandler}), comm, errh)
    return errh
end
function get_error_handler(win::Win)
    errh = ErrorHandler()
    @mpichk ccall((:MPI_Win_get_errhandler, libmpi), Cint, (MPI_Win, Ptr{MPI_Errhandler}), win, errh)
    return errh
end
function get_error_handler(file::File.FileHandle)
    errh = ErrorHandler()
    @mpichk ccall((:MPI_File_get_errhandler, libmpi), Cint, (MPI_File, Ptr{MPI_Errhandler}), file, errh)
    return errh
end

"""
    MPI.set_error_handler!(comm::MPI.Comm, errh::ErrorHandler)
    MPI.set_error_handler!(win::MPI.Win, errh::ErrorHandler)
    MPI.set_error_handler!(file::MPI.File.FileHandle, errh::ErrorHandler)

Set the [`ErrorHandler`](@ref) for the relevant MPI object.

# See also
- [`get_error_handler`](@ref)
"""
function set_error_handler!(comm::Comm, errh::ErrorHandler)
    @mpichk ccall((:MPI_Comm_set_errhandler, libmpi), Cint, (MPI_Comm, MPI_Errhandler), comm, errh)
    return nothing
end
function set_error_handler!(win::Win, errh::ErrorHandler)
    @mpichk ccall((:MPI_Win_set_errhandler, libmpi), Cint, (MPI_Win, MPI_Errhandler), win, errh)
    return nothing
end
function set_error_handler!(file::File.FileHandle, errh::ErrorHandler)
    @mpichk ccall((:MPI_File_set_errhandler, libmpi), Cint, (MPI_File, MPI_Errhandler), file, errh)
    return nothing
end


