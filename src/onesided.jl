@mpi_handle Win

const WIN_NULL = _Win(MPI_WIN_NULL)
Win() = Win(WIN_NULL.val)

struct LockType
    val::Cint
end
const LOCK_EXCLUSIVE = LockType(MPI_LOCK_EXCLUSIVE)
const LOCK_SHARED = LockType(MPI_LOCK_SHARED)


"""
    MPI.Win_create(base::Array, comm::Comm; infokws...)

Create a window over the array `base`, returning a `Win` object used by these processes to perform RMA operations

This is a collective call over `comm`.

`infokws` are info keys providing optimization hints.

[`MPI.free`](@ref) should be called on the `Win` object once operations have been completed.
"""
function Win_create(base::AbstractArray{T}, comm::Comm; infokws...) where T
    win = Win()
    # int MPI_Win_create(void *base, MPI_Aint size, int disp_unit, MPI_Info info,
    #                    MPI_Comm comm, MPI_Win *win)
    @mpichk ccall((:MPI_Win_create, libmpi), Cint,
                  (MPIPtr, Cptrdiff_t, Cint, MPI_Info, MPI_Comm, Ptr{MPI_Win}),
                  base, Cptrdiff_t(length(base)*sizeof(T)), sizeof(T), Info(infokws...), comm, win)
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
    # int MPI_Win_create_dynamic(MPI_Info info, MPI_Comm comm, MPI_Win *win)
    @mpichk ccall((:MPI_Win_create_dynamic, libmpi), Cint,
                  (MPI_Info, MPI_Comm, Ptr{MPI_Win}),
                  Info(kwargs...), comm, win)
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
    # int MPI_Win_allocate_shared(MPI_Aint size, int disp_unit, MPI_Info info,
    #                             MPI_Comm comm, void *baseptr, MPI_Win *win)
    @mpichk ccall((:MPI_Win_allocate_shared, libmpi), Cint,
                  (Cptrdiff_t, Cint, MPI_Info, MPI_Comm, Ref{Ptr{T}}, Ptr{MPI_Win}),
                  Cptrdiff_t(len*sizeof(T)), sizeof(T), Info(kwargs...), comm, out_baseptr, win)
    refcount_inc()
    finalizer(free, win)
    return win, out_baseptr[]
end

function free(win::Win)
    if win.val != WIN_NULL.val
        # int MPI_Win_free(MPI_Win *win)
        @mpichk ccall((:MPI_Win_free, libmpi), Cint, (Ptr{MPI_Win},), win)
        refcount_dec()
    end
    return nothing
end




function Win_shared_query(win::Win, owner_rank::Int)
    out_len = Ref{Cptrdiff_t}()
    out_sizeT = Ref{Cint}()
    out_baseptr = Ref{Ptr{Cvoid}}()
    # int MPI_Win_shared_query(MPI_Win win, int rank, MPI_Aint *size,
    #                          int *disp_unit, void *baseptr)
    @mpichk ccall((:MPI_Win_shared_query, libmpi), Cint,
                  (MPI_Win, Cint, Ref{Cptrdiff_t}, Ref{Cint}, Ref{Ptr{Cvoid}}),
                  win, owner_rank, out_len, out_sizeT, out_baseptr)
    out_len[], out_sizeT[], out_baseptr[]
end

function Win_attach(win::Win, base::AbstractArray{T}) where T
    # int MPI_Win_attach(MPI_Win win, void *base, MPI_Aint size)
    @mpichk ccall((:MPI_Win_attach, libmpi), Cint,
                  (MPI_Win, MPIPtr, Cptrdiff_t),
                  win, base, Cptrdiff_t(sizeof(base)))
end

function Win_detach(win::Win, base::AbstractArray{T}) where T
    # int MPI_Win_detach(MPI_Win win, const void *base)
    @mpichk ccall((:MPI_Win_detach, libmpi), Cint,
                  (MPI_Win, MPIPtr),
                  win, base)
end

function Win_fence(assert::Integer, win::Win)
    # int MPI_Win_fence(int assert, MPI_Win win)
    @mpichk ccall((:MPI_Win_fence, libmpi), Cint, (Cint, MPI_Win), assert, win)
end

function Win_flush(rank::Integer, win::Win)
    # int MPI_Win_flush(int rank, MPI_Win win)
    @mpichk ccall((:MPI_Win_flush, libmpi), Cint,(Cint, MPI_Win), rank, win)
end

function Win_sync(win::Win)
    # int MPI_Win_sync(MPI_Win win)
    @mpichk ccall((:MPI_Win_sync, libmpi), Cint, (MPI_Win,), win)
end

function Win_lock(lock_type::LockType, rank::Integer, assert::Integer, win::Win)
    # int MPI_Win_lock(int lock_type, int rank, int assert, MPI_Win win)
    @mpichk ccall((:MPI_Win_lock, libmpi), Cint,
                  (Cint, Cint, Cint, MPI_Win),
                  lock_type.val, rank, assert, win)
