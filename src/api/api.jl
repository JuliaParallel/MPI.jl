module API

export MPI_Aint, MPI_Count, MPI_Offset, MPI_Status,
    MPI_Comm, MPI_Datatype, MPI_Errhandler, MPI_File, MPI_Group,
    MPI_Info, MPI_Message, MPI_Op, MPI_Request, MPI_Win,
    libmpi, mpiexec, @mpichk, @mpicall, MPIPtr, SentinelPtr, FeatureLevelError,
    preloads, preloads_env_switch
    # libgtl

import MPIPreferences
using Libdl

if MPIPreferences.binary == "MPICH_jll"
    import MPICH_jll: libmpi, libmpi_handle, mpiexec
    const libmpiconstants = nothing
    const preloads = []
    const preloads_env_switch = nothing
elseif MPIPreferences.binary == "OpenMPI_jll"
    import OpenMPI_jll: libmpi, libmpi_handle, mpiexec
    const libmpiconstants = nothing
    const preloads = []
    const preloads_env_switch = nothing
elseif MPIPreferences.binary == "MicrosoftMPI_jll"
    import MicrosoftMPI_jll: libmpi, libmpi_handle, mpiexec
    const libmpiconstants = nothing
    const preloads = []
    const preloads_env_switch = nothing
elseif MPIPreferences.binary == "MPItrampoline_jll"
    import MPItrampoline_jll: MPItrampoline_jll, libmpi, libmpi_handle, mpiexec
    const libmpiconstants = MPItrampoline_jll.libload_time_mpi_constants_path
    # TODO: We'll probably need the preloads -- like cray's GTL -- with
    # libmpitrampoline, and until MPItrampoline_jll "understands" preloads, this
    # should be an acceptable workaround
    const preloads = MPIPreferences.Preferences.@load_preference("preloads")
    const preloads_env_switch = MPIPreferences.Preferences.@load_preference("preloads_env_switch")
elseif MPIPreferences.binary == "system"
    import MPIPreferences.System: libmpi, libmpi_handle, mpiexec,
        preloads, preloads_env_switch
    const libmpiconstants = nothing
else
    error("Unknown MPI binary: $(MPIPreferences.binary)")
end

import ..MPIError, .._doc_external
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
    push!(initexprs, :($name[] = $T <: Integer ? $expr % $T : $expr))
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

const MPI_User_function_c = MPI_User_function
const MPI_Datarep_conversion_function_c = MPI_Datarep_conversion_function

primitive type SentinelPtr Sys.WORD_SIZE
end

primitive type MPIPtr Sys.WORD_SIZE
end
@assert sizeof(MPIPtr) == sizeof(Ptr{Cvoid})
Base.cconvert(::Type{MPIPtr}, x::SentinelPtr) = x
Base.unsafe_convert(::Type{MPIPtr}, x::SentinelPtr) = reinterpret(MPIPtr, x)


# Initialize the ref constants from the library.
# This is not `API.__init__`, as it should be called _after_
# `dlopen` to ensure the library is opened correctly.
@eval function init_consts()
    $(Expr(:block, initexprs...))
end

const use_stdcall = startswith(basename(libmpi), "msmpi")

macro mpicall(expr)
    @assert expr isa Expr && expr.head == :call && expr.args[1] == :ccall

    # On unix systems we call the global symbols to allow for LD_PRELOAD interception
    # It can be emulated in Windows (via Libdl.dllist), but this is not fast.
    if Sys.isunix() && expr.args[2].head == :tuple &&
            (VERSION ≥ v"1.5-" || expr.args[2].args[1] ≠ :(:MPI_Get_library_version))
        expr.args[2] = expr.args[2].args[1]
    end

    # Microsoft MPI uses stdcall calling convention
    # this only affects 32-bit Windows
    # unfortunately we need to use ccall to call Get_library_version
    # so check using library name instead
    if use_stdcall
        insert!(expr.args, 3, :stdcall)
    end
    return esc(expr)
end

"""
    FeatureLevelError

Error thrown if a feature is not implemented in the current MPI backend.
"""
struct FeatureLevelError <: Exception
    function_name::Symbol
    min_version::VersionNumber # minimal MPI version required for this feature to be available
end
function Base.show(io::IO, err::FeatureLevelError)
    print(io, "FeatureLevelError($(err.function_name)): Minimum MPI version is $(err.min_version)")
end

macro mpichk(expr, min_version=nothing)
    if !isnothing(min_version) && expr.args[2].head == :tuple
        fn = expr.args[2].args[1].value
        if isnothing(dlsym(libmpi_handle, fn; throw_error=false))
            return quote
                throw(FeatureLevelError($(QuoteNode(fn)), $min_version))
            end
        end
    end

    expr = macroexpand(@__MODULE__, :(@mpicall($expr)))
    # MPI_SUCCESS is defined to be 0
    :((errcode = $(esc(expr))) == 0 || throw(MPIError(errcode)))
end


include("generated_api.jl")

# since this is called by invokelatest, it isn't automatically precompiled
precompile(init_consts, ())

end
