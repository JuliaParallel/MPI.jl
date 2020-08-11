"""
    Barrier(comm::Comm)

Blocks until `comm` is synchronized.

If `comm` is an intracommunicator, then it blocks until all members of the group have called it.

If `comm` is an intercommunicator, then it blocks until all members of the other group have called it.

# External links
$(_doc_external("MPI_Barrier"))
"""
function Barrier(comm::Comm)
    # int MPI_Barrier(MPI_Comm comm)
    @mpichk ccall((:MPI_Barrier, libmpi), Cint, (MPI_Comm,), comm)
    return nothing
end

"""
    Bcast!(buf[, count=length(buf)], root::Integer, comm::Comm)

Broadcast the first `count` elements of the buffer `buf` from `root` to all processes.

# External links
$(_doc_external("MPI_Bcast"))
"""
function Bcast!(buf::Buffer, root::Integer, comm::Comm)
    # int MPI_Bcast(void* buffer, int count, MPI_Datatype datatype, int root,
    #               MPI_Comm comm)
    @mpichk ccall((:MPI_Bcast, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm),
                  buf.data, buf.count, buf.datatype, root, comm)
    buf.data
end
function Bcast!(data, root::Integer, comm::Comm)
    Bcast!(Buffer(data), root, comm)
end

function bcast(obj, root::Integer, comm::Comm)
    isroot = Comm_rank(comm) == root
    count = Ref{Cint}()
    if isroot
        buf = MPI.serialize(obj)
        count[] = length()
    end
    Bcast!(count, root, comm)
    if !isroot
        buf = Array{UInt8}(undef, count[])
    end
    Bcast!(buf, root, comm)
    if !isroot
        obj = MPI.deserialize(buf)
    end
    obj
end

"""
    Scatter!(sendbuf, recvbuf, root::Integer, comm::Comm)

Splits the buffer `sendbuf` in the `root` process into `Comm_size(comm)` chunks,
sending the `j`-th chunk to the process of rank `j` into the `recvbuf` buffer.

`sendbuf` on the root process should be a [`MultiBuffer`](@ref), or an `Array` if the
`count` can be determined from `recvbuf`. On non-root processes it is ignored, and can be
`nothing`.

`recvbuf` is a [`Buffer`](@ref) object, or any object for which `Buffer(recvbuf)` is
defined. On the root process, it can also be `nothing`, in which case it is ignored (this
corresponds the behaviour of `MPI_IN_PLACE` in `MPI_Scatter`). For example
```
if root == MPI.Comm_rank(comm)
    Scatter!(MultiBuffer(buf, count), nothing, root, comm)
else
    Scatter!(nothing, buf, root, comm)        
end
```

# See also
- [`Scatter`](@ref) to allocate the output buffer.
- [`Scatterv!`](@ref) if the number of elements varies between processes.

# External links
$(_doc_external("MPI_Scatter"))
"""
function Scatter!(sendbuf::MultiBuffer, recvbuf::Buffer, root::Integer, comm::Comm)
    if sendbuf.nchunks !== nothing && Comm_rank(comm) == root
        @assert sendbuf.nchunks >= Comm_size(comm)
    end
    # int MPI_Scatter(const void* sendbuf, int sendcount, MPI_Datatype sendtype,
    #                 void* recvbuf, int recvcount, MPI_Datatype recvtype, int root,
    #                 MPI_Comm comm)
    @mpichk ccall((:MPI_Scatter, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype,
                   MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm),
                  sendbuf.data, sendbuf.count, sendbuf.datatype,
                  recvbuf.data, recvbuf.count, recvbuf.datatype, root, comm)
    recvbuf.data
end
Scatter!(sendbuf::MultiBuffer, recvbuf, root::Integer comm::Comm) =
    Scatter!(sendbuf, Buffer(recvbuf), root, comm)
Scatter!(sendbuf::AbstractArray, recvbuf::Union{Ref,AbstractArray}, root::Integer, comm::Comm) =
    Scatter!(MultiBuffer(sendbuf,length(recvbuf)), recvbuf, root, comm)    
