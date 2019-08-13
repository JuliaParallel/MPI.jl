const REFCOUNT = Threads.Atomic{Int}(1)

"""
    refcount_inc()

Increment the MPI reference counter. This should be called at initialization of any object
which calls an MPI routine in its finalizer. A matching [`refcount_dec`](@ref) should be
added to the finalizer.

For more details, see [Finalizers](@ref).
"""
function refcount_inc()
    Threads.atomic_add!(REFCOUNT, 1)
end

"""
    refcount_dec()

Decrement the MPI reference counter. This should be added after an MPI call in an object
finalizer, with a matching [`refcount_inc`](@ref) when the object is initialized.

For more details, see [Finalizers](@ref).
"""
function refcount_dec()
    # refcount zero, all objects finalized, now finalize MPI
    if Threads.atomic_sub!(REFCOUNT, 1) == 1
        !Finalized() && _Finalize()
    end
end

# Administrative functions
"""
    Init()

Initialize MPI in the current process.

All MPI programs must contain exactly one call to `MPI.Init()`.

The only MPI functions that may be called before `MPI.Init()` are
[`MPI.Initialized`](@ref) and [`MPI.Finalized`](@ref).

# External links
$(_doc_external("MPI_Init"))
"""
function Init()
    if REFCOUNT[] != 1
        error("MPI REFCOUNT in incorrect state")
    end
    @mpichk ccall((:MPI_Init, libmpi), Nothing, (Ptr{Cint},Ptr{Cint}), C_NULL, C_NULL)
    atexit(refcount_dec)

    for f in mpi_init_hooks
        f()
    end
end

"""
    Finalize()

Marks MPI state for cleanup. This should be called after [`Init`](@ref), at most once, and
no further MPI calls (other than [`Initialized`](@ref) or [`Finalized`](@ref)) should be
made after it is called.

Note that this does not correspond exactly to `MPI_FINALIZE` in the MPI specification. In
particular:

- It may not finalize MPI immediately. Julia will wait until all MPI-related objects are
  garbage collected before finalizing MPI. As a result, [`Finalized()`](@ref) may return
  `false` after `Finalize()` has been called. See [Finalizers](@ref) for more details.

- It is optional: [`Init`](@ref) will automatically insert a hook to finalize MPI when
  Julia exits.

# External links
$(_doc_external("MPI_Finalize"))
"""
function Finalize()
    # calling atexit here is a bit silly, but it's to avoid a case where MPI is finalized
    # one object early, e.g.
    #
    # event         | REFCOUNT
    # ---------------------
    # Init()        |   1  : MPI_INIT
    # new object    |   2  : MPI_X_CREATE
    # Finalize()    |   1
    # atexit        |
    #  refcount_inc |   2  : relies on LIFO ordering
    #  refcount_dec |   1  : MPI_FINALIZE would otherwise be called here
    # finalizers    |
    #  refcount_dec |   0  : MPI_X_FREE, MPI_FINALIZE
    atexit(refcount_inc)
    refcount_dec()
end

function _Finalize()
    @mpichk ccall((:MPI_Finalize, libmpi), Nothing, ())
end

"""
    Abort(comm::Comm, errcode::Integer)

Make a “best attempt” to abort all tasks in the group of `comm`. This function does not
require that the invoking environment take any action with the error code. However, a Unix
or POSIX environment should handle this as a return errorcode from the main program.

# External links
$(_doc_external("MPI_Abort"))
"""
function Abort(comm::Comm, errcode::Integer)
    @mpichk ccall((:MPI_Abort, libmpi), Cint, (MPI_Comm, Cint), comm, errcode)
end

"""
    Initialized()

Returns `true` if [`MPI.Init`](@ref) has been called, `false` otherwise.

It is unaffected by [`MPI.Finalize`](@ref), and is one of the few functions that may be
called before [`MPI.Init`](@ref).

# External links
$(_doc_external("MPI_Intialized"))
"""
function Initialized()
    flag = Ref{Cint}()
    @mpichk ccall((:MPI_Initialized, libmpi), Cint, (Ptr{Cint},), flag)
    flag[] != 0
end

"""
    Finalized()

Returns `true` if [`MPI.Finalize`](@ref) has completed, `false` otherwise.

It is safe to call before [`MPI.Init`](@ref) and after [`MPI.Finalize`](@ref).

# External links
$(_doc_external("MPI_Finalized"))
"""
function Finalized()
    flag = Ref{Cint}()
    @mpichk ccall((:MPI_Finalized, libmpi), Cint, (Ptr{Cint},), flag)
    flag[] != 0
end

function Wtick()
    @static if Sys.iswindows()
        ccall((:MPI_Wtick, libmpi), stdcall, Cdouble, ())
    else
        ccall((:MPI_Wtick, libmpi), Cdouble, ())
    end        
end

function Wtime()
    @static if Sys.iswindows()
        ccall((:MPI_Wtime, libmpi), stdcall, Cdouble, ())
    else
        ccall((:MPI_Wtime, libmpi), Cdouble, ())
    end
end

