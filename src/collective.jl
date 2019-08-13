import Base: eltype
const IN_PLACE = MPI_IN_PLACE

"""
    Barrier(comm::Comm)

Blocks until `comm` is synchronized.

If `comm` is an intracommunicator, then it blocks until all members of the group have called it.

If `comm` is an intercommunicator, then it blocks until all members of the other group have called it.
"""
function Barrier(comm::Comm)
    # int MPI_Barrier(MPI_Comm comm)
    @mpichk ccall((:MPI_Barrier, libmpi), Cint, (MPI_Comm,), comm)
end

"""
    Bcast!(buf[, count=length(buf)], root, comm::Comm)

Broadcast the first `count` elements of the buffer `buf` from `root` to all processes.
"""
function Bcast!(buffer, count::Integer,
                root::Integer, comm::Comm)

    # int MPI_Bcast(void* buffer, int count, MPI_Datatype datatype, int root,
    #               MPI_Comm comm)
    @mpichk ccall((:MPI_Bcast, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm),
                  buffer, count, mpitype(eltype(buffer)), root, comm)
    buffer
end

function Bcast!(buffer::AbstractArray{T}, root::Integer, comm::Comm) where T
    Bcast!(buffer, length(buffer), root, comm)
end

#=
function Bcast{T}(obj::T, root::Integer, comm::Comm)
    buf = [T]
    Bcast!(buf, root, comm)
    buf[1]
end
=#

function bcast(obj, root::Integer, comm::Comm)
    isroot = Comm_rank(comm) == root
    count = Array{Cint}(undef, 1)
    if isroot
        buf = MPI.serialize(obj)
        count[1] = length(buf)
    end
    Bcast!(count, root, comm)
    if !isroot
        buf = Array{UInt8}(undef, count[1])
    end
    Bcast!(buf, root, comm)
    if !isroot
        obj = MPI.deserialize(buf)
    end
    obj
end

"""
    Reduce!(sendbuf, recvbuf[, count=length(sendbuf)], op, root, comm)

Performs `op` reduction on the first `count` elements of the  buffer `sendbuf`
and stores the result in `recvbuf` on the process of rank `root`.

On non-root processes `recvbuf` is ignored.

To perform the reduction in place, see [`Reduce_in_place!`](@ref).

To handle allocation of the output buffer, see [`Reduce`](@ref).
"""
function Reduce!(sendbuf, recvbuf,
                 count::Integer, op::Union{Op,MPI_Op}, root::Integer,
                 comm::Comm)
    isroot = Comm_rank(comm) == root
    isroot && typeof(recvbuf) <: AbstractArray && @assert length(recvbuf) >= count
    # int MPI_Reduce(const void* sendbuf, void* recvbuf, int count,
    #                MPI_Datatype datatype, MPI_Op op, int root, MPI_Comm comm)
    @mpichk ccall((:MPI_Reduce, libmpi), Cint,
                  (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm),
                  sendbuf, recvbuf, count, mpitype(eltype(sendbuf)), op, root, comm)
    isroot ? recvbuf : nothing
end

# Convert user-provided functions to MPI.Op
Reduce!(sendbuf, recvbuf,
        count::Integer, opfunc, root::Integer, comm::Comm) =
    Reduce!(sendbuf, recvbuf, count, Op(opfunc, eltype(sendbuf)), root, comm)

function Reduce!(sendbuf::AbstractArray{T}, recvbuf::AbstractArray{T},
                 op, root::Integer, comm::Comm) where T
    Reduce!(sendbuf, recvbuf, length(sendbuf), op, root, comm)
end

"""
    Reduce(sendbuf, count, op, root, comm)

Performs `op` reduction on the buffer `sendbuf` and stores the result in
an output buffer allocated on the process of rank `root`. An empty array
will be returned on all other processes.

To specify the output buffer, see [`Reduce!`](@ref).

To perform the reduction in place, see [`Reduce_in_place!`](@ref).
"""
function Reduce(sendbuf, count::Integer,
                op, root::Integer, comm::Comm) where T
    isroot = Comm_rank(comm) == root
    recvbuf = similar(sendbuf, isroot ? count : 0)
    Reduce!(sendbuf, recvbuf, count, op, root, comm)