Scatter!(sendbuf::Nothing, recvbuf, root::Integer, comm::Comm) =
    Scatter!(MultiBuffer(), recvbuf, root, comm)
Scatter!(sendbuf::MultiBuffer, recvbuf::Nothing, root::Integer, comm::Comm) =
    Scatter!(sendbuf, IN_PLACE, root, comm)


"""
    Scatterv!(sendbuf, recvbuf, counts, root, comm)

Splits the buffer `sendbuf` in the `root` process into `Comm_size(comm)` chunks
of length `counts[j]` and sends the j-th chunk to the process of rank j into the
`recvbuf` buffer, which must be of length at least `count`.

`recvbuf` can be `nothing` on the root process, in which case it is unmodified (this
corresponds the behaviour of `MPI_IN_PLACE` in `MPI_Scatterv`). For example
```
if root == MPI.Comm_rank(comm)
    Scatterv!(buf, nothing, counts, root, comm)
else
    Scatterv!(nothing, buf, counts, root, comm)
end
```

# See also
- [`Scatterv`](@ref) for the allocating operation
- [`Scatter!`](@ref)/[`Scatter`](@ref) if the counts are the same for all processes

# External links
$(_doc_external("MPI_Scatterv"))
"""
function Scatterv!(sendbuf::VMultiBuffer, recvbuf::Buffer, root::Integer, comm::Comm)
    if Comm_rank(comm) == root
        @assert length(sendbuf.counts) >= Comm_size(comm)
    end
    # int MPI_Scatterv(const void* sendbuf, const int sendcounts[],
    #                  const int displs[], MPI_Datatype sendtype, void* recvbuf,
    #                  int recvcount, MPI_Datatype recvtype, int root, MPI_Comm comm)
    @mpichk ccall((:MPI_Scatterv, libmpi), Cint,
                  (MPIPtr, Ptr{Cint}, Ptr{Cint},  MPI_Datatype,
                   MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm),
                  sendbuf.data, sendbuf.counts, sendbuf.displs, sendbuf.datatype,
                  recvbuf.data, recvbuf.count, recvbuf.datatype, root, comm)
    recvbuf
end
Scatterv!(sendbuf::VMultiBuffer, recvbuf, root::Integer, comm::Comm) =
    Scatterv!(sendbuf, Buffer(recvbuf), root, comm)
Scatterv!(sendbuf::VMultiBuffer, recvbuf::Nothing, root::Integer, comm::Comm) =
    Scatterv!(sendbuf, IN_PLACE, root, comm)
Scatterv!(sendbuf::Nothing, recvbuf, root::Integer, comm::Comm) =
    Scatterv!(VMultiBuffer(), recvbuf, root, comm)


"""
    Gather!(sendbuf, recvbuf, root::Integer, comm::Comm)

Each process sends the contents of the buffer `sendbuf` to the `root` process. The `root`
process stores elements in rank order in the buffer buffer `recvbuf`.

`sendbuf` can be `nothing` on the root process, in which case the corresponding entries in
`recvbuf` are assumed to be already in place (this corresponds the behaviour of
`MPI_IN_PLACE` in `MPI_Gather`). For example
```
if root == MPI.Comm_rank(comm)
    Gather!(nothing, buf, count, root, comm)
else
    Gather!(buf, nothing, count, root, comm)
end
```

`recvbuf` on the root process should be a buffer of length `count*Comm_size(comm)`, and
on non-root processes it is ignored and can be `nothing`.

`count` should be the same for all processes.

# See also
- [`Gather`](@ref) for the allocating operation.
- [`Gatherv!`](@ref) if the number of elements varies between processes.
- [`Allgather!`](@ref) to send the result to all processes.

# External links
$(_doc_external("MPI_Gather"))
"""
function Gather!(sendbuf::Buffer, recvbuf::MultiBuffer, root::Integer, comm::Comm)
    if recvbuf.nchunks !== nothing && Comm_rank(comm) == root
        @assert recvbuf.nchunks >= Comm_size(comm)
    end
    # int MPI_Gather(const void* sendbuf, int sendcount, MPI_Datatype sendtype,
    #                void* recvbuf, int recvcount, MPI_Datatype recvtype, int root,
    #                MPI_Comm comm)
    @mpichk ccall((:MPI_Gather, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm),
                  sendbuf.data, sendbuf.count, sendbuf.datatype,
                  recvbuf.data, recvbuf.count, recvbuf.datatype, root, comm)
    recvbuf.data
