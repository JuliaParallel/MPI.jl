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
    API.MPI_Barrier(comm)
    return nothing
end

"""
    Ibarrier(comm::Comm[, req::AbstractRequest = Request())

Blocks until `comm` is synchronized.

If `comm` is an intracommunicator, then it blocks until all members of the group have called it.

If `comm` is an intercommunicator, then it blocks until all members of the other group have called it.

# External links
$(_doc_external("MPI_Ibarrier"))
"""
function Ibarrier(comm::Comm, req::AbstractRequest = Request())
    @assert isnull(req)
    # int MPI_Ibarrier(MPI_Comm comm, MPI_Req req)
    API.MPI_Ibarrier(comm, req)
    return req
end


"""
    Bcast!(buf, comm::Comm; root::Integer=0)

Broadcast the buffer `buf` from `root` to all processes in `comm`.

# See also
- [`bcast`](@ref)

# External links
$(_doc_external("MPI_Bcast"))
"""
Bcast!(buf, comm::Comm; root::Integer=Cint(0)) =
    Bcast!(buf, root, comm)

function Bcast!(buf::Buffer, root::Integer, comm::Comm)
    # int MPI_Bcast(void* buffer, int count, MPI_Datatype datatype, int root,
    #               MPI_Comm comm)
    API.MPI_Bcast(buf.data, buf.count, buf.datatype, root, comm)
    return buf.data
end
function Bcast!(data, root::Integer, comm::Comm)
    Bcast!(Buffer(data), root, comm)
end

"""
    Bcast(obj, root::Integer, comm::Comm)

Broadcast the `obj` from `root` to all processes in `comm`. Returns the object.
Currently `obj` must be `isbits`, i.e. `isbitstype(typeof(obj)) == true`.
"""
function Bcast(obj::T, root::Integer, comm::Comm) where T
    if !isbitstype(T)
        throw(ArgumentError("Bcast currently only supports `isbitstype`s."))
    end
    Bcast!(Ref(obj), root, comm)[]
end

"""
    bcast(obj, comm::Comm; root::Integer=0)

Broadcast the object `obj` from rank `root` to all processes on `comm`. This is
able to handle arbitrary data.

# See also

- [`Bcast!`](@ref)
"""
bcast(obj, comm::Comm; root::Integer=Cint(0)) =
    bcast(obj, root, comm)
function bcast(obj, root::Integer, comm::Comm)
    isroot = Comm_rank(comm) == root
    count = Ref{Cint}()
    if isroot
        buf = MPI.serialize(obj)
        count[] = length(buf)
    end
    Bcast!(count, root, comm)
    if !isroot
        buf = Array{UInt8}(undef, count[])
    end
    Bcast!(buf, root, comm)
    if !isroot
        obj = MPI.deserialize(buf)
    end
    return obj
end

"""
    Scatter!(sendbuf::Union{UBuffer,Nothing}, recvbuf, comm::Comm;
        root::Integer=0)

Splits the buffer `sendbuf` in the `root` process into `Comm_size(comm)` chunks,
sending the `j`-th chunk to the process of rank `j-1` into the `recvbuf` buffer.

`sendbuf` on the root process should be a [`UBuffer`](@ref) (an `Array` can also be
passed directly if the sizes can be determined from `recvbuf`). On non-root processes it
is ignored, and `nothing` can be passed instead.

`recvbuf` is a [`Buffer`](@ref) object, or any object for which `Buffer(recvbuf)` is
defined. On the root process, it can also be [`MPI.IN_PLACE`](@ref), in which case it is
unmodified. For example:
```
if root == MPI.Comm_rank(comm)
    MPI.Scatter!(UBuffer(buf, count), MPI.IN_PLACE, comm; root=root)
else
    MPI.Scatter!(nothing, buf, comm; root=root)
end
```

# See also
- [`Scatterv!`](@ref) if the number of elements varies between processes.

# External links
$(_doc_external("MPI_Scatter"))
"""
Scatter!(sendbuf, recvbuf, comm::Comm; root::Integer=Cint(0)) =
    Scatter!(sendbuf, recvbuf, root, comm)
function Scatter!(sendbuf::UBuffer, recvbuf::Buffer, root::Integer, comm::Comm)
    if sendbuf.nchunks !== nothing && Comm_rank(comm) == root
        @assert sendbuf.nchunks >= Comm_size(comm)
    end
    # int MPI_Scatter(const void* sendbuf, int sendcount, MPI_Datatype sendtype,
    #                 void* recvbuf, int recvcount, MPI_Datatype recvtype, int root,
    #                 MPI_Comm comm)
    API.MPI_Scatter(sendbuf.data, sendbuf.count, sendbuf.datatype,
                    recvbuf.data, recvbuf.count, recvbuf.datatype, root, comm)
    return recvbuf.data
end
Scatter!(sendbuf::UBuffer, recvbuf, root::Integer, comm::Comm) =
    Scatter!(sendbuf, Buffer(recvbuf), root, comm)
Scatter!(sendbuf::Nothing, recvbuf, root::Integer, comm::Comm) =
    Scatter!(UBuffer(nothing), recvbuf, root, comm)

# determine UBuffer count from recvbuf
Scatter!(sendbuf::AbstractArray{T}, recvbuf::Union{Ref{T},AbstractArray{T}}, root::Integer, comm::Comm) where {T} =
    Scatter!(UBuffer(sendbuf,length(recvbuf)), recvbuf, root, comm)

"""
    Scatter(sendbuf, T, comm::Comm; root::Integer=0)

Splits the buffer `sendbuf` in the `root` process into `Comm_size(comm)` chunks,
sending the `j`-th chunk to the process of rank `j-1` as an object of type `T`.

# See also
- [`Scatter!`](@ref)
"""
Scatter(sendbuf, T, comm; root::Integer=Cint(0)) =
    Scatter(sendbuf, T, root, comm)