end

function Reduce(sendbuf::AbstractArray{T,N}, op,
                root::Integer, comm::Comm) where {T,N}
    isroot = Comm_rank(comm) == root
    recvbuf = similar(sendbuf, isroot ? size(sendbuf) : Tuple(zeros(Int, ndims(sendbuf))))
    Reduce!(sendbuf, recvbuf, length(sendbuf), op, root, comm)
end

function Reduce(object::T, op
                , root::Integer, comm::Comm) where T
    isroot = Comm_rank(comm) == root
    sendbuf = T[object]
    recvbuf = Reduce(sendbuf, op, root, comm)
    isroot ? recvbuf[1] : nothing
end

"""
    Reduce_in_place!(buf, count, op, root, comm)

Performs `op` reduction on the first `count` elements of the buffer `buf` and
stores the result on `buf` of the `root` process in the group.

This is equivalent to calling
```julia
if root == MPI.Comm_rank(comm)
    Reduce!(MPI.IN_PLACE, buf, count, root, comm)
else
    Reduce!(buf, C_NULL, count, root, comm)
end
```

To handle allocation of the output buffer, see [`Reduce`](@ref).

To specify a separate output buffer, see [`Reduce!`](@ref).
"""
function Reduce_in_place!(buf, count::Integer,
                          op::Union{Op,MPI_Op}, root::Integer,
                          comm::Comm)
    T = eltype(buf)
    if Comm_rank(comm) == root
        typeof(buf) <: AbstractArray && @assert length(buf) >= count
        @mpichk ccall((:MPI_Reduce, libmpi), Cint,
                      (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm),
                      MPI_IN_PLACE, buf, count, mpitype(T), op, root, comm)
    else
        @mpichk ccall((:MPI_Reduce, libmpi), Cint,
                      (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm),
                      buf, C_NULL, count, mpitype(T), op, root, comm)
    end
    buf
end

# Convert to MPI.Op
Reduce_in_place!(buf, count::Integer, op,
                 root::Integer, comm::Comm) =
                    Reduce_in_place!(buf, count, Op(op,eltype(buf)), root, comm)

"""
    Allreduce!(sendbuf, recvbuf[, count=length(sendbuf)], op, comm)

Performs `op` reduction on the first `count` elements of the buffer
`sendbuf` storing the result in the `recvbuf` of all processes in the
group.

All-reduce is equivalent to a [`Reduce!`](@ref) operation followed by
a [`Bcast!`](@ref), but can lead to better performance.

If `sendbuf==MPI.IN_PLACE` the data is read from `recvbuf` and then overwritten
with the results.

To handle allocation of the output buffer, see [`Allreduce`](@ref).
"""
function Allreduce!(sendbuf, recvbuf,
                   count::Integer, op::Union{Op,MPI_Op}, comm::Comm)
    typeof(recvbuf) <: AbstractArray && @assert length(recvbuf) >= count
    sendbuf == MPI.IN_PLACE || @assert eltype(sendbuf) == eltype(recvbuf)
    T = eltype(recvbuf)
    # int MPI_Allreduce(const void* sendbuf, void* recvbuf, int count,
    #                   MPI_Datatype datatype, MPI_Op op, MPI_Comm comm)
    @mpichk ccall((:MPI_Allreduce, libmpi), Cint,
                  (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm),
                  sendbuf, recvbuf, count, mpitype(T), op, comm)
    recvbuf
end

# Convert user-provided functions to MPI.Op
Allreduce!(sendbuf, recvbuf,
           count::Integer, opfunc, comm::Comm) =
    Allreduce!(sendbuf, recvbuf, count, Op(opfunc, eltype(recvbuf)), comm)

function Allreduce!(sendbuf, recvbuf::AbstractArray{T},
                   op, comm::Comm) where T
    Allreduce!(sendbuf, recvbuf, length(recvbuf), op, comm)
end

"""
    Allreduce!(buf, op, comm)

Performs `op` reduction in place on the buffer `sendbuf`, overwriting it with
the results on all the processes in the group.

Equivalent to calling `Allreduce!(MPI.IN_PLACE, buf, op, comm)`
"""
function Allreduce!(buf::AbstractArray{T}, op, comm::Comm) where T
    Allreduce!(MPI.IN_PLACE, buf, length(buf), op, comm)
