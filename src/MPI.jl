module MPI

using Libdl, Serialization
using Requires
using DocStringExtensions

export mpiexec

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
Base.cconvert(::Type{MPIPtr}, x::SentinelPtr) = x
Base.unsafe_convert(::Type{MPIPtr}, x::SentinelPtr) = reinterpret(MPIPtr, x)


function _doc_external(fname)
"""
- `$fname` man page: [OpenMPI](https://www.open-mpi.org/doc/current/man3/$fname.3.php), [MPICH](https://www.mpich.org/static/docs/latest/www3/$fname.html)
"""
end

include("paths.jl")
include("implementations.jl")

if MPI_LIBRARY_ABI == UnknownABI
    include(joinpath(@__DIR__, "..", "deps", "consts.jl"))
elseif MPI_LIBRARY_ABI == MPICHABI
    include(joinpath("consts", "mpich.jl"))
elseif MPI_LIBRARY_ABI == OpenMPIABI
    include(joinpath("consts", "openmpi.jl"))
elseif MPI_LIBRARY_ABI == MicrosoftMPIABI
    include(joinpath("consts", "microsoftmpi.jl"))
end

include("error.jl")
include("handle.jl")
include("info.jl")
include("comm.jl")
include("environment.jl")
include("datatypes.jl")
include("buffers.jl")
include("operators.jl")
include("pointtopoint.jl")
include("collective.jl")
include("topology.jl")
include("onesided.jl")
include("io.jl")

include("deprecated.jl")

function __init__()

    @static if Sys.isunix()
        # need to open libmpi with RTLD_GLOBAL flag for Linux, before
        # any ccall cannot use RTLD_DEEPBIND; this leads to segfaults
        # at least on Ubuntu 15.10
        Libdl.dlopen(libmpi, Libdl.RTLD_LAZY | Libdl.RTLD_GLOBAL)
    end

    @debug "MPI library info" BINARY find_binary()  MPI_LIBRARY_VERSION_STRING Get_library_version()
    
    if false # BINARY != find_binary() || MPI_LIBRARY_VERSION_STRING != Get_library_version()
        # MPI library has changed, invalidate cache
        rm(Base.compilecache_path(Base.PkgId(MPI)), force = true)
        # TODO: figure out if we can reload package without erroring
        # though that would probably trigger a race condition
        error("MPI library has changed, please restart Julia")
    end

    # check if using JLL binaries on HPC
    if BINARY isa JLLBinary && !haskey(ENV, "JULIA_MPI_BINARY")
        if haskey(ENV, "SLURM_JOBID") || haskey(ENV, "PBS_JOBID") || haskey(ENV, "LSB_JOBID")
            @warn "You appear to be using MPI.jl on a cluster with the default MPI binary.\nFor maximum performance you should use the cluster provided version.\nThis warning message can be disabled by setting the `JULIA_MPI_BINARY=$MPI_BINARY`."
        end
    end

    # Required for OpenMPI relocateable binaries
    # TODO: this should be done in OpenMPI_jll package
    # https://github.com/JuliaPackaging/Yggdrasil/issues/390
    if BINARY isa JLLBinary && BINARY.jllname == "OpenMPI_jll"
        ENV["OPAL_PREFIX"] = OpenMPI_jll.artifact_dir
    end

    # disable UCX memory cache, since it doesn't work correctly
    # https://github.com/openucx/ucx/issues/5061
    if !haskey(ENV, "UCX_MEMTYPE_CACHE")
        ENV["UCX_MEMTYPE_CACHE"] = "no"
    end
    
    # Julia multithreading uses SIGSEGV to sync thread
    # https://docs.julialang.org/en/v1/devdocs/debuggingtips/#Dealing-with-signals-1
    # By default, UCX will error if this occurs (issue #337)
    if !haskey(ENV, "UCX_ERROR_SIGNALS")
        # default is "SIGILL,SIGSEGV,SIGBUS,SIGFPE"
        ENV["UCX_ERROR_SIGNALS"] = "SIGILL,SIGBUS,SIGFPE"
    end

    @require CuArrays="3a865a2d-5b23-5a0f-bc46-62713ec82fae" include("cuda.jl")
end

end