Scatter(sendbuf, ::Type{T}, root::Integer, comm::Comm) where {T} =
    Scatter!(sendbuf, Ref{T}(), root, comm)[]

"""
    scatter(objs::Union{AbstractVector, Nothing}, comm::Comm; root::Integer=0)

Sends the `j`-th element of `objs` in the `root` process to rank `j-1` and returns it. On `root`, `objs` is expected to be a `Comm_size(comm)`-element vector. On the other ranks, it is ignored and can be `nothing`.

This method can handle arbitrary data.

# See also

- [`Scatter!`](@ref)
"""
function scatter(objs::Union{AbstractVector, Nothing}, comm::Comm; root::Integer=0)
    isroot = Comm_rank(comm) == root

    if isroot
        if length(objs) != Comm_size(comm)
            throw(ArgumentError("Length of argument objs ($(length(objs))) != number of ranks in comm ($(Comm_size(comm)))."))
        end

        sendbuffer = IOBuffer()
        counts = Vector{Int64}(undef, length(objs))

        last_pos = 0
        for (i, obj) in enumerate(objs)
            Serialization.serialize(sendbuffer, i == root + 1 ? nothing : obj)
            counts[i] = position(sendbuffer) - last_pos
            last_pos = position(sendbuffer)
        end

        count = Scatter(counts, Int64, comm; root = root)
        sendbuf = VBuffer(take!(sendbuffer), counts)

        Scatterv!(sendbuf, IN_PLACE, comm; root = root)
        return objs[root + 1]
    else
        count = Scatter(nothing, Int64, comm; root = root)

        data = Array{UInt8}(undef, count)
        recvbuf = Buffer(data)

        Scatterv!(nothing, recvbuf, comm; root = root)
        return MPI.deserialize(recvbuf.data)
    end
end


"""
    Scatterv!(sendbuf, recvbuf, comm::Comm; root::Integer=0)

Splits the buffer `sendbuf` in the `root` process into `Comm_size(comm)` chunks and sends
the `j`th chunk to the process of rank `j-1` into the `recvbuf` buffer.

`sendbuf` on the root process should be a [`VBuffer`](@ref). On non-root processes it is
ignored, and `nothing` can be passed instead.

`recvbuf` is a [`Buffer`](@ref) object, or any object for which `Buffer(recvbuf)` is
defined. On the root process, it can also be [`MPI.IN_PLACE`](@ref), in which case it is
unmodified. For example:
```
if root == MPI.Comm_rank(comm)
    MPI.Scatterv!(VBuffer(buf, counts), MPI.IN_PLACE, comm; root=root)
else
    MPI.Scatterv!(nothing, buf, comm; root=root)
end
```

# See also
- [`Scatter!`](@ref) if the number of elements are the same for all processes

# External links
$(_doc_external("MPI_Scatterv"))
"""
Scatterv!(sendbuf, recvbuf, comm::Comm; root::Integer=Cint(0)) =
    Scatterv!(sendbuf, recvbuf, root, comm)
function Scatterv!(sendbuf::VBuffer, recvbuf::Buffer, root::Integer, comm::Comm)
    if Comm_rank(comm) == root
        @assert length(sendbuf.counts) >= Comm_size(comm)
    end
    # int MPI_Scatterv(const void* sendbuf, const int sendcounts[],
    #                  const int displs[], MPI_Datatype sendtype, void* recvbuf,
    #                  int recvcount, MPI_Datatype recvtype, int root, MPI_Comm comm)
    API.MPI_Scatterv(sendbuf.data, sendbuf.counts, sendbuf.displs, sendbuf.datatype,
                     recvbuf.data, recvbuf.count, recvbuf.datatype,
                     root, comm)
    return recvbuf.data
end
Scatterv!(sendbuf::VBuffer, recvbuf, root::Integer, comm::Comm) =
    Scatterv!(sendbuf, Buffer(recvbuf), root, comm)
Scatterv!(sendbuf::Nothing, recvbuf, root::Integer, comm::Comm) =
    Scatterv!(VBuffer(nothing), recvbuf, root, comm)


"""
    Gather!(sendbuf, recvbuf, comm::Comm; root::Integer=0)

Each process sends the contents of the buffer `sendbuf` to the `root` process. The `root`
process stores elements in rank order in the buffer buffer `recvbuf`.

`sendbuf` should be a [`Buffer`](@ref) object, or any object for which
[`Buffer_send`](@ref) is defined, with the same length on all processes, and should be the
same length on all processes.

On the root process, `sendbuf` can be [`MPI.IN_PLACE`](@ref) on the root process, in which
case the corresponding entries in `recvbuf` are assumed to be already in place (this
corresponds the behaviour of `MPI_IN_PLACE` in `MPI_Gather`). For example:
```
if root == MPI.Comm_rank(comm)
    MPI.Gather!(MPI.IN_PLACE, UBuffer(buf, count), comm; root=root)
else
    MPI.Gather!(buf, nothing, comm; root=root)
end
```

`recvbuf` on the root process should be a [`UBuffer`](@ref), or can be an `AbstractArray`
if the length can be determined from `sendbuf`. On non-root processes it is ignored and
can be `nothing`.

# See also
- [`Gather`](@ref) for the allocating operation.
- [`Gatherv!`](@ref) if the number of elements varies between processes.
- [`Allgather!`](@ref) to send the result to all processes.

# External links
$(_doc_external("MPI_Gather"))
"""
Gather!(sendbuf, recvbuf, comm::Comm; root::Integer=Cint(0)) =
    Gather!(sendbuf, recvbuf, root, comm)
