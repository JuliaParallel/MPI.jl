"""
    Op

An MPI reduction operator, for use with [Reduce/Scan collective operations](@ref Reduce/Scan) to wrap binary operators. MPI.jl will perform this conversion automatically.

## Usage

    Op(op, T=Any; iscommutative=false)

Wrap the Julia reduction function `op` for arguments of type `T`. `op` is assumed to be
associative, and if `iscommutative` is true, assumed to be commutative as well.

Certain combinations of `op` and `T` will use the predefined MPI intrinsic operations,
otherwise it will wrap the function in a Julia closure at runtime. The macro [`@Op`](@ref)
can be used to wrap functions ahead of time, which may reduce runtime overhead, and is
required on platforms where closures are not supported (such as ARM and PPC).

User usage of this function is generally unnecessary since it will be called directly
by the relevant MPI collective operations.

## See also

- [`Reduce!`](@ref)/[`Reduce`](@ref)
- [`Allreduce!`](@ref)/[`Allreduce`](@ref)
- [`Scan!`](@ref)/[`Scan`](@ref)
- [`Exscan!`](@ref)/[`Exscan`](@ref)

"""
@mpi_handle Op MPI_Op cfunc::Union{Base.CFunction, Nothing}

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
    @assert isconcretetype(T)
    a = Ptr{T}(_a)
    b = Ptr{T}(_b)
    for i = 1:len
        unsafe_store!(b, w.f(unsafe_load(a,i), unsafe_load(b,i)), i)
    end
    return nothing
end


function Op(f, T=Any; iscommutative=false)
    if MPI_LIBRARY == MicrosoftMPI && Sys.WORD_SIZE == 32
        error("User-defined reduction operators are not supported on 32-bit Windows.\nSee https://github.com/JuliaParallel/MPI.jl/issues/246 for more details.")
    end
    w = OpWrapper{typeof(f),T}(f)
    cfunc = @cfunction($w, Cvoid, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Datatype}))

    op = Op(OP_NULL.val, cfunc)
    # int MPI_Op_create(MPI_User_function* user_fn, int commute, MPI_Op* op)
    @mpichk ccall((:MPI_Op_create, libmpi), Cint,
                  (Ptr{Cvoid}, Cint, Ptr{MPI_Op}),
                  cfunc, iscommutative, op)

    refcount_inc()
    finalizer(free, op)
    return op
end

"""
    @declareOp(op, T[, iscommutative])

Declare a Julia function `op` to be used as a custom MPI operator [`Op`](@ref) for
variables of type `T`. This will create the [`Op`](@ref) object and define an appropriate
constructor method to `Op`. The `iscommutative` argument indicates to MPI whether or not
MPI can assume the operation is commutative (default is `false`).

The usage of this macro is optional: the main advantage of this is that will avoid the use
of a closure (see ["Closure cfunctions" in the Julia
manual](https://docs.julialang.org/en/v1/manual/calling-c-and-fortran-code/#Closure-cfunctions-1),
which may offer some performance advantages.

This should only be called once per combination of `op` and `T`, and should be at the
top-level (e.g. not inside a function). It can be safely used before `MPI.Init()` and
inside a precompiled module.
"""
macro declareOp(f, T, iscommutative=false)
    opwrap = gensym(:opwrap) # we need to manually gensym for use with `@cfunction` macro
    quote
        if !Base.issingletontype(typeof($(esc(f))))
            error("@declareOp macro can only be used with instances of singleton types")
        end        
        const op = Op(OP_NULL.val, nothing)
        const $(esc(opwrap)) = OpWrapper{typeof($(esc(f))),$(esc(T))}($(esc(f)))
        function initop()
            fptr = @cfunction($opwrap, Cvoid, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Datatype}))
            @mpichk ccall((:MPI_Op_create, libmpi), Cint,
                          (Ptr{Cvoid}, Cint, Ptr{MPI_Op}),
                          fptr, $iscommutative, op)
        end
        if Initialized() && !Finalized()
            initop()
        else
            push!(mpi_init_hooks, initop)
        end
        MPI.Op(::typeof($(esc(f))), ::Type{$(esc(T))}; iscommutative=$iscommutative) = op
        op
    end
end
