module API

export MPI_Aint, MPI_Count, MPI_Offset, MPI_Status,
    MPI_Comm, MPI_Datatype, MPI_Errhandler, MPI_File, MPI_Group,
    MPI_Info, MPI_Message, MPI_Op, MPI_Request, MPI_Win,
    libmpi, mpiexec, @mpichk, @mpicall, MPIPtr, SentinelPtr, FeatureLevelError,
    HAS_LARGE_COUNT

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

# Callback typedefs to which the generated `ccall` signatures refer. Every ABI file
# defines the narrow callback types as `Cvoid`. Only src/api/mpiabi.jl also defines the
# large-count ones. Fill in the rest here (re-`const`ing to the same value elsewhere).
#
# The C signatures differ genuinely. `MPI_User_function` takes `int *len`, while
# `MPI_User_function_c` takes `MPI_Count *len`, and likewise for the datarep conversion
# functions. That is, these aliases are *not* interchangeable, even though we alias them here.
# We only define them all as `Cvoid` here because they arrive at `ccall` as opaque pointers.
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

`min_version` is the MPI version that introduced the feature, or `nothing` when it
is not known. See `MPI.jl/gen/versions/README.md`.
"""
struct FeatureLevelError <: Exception
    function_name::Symbol
    min_version::Union{Nothing,VersionNumber} # minimal MPI version required for this feature to be available
end
function Base.show(io::IO, err::FeatureLevelError)
    print(io, "FeatureLevelError($(err.function_name)): ")
    if isnothing(err.min_version)
        print(io, "not provided by the MPI library in use")
    else
        print(io, "Minimum MPI version is $(err.min_version)")
    end
end

"""
    @mpichk ccall(...) [min_version] [fallback=MPI_Foo]

Wrap a `ccall` to an MPI procedure: call it via `@mpicall` and turn a nonzero return
code into an `MPIError`.

If the symbol is absent from the MPI library, the whole body is replaced at
macro-expansion time — that is, when MPI.jl is precompiled — by one of

  * a call to `fallback` with the same arguments, if given. This is how the
    large-count `MPI_Foo_c` wrappers fall back to the narrow `MPI_Foo` entry points on a
    pre-MPI-4.0 library: the two take the same arguments in the same order, and a
    count which is too large for the narrow interface then fails in `ccall`'s conversion to
    `Cint`.

    Note the limit of that transparency: This only works for counts passed *by value*, which are converted by
    `ccall`. Counts passed through a pointer are not converted. Callers must therefore type
    arrays and `Ref`s with [`Count`](@ref MPI.API.Count), [`Displ`](@ref MPI.API.Displ)
    or [`TypeDispl`](@ref MPI.API.TypeDispl), which depend on the entry point they use. A
    `Ref{MPI_Count}` reaching a fallback that wants a `Ptr{Cint}` is a `MethodError`.
  * otherwise, `throw(`[`FeatureLevelError`](@ref)`(name, min_version))`.

`min_version` comes from the generator's `INTRODUCED` table.
"""
macro mpichk(expr, args...)
    min_version = nothing
    fallback = nothing
    for arg in args
        if arg isa Expr && arg.head === :(=) && arg.args[1] === :fallback
            fallback = arg.args[2]
        else
            min_version = arg
        end
    end

    if expr.args[2].head == :tuple
        fn = expr.args[2].args[1].value
        if isnothing(dlsym(libmpi_handle, fn; throw_error=false))
            if !isnothing(fallback)
                # ccall(target, returntype, argtypes, args...)
                return esc(Expr(:call, fallback, expr.args[5:end]...))
            end
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

"""
    MPI.API.HAS_LARGE_COUNT

Whether the MPI library provides the MPI 4.0 large-count (`MPI_*_c`) entry points, as
determined when MPI.jl is precompiled.

The `MPI_*_c` wrappers can be called either way: where this is `false` they fall back to
the corresponding narrow entry point, and a count that does not fit in a `Cint` then
raises an `InexactError`.
"""
const HAS_LARGE_COUNT = !isnothing(dlsym(libmpi_handle, :MPI_Send_c; throw_error=false))

"""
    MPI.API.Count

The integer type the high-level interface uses for element counts: `MPI_Count` if the
library provides the MPI 4.0 large-count entry points, and `Cint` otherwise. See
[`MPI.API.HAS_LARGE_COUNT`](@ref).
"""
const Count = HAS_LARGE_COUNT ? MPI_Count : Cint

"""
    MPI.API.Displ

The integer type the high-level interface uses for the displacements of the "v"
collectives ([`MPI.VBuffer`](@ref)): `MPI_Aint` if the library provides the MPI 4.0
large-count entry points, and `Cint` otherwise.

This is deliberately separate from [`MPI.API.Count`](@ref): `MPI_Alltoallv_c` and friends
widen their counts to `MPI_Count`, but widen their displacements only to `MPI_Aint`, and the two
are not the same type on every ABI. (For example, in 32-bit MPICH, `MPI_Count` is
`Int64` while `MPI_Aint` is `Int32`.) Note that the derived-datatype constructors go the
other way: `MPI_Type_create_struct_c` widens its byte displacements to `MPI_Count`.
"""
const Displ = HAS_LARGE_COUNT ? MPI_Aint : Cint

"""
    MPI.API.TypeDispl

The integer type which the high-level interface uses for the byte displacements of the
derived-datatype constructors (`MPI.Types.create_struct` and friends): `MPI_Count` if
the library provides the MPI 4.0 large-count entry points, and `MPI_Aint` otherwise.

A third type is needed because the datatype constructors widen byte displacements from
`MPI_Aint` all the way to `MPI_Count`, where the "v" collectives widen element
displacements only from `int` to `MPI_Aint`, so neither [`MPI.API.Count`](@ref) nor
[`MPI.API.Displ`](@ref) fits both. The three coincide on 64-bit ABIs.
"""
const TypeDispl = HAS_LARGE_COUNT ? MPI_Count : MPI_Aint

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
