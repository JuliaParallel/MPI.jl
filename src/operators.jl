"""
    Op

An MPI reduction operator, for use with [Reduce/Scan collective operations](@ref Reduce/Scan) to wrap binary operators. MPI.jl will perform this conversion automatically.

## Usage

    Op(op, T=Any; iscommutative=false)

Wrap the Julia reduction function `op` for arguments of type `T`. `op` is assumed to be
associative, and if `iscommutative` is true, assumed to be commutative as well.

## See also

- [`Reduce!`](@ref)/[`Reduce`](@ref)
- [`Allreduce!`](@ref)/[`Allreduce`](@ref)
- [`Scan!`](@ref)/[`Scan`](@ref)
- [`Exscan!`](@ref)/[`Exscan`](@ref)
"""
mutable struct Op
    val::MPI_Op
    fptr
    Op(val::MPI_Op, fptr) = new(val, fptr)
end
Base.:(==)(a::Op, b::Op) = a.val == b.val
Base.cconvert(::Type{MPI_Op}, op::Op) = op
Base.unsafe_convert(::Type{MPI_Op}, op::Op) = op.val
Base.unsafe_convert(::Type{Ptr{MPI_Op}}, op::Op) = convert(Ptr{MPI_Op}, pointer_from_objref(op))

const OP_NULL = Op(Consts.MPI_OP_NULL[], nothing)
const BAND    = Op(Consts.MPI_BAND[], nothing)
const BOR     = Op(Consts.MPI_BOR[], nothing)
const BXOR    = Op(Consts.MPI_BXOR[], nothing)
const LAND    = Op(Consts.MPI_LAND[], nothing)
const LOR     = Op(Consts.MPI_LOR[], nothing)
const LXOR    = Op(Consts.MPI_LXOR[], nothing)
const MAX     = Op(Consts.MPI_MAX[], nothing)
const MIN     = Op(Consts.MPI_MIN[], nothing)
const PROD    = Op(Consts.MPI_PROD[], nothing)
const REPLACE = Op(Consts.MPI_REPLACE[], nothing)
const SUM     = Op(Consts.MPI_SUM[], nothing)
const NO_OP   = Op(Consts.MPI_NO_OP[], nothing)
add_load_time_hook!(() -> OP_NULL.val = Consts.MPI_OP_NULL[])
add_load_time_hook!(() -> BAND.val    = Consts.MPI_BAND[]   )
add_load_time_hook!(() -> BOR.val     = Consts.MPI_BOR[]    )
add_load_time_hook!(() -> BXOR.val    = Consts.MPI_BXOR[]   )
add_load_time_hook!(() -> LAND.val    = Consts.MPI_LAND[]   )
add_load_time_hook!(() -> LOR.val     = Consts.MPI_LOR[]    )
add_load_time_hook!(() -> LXOR.val    = Consts.MPI_LXOR[]   )
add_load_time_hook!(() -> MAX.val     = Consts.MPI_MAX[]    )
add_load_time_hook!(() -> MIN.val     = Consts.MPI_MIN[]    )
add_load_time_hook!(() -> PROD.val    = Consts.MPI_PROD[]   )
add_load_time_hook!(() -> REPLACE.val = Consts.MPI_REPLACE[])
add_load_time_hook!(() -> SUM.val     = Consts.MPI_SUM[]    )
add_load_time_hook!(() -> NO_OP.val   = Consts.MPI_NO_OP[]  )

Op(::typeof(min), ::Type{T}; iscommutative=true) where {T<:Union{MPIInteger,MPIFloatingPoint}} = MIN
Op(::typeof(max), ::Type{T}; iscommutative=true) where {T<:Union{MPIInteger,MPIFloatingPoint}} = MAX
Op(::typeof(+), ::Type{T}; iscommutative=true) where {T<:Union{MPIInteger,MPIFloatingPoint,MPIComplex}} = SUM
Op(::typeof(*), ::Type{T}; iscommutative=true) where {T<:Union{MPIInteger,MPIFloatingPoint,MPIComplex}} = PROD
Op(::typeof(&), ::Type{T}; iscommutative=true) where {T<:MPIInteger} = BAND
Op(::typeof(|), ::Type{T}; iscommutative=true) where {T<:MPIInteger} = BOR
Op(::typeof(⊻), ::Type{T}; iscommutative=true) where {T<:MPIInteger} = BXOR


function free(op::Op)
    if op != OP_NULL && !Finalized()
        # int MPI_Op_free(MPI_Op *op)
        @mpichk ccall((:MPI_Op_free, libmpi), Cint, (Ptr{MPI_Op},), op)
    end
    op.fptr = nothing
    return nothing
end

struct OpWrapper{F,T}
    f::F
end

function (w::OpWrapper{F,T})(_a::Ptr{Cvoid}, _b::Ptr{Cvoid}, _len::Ptr{Cint}, t::Ptr{MPI_Datatype}) where {F,T}
    len = unsafe_load(_len)
    @assert isconcretetype(T)
    a = Ptr{T}(_a)
    b = Ptr{T}(_b)
    for i = 1:len
        unsafe_store!(b, w.f(unsafe_load(a,i), unsafe_load(b,i)), i)
    end
    return nothing
end


function Op(f, T=Any; iscommutative=false)
    @static if MPI_LIBRARY == "MicrosoftMPI" && Sys.WORD_SIZE == 32
        error("User-defined reduction operators are not supported on 32-bit Windows.\nSee https://github.com/JuliaParallel/MPI.jl/issues/246 for more details.")
    elseif Sys.ARCH ∈ (:aarch64, :ppc64le, :powerpc64le) || startswith(lowercase(String(Sys.ARCH)), "arm")
        error("User-defined reduction operators are currently not supported on non-Intel architectures.\nSee https://github.com/JuliaParallel/MPI.jl/issues/404 for more details.")
    end
    w = OpWrapper{typeof(f),T}(f)
    fptr = @cfunction($w, Cvoid, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Datatype}))

    op = Op(OP_NULL.val, fptr)
    # int MPI_Op_create(MPI_User_function* user_fn, int commute, MPI_Op* op)
    @mpichk ccall((:MPI_Op_create, libmpi), Cint,
                  (Ptr{Cvoid}, Cint, Ptr{MPI_Op}),
                  fptr, iscommutative, op)

    finalizer(free, op)
    return op
end
