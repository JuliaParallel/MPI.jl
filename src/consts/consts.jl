module Consts

export MPI_Aint, MPI_Count, MPI_Offset, MPI_Status,
    MPI_Comm, MPI_Datatype, MPI_Errhandler, MPI_File, MPI_Group,
    MPI_Info, MPI_Message, MPI_Op, MPI_Request, MPI_Win

import MPIPreferences
import ..libmpi, ..libmpiconstants

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

@eval function __init__()
    $(Expr(:block, initexprs...))
end

end