end

"""
    Allreduce(sendbuf, op, comm)

Performs `op` reduction on the buffer `sendbuf`, allocating and returning the
output buffer in all processes of the group.

To specify the output buffer or perform the operation in pace, see [`Allreduce!`](@ref).
"""
function Allreduce(sendbuf::AbstractArray{T, N}, op, comm::Comm) where {T, N}
    recvbuf = similar(sendbuf, size(sendbuf))
    Allreduce!(sendbuf, recvbuf, length(sendbuf), op, comm)
end

function Allreduce(obj::T, op, comm::Comm) where T
    objref = Ref(obj)
    outref = Ref{T}()
    Allreduce!(objref, outref, 1, op, comm)

    outref[]
end


"""
    Scatter!(sendbuf, recvbuf, count, root, comm)

Splits the buffer `sendbuf` in the `root` process into `Comm_size(comm)` chunks
and sends the j-th chunk to the process of rank j into the `recvbuf` buffer,
which must be of length at least `count`.

`count` should be the same for all processes. If the number of elements varies between
processes, use [`Scatter!`](@ref) instead.

To perform the reduction in place, see [`Scatter_in_place!`](@ref).

To handle allocation of the output buffer, see [`Scatter`](@ref).
"""
function Scatter!(sendbuf, recvbuf,
                  count::Integer, root::Integer,
                  comm::Comm)
    typeof(recvbuf) <: AbstractArray && @assert length(recvbuf) >= count
    isroot = Comm_rank(comm) == root
    isroot && typeof(sendbuf) <: AbstractArray && @assert length(sendbuf) >= count*Comm_size(comm)
    @assert eltype(sendbuf) == eltype(recvbuf)
    T = eltype(recvbuf)

    # int MPI_Scatter(const void* sendbuf, int sendcount, MPI_Datatype sendtype,
    #                 void* recvbuf, int recvcount, MPI_Datatype recvtype, int root,
    #                 MPI_Comm comm)
    @mpichk ccall((:MPI_Scatter, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm),
                  sendbuf, count, mpitype(T), recvbuf, count, mpitype(T), root, comm)
    recvbuf
end

"""
    Scatter_in_place!(buf, count, root, comm)

Splits the buffer `buf` in the `root` process into `Comm_size(comm)` chunks
and sends the j-th chunk to the process of rank j. No data is sent to the `root`
process.

This is functionally equivalent to calling
```
if root == MPI.Comm_rank(comm)
    Scatter!(buf, MPI.IN_PLACE, count, root, comm)
else
    Scatter!(C_NULL, buf, count, root, comm)
end
```

To specify a separate output buffer, see [`Scatter!`](@ref).

To handle allocation of the output buffer, see [`Scatter`](@ref).
"""
function Scatter_in_place!(buf,
                  count::Integer, root::Integer,
                  comm::Comm)
    T = eltype(buf)
    if Comm_rank(comm) == root
        @mpichk ccall((:MPI_Scatter, libmpi), Cint,
                      (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm),
                      buf, count, mpitype(T), MPI_IN_PLACE, count, mpitype(T), root, comm)
    else
        @mpichk ccall((:MPI_Scatter, libmpi), Cint,
                      (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm),
                      C_NULL, count, mpitype(T), buf, count, mpitype(T), root, comm)
    end
    buf
end

"""
    Scatter(sendbuf, count, root, comm)

Splits the buffer `sendbuf` in the `root` process into `Comm_size(comm)` chunks
and sends the j-th chunk to the process of rank j, allocating the output buffer.
"""
function Scatter(sendbuf, count::Integer, root::Integer,
                 comm::Comm) where T
    recvbuf = similar(sendbuf, count)
    Scatter!(sendbuf, recvbuf, count, root, comm)
end