function Gather!(sendbuf::Buffer, recvbuf::UBuffer, root::Integer, comm::Comm)
    if recvbuf.nchunks !== nothing && Comm_rank(comm) == root
        @assert recvbuf.nchunks >= Comm_size(comm)
    end
    # int MPI_Gather(const void* sendbuf, int sendcount, MPI_Datatype sendtype,
    #                void* recvbuf, int recvcount, MPI_Datatype recvtype, int root,
    #                MPI_Comm comm)
    API.MPI_Gather(sendbuf.data, sendbuf.count, sendbuf.datatype,
                   recvbuf.data, recvbuf.count, recvbuf.datatype, root, comm)
    return recvbuf.data
end
Gather!(sendbuf, recvbuf::UBuffer, root::Integer, comm::Comm) =
    Gather!(Buffer_send(sendbuf), recvbuf, root, comm)
Gather!(sendbuf::Union{Ref,AbstractArray}, recvbuf::AbstractArray, root::Integer, comm::Comm) =
    Gather!(sendbuf, UBuffer(recvbuf, length(sendbuf)), root, comm)
Gather!(sendbuf, recvbuf::Nothing, root::Integer, comm::Comm) =
    Gather!(sendbuf, UBuffer(nothing), root, comm)
Gather!(sendbuf::Nothing, recvbuf, root::Integer, comm::Comm) =
    Gather!(IN_PLACE, recvbuf, root, comm)



"""
    Gather(sendbuf, comm::Comm; root=0)

Each process sends the contents of the buffer `sendbuf` to the `root` process. The `root`
allocates the output buffer and stores elements in rank order.

`sendbuf` can be an `AbstractArray` or a scalar, and should be the same length on all
processes.

# See also
- [`Gather!`](@ref) for the mutating operation.
- [`Gatherv!`](@ref) if the number of elements varies between processes.
- [`Allgather!`](@ref)/[`Allgather`](@ref) to send the result to all processes.

# External links
$(_doc_external("MPI_Gather"))
"""
Gather(sendbuf, comm::Comm; root::Integer=Cint(0)) =
    Gather(sendbuf, root, comm)
Gather(sendbuf::AbstractArray, root::Integer, comm::Comm) =
    Gather!(sendbuf, Comm_rank(comm) == root ? similar(sendbuf, Comm_size(comm) * length(sendbuf)) : nothing, root, comm)
Gather(object::T, root::Integer, comm::Comm) where {T} =
    Gather!(Ref(object), Comm_rank(comm) == root ? Array{T}(undef, Comm_size(comm)) : nothing, root, comm)

"""
    gather(obj, comm::Comm; root::Integer=0)

Gather the objects `obj` from all ranks on `comm` to rank `root`. This is able to to handle arbitrary data. On `root`, it returns a vector of the objects, and `nothing` otherwise.

# See also

- [`Gather!`](@ref)
"""
function gather(obj, comm::Comm; root::Integer=0)
    isroot = Comm_rank(comm) == root

    sendbuf = MPI.serialize(obj)
    count = length(sendbuf)

    counts = Gather(count, comm; root = root)

    if isroot
        data = Array{UInt8}(undef, sum(counts))
        recvbuf = VBuffer(data, counts)

        Gatherv!(sendbuf, recvbuf, comm; root = root)

        objs = [
            MPI.deserialize(view(recvbuf.data, displ+1:displ+count)) for (displ, count) in zip(recvbuf.displs, recvbuf.counts)
        ]
        return objs
    else
        Gatherv!(sendbuf, nothing, comm; root = root)
        return nothing
    end
end


"""
    Gatherv!(sendbuf, recvbuf, comm::Comm; root::Integer=0)

Each process sends the contents of the buffer `sendbuf` to the `root` process. The `root`
stores elements in rank order in the buffer `recvbuf`.

`sendbuf` should be a [`Buffer`](@ref) object, or any object for which
[`Buffer_send`](@ref) is defined, with the same length on all processes.

On the root process, `sendbuf` can be [`MPI.IN_PLACE`](@ref), in which case the
corresponding entries in `recvbuf` are assumed to be already in place. For example
```
if root == MPI.Comm_rank(comm)
    Gatherv!(MPI.IN_PLACE, VBuffer(buf, counts), comm; root=root)
else
    Gatherv!(buf, nothing, comm; root=root)
end
```

`recvbuf` on the root process should be a [`VBuffer`](@ref), or can be an `AbstractArray`
if the length can be determined from `sendbuf`. On non-root processes it is ignored and
can be `nothing`.

# See also
- [`Gather!`](@ref) if the number of elements is the same between processes.
- [`Allgatherv!`](@ref) to send the result to all processes.

# External links
$(_doc_external("MPI_Gatherv"))
"""
Gatherv!(sendbuf, recvbuf, comm::Comm; root::Integer=Cint(0)) =
    Gatherv!(sendbuf, recvbuf, root, comm)
function Gatherv!(sendbuf::Buffer, recvbuf::VBuffer, root::Integer, comm::Comm)
    if Comm_rank(comm) == root
        @assert length(recvbuf.counts) >= Comm_size(comm)
    end
    # int MPI_Gatherv(const void* sendbuf, int sendcount, MPI_Datatype sendtype,
    #                 void* recvbuf, const int recvcounts[], const int displs[],
    #                 MPI_Datatype recvtype, int root, MPI_Comm comm)
    API.MPI_Gatherv(sendbuf.data, sendbuf.count, sendbuf.datatype,
                    recvbuf.data, recvbuf.counts, recvbuf.displs, recvbuf.datatype, root, comm)
    return recvbuf.data
end
Gatherv!(sendbuf, recvbuf::VBuffer, root::Integer, comm::Comm) =
    Gatherv!(Buffer_send(sendbuf), recvbuf, root, comm)
