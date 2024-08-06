module MPI

using Libdl, Serialization
using DocStringExtensions
import MPIPreferences

export mpiexec, UBuffer, VBuffer

function serialize(x)
    s = IOBuffer()
    Serialization.serialize(s, x)
    take!(s)
end

function deserialize(x)
    s = IOBuffer(x)
    Serialization.deserialize(s)
end


function _doc_external(fname)
    # Ideally we'd like to use the "latest" version of the docs, but MPICH v4.0
    # at the moment seems to be the last version with all the docstrings.
    mpich = "[MPICH](https://www.mpich.org/static/docs/v4.0/www3/$(fname).html)"
    # All the *_c functions are undocumented in OpenMPI website
    if !endswith(string(fname), "_c")
        openmpi = "[OpenMPI](https://docs.open-mpi.org/en/main/man-openmpi/man3/$(fname).3.html)"
        # Few docstrings aren't available for MPICH
        if fname in (:MPI_Status_c2f, :MPI_Status_f2c) || startswith(string(fname), "MPI_Type_create_f90_")
            return """
            - `$fname` man page: $(openmpi)
            """
        else
            return """
            - `$fname` man page: $(openmpi), $(mpich)
            """
        end
    else
        return """
        - `$fname` man page: $(mpich)
        """
    end
end

"""
    MPIError

Error thrown when an MPI function returns an error code. The `code` field contains the MPI error code.
"""
struct MPIError <: Exception
    code::Cint
end
function Base.show(io::IO, err::MPIError)
    print(io, "MPIError(", err.code, "): ", error_string(err))
end




include("api/api.jl")
using .API
const Consts = API

# These functions are run after reading the values of the constants above)
const _mpi_load_time_hooks = Any[]
const _finished_loading = Ref(false)
function add_load_time_hook!(f)
    @assert !_finished_loading[]
    push!(_mpi_load_time_hooks, f)
end
function run_load_time_hooks()
    @assert !_finished_loading[]
    _finished_loading[] = true
    foreach(call, _mpi_load_time_hooks)
    empty!(_mpi_load_time_hooks)
    nothing
end
# Set dst.val = src[] when called
struct LoadTimeHookSetVal{Dst, Src}
    dst::Dst
    src::Src
end
function (hook::LoadTimeHookSetVal)()
    hook.dst.val = hook.src[]
    return nothing
end
call(hook) = hook()

include("implementations.jl")
include("error.jl")
include("info.jl")
include("group.jl")
include("comm.jl")
include("environment.jl")
include("datatypes.jl")
include("buffers.jl")
include("operators.jl")
include("nonblocking.jl")
include("pointtopoint.jl")
include("collective.jl")
include("topology.jl")
include("onesided.jl")
include("io.jl")
include("errhandler.jl")
include("mpiexec_wrapper.jl")
include("misc.jl")

include("deprecated.jl")

if !isdefined(Base, :get_extension)
    using Requires: @require
end

function __init__()
    MPIPreferences.check_unchanged()

    # an empty string was used to indicate "default"
    # https://github.com/JuliaParallel/MPI.jl/blob/v0.19.2/deps/build.jl#L142
    mpi_env_binary = get(ENV, "JULIA_MPI_BINARY", "")
    if mpi_env_binary != "" && mpi_env_binary != MPIPreferences.binary
        @warn """
        The JULIA_MPI_BINARY environment variable is no longer used to configure the MPI binary.
        Please use the MPIPreferences.jl package instead:

            MPIPreferences.use_system_binary()  # use the system binary
            MPIPreferences.use_jll_binary()     # use JLL binary

        See https://juliaparallel.org/MPI.jl/stable/configuration/ for more details

        """ ENV["JULIA_MPI_BINARY"]=mpi_env_binary MPIPreferences.binary
    end

    # Set environment variables before dlopen.

    # disable UCX memory cache, since it doesn't work correctly
    # https://github.com/openucx/ucx/issues/5061
    if !haskey(ENV, "UCX_MEMTYPE_CACHE")
        ENV["UCX_MEMTYPE_CACHE"] = "no"
    end

    # Julia multithreading uses SIGSEGV to sync threads
    # https://docs.julialang.org/en/v1/devdocs/debuggingtips/#Dealing-with-signals-1
    # By default, UCX will error if this occurs (issue #337)
    if !haskey(ENV, "UCX_ERROR_SIGNALS")
        # default is "SIGILL,SIGSEGV,SIGBUS,SIGFPE"
        ENV["UCX_ERROR_SIGNALS"] = "SIGILL,SIGBUS,SIGFPE"
    end

    # preload any dependencies of libmpi (if needed, eg. GTL on cray) before
    # dlopen'ing the MPI library: https://github.com/JuliaParallel/MPI.jl/pull/716
    MPIPreferences.dlopen_preloads()

    @static if Sys.isunix()
        # dlopen the MPI library before any ccall:
        # - RTLD_GLOBAL is required for Open MPI
        #   https://www.open-mpi.org/community/lists/users/2010/04/12803.php
        # - also allows us to ccall global symbols, which enables profilers
        #   which use LD_PRELOAD
        # - don't use RTLD_DEEPBIND; this leads to issues with multiple MPI
        #   libraries:
        #   https://github.com/JuliaParallel/MPI.jl/pull/109
        #   https://github.com/JuliaParallel/MPI.jl/issues/587
        Libdl.dlopen(libmpi, Libdl.RTLD_LAZY | Libdl.RTLD_GLOBAL)
    end

    # Needs to be called after `dlopen`. Use `invokelatest` so that `cglobal`
    # calls don't trigger early `dlopen`-ing of the library.
    Base.invokelatest(API.init_consts)

    if MPIPreferences.binary == "MPItrampoline_jll" && !haskey(ENV, "MPITRAMPOLINE_MPIEXEC")
        ENV["MPITRAMPOLINE_MPIEXEC"] = API.MPItrampoline_jll.mpich_mpiexec_path
    end

    run_load_time_hooks()

    @static if !isdefined(Base, :get_extension)
        @require AMDGPU="21141c5a-9bdb-4563-92ae-f87d6854732e" include("../ext/AMDGPUExt.jl")
        @require CUDA="052768ef-5323-5732-b1bb-66c8b64840ba" include("../ext/CUDAExt.jl")
    end
end


using PrecompileTools: @compile_workload
@static if VERSION >= v"1.8"
    @compile_workload begin
        # Running the load time hooks here shaves off a significant amount of loading time,
        # see also https://github.com/JuliaParallel/MPI.jl/pull/728
        foreach(call, _mpi_load_time_hooks)
    end
    # We insert some explicit precompile statements here. The corresponding methods
    # are likely to be called from anyone using MPI in Julia. Thus, it is reasonable
    # to compile them ahead of time instead of compiling them in parallel for each
    # run.
    Base.precompile(Init, ())
    Base.precompile(Comm_rank, (Comm,))
    Base.precompile(Comm_size, (Comm,))
end

end
