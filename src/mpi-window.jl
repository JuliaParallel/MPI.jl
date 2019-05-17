mutable struct Win
    val::Cint
    Win() = new(MPI_WIN_NULL)
end

function Base.unsafe_convert(::Type{Ptr{Cint}}, win::Win)
    convert(Ptr{Cint}, pointer_from_objref(win))
end


if HAVE_MPI_COMM_C2F
    function CWin(win::Win)
      ccall((:MPI_Win_f2c, libmpi), CWin, (Cint,), win.val)
    end
    function Win(cwin::CWin)
      Win(ccall((:MPI_Win_c2f, libmpi), Cint, (CWin,), cwin))
    end
else
    function CWin(win::Win)
      reinterpret(CWin, win.val)
    end
    function Win(cwin::CWin)
      Win(reinterpret(Cint, cwin))
    end
end

"""
    MPI.Win_create(base::Array, comm::Comm; infokws...)

Create a window over the array `base`, returning a `Win` object used by these processes to perform RMA operations

This is a collective call over `comm`.

`infokws` are info keys providing optimization hints.

[`MPI.free`](@ref) should be called on the `Win` object once operations have been completed.
"""
function Win_create(base::Array{T}, comm::Comm; infokws...) where T
    win = Win()
    ccall(MPI_WIN_CREATE, Nothing,
          (Ptr{T}, Ref{Cptrdiff_t}, Ref{Cint}, Ptr{Cint}, Ref{Cint}, Ptr{Cint}, Ref{Cint}),
          base, Cptrdiff_t(length(base)*sizeof(T)), sizeof(T), Info(infokws...), comm.val, win, 0)
    refcount_inc()
    finalizer(free, win)
    return win
end

"""
    MPI.Win_create_dynamic(comm::Comm; infokws...)

Create a dynamic window returning a `Win` object used by these processes to perform RMA operations

This is a collective call over `comm`.

`infokws` are info keys providing optimization hints.

[`MPI.free`](@ref) should be called on the `Win` object once operations have been completed.
"""
function Win_create_dynamic(comm::Comm; kwargs...)
    win = Win()
    ccall(MPI_WIN_CREATE_DYNAMIC, Nothing,
          (Ptr{Cint}, Ref{Cint}, Ptr{Cint}, Ref{Cint}),
          Info(kwargs...), comm.val, win, 0)
    refcount_inc()
    finalizer(free, win)
    return win
end



"""
    (win, ptr) = MPI.Win_allocate_shared(T, len, comm::Comm; infokws...)

Create and allocate a shared memory window for objects of type `T` of length `len`,
returning a `Win` and a `Ptr{T}` object used by these processes to perform RMA operations

This is a collective call over `comm`.

`infokws` are info keys providing optimization hints.

[`MPI.free`](@ref) should be called on the `Win` object once operations have been completed.
"""
function Win_allocate_shared(::Type{T}, len::Int, comm::Comm; kwargs...) where T
    win = Win()
    out_baseptr = Ref{Ptr{T}}()
    ccall(MPI_WIN_ALLOCATE_SHARED, Nothing,
          (Ref{Cptrdiff_t}, Ref{Cint}, Ptr{Cint}, Ref{Cint}, Ref{Ptr{T}}, Ptr{Cint}, Ref{Cint}),
          Cptrdiff_t(len*sizeof(T)), sizeof(T), Info(kwargs...), comm.val, out_baseptr, win, 0)
    refcount_inc()
    finalizer(free, win)
    return win, out_baseptr[]
end

function free(win::Win)
    if win.val != MPI_WIN_NULL
        ccall(MPI_WIN_FREE, Nothing, (Ptr{Cint}, Ref{Cint}), win, 0)
        refcount_dec()
    end
    return nothing
end




function Win_shared_query(win::Win, owner_rank::Int)
    out_len = Ref{Cptrdiff_t}()
    out_sizeT = Ref{Cint}()
    out_baseptr = Ref{Ptr{Cvoid}}()
    ccall(MPI_WIN_SHARED_QUERY, Nothing,
          (Ref{Cint}, Ref{Cint}, Ref{Cptrdiff_t}, Ref{Cint}, Ref{Ptr{Cvoid}}, Ref{Cint}),
          win.val, owner_rank, out_len, out_sizeT, out_baseptr, 0)
    out_len[], out_sizeT[], out_baseptr[]
end

function Win_attach(win::Win, base::Array{T}) where T
    ccall(MPI_WIN_ATTACH, Nothing,
          (Ref{Cint}, Ptr{T}, Ref{Cptrdiff_t}, Ref{Cint}),
          win.val, base, Cptrdiff_t(sizeof(base)), 0)
