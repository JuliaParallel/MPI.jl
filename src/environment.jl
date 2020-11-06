"""
    mpiexec(fn)

A wrapper function for the MPI launcher executable. Calls `fn(cmd)`, where `cmd` is a `Cmd` object of the MPI launcher.

# Environment Variables

The behaviour of `mpiexec` can be controlled by the following environment variables:

- `JULIA_MPIEXEC`: the name or path of the launcher executable (set at compile time).
- `JULIA_MPIEXEC_ARGS`: additional arguments that are passed to the launcher. These are
  space seperated, supporting the same quoting rules as Julia `Cmd` objects. These can be
  modified at run time.

# Usage

```jldoctest
julia> mpiexec(cmd -> run(`\$cmd -n 3 echo hello world`));
hello world
hello world
hello world
```
"""
function mpiexec(fn)
    _mpiexec(cmd -> fn(`$cmd $(Base.shell_split(get(ENV, "JULIA_MPIEXEC_ARGS", "")))`))
end


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


function run_init_hooks()
    for f in mpi_init_hooks
        f()
    end
    return nothing
end


"""
    Init()

Initialize MPI in the current process.

All MPI programs must contain exactly one call to `MPI.Init` or
[`MPI.Init_thread`](@ref). In particular, note that it is not valid to call `MPI.Init` or
`MPI.Init_thread` again after calling [`MPI.Finalize`](@ref).

The only MPI functions that may be called before `MPI.Init`/`MPI.Init_thread` are
[`MPI.Initialized`](@ref) and [`MPI.Finalized`](@ref).

# External links
$(_doc_external("MPI_Init"))
"""
function Init()
    @mpichk ccall((:MPI_Init, libmpi), Cint, (Ptr{Cint},Ptr{Cint}), C_NULL, C_NULL)
    atexit(() -> Finalized() || Finalize())

    run_init_hooks()
    _warn_if_wrong_mpi()
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

- [`Init_thread`](@ref)
- [`Query_thread`](@ref)
"""
@enum ThreadLevel begin
    THREAD_SINGLE     = MPI_THREAD_SINGLE
    THREAD_FUNNELED   = MPI_THREAD_FUNNELED
    THREAD_SERIALIZED = MPI_THREAD_SERIALIZED
    THREAD_MULTIPLE   = MPI_THREAD_MULTIPLE
end


"""
    Init_thread(required::ThreadLevel)

Initialize MPI and the MPI thread environment in the current process. The argument
specifies the required level of threading support, see [`ThreadLevel`](@ref).

The function will return the provided `ThreadLevel`, and values may be compared via
inequalities, i.e.

```julia
provided = Init_thread(required)
@assert provided >= required
```

All MPI programs must contain exactly one call to [`MPI.Init`](@ref) or
`MPI.Init_thread`. In particular, note that it is not valid to call `MPI.Init` or
`MPI.Init_thread` again after calling [`MPI.Finalize`](@ref).

The only MPI functions that may be called before `MPI.Init`/`MPI.Init_thread` are
[`MPI.Initialized`](@ref) and [`MPI.Finalized`](@ref).

# External links
$(_doc_external("MPI_Init_thread"))
"""
function Init_thread(required::ThreadLevel)
    r_provided = Ref{ThreadLevel}()
    # int MPI_Init_thread(int *argc, char ***argv, int required, int *provided)
    @mpichk ccall((:MPI_Init_thread, libmpi), Cint,
                  (Ptr{Cint},Ptr{Cvoid}, ThreadLevel, Ref{ThreadLevel}),
                  C_NULL, C_NULL, required, r_provided)
    provided = r_provided[]
    if provided < required
        @warn "Thread level requested = $required, provided = $provided"
    end

    atexit(() -> Finalized() || Finalize())
    run_init_hooks()
    _warn_if_wrong_mpi()
    return provided
end

"""
    Query_thread()

Query the level of threading support in the current process.
Returns a [`ThreadLevel`](@ref) value denoting

# External links
$(_doc_external("MPI_Query_thread"))
"""
function Query_thread()
    r_provided = Ref{ThreadLevel}()

    # int MPI_Query_thread(int *provided)
    @mpichk ccall((:MPI_Query_thread, libmpi), Cint,
                  (Ref{ThreadLevel},), r_provided)
    return r_provided[]
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
    @mpichk ccall((:MPI_Finalize, libmpi), Cint, ())
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
        @static if MPI_LIBRARY == OpenMPI
            # int MPIX_Query_cuda_support(void)
            return 0 != ccall((:MPIX_Query_cuda_support, libmpi), Cint, ())
        elseif MPI_LIBRARY == IBMSpectrumMPI
            return true
        else
            return false
        end
    else
        return parse(Bool, flag)
    end
end