"""
    Scatterv!(sendbuf, recvbuf, counts, root, comm)

Splits the buffer `sendbuf` in the `root` process into `Comm_size(comm)` chunks
of length `counts[j]` and sends the j-th chunk to the process of rank j into the
`recvbuf` buffer, which must be of length at least `count`.

To perform the reduction in place refer to [`Scatterv_in_place!`](@ref).
"""
function Scatterv!(sendbuf, recvbuf,
                  counts::Vector{Cint}, root::Integer, comm::Comm)
    @assert eltype(sendbuf) == eltype(recvbuf)
    T = eltype(recvbuf)
    recvcnt = counts[Comm_rank(comm) + 1]
    disps = accumulate(+, counts) - counts
    typeof(recvbuf) <: AbstractArray && @assert length(recvbuf) >= recvcnt
    # int MPI_Scatterv(const void* sendbuf, const int sendcounts[],
    #                  const int displs[], MPI_Datatype sendtype, void* recvbuf,
    #                  int recvcount, MPI_Datatype recvtype, int root, MPI_Comm comm)
    @mpichk ccall((:MPI_Scatterv, libmpi), Cint,
                  (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm),
                  sendbuf, counts, disps, mpitype(T), recvbuf, recvcnt, mpitype(T), root, comm)
    recvbuf
end

"""
    Scatterv(sendbuf, counts, root, comm)

Splits the buffer `sendbuf` in the `root` process into `Comm_size(comm)` chunks
of length `counts[j]` and sends the j-th chunk to the process of rank j, which
allocates the output buffer
"""
function Scatterv(sendbuf, counts::Vector{Cint},
                   root::Integer, comm::Comm)
    recvbuf = similar(sendbuf, counts[Comm_rank(comm) + 1])
    Scatterv!(sendbuf, recvbuf, counts, root, comm)
end

"""
    Scatterv_in_place(buf, counts, root, comm)

Splits the buffer `buf` in the `root` process into `Comm_size(comm)` chunks
of length `counts[j]` and sends the j-th chunk to the process of rank j into the
`buf` buffer, which must be of length at least `count`. The `root` process sends
nothing to itself.

This is functionally equivalent to calling
```
if root == MPI.Comm_rank(comm)
    Scatterv!(buf, MPI.IN_PLACE, counts, root, comm)
else
    Scatterv!(C_NULL, buf, counts, root, comm)
end
```
"""
function Scatterv_in_place!(buf, counts::Vector{Cint},
                           root::Integer, comm::Comm)
    T = eltype(buf)
    recvcnt = counts[Comm_rank(comm) + 1]
    disps = accumulate(+, counts) - counts
    typeof(buf) <: AbstractArray && @assert length(buf) >= recvcnt

    if Comm_rank(comm) == root
        @mpichk ccall((:MPI_Scatterv, libmpi), Cint,
                      (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm),
                      buf, counts, disps, mpitype(T), MPI_IN_PLACE, recvcnt, mpitype(T), root, comm)
    else
        @mpichk ccall((:MPI_Scatterv, libmpi), Cint,
                      (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm),
                      C_NULL, counts, disps, mpitype(T), buf, recvcnt, mpitype(T), root, comm)
    end
    buf
end

"""
    Gather!(sendbuf, recvbuf, count, root, comm)

Each process sends the first `count` elements of the buffer `sendbuf` to the
`root` process. The `root` process stores elements in rank order in the buffer
buffer `recvbuf`.

`count` should be the same for all processes. If the number of elements varies between
processes, use [`Gatherv!`](@ref) instead.

To perform the reduction in place refer to [`Gather_in_place!`](@ref).
"""
function Gather!(sendbuf, recvbuf,
                count::Integer, root::Integer, comm::Comm)
    @assert eltype(sendbuf) == eltype(recvbuf)
    T = eltype(recvbuf)
    typeof(sendbuf) <: AbstractArray && @assert length(sendbuf) >= count
    isroot = Comm_rank(comm) == root
    isroot && typeof(recvbuf) <: AbstractArray && @assert length(recvbuf) >= count*Comm_size(comm)

    # int MPI_Gather(const void* sendbuf, int sendcount, MPI_Datatype sendtype,
    #                void* recvbuf, int recvcount, MPI_Datatype recvtype, int root,
    #                MPI_Comm comm)
    @mpichk ccall((:MPI_Gather, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm),
                  sendbuf, count, mpitype(T), recvbuf, count, mpitype(T), root, comm)
    isroot ? recvbuf : nothing
