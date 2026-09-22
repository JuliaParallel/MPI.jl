"""
    Op

An MPI reduction operator, for use with [Reduce/Scan collective operations](@ref Reduce/Scan) to wrap binary operators. MPI.jl will perform this conversion automatically.

## Usage

    Op(op, T=Any; iscommutative=false)

Wrap the Julia reduction function `op` for arguments of type `T`. `op` is assumed to be
associative, and if `iscommutative` is true, assumed to be commutative as well.

!!! note
    On architectures where Julia cannot build closure cfunctions (anything other than x86
    and x86-64), each *distinct* operator permanently occupies a slot in an internal pool
    of C callbacks: `MPI_Op_free` only marks an operation for deallocation, so the wrapped
    function has to stay callable for the rest of the process. Identical operators share a
    slot, so reducing repeatedly with the same function is fine; [`@RegisterOp`](@ref)
    avoids the pool entirely.

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
    # use `to_type_raw` rather than `to_type(Datatype(unsafe_load(t)))` to avoid allocating
    concrete_T = isconcretetype(T) ? T : to_type_raw(unsafe_load(t))
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

# Closure cfunctions (`@cfunction($f, ...)`) are implemented with LLVM trampolines, which
# only exist on x86 and x86-64. Everywhere else creating one does not throw, it aborts the
# process, so this has to be an allowlist: an unknown architecture must take the
# trampoline pool path below.
const HAVE_CLOSURE_CFUNCTION = Sys.ARCH ∈ (:x86_64, :i686)

@static if !HAVE_CLOSURE_CFUNCTION

# Where closure cfunctions are unavailable, `Op` draws from a pool of statically defined
# trampolines instead. A trampoline is an ordinary top-level function -- which `@cfunction`
# accepts on every architecture -- forwarding to the `OpWrapper` held in its own `OpSlot`.
# That forwarding call is a dynamic dispatch, but it happens once per invocation of the
# callback rather than once per element, so it is amortized over the `len` elements MPI
# passes each time.
# See https://github.com/JuliaParallel/MPI.jl/issues/404
mutable struct OpSlot
    wrapper::Any
    fptr::Ptr{Cvoid}
end
OpSlot() = OpSlot(nothing, C_NULL)

const OP_POOL_SIZE = 128
const OP_POOL = OpSlot[OpSlot() for _ in 1:OP_POOL_SIZE]
# Number of slots handed out so far. Slots are never returned to the pool: `MPI_Op_free`
# only marks an operation for deallocation, and MPI may go on calling the user function
# until every operation referencing it has completed, so a wrapper handed to MPI has to
# stay alive and callable for the rest of the process.
const OP_POOL_USED = Ref(0)
# Maps an `OpWrapper` to the trampoline already installed for it. `Reduce!` and friends
# construct an `Op` on every call, so without this a loop reducing with the same operator
# would consume a slot per iteration. Keyed by object identity: `OpWrapper` and Julia
# closures are immutable, so `===` compares the captured values with `===`, which is
# exactly the condition under which two wrappers are interchangeable.
const OP_SLOT_CACHE = IdDict{Any,Ptr{Cvoid}}()
const OP_POOL_LOCK = ReentrantLock()
const OP_POOL_WARN_AT = 4 * OP_POOL_SIZE
const OP_POOL_WARNED = Ref(false)

# NOTE: each trampoline reaches its slot through the object interpolated into its body,
# not through a global binding. `grow_op_pool!` builds trampolines the same way in an
# already-running session, where defining a new global would be read in a world older than
# the one that defines it.
for i in 1:OP_POOL_SIZE
    @eval function $(Symbol(:_op_trampoline_, i))(a::Ptr{Cvoid}, b::Ptr{Cvoid},
                                                  len::Ptr{Cint}, t::Ptr{MPI_Datatype})
        $(OP_POOL[i]).wrapper(a, b, len, t)
        return nothing
    end
end

# `@cfunction` pointers must not be taken from a precompiled image, so they are refreshed
# at load time. This is idempotent, as it must be: load time hooks also run inside the
# precompile workload.
@eval function init_op_pool()
    $([:($(OP_POOL[i]).fptr =
             @cfunction($(Symbol(:_op_trampoline_, i)), Cvoid,
                        (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Datatype})))
       for i in 1:OP_POOL_SIZE]...)
    return nothing
end
add_load_time_hook!(init_op_pool)

"""
    grow_op_pool!()

