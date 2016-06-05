__precompile__()

module MPI

using Compat

@static if is_windows()
    const depfile = "win_mpiconstants.jl"
end

@static if is_unix()
    const depfile = joinpath(dirname(@__FILE__), "..", "deps", "src", "compile-time.jl")
    isfile(depfile) || error("MPI not properly installed. Please run Pkg.build(\"MPI\")")
end

include(depfile)

include("mpi-base.jl")
include("cman.jl")

const mpitype_dict = Dict{DataType, Cint}()
const mpitype_dict_inverse = Dict{Cint, DataType}()

function __init__()
    @static if is_unix()
        # need to open libmpi with RTLD_GLOBAL flag for Linux, before
        # any ccall cannot use RTLD_DEEPBIND; this leads to segfaults
        # at least on Ubuntu 15.10
        @eval const libmpi_handle =
            Libdl.dlopen(libmpi, Libdl.RTLD_LAZY | Libdl.RTLD_GLOBAL)

        # look up all symbols ahead of time
        for (jname, fname) in _mpi_functions
            eval(:(const $jname = Libdl.dlsym(libmpi_handle, $fname)))
        end
    end

    for (T,mpiT) in (Char => MPI_INTEGER4,
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
        mpitype_dict[T] = mpiT
        mpitype_dict_inverse[mpiT] = T
    end
end

end