end

"""
    Gather(sendbuf[, count=length(sendbuf)], root, comm)

Each process sends the first `count` elements of the buffer `sendbuf` to the
`root` process. The `root` allocates the output buffer and stores elements in
rank order.
"""
function Gather(sendbuf, count::Integer,
                root::Integer, comm::Comm) where T
    isroot = Comm_rank(comm) == root
    recvbuf = similar(sendbuf, isroot ? Comm_size(comm) * count : 0)
    Gather!(sendbuf, recvbuf, count, root, comm)
end

function Gather(sendbuf::AbstractArray{T}, root::Integer, comm::Comm) where T
    isroot = Comm_rank(comm) == root
    recvbuf = similar(sendbuf, isroot ? Comm_size(comm) * length(sendbuf) : 0)
    Gather!(sendbuf, recvbuf, length(sendbuf), root, comm)
end

function Gather(object::T, root::Integer, comm::Comm) where T
    isroot = Comm_rank(comm) == root
    sendbuf = T[object]
    recvbuf = Gather(sendbuf, root, comm)
    isroot ? recvbuf : nothing
end

"""
    Gather_in_place!(buf, count, root, comm)

Each process sends the first `count` elements of the buffer `buf` to the
`root` process. The `root` process stores elements in rank order in the buffer
buffer `buf`, sending no data to itself.

This is functionally equivalent to calling
```
if root == MPI.Comm_rank(comm)
    Gather!(MPI.IN_PLACE, buf, count, root, comm)
else
    Gather!(buf, C_NULL, count, root, comm)
end
```
"""
function Gather_in_place!(buf, count::Integer, root::Integer,
                          comm::Comm)
    T = eltype(buf)
    if Comm_rank(comm) == root
        typeof(buf) <: AbstractArray && @assert length(buf) >= count*Comm_size(comm)
        @mpichk ccall((:MPI_Gather, libmpi), Cint,
                      (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm),
                      MPI_IN_PLACE, count, mpitype(T), buf, count, mpitype(T), root, comm)
    else
        @mpichk ccall((:MPI_Gather, libmpi), Cint,
                      (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm),
                      buf, count, mpitype(T), C_NULL, count, mpitype(T), root, comm)
    end
    buf
end

"""
    Allgather!(sendbuf, recvbuf, count, comm)

Each process sends the first `count` elements of `sendbuf` to the
other processes, who store the results in rank order into
`recvbuf`.

If `sendbuf==MPI.IN_PLACE` the input data is assumed to be in the
area of `recvbuf` where the process would receive it's own
contribution.
"""
function Allgather!(sendbuf, recvbuf,
                    count::Integer, comm::Comm)
    sendbuf == MPI.IN_PLACE || @assert eltype(sendbuf) == eltype(recvbuf)
    T = eltype(recvbuf)
    typeof(recvbuf) <: AbstractArray && @assert length(recvbuf) >= Comm_size(comm)*count
    # int MPI_Allgather(const void* sendbuf, int sendcount,
    #                   MPI_Datatype sendtype, void* recvbuf, int recvcount,
    #                   MPI_Datatype recvtype, MPI_Comm comm)
    @mpichk ccall((:MPI_Allgather, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm),
                  sendbuf, count, mpitype(T), recvbuf, count, mpitype(T), comm)
    recvbuf
end

"""
    Allgather!(buf, count, comm)

Equivalent to `Allgather!(MPI.IN_PLACE, buf, count, comm)`.
"""
function Allgather!(buf, count::Integer,
                   comm::Comm)
    Allgather!(MPI.IN_PLACE, buf, count, comm)
end

"""
    Allgather(sendbuf[, count=length(sendbuf)], comm)

Each process sends the first `count` elements of `sendbuf` to the
other processes, who store the results in rank order allocating
the output buffer.
"""
function Allgather(sendbuf, count::Integer, comm::Comm)
    recvbuf = similar(sendbuf, Comm_size(comm) * count)
    Allgather!(sendbuf, recvbuf, count, comm)