end
Gather!(sendbuf, recvbuf::MultiBuffer, root::Integer, comm::Comm) =
    Gather!(Buffer(sendbuf), recvbuf, root, comm)
Gather!(sendbuf::Union{Ref,AbstractArray}, recvbuf::AbstractArray, root::Integer, comm::Comm) =
    Gather!(sendbuf, MultiBuffer(recvbuf, length(sendbuf)), root, comm)
Gather!(sendbuf, recvbuf::Nothing, root::Integer, comm::Comm) =
    Gather!(sendbuf, MultiBuffer(), root, comm)
Gather!(sendbuf::Nothing, recvbuf, root::Integer, comm::Comm) =
    Gather!(IN_PLACE, recvbuf, root, comm)



"""
    Gather(sendbuf, root, comm)

Each process sends the contents of the buffer `sendbuf` to the `root` process. The `root`
allocates the output buffer and stores elements in rank order.

`count` should be the same for all processes.

# See also
- [`Gather!`](@ref) for the mutating operation.
- [`Gatherv!`](@ref)/[`Gatherv`](@ref) if the number of elements varies between processes.
- [`Allgather!`](@ref)/[`Allgather`](@ref) to send the result to all processes.

# External links
$(_doc_external("MPI_Gather"))
"""
function Gather(sendbuf::Union{Ref,AbstractArray}, root::Integer, comm::Comm)
    Gather!(sendbuf, Comm_rank(comm) == root ? similar(sendbuf, Comm_size(comm) * length(sendbuf)) : nothing, root, comm)
end
function Gather(object::T, root::Integer, comm::Comm) where {T}
    Gather(Ref(object), root, comm)
end

"""
    Allgather!(sendbuf, recvbuf, comm::Comm)
    Allgather!(sendrecvbuf, comm::Comm)

Each process sends the contents of `sendbuf` to the other processes, who
store the results in rank order into `recvbuf`.

`count` should be the same for all processes.

If only one buffer `sendrecvbuf` is provided, then each process send data is assumed to be
in the area where it would receive it's own contribution.

# See also
- [`Allgather`](@ref) for the allocating operation
- [`Allgatherv!`](@ref)/[`Allgatherv`](@ref) if the number of elements varies between processes.
- [`Gather!`](@ref) to send only to a single root process

# External links
$(_doc_external("MPI_Allgather"))
"""
function Allgather!(sendbuf::Buffer, recvbuf::MultiBuffer, count::Integer, comm::Comm)
    if recvbuf.nchunks !== nothing
        @assert recvbuf.nchunks >= Comm_size(comm)
    end

    # int MPI_Allgather(const void* sendbuf, int sendcount,
    #                   MPI_Datatype sendtype, void* recvbuf, int recvcount,
    #                   MPI_Datatype recvtype, MPI_Comm comm)
    @mpichk ccall((:MPI_Allgather, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm),
                  sendbuf.data, sendbuf.count, sendbuf.datatype,
                  recvbuf.data, recvbuf.count, recvbuf.datatype, comm)
    recvbuf.data
end
Allgather!(sendbuf, recvbuf::MultiBuffer, comm::Comm) =
    Allgather!(Buffer(sendbuf), recvbuf, comm)
Allgather!(sendbuf::Union{Ref,AbstractArray}, recvbuf::AbstractArray, comm::Comm) =
    Allgather!(sendbuf, MultiBuffer(recvbuf, length(sendbuf)), comm)


function Allgather!(sendrecvbuf::MultiBuffer, comm::Comm)
    Allgather!(IN_PLACE, sendrecvbuf, count, comm)
end