Gatherv!(sendbuf, recvbuf::Nothing, root::Integer, comm::Comm) =
    Gatherv!(sendbuf, VBuffer(nothing), root, comm)



"""
    Allgather!(sendbuf, recvbuf::UBuffer, comm::Comm)
    Allgather!(sendrecvbuf::UBuffer, comm::Comm)

Each process sends the contents of `sendbuf` to the other processes, the result of which
is stored in rank order into `recvbuf`.

`sendbuf` can be a [`Buffer`](@ref) object, or any object for which [`Buffer_send`](@ref)
is defined, and should be the same length on all processes.

`recvbuf` can be a [`UBuffer`](@ref), or can be an `AbstractArray` if the length can be
determined from `sendbuf`.

If only one buffer `sendrecvbuf` is provided, then on each process the data to send is
assumed to be in the area where it would receive its own contribution.

# See also
- [`Allgather`](@ref) for the allocating operation
- [`Allgatherv!`](@ref) if the number of elements varies between processes.
- [`Gather!`](@ref) to send only to a single root process

# External links
$(_doc_external("MPI_Allgather"))
"""
function Allgather!(sendbuf::Buffer, recvbuf::UBuffer, comm::Comm)
    if recvbuf.nchunks !== nothing
        @assert recvbuf.nchunks >= Comm_size(comm)
    end

    # int MPI_Allgather(const void* sendbuf, int sendcount,
    #                   MPI_Datatype sendtype, void* recvbuf, int recvcount,
    #                   MPI_Datatype recvtype, MPI_Comm comm)
    API.MPI_Allgather(sendbuf.data, sendbuf.count, sendbuf.datatype,
                      recvbuf.data, recvbuf.count, recvbuf.datatype, comm)
    return recvbuf.data
end
Allgather!(sendbuf, recvbuf::UBuffer, comm::Comm) =
    Allgather!(Buffer_send(sendbuf), recvbuf, comm)

Allgather!(sendbuf::Union{Ref,AbstractArray}, recvbuf::AbstractArray, comm::Comm) =
    Allgather!(sendbuf, UBuffer(recvbuf, length(sendbuf)), comm)


Allgather!(sendrecvbuf::UBuffer, comm::Comm) =
    Allgather!(IN_PLACE, sendrecvbuf, comm)

"""
    Allgather(sendbuf, comm)

Each process sends the contents of `sendbuf` to the other processes, who store the results
in rank order allocating the output buffer.

`sendbuf` can be an `AbstractArray` or a scalar, and should be the same size on all
processes.

# See also
- [`Allgather!`](@ref) for the mutating operation
- [`Allgatherv!`](@ref) if the number of elements varies between processes.
- [`Gather!`](@ref) to send only to a single root process

# External links
$(_doc_external("MPI_Allgather"))
"""
Allgather(sendbuf::AbstractArray, comm::Comm) =
    Allgather!(sendbuf, similar(sendbuf, Comm_size(comm) * length(sendbuf)), comm)
Allgather(object::T, comm::Comm) where {T} =
    Allgather!(Ref(object), Array{T}(undef, Comm_size(comm)), comm)


"""
    Allgatherv!(sendbuf, recvbuf::VBuffer, comm::Comm)
    Allgatherv!(sendrecvbuf::VBuffer, comm::Comm)

Each process sends the contents of `sendbuf` to all other process. Each process stores the
received in the [`VBuffer`](@ref) `recvbuf`.

`sendbuf` can be a [`Buffer`](@ref) object, or any object for which [`Buffer_send`](@ref)
is defined.

If only one buffer `sendrecvbuf` is provided, then for each process, the data to be sent
is taken from the interval of `recvbuf` where it would store its own data.

# See also
- [`Gatherv!`](@ref) to send the result to a single process

# External links
$(_doc_external("MPI_Allgatherv"))
"""
function Allgatherv!(sendbuf::Buffer, recvbuf::VBuffer, comm::Comm)
    @assert length(recvbuf.counts) >= Comm_size(comm)

    # int MPI_Allgatherv(const void* sendbuf, int sendcount,
    #                    MPI_Datatype sendtype, void* recvbuf, const int recvcounts[],
    #                    const int displs[], MPI_Datatype recvtype, MPI_Comm comm)
    API.MPI_Allgatherv(sendbuf.data, sendbuf.count, sendbuf.datatype,
                       recvbuf.data, recvbuf.counts, recvbuf.displs, recvbuf.datatype,
                       comm)
    return recvbuf.data
end
Allgatherv!(sendbuf, recvbuf::VBuffer, comm::Comm) =
    Allgatherv!(Buffer_send(sendbuf), recvbuf, comm)

Allgatherv!(sendrecvbuf::VBuffer, comm::Comm) =
    Allgatherv!(IN_PLACE, sendrecvbuf, comm)