end
function Allgather(sendbuf::AbstractArray, comm::Comm)
    Allgather(sendbuf, length(sendbuf), comm)
end

function Allgather(object::T, comm::Comm) where T
    sendbuf = T[object]
    recvbuf = Allgather(sendbuf, comm)
    recvbuf
end

"""
    Gatherv!(sendbuf, recvbuf, counts, root, comm)

Each process sends the first `counts[rank]` elements of the buffer `sendbuf` to
the `root` process. The `root` stores elements in rank order in the buffer
`recvbuf`.

To perform the reduction in place refer to [`Gatherv_in_place!`](@ref).
"""
function Gatherv!(sendbuf, recvbuf,
                  counts::Vector{Cint}, root::Integer, comm::Comm)
    @assert eltype(sendbuf) == eltype(recvbuf)
    T = eltype(recvbuf)
    isroot = Comm_rank(comm) == root
    displs = accumulate(+, counts) - counts
    sendcnt = counts[Comm_rank(comm) + 1]
    isroot && typeof(recvbuf) <: AbstractArray && @assert length(recvbuf) >= sum(counts)
    # int MPI_Gatherv(const void* sendbuf, int sendcount, MPI_Datatype sendtype,
    #                 void* recvbuf, const int recvcounts[], const int displs[],
    #                 MPI_Datatype recvtype, int root, MPI_Comm comm)
    @mpichk ccall((:MPI_Gatherv, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm),
                  sendbuf, sendcnt, mpitype(T), recvbuf, counts, displs, mpitype(T), root, comm)
    isroot ? recvbuf : nothing
end

"""
    Gatherv(sendbuf, counts, root, comm)

Each process sends the first `counts[rank]` elements of the buffer `sendbuf` to
the `root` process. The `root` allocates the output buffer and stores elements
in rank order.
"""
function Gatherv(sendbuf, counts::Vector{Cint},
                 root::Integer, comm::Comm)
    isroot = Comm_rank(comm) == root
    recvbuf = similar(sendbuf, isroot ? sum(counts) : 0)
    Gatherv!(sendbuf, recvbuf, counts, root, comm)
end

function Gatherv(sendbuf::AbstractArray{T}, counts::Vector{Cint},
                 root::Integer, comm::Comm) where T
    isroot = Comm_rank(comm) == root
    recvbuf = similar(sendbuf, isroot ? sum(counts) : 0)
    Gatherv!(sendbuf, recvbuf, counts, root, comm)
end

"""
    Gatherv_in_place!(buf, counts, root, comm)

Each process sends the first `counts[rank]` elements of the buffer `buf` to
the `root` process. The `root` allocates the output buffer and stores elements
in rank order.

This is functionally equivalent to calling
```
if root == MPI.Comm_rank(comm)
    Gatherv!(MPI.IN_PLACE, buf, counts, root, comm)
else
    Gatherv!(buf, C_NULL, counts, root, comm)
end
```
"""
function Gatherv_in_place!(buf, counts::Vector{Cint},
                           root::Integer, comm::Comm)
    T = eltype(buf)
    isroot = Comm_rank(comm) == root
    displs = accumulate(+, counts) - counts
    sendcnt = counts[Comm_rank(comm) + 1]

    if isroot
        typeof(buf) <: AbstractArray && @assert length(buf) >= sum(counts)
        @mpichk ccall((:MPI_Gatherv, libmpi), Cint,
                      (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm),
                      MPI_IN_PLACE, sendcnt, mpitype(T), buf, counts, displs, mpitype(T), root, comm)
    else
        @mpichk ccall((:MPI_Gatherv, libmpi), Cint,
                      (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm),
                      buf, sendcnt, mpitype(T), C_NULL, counts, displs, mpitype(T), root, comm)
    end
    buf
end


