mutable struct Win
    val::MPI_Win
    object
end
Base.:(==)(a::Win, b::Win) = a.val == b.val
Base.cconvert(::Type{MPI_Win}, win::Win) = win
Base.unsafe_convert(::Type{MPI_Win}, win::Win) = win.val
Base.unsafe_convert(::Type{Ptr{MPI_Win}}, win::Win) = convert(Ptr{MPI_Win}, pointer_from_objref(win))

const WIN_NULL = Win(API.MPI_WIN_NULL[], nothing)
add_load_time_hook!(LoadTimeHookSetVal(WIN_NULL, API.MPI_WIN_NULL))

Win() = Win(WIN_NULL.val, nothing)

function free(win::Win)
    if win != WIN_NULL && !Finalized()
        # int MPI_Win_free(MPI_Win *win)
        API.MPI_Win_free(win)
    end
    win.object = nothing
    return nothing
end

mutable struct LockType
    val::Cint
end
Base.:(==)(a::LockType, b::LockType) = a.val == b.val
Base.cconvert(::Type{Cint}, lock_type::LockType) = lock_type
Base.unsafe_convert(::Type{Cint}, lock_type::LockType) = lock_type.val
Base.unsafe_convert(::Type{Ptr{Cint}}, lock_type::LockType) = convert(Ptr{Cint}, pointer_from_objref(lock_type))

const LOCK_EXCLUSIVE = LockType(API.MPI_LOCK_EXCLUSIVE[])
const LOCK_SHARED    = LockType(API.MPI_LOCK_SHARED[]   )
add_load_time_hook!(LoadTimeHookSetVal(LOCK_EXCLUSIVE, API.MPI_LOCK_EXCLUSIVE))
add_load_time_hook!(LoadTimeHookSetVal(LOCK_SHARED,    API.MPI_LOCK_SHARED   ))
LockType(sym::Symbol) =
    sym ≡ :exclusive ? LOCK_EXCLUSIVE :
    sym ≡ :shared ? LOCK_SHARED :
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
    API.MPI_Win_create(base, size, disp_unit, Info(infokws...), comm, win)
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
    win, array = MPI.Win_allocate(Array{T}, dims, comm::Comm; infokws...)

Create and allocate a window for objects of type `T` of dimension
`dims` (either an integer or tuple of integers), returning a `Win` and the
`Array{T}` attached to the local process.

This is a collective call over `comm`, but `dims` can differ for each call (and
can be zero).

If the underlying implementation supports MPI 4.1, 
use [`MPI.Win_shared_query`](@ref) to obtain the `Array` attached to a different
process in the same shared memory space.

`infokws` are info keys providing optimization hints.

[`MPI.free`](@ref) should be called on the `Win` object once operations have
been completed.
"""
function Win_allocate(::Type{Ptr{T}}, len::Integer, comm::Comm; kwargs...) where T
    win = Win()
    out_baseptr = Ref{Ptr{T}}()
    # int MPI_Win_allocate(MPI_Aint size, int disp_unit, MPI_Info info,
    #                      MPI_Comm comm, void *baseptr, MPI_Win *win)
    API.MPI_Win_allocate(len*sizeof(T), sizeof(T), Info(kwargs...), comm, out_baseptr, win)
    finalizer(free, win)
    return win, out_baseptr[]
end
function Win_allocate(::Type{Array{T}}, dims, comm::Comm; kwargs...) where T
    win, ptr = Win_allocate(Ptr{T}, prod(dims), comm; kwargs...)
    array = unsafe_wrap(Array, ptr, dims)
    win.object = array
    finalizer(free, win)
    return win, array
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
    API.MPI_Win_allocate_shared(len*sizeof(T), sizeof(T), Info(kwargs...), comm, out_baseptr, win)
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
    array = Win_shared_query(Array{T}, [dims,] win; rank)

Obtain the shared memory allocated by [`Win_allocate_shared`](@ref) of the
process `rank` in `win`. Returns an `Array{T}` of size `dims` (being a
`Vector{T}` if no `dims` argument is provided).
"""
Win_shared_query(::Type{Array{T}}, win::Win; rank) where {T} =
    Win_shared_query(Array{T}, win, rank)