"""
    Allgather(sendbuf[, count=length(sendbuf)], comm)

Each process sends the first `count` elements of `sendbuf` to the other processes, who
store the results in rank order allocating the output buffer.

`count` should be the same for all processes.

# See also
- [`Allgather!`](@ref) for the mutating operation
- [`Allgatherv!`](@ref)/[`Allgatherv`](@ref) if the number of elements varies between processes.
- [`Gather!`](@ref) to send only to a single root process

# External links
$(_doc_external("MPI_Allgather"))
"""
function Allgather(sendbuf::Union{Ref,AbstractArray}, comm::Comm)
    Allgather!(sendbuf, similar(sendbuf, Comm_size(comm) * length(sendbuf)), comm)
end
function Allgather(object::T, comm::Comm) where T
    Allgather!(Ref(object), comm)
end

"""
    Gatherv!(sendbuf, recvbuf, counts, root, comm)

Each process sends the first `counts[rank]` elements of the buffer `sendbuf` to
the `root` process. The `root` stores elements in rank order in the buffer
`recvbuf`.

`sendbuf` can be `nothing` on the root process, in which case the corresponding entries in
`recvbuf` are assumed to be already in place (this corresponds the behaviour of
`MPI_IN_PLACE` in `MPI_Gatherv`). For example
```
if root == MPI.Comm_rank(comm)
    Gatherv!(nothing, buf, counts, root, comm)
else
    Gatherv!(buf, nothing, counts, root, comm)
end
```

# See also
- [`Gatherv`](@ref) for the allocating operation
- [`Gather!`](@ref)
- [`Allgatherv!`](@ref)/[`Allgatherv`](@ref) to send the result to all processes

# External links
$(_doc_external("MPI_Gatherv"))
"""
function Gatherv!(sendbuf::Buffer, recvbuf::VMultiBuffer, root::Integer, comm::Comm)
    if Comm_rank(comm) == root
        @assert length(recvbuf.counts) >= Comm_size(comm)
    end
    # int MPI_Gatherv(const void* sendbuf, int sendcount, MPI_Datatype sendtype,
    #                 void* recvbuf, const int recvcounts[], const int displs[],
    #                 MPI_Datatype recvtype, int root, MPI_Comm comm)
    @mpichk ccall((:MPI_Gatherv, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm),
                  sendbuf.data, sendbuf.count, sendbuf.datatype,
                  recvbuf.data, recvbuf.counts, recvbuf.displs, recvbuf.datatype, root, comm)
    recvbuf.data
end
Gatherv!(sendbuf, recvbuf::VMultiBuffer, root::Integer, comm::Comm) =
    Gatherv!(Buffer(sendbuf), recvbuf, root, comm)
Gatherv!(sendbuf, recvbuf::Nothing, root::Integer, comm::Comm) =
    Gatherv!(sendbuf, VMultiBuffer(), root, comm)


"""
    Allgatherv!(sendbuf, recvbuf, comm)
    Allgatherv!(sendrecvbuf, comm)

Each process sends the first `counts[rank]` elements of the buffer `sendbuf` to
all other process. Each process stores the received data in rank order in the
buffer `recvbuf`.

If only one buffer `sendrecvbuf` is provided, then for each process, the data to be sent
is taken from the interval of `recvbuf` where it would store it's own data.

# See also
- [`Allgatherv`](@ref) for the allocating operation
- [`Gatherv!`](@ref)/[`Gatherv`](@ref) to send the result to a single process

# External links
$(_doc_external("MPI_Allgatherv"))
"""
function Allgatherv!(sendbuf::Buffer, recvbuf::VMultiBuffer, comm::Comm)
    @assert length(recvbuf.counts) >= Comm_size(comm)

    # int MPI_Allgatherv(const void* sendbuf, int sendcount,
    #                    MPI_Datatype sendtype, void* recvbuf, const int recvcounts[],
    #                    const int displs[], MPI_Datatype recvtype, MPI_Comm comm)
    @mpichk ccall((:MPI_Allgatherv, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm),
                  sendbuf.data, sendbuf.count, sendbuf.datatype,
                  recvbuf.data, recvbuf.counts, recvbuf.displs, recvbuf.datatype, comm)
    recvbuf