"""
    Allgatherv!(sendbuf, recvbuf, counts, comm)

Each process sends the first `counts[rank]` elements of the buffer `sendbuf` to
all other process. Each process stores the received data in rank order in the
buffer `recvbuf`.

if `sendbuf==MPI.IN_PLACE` every process takes the data to be sent is taken from
the interval of `recvbuf` where it would store it's own data.
"""
function Allgatherv!(sendbuf, recvbuf,
	                     counts::Vector{Cint}, comm::Comm)
    typeof(recvbuf) <: AbstractArray && @assert length(recvbuf) >= sum(counts)
    sendbuf == MPI.IN_PLACE || @assert eltype(sendbuf) == eltype(recvbuf)
    T = eltype(recvbuf)
    displs = accumulate(+, counts) - counts
    sendcnt = counts[Comm_rank(comm) + 1]
    # int MPI_Allgatherv(const void* sendbuf, int sendcount,
    #                    MPI_Datatype sendtype, void* recvbuf, const int recvcounts[],
    #                    const int displs[], MPI_Datatype recvtype, MPI_Comm comm)
    @mpichk ccall((:MPI_Allgatherv, libmpi), Cint,
              (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm),
              sendbuf, sendcnt, mpitype(T), recvbuf, counts, displs, mpitype(T), comm)
    recvbuf
end

"""
    Allgatherv(sendbuf, counts, comm)

Each process sends the first `counts[rank]` elements of the buffer `sendbuf` to
all other process. Each process allocates an output buffer and stores the
received data in rank order.
"""
function Allgatherv(sendbuf, counts::Vector{Cint},
                    comm::Comm)
    recvbuf = similar(sendbuf, sum(counts))
    Allgatherv!(sendbuf, recvbuf, counts, comm)
end

"""
    Alltoall!(sendbuf, recvbuf, count, comm)

Every process divides the buffer `sendbuf` into `Comm_size(comm)` chunks of
length `count`, sending the `j`-th chunk to the `j`-th process.
Every process stores the data received from the `j`-th process in the `j`-th
chunk of the buffer `recvbuf`.

```
rank    send buf                        recv buf
----    --------                        --------
 0      a,b,c,d,e,f       Alltoall      a,b,A,B,α,β
 1      A,B,C,D,E,F  ---------------->  c,d,C,D,γ,ψ
 2      α,β,γ,ψ,η,ν                     e,f,E,F,η,ν
```

If `sendbuf==MPI.IN_PLACE`, data is sent from the `recvbuf` and then
overwritten.
"""
function Alltoall!(sendbuf, recvbuf,
                   count::Integer, comm::Comm)
    sendbuf == MPI.IN_PLACE || @assert eltype(sendbuf) == eltype(recvbuf)
    T = eltype(recvbuf)
    # int MPI_Alltoall(const void* sendbuf, int sendcount, MPI_Datatype sendtype,
    #                  void* recvbuf, int recvcount, MPI_Datatype recvtype,
    #                  MPI_Comm comm)
    @mpichk ccall((:MPI_Alltoall, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm),
                  sendbuf, count, mpitype(T), recvbuf, count, mpitype(T), comm)
    recvbuf
end

"""
    Alltoall(sendbuf, count, comm)

Every process divides the buffer `sendbuf` into `Comm_size(comm)` chunks of
length `count`, sending the `j`-th chunk to the `j`-th process.
Every process allocates the output buffer and stores the data received from the
`j`-th process in the `j`-th chunk.

```
rank    send buf                        recv buf
----    --------                        --------
 0      a,b,c,d,e,f       Alltoall      a,b,A,B,α,β
 1      A,B,C,D,E,F  ---------------->  c,d,C,D,γ,ψ
 2      α,β,γ,ψ,η,ν                     e,f,E,F,η,ν
```
"""
function Alltoall(sendbuf, count::Integer,
                  comm::Comm)
    recvbuf = similar(sendbuf, Comm_size(comm)*count)
    Alltoall!(sendbuf, recvbuf, count, comm)
end

