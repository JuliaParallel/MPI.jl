import Base: eltype

# definition of the `Status` struct.
# TODO: this bakes in a lot of assumptions about ordering and padding
if !@isdefined(Status)
    let
        struct_fields = Any[]
        offset = 0
        i = 0

        while offset < MPI_Status_Source_offset
            push!(struct_fields, :($(Symbol(:_pad, i+=1))::Cint))
            offset += 4
        end
        @assert offset == MPI_Status_Source_offset
        push!(struct_fields, :(source::Cint))
        offset += 4

        while offset < MPI_Status_Tag_offset
            push!(struct_fields, :($(Symbol(:_pad, i+=1))::Cint))
            offset += 4
        end
        @assert offset == MPI_Status_Tag_offset
        push!(struct_fields, :(tag::Cint))
        offset += 4

        while offset < MPI_Status_Error_offset
            push!(struct_fields, :($(Symbol(:_pad, i+=1))::Cint))
            offset += 4
        end
        @assert offset == MPI_Status_Error_offset
        push!(struct_fields, :(error::Cint))
        offset += 4

        while offset < MPI_Status_size
            push!(struct_fields, :($(Symbol(:_pad, i+=1))::Cint))
            offset += 4
        end

        @eval struct Status
            $(struct_fields...)
        end
    end

    @assert fieldoffset(Status, findfirst(isequal(:source), fieldnames(Status))) == MPI_Status_Source_offset
    @assert fieldoffset(Status, findfirst(isequal(:tag), fieldnames(Status))) == MPI_Status_Tag_offset
    @assert fieldoffset(Status, findfirst(isequal(:error), fieldnames(Status))) == MPI_Status_Error_offset
    @assert sizeof(Status) == MPI_Status_size
end


"""
    MPI.Status

The status of an MPI receive communication. It has 3 accessible fields

- `source`: source of the received message
- `tag`: tag of the received message
- `error`: error code. This is only set if a function returns multiple statuses.

Additionally, the accessor function [`MPI.Get_count`](@ref) can be used to determine the
number of entries received.
"""
Status

Get_source(status::Status) = Int(status.source)
Get_tag(status::Status) = Int(status.tag)
Get_error(status::Status) = Int(status.error)

"""
    MPI.Request

An MPI Request object, representing a non-blocking communication. This also contains a
reference to the buffer used in the communication to ensure it isn't garbage-collected
during communication.
"""
@mpi_handle Request buffer

const REQUEST_NULL = _Request(MPI_REQUEST_NULL, nothing)
Request() = Request(REQUEST_NULL.val, nothing)

"""
    status = Probe(src::Integer, tag::Integer, comm::Comm)

Blocks until there is a message that can be received matching `src`, `tag` and
`comm`. Returns the corresponding [`Status`](@ref) object.

# External links
$(_doc_external("MPI_Probe"))
"""
function Probe(src::Integer, tag::Integer, comm::Comm)
    stat_ref = Ref{Status}()
    @mpichk ccall((:MPI_Probe, libmpi), Cint,
          (Cint, Cint, MPI_Comm, Ptr{Status}),
          src, tag, comm, stat_ref)
    stat_ref[]
end

"""
    ismessage, (status|nothing) = Iprobe(src::Integer, tag::Integer, comm::Comm)

Checks if there is a message that can be received matching `src`, `tag` and `comm`. If so,
returns a tuple `true` and a [`Status`](@ref) object, otherwise returns a tuple `false, nothing`.

# External links
$(_doc_external("MPI_Iprobe"))
"""
function Iprobe(src::Integer, tag::Integer, comm::Comm)
    flag = Ref{Cint}()
    stat_ref = Ref{Status}()
    @mpichk ccall((:MPI_Iprobe, libmpi), Cint,
          (Cint, Cint, MPI_Comm, Ptr{Cint}, Ptr{Status}),
          src, tag, comm, flag, stat_ref)
    if flag[] == 0
        return false, nothing
    end
    true, stat_ref[]
