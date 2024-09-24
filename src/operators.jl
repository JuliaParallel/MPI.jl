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
- [`@RegisterOp`](@ref)
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

const OP_NULL = Op(API.MPI_OP_NULL[], nothing)
const BAND    = Op(API.MPI_BAND[], nothing)
const BOR     = Op(API.MPI_BOR[], nothing)
const BXOR    = Op(API.MPI_BXOR[], nothing)
const LAND    = Op(API.MPI_LAND[], nothing)
const LOR     = Op(API.MPI_LOR[], nothing)
const LXOR    = Op(API.MPI_LXOR[], nothing)
const MAX     = Op(API.MPI_MAX[], nothing)
const MIN     = Op(API.MPI_MIN[], nothing)
const PROD    = Op(API.MPI_PROD[], nothing)
const REPLACE = Op(API.MPI_REPLACE[], nothing)
const SUM     = Op(API.MPI_SUM[], nothing)
const NO_OP   = Op(API.MPI_NO_OP[], nothing)
add_load_time_hook!(LoadTimeHookSetVal(OP_NULL, API.MPI_OP_NULL))
add_load_time_hook!(LoadTimeHookSetVal(BAND,    API.MPI_BAND   ))
add_load_time_hook!(LoadTimeHookSetVal(BOR,     API.MPI_BOR    ))
add_load_time_hook!(LoadTimeHookSetVal(BXOR,    API.MPI_BXOR   ))
add_load_time_hook!(LoadTimeHookSetVal(LAND,    API.MPI_LAND   ))
add_load_time_hook!(LoadTimeHookSetVal(LOR,     API.MPI_LOR    ))
add_load_time_hook!(LoadTimeHookSetVal(LXOR,    API.MPI_LXOR   ))
add_load_time_hook!(LoadTimeHookSetVal(MAX,     API.MPI_MAX    ))
add_load_time_hook!(LoadTimeHookSetVal(MIN,     API.MPI_MIN    ))
add_load_time_hook!(LoadTimeHookSetVal(PROD,    API.MPI_PROD   ))
add_load_time_hook!(LoadTimeHookSetVal(REPLACE, API.MPI_REPLACE))
add_load_time_hook!(LoadTimeHookSetVal(SUM,     API.MPI_SUM    ))
add_load_time_hook!(LoadTimeHookSetVal(NO_OP,   API.MPI_NO_OP  ))

Op(::typeof(min), ::Type{T}; iscommutative=true) where {T<:Union{MPIInteger,MPIFloatingPoint}} = MIN
Op(::typeof(max), ::Type{T}; iscommutative=true) where {T<:Union{MPIInteger,MPIFloatingPoint}} = MAX
Op(::typeof(+), ::Type{T}; iscommutative=true) where {T<:Union{MPIInteger,MPIFloatingPoint,MPIComplex}} = SUM
Op(::typeof(*), ::Type{T}; iscommutative=true) where {T<:Union{MPIInteger,MPIFloatingPoint,MPIComplex}} = PROD
Op(::typeof(&), ::Type{T}; iscommutative=true) where {T<:MPIInteger} = BAND
Op(::typeof(|), ::Type{T}; iscommutative=true) where {T<:MPIInteger} = BOR
Op(::typeof(⊻), ::Type{T}; iscommutative=true) where {T<:MPIInteger} = BXOR
Op(::typeof(&), ::Type{T}; iscommutative=true) where {T<:MPILogical} = LAND
Op(::typeof(|), ::Type{T}; iscommutative=true) where {T<:MPILogical} = LOR
Op(::typeof(⊻), ::Type{T}; iscommutative=true) where {T<:MPILogical} = LXOR


function free(op::Op)
    if op != OP_NULL && !Finalized()
        # int MPI_Op_free(MPI_Op *op)
        API.MPI_Op_free(op)
    end
    op.fptr = nothing
    return nothing
end

struct OpWrapper{F,T}
    f::F
end