"""
    Alltoallv!(sendbuf::T, recvbuf::T, scounts, rcounts, comm)

`MPI.IN_PLACE` is not supported for this operation.
"""
function Alltoallv!(sendbuf, recvbuf,
                   scounts::Vector{Cint}, rcounts::Vector{Cint},
                   comm::Comm)
    typeof(recvbuf) <: AbstractArray && @assert length(recvbuf) == sum(rcounts)
    @assert eltype(sendbuf) == eltype(recvbuf)
    T = eltype(sendbuf)

    sdispls = accumulate(+, scounts) - scounts
    rdispls = accumulate(+, rcounts) - rcounts
    # int MPI_Alltoallv(const void* sendbuf, const int sendcounts[],
    #                   const int sdispls[], MPI_Datatype sendtype, void* recvbuf,
    #                   const int recvcounts[], const int rdispls[],
    #                   MPI_Datatype recvtype, MPI_Comm comm)
    @mpichk ccall((:MPI_Alltoallv, libmpi), Cint,
                  (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm),
                  sendbuf, scounts, sdispls, mpitype(T), recvbuf, rcounts, rdispls, mpitype(T), comm)
    recvbuf
end

function Alltoallv(sendbuf, scounts::Vector{Cint},
                   rcounts::Vector{Cint}, comm::Comm)
    recvbuf = similar(sendbuf, sum(rcounts))
    Alltoallv!(sendbuf, recvbuf, scounts, rcounts, comm)
end


function Scan(sendbuf, count::Integer,
              op::Union{Op,MPI_Op}, comm::Comm)
    T = eltype(sendbuf)
    recvbuf = similar(sendbuf, count)
    # int MPI_Scan(const void* sendbuf, void* recvbuf, int count,
    #              MPI_Datatype datatype, MPI_Op op, MPI_Comm comm)
    @mpichk ccall((:MPI_Scan, libmpi), Cint,
                  (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm),
                  sendbuf, recvbuf, count, mpitype(T), op, comm)
    recvbuf
end


function Scan!(sendbuf, recvbuf, count::Integer,
               op::Union{Op,MPI_Op}, comm::Comm)
    T = eltype(sendbuf)
    # int MPI_Scan(const void* sendbuf, void* recvbuf, int count,
    #              MPI_Datatype datatype, MPI_Op op, MPI_Comm comm)
    @mpichk ccall((:MPI_Scan, libmpi), Cint,
                  (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm),
                  sendbuf, recvbuf, count, mpitype(T), op, comm)
    recvbuf
end
function Scan!(sendbuf, recvbuf, count::Integer, opfunc, comm::Comm)
    Scan!(sendbuf, recvbuf, count, Op(opfunc, eltype(sendbuf)), comm)
end
function Scan!(sendbuf::AbstractArray, recvbuf, op, comm::Comm)
    Scan!(sendbuf, recvbuf, length(sendbuf), op, comm)
end

function Scan(sendbuf, count::Integer, op, comm::Comm)
    Scan!(sendbuf, similar(sendbuf, count), count, op, comm)
end

function Scan(sendbuf::AbstractArray, op, comm::Comm)
    Scan(sendbuf, length(sendbuf), op, comm)
end
function Scan(object::T, op, comm::Comm) where T
    sendbuf = T[object]
    Scan(sendbuf,1,op,comm)
end

function Exscan!(sendbuf, recvbuf, count::Integer,
                op::Union{Op,MPI_Op}, comm::Comm)
    T = eltype(sendbuf)
    # int MPI_Exscan(const void* sendbuf, void* recvbuf, int count,
    #                MPI_Datatype datatype, MPI_Op op, MPI_Comm comm)
    @mpichk ccall((:MPI_Exscan, libmpi), Cint,
          (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm),
          sendbuf, recvbuf, count, mpitype(T), op, comm)
    recvbuf
end
function Exscan!(sendbuf, recvbuf, count::Integer, opfunc, comm::Comm)
    Exscan!(sendbuf, recvbuf, count, Op(opfunc, eltype(sendbuf)), comm)
end
function Exscan!(sendbuf::AbstractArray, recvbuf, op, comm::Comm)
    Exscan!(sendbuf, recvbuf, length(sendbuf), op, comm)
end

function Exscan(sendbuf, count::Integer, op, comm::Comm)
    Exscan!(sendbuf, similar(sendbuf, count), count, op, comm)
end

function Exscan(sendbuf::AbstractArray, op, comm::Comm)
    Exscan(sendbuf, length(sendbuf), op, comm)
end
function Exscan(object::T, op, comm::Comm) where T
    sendbuf = T[object]
    Exscan(sendbuf,1,op,comm)
end
