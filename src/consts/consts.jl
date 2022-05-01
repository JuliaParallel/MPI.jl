module Consts

export MPI_Aint, MPI_Count, MPI_Offset, MPI_Status,
    MPI_Comm, MPI_Datatype, MPI_Errhandler, MPI_File, MPI_Group,
    MPI_Info, MPI_Message, MPI_Op, MPI_Request, MPI_Win

import MPIPreferences
import ..libmpi, ..libmpiconstants
using Libdl: Libdl

const initexprs = Any[]

"""
    @const_ref name T expr

Defines an constant binding
```julia
const name = Ref{T}()
```
and adds a hook to execute
```julia
name[] = expr
```
at module initialization time.
"""
macro const_ref(name, T, expr)
    push!(initexprs, :($name[] = $expr))
    :(const $(esc(name)) = Ref{$T}())
end

@static if MPIPreferences.abi == "MPICH"
    include("mpich.jl")
elseif MPIPreferences.abi == "OpenMPI"
    include("openmpi.jl")
elseif MPIPreferences.abi == "MicrosoftMPI"
    include("microsoftmpi.jl")
elseif MPIPreferences.abi == "MPItrampoline"
    include("mpitrampoline.jl")
else
    error("Unknown MPI ABI $(MPIPreferences.abi)")
end

function __init__()
    @static if Sys.isunix()
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
        # This call needs to be here instead of `MPI.__init__` since the evaluation of
        # the `initexprs` below might otherwise load the MPI library in an uncontrolled
        # manner
        Libdl.dlopen(libmpi, Libdl.RTLD_LAZY | Libdl.RTLD_GLOBAL)
    end

    eval(Expr(:block, initexprs...))
end

end
