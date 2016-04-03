__precompile__()

module MPI

using Compat

@windows_only begin
	const depfile = "win_mpiconstants.jl"
end

@unix_only begin
	const depfile = joinpath(dirname(@__FILE__), "..", "deps", "src", "compile-time.jl")
	isfile(depfile) || error("MPI not properly installed. Please run Pkg.build(\"MPI\")")
end

include(depfile)

include("mpi-base.jl")
include("cman.jl")

function __init__()
    @unix_only begin
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
