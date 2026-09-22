module API

export MPI_Aint, MPI_Count, MPI_Offset, MPI_Status,
    MPI_Comm, MPI_Datatype, MPI_Errhandler, MPI_File, MPI_Group,
    MPI_Info, MPI_Message, MPI_Op, MPI_Request, MPI_Win,
    libmpi, mpiexec, @mpichk, @mpicall, MPIPtr, SentinelPtr, FeatureLevelError

import MPIPreferences
using Libdl

if MPIPreferences.binary == "MPIABI_jll"
    import MPIABI_jll: MPIABI_jll, libmpi, libmpi_handle, mpiexec
    const libmpiconstants = nothing
elseif MPIPreferences.binary == "MPICH_jll"
    import MPICH_jll: MPICH_jll, libmpi, libmpi_handle, mpiexec
    const libmpiconstants = nothing
elseif MPIPreferences.binary == "MPItrampoline_jll"
    import MPItrampoline_jll: MPItrampoline_jll, libmpi, libmpi_handle, mpiexec
    const libmpiconstants = MPItrampoline_jll.libload_time_mpi_constants_path
elseif MPIPreferences.binary == "MicrosoftMPI_jll"
    import MicrosoftMPI_jll: MicrosoftMPI_jll, libmpi, libmpi_handle, mpiexec
    const libmpiconstants = nothing
elseif MPIPreferences.binary == "OpenMPI_jll"
    import OpenMPI_jll: OpenMPI_jll, libmpi, libmpi_handle, mpiexec
    const libmpiconstants = nothing
elseif MPIPreferences.binary == "system"
    import MPIPreferences.System: libmpi, libmpi_handle, mpiexec
    const libmpiconstants = nothing
else
    error("Unknown MPI binary: $(MPIPreferences.binary)")
end

import ..MPIError, .._doc_external
const initexprs = Any[]

"""
    @const_ref name T expr

Defines a constant binding
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

@static if MPIPreferences.abi == "MPIABI"
    include("mpiabi.jl")
elseif MPIPreferences.abi == "MPICH"
    include("mpich.jl")
elseif MPIPreferences.abi == "MPItrampoline"
    include("mpitrampoline.jl")
elseif MPIPreferences.abi == "MicrosoftMPI"
    include("microsoftmpi.jl")
elseif MPIPreferences.abi == "OpenMPI"
    include("openmpi.jl")
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
Base.cconvert(::Type{MPIPtr}, x::SentinelPtr) = reinterpret(MPIPtr, x)

# Initialize the ref constants from the library.
# This is not `API.__init__`, as it should be called _after_
# `dlopen` to ensure the library is opened correctly.
@eval function init_consts()
    $(Expr(:block, initexprs...))
end

const use_stdcall = startswith(basename(libmpi), "msmpi") && Sys.WORD_SIZE == 32

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

for handle in [
    :MPI_Comm,
    :MPI_Datatype,
    :MPI_Errhandler,
    :MPI_File,
    :MPI_Group,
    :MPI_Info,
    :MPI_Message,
    :MPI_Op,
    :MPI_Request,
    :MPI_Win,
]
    # The C conversion functions are named after the handle type, except for
    # `MPI_Datatype`, for which the standard specifies `MPI_Type_f2c` and
    # `MPI_Type_c2f`.
    cname = handle === :MPI_Datatype ? :MPI_Type : handle
    handle_f2c = Symbol(cname,:_f2c)
    handle_c2f = Symbol(cname,:_c2f)
    @eval begin
        if !isnothing(dlsym(libmpi_handle, $(Meta.quot(handle_f2c)); throw_error=false)) &&
           !isnothing(dlsym(libmpi_handle, $(Meta.quot(handle_c2f)); throw_error=false))
            # Call the library's own conversion functions whenever it exports them
            function $handle_f2c(fcomm::Cint)
                @mpicall ccall(($(Meta.quot(handle_f2c)), libmpi), $handle, (Cint,), fcomm)
            end
            function $handle_c2f(comm::$handle)
                @mpicall ccall(($(Meta.quot(handle_c2f)), libmpi), Cint, ($handle,), comm)
            end
        elseif $handle === Cint || $handle === Cuint
            # The library has no such functions.  Before MPI 4.1 the standard
            # allowed these conversions to be macros, and MPICH before 4.2 as
            # well as its derivatives (Microsoft MPI, MVAPICH, Intel MPI, Cray
            # MPICH, HPE MPT) did that.
            #
            # Luckily we know that MPICH uses the same internal
            # representation for C and Fortran handles, so the
            # conversion is a no-op.
            $handle_f2c(fcomm::Cint) = fcomm % $handle
            $handle_c2f(comm::$handle) = comm % Cint
        else
            $handle_f2c(fcomm::Cint) =
                error($(string(handle_f2c)), " is not exported by this MPI library")
            $handle_c2f(comm::$handle) =
                error($(string(handle_c2f)), " is not exported by this MPI library")
        end
    end
    if cname !== handle
        # Keep `MPI_Datatype_f2c`/`MPI_Datatype_c2f` as aliases for
        # backwards compatibility
        @eval begin
            const $(Symbol(handle,:_f2c)) = $handle_f2c
            const $(Symbol(handle,:_c2f)) = $handle_c2f
        end
    end
end

# since this is called by invokelatest, it isn't automatically precompiled
precompile(init_consts, ())

end
