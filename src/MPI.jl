VERSION < v"0.7.0-beta2.199" && __precompile__()

module MPI

using Compat

using Libdl

@static if Compat.Sys.iswindows()
    const depfile = "win_mpiconstants.jl"
end

@static if Compat.Sys.isunix()
    const depfile = joinpath(dirname(@__FILE__), "..", "deps", "src", "compile-time.jl")
    isfile(depfile) || error("MPI not properly installed. Please run Pkg.build(\"MPI\")")
end

include(depfile)

include("mpi-base.jl")
include("cman.jl")
include("window-io.jl")
include("window-cman.jl")

const mpitype_dict = Dict{DataType, Cint}()
const mpitype_dict_inverse = Dict{Cint, DataType}()

function __init__()
    @static if Compat.Sys.isunix()
        # need to open libmpi with RTLD_GLOBAL flag for Linux, before
        # any ccall cannot use RTLD_DEEPBIND; this leads to segfaults
        # at least on Ubuntu 15.10
        @eval const libmpi_handle =
            Libdl.dlopen(libmpi, Libdl.RTLD_LAZY | Libdl.RTLD_GLOBAL)

        # look up all symbols ahead of time
        for (jname, fname) in _mpi_functions
            Core.eval(MPI, :(const $jname = Libdl.dlsym(libmpi_handle, $fname)))
        end
    end

    # Note: older versions of OpenMPI (e.g. the version on Travis) do not
    # define MPI_CHAR and MPI_*INT*_T for Fortran, so we don't use them (yet).
    for (T,mpiT) in (Char => MPI_INTEGER4,   # => MPI_WCHAR, (note: wchar_t is 16 bits in Windows)
                     Int8 => MPI_INTEGER1,   # => MPI_INT8_T,
                     UInt8 => MPI_INTEGER1,  # => MPI_UINT8_T,
                     Int16 => MPI_INTEGER2,  # => MPI_INT16_T,
                     UInt16 => MPI_INTEGER2, # => MPI_UINT16_T,
                     Int32 => MPI_INTEGER4,  # => MPI_INT32_T,
                     UInt32 => MPI_INTEGER4, # => MPI_UINT32_T,
                     Int64 => MPI_INTEGER8,  # => MPI_INT64_T,
                     UInt64 => MPI_INTEGER8, # => MPI_UINT64_T,
                     Float32 => MPI_REAL4,
                     Float64 => MPI_REAL8,
                     ComplexF32 => MPI_COMPLEX8,
                     ComplexF64 => MPI_COMPLEX16)
        mpitype_dict[T] = mpiT
        mpitype_dict_inverse[mpiT] = T
    end
end

end