end

"""
    MPI.Get_count(status::Status, T)

The number of entries received. `T` should match the argument provided by the receive call that set the status variable.

If the number of entries received exceeds the limits of the count parameter, then it returns `MPI_UNDEFINED`.

# External links
$(_doc_external("MPI_Get_count"))
"""
function Get_count(stat::Status, datatype::Union{MPI_Datatype, Datatype})
    count = Ref{Cint}()
    @mpichk ccall((:MPI_Get_count, libmpi), Cint,
                  (Ptr{Status}, MPI_Datatype, Ptr{Cint}),
                  Ref(stat), datatype, count)
    Int(count[])
end
Get_count(stat::Status, ::Type{T}) where {T} = Get_count(stat, mpitype(T))


"""
    Send(buf, [count::Integer, [datatype::Datatype,]]
         dest::Integer, tag::Integer, comm::Comm) where T

Perform a blocking send of `count` elements of type `datatype` from `buf` to MPI
rank `dest` of communicator `comm` using the message tag `tag`

If not provided, `datatype` and `count` are derived from the element type and length of
`buf`, respectively.

# External links
$(_doc_external("MPI_Send"))
"""
function Send(buf, count::Integer, datatype::Union{Datatype, MPI_Datatype},
              dest::Integer, tag::Integer, comm::Comm)
    # int MPI_Send(const void* buf, int count, MPI_Datatype datatype, int dest,
    #              int tag, MPI_Comm comm)
    @mpichk ccall((:MPI_Send, libmpi), Cint,
          (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm),
          buf, count, datatype, dest, tag, comm)
    return nothing
end

Send(buf, count::Integer, dest::Integer, tag::Integer, comm::Comm) =
    Send(buf, count, mpitype(eltype(buf)), dest, tag, comm)
Send(buf::AbstractArray, dest::Integer, tag::Integer, comm::Comm) =
    Send(buf, length(buf), dest, tag, comm)


"""
    Send(obj::T, dest::Integer, tag::Integer, comm::Comm) where T

Complete a blocking send of `obj` to MPI rank `dest` of communicator `comm`
using with the message tag `tag`.
"""
function Send(obj::T, dest::Integer, tag::Integer, comm::Comm) where T
    buf = [obj]
    Send(buf, dest, tag, comm)
end

"""
    send(obj, dest::Integer, tag::Integer, comm::Comm)

Complete a blocking send of using a serialized version of `obj` to MPI rank
`dest` of communicator `comm` using with the message tag `tag`.
"""
function send(obj, dest::Integer, tag::Integer, comm::Comm)
    buf = MPI.serialize(obj)
    Send(buf, dest, tag, comm)
end

"""
    Isend(buf, [count::Integer, [datatype::Datatype,]]
          dest::Integer, tag::Integer, comm::Comm)

Starts a nonblocking send of `count` elements of type `datatype` from `buf` to
MPI rank `dest` of communicator `comm` using with the message tag `tag`

If not provided, `datatype` and `count` are derived from the element type and length of
`buf`, respectively.

Returns the [`Request`](@ref) object for the nonblocking send.

# External links
$(_doc_external("MPI_Isend"))
"""
function Isend(buf, count::Integer, datatype::Union{Datatype, MPI_Datatype},
               dest::Integer, tag::Integer, comm::Comm)
    req = Request()
    # int MPI_Isend(const void* buf, int count, MPI_Datatype datatype, int dest,
    #               int tag, MPI_Comm comm, MPI_Request *request)
    @mpichk ccall((:MPI_Isend, libmpi), Cint,
          (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}),
                  buf, count, datatype, dest, tag, comm, req)
    req.buffer = buf
    return req
end

Isend(buf, count::Integer, dest::Integer, tag::Integer, comm::Comm) =
    Isend(buf, count, mpitype(eltype(buf)), dest, tag, comm)
Isend(buf::AbstractArray, dest::Integer, tag::Integer, comm::Comm) =
    Isend(buf, length(buf), dest, tag, comm)

