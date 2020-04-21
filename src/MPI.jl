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

    if MPI_LIBRARY_VERSION_STRING != Get_library_version()
        # MPI library has changed, invalidate cache
        cachefile = Base.compilecache(Base.PkgId(MPI))
        rm(cachefile)
        # TODO: figure out if we can reload package without erroring
        # though that would probably trigger a race condition
        error("MPI library has changed, please restart Julia")
    end
    
    # disable UCX memory hooks since it can mess up dlopen
    # https://github.com/openucx/ucx/issues/4001
#    ENV["UCX_MEM_MMAP_RELOC"] = "no"
#    ENV["UCX_MEM_MALLOC_HOOKS"] = "no"
#    ENV["UCX_MEM_MALLOC_RELOC"] = "no"
#    ENV["UCX_MEM_EVENTS"] = "no"

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
