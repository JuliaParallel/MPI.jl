@mpi_handle Op

const OP_NULL = _Op(MPI_OP_NULL)
const BAND    = _Op(MPI_BAND)
const BOR     = _Op(MPI_BOR)
const BXOR    = _Op(MPI_BXOR)
const LAND    = _Op(MPI_LAND)
const LOR     = _Op(MPI_LOR)
const LXOR    = _Op(MPI_LXOR)
const MAX     = _Op(MPI_MAX)
const MIN     = _Op(MPI_MIN)
const NO_OP   = _Op(MPI_NO_OP)
const PROD    = _Op(MPI_PROD)
const REPLACE = _Op(MPI_REPLACE)
const SUM     = _Op(MPI_SUM)



import Base.Threads: nthreads, threadid

# Implement user-defined MPI reduction operations, by passing Julia
# functions as callbacks to MPI.

# Unfortunately, MPI_Op_create takes a function that does not accept
# a void* "thunk" parameter, making it impossible to fully simulate
# a closure.  So, we have to use a global variable instead.   (Since
# the reduction functions are barriers, being re-entrant is probably
# not important in practice, fortunately.)   For MPI_THREAD_MULTIPLE
# using Julia native threading, however, we do make this global thread-local
const _user_functions = Array{Function}(undef, 1) # resized to nthreads() at runtime
const _user_op = _Op(MPI_OP_NULL)

# C callback function corresponding to MPI_User_function
function _mpi_user_function(_a::Ptr{Nothing}, _b::Ptr{Nothing}, _len::Ptr{Cint}, t::Ptr{MPI_Datatype})
    len = unsafe_load(_len)
    T = mpitype_dict_inverse[unsafe_load(t)]
    a = Ptr{T}(_a)
    b = Ptr{T}(_b)
    f = _user_functions[threadid()]
    for i = 1:len
        unsafe_store!(b, f(unsafe_load(a,i), unsafe_load(b,i)), i)
    end
    return nothing
end

function user_op(opfunc::Function)
    if Sys.iswindows() && Sys.WORD_SIZE == 32
        error("Custom reduction operators are not supported on 32-bit Windows.\nSee https://github.com/JuliaParallel/MPI.jl/issues/246 for more details.")
    end
    
    # we must initialize these at runtime, but it can't be done in __init__
    # since MPI.Init is not called yet.  So we do it lazily here:
    if _user_op.val == OP_NULL.val
        # FIXME: to be thread-safe, there should really be a mutex lock
        # of some sort so that this initialization only occurs once.
        # To do when native threading in Julia stabilizes (and is documented).
        resize!(_user_functions, nthreads())
        user_function = @cfunction(_mpi_user_function, Nothing, (Ptr{Nothing}, Ptr{Nothing}, Ptr{Cint}, Ptr{MPI_Datatype}))
        @mpichk ccall((:MPI_Op_create, libmpi), Cint,
             (Ptr{Cvoid}, Ref{Cint}, Ptr{MPI_Op}),
             user_function, false, _user_op)
    end

    _user_functions[threadid()] = opfunc
    return _user_op
end



# Match predefined ops to Julia functions
for (f,op) in [
    (+, :SUM),
    (*, :PROD),
    (min, :MIN),
    (max, :MAX),
    (&, :BAND),
    (|, :BOR),
    (⊻, :BXOR),
]
    @eval user_op(::$(typeof(f))) = $op.val
end
