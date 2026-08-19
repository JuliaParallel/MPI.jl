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
Base.cconvert(::Type{MPIPtr}, x::SentinelPtr) = x
Base.unsafe_convert(::Type{MPIPtr}, x::SentinelPtr) = reinterpret(MPIPtr, x)


# Initialize the ref constants from the library.
# This is not `API.__init__`, as it should be called _after_
# `dlopen` to ensure the library is opened correctly.
@eval function init_consts()
    $(Expr(:block, initexprs...))
end

const use_stdcall = startswith(basename(libmpi), "msmpi") && Sys.WORD_SIZE == 32

# Parse an optional leading `gc_safe=(true|false)` argument (as in `@ccall`).
# Returns (gc_safe::Bool, remaining_args).
function parse_gc_safe(args)
    if !isempty(args) && Meta.isexpr(args[1], :(=), 2) && args[1].args[1] === :gc_safe
        val = args[1].args[2]
        val === true || val === false ||
            throw(ArgumentError("`gc_safe` must be literally `true` or `false`"))
        return val, args[2:end]
    end
    return false, args
end

function mpicall_lower(expr, gc_safe::Bool)
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
    if gc_safe && VERSION >= v"1.12"
        # same lowering as Base's `@ccall gc_safe=true` (`ccall_macro_lower` in
        # `base/c.jl`); the `gc_safe` flag is only supported by Julia 1.12+
        convention = use_stdcall ? :stdcall : :ccall
        insert!(expr.args, 3, Expr(:cconv, (convention, UInt16(0), true), 0))
    elseif use_stdcall
        insert!(expr.args, 3, :stdcall)
    end
    return expr
end

"""
    @mpicall [gc_safe=false] ccall((:MPI_Fn, libmpi), rettype, (argtypes...), args...)

Wrapper around `ccall` for calling MPI library functions, handling the
platform-specific calling convention (`stdcall` for Microsoft MPI on 32-bit
Windows) and symbol lookup.

Setting `gc_safe=true` allows the garbage collector to run concurrently with
the call, which is useful for MPI functions which may block.  It is ignored on
Julia versions older than v1.12, which don't support this option.

!!! warning
    `gc_safe=true` can lead to undefined behavior if the MPI function calls
    back into the Julia runtime, see the documentation of `@ccall`.
"""
macro mpicall(args...)
    gc_safe, args = parse_gc_safe(args)
    length(args) == 1 ||
        throw(ArgumentError("@mpicall takes a `ccall(...)` expression and an optional leading `gc_safe=(true|false)` argument"))
    esc(mpicall_lower(args[1], gc_safe))
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

"""
    @mpichk [gc_safe=false] ccall((:MPI_Fn, libmpi), Cint, (argtypes...), args...) [min_version]

Like [`@mpicall`](@ref), but checks the returned error code and throws an
[`MPIError`](@ref) if the call was not successful.

If the minimal MPI version `min_version` required for `MPI_Fn` to be available
is provided and the function is not found in the MPI library, a
[`FeatureLevelError`](@ref) is thrown instead of performing the call.
"""
macro mpichk(args...)
    gc_safe, args = parse_gc_safe(args)
    1 <= length(args) <= 2 ||
        throw(ArgumentError("@mpichk takes a `ccall(...)` expression, an optional leading `gc_safe=(true|false)` argument, and an optional trailing minimum MPI version"))
    expr = args[1]
    min_version = length(args) == 2 ? args[2] : nothing
    if !isnothing(min_version) && expr.args[2].head == :tuple
        fn = expr.args[2].args[1].value
        if isnothing(dlsym(libmpi_handle, fn; throw_error=false))
            return quote
                throw(FeatureLevelError($(QuoteNode(fn)), $min_version))
            end
        end
    end

    expr = mpicall_lower(expr, gc_safe)
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
    handle_f2c = Symbol(handle,:_f2c)
    handle_c2f = Symbol(handle,:_c2f)
    @eval begin
        if $handle == Cint
            $handle_f2c(fcomm::Cint) = fcomm
            $handle_c2f(comm::Cint) = comm
        else
            function $handle_f2c(fcomm::Cint)
                ccall(($(Meta.quot(handle_f2c)), libmpi), $handle, (Cint,), fcomm)
            end
            function $handle_c2f(comm::$handle)
                ccall(($(Meta.quot(handle_c2f)), libmpi), Cint, ($handle,), comm)
            end
        end
    end
end

# since this is called by invokelatest, it isn't automatically precompiled
precompile(init_consts, ())

end
