module MPI

using Compat

const libmpi = Libdl.find_library(["libmpi", "msmpi"])
# libmpi is loaded with RTLD_GLOBAL to make sure that all dependent modules are loaded correctly
Libdl.dlopen(libmpi, Libdl.RTLD_GLOBAL)

include("mpi-base.jl")
include("cman.jl")

end