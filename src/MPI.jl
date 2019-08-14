module MPI

using Libdl, Serialization
using Requires

macro mpichk(expr)
    @assert expr isa Expr && expr.head == :call && expr.args[1] == :ccall
    if Sys.iswindows()
        insert!(expr.args, 3, :stdcall)
    end
    esc(expr)
end

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

include(joinpath(@__DIR__, "..", "deps", "deps.jl"))
include("handle.jl")
include("info.jl")
include("comm.jl")
include("environment.jl")
include("datatypes.jl")
include("operators.jl")
include("pointtopoint.jl")
include("collective.jl")
include("topology.jl")
include("window.jl")

include("cman.jl")
include("deprecated.jl")

function __init__()
    @static if Sys.isunix()
        # need to open libmpi with RTLD_GLOBAL flag for Linux, before
        # any ccall cannot use RTLD_DEEPBIND; this leads to segfaults
        # at least on Ubuntu 15.10
        Libdl.dlopen(libmpi, Libdl.RTLD_LAZY | Libdl.RTLD_GLOBAL)
    end

    # disable UCX memory hooks since it can mess up dlopen
    # https://github.com/openucx/ucx/issues/4001
    ENV["UCX_MEM_MMAP_RELOC"] = "no"
    ENV["UCX_MEM_MALLOC_HOOKS"] = "no"
    ENV["UCX_MEM_MALLOC_RELOC"] = "no"
    ENV["UCX_MEM_EVENTS"] = "no"

    if filesize(dlpath(libmpi)) != libmpi_size
        error("MPI library has changed, re-run Pkg.build(\"MPI\")")
    end

    @require CuArrays="3a865a2d-5b23-5a0f-bc46-62713ec82fae" include("cuda.jl")
end

end
