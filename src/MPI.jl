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

try
    include(joinpath(dirname(@__DIR__), "deps", "deps.jl"))
    include(joinpath(dirname(@__DIR__), "deps", "compile_time_mpi_constants.jl"))
catch e
    error("MPI.jl not properly configured, please run `Pkg.build(\"MPI\")`.")
end
include("define_load_time_mpi_constants.jl")
include("read_load_time_mpi_constants.jl")
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
        #   <https://www.open-mpi.org/community/lists/users/2010/04/12803.php>
        # - also allows us to ccall global symbols, which enables
        #   profilers which use LD_PRELOAD
        # - don't use RTLD_DEEPBIND; this leads to segfaults at least
        #   on Ubuntu 15.10
        #   <https://github.com/JuliaParallel/MPI.jl/pull/109>
        Libdl.dlopen(libmpi, Libdl.RTLD_LAZY | Libdl.RTLD_GLOBAL)
    end

    __init__deps()

    read_load_time_mpi_constants()

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

    @require CUDA="052768ef-5323-5732-b1bb-66c8b64840ba" include("cuda.jl")
end

end