end
function Allgatherv!(sendrecvbuf::VMultiBuffer, comm::Comm)
    Allgatherv!(IN_PLACE, sendrecvbuf, comm)
end



"""
    Alltoall!(sendbuf, recvbuf, count::Integer, comm::Comm)
    Alltoall!(sendrecvbuf, count::Integer, comm::Comm)

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

If only one buffer `sendrecvbuf` then data is overwritten.

# See also
- [`Alltoall`](@ref) for the allocating operation

# External links
$(_doc_external("MPI_Alltoall"))
"""
function Alltoall!(sendbuf, recvbuf, count::Integer, comm::Comm)
    buflength = count * Comm_size(comm)
    @assert_minlength recvbuf buflength
    @assert_minlength sendbuf buflength    
    sendbuf isa SentinelPtr || @assert eltype(sendbuf) == eltype(recvbuf)
    T = eltype(recvbuf)
    # int MPI_Alltoall(const void* sendbuf, int sendcount, MPI_Datatype sendtype,
    #                  void* recvbuf, int recvcount, MPI_Datatype recvtype,
    #                  MPI_Comm comm)
    @mpichk ccall((:MPI_Alltoall, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm),
                  sendbuf, count, Datatype(T), recvbuf, count, Datatype(T), comm)
    recvbuf
end
function Alltoall!(sendrecvbuf, count::Integer, comm::Comm)
    Alltoall!(MPI_IN_PLACE, recvbuf, count, comm)
end

"""
    Alltoall(sendbuf, count::Integer, comm::Comm)

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

# See also
- [`Alltoall!`](@ref) for the mutating operation

# External links
$(_doc_external("MPI_Alltoall"))
"""
function Alltoall(sendbuf, count::Integer,  comm::Comm)
    recvbuf = similar(sendbuf, Comm_size(comm)*count)
    Alltoall!(sendbuf, recvbuf, count, comm)
end

"""
    Alltoallv!(sendbuf, recvbuf, scounts::Vector, rcounts::Vector, comm::Comm)

Similar to [`Alltoall!`](@ref), except with different size chunks per process.

# See also
- [`Alltoallv`](@ref) for the allocating operation

# External links
$(_doc_external("MPI_Alltoallv"))
"""
function Alltoallv!(sendbuf, recvbuf, scounts::Vector{Cint}, rcounts::Vector{Cint}, comm::Comm)
    @assert_minlength sendbuf sum(scounts)
    @assert_minlength recvbuf sum(rcounts)
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
                  sendbuf, scounts, sdispls, Datatype(T), recvbuf, rcounts, rdispls, Datatype(T), comm)
    recvbuf
end

"""
    Alltoallv(sendbuf, recvbuf, scounts::Vector, rcounts::Vector, comm::Comm)

Similar to [`Alltoall`](@ref), except with different size chunks per process.

# See also
- [`Alltoallv!`](@ref) for the mutating operation

# External links
$(_doc_external("MPI_Alltoallv"))
"""
function Alltoallv(sendbuf, scounts::Vector{Cint},
                   rcounts::Vector{Cint}, comm::Comm)
    recvbuf = similar(sendbuf, sum(rcounts))
    Alltoallv!(sendbuf, recvbuf, scounts, rcounts, comm)
end


### Reduce/Scan

## Reduce