"""
    Alltoall!(sendbuf::UBuffer, recvbuf::UBuffer, comm::Comm)
    Alltoall!(sendrecvbuf::UBuffer, comm::Comm)

Every process divides the [`UBuffer`](@ref) `sendbuf` into `Comm_size(comm)` chunks of
equal size, sending the `j`-th chunk to the process of rank `j-1`.  Every process stores
the data received from rank `j-1` process in the `j`-th chunk of the buffer `recvbuf`.

```
rank    send buf                        recv buf
----    --------                        --------
 0      a,b,c,d,e,f       Alltoall      a,b,A,B,α,β
 1      A,B,C,D,E,F  ---------------->  c,d,C,D,γ,ψ
 2      α,β,γ,ψ,η,ν                     e,f,E,F,η,ν
```

If only one buffer `sendrecvbuf` is used, then data is overwritten.

# See also
- [`Alltoall`](@ref) for the allocating operation

# External links
$(_doc_external("MPI_Alltoall"))
"""
function Alltoall!(sendbuf::UBuffer, recvbuf::UBuffer, comm::Comm)
    if sendbuf.data !== API.MPI_IN_PLACE[] && sendbuf.nchunks !== nothing
        @assert sendbuf.nchunks >= Comm_size(comm)
    end
    if recvbuf.nchunks !== nothing
        @assert recvbuf.nchunks >= Comm_size(comm)
    end
    # int MPI_Alltoall(const void* sendbuf, int sendcount, MPI_Datatype sendtype,
    #                  void* recvbuf, int recvcount, MPI_Datatype recvtype,
    #                  MPI_Comm comm)
    API.MPI_Alltoall(sendbuf.data, sendbuf.count, sendbuf.datatype,
                     recvbuf.data, recvbuf.count, recvbuf.datatype,
                     comm)
    return recvbuf.data
end
Alltoall!(sendbuf::InPlace, recvbuf::UBuffer, comm::Comm) =
    Alltoall!(UBuffer(IN_PLACE), recvbuf, comm)
Alltoall!(sendrecvbuf::UBuffer, comm::Comm) =
    Alltoall!(IN_PLACE, sendrecvbuf, comm)

"""
    Alltoall(sendbuf::UBuffer, comm::Comm)

Every process divides the [`UBuffer`](@ref) `sendbuf` into `Comm_size(comm)` chunks of
equal size, sending the `j`-th chunk to the process of rank `j-1`. Every process allocates
the output buffer and stores the data received from the process on rank `j-1` in the
`j`-th chunk.

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
Alltoall(sendbuf::UBuffer,  comm::Comm) =
    Alltoall!(sendbuf, similar(sendbuf), comm)


"""
    Alltoallv!(sendbuf::VBuffer, recvbuf::VBuffer, comm::Comm)

Similar to [`Alltoall!`](@ref), except with different size chunks per process.

# See also
- [`VBuffer`](@ref)

# External links
$(_doc_external("MPI_Alltoallv"))
"""
function Alltoallv!(sendbuf::VBuffer, recvbuf::VBuffer, comm::Comm)
    if sendbuf.data !== API.MPI_IN_PLACE[]
        @assert length(sendbuf.counts) >= Comm_size(comm)
    end
    @assert length(recvbuf.counts) >= Comm_size(comm)
    # int MPI_Alltoallv(const void* sendbuf, const int sendcounts[],
    #                   const int sdispls[], MPI_Datatype sendtype, void* recvbuf,
    #                   const int recvcounts[], const int rdispls[],
    #                   MPI_Datatype recvtype, MPI_Comm comm)
    API.MPI_Alltoallv(sendbuf.data, sendbuf.counts, sendbuf.displs, sendbuf.datatype,
                      recvbuf.data, recvbuf.counts, recvbuf.displs, recvbuf.datatype,
                      comm)

    return recvbuf.data
end


### Reduce/Scan

## Reduce

# mutating
"""
    Reduce!(sendbuf, recvbuf, op, comm::Comm; root::Integer=0)
    Reduce!(sendrecvbuf, op, comm::Comm; root::Integer=0)

Performs elementwise reduction using the operator `op` on the buffer `sendbuf` and stores
the result in `recvbuf` on the process of rank `root`.

On non-root processes `recvbuf` is ignored, and can be `nothing`.

To perform the reduction in place, provide a single buffer `sendrecvbuf`.

# See also
- [`Reduce`](@ref) to handle allocation of the output buffer.
- [`Allreduce!`](@ref)/[`Allreduce`](@ref) to send reduction to all ranks.
- [`Op`](@ref) for details on reduction operators.

# External links
$(_doc_external("MPI_Reduce"))
"""
Reduce!(sendrecvbuf, op, comm::Comm; root::Integer=Cint(0)) =
    Reduce!(sendrecvbuf, op, root, comm)
Reduce!(sendbuf, recvbuf, op, comm::Comm; root::Integer=Cint(0)) =
    Reduce!(sendbuf, recvbuf, op, root, comm)

function Reduce!(rbuf::RBuffer, op::Union{Op,MPI_Op}, root::Integer, comm::Comm)
    # int MPI_Reduce(const void* sendbuf, void* recvbuf, int count,
    #                MPI_Datatype datatype, MPI_Op op, int root, MPI_Comm comm)
    API.MPI_Reduce(rbuf.senddata, rbuf.recvdata, rbuf.count, rbuf.datatype, op, root, comm)
    return rbuf.recvdata
end

# Convert user-provided functions to MPI.Op
function Reduce!(rbuf::RBuffer, op, root::Integer, comm::Comm)
    Reduce!(rbuf, Op(op, eltype(rbuf)), root, comm)
end
Reduce!(sendbuf, recvbuf, op, root::Integer, comm::Comm) =
    Reduce!(RBuffer(sendbuf, recvbuf), op, root, comm)

# inplace
function Reduce!(buf, op, root::Integer, comm::Comm)
    if Comm_rank(comm) == root
        Reduce!(IN_PLACE, buf, op, root, comm)
    else
        Reduce!(buf, nothing, op, root, comm)
    end
end

# allocating
"""
    recvbuf = Reduce(sendbuf, op, comm::Comm; root::Integer=0)

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
Reduce(sendbuf, op, comm::Comm; root::Integer=Cint(0)) =
    Reduce(sendbuf, op, root, comm)
function Reduce(sendbuf::AbstractArray, op, root::Integer, comm::Comm)
    if Comm_rank(comm) == root
        Reduce!(sendbuf, similar(sendbuf), op, root, comm)
    else
        Reduce!(sendbuf, nothing, op, root, comm)
    end
