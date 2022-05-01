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

const libmpi_handle = Ref(C_NULL)

@eval function __init__()
    @static if parse(Bool, get(ENV, "CI", "false")) && MPIPreferences.binary == "system"
        # If we're running in CI and we're using system MPI, make sure that at this point
        # the library isn't loaded yet, to prevent the next `dlopen` on Unix systems from
        # being no-op.
        @assert all(!contains(libmpi), Libdl.dllist())
    end

    global libmpi_handle[] = @static if Sys.isunix()
        # dlopen the MPI library before any ccall:
        # - RTLD_GLOBAL is required for Open MPI
        #   <https://www.open-mpi.org/community/lists/users/2010/04/12803.php>
        # - also allows us to ccall global symbols, which enables
        #   profilers which use LD_PRELOAD
        # - don't use RTLD_DEEPBIND; this leads to segfaults at least
        #   on Ubuntu 15.10
        #   <https://github.com/JuliaParallel/MPI.jl/pull/109>
        Libdl.dlopen(libmpi, Libdl.RTLD_LAZY | Libdl.RTLD_GLOBAL)
    else
        # `dlopen` libmpi to get its handle, it'll be needed to determine some runtime
        # constants.
        Libdl.dlopen(libmpi)
    end

    $(Expr(:block, initexprs...))
end

end
