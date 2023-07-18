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

const ERRHANDLER_NULL  = Errhandler(API.MPI_ERRHANDLER_NULL[])
const ERRORS_ARE_FATAL = Errhandler(API.MPI_ERRORS_ARE_FATAL[])
const ERRORS_RETURN    = Errhandler(API.MPI_ERRORS_RETURN[]   )
add_load_time_hook!(LoadTimeHookSetVal(ERRHANDLER_NULL,  API.MPI_ERRHANDLER_NULL ))
add_load_time_hook!(LoadTimeHookSetVal(ERRORS_ARE_FATAL, API.MPI_ERRORS_ARE_FATAL))
add_load_time_hook!(LoadTimeHookSetVal(ERRORS_RETURN,    API.MPI_ERRORS_RETURN   ))

Errhandler() = Errhandler(ERRHANDLER_NULL.val)

function free(errh::Errhandler)
    if errh != ERRHANDLER_NULL && errh != ERRORS_ARE_FATAL && errh != ERRORS_RETURN && !Finalized()
        # int MPI_Errhandler_free(MPI_Errhandler *errhandler)
        API.MPI_Errhandler_free(errh)
    end
    return nothing
end

"""
    MPI.set_default_error_handler_return()

Set the error handler for `MPI_COMM_SELF` and `MPI_COMM_WORLD` to `MPI_ERRORS_RETURN`. This
will cause certain MPI errors to appear as Julia exceptions.

This function is executed automatically by [`MPI.Init()`](@ref) but *may* be invoked
manually if MPI has been initialized externally by a direct call to `MPI_Init()`. It is safe
to call this function multiple times.
"""
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
    API.MPI_Comm_get_errhandler(comm, errh)
    return errh
end
function get_errorhandler(win::Win)
    errh = Errhandler()
    API.MPI_Win_get_errhandler(win, errh)
    return errh
end
function get_errorhandler(file::File.FileHandle)
    errh = Errhandler()
    API.MPI_File_get_errhandler(file, errh)
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
    API.MPI_Comm_set_errhandler(comm, errh)
    return nothing
end
function set_errorhandler!(win::Win, errh::Errhandler)
    API.MPI_Win_set_errhandler(win, errh)
    return nothing
end
function set_errorhandler!(file::File.FileHandle, errh::Errhandler)
    API.MPI_File_set_errhandler(file, errh)
    return nothing
end


