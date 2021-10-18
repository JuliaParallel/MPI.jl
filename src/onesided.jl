@mpi_handle Win MPI_Win object

const WIN_NULL = _Win(MPI_WIN_NULL, nothing)
Win() = Win(WIN_NULL.val, nothing)


function free(win::Win)
    if win.val != WIN_NULL.val && !Finalized()
        # int MPI_Win_free(MPI_Win *win)
        @mpichk ccall((:MPI_Win_free, libmpi), Cint, (Ptr{MPI_Win},), win)
        win.object = nothing
    end
    return nothing
end

@enum LockType begin
    LOCK_EXCLUSIVE = MPI_LOCK_EXCLUSIVE
    LOCK_SHARED = MPI_LOCK_SHARED
end
LockType(sym::Symbol) =
    sym == :exclusive ? LOCK_EXCLUSIVE :
    sym == :shared ? LOCK_SHARED :
    error("Invalid LockType $sym")

"""
    MPI.Win_create(base[, size::Integer, disp_unit::Integer], comm::Comm; infokws...)

Create a window over the array `base`, returning a `Win` object used by these
processes to perform RMA operations. This is a collective call over `comm`.

- `size` is the size of the window in bytes (default = `sizeof(base)`)
- `disp_unit` is the size of address scaling in bytes (default =
  `sizeof(eltype(base))`)
- `infokws` are info keys providing optimization hints to the runtime.

[`MPI.free`](@ref) should be called on the `Win` object once operations have
been completed.
"""
function Win_create(base, size::Integer, disp_unit::Integer, comm::Comm; infokws...)
    win = Win()
    # int MPI_Win_create(void *base, MPI_Aint size, int disp_unit, MPI_Info info,
    #                    MPI_Comm comm, MPI_Win *win)
    @mpichk ccall((:MPI_Win_create, libmpi), Cint,
                  (MPIPtr, Cptrdiff_t, Cint, MPI_Info, MPI_Comm, Ptr{MPI_Win}),
                  base, size, disp_unit, Info(infokws...), comm, win)
    win.object = base
    finalizer(free, win)
    return win
end
function Win_create(base::Array{T}, comm::Comm; infokws...) where T
    Win_create(base, sizeof(base), sizeof(T), comm; infokws...)
end
function Win_create(base::SubArray{T}, comm::Comm; infokws...) where T
    Base.iscontiguous(base) || error("Array must be contiguous")
    Win_create(base, sizeof(base), sizeof(T), comm; infokws...)
end

"""
    win, array = MPI.Win_allocate_shared(Array{T}, dims, comm::Comm; infokws...)

Create and allocate a shared memory window for objects of type `T` of dimension
`dims` (either an integer or tuple of integers), returning a `Win` and the
`Array{T}` attached to the local process.

This is a collective call over `comm`, but `dims` can differ for each call (and
can be zero).

Use [`MPI.Win_shared_query`](@ref) to obtain the `Array` attached to a different
process in the same shared memory space.

`infokws` are info keys providing optimization hints.

[`MPI.free`](@ref) should be called on the `Win` object once operations have
been completed.
"""
function Win_allocate_shared(::Type{Ptr{T}}, len::Integer, comm::Comm; kwargs...) where T
    win = Win()
    out_baseptr = Ref{Ptr{T}}()
    # int MPI_Win_allocate_shared(MPI_Aint size, int disp_unit, MPI_Info info,
    #                             MPI_Comm comm, void *baseptr, MPI_Win *win)
    @mpichk ccall((:MPI_Win_allocate_shared, libmpi), Cint,
                  (Cptrdiff_t, Cint, MPI_Info, MPI_Comm, Ref{Ptr{T}}, Ptr{MPI_Win}),
                  len*sizeof(T), sizeof(T), Info(kwargs...), comm, out_baseptr, win)
    finalizer(free, win)
    return win, out_baseptr[]
end
function Win_allocate_shared(::Type{Array{T}}, dims, comm::Comm; kwargs...) where T
    win, ptr = Win_allocate_shared(Ptr{T}, prod(dims), comm; kwargs...)
    array = unsafe_wrap(Array, ptr, dims)
    win.object = array
    finalizer(free, win)
    return win, array
end

"""
    array = Win_shared_query(Array{T}, [dims,] win, rank)

Obtain the shared memory allocated by [`Win_allocate_shared`](@ref) of the
process `rank` in `win`. Returns an `Array{T}` of size `dims` (being a
`Vector{T}` if no `dims` argument is provided).
"""
function Win_shared_query(::Type{Ptr{T}}, win::Win, owner_rank::Integer) where T
    out_len = Ref{Cptrdiff_t}()
    out_sizeT = Ref{Cint}()
    out_baseptr = Ref{Ptr{T}}()
    # int MPI_Win_shared_query(MPI_Win win, int rank, MPI_Aint *size,
    #                          int *disp_unit, void *baseptr)
    @mpichk ccall((:MPI_Win_shared_query, libmpi), Cint,
                  (MPI_Win, Cint, Ref{Cptrdiff_t}, Ref{Cint}, Ref{Ptr{T}}),
                  win, owner_rank, out_len, out_sizeT, out_baseptr)
    out_len[], out_sizeT[], out_baseptr[]