Win_shared_query(::Type{Ptr{T}}, win::Win; rank) where {T} =
    Win_shared_query(Ptr{T}, win, rank)
Win_shared_query(::Type{Array{T}}, dims, win::Win; rank) where {T} =
    Win_shared_query(Array{T}, dims, win, rank)

function Win_shared_query(::Type{Ptr{T}}, win::Win, owner_rank::Integer) where T
    out_len = Ref{Cptrdiff_t}()
    out_sizeT = Ref{Cint}()
    out_baseptr = Ref{Ptr{T}}()
    # int MPI_Win_shared_query(MPI_Win win, int rank, MPI_Aint *size,
    #                          int *disp_unit, void *baseptr)
    API.MPI_Win_shared_query(win, owner_rank, out_len, out_sizeT, out_baseptr)
    out_len[], out_sizeT[], out_baseptr[]
end
function Win_shared_query(::Type{Array{T}}, win::Win, owner_rank::Integer) where T
    len, sizeT, ptr = Win_shared_query(Ptr{T}, win, owner_rank)
    sizeT == sizeof(T) || error("type sizes don't match")
    # the ptr may be invalid for empty arrays, which will cause an error as unsafe_wrap
    # checks the alignment of ptr, even for length 0
    if len > 0
        return unsafe_wrap(Array, ptr, div(len, sizeT))
    else
        return Array{T}(undef, 0)
    end
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
    API.MPI_Win_create_dynamic(Info(kwargs...), comm, win)
    finalizer(free, win)
    win.object = Set()
    return win
end

function Win_attach!(win::Win, base::AbstractArray{T}) where T
    # int MPI_Win_attach(MPI_Win win, void *base, MPI_Aint size)
    API.MPI_Win_attach(win, base, sizeof(base))
    push!(win.object, base)
end
function Win_detach!(win::Win, base::AbstractArray{T}) where T
    # int MPI_Win_detach(MPI_Win win, const void *base)
    API.MPI_Win_detach(win, base)
    delete!(win.object, base)
end

Win_fence(assert::Integer, win::Win) = API.MPI_Win_fence(assert, win)

function Win_fence(win::Win; nostore=false, noput=false, noprecede=false, nosucceed=false)
    assert =
        (nostore * API.MPI_MODE_NOSTORE[]) |
        (noput * API.MPI_MODE_NOPUT[]) |
        (noprecede * API.MPI_MODE_NOPRECEDE[]) |
        (nosucceed * API.MPI_MODE_NOSUCCEED[])
    Win_fence(assert, win)
end

"""
    Win_flush(win::Win; rank)

Completes all outstanding RMA operations initiated by the calling process to the
target rank on the specified window.

# External links
$(_doc_external("MPI_Win_flush"))
"""
Win_flush(win::Win; rank) = Win_flush(rank, win)
Win_flush(rank::Integer, win::Win) = API.MPI_Win_flush(rank, win)

Win_sync(win::Win) = API.MPI_Win_sync(win)

"""
    Win_lock_all(win::Win; nocheck=false)

Starts an RMA access epoch. The window can be
accessed by RMA operations at all processes on `win` during that epoch.
This operation is equivalent to a call to Win_lock(shared) for all processes
associted with the window.

If `nocheck=true`, no other process holds, or will attempt to acquire, a
conflicting lock, while the caller holds the window lock. This is useful when
mutual exclusion is achieved by other means, but the coherence operations that
may be attached to the lock and unlock calls are still required.

# External links
$(_doc_external("MPI_Win_lock_all"))
"""
function Win_lock_all(win::Win; nocheck::Bool = false)
    Win_lock_all(nocheck * API.MPI_MODE_NOCHECK[], win)
end
function Win_lock_all(assert::Integer, win::Win)
    # int MPI_Win_lock_all(int assert, MPI_Win win)
    API.MPI_Win_lock_all(assert, win)