# mutating
"""
    Reduce!(sendbuf, recvbuf[, count::Integer=length(sendbuf)], op, root::Integer, comm::Comm)
    Reduce!(sendrecvbuf, op, root::Integer, comm::Comm)

Performs elementwise reduction using the operator `op` on the first `count` elements of
the buffer `sendbuf` and stores the result in `recvbuf` on the process of rank `root`.

On non-root processes `recvbuf` is ignored, and can be `nothing`. 

To perform the reduction in place, provide a single buffer `sendrecvbuf`.

# See also
- [`Reduce`](@ref) to handle allocation of the output buffer.
- [`Allreduce!`](@ref)/[`Allreduce`](@ref) to send reduction to all ranks.
- [`Op`](@ref) for details on reduction operators.

# External links
$(_doc_external("MPI_Reduce"))
"""
function Reduce!(sendbuf, recvbuf, count::Integer, op::Union{Op,MPI_Op}, root::Integer, comm::Comm)
    isroot = Comm_rank(comm) == root
    @assert_minlength sendbuf count
    if isroot
        @assert recvbuf !== nothing
        @assert_minlength recvbuf count
    end
    T = sendbuf isa SentinelPtr ? eltype(recvbuf) : eltype(sendbuf)
    # int MPI_Reduce(const void* sendbuf, void* recvbuf, int count,
    #                MPI_Datatype datatype, MPI_Op op, int root, MPI_Comm comm)
    @mpichk ccall((:MPI_Reduce, libmpi), Cint,
                  (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm),
                  sendbuf, recvbuf, count, Datatype(T), op, root, comm)
    recvbuf
end

# Convert user-provided functions to MPI.Op
function Reduce!(sendbuf, recvbuf, count::Integer, opfunc, root::Integer, comm::Comm)
    T = sendbuf isa SentinelPtr ? eltype(recvbuf) : eltype(sendbuf)
    Reduce!(sendbuf, recvbuf, count, Op(opfunc, T), root, comm)
end
function Reduce!(sendbuf::AbstractArray, recvbuf::Union{Nothing,AbstractArray},
                 op, root::Integer, comm::Comm)
    Reduce!(sendbuf, recvbuf, length(sendbuf), op, root, comm)
end

# inplace
function Reduce!(buf, op, root::Integer, comm::Comm)
    if Comm_rank(comm) == root
        Reduce!(MPI_IN_PLACE, buf, length(buf), op, root, comm)
    else
        Reduce!(buf, nothing, length(buf), op, root, comm)
    end
end

# allocating
"""
    recvbuf = Reduce(sendbuf, op, root::Integer, comm::Comm)

Performs elementwise reduction using the operator `op` on the buffer `sendbuf`, returning
the result `recvbuf` on the process of rank `root`, and `nothing` on non-root processes.

`sendbuf` can also be a scalar, in which case `recvbuf` will be a value of the same type.

# See also
- [`Reduce!`](@ref) for mutating and in-place operations
- [`Allreduce!`](@ref)/[`Allreduce`](@ref) to send reduction to all ranks.
- [`Op`](@ref) for details on reduction operators.

# External links
$(_doc_external("MPI_Reduce"))
"""
function Reduce(sendbuf::AbstractArray, op, root::Integer, comm::Comm)
    Reduce!(sendbuf, Comm_rank(comm) == root ? similar(sendbuf) : nothing, length(sendbuf), op, root, comm)
end
function Reduce(object::T, op, root::Integer, comm::Comm) where {T}
    if Comm_rank(comm) == root
        Reduce!(Ref(object), Ref{T}(), 1, op, root, comm)[]
    else
        Reduce!(Ref(object), nothing, 1, op, root, comm)
    end
end

## Allreduce

# mutating
"""
    Allreduce!(sendbuf, recvbuf[, count=length(sendbuf)], op, comm)
    Allreduce!(sendrecvbuf, op, comm)

Performs elementwise reduction using the operator `op` on the first `count` elements of
the buffer `sendbuf`, storing the result in the `recvbuf` of all processes in the group.

`Allreduce!` is equivalent to a [`Reduce!`](@ref) operation followed by
a [`Bcast!`](@ref), but can lead to better performance.

If only one `sendrecvbuf` buffer is provided, then the operation is performed in-place.

# See also
- [`Allreduce`](@ref), to handle allocation of the output buffer.
- [`Reduce!`](@ref)/[`Reduce`](@ref) to send reduction to a single rank.
- [`Op`](@ref) for details on reduction operators.

# External links
$(_doc_external("MPI_Allreduce"))
"""
function Allreduce!(sendbuf, recvbuf, count::Integer, op::Union{Op,MPI_Op}, comm::Comm)
    @assert_minlength sendbuf count
    @assert_minlength recvbuf count
    sendbuf isa SentinelPtr || @assert eltype(sendbuf) == eltype(recvbuf)
    T = eltype(recvbuf)
    # int MPI_Allreduce(const void* sendbuf, void* recvbuf, int count,
    #                   MPI_Datatype datatype, MPI_Op op, MPI_Comm comm)
    @mpichk ccall((:MPI_Allreduce, libmpi), Cint,
                  (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm),
                  sendbuf, recvbuf, count, Datatype(T), op, comm)
    recvbuf