end
function Win_shared_query(::Type{Array{T}}, win::Win, owner_rank::Integer) where T
    len, sizeT, ptr = Win_shared_query(Ptr{T}, win, owner_rank)
    sizeT == sizeof(T) || error("type sizes don't match")
    return unsafe_wrap(Array, ptr, div(len, sizeT))
end
Win_shared_query(::Type{Array{T}}, dims, win::Win, owner_rank::Integer) where T =
    reshape(Win_shared_query(Array{T}, win, owner_rank), dims)


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
    finalizer(free, win)
    win.object = Set()
    return win
end

function Win_attach!(win::Win, base::AbstractArray{T}) where T
    # int MPI_Win_attach(MPI_Win win, void *base, MPI_Aint size)
    @mpichk ccall((:MPI_Win_attach, libmpi), Cint,
                  (MPI_Win, MPIPtr, Cptrdiff_t),
                  win, base, sizeof(base))
    push!(win.object, base)
end
function Win_detach!(win::Win, base::AbstractArray{T}) where T
    # int MPI_Win_detach(MPI_Win win, const void *base)
    @mpichk ccall((:MPI_Win_detach, libmpi), Cint,
                  (MPI_Win, MPIPtr),
                  win, base)
    delete!(win.object, base)
end

function Win_fence(assert::Integer, win::Win)
    # int MPI_Win_fence(int assert, MPI_Win win)
    @mpichk ccall((:MPI_Win_fence, libmpi), Cint, (Cint, MPI_Win), assert, win)
end

function Win_fence(win::Win; nostore=false, noput=false, noprecede=false, nosucceed=false)
    assert =
        (nostore * MPI_MODE_NOSTORE) |
        (noput * MPI_MODE_NOPUT) |
        (noprecede * MPI_MODE_NOPRECEDE) |
        (nosucceed * MPI_MODE_NOSUCCEED)
    Win_fence(assert, win)
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
                  lock_type, rank, assert, win)
end
function Win_lock(rank::Integer, win::Win;
         type,  nocheck = false)
    Win_lock(type isa Symbol ? LockType(type) : type, rank, nocheck * MPI_MODE_NOCHECK, win)
end


function Win_unlock(rank::Integer, win::Win)
    # int MPI_Win_unlock(int rank, MPI_Win win)
    @mpichk ccall((:MPI_Win_unlock, libmpi), Cint, (Cint, MPI_Win), rank, win)
end


# TODO: add some sort of "remote buffer": a way to specify different datatypes/counts

"""
    Get!(origin, target_rank::Integer, [target_disp::Integer], win::Win)

Copies data from the memory window `win` on the remote rank `target_rank` into `origin`
(with diplacement `target_disp`) using remote memory access.
`origin` can be a [`Buffer`](@ref), or any object for which `Buffer(origin)` is defined.

# External links
$(_doc_external("MPI_Get"))
"""
function Get!(origin_buf::Buffer, target_rank::Integer, target_disp::Integer, win::Win)
    # int MPI_Get(void *origin_addr, int origin_count,
    #             MPI_Datatype origin_datatype, int target_rank,
    #             MPI_Aint target_disp, int target_count,
    #             MPI_Datatype target_datatype, MPI_Win win)
    @mpichk ccall((:MPI_Get, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype, Cint, Cptrdiff_t, Cint, MPI_Datatype, MPI_Win),
                  origin_buf.data, origin_buf.count, origin_buf.datatype,
                  target_rank, Cptrdiff_t(target_disp), origin_buf.count, origin_buf.datatype, win)
end
Get!(origin, target_rank::Integer, target_disp::Integer, win::Win) =
    Get!(Buffer(origin), target_rank, target_disp, win)
Get!(origin, target_rank::Integer, win::Win) =
    Get!(origin, target_rank, 0, win)

"""
    Put!(origin, target_rank::Integer, [target_disp::Integer], win::Win)

Copies data from `origin` into memory window `win` on remote rank `target_rank`
(with diplacement `target_disp`) using remote memory access.
`origin` can be a [`Buffer`](@ref), or any object for which [`Buffer_send(origin)`](@ref) is defined.

# External links
$(_doc_external("MPI_Put"))
"""
function Put!(origin_buf::Buffer, target_rank::Integer, target_disp::Integer, win::Win)
    # int MPI_Put(const void *origin_addr, int origin_count,
    #             MPI_Datatype origin_datatype, int target_rank,
    #             MPI_Aint target_disp, int target_count,
    #             MPI_Datatype target_datatype, MPI_Win win)
    @mpichk ccall((:MPI_Put, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype, Cint, Cptrdiff_t, Cint, MPI_Datatype, MPI_Win),
                  origin_buf.data, origin_buf.count, origin_buf.datatype,
                  target_rank, Cptrdiff_t(target_disp), origin_buf.count, origin_buf.datatype, win)
