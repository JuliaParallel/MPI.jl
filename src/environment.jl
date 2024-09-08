"""
    mpiexec()

A wrapper function for the MPI launcher executable. Returns a `Cmd` object pointing to the MPI launcher.

# Usage

```jldoctest
julia> run(`\$(mpiexec()) -n 3 echo hello world`);
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

"""
    MPI.add_init_hook!(f)

Register a function `f` that will be called as `f()` when `MPI.Init` is
called. These are invoked in a first-in, first-out (FIFO) order.
"""
add_init_hook!(f) = push!(mpi_init_hooks, f)

"""
    MPI.run_init_hooks()

Execute all functions that have been registered using [`MPI.add_init_hook!()`](@ref).

This function is executed automatically by [`MPI.Init()`](@ref) but *must* be invoked
manually if MPI has been initialized externally by a direct call to `MPI_Init()`. It is safe
to call this function multiple times (subsequent runs will be a no-op).
"""
function run_init_hooks()
    while !isempty(mpi_init_hooks)
        f = popfirst!(mpi_init_hooks) # FIFO
        f()
    end
    return nothing
end

const mpi_finalize_hooks = Any[]

"""
    MPI.add_finalize_hook!(f)

Register a function `f` that will be called as `f()` when `MPI.Finalizer` is
called. These are invoked in a last-in, first-out (LIFO) order.
"""
add_finalize_hook!(f) = push!(mpi_finalize_hooks, f)
function run_finalize_hooks()
    while !isempty(mpi_finalize_hooks)
        f = pop!(mpi_finalize_hooks) # LIFO
        f()
    end
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
            # MPI_Finalize is a collective and can act like a barrier (this may
            # be implementation specific). If we are terminating due to a Julia
            # exception, we shouldn't call MPI_Finalize.
            @static if VERSION >= v"1.9-"
                # In Julia 1.9 we can access the exitcode from the atexit hook
                atexit() do exitcode
                    if exitcode == 0 && !Finalized()
                        Finalize()
                    end
                end
            else
                # In Julia 1.8 and earlier we can peek at the current exception,
                # and only if that field is nothing do we terminate.
                # This does not work in Julia 1.9 or later.
                atexit() do
                    if !Finalized() && ccall(:jl_current_exception, Any, ()) === nothing
                        Finalize()
                    end
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
const THREAD_SINGLE     = ThreadLevel(API.MPI_THREAD_SINGLE[])
const THREAD_FUNNELED   = ThreadLevel(API.MPI_THREAD_FUNNELED[])
const THREAD_SERIALIZED = ThreadLevel(API.MPI_THREAD_SERIALIZED[])
const THREAD_MULTIPLE   = ThreadLevel(API.MPI_THREAD_MULTIPLE[])
add_load_time_hook!(LoadTimeHookSetVal(THREAD_SINGLE,     API.MPI_THREAD_SINGLE    ))
add_load_time_hook!(LoadTimeHookSetVal(THREAD_FUNNELED,   API.MPI_THREAD_FUNNELED  ))
add_load_time_hook!(LoadTimeHookSetVal(THREAD_SERIALIZED, API.MPI_THREAD_SERIALIZED))
add_load_time_hook!(LoadTimeHookSetVal(THREAD_MULTIPLE,   API.MPI_THREAD_MULTIPLE  ))
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
    API.MPI_Init_thread(C_NULL, C_NULL, required.val, r_provided)
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
    API.MPI_Query_thread(r_provided)
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
    API.MPI_Is_thread_main(r_flag)
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
        run_finalize_hooks()
        API.MPI_Finalize()
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
Abort(comm::Comm, errcode::Integer) = API.MPI_Abort(comm, errcode)

"""
    Initialized()

Returns `true` if [`MPI.Init`](@ref) has been called, `false` otherwise.

It is unaffected by [`MPI.Finalize`](@ref), and is one of the few functions that may be
called before [`MPI.Init`](@ref).

# External links
$(_doc_external("MPI_Initialized"))
"""
function Initialized()
    flag = Ref{Cint}()
    API.MPI_Initialized(flag)
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
    API.MPI_Finalized(flag)
    flag[] != 0
end

Wtick() = API.MPI_Wtick()

Wtime() = API.MPI_Wtime()

"""
    MPI.has_cuda()

Check if the MPI implementation is known to have CUDA support. Currently only Open MPI
provides a mechanism to check, so it will return `false` with other implementations
(unless overridden). For "IBMSpectrumMPI" it will return `true`.

This can be overridden by setting the `JULIA_MPI_HAS_CUDA` environment variable to `true`
or `false`.

!!! note
    For OpenMPI or OpenMPI-based implementations you first need to call [Init()](@ref).

See also [`MPI.has_rocm`](@ref) for ROCm support.
"""
function has_cuda()
    flag = get(ENV, "JULIA_MPI_HAS_CUDA", nothing)
    if flag === nothing
        # Only Open MPI provides a function to check CUDA support
        @static if MPI_LIBRARY == "OpenMPI"
            # int MPIX_Query_cuda_support(void)
            return @ccall libmpi.MPIX_Query_cuda_support()::Bool
        elseif MPI_LIBRARY == "IBMSpectrumMPI"
            return true
        else
            return false
        end
    else
        return parse(Bool, flag)
    end
end

"""
    MPI.has_rocm()

Check if the MPI implementation is known to have ROCm support. Currently only Open MPI
provides a mechanism to check, so it will return `false` with other implementations
(unless overridden).

This can be overridden by setting the `JULIA_MPI_HAS_ROCM` environment variable to `true`
or `false`.

See also [`MPI.has_cuda`](@ref) for CUDA support.
"""
function has_rocm()
    flag = get(ENV, "JULIA_MPI_HAS_ROCM", nothing)
    if flag === nothing
        # Only Open MPI provides a function to check ROCm support
        @static if MPI_LIBRARY == "OpenMPI" && MPI_LIBRARY_VERSION ≥ v"5"
            # int MPIX_Query_rocm_support(void)
            return @ccall libmpi.MPIX_Query_rocm_support()::Bool
        else
            return false
        end
    else
        return parse(Bool, flag)
    end
end

"""
    MPI.has_gpu()

Checks if the MPI implementation is known to have GPU support. Currently this checks for the
following GPUs:

1. CUDA: via [`MPI.has_cuda`](@ref)
2. ROCm: via [`MPI.has_rocm`](@ref)

See also [`MPI.has_cuda`](@ref) and [`MPI.has_rocm`](@ref) for more fine-grained
checks.
"""
has_gpu() = has_cuda() || has_rocm()
