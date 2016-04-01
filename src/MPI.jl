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

    global const mpitype_dict = Dict{DataType, Cint}(
        # Older versions of OpenMPI (such as those used by default in
        # Travis) do not define MPI_WCHAR and the MPI_*INT*_T types for
        # Fortran. We thus don't require them (yet).
        # Char => MPI_WCHAR,
        # Int8 => MPI_INT8_T,
        # UInt8 => MPI_UINT8_T,
        # Int16 => MPI_INT16_T,
        # UInt16 => MPI_UINT16_T,
        # Int32 => MPI_INT32_T,
        # UInt32 => MPI_UINT32_T,
        # Int64 => MPI_INT64_T,
        # UInt64 => MPI_UINT64_T,
        Char => MPI_INTEGER4,
        Int8 => MPI_INTEGER1,
        UInt8 => MPI_INTEGER1,
        Int16 => MPI_INTEGER2,
        UInt16 => MPI_INTEGER2,
        Int32 => MPI_INTEGER4,
        UInt32 => MPI_INTEGER4,
        Int64 => MPI_INTEGER8,
        UInt64 => MPI_INTEGER8,
        Float32 => MPI_REAL4,
        Float64 => MPI_REAL8,
        Complex64 => MPI_COMPLEX8,
        Complex128 => MPI_COMPLEX16)

end

end