"""
    Isend(obj::T, dest::Integer, tag::Integer, comm::Comm) where T

Starts a nonblocking send of `obj` to MPI rank `dest` of communicator `comm`
using with the message tag `tag`.

Returns the commication `Request` for the nonblocking send.
"""
function Isend(obj::T, dest::Integer, tag::Integer, comm::Comm) where T
    buf = [obj]
    Isend(buf, dest, tag, comm)
end

"""
    isend(obj, dest::Integer, tag::Integer, comm::Comm)

Starts a nonblocking send of using a serialized version of `obj` to MPI rank
`dest` of communicator `comm` using with the message tag `tag`.

Returns the commication `Request` for the nonblocking send.
"""
function isend(obj, dest::Integer, tag::Integer, comm::Comm)
    buf = MPI.serialize(obj)
    Isend(buf, dest, tag, comm)
end

"""
    Recv!(buf, [count::Integer, [datatype::Datatype,]]
          src::Integer, tag::Integer, comm::Comm)

Completes a blocking receive of up to `count` elements of type `datatype` into `buf`
from MPI rank `src` of communicator `comm` using with the message tag `tag`

If not provided, `datatype` and `count` are derived from the element type and length of
`buf`, respectively.

Returns the [`Status`](@ref) of the receive.

# External links
$(_doc_external("MPI_Recv"))
"""
function Recv!(buf, count::Integer, datatype::Union{Datatype,MPI_Datatype}, src::Integer,
               tag::Integer, comm::Comm)
    stat_ref = Ref{Status}()
    # int MPI_Recv(void* buf, int count, MPI_Datatype datatype, int source,
    #              int tag, MPI_Comm comm, MPI_Status *status)
    @mpichk ccall((:MPI_Recv, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{Status}),
                  buf, count, datatype, src, tag, comm, stat_ref)
    return stat_ref[]
end

Recv!(buf, count::Integer, src::Integer, tag::Integer, comm::Comm) =
    Recv!(buf, count, mpitype(eltype(buf)), src, tag, comm)
Recv!(buf::AbstractArray, src::Integer, tag::Integer, comm::Comm) =
    Recv!(buf, length(buf), src, tag, comm)

function Recv(::Type{T}, src::Integer, tag::Integer, comm::Comm) where T
    buf = Ref{T}()
    stat = Recv!(buf, 1, src, tag, comm)
    (buf[], stat)
end

function recv(src::Integer, tag::Integer, comm::Comm)
    stat = Probe(src, tag, comm)
    count = Get_count(stat, UInt8)
    buf = Array{UInt8}(undef, count)
    stat = Recv!(buf, Get_source(stat), Get_tag(stat), comm)
    (MPI.deserialize(buf), stat)
end

"""
    Irecv!(buf, [count::Integer, [datatype::Datatype,]]
           src::Integer, tag::Integer, comm::Comm) where T

Starts a nonblocking receive of up to `count` elements of type `datatype` into `buf`
from MPI rank `src` of communicator `comm` using with the message tag `tag`

Returns the [`Request`](@ref) for the nonblocking receive.

# External links
$(_doc_external("MPI_Irecv"))
"""
function Irecv!(buf, count::Integer, datatype::Union{Datatype, MPI_Datatype},
                    src::Integer, tag::Integer, comm::Comm) where T
    req = Request()
    # int MPI_Irecv(void* buf, int count, MPI_Datatype datatype, int source,
    #               int tag, MPI_Comm comm, MPI_Request *request)
    @mpichk ccall((:MPI_Irecv, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}),
                  buf, count, datatype, src, tag, comm, req)
    req.buffer = buf
    return req
end

Irecv!(buf, count::Integer, src::Integer, tag::Integer, comm::Comm) =
    Irecv!(buf, count, mpitype(eltype(buf)), src, tag, comm)
Irecv!(buf::AbstractArray, src::Integer, tag::Integer, comm::Comm) =
    Irecv!(buf, length(buf), src, tag, comm)


function irecv(src::Integer, tag::Integer, comm::Comm)
    (flag, stat) = Iprobe(src, tag, comm)
    if !flag
        return (false, nothing, nothing)
    end
    count = Get_count(stat, UInt8)
    buf = Array{UInt8}(undef, count)
    stat = Recv!(buf, Get_source(stat), Get_tag(stat), comm)
    (true, MPI.deserialize(buf), stat)
end

"""
    Sendrecv!(sendbuf, [sendcount::Integer, [sendtype::Union{Datatype, MPI_Datatype}]],  
             dest::Integer, sendtag::Integer,
             recvbuf, [recvcount::Integer, [recvtype::Union{Datatype, MPI_Datatype}]], 
             source::Integer, recvtag::Integer,
             comm::Comm)

Complete a blocking send-receive operation over the MPI communicator `comm`. Send 
`sendcount` elements of type `sendtype` from `sendbuf` to the MPI rank `dest` using message 
tag `tag`, and receive `recvcount` elements of type `recvtype` from MPI rank `source` into 
the buffer `recvbuf` using message tag `tag`. Return a [`Status`](@ref) object.

If not provided, `sendtype`/`recvtype` and `sendcount`/`recvcount` are derived from the
element type and length of `sendbuf`/`recvbuf`, respectively.

# External links
$(_doc_external("MPI_Sendrecv"))
"""
function Sendrecv!(sendbuf, sendcount::Integer, sendtype::Union{Datatype, MPI_Datatype},   dest::Integer, sendtag::Integer,
                  recvbuf, recvcount::Integer, recvtype::Union{Datatype, MPI_Datatype}, source::Integer, recvtag::Integer,
                  comm::Comm)
    # int MPI_Sendrecv(const void *sendbuf, int sendcount, MPI_Datatype sendtype, int dest,   int sendtag,
    #                        void *recvbuf, int recvcount, MPI_Datatype recvtype, int source, int recvtag,
    #                    MPI_Comm comm, MPI_Status *status)
    stat_ref = Ref{Status}()
    @mpichk ccall((:MPI_Sendrecv, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype, Cint, Cint,
                   MPIPtr, Cint, MPI_Datatype, Cint, Cint,
                 MPI_Comm, Ptr{Status}),
                   sendbuf, sendcount, sendtype, dest,   sendtag,
                   recvbuf, recvcount, recvtype, source, recvtag, comm, stat_ref)
    return stat_ref[]
end

function Sendrecv!(sendbuf, sendcount::Integer,   dest::Integer, sendtag::Integer,
                  recvbuf, recvcount::Integer, source::Integer, recvtag::Integer,
                  comm::Comm)
    return Sendrecv!(sendbuf, sendcount, mpitype(eltype(sendbuf)), dest,   sendtag,
                    recvbuf, recvcount, mpitype(eltype(recvbuf)), source, recvtag, comm)
end
function Sendrecv!(sendbuf::AbstractArray,   dest::Integer, sendtag::Integer,
                  recvbuf::AbstractArray, source::Integer, recvtag::Integer,
                  comm::Comm)
    return Sendrecv!(sendbuf, length(sendbuf), dest,   sendtag,
                    recvbuf, length(recvbuf), source, recvtag, comm)
end

"""
    status = Wait!(req::Request)

Block until the request `req` is complete and deallocated. Returns the [`Status`](@ref) of the request.

# External links
$(_doc_external("MPI_Wait"))
"""
function Wait!(req::Request)
    stat_ref = Ref{Status}()
    # int MPI_Wait(MPI_Request *request, MPI_Status *status)
    @mpichk ccall((:MPI_Wait, libmpi), Cint,
                  (Ptr{MPI_Request}, Ptr{Status}),
                  req, stat_ref)
    req.buffer = nothing
    stat
end

"""
    iscomplete, (status|nothing) = Test!(req::Request)

Check if the request `req` is complete. If so, the request is deallocated and a tuple of
`true` and the [`Status`](@ref) of the request is returned. Otherwise a tuple of
`false, nothing` is returned.

# External links
$(_doc_external("MPI_Test"))
"""
function Test!(req::Request)
    flag = Ref{Cint}()
    stat_ref = Ref{Status}()
    # int MPI_Test(MPI_Request *request, int *flag, MPI_Status *status)
    @mpichk ccall((:MPI_Test, libmpi), Cint,
                  (Ptr{MPI_Request}, Ptr{Cint}, Ptr{Status}),
                  req, flag, stat_ref)
    if flag[] == 0
        return (false, nothing)
    end
    req.buffer = nothing
    (true, stat_ref[])
end

"""
    statuses = Waitall!(reqs::Vector{Request})

Block until all the requests in the array `reqs` are complete. Returns an array
of the [`Status`](@ref) objects corresponding to each request.

# External links
$(_doc_external("MPI_Waitall"))
"""
function Waitall!(reqs::Vector{Request})
    count = length(reqs)
    reqvals = [reqs[i].val for i in 1:count]
    stats = Array{Status}(undef, count)
    # int MPI_Waitall(int count, MPI_Request array_of_requests[],
    #                 MPI_Status array_of_statuses[])
    @mpichk ccall((:MPI_Waitall, libmpi), Cint,
                  (Cint, Ptr{MPI_Request}, Ptr{Status}),
                  count, reqvals, stats)
    for i in 1:count
        reqs[i].val = reqvals[i]
        reqs[i].buffer = nothing
    end
    return stats
end

"""
    iscomplete, (statuses|nothing) = Testall!(reqs::Vector{Request})

Check if all the requests in the array `reqs` are complete. If so, the requests are
deallocated and a tuple of `true` and an array of the [`Status`](@ref) objects
corresponding to each request is returned. Otherwise no requests are modified a tuple of
`false, nothing` is returned.

# External links
$(_doc_external("MPI_Testall"))
"""
function Testall!(reqs::Vector{Request})
    count = length(reqs)
    reqvals = [reqs[i].val for i in 1:count]
    flag = Ref{Cint}()
    stats = Array{Status}(undef, count)
    # int MPI_Testall(int count, MPI_Request array_of_requests[], int *flag,
    #                 MPI_Status array_of_statuses[])
    @mpichk ccall((:MPI_Testall, libmpi), Cint,
                  (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Status}),
                  count, reqvals, flag, stats)
    if flag[] == 0
        return (false, nothing)
    end
    for i in 1:count
        reqs[i].val = reqvals[i]
        reqs[i].buffer = nothing
    end
    (true, stats)
end


"""
    (index, status) = Waitany!(reqs::Vector{Request})

Blocks until one of the requests in the array `reqs` is complete: if more than one is
complete, one is chosen arbitrarily. The request is deallocated and a tuple of the index
of the completed request and its [`Status`](@ref) is returned.

# External links
$(_doc_external("MPI_Waitany"))
"""
function Waitany!(reqs::Vector{Request})
    count = length(reqs)
    reqvals = [reqs[i].val for i in 1:count]
    ind = Ref{Cint}()
    stat_ref = Ref{Status}()
    # int MPI_Waitany(int count, MPI_Request array_of_requests[], int *index,
    #                 MPI_Status *status)
    @mpichk ccall((:MPI_Waitany, libmpi), Cint,
                  (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Status}),
                  count, reqvals, ind, stat_ref)
    index = Int(ind[]) + 1
    reqs[index].val = reqvals[index]
    reqs[index].buffer = nothing
    (index, stat_ref[])
end

"""
    iscomplete, (index, status | 0, nothing) = Testany!(reqs::Vector{Request})

Check if any one of the requests in the array `reqs` is complete: if more than one is
complete, one is chosen arbitrarily. If so, the request is deallocated an a tuple of
`true`, its index and its [`Status`](@ref) is returned. Otherwise a tuple of `false, 0,
nothing` is returned.

# External links
$(_doc_external("MPI_Testany"))
"""
function Testany!(reqs::Vector{Request})
    count = length(reqs)
    reqvals = [req.val for req in reqs]
    ind = Ref{Cint}()
    flag = Ref{Cint}()
    stat_ref = Ref{Status}()
    # int MPI_Testany(int count, MPI_Request array_of_requests[], int *index,
    #                 int *flag, MPI_Status *status)
    @mpichk ccall((:MPI_Testany, libmpi), Cint,
                  (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{Status}),
                  count, reqvals, ind, flag, stat_ref)
    if flag[] == 0 || ind[] == MPI_UNDEFINED
        return (false, 0, nothing)
    end
    index = Int(ind[]) + 1
    reqs[index].val = reqvals[index]
    reqs[index].buffer = nothing
    (true, index, stat_ref[])
end

"""
    (indices, statuses) = Waitsome!(reqs::Vector{Request})

Block until at least one of the requests in the array `reqs` is complete. The completed
requests are deallocated, and a tuple of their indices in `reqs` and their corresponding
[`Status`](@ref) objects are returned.

# External links
$(_doc_external("MPI_Waitsome"))
"""
function Waitsome!(reqs::Vector{Request})
    count = length(reqs)
    reqvals = [reqs[i].val for i in 1:count]
    outcnt = Ref{Cint}()
    inds = Array{Cint}(undef, count)
    stats = Array{Status}(undef,count)
    # int MPI_Waitsome(int incount, MPI_Request array_of_requests[],
    #                  int *outcount, int array_of_indices[],
    #                  MPI_Status array_of_statuses[])
    @mpichk ccall((:MPI_Waitsome, libmpi), Cint,
          (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{Status}),
          count, reqvals, outcnt, inds, stats)
    outcount = Int(outcnt[])
    # This can happen if there were no valid requests
    if outcount == MPI_UNDEFINED
        outcount = 0
    end
    indices = Array{Int}(undef, outcount)
    for i in 1:outcount
        ind = Int(inds[i])+1
        reqs[ind].val = reqvals[ind]
        reqs[ind].buffer = nothing
        indices[i] = ind
    end
    (indices, stats)
end

"""
    (indices, statuses) = Testsome!(reqs::Vector{Request})

Similar to [`Waitsome!`](@ref) except that it returns immediately: if no operations have
completed then `indices` and `statuses` will be empty.

# External links
$(_doc_external("MPI_Testsome"))
"""
function Testsome!(reqs::Vector{Request})
    count = length(reqs)
    reqvals = [req.val for req in reqs]
    outcnt = Ref{Cint}()
    inds = Array{Cint}(undef, count)
    stats = Array{Status}(undef, count)
    # int MPI_Testsome(int incount, MPI_Request array_of_requests[],
    #                  int *outcount, int array_of_indices[],
    #                  MPI_Status array_of_statuses[])
    @mpichk ccall((:MPI_Testsome, libmpi), Cint,
                  (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{Status}),
                  count, reqvals, outcnt, inds, stats)
    outcount = outcnt[]
    # This can happen if there were no valid requests
    if outcount == MPI_UNDEFINED
        outcount = 0
    end
    indices = Array{Int}(undef, outcount)
    for i in 1:outcount
        ind = Int(inds[i])+1
        reqs[ind].val = reqvals[ind]
        reqs[ind].buffer = nothing
        indices[i] = ind
    end
    (indices, stats)
end

"""
    Cancel!(req::Request)

Marks a pending [`Irecv!`](@ref) operation for cancellation (cancelling a [`Isend`](@ref)
is deprecated). Note that the request is not deallocated, and can still be queried using
the test or wait functions.

# External links
$(_doc_external("MPI_Cancel"))
"""
function Cancel!(req::Request)
    # int MPI_Cancel(MPI_Request *request)
    @mpichk ccall((:MPI_Cancel, libmpi), Cint, (Ptr{MPI_Request},), req)
    req.buffer = nothing
    nothing
end
