"""
    MPI.Errhandler

An MPI error handler object. Currently only two are supported:

- `ERRORS_ARE_FATAL` (default): program will immediately abort
- `ERRORS_RETURN`: program will throw an `MPIError`.
"""
mutable struct Errhandler
    val::MPI_Errhandler
end
Base.:(==)(a::Errhandler, b::Errhandler) = a.val == b.val
Base.cconvert(::Type{MPI_Errhandler}, errhandler::Errhandler) = errhandler
Base.unsafe_convert(::Type{MPI_Errhandler}, errhandler::Errhandler) = errhandler.val
Base.unsafe_convert(::Type{Ptr{MPI_Errhandler}}, errhandler::Errhandler) = convert(Ptr{MPI_Errhandler}, pointer_from_objref(errhandler))

const ERRHANDLER_NULL  = Errhandler(Consts.MPI_ERRHANDLER_NULL[])
const ERRORS_ARE_FATAL = Errhandler(Consts.MPI_ERRORS_ARE_FATAL[])
const ERRORS_RETURN    = Errhandler(Consts.MPI_ERRORS_RETURN[]   )
add_load_time_hook!(() -> ERRHANDLER_NULL.val  = Consts.MPI_ERRHANDLER_NULL[] )
add_load_time_hook!(() -> ERRORS_ARE_FATAL.val = Consts.MPI_ERRORS_ARE_FATAL[])
add_load_time_hook!(() -> ERRORS_RETURN.val    = Consts.MPI_ERRORS_RETURN[]   )

Errhandler() = Errhandler(ERRHANDLER_NULL.val)

function free(errh::Errhandler)
    if errh != ERRHANDLER_NULL && errh != ERRORS_ARE_FATAL && errh != ERRORS_RETURN && !Finalized()
        # int MPI_Errhandler_free(MPI_Errhandler *errhandler)
        @mpichk ccall((:MPI_Errhandler_free, libmpi), Cint, (Ptr{MPI_Errhandler},), errh)
    end
    return nothing
end

function set_default_error_handler_return()
    set_errorhandler!(COMM_SELF, ERRORS_RETURN)
    set_errorhandler!(COMM_WORLD, ERRORS_RETURN)
end

"""
    MPI.get_errorhandler(comm::MPI.Comm)
    MPI.get_errorhandler(win::MPI.Win)
    MPI.get_errorhandler(file::MPI.File.FileHandle)

Get the current [`Errhandler`](@ref) for the relevant MPI object.

# See also
- [`set_errorhandler!`](@ref)
"""
function get_errorhandler(comm::Comm)
    errh = Errhandler()
    @mpichk ccall((:MPI_Comm_get_errhandler, libmpi), Cint, (MPI_Comm, Ptr{MPI_Errhandler}), comm, errh)
    return errh
end
function get_errorhandler(win::Win)
    errh = Errhandler()
    @mpichk ccall((:MPI_Win_get_errhandler, libmpi), Cint, (MPI_Win, Ptr{MPI_Errhandler}), win, errh)
    return errh
end
function get_errorhandler(file::File.FileHandle)
    errh = Errhandler()
    @mpichk ccall((:MPI_File_get_errhandler, libmpi), Cint, (MPI_File, Ptr{MPI_Errhandler}), file, errh)
    return errh
end

"""
    MPI.set_errorhandler!(comm::MPI.Comm, errh::Errhandler)
    MPI.set_errorhandler!(win::MPI.Win, errh::Errhandler)
    MPI.set_errorhandler!(file::MPI.File.FileHandle, errh::Errhandler)

Set the [`Errhandler`](@ref) for the relevant MPI object.

# See also
- [`get_errorhandler`](@ref)
"""
function set_errorhandler!(comm::Comm, errh::Errhandler)
    @mpichk ccall((:MPI_Comm_set_errhandler, libmpi), Cint, (MPI_Comm, MPI_Errhandler), comm, errh)
    return nothing
end
function set_errorhandler!(win::Win, errh::Errhandler)
    @mpichk ccall((:MPI_Win_set_errhandler, libmpi), Cint, (MPI_Win, MPI_Errhandler), win, errh)
    return nothing
end
function set_errorhandler!(file::File.FileHandle, errh::Errhandler)
    @mpichk ccall((:MPI_File_set_errhandler, libmpi), Cint, (MPI_File, MPI_Errhandler), file, errh)
    return nothing
end


