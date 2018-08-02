using Compat

# Implement user-defined MPI reduction operations, by passing Julia
# functions as callbacks to MPI.

# for defining thread-local variables; can use Compat
# once JuliaLang/Compat.jl#223 is resolved.
if isdefined(Base, :Threads)
    import Base.Threads: nthreads, threadid
else
    nthreads() = 1
    threadid() = 1
end

# Unfortunately, MPI_Op_create takes a function that does not accept
# a void* "thunk" parameter, making it impossible to fully simulate
# a closure.  So, we have to use a global variable instead.   (Since
# the reduction functions are barriers, being re-entrant is probably
# not important in practice, fortunately.)   For MPI_THREAD_MULTIPLE
# using Julia native threading, however, we do make this global thread-local
const _user_functions = Array{Function}(undef, 1) # resized to nthreads() at runtime
const _user_op = Op(MPI_OP_NULL) # _mpi_user_function operation, initialized below

# C callback function corresponding to MPI_User_function
function _mpi_user_function(_a::Ptr{Nothing}, _b::Ptr{Nothing}, _len::Ptr{Cint}, t::Ptr{Cint})
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
    # we must initialize these at runtime, but it can't be done in __init__
    # since MPI.Init is not called yet.  So we do it lazily here:
    if _user_op.val == MPI_OP_NULL
        # FIXME: to be thread-safe, there should really be a mutex lock
        # of some sort so that this initialization only occurs once.
        # To do when native threading in Julia stabilizes (and is documented).
        resize!(_user_functions, nthreads())
        user_function = @cfunction(_mpi_user_function, Nothing, (Ptr{Nothing}, Ptr{Nothing}, Ptr{Cint}, Ptr{Cint}))
        opnum = Ref{Cint}()
        ccall(MPI_OP_CREATE, Nothing, (Ptr{Nothing}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
             user_function, false, opnum, 0)
        _user_op.val = opnum[]
    end

    _user_functions[threadid()] = opfunc
    return _user_op
end

# use function types in Julia 0.7 to automatically use built-in
# MPI operations for the corresponding Julia functions.
for (f,op) in ((+,SUM), (*,PROD),
               (min,MIN), (max,MAX),
               (&, BAND), (|, BOR), (⊻, BXOR))
    @eval user_op(::$(typeof(f))) = $op
end

Allreduce!(sendbuf::MPIBuffertype{T}, recvbuf::MPIBuffertype{T},
           count::Integer, opfunc::Function, comm::Comm) where {T} =
    Allreduce!(sendbuf, recvbuf, count, user_op(opfunc), comm)

Reduce(sendbuf::MPIBuffertype{T}, count::Integer,
       opfunc::Function, root::Integer, comm::Comm) where {T} =
    Reduce(sendbuf, count, user_op(opfunc), root, comm)