end
Put!(origin, target_rank::Integer, target_disp::Integer, win::Win) =
    Put!(Buffer_send(origin), target_rank, target_disp, win)
Put!(origin, target_rank::Integer, win::Win) =
    Put!(origin, target_rank, 0, win)

function Fetch_and_op!(sourceval::Ref{T}, returnval::Ref{T}, target_rank::Integer, target_disp::Integer, op::Op, win::Win) where {T}
    # int MPI_Fetch_and_op(const void *origin_addr, void *result_addr,
    #                      MPI_Datatype datatype, int target_rank, MPI_Aint target_disp,
    #                      MPI_Op op, MPI_Win win)
    @mpichk ccall((:MPI_Fetch_and_op, libmpi), Cint,
                  (MPIPtr, MPIPtr, MPI_Datatype, Cint, Cptrdiff_t, MPI_Op, MPI_Win),
                  sourceval, returnval, Datatype(T), target_rank, target_disp, op, win)
end


"""
    Accumulate!(origin, target_rank::Integer, target_disp::Integer, op::Op, win::Win)

Combine the content of the `origin` buffer into the target buffer (specified by `win` and
displacement `target_disp`) with reduction operator `op` on the remote rank
`target_rank` using remote memory access.

`origin` can be a [`Buffer`](@ref), or any object for which [`Buffer_send(origin)`](@ref) is defined.
`op` can be any predefined [`Op`](@ref) (custom operators are not supported).

# External links
$(_doc_external("MPI_Accumulate"))
"""
function Accumulate!(origin_buf::Buffer, target_rank::Integer, target_disp::Integer, op::Op, win::Win)
    # int MPI_Accumulate(const void *origin_addr, int origin_count,
    #                    MPI_Datatype origin_datatype, int target_rank,
    #                    MPI_Aint target_disp, int target_count,
    #                    MPI_Datatype target_datatype, MPI_Op op, MPI_Win win)
    @mpichk ccall((:MPI_Accumulate, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype, Cint, Cptrdiff_t, Cint, MPI_Datatype, MPI_Op, MPI_Win),
                  origin_buf.data, origin_buf.count, origin_buf.datatype,
                  target_rank, Cptrdiff_t(target_disp), origin_buf.count, origin_buf.datatype, op, win)
end
Accumulate!(origin, target_rank::Integer, target_disp::Integer, op::Op, win::Win) =
    Accumulate!(Buffer_send(origin), target_rank, target_disp, op, win)

"""
    Get_accumulate!(origin, result, target_rank::Integer, target_disp::Integer, op::Op, win::Win)

Combine the content of the `origin` buffer into the target buffer (specified by `win` and
displacement `target_disp`) with reduction operator `op` on the remote
rank `target_rank` using remote memory access. `Get_accumulate` also returns the
content of the target buffer _before_ accumulation into the `result` buffer.

`origin` can be a [`Buffer`](@ref), or any object for which `Buffer_send(origin)` is defined, `result` can be a [`Buffer`](@ref), or any object for which `Buffer(result)` is defined.
`op` can be any predefined [`Op`](@ref) (custom operators are not supported).

# External links
$(_doc_external("MPI_Get_accumulate"))
"""
function Get_accumulate!(origin_buf::Buffer, result_buf::Buffer, target_rank::Integer, target_disp::Integer, op::Op, win::Win)
    # int MPI_Get_accumulate(const void *origin_addr, int origin_count,
    #                        MPI_Datatype origin_datatype, void *result_addr,
    #                        int result_count, MPI_Datatype result_datatype,
    #                        int target_rank, MPI_Aint target_disp, int target_count,
    #                        MPI_Datatype target_datatype, MPI_Op op, MPI_Win win)
    @mpichk ccall((:MPI_Get_accumulate, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype,
                   MPIPtr, Cint, MPI_Datatype,
                   Cint, Cptrdiff_t, Cint, MPI_Datatype, MPI_Op, MPI_Win),
                  origin_buf.data, origin_buf.count, origin_buf.datatype,
                  result_buf.data, result_buf.count, result_buf.datatype,
                  target_rank, Cptrdiff_t(target_disp), origin_buf.count, origin_buf.datatype, op, win)
end
Get_accumulate!(origin, result, target_rank::Integer, target_disp::Integer, op::Op, win::Win) =
    Get_accumulate!(Buffer_send(origin), Buffer(result), target_rank, target_disp, op, win)