end
function Reduce(object::T, op, root::Integer, comm::Comm) where {T}
    source = Ref(object)
    if Comm_rank(comm) == root
        Reduce!(source, Ref{T}(), op, root, comm)[]
    else
        Reduce!(source, nothing, op, root, comm)
    end
end

## IReduce

"""
    IReduce!(sendbuf, recvbuf, op, comm::Comm[, req::AbstractRequest = Request()]; root::Integer=0)
    IReduce!(sendrecvbuf, op, comm::Comm[, req::AbstractRequest = Request()]; root::Integer=0)

Starts a nonblocking elementwise reduction using the operator `op` on the buffer `sendbuf` and
stores the result in `recvbuf` on the process of rank `root`.

On non-root processes `recvbuf` is ignored, and can be `nothing`.

To perform the reduction in place, provide a single buffer `sendrecvbuf`.

Returns the [`AbstractRequest`](@ref) object for the nonblocking reduction.

# See also
- [`Reduce!`](@ref) the equivalent blocking operation.
- [`IAllreduce!`](@ref) to send reduction to all ranks.
- [`Op`](@ref) for details on reduction operators.

# External links
$(_doc_external("MPI_Ireduce"))
"""
IReduce!(sendrecvbuf, op, comm::Comm, req::AbstractRequest=Request(); root::Integer=Cint(0)) =
    IReduce!(sendrecvbuf, op, root, comm, req)
IReduce!(sendbuf, recvbuf, op, comm::Comm, req::AbstractRequest=Request(); root::Integer=Cint(0)) =
    IReduce!(sendbuf, recvbuf, op, root, comm, req)

function IReduce!(rbuf::RBuffer, op::Union{Op,MPI_Op}, root::Integer, comm::Comm, req::AbstractRequest=Request())
    # int MPI_Ireduce(const void* sendbuf, void* recvbuf, int count,
    #                 MPI_Datatype datatype, MPI_Op op, int root, MPI_Comm comm,
    #                 MPI_Request* req)
    API.MPI_Ireduce(rbuf.senddata, rbuf.recvdata, rbuf.count, rbuf.datatype, op, root, comm, req)
    setbuffer!(req, rbuf)
    return req
end

IReduce!(rbuf::RBuffer, op, root::Integer, comm::Comm, req::AbstractRequest=Request()) =
    IReduce!(rbuf, Op(op, eltype(rbuf)), root, comm, req)
IReduce!(sendbuf, recvbuf, op, root::Integer, comm::Comm, req::AbstractRequest=Request()) =
    IReduce!(RBuffer(sendbuf, recvbuf), op, root, comm, req)

# inplace
function IReduce!(buf, op, root::Integer, comm::Comm, req::AbstractRequest=Request())
    if Comm_rank(comm) == root
        IReduce!(IN_PLACE, buf, op, root, comm, req)
    else
        IReduce!(buf, nothing, op, root, comm, req)
    end
end

## Allreduce

# mutating
"""
    Allreduce!(sendbuf, recvbuf, op, comm::Comm)
    Allreduce!(sendrecvbuf, op, comm::Comm)

Performs elementwise reduction using the operator `op` on the buffer `sendbuf`, storing
the result in the `recvbuf` of all processes in the group.

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
function Allreduce!(rbuf::RBuffer, op::Union{Op,MPI_Op}, comm::Comm)
    # int MPI_Allreduce(const void* sendbuf, void* recvbuf, int count,
    #                   MPI_Datatype datatype, MPI_Op op, MPI_Comm comm)
    API.MPI_Allreduce(rbuf.senddata, rbuf.recvdata, rbuf.count, rbuf.datatype, op, comm)
    rbuf.recvdata
end
Allreduce!(rbuf::RBuffer, op, comm::Comm) =
    Allreduce!(rbuf, Op(op, eltype(rbuf)), comm)
Allreduce!(sendbuf, recvbuf, op, comm::Comm) =
    Allreduce!(RBuffer(sendbuf, recvbuf), op, comm)

# inplace
Allreduce!(buf, op, comm::Comm) = Allreduce!(IN_PLACE, buf, op, comm)

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
Allreduce(sendbuf::AbstractArray, op, comm::Comm) =
    Allreduce!(sendbuf, similar(sendbuf), op, comm)
Allreduce(obj::T, op, comm::Comm) where {T} =
    Allreduce!(Ref(obj), Ref{T}(), op, comm)[]

## IAllreduce

"""
    IAllreduce!(sendbuf, recvbuf, op, comm::Comm[, req::AbstractRequest = Request()])
    IAllreduce!(sendrecvbuf, op, comm::Comm[, req::AbstractRequest = Request()])

Starts a nonblocking elementwise reduction using the operator `op` on the buffer `sendbuf`, storing
the result in the `recvbuf` of all processes in the group.

If only one `sendrecvbuf` buffer is provided, then the operation is performed in-place.

Returns the [`AbstractRequest`](@ref) object for the nonblocking reduction.

# See also
- [`Allreduce!`](@ref) the equivalent blocking operation.
- [`IReduce!`](@ref) to send reduction to a single rank.
- [`Op`](@ref) for details on reduction operators.