end

"""
    Win_unlock_all(win::Win)

Completes an RMA access epoch started by a call to [`Win_lock_all`](@ref).

# External links
$(_doc_external("MPI_Win_unlock_all"))
"""
Win_unlock_all(win::Win) = Win_unlock_all(win)
Win_unlock_all(win::Win) = API.MPI_Win_unlock_all(win)

"""
    Win_lock(win::Win; rank::Integer, type=:exclusive/:shared, nocheck=false)

Starts an RMA access epoch. The window at the process with rank `rank` can be
accessed by RMA operations on `win` during that epoch.

Multiple RMA access epochs (with calls to `MPI.Win_lock`) can occur
simultaneously; however, each access epoch must target a different process.

Accesses that are protected by an exclusive lock (`type=:exclusive`) will not be
concurrent at the window site with other accesses to the same window that are
lock protected. Accesses that are protected by a shared lock (`type=:shared`)
will not be concurrent at the window site with accesses protected by an
exclusive lock to the same window.

If `nocheck=true`, no other process holds, or will attempt to acquire, a
conflicting lock, while the caller holds the window lock. This is useful when
mutual exclusion is achieved by other means, but the coherence operations that
may be attached to the lock and unlock calls are still required.

# External links
$(_doc_external("MPI_Win_lock"))
"""
function Win_lock(win::Win; rank::Integer, type::Union{Symbol,LockType}, nocheck::Bool = false)
    Win_lock(type isa Symbol ? LockType(type) : type, rank, nocheck * API.MPI_MODE_NOCHECK[], win)
end
function Win_lock(lock_type::LockType, rank::Integer, assert::Integer, win::Win)
    # int MPI_Win_lock(int lock_type, int rank, int assert, MPI_Win win)
    API.MPI_Win_lock(lock_type, rank, assert, win)
end

"""
    Win_unlock(win::Win; rank::Integer)

Completes an RMA access epoch started by a call to [`Win_lock`](@ref).

# External links
$(_doc_external("MPI_Win_unlock"))
"""
Win_unlock(win::Win; rank::Integer) = Win_unlock(rank, win)
Win_unlock(rank::Integer, win::Win) = API.MPI_Win_unlock(rank, win)


# TODO: add some sort of "remote buffer": a way to specify different datatypes/counts

"""
    Get!(origin, win::Win; rank::Integer, disp::Integer=0)

Copies data from the memory window `win` on the remote rank `rank`, with
displacement `disp`, into `origin` using remote memory access. `origin` can be a
[`Buffer`](@ref), or any object for which `Buffer(origin)` is defined.

# External links
$(_doc_external("MPI_Get"))
"""
Get!(origin, win::Win; rank::Integer, disp::Integer=0) =
    Get!(origin, rank, disp, win)
function Get!(origin_buf::Buffer, target_rank::Integer, target_disp::Integer, win::Win)
    # int MPI_Get(void *origin_addr, int origin_count,
    #             MPI_Datatype origin_datatype, int target_rank,
    #             MPI_Aint target_disp, int target_count,
    #             MPI_Datatype target_datatype, MPI_Win win)
    API.MPI_Get(origin_buf.data, origin_buf.count, origin_buf.datatype,
                target_rank, Cptrdiff_t(target_disp), origin_buf.count, origin_buf.datatype, win)
end
Get!(origin, target_rank::Integer, target_disp::Integer, win::Win) =
    Get!(Buffer(origin), target_rank, target_disp, win)
Get!(origin, target_rank::Integer, win::Win) =
    Get!(origin, target_rank, 0, win)

"""
    Put!(origin, win::Win; rank::Integer, disp::Integer=0)

Copies data from `origin` into memory window `win` on remote rank `rank` at
displacement `disp` using remote memory access. `origin` can be a
[`Buffer`](@ref), or any object for which [`Buffer_send(origin)`](@ref) is
defined.

# External links
$(_doc_external("MPI_Put"))
"""
Put!(origin, win::Win; rank::Integer, disp::Integer=0) =
    Put!(origin, rank, disp, win)