end

function Win_detach(win::Win, base::Array{T}) where T
    ccall(MPI_WIN_DETACH, Nothing,
          (Ref{Cint}, Ptr{T}, Ref{Cint}),
          win.val, base, 0)
end

function Win_fence(assert::Integer, win::Win)
    ccall(MPI_WIN_FENCE, Nothing, (Ref{Cint}, Ref{Cint}, Ref{Cint}), assert, win.val, 0)
end

function Win_flush(rank::Integer, win::Win)
    ccall(MPI_WIN_FLUSH, Nothing, (Ref{Cint}, Ref{Cint}, Ref{Cint}), rank, win.val, 0)
end

function Win_sync(win::Win)
    ccall(MPI_WIN_SYNC, Nothing, (Ref{Cint}, Ref{Cint}), win.val, 0)
end

function Win_sync(win::CWin)
    ccall((:MPI_Win_sync, libmpi), Nothing, (CWin,), win)
end

function Win_lock(lock_type::LockType, rank::Integer, assert::Integer, win::Win)
    ccall(MPI_WIN_LOCK, Nothing,
          (Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          lock_type.val, rank, assert, win.val, 0)
end

function Win_unlock(rank::Integer, win::Win)
    ccall(MPI_WIN_UNLOCK, Nothing, (Ref{Cint}, Ref{Cint}, Ref{Cint}), rank, win.val, 0)
end

function Get(origin_buffer::MPIBuffertype{T}, count::Integer, target_rank::Integer, target_disp::Integer, win::Win) where T
    ccall(MPI_GET, Nothing,
          (Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cptrdiff_t}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          origin_buffer, count, mpitype(T), target_rank, Cptrdiff_t(target_disp), count, mpitype(T), win.val, 0)
end
function Get(origin_buffer::Array{T}, target_rank::Integer, win::Win) where T
    count = length(origin_buffer)
    Get(origin_buffer, count, target_rank, 0, win)
end
function Get(origin_value::Ref{T}, target_rank::Integer, win::Win) where T
    Get(origin_value, 1, target_rank, 0, win)
end

function Put(origin_buffer::MPIBuffertype{T}, count::Integer, target_rank::Integer, target_disp::Integer, win::Win) where T
    ccall(MPI_PUT, Nothing,
          (Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cptrdiff_t}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          origin_buffer, count, mpitype(T), target_rank, Cptrdiff_t(target_disp), count, mpitype(T), win.val, 0)
end
function Put(origin_buffer::Array{T}, target_rank::Integer, win::Win) where T
    count = length(origin_buffer)
    Put(origin_buffer, count, target_rank, 0, win)
end
function Put(origin_value::Ref{T}, target_rank::Integer, win::Win) where T
    Put(origin_value, 1, target_rank, 0, win)
end

function Fetch_and_op(sourceval::MPIBuffertype{T}, returnval::MPIBuffertype{T}, target_rank::Integer, target_disp::Integer, op::Op, win::Win) where T
    ccall(MPI_FETCH_AND_OP, Nothing,
          (Ptr{T}, Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cptrdiff_t}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          sourceval, returnval, mpitype(T), target_rank, Cptrdiff_t(target_disp), op.val, win.val, 0)
end

function Fetch_and_op(sourceval::MPIBuffertype{T}, returnval::MPIBuffertype{T}, target_rank::Integer, target_disp::Integer, op::Op, win::CWin) where T
    ccall((:MPI_Fetch_and_op, libmpi), Nothing,
          (Ptr{T}, Ptr{T}, Cint, Cint, Cptrdiff_t, Cint, CWin),
          sourceval, returnval, mpitype(T), target_rank, target_disp, op.val, win)
end

function Accumulate(origin_buffer::MPIBuffertype{T}, count::Integer, target_rank::Integer, target_disp::Integer, op::Op, win::Win) where T
    ccall(MPI_ACCUMULATE, Nothing,
          (Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cptrdiff_t}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          origin_buffer, count, mpitype(T), target_rank, Cptrdiff_t(target_disp), count, mpitype(T), op.val, win.val, 0)
end

function Get_accumulate(origin_buffer::MPIBuffertype{T}, result_buffer::MPIBuffertype{T}, count::Integer, target_rank::Integer, target_disp::Integer, op::Op, win::Win) where T
    ccall(MPI_GET_ACCUMULATE, Nothing,
          (Ptr{T}, Ref{Cint}, Ref{Cint}, Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cptrdiff_t}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          origin_buffer, count, mpitype(T), result_buffer, count, mpitype(T), target_rank, Cptrdiff_t(target_disp), count, mpitype(T), op.val, win.val, 0)
end