# External links
$(_doc_external("MPI_Iallreduce"))
"""
function IAllreduce!(rbuf::RBuffer, op::Union{Op, MPI_Op}, comm::Comm, req::AbstractRequest=Request())
    @assert isnull(req)
    # int MPI_Iallreduce(const void* sendbuf, void* recvbuf, int count,
    #                    MPI_Datatype datatype, MPI_Op op, MPI_Comm comm,
    #                    MPI_Request* req)
    API.MPI_Iallreduce(rbuf.senddata, rbuf.recvdata, rbuf.count, rbuf.datatype, op, comm, req)
    setbuffer!(req, rbuf)
    return req
end
IAllreduce!(rbuf::RBuffer, op, comm::Comm, req::AbstractRequest=Request()) =
    IAllreduce!(rbuf, Op(op, eltype(rbuf)), comm, req)
IAllreduce!(sendbuf, recvbuf, op, comm::Comm, req::AbstractRequest=Request()) =
    IAllreduce!(RBuffer(sendbuf, recvbuf), op, comm, req)

# inplace
IAllreduce!(rbuf, op, comm::Comm, req::AbstractRequest=Request()) =
    IAllreduce!(IN_PLACE, rbuf, op, comm, req)

## Scan

# mutating
"""
    Scan!(sendbuf, recvbuf, op, comm::Comm)
    Scan!(sendrecvbuf, op, comm::Comm)

Inclusive prefix reduction (analogous to `accumulate` in Julia): `recvbuf` on rank `i`
will contain the result of reducing `sendbuf` by `op` from ranks `0:i`.

If only a single buffer `sendrecvbuf` is provided, then operations will be performed
in-place.

# See also
- [`Scan`](@ref) to handle allocation of the output buffer
- [`Exscan!`](@ref)/[`Exscan`](@ref) for exclusive scan
- [`Op`](@ref) for details on reduction operators.

# External links
$(_doc_external("MPI_Scan"))
"""
function Scan!(rbuf::RBuffer, op::Union{Op,MPI_Op}, comm::Comm)
    # int MPI_Scan(const void* sendbuf, void* recvbuf, int count,
    #              MPI_Datatype datatype, MPI_Op op, MPI_Comm comm)
    API.MPI_Scan(rbuf.senddata, rbuf.recvdata, rbuf.count, rbuf.datatype, op, comm)
    rbuf.recvdata
end
Scan!(rbuf::RBuffer, op, comm::Comm) = Scan!(rbuf, Op(op, eltype(rbuf)), comm)
Scan!(sendbuf, recvbuf, op, comm::Comm) = Scan!(RBuffer(sendbuf, recvbuf), op, comm)

# inplace
Scan!(buf, op, comm::Comm) =
    Scan!(IN_PLACE, buf, op, comm)

# allocating
"""
    recvbuf = Scan(sendbuf, op, comm::Comm)

Inclusive prefix reduction (analogous to `accumulate` in Julia): `recvbuf` on rank `i`
will contain the result of reducing `sendbuf` by `op` from ranks `0:i`.

`sendbuf` can also be a scalar, in which case `recvbuf` will also be a scalar of the same
type.

# See also
- [`Scan!`](@ref) for mutating or in-place operations
- [`Exscan!`](@ref)/[`Exscan`](@ref) for exclusive scan
- [`Op`](@ref) for details on reduction operators.

# External links
$(_doc_external("MPI_Scan"))
"""
Scan(sendbuf::AbstractArray, op, comm::Comm) =
    Scan!(sendbuf, similar(sendbuf), op, comm)
Scan(object::T, op, comm::Comm) where {T} = Scan!(Ref(object), Ref{T}(), op, comm)[]

## Exscan
# mutating
"""
    Exscan!(sendbuf, recvbuf, op, comm::Comm)
    Exscan!(sendrecvbuf, op, comm::Comm)

Exclusive prefix reduction (analogous to `accumulate` in Julia): `recvbuf` on rank `i`
will contain the result of reducing `sendbuf` by `op` from ranks `0:i-1`. The
`recvbuf` on rank `0` is ignored, and the `recvbuf` on rank `1` will contain the contents
of `sendbuf` on rank `0`.

If only a single `sendrecvbuf` is provided, then operations are performed in-place, and
`buf` on rank 0 will remain unchanged.

# See also
- [`Exscan`](@ref) to handle allocation of the output buffer
- [`Scan!`](@ref)/[`Scan`](@ref) for inclusive scan
- [`Op`](@ref) for details on reduction operators.

# External links
$(_doc_external("MPI_Exscan"))
"""
function Exscan!(rbuf::RBuffer, op::Union{Op,MPI_Op}, comm::Comm)
    # int MPI_Exscan(const void* sendbuf, void* recvbuf, int count,
    #                MPI_Datatype datatype, MPI_Op op, MPI_Comm comm)
    API.MPI_Exscan(rbuf.senddata, rbuf.recvdata, rbuf.count, rbuf.datatype, op, comm)
    rbuf.recvdata
end
Exscan!(rbuf::RBuffer, op, comm::Comm) = Exscan!(rbuf, Op(op, eltype(rbuf)), comm)
Exscan!(sendbuf, recvbuf, op, comm::Comm) = Exscan!(RBuffer(sendbuf, recvbuf), op, comm)

# inplace
Exscan!(buf, op, comm::Comm) = Exscan!(IN_PLACE, buf, op, comm)

# allocating
"""
    recvbuf = Exscan(sendbuf, op, comm::Comm)

Exclusive prefix reduction (analogous to `accumulate` in Julia): `recvbuf` on rank `i`
will contain the result of reducing `sendbuf` by `op` from ranks `0:i-1`. The
`recvbuf` on rank `0` is undefined, and the `recvbuf` on rank `1` will contain the contents
of `sendbuf` on rank `0`.

# See also
- [`Exscan!`](@ref) for mutating and in-place operations
- [`Scan!`](@ref)/[`Scan`](@ref) for inclusive scan
- [`Op`](@ref) for details on reduction operators.

# External links
$(_doc_external("MPI_Scan"))
"""
Exscan(sendbuf::AbstractArray, op, comm::Comm) =
    Exscan!(sendbuf, similar(sendbuf), op, comm)
Exscan(object::T, op, comm::Comm) where {T} = Exscan!(Ref(object), Ref{T}(), op, comm)[]

"""
    Neighbor_alltoall!(sendbuf::UBuffer, recvbuf::UBuffer, comm::Comm)

Perform an all-to-all communication along the directed edges of the graph with fixed size messages.

See also [`MPI.Alltoall!`](@ref).

# External links
$(_doc_external("MPI_Neighbor_alltoall"))
"""
function Neighbor_alltoall!(sendbuf::UBuffer, recvbuf::UBuffer, graph_comm::Comm)
    # int MPI_Neighbor_alltoall(const void *sendbuf, int sendcount, MPI_Datatype sendtype, void *recvbuf,
    #       int recvcount, MPI_Datatype recvtype, MPI_Comm graph_comm)
    API.MPI_Neighbor_alltoall(sendbuf.data, sendbuf.count, sendbuf.datatype,
                              recvbuf.data, recvbuf.count, recvbuf.datatype,
                              graph_comm)
    return recvbuf.data
end

Neighbor_alltoall!(sendbuf::InPlace, recvbuf::UBuffer, graph_comm::Comm) =
    Neighbor_alltoall!(UBuffer(IN_PLACE), recvbuf, graph_comm)
Neighbor_alltoall!(sendrecvbuf::UBuffer, graph_comm::Comm) =
    Neighbor_alltoall!(IN_PLACE, sendrecvbuf, comm)
Neighbor_alltoall(sendbuf::UBuffer, graph_comm::Comm) =
    Neighbor_alltoall!(sendbuf, similar(sendbuf), graph_comm)

"""
    Neighbor_alltoallv!(sendbuf::VBuffer, recvbuf::VBuffer, graph_comm::Comm)

Perform an all-to-all communication along the directed edges of the graph with variable size messages.

See also [`MPI.Alltoallv!`](@ref).

# External links
$(_doc_external("MPI_Neighbor_alltoallv"))
"""
function Neighbor_alltoallv!(sendbuf::VBuffer, recvbuf::VBuffer, graph_comm::Comm)
    # int MPI_Neighbor_alltoallv!(const void* sendbuf, const int sendcounts[],
    #                             const int sdispls[], MPI_Datatype sendtype, void* recvbuf,
    #                             const int recvcounts[], const int rdispls[],
    #                             MPI_Datatype recvtype, MPI_Comm comm)
    API.MPI_Neighbor_alltoallv(sendbuf.data, sendbuf.counts, sendbuf.displs, sendbuf.datatype,
                               recvbuf.data, recvbuf.counts, recvbuf.displs, recvbuf.datatype,
                               graph_comm)
    return recvbuf.data
end

"""
    Neighbor_allgather!(sendbuf::Buffer, recvbuf::UBuffer, comm::Comm)

Perform an all-gather communication along the directed edges of the graph.

See also [`MPI.Allgather!`](@ref).

# External links
$(_doc_external("MPI_Neighbor_allgather"))
"""
function Neighbor_allgather!(sendbuf::Buffer, recvbuf::UBuffer, graph_comm::Comm)
    # int MPI_Neighbor_allgather(const void* sendbuf, int sendcount,
    #                            MPI_Datatype sendtype, void* recvbuf, int recvcount,
    #                            MPI_Datatype recvtype, MPI_Comm comm)
    API.MPI_Neighbor_allgather(sendbuf.data, sendbuf.count, sendbuf.datatype,
                               recvbuf.data, recvbuf.count, recvbuf.datatype, graph_comm)
    return recvbuf.data
end
Neighbor_allgather!(sendbuf, recvbuf::UBuffer, graph_comm::Comm) =
    Neighbor_allgather!(Buffer_send(sendbuf), recvbuf, graph_comm)

Neighbor_allgather!(sendbuf::Union{Ref,AbstractArray}, recvbuf::AbstractArray, graph_comm::Comm) =
    Neighbor_allgather!(sendbuf, UBuffer(recvbuf, length(sendbuf)), graph_comm)


Neighbor_allgather!(sendrecvbuf::UBuffer, graph_comm::Comm) =
    Neighbor_allgather!(IN_PLACE, sendrecvbuf, graph_comm)

"""
    Neighbor_allgatherv!(sendbuf::Buffer, recvbuf::VBuffer, comm::Comm)

Perform an all-gather communication along the directed edges of the graph with variable sized data.

See also [`MPI.Allgatherv!`](@ref).

# External links
$(_doc_external("MPI_Neighbor_allgatherv"))
"""
function Neighbor_allgatherv!(sendbuf::Buffer, recvbuf::VBuffer, graph_comm::Comm)
    # int MPI_Neighbor_allgatherv(const void *sendbuf, int sendcount, MPI_Datatype sendtype,
    #                             void *recvbuf, const int recvcounts[], const int displs[],
    #                             MPI_Datatype recvtype, MPI_Comm comm)
    API.MPI_Neighbor_allgatherv(sendbuf.data, sendbuf.count, sendbuf.datatype,
                                recvbuf.data, recvbuf.counts, recvbuf.displs, recvbuf.datatype, graph_comm)
    return recvbuf.data
end
Neighbor_allgatherv!(sendbuf, recvbuf::VBuffer, graph_comm::Comm) =
    Neighbor_allgatherv!(Buffer_send(sendbuf), recvbuf, graph_comm)

Neighbor_allgatherv!(sendbuf::Union{Ref,AbstractArray}, recvbuf::AbstractArray, graph_comm::Comm) =
    Neighbor_allgatherv!(sendbuf, VBuffer(recvbuf, length(sendbuf)), graph_comm)


Neighbor_allgatherv!(sendrecvbuf::VBuffer, graph_comm::Comm) =
    Neighbor_allgatherv!(IN_PLACE, sendrecvbuf, graph_comm)