function Put!(origin_buf::Buffer, target_rank::Integer, target_disp::Integer, win::Win)
    # int MPI_Put(const void *origin_addr, int origin_count,
    #             MPI_Datatype origin_datatype, int target_rank,
    #             MPI_Aint target_disp, int target_count,
    #             MPI_Datatype target_datatype, MPI_Win win)
    API.MPI_Put(origin_buf.data, origin_buf.count, origin_buf.datatype,
                target_rank, Cptrdiff_t(target_disp), origin_buf.count, origin_buf.datatype, win)
end
Put!(origin, target_rank::Integer, target_disp::Integer, win::Win) =
    Put!(Buffer_send(origin), target_rank, target_disp, win)
Put!(origin, target_rank::Integer, win::Win) =
    Put!(origin, target_rank, 0, win)

Fetch_and_op!(source, returnval, op, win::Win; rank::Integer, disp::Integer=0) =
    Fetch_and_op!(source, returnval, rank, disp, op, win)
function Fetch_and_op!(sourceval::Ref{T}, returnval::Ref{T}, target_rank::Integer, target_disp::Integer, op::Op, win::Win) where {T}
    # int MPI_Fetch_and_op(const void *origin_addr, void *result_addr,
    #                      MPI_Datatype datatype, int target_rank, MPI_Aint target_disp,
    #                      MPI_Op op, MPI_Win win)
    API.MPI_Fetch_and_op(sourceval, returnval, Datatype(T), target_rank, target_disp, op, win)
end


"""
    Accumulate!(origin, op, win::Win; rank::Integer, disp::Integer=0)

Combine the content of the `origin` buffer into the target buffer (specified by `win` and
displacement `target_disp`) with reduction operator `op` on the remote rank
`target_rank` using remote memory access.

`origin` can be a [`Buffer`](@ref), or any object for which [`Buffer_send(origin)`](@ref) is defined.
`op` can be any predefined [`Op`](@ref) (custom operators are not supported).

# External links
$(_doc_external("MPI_Accumulate"))
"""
Accumulate!(origin, op, win::Win; rank::Integer, disp::Integer=0) =
    Accumulate!(origin, rank, disp, op, win)
function Accumulate!(origin_buf::Buffer, target_rank::Integer, target_disp::Integer, op::Op, win::Win)
    # int MPI_Accumulate(const void *origin_addr, int origin_count,
    #                    MPI_Datatype origin_datatype, int target_rank,
    #                    MPI_Aint target_disp, int target_count,
    #                    MPI_Datatype target_datatype, MPI_Op op, MPI_Win win)
    API.MPI_Accumulate(origin_buf.data, origin_buf.count, origin_buf.datatype,
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
Get_accumulate!(origin, result, op, win::Win; rank::Integer, disp::Integer=0) =
    Get_accumulate!(origin, result, rank, disp, op, win)
function Get_accumulate!(origin_buf::Buffer, result_buf::Buffer, target_rank::Integer, target_disp::Integer, op::Op, win::Win)
    # int MPI_Get_accumulate(const void *origin_addr, int origin_count,
    #                        MPI_Datatype origin_datatype, void *result_addr,
    #                        int result_count, MPI_Datatype result_datatype,
    #                        int target_rank, MPI_Aint target_disp, int target_count,
    #                        MPI_Datatype target_datatype, MPI_Op op, MPI_Win win)
    API.MPI_Get_accumulate(origin_buf.data, origin_buf.count, origin_buf.datatype,
                           result_buf.data, result_buf.count, result_buf.datatype,
                           target_rank, Cptrdiff_t(target_disp), origin_buf.count, origin_buf.datatype, op, win)
end
Get_accumulate!(origin, result, target_rank::Integer, target_disp::Integer, op::Op, win::Win) =
    Get_accumulate!(Buffer_send(origin), Buffer(result), target_rank, target_disp, op, win)
