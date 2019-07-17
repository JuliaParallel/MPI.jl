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

primitive type SentinelPtr
    Sys.WORD_SIZE
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

    if filesize(dlpath(libmpi)) != libmpi_size
        error("MPI library has changed, re-run Pkg.build(\"MPI\")")
    end

    @require CuArrays="3a865a2d-5b23-5a0f-bc46-62713ec82fae" include("cuda.jl")
end

end