end
function Allreduce!(sendbuf, recvbuf, count::Integer, opfunc, comm::Comm)
    Allreduce!(sendbuf, recvbuf, count, Op(opfunc, eltype(recvbuf)), comm)
end

function Allreduce!(sendbuf::AbstractArray, recvbuf::AbstractArray, op, comm::Comm)
    Allreduce!(sendbuf, recvbuf, length(recvbuf), op, comm)
end

# inplace
function Allreduce!(buf, op, comm::Comm)
    Allreduce!(MPI_IN_PLACE, buf, length(buf), op, comm)
end

# allocating
"""
    recvbuf = Allreduce(sendbuf, op, comm)

Performs elementwise reduction using the operator `op` on the buffer `sendbuf`, returning
the result in the `recvbuf` of all processes in the group.

`sendbuf` can also be a scalar, in which case `recvbuf` will be a value of the same type.

# See also
- [`Allreduce!`](@ref) for mutating or in-place operations.
- [`Reduce!`](@ref)/[`Reduce`](@ref) to send reduction to a single rank.
- [`Op`](@ref) for details on reduction operators.

# External links
$(_doc_external("MPI_Allreduce"))
"""
function Allreduce(sendbuf::AbstractArray, op, comm::Comm)
    Allreduce!(sendbuf, similar(sendbuf), length(sendbuf), op, comm)
end
function Allreduce(obj::T, op, comm::Comm) where {T}
    Allreduce!(Ref(obj), Ref{T}(), 1, op, comm)[]
end

## Scan

# mutating
"""
    Scan!(sendbuf, recvbuf[, count::Integer], op, comm::Comm)
    Scan!(buf[, count::Integer], op, comm::Comm)

Inclusive prefix reduction (analagous to `accumulate` in Julia): `recvbuf` on rank `i`
will contain the the result of reducing `sendbuf` by `op` from ranks `0:i`.

If only a single buffer is provided, then operations will be performed in-place in `buf`.

# See also
- [`Scan`](@ref) to handle allocation of the output buffer
- [`Exscan!`](@ref)/[`Exscan`](@ref) for exclusive scan
- [`Op`](@ref) for details on reduction operators.

# External links
$(_doc_external("MPI_Scan"))
"""
function Scan!(sendbuf, recvbuf, count::Integer,
               op::Union{Op,MPI_Op}, comm::Comm)
    T = eltype(recvbuf)
    # int MPI_Scan(const void* sendbuf, void* recvbuf, int count,
    #              MPI_Datatype datatype, MPI_Op op, MPI_Comm comm)
    @mpichk ccall((:MPI_Scan, libmpi), Cint,
                  (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm),
                  sendbuf, recvbuf, count, Datatype(T), op, comm)
    recvbuf
end
function Scan!(sendbuf, recvbuf, count::Integer, opfunc, comm::Comm)
    Scan!(sendbuf, recvbuf, count, Op(opfunc, eltype(recvbuf)), comm)
end
function Scan!(sendbuf::AbstractArray, recvbuf, op, comm::Comm)
    Scan!(sendbuf, recvbuf, length(sendbuf), op, comm)
end

# inplace
function Scan!(buf, count::Integer, opfunc, comm::Comm)
    Scan!(MPI_IN_PLACE, buf, count, Op(opfunc, eltype(sendbuf)), comm)
end
function Scan!(buf, opfunc, comm::Comm)
    Scan!(buf, length(buf), Op(opfunc, eltype(sendbuf)), comm)
end

