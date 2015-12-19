__precompile__()

module MPI

using Compat

const depfile = joinpath(dirname(@__FILE__), "..", "deps", "src", "compile-time.jl")
isfile(depfile) || error("MPI not properly installed. Please run Pkg.build(\"MPI\")")
include(depfile)
include("mpi-base.jl")
include("cman.jl")

function __init__()
    # need to open libmpi with RTLD_GLOBAL flag for Linux, before any ccall
    # cannot use RTLD_DEEPBIND; this leads to segfaults at least on Ubuntu 15.10
    Libdl.dlopen(libmpi, Libdl.RTLD_LAZY|Libdl.RTLD_GLOBAL)
end

end
