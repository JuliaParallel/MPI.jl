module MPI

using Libdl, Serialization
using Requires
using DocStringExtensions

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

primitive type SentinelPtr Sys.WORD_SIZE
end

primitive type MPIPtr Sys.WORD_SIZE
end
@assert sizeof(MPIPtr) == sizeof(Ptr{Cvoid})
Base.cconvert(::Type{MPIPtr}, x::SentinelPtr) = x
Base.unsafe_convert(::Type{MPIPtr}, x::SentinelPtr) = reinterpret(MPIPtr, x)


function _doc_external(fname)
"""
- `$fname` man page: [OpenMPI](https://www.open-mpi.org/doc/current/man3/$fname.3.php), [MPICH](https://www.mpich.org/static/docs/latest/www3/$fname.html)
"""
end


import MPIPreferences

if MPIPreferences.binary == "MPICH_jll"
    import MPICH_jll: libmpi, libmpi_handle, mpiexec
    const libmpiconstants = nothing
elseif MPIPreferences.binary == "OpenMPI_jll"
    import OpenMPI_jll: libmpi, libmpi_handle, mpiexec
    const libmpiconstants = nothing
elseif MPIPreferences.binary == "MicrosoftMPI_jll"
    import MicrosoftMPI_jll: libmpi, libmpi_handle, mpiexec
    const libmpiconstants = nothing
elseif MPIPreferences.binary == "MPItrampoline_jll"
    import MPItrampoline_jll: MPItrampoline_jll, libmpi, libmpi_handle, mpiexec
    const libmpiconstants = MPItrampoline_jll.libload_time_mpi_constants_path
elseif MPIPreferences.binary == "system"
    import MPIPreferences.System: libmpi, libmpi_handle, mpiexec
    const libmpiconstants = nothing
else
    error("Unknown MPI binary: $(MPIPreferences.binary)")
end

include("consts/consts.jl")
using .Consts

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
    for hook in _mpi_load_time_hooks
        hook()
    end
    empty!(_mpi_load_time_hooks)
    nothing
end


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

include("deprecated.jl")

function __init__()
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
    Base.invokelatest(Consts.init_consts)

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

    if MPIPreferences.binary == "MPItrampoline_jll" && !haskey(ENV, "MPITRAMPOLINE_MPIEXEC")
        ENV["MPITRAMPOLINE_MPIEXEC"] = MPItrampoline_jll.mpich_mpiexec_path
    end

    run_load_time_hooks()

    @require AMDGPU="21141c5a-9bdb-4563-92ae-f87d6854732e" include("rocm.jl")
    @require CUDA="052768ef-5323-5732-b1bb-66c8b64840ba" include("cuda.jl")
end

end