# allocating
"""
    recvbuf = Scan(sendbuf, op, comm::Comm)

Inclusive prefix reduction (analagous to `accumulate` in Julia): `recvbuf` on rank `i`
will contain the the result of reducing `sendbuf` by `op` from ranks `0:i`.

`sendbuf` can also be a scalar, in which case `recvbuf` will also be a scalar of the same
type.

# See also
- [`Scan!`](@ref) for mutating or in-place operations
- [`Exscan!`](@ref)/[`Exscan`](@ref) for exclusive scan
- [`Op`](@ref) for details on reduction operators.

# External links
$(_doc_external("MPI_Scan"))
"""
function Scan(sendbuf::AbstractArray, op, comm::Comm)
    Scan!(sendbuf, similar(sendbuf), op, comm)
end
function Scan(object::T, op, comm::Comm) where {T}
    Scan!(Ref(object), Ref{T}(), 1, op, comm)[]
end

## Exscan

# mutating

"""
    Exscan!(sendbuf, recvbuf[, count::Integer], op, comm::Comm)
    Exscan!(buf[, count::Integer], op, comm::Comm)

Exclusive prefix reduction (analagous to `accumulate` in Julia): `recvbuf` on rank `i`
will contain the the result of reducing `sendbuf` by `op` from ranks `0:i-1`. The
`recvbuf` on rank `0` is ignored, and the `recvbuf` on rank `1` will contain the contents
of `sendbuf` on rank `0`.

If only a single `buf` is provided, then operations are performed in-place, and `buf` on
rank 0 will remain unchanged.

# See also
- [`Exscan`](@ref) to handle allocation of the output buffer
- [`Scan!`](@ref)/[`Scan`](@ref) for inclusive scan
- [`Op`](@ref) for details on reduction operators.

# External links
$(_doc_external("MPI_Exscan"))
"""
function Exscan!(sendbuf, recvbuf, count::Integer,
                op::Union{Op,MPI_Op}, comm::Comm)
    T = eltype(recvbuf)
    # int MPI_Exscan(const void* sendbuf, void* recvbuf, int count,
    #                MPI_Datatype datatype, MPI_Op op, MPI_Comm comm)
    @mpichk ccall((:MPI_Exscan, libmpi), Cint,
          (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm),
          sendbuf, recvbuf, count, Datatype(T), op, comm)
    recvbuf
end
function Exscan!(sendbuf, recvbuf, count::Integer, opfunc, comm::Comm)
    Exscan!(sendbuf, recvbuf, count, Op(opfunc, eltype(recvbuf)), comm)
end
function Exscan!(sendbuf::AbstractArray, recvbuf::AbstractArray, op, comm::Comm)
    Exscan!(sendbuf, recvbuf, length(sendbuf), op, comm)
end

# inplace
function Exscan!(buf, count::Integer, opfunc, comm::Comm)
    Exscan!(MPI_IN_PLACE, buf, count, Op(opfunc, eltype(buf)), comm)
end
function Exscan!(buf, op, comm::Comm)
    Exscan!(buf, length(buf), op, comm)
end


# allocating
"""
    recvbuf = Exscan(sendbuf, op, comm::Comm)

Exclusive prefix reduction (analagous to `accumulate` in Julia): `recvbuf` on rank `i`
will contain the the result of reducing `sendbuf` by `op` from ranks `0:i-1`. The
`recvbuf` on rank `0` is undefined, and the `recvbuf` on rank `1` will contain the contents
of `sendbuf` on rank `0`.

# See also
- [`Exscan!`](@ref) for mutating and in-place operations
- [`Scan!`](@ref)/[`Scan`](@ref) for inclusive scan
- [`Op`](@ref) for details on reduction operators.

# External links
$(_doc_external("MPI_Scan"))
"""
function Exscan(sendbuf::AbstractArray, op, comm::Comm)
    Exscan!(sendbuf, similar(sendbuf), op, comm)
end
function Exscan(object::T, op, comm::Comm) where {T}
    Exscan!(Ref(object), Ref{T}(), 1, op, comm)[]
end
