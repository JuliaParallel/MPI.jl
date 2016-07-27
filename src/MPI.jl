module MPI

using Compat
import Compat.String

const libmpi = Libdl.find_library(["libmpi", "msmpi"])
# libmpi is loaded with RTLD_GLOBAL to make sure that all dependent modules are loaded correctly
Libdl.dlopen(libmpi, Libdl.RTLD_GLOBAL)

# Query the linked MPI implementation
# 8192 is the maximum length of the version string (MPI_MAX_LIBRARY_VERSION_STRING) across the
# implementations I'm aware of. The MPI_Get_library_version function doesn't allow us two query the length.
sbuf = Array(UInt8, 8192)
n = Ref{Cint}()
mjr, mnr = Ref{Cint}(), Ref{Cint}()

ccall((:MPI_Get_library_version, libmpi), Cint, (Ptr{UInt8}, Ref{Cint}), sbuf, n)
ccall((:MPI_Get_version, libmpi), Cint, (Ref{Cint}, Ref{Cint}), mjr, mnr)

const MPIString  = String(sbuf[1:n[] - 1])
const MPIVersion = VersionNumber(mjr[], mnr[])

# Load header file information for linked MPI implementation
if ismatch(r"Open MPI", MPIString)
    MPIName = :OpenMPI
    include("openmpi.jl")
elseif ismatch(r"MPICH", MPIString)
    MPIName = :MPICH
    include("mpich.jl")
elseif ismatch(r"Intel", MPIString)
    MPIName = :Intel
    include("intel.jl")
elseif ismatch(r"Microsoft", MPIString)
    MPIName = :Microsoft
    include("microsoft.jl")
else
    error("Your MPI implementation is not known to MPI.jl. Please add the necessary constant from
        from mpi.h of your MPI implementation ans submit pull request.")
end

include("mpi-base.jl")
include("cman.jl")

end