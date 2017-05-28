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
const _user_functions = Array(Function, 1) # resized to nthreads() at runtime
const _user_op = Ref{MPI_Op}(OP_NULL) # _mpi_user_function operation, initialized below

# C callback function corresponding to MPI_User_function
function _mpi_user_function(_a::Ptr{Void}, _b::Ptr{Void}, _len::Ptr{Cint}, t::Ptr{MPI_Datatype})
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

mpiop(op::MPI_Op) = op
mpiop(op::Ref{MPI_Op}) = op.x

function mpiop(opfunc::Function)
    # we must initialize these at runtime, but it can't be done in __init__
    # since MPI.Init is not called yet.  So we do it lazily here:
    if _user_op.x == OP_NULL
        # FIXME: to be thread-safe, there should really be a mutex lock
        # of some sort so that this initialization only occurs once.
        # To do when native threading in Julia stabilizes (and is documented).
        resize!(_user_functions, nthreads())
        user_function = cfunction(_mpi_user_function, Void, (Ptr{Void}, Ptr{Void}, Ptr{Cint}, Ptr{MPI_Datatype}))
        opnum = Ref{MPI_Op}()
        ccall((:MPI_Op_create, libmpi), Cint, (Ptr{MPI_User_function}, Cint, Ref{MPI_Op}),
             user_function, false, opnum)
        _user_op.x = opnum[]
    end

    _user_functions[threadid()] = opfunc
    return _user_op.x
end

# use function types in Julia 0.5 to automatically use built-in
# MPI operations for the corresponding Julia functions.
if VERSION >= v"0.5.0-dev+2396"
    for (f,op) in ((+,SUM), (*,PROD),
                   (min,MIN), (max,MAX),
                   (&, BAND), (|, BOR), ($, BXOR))
        @eval mpiop(::$(typeof(f))) = $op
    end
end

# Allreduce!{T}(sendbuf::MPIBuffertype{T}, recvbuf::MPIBuffertype{T},
#               count::Integer, opfunc::Function, comm::Comm) =
#     Allreduce!(sendbuf, recvbuf, count, user_op(opfunc), comm)

# Reduce(sendbuf::MPIBuffertype, count::Integer, opfunc::Function, root::Integer, comm::Comm) =
    # Reduce(sendbuf, count, user_op(opfunc), root, comm)