function (w::OpWrapper{F,T})(_a::Ptr{Cvoid}, _b::Ptr{Cvoid}, _len::Ptr{Cint}, t::Ptr{MPI_Datatype}) where {F,T}
    len = unsafe_load(_len)
    if !isconcretetype(T)
        concrete_T = to_type(Datatype(unsafe_load(t))) # Ptr might actually point to a Julia object so we could unsafe_pointer_to_objref?
    else
        concrete_T = T
    end
    function copy(::Type{T}) where T
        @assert isconcretetype(T)
        a = Ptr{T}(_a)
        b = Ptr{T}(_b)
        for i = 1:len
            unsafe_store!(b, w.f(unsafe_load(a,i), unsafe_load(b,i)), i)
        end
    end
    copy(concrete_T)
    return nothing
end

function Op(f, T=Any; iscommutative=false)
    @static if MPI_LIBRARY == "MicrosoftMPI" && Sys.WORD_SIZE == 32
        error("""
            User-defined reduction operators are not supported on 32-bit Windows.
            See https://github.com/JuliaParallel/MPI.jl/issues/246 for more details.
        """)
    elseif Sys.ARCH ∈ (:aarch64, :ppc64le, :powerpc64le) || startswith(lowercase(String(Sys.ARCH)), "arm")
        error("""
            User-defined reduction operators are currently not supported on non-Intel architectures.
            See https://github.com/JuliaParallel/MPI.jl/issues/404 for more details.

            You may want to use `@RegisterOp` to statically register `f`.
            """)
    end
    w = OpWrapper{typeof(f),T}(f)
    fptr = @cfunction($w, Cvoid, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Datatype}))

    op = Op(OP_NULL.val, fptr)
    # int MPI_Op_create(MPI_User_function* user_fn, int commute, MPI_Op* op)
    API.MPI_Op_create(fptr, iscommutative, op)

    finalizer(free, op)
    return op
end

"""
    @RegisterOp(f, T)

Register a custom operator [`Op`](@ref) using the function `f` statically.
On platfroms like AArch64, Julia does not support runtime closures,
being passed to C. The generic version of [`Op`](@ref) uses runtime closures
to support arbitrary functions being passed as MPI reduction operators.
`@RegisterOp` statically adds a function to the set of functions allowed as
as an MPI operator.

```julia
function my_reduce(x, y)
    2x+y-x
end
MPI.@RegisterOp(my_reduce, Int)
# ...
MPI.Reduce!(send_arr, recv_arr, my_reduce, MPI.COMM_WORLD; root=root)
#...
```
!!! warning
    Note that `@RegisterOp` works be introducing a new method of the generic function `Op`.
    It can only be used as a top-level statement and may trigger method invalidations.

!!! note
    `T` can be `Any`, but this will lead to a runtime dispatch.
"""
macro RegisterOp(f, T)
    name_wrapper = gensym(Symbol(f, :_, T, :_wrapper))
    name_fptr = gensym(Symbol(f, :_, T, :_ptr))
    name_module = gensym(Symbol(f, :_, T, :_module))
    # The gist is that we can use a method very similar to how we handle `min`/`max`
    # but since this might be used from user code we can't use add_load_time_hook!
    # this is why we introduce a new module that has a `__init__` function.
    # If this module approach is too costly for loading MPI.jl for internal use we could use
    # `add_load_time_hook`
    expr = quote
        module $(name_module)
            # import ..$f, ..$T
            $(Expr(:import, Expr(:., :., :., f), Expr(:., :., :., T))) # Julia 1.6 strugles with import ..$f, ..$T
            const $(name_wrapper) = $OpWrapper{typeof($f),$T}($f)
            const $(name_fptr) = Ref(@cfunction($(name_wrapper), Cvoid, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{$MPI_Datatype})))
            function __init__()
                $(name_fptr)[] = @cfunction($(name_wrapper), Cvoid, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{$MPI_Datatype}))
            end
            import MPI: Op
            # we can't create a const Op since MPI needs to be initialized?
            function Op(::typeof($f), ::Type{<:$T}; iscommutative=false)
                op = Op($OP_NULL.val, $(name_fptr)[])
                # int MPI_Op_create(MPI_User_function* user_fn, int commute, MPI_Op* op)
                $API.MPI_Op_create($(name_fptr)[], iscommutative, op)

                finalizer($free, op)
            end
        end
    end
    expr.head = :toplevel
    esc(expr)
end

@RegisterOp(min, Any)
@RegisterOp(max, Any)
@RegisterOp(+, Any)
@RegisterOp(*, Any)
@RegisterOp(&, Any)
@RegisterOp(|, Any)
@RegisterOp(⊻, Any)