Add one trampoline to `OP_POOL` and return its slot. Compiling it costs on the
order of 10ms, so this is a slow path, taken only once the static pool is exhausted.
The caller must hold `OP_POOL_LOCK`.
"""
function grow_op_pool!()
    slot = OpSlot()
    tramp = Symbol(:_op_trampoline_, length(OP_POOL) + 1)
    @eval function $tramp(a::Ptr{Cvoid}, b::Ptr{Cvoid}, len::Ptr{Cint}, t::Ptr{MPI_Datatype})
        $(slot).wrapper(a, b, len, t)
        return nothing
    end
    # A separate `eval`: a single `@eval begin ... end` is compiled as one thunk, so
    # `$tramp` would not yet be defined when the `@cfunction` in it is resolved.
    slot.fptr = @eval @cfunction($tramp, Cvoid,
                                 (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Datatype}))
    push!(OP_POOL, slot)
    return slot
end

"""
    op_fptr(w::OpWrapper)

Return a C function pointer to a trampoline that forwards to `w`, installing `w` in a
fresh pool slot unless an identical wrapper already occupies one.
"""
function op_fptr(w)
    @lock OP_POOL_LOCK begin
        get!(OP_SLOT_CACHE, w) do
            n = OP_POOL_USED[] + 1
            slot = n <= length(OP_POOL) ? OP_POOL[n] : grow_op_pool!()
            slot.wrapper = w
            OP_POOL_USED[] = n
            if n >= OP_POOL_WARN_AT && !OP_POOL_WARNED[]
                OP_POOL_WARNED[] = true
                @warn """
                    $n distinct user-defined reduction operators have been created. On $(Sys.ARCH)
                    each one permanently occupies a slot in MPI.jl's callback pool, and every slot
                    past the first $OP_POOL_SIZE must be compiled at run time.

                    Identical operators share a slot, so this usually means a loop is building a
                    new operator each iteration. Hoist `op = MPI.Op(f, T)` out of the loop, or
                    register the function once with `MPI.@RegisterOp(f, T)`.
                    """
            end
            slot.fptr
        end
    end
end

end # @static if !HAVE_CLOSURE_CFUNCTION

function Op(f, T=Any; iscommutative=false)
    @static if MPI_LIBRARY == "MicrosoftMPI" && Sys.WORD_SIZE == 32
        # Julia's C-compatible function pointers cannot use the `stdcall` calling
        # convention that 32-bit Microsoft MPI expects.
        error("""
            User-defined reduction operators are not supported on 32-bit Windows.
            See https://github.com/JuliaParallel/MPI.jl/issues/246 for more details.
        """)
    end
    w = OpWrapper{typeof(f),T}(f)
    fptr = @static if HAVE_CLOSURE_CFUNCTION
        @cfunction($w, Cvoid, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Datatype}))
    else
        op_fptr(w)
    end

    op = Op(OP_NULL.val, fptr)
    # int MPI_Op_create(MPI_User_function* user_fn, int commute, MPI_Op* op)
    API.MPI_Op_create(fptr, iscommutative, op)

    finalizer(free, op)
    return op
end

"""
    @RegisterOp(f, T)

Statically register the function `f` as a reduction operator [`Op`](@ref) for arguments of
type `T`.

This is an optimization, not a requirement: [`Op`](@ref) accepts any function on any
architecture. `@RegisterOp` builds the C callback for `f` when the enclosing module is
compiled rather than at run time, which avoids a dynamic dispatch on each invocation of
the callback and, on architectures without closure cfunctions, avoids permanently
occupying a slot in MPI.jl's internal callback pool.

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
