"""
    Op

An MPI reduction operator, for use with [`Reduce!`](@ref)/[`Reduce`](@ref),
[`Reduce_in_place!`](@ref), [`Allreduce!`](@ref)/[`Allreduce`](@ref), [`Scan`](@ref) or [`Exscan`](@ref).

## Usage

    Op(op, T=Any; iscommutative=false)

Wrap the Julia reduction function `op` for arguments of type `T`. `op` is assumed to be
associative, and if `iscommutative` is true, assumed to be commutative as well.
"""
@mpi_handle Op fptr

const OP_NULL = _Op(MPI_OP_NULL, nothing)
const BAND    = _Op(MPI_BAND, nothing)
const BOR     = _Op(MPI_BOR, nothing)
const BXOR    = _Op(MPI_BXOR, nothing)
const LAND    = _Op(MPI_LAND, nothing)
const LOR     = _Op(MPI_LOR, nothing)
const LXOR    = _Op(MPI_LXOR, nothing)
const MAX     = _Op(MPI_MAX, nothing)
const MIN     = _Op(MPI_MIN, nothing)
const PROD    = _Op(MPI_PROD, nothing)
const REPLACE = _Op(MPI_REPLACE, nothing)
const SUM     = _Op(MPI_SUM, nothing)

if @isdefined(MPI_NO_OP)
    const NO_OP   = _Op(MPI_NO_OP, nothing)
end

Op(::typeof(min), ::Type{T}; iscommutative=true) where {T<:Union{MPIInteger,MPIFloatingPoint}} = MIN
Op(::typeof(max), ::Type{T}; iscommutative=true) where {T<:Union{MPIInteger,MPIFloatingPoint}} = MAX
Op(::typeof(+), ::Type{T}; iscommutative=true) where {T<:Union{MPIInteger,MPIFloatingPoint,MPIComplex}} = SUM
Op(::typeof(*), ::Type{T}; iscommutative=true) where {T<:Union{MPIInteger,MPIFloatingPoint,MPIComplex}} = PROD
Op(::typeof(&), ::Type{T}; iscommutative=true) where {T<:MPIInteger} = BAND
Op(::typeof(|), ::Type{T}; iscommutative=true) where {T<:MPIInteger} = BOR
Op(::typeof(⊻), ::Type{T}; iscommutative=true) where {T<:MPIInteger} = BXOR


function free(op::Op)
    if op.val != OP_NULL.val
        @mpichk ccall((:MPI_Op_free, libmpi), Cint, (Ptr{MPI_Op},), op)
        refcount_dec()
    end
    return nothing
end

struct OpWrapper{F,T}
    f::F
end

function (w::OpWrapper{F,T})(_a::Ptr{Cvoid}, _b::Ptr{Cvoid}, _len::Ptr{Cint}, t::Ptr{MPI_Datatype}) where {F,T}
    len = unsafe_load(_len)
    if isconcretetype(T)
        S = T
    else
        S = mpitype_dict_inverse[unsafe_load(t)]
    end
    a = Ptr{S}(_a)
    b = Ptr{S}(_b)
    for i = 1:len
        unsafe_store!(b, w.f(unsafe_load(a,i), unsafe_load(b,i)), i)
    end
    return nothing
end


function Op(f, T=Any; iscommutative=false)
    if Sys.iswindows() && Sys.WORD_SIZE == 32
        error("User-defined reduction operators are not supported on 32-bit Windows.\nSee https://github.com/JuliaParallel/MPI.jl/issues/246 for more details.")
    end
    w = OpWrapper{typeof(f),T}(f)
    fptr = @cfunction($w, Cvoid, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Datatype}))
    
    op = Op(OP_NULL.val, fptr)
    # int MPI_Op_create(MPI_User_function* user_fn, int commute, MPI_Op* op)
    @mpichk ccall((:MPI_Op_create, libmpi), Cint,
                  (Ptr{Cvoid}, Cint, Ptr{MPI_Op}),
                  fptr, iscommutative, op)

    refcount_inc()
    finalizer(free, op)
    return op
end

