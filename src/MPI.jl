__precompile__()

module MPI

using Compat

if @windows? true : false
	include("win_mpiconstants.jl")
else
	const depfile = joinpath(dirname(@__FILE__), "..", "deps", "src", "compile-time.jl")
	isfile(depfile) || error("MPI not properly installed. Please run Pkg.build(\"MPI\")")
	include(depfile)
end

include("mpi-base.jl")
include("cman.jl")

function __init__()
    if @windows? true : false
    else
        # need to open libmpi with RTLD_GLOBAL flag for Linux, before any ccall
        # cannot use RTLD_DEEPBIND; this leads to segfaults at least on Ubuntu 15.10
        @eval const libmpi_handle =
            Libdl.dlopen(libmpi, Libdl.RTLD_LAZY | Libdl.RTLD_GLOBAL)

        # look up all symbols ahead of time
        for (jname, fname) in _mpi_functions
            eval(:(const $jname = Libdl.dlsym(libmpi_handle, $fname)))
        end
    end
end

end