end

function Win_unlock(rank::Integer, win::Win)
    # int MPI_Win_unlock(int rank, MPI_Win win)
    @mpichk ccall((:MPI_Win_unlock, libmpi), Cint, (Cint, MPI_Win), rank, win)
end

function Get(origin_buffer, count::Integer, target_rank::Integer, target_disp::Integer, win::Win)
    T = eltype(origin_buffer)
    # int MPI_Get(void *origin_addr, int origin_count,
    #             MPI_Datatype origin_datatype, int target_rank,
    #             MPI_Aint target_disp, int target_count,
    #             MPI_Datatype target_datatype, MPI_Win win)
    @mpichk ccall((:MPI_Get, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype, Cint, Cptrdiff_t, Cint, MPI_Datatype, MPI_Win),
                  origin_buffer, count, mpitype(T), target_rank, Cptrdiff_t(target_disp), count, mpitype(T), win)
end
function Get(origin_buffer::AbstractArray{T}, target_rank::Integer, win::Win) where T
    count = length(origin_buffer)
    Get(origin_buffer, count, target_rank, 0, win)
end
function Get(origin_value::Ref{T}, target_rank::Integer, win::Win) where T
    Get(origin_value, 1, target_rank, 0, win)
end

function Put(origin_buffer, count::Integer, target_rank::Integer, target_disp::Integer, win::Win)
    # int MPI_Put(const void *origin_addr, int origin_count,
    #             MPI_Datatype origin_datatype, int target_rank,
    #             MPI_Aint target_disp, int target_count,
    #             MPI_Datatype target_datatype, MPI_Win win)
    T = eltype(origin_buffer)
    @mpichk ccall((:MPI_Put, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype, Cint, Cptrdiff_t, Cint, MPI_Datatype, MPI_Win),
                  origin_buffer, count, mpitype(T), target_rank, Cptrdiff_t(target_disp), count, mpitype(T), win)
end
function Put(origin_buffer::AbstractArray{T}, target_rank::Integer, win::Win) where T
    count = length(origin_buffer)
    Put(origin_buffer, count, target_rank, 0, win)
end
function Put(origin_value::Ref{T}, target_rank::Integer, win::Win) where T
    Put(origin_value, 1, target_rank, 0, win)
end

function Fetch_and_op(sourceval, returnval, target_rank::Integer, target_disp::Integer, op::Op, win::Win)
    # int MPI_Fetch_and_op(const void *origin_addr, void *result_addr,
    #                      MPI_Datatype datatype, int target_rank, MPI_Aint target_disp,
    #                      MPI_Op op, MPI_Win win)
    @assert eltype(sourceval) == eltype(returnval)
    T = eltype(sourceval)
    @mpichk ccall((:MPI_Fetch_and_op, libmpi), Cint,
                  (MPIPtr, MPIPtr, MPI_Datatype, Cint, Cptrdiff_t, MPI_Op, MPI_Win),
                  sourceval, returnval, mpitype(T), target_rank, target_disp, op, win)
end

function Accumulate(origin_buffer, count::Integer, target_rank::Integer, target_disp::Integer, op::Op, win::Win)
    # int MPI_Accumulate(const void *origin_addr, int origin_count,
    #                    MPI_Datatype origin_datatype, int target_rank,
    #                    MPI_Aint target_disp, int target_count,
    #                    MPI_Datatype target_datatype, MPI_Op op, MPI_Win win)
    T = eltype(origin_buffer)
    @mpichk ccall((:MPI_Accumulate, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype, Cint, Cptrdiff_t, Cint, MPI_Datatype, MPI_Op, MPI_Win),
                  origin_buffer, count, mpitype(T), target_rank, Cptrdiff_t(target_disp), count, mpitype(T), op, win)
end

function Get_accumulate(origin_buffer, result_buffer, count::Integer, target_rank::Integer, target_disp::Integer, op::Op, win::Win)
    # int MPI_Get_accumulate(const void *origin_addr, int origin_count,
    #                        MPI_Datatype origin_datatype, void *result_addr,
    #                        int result_count, MPI_Datatype result_datatype,
    #                        int target_rank, MPI_Aint target_disp, int target_count,
    #                        MPI_Datatype target_datatype, MPI_Op op, MPI_Win win)
    @assert eltype(origin_buffer) == eltype(result_buffer)
    T = eltype(origin_buffer)
    @mpichk ccall((:MPI_Get_accumulate, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, Cptrdiff_t, Cint, MPI_Datatype, MPI_Op, MPI_Win),
                  origin_buffer, count, mpitype(T), result_buffer, count, mpitype(T), target_rank, Cptrdiff_t(target_disp), count, mpitype(T), op, win)
end
