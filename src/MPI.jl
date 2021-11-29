module MPI

using Libdl, Serialization
using Requires, Preferences
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
Base.cconvert(::Type{MPIPtr}, x::SentinelPtr) = x
Base.unsafe_convert(::Type{MPIPtr}, x::SentinelPtr) = reinterpret(MPIPtr, x)


function _doc_external(fname)
"""
- `$fname` man page: [OpenMPI](https://www.open-mpi.org/doc/current/man3/$fname.3.php), [MPICH](https://www.mpich.org/static/docs/latest/www3/$fname.html)
"""
end

# preferences
# binary = "system" | "OpenMPI_jll" | "MPICH_jll" | "MicrosoftMPI_jll"
# if binary == "system" then the following also need to be set:
#   libmpi = library name (optional path)
#   abi = "openmpi" | "mpich" | "microsoftmpi" | "unknown"
#   mpiexec = MPI launcher command


const binary = @load_preference("binary", Sys.iswindows() ? "MicrosoftMPI_jll" : "MPICH_jll")

@static if binary == "MPICH_jll"
    using MPICH_jll
    const abi = "MPICH"
    const _mpiexec = MPICH_jll.mpiexec
    const mpiexec_path = MPICH_jll.mpiexec_path
    __init__deps() = nothing
elseif binary == "OpenMPI_jll"
    using OpenMPI_jll
    const abi = "OpenMPI"
    const _mpiexec = OpenMPI_jll.mpiexec
    const mpiexec_path = OpenMPI_jll.mpiexec_path
    __init__deps() = nothing
elseif binary == "MicrosoftMPI_jll"
    using MicrosoftMPI_jll
    const abi = "MicrosoftMPI"
    const _mpiexec = MicrosoftMPI_jll.mpiexec
    const mpiexec_path = MicrosoftMPI_jll.mpiexec_path
    __init__deps() = nothing
elseif binary == "system"
    const libmpi = @load_preference("libmpi")
    const abi = @load_preference("abi")
    const mpiexec_path = @load_preference("mpiexec")
    const mpiexec_cmd = `$mpiexec_path`
    _mpiexec(fn) = begin
        fn(mpiexec_cmd)
    end

    function __init__deps()
        libabi = identify_abi()
        if libabi != abi
            @set_preferences!("abi" => libabi)
            error("MPI library ABI has changed; restart Julia for the change to take effect")
        end
    end        
else
    error("Invalid binary preference $binary")
end

if abi == "MPICH"
    include("consts/mpich.jl")
elseif abi == "OpenMPI"
    include("consts/openmpi.jl")
elseif abi == "MicrosoftMPI"
    include("consts/microsoftmpi.jl")
else
    include(joinpath(dirname(@__DIR__), "deps", "consts.jl"))
end



include("implementations.jl")
include("preferences.jl")
include("identify.jl")
include("error.jl")
include("handle.jl")
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
include("errorhandler.jl")
include("mpiexec_wrapper.jl")

include("deprecated.jl")

function __init__()

    @static if Sys.isunix()
        # need to open libmpi with RTLD_GLOBAL flag for Linux, before
        # any ccall cannot use RTLD_DEEPBIND; this leads to segfaults
        # at least on Ubuntu 15.10
        Libdl.dlopen(libmpi, Libdl.RTLD_LAZY | Libdl.RTLD_GLOBAL)
    end

    __init__deps()

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

    @require CUDA="052768ef-5323-5732-b1bb-66c8b64840ba" include("cuda.jl")
end

end
