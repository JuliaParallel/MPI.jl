module DlopenHack

using Libdl: Libdl
using MPIPreferences: MPIPreferences
import ..libmpi

function __init__()
    @static if MPIPreferences.binary == "system" &&
        (x = tryparse(Bool, get(ENV, "GITHUB_ACTIONS", "false")); something(x, false))
        # If we're running in CI, make sure that at this point the library isn't loaded yet.
        @assert all(!contains(libmpi), Libdl.dllist())
    end

    # dlopen the MPI library before any ccall:
    # - RTLD_GLOBAL is required for Open MPI
    #   <https://www.open-mpi.org/community/lists/users/2010/04/12803.php>
    # - also allows us to ccall global symbols, which enables
    #   profilers which use LD_PRELOAD
    # - don't use RTLD_DEEPBIND; this leads to segfaults at least
    #   on Ubuntu 15.10
    #   <https://github.com/JuliaParallel/MPI.jl/pull/109>
    #   and when using HPE's MPT MPI implementation
    #   <https://github.com/JuliaParallel/MPI.jl/pull/580>
    Libdl.dlopen(libmpi, Libdl.RTLD_LAZY | Libdl.RTLD_GLOBAL)
end

end # module
