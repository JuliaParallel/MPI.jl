"""
    mpiexec(fn)

A wrapper function for the MPI launcher executable. Calls `fn(cmd)`, where `cmd` is a `Cmd` object of the MPI launcher.

# Usage

```jldoctest
julia> mpiexec(cmd -> run(`\$cmd -n 3 echo hello world`));
hello world
hello world
hello world
```
"""
mpiexec

# Administrative functions
function _warn_if_wrong_mpi()
    # warn if we have only one process but environment variables
    # suggest we should have more
    if Comm_rank(MPI.COMM_WORLD) == 0 && Comm_size(MPI.COMM_WORLD) == 1
        known_envvars = ("MPI_LOCALNRANKS", #MPICH
                         "OMPI_COMM_WORLD_SIZE" # OpenMPI
                         )
        if any(v -> haskey(ENV, v) && parse(Int, ENV[v]) > 1, known_envvars)
            @warn """
                You appear to have run julia under a different `mpiexec` than the one used by MPI.jl.
                See the documentation for details.
            """
        end
    end
end


"""
    MPI.free(obj)

Free the MPI object handle `obj`. This is typically used as the finalizer, and so need not be called directly unless otherwise noted.
"""
function free
end


const mpi_init_hooks = Any[]
add_init_hook!(f) = push!(mpi_init_hooks, f)
function run_init_hooks()
    for f in mpi_init_hooks
        f()
    end
    empty!(mpi_init_hooks)
    return nothing
end


"""
    Init(;threadlevel=:serialized, finalize_atexit=true, errors_return=true)

Initialize MPI in the current process. The keyword options:

- `threadlevel`: either `:single`, `:funneled`, `:serialized` (default),
  `:multiple`, or an instance of [`ThreadLevel`](@ref).
- `finalize_atexit`: if `true` (default), adds an `atexit` hook to call
  [`MPI.Finalize`](@ref) if it hasn't already been called.
- `errors_return`: if `true` (default), will set the default error handlers for
  [`MPI.COMM_SELF`](@ref) and [`MPI.COMM_WORLD`](@ref) to be
  `MPI.ERRORS_RETURN`. MPI errors will then appear as Julia exceptions.

It will return the [`ThreadLevel`](@ref) value which MPI is initialized at.

All MPI programs must call this function at least once before calling any other
MPI operations: the only MPI functions that may be called before `MPI.Init` are
[`MPI.Initialized`](@ref) and [`MPI.Finalized`](@ref).

It is safe to call `MPI.Init` multiple times, however it is not valid to call
it after calling [`MPI.Finalize`](@ref).

# External links
$(_doc_external("MPI_Init"))
$(_doc_external("MPI_Init_thread"))
"""
function Init(;threadlevel=:serialized, finalize_atexit=true, errors_return=true)
    if threadlevel isa Symbol
        threadlevel = ThreadLevel(threadlevel)
    end
    if MPI.Finalized()
        error("MPI cannot be initialized after MPI.Finalize has been called.")
    end
    if MPI.Initialized()
        provided = Query_thread()
        if provided < threadlevel
            @warn "MPI already initialized with thread level $provided, requested = $threadlevel"
        end
    else
        provided = _init_thread(threadlevel)
        if provided < threadlevel
            @warn "MPI thread level requested = $threadlevel, provided = $provided"
        end

        if finalize_atexit
            atexit() do
                # MPI_Finalize is a collective and can act like a barrier (this may be implementation
                # specific). If we are terminating due to a Julia exception, we shouldn't call
                # MPI_Finalize. We thus peek at the current exception, and only if that field is
                # nothing do we terminate.
                if !Finalized() && ccall(:jl_current_exception, Any, ()) === nothing
                    Finalize()
                end
            end
        end

        run_init_hooks()
        if errors_return
            set_default_error_handler_return()
        end
        _warn_if_wrong_mpi()
    end
    return provided
end

"""
    ThreadLevel

An Enum denoting the level of threading support in the current process:

 - `MPI.THREAD_SINGLE`: Only one thread will execute.

 - `MPI.THREAD_FUNNELED`: The process may be multi-threaded, but the application must
   ensure that only the main thread makes MPI calls. See [`Is_thread_main`](@ref).

 - `MPI.THREAD_SERIALIZED`: The process may be multi-threaded, and multiple threads may
   make MPI calls, but only one at a time (i.e. all MPI calls are serialized).

 - `MPI.THREAD_MULTIPLE`: Multiple threads may call MPI, with no restrictions.

# See also

- [`Init`](@ref)
- [`Query_thread`](@ref)
"""
mutable struct ThreadLevel
    val::Cint
end
const THREAD_SINGLE     = ThreadLevel(Consts.MPI_THREAD_SINGLE[])
const THREAD_FUNNELED   = ThreadLevel(Consts.MPI_THREAD_FUNNELED[])
const THREAD_SERIALIZED = ThreadLevel(Consts.MPI_THREAD_SERIALIZED[])
const THREAD_MULTIPLE   = ThreadLevel(Consts.MPI_THREAD_MULTIPLE[])
add_load_time_hook!(() -> THREAD_SINGLE.val     = Consts.MPI_THREAD_SINGLE[]    )
add_load_time_hook!(() -> THREAD_FUNNELED.val   = Consts.MPI_THREAD_FUNNELED[]  )
add_load_time_hook!(() -> THREAD_SERIALIZED.val = Consts.MPI_THREAD_SERIALIZED[])
add_load_time_hook!(() -> THREAD_MULTIPLE.val   = Consts.MPI_THREAD_MULTIPLE[]  )
ThreadLevel(threadlevel::Symbol) =
    threadlevel == :single ? THREAD_SINGLE :
    threadlevel == :funneled ? THREAD_FUNNELED :
    threadlevel == :serialized ? THREAD_SERIALIZED :
    threadlevel == :multiple ? THREAD_MULTIPLE :
    error("Invalid threadlevel: must be one of :single, :funneled, :serialized, or :multiple")
Base.:(==)(tl1::ThreadLevel, tl2::ThreadLevel) = tl1.val == tl2.val
Base.isless(tl1::ThreadLevel, tl2::ThreadLevel) = tl1.val < tl2.val

function _init_thread(required::ThreadLevel)
    r_provided = Ref{Cint}()
    # int MPI_Init_thread(int *argc, char ***argv, int required, int *provided)
    @mpichk ccall((:MPI_Init_thread, libmpi), Cint,
                    (Ptr{Cint},Ptr{Cvoid}, Cint, Ref{Cint}),
                    C_NULL, C_NULL, required.val, r_provided)
    return ThreadLevel(r_provided[])
end


"""
    Query_thread()

Query the level of threading support in the current process.
Returns a [`ThreadLevel`](@ref) value denoting

# External links
$(_doc_external("MPI_Query_thread"))
"""
function Query_thread()
    r_provided = Ref{Cint}()

    # int MPI_Query_thread(int *provided)
    @mpichk ccall((:MPI_Query_thread, libmpi), Cint,
                  (Ref{Cint},), r_provided)
    return ThreadLevel(r_provided[])
end

"""
    Is_thread_main()

Queries whether the current thread is the main thread according to MPI. This can be called
by any thread, and is useful for the  `THREAD_FUNNELED` [`ThreadLevel`](@ref).

# External links
$(_doc_external("MPI_Is_thread_main"))
"""
function Is_thread_main()
    r_flag = Ref{Cint}()
    # int MPI_Is_thread_main(int *flag)
    @mpichk ccall((:MPI_Is_thread_main, libmpi), Cint,
                  (Ref{Cint},), r_flag)
    return r_flag[] != 0
end



"""
    Finalize()

Marks MPI state for cleanup. This should be called after [`MPI.Init`](@ref), and
can be called at most once. No further MPI calls (other than
[`Initialized`](@ref) or [`Finalized`](@ref)) should be made after it is called.

[`MPI.Init`](@ref) will automatically insert a hook to call this function when
Julia exits, if it hasn't already been called.

# External links
$(_doc_external("MPI_Finalize"))
"""
function Finalize()
    if !MPI.Finalized()
        @mpichk ccall((:MPI_Finalize, libmpi), Cint, ())
    end
    return nothing
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
    @mpicall ccall((:MPI_Wtick, libmpi), Cdouble, ())
end

function Wtime()
    @mpicall ccall((:MPI_Wtime, libmpi), Cdouble, ())
end


"""
    MPI.has_cuda()

Check if the MPI implementation is known to have CUDA support. Currently only Open MPI
provides a mechanism to check, so it will return `false` with other implementations
(unless overriden).

This can be overriden by setting the `JULIA_MPI_HAS_CUDA` environment variable to `true`
or `false`.
"""
function has_cuda()
    flag = get(ENV, "JULIA_MPI_HAS_CUDA", nothing)
    if flag === nothing
        # Only Open MPI provides a function to check CUDA support
        @static if MPI_LIBRARY == "OpenMPI"
            # int MPIX_Query_cuda_support(void)
            return 0 != ccall((:MPIX_Query_cuda_support, libmpi), Cint, ())
        elseif MPI_LIBRARY == "IBMSpectrumMPI"
            return true
        else
            return false
        end
    else
        return parse(Bool, flag)
    end
end
