# Implement user-defined MPI reduction operations, by passing Julia
# functions as callbacks to MPI.

# Unfortunately, MPI_Op_create takes a function that does not accept
# a void* "thunk" parameter, making it impossible to fully simulate
# a closure.  So, we have to use a global variable instead.   (Since
# the reduction functions are barriers, being re-entrant is probably
# not important in practice, fortunately.)
const _user_function = Ref{Function}()

# C callback function corresponding to MPI_User_function
function _mpi_user_function(_a::Ptr{Void}, _b::Ptr{Void}, _len::Ptr{Cint}, t::Ptr{Cint})
    len = unsafe_load(_len)
    T = mpitype_dict_inverse[unsafe_load(t)]
    a = Ptr{T}(_a)
    b = Ptr{T}(_b)
    f = _user_function[]
    for i = 1:len
        unsafe_store!(b, f(unsafe_load(a,i), unsafe_load(b,i)), i)
    end
    return nothing
end

# for op_create(opfunc) do op ... end
function op_create(f::Function, opfunc::Function)
    user_function = cfunction(_mpi_user_function, Void, (Ptr{Void}, Ptr{Void}, Ptr{Cint}, Ptr{Cint}))
    _user_function[] = opfunc
    opnum = Ref{Cint}()
    try
        ccall(MPI_OP_CREATE, Void, (Ptr{Void}, Ref{Cint}, Ref{Cint}, Ptr{Cint}),
             user_function, false, opnum, &0)
        return f(Op(opnum[]))
    finally
        ccall(MPI_OP_FREE, Void, (Ref{Cint}, Ptr{Cint}), opnum, &0)
    end
end

# use function types in Julia 0.5 to automatically use built-in
# MPI operations for the corresponding Julia functions.
if VERSION >= v"0.5.0-dev+2396"
    for (f,op) in ((+,SUM), (*,PROD),
                   (min,MIN), (max,MAX),
                   (&, BAND), (|, BOR), ($, BXOR))
        @eval op_create(fun::Function, ::$(typeof(f))) = fun($op)
    end
end

function Allreduce!{T}(sendbuf::MPIBuffertype{T}, recvbuf::MPIBuffertype{T},
                       count::Integer, opfunc::Function, comm::Comm)
    op_create(opfunc) do op
        return Allreduce!(sendbuf, recvbuf, count, op, comm)
    end
end

function Reduce{T}(sendbuf::MPIBuffertype{T}, count::Integer,
                   op::Function, root::Integer, comm::Comm)
    op_create(opfunc) do op
        return Reduce(sendbuf, count, op, root, comm)
    end
end
