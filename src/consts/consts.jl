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
elseif MPIPreferences.abi == "HPE MPT"
    include("mpt.jl")
else
    error("Unknown MPI ABI $(MPIPreferences.abi)")
end

# Initialize the ref constants from the library.
# This is not `Consts.__init__`, as it should be called _after_
# `dlopen` to ensure the library is opened correctly.
@eval function init_consts()
    $(Expr(:block, initexprs...))
end

# since this is called by invokelatest, it isn't automatically precompiled
precompile(init_consts, ())

end
