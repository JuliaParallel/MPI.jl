import Base: eltype

# definition of the `Status` struct.
# TODO: this bakes in a lot of assumptions about ordering and padding
if !@isdefined(Status)
    let
        struct_fields = Any[]
        empty_vals = Cint[]
        offset = 0
        i = 0

        while offset < MPI_Status_Source_offset
            push!(struct_fields, :($(Symbol(:_pad, i+=1))::Cint))
            push!(empty_vals, zero(Cint))
            offset += 4
        end
        @assert offset == MPI_Status_Source_offset
        push!(struct_fields, :(source::Cint))
        push!(empty_vals, MPI_ANY_SOURCE)
        offset += 4

        while offset < MPI_Status_Tag_offset
            push!(struct_fields, :($(Symbol(:_pad, i+=1))::Cint))
            push!(empty_vals, zero(Cint))
            offset += 4
        end
        @assert offset == MPI_Status_Tag_offset
        push!(struct_fields, :(tag::Cint))
        push!(empty_vals, MPI_ANY_TAG)
        offset += 4

        while offset < MPI_Status_Error_offset
            push!(struct_fields, :($(Symbol(:_pad, i+=1))::Cint))
            push!(empty_vals, zero(Cint))
            offset += 4
        end
        @assert offset == MPI_Status_Error_offset
        push!(struct_fields, :(error::Cint))
        push!(empty_vals, MPI_SUCCESS)
        offset += 4

        while offset < MPI_Status_size
            push!(struct_fields, :($(Symbol(:_pad, i+=1))::Cint))
            push!(empty_vals, zero(Cint))
            offset += 4
        end

        @eval begin
            struct Status
                $(struct_fields...)
            end
            const STATUS_EMPTY = Status($(empty_vals...))
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

The status of a Request can be checked by the [`Wait!`](@ref) and [`Test!`](@ref) functions
or their multiple-request variants, which will deallocate the request once it is
determined to be complete. Alternatively, it will be deallocated at finalization, meaning
that it is safe to ignore the request objects if the status of the communication can be
checked by other means.

See also [`Cancel!`](@ref).
"""
@mpi_handle Request MPI_Request buffer

const REQUEST_NULL = _Request(MPI_REQUEST_NULL, nothing)
Request() = Request(REQUEST_NULL.val, nothing)
isnull(req::Request) = req.val == REQUEST_NULL.val

function free(req::Request)
    if !isnull(req) && !MPI.Finalized()
        @mpichk ccall((:MPI_Request_free, libmpi), Cint, (Ptr{MPI_Request},), req)
        req.buffer = nothing
    end
    return nothing
end


"""
    status = Probe(src::Integer, tag::Integer, comm::Comm)

Blocks until there is a message that can be received matching `src`, `tag` and
`comm`. Returns the corresponding [`Status`](@ref) object.

# External links
$(_doc_external("MPI_Probe"))
"""
function Probe(src::Integer, tag::Integer, comm::Comm)
    stat_ref = Ref{Status}(MPI.STATUS_EMPTY)
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
    stat_ref = Ref{Status}(MPI.STATUS_EMPTY)
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
function Get_count(stat::Status, datatype::Datatype)
    count = Ref{Cint}()
    @mpichk ccall((:MPI_Get_count, libmpi), Cint,
                  (Ptr{Status}, MPI_Datatype, Ptr{Cint}),
                  Ref(stat), datatype, count)
    Int(count[])
end
Get_count(stat::Status, ::Type{T}) where {T} = Get_count(stat, Datatype(T))


"""
    Send(buf, dest::Integer, tag::Integer, comm::Comm)

Perform a blocking send from the buffer `buf` to MPI rank `dest` of communicator `comm`
using the message tag `tag`.

# External links
$(_doc_external("MPI_Send"))
"""
function Send(buf::Buffer, dest::Integer, tag::Integer, comm::Comm)
    # int MPI_Send(const void* buf, int count, MPI_Datatype datatype, int dest,
    #              int tag, MPI_Comm comm)
    @mpichk ccall((:MPI_Send, libmpi), Cint,
          (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm),
          buf.data, buf.count, buf.datatype, dest, tag, comm)
    return nothing
end
Send(arr::Union{Ref,AbstractArray}, dest::Integer, tag::Integer, comm::Comm) =
    Send(Buffer(arr), dest, tag, comm)


"""
    Send(obj::T, dest::Integer, tag::Integer, comm::Comm) where T

Complete a blocking send of `obj` to MPI rank `dest` of communicator `comm`
using with the message tag `tag`.
"""
function Send(obj::T, dest::Integer, tag::Integer, comm::Comm) where T
    buf = Ref{T}(obj)
    Send(buf, dest, tag, comm)
end

"""
    send(obj, dest::Integer, tag::Integer, comm::Comm)

Complete a blocking send using a serialized version of `obj` to MPI rank
`dest` of communicator `comm` using with the message tag `tag`.
"""
function send(obj, dest::Integer, tag::Integer, comm::Comm)
    buf = MPI.serialize(obj)
    Send(buf, dest, tag, comm)
end

"""
    Isend(data, dest::Integer, tag::Integer, comm::Comm)

Starts a nonblocking send of `data` to MPI rank `dest` of communicator `comm` using with
the message tag `tag`.

`data` can be a `Buffer`, or any object for which [`Buffer_send`](@ref) is defined.

Returns the [`Request`](@ref) object for the nonblocking send.

# External links
$(_doc_external("MPI_Isend"))
"""
function Isend(buf::Buffer, dest::Integer, tag::Integer, comm::Comm)
    req = Request()
    # int MPI_Isend(const void* buf, int count, MPI_Datatype datatype, int dest,
    #               int tag, MPI_Comm comm, MPI_Request *request)
    @mpichk ccall((:MPI_Isend, libmpi), Cint,
          (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}),
                  buf.data, buf.count, buf.datatype, dest, tag, comm, req)
    req.buffer = buf
    finalizer(free, req)
    return req
end
Isend(data, dest::Integer, tag::Integer, comm::Comm) =
    Isend(Buffer_send(data), dest, tag, comm)

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
    Recv!(data, src::Integer, tag::Integer, comm::Comm)

Completes a blocking receive into the buffer `data` from MPI rank `src` of communicator
`comm` using with the message tag `tag`.

`data` can be a [`Buffer`](@ref), or any object for which `Buffer(data)` is defined.

Returns the [`Status`](@ref) of the receive.

# See also
- [`Recv`](@ref) 
- [`recv`](@ref) 

# External links
$(_doc_external("MPI_Recv"))
"""
function Recv!(buf::Buffer, src::Integer, tag::Integer, comm::Comm)
    stat_ref = Ref{Status}(MPI.STATUS_EMPTY)
    # int MPI_Recv(void* buf, int count, MPI_Datatype datatype, int source,
    #              int tag, MPI_Comm comm, MPI_Status *status)
    @mpichk ccall((:MPI_Recv, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{Status}),
                  buf.data, buf.count, buf.datatype, src, tag, comm, stat_ref)
    return stat_ref[]
end
Recv!(buf, src::Integer, tag::Integer, comm::Comm) =
    Recv!(Buffer(buf), src, tag, comm)

"""
    Recv(::Type{T}, src::Integer, tag::Integer, comm::Comm)

Completes a blocking receive of an object of type `T` from MPI rank `src` of communicator
`comm` using with the message tag `tag`.

Returns a tuple of the object of type `T` and the [`Status`](@ref) of the receive.

# See also
- [`Recv!`](@ref) 
- [`recv`](@ref) 

# External links
$(_doc_external("MPI_Recv"))
"""
function Recv(::Type{T}, src::Integer, tag::Integer, comm::Comm) where T
    buf = Ref{T}()
    stat = Recv!(buf, src, tag, comm)
    (buf[], stat)
end

"""
    recv(src::Integer, tag::Integer, comm::Comm)

Completes a blocking receive of a serialized object from MPI rank `src` of communicator
`comm` using with the message tag `tag`.

Returns the deserialized object and the [`Status`](@ref) of the receive.
"""
function recv(src::Integer, tag::Integer, comm::Comm)
    stat = Probe(src, tag, comm)
    count = Get_count(stat, UInt8)
    buf = Array{UInt8}(undef, count)
    stat = Recv!(buf, Get_source(stat), Get_tag(stat), comm)
    (MPI.deserialize(buf), stat)
end

"""
    Irecv!(data, src::Integer, tag::Integer, comm::Comm)

Starts a nonblocking receive into the buffer `data` from MPI rank `src` of communicator
`comm` using with the message tag `tag`.

`data` can be a [`Buffer`](@ref), or any object for which `Buffer(data)` is defined.

Returns the [`Request`](@ref) for the nonblocking receive.

# External links
$(_doc_external("MPI_Irecv"))
"""
function Irecv!(buf::Buffer, src::Integer, tag::Integer, comm::Comm)
    req = Request()    
    # int MPI_Irecv(void* buf, int count, MPI_Datatype datatype, int source,
    #               int tag, MPI_Comm comm, MPI_Request *request)
    @mpichk ccall((:MPI_Irecv, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}),
                  buf.data, buf.count, buf.datatype, src, tag, comm, req)
    req.buffer = buf
    finalizer(free, req)
    return req
end
Irecv!(data, src::Integer, tag::Integer, comm::Comm) =
    Irecv!(Buffer(data), src, tag, comm)


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
    Sendrecv!(sendbuf, dest::Integer, sendtag::Integer,
              recvbuf, source::Integer, recvtag::Integer,
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
function Sendrecv!(sendbuf::Buffer, dest::Integer, sendtag::Integer,
                   recvbuf::Buffer, source::Integer, recvtag::Integer,
                   comm::Comm)
    # int MPI_Sendrecv(const void *sendbuf, int sendcount, MPI_Datatype sendtype, int dest,   int sendtag,
    #                        void *recvbuf, int recvcount, MPI_Datatype recvtype, int source, int recvtag,
    #                    MPI_Comm comm, MPI_Status *status)
    stat_ref = Ref{Status}(MPI.STATUS_EMPTY)
    @mpichk ccall((:MPI_Sendrecv, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype, Cint, Cint,
                   MPIPtr, Cint, MPI_Datatype, Cint, Cint,
                   MPI_Comm, Ptr{Status}),
                  sendbuf.data, sendbuf.count, sendbuf.datatype, dest, sendtag,
                  recvbuf.data, recvbuf.count, recvbuf.datatype, source, recvtag,
                  comm, stat_ref)
    return stat_ref[]
end
Sendrecv!(sendbuf, dest::Integer, sendtag::Integer, recvbuf, source::Integer, recvtag::Integer, comm::Comm) =
    Sendrecv!(Buffer(sendbuf), dest, sendtag, Buffer(recvbuf), source, recvtag, comm)


"""
    status = Wait!(req::Request)

Block until the request `req` is complete and deallocated. Returns the [`Status`](@ref) of the request.

# External links
$(_doc_external("MPI_Wait"))
"""
function Wait!(req::Request)
    stat_ref = Ref{Status}(MPI.STATUS_EMPTY)
    alreadynull = isnull(req)
    # int MPI_Wait(MPI_Request *request, MPI_Status *status)
    @mpichk ccall((:MPI_Wait, libmpi), Cint,
                  (Ptr{MPI_Request}, Ptr{Status}),
                  req, stat_ref)
    if !alreadynull
        req.buffer = nothing
    end
    stat
end

"""
    (flag, status) = Test!(req::Request)

Check if the request `req` is complete. If so, the request is deallocated and `flag` is returned `true` and `status` as the [`Status`](@ref) of the request. Otherwise `flag` is returned `false` and `status` is `nothing`.

# External links
$(_doc_external("MPI_Test"))
"""
function Test!(req::Request)
    flag = Ref{Cint}()
    stat_ref = Ref{Status}(MPI.STATUS_EMPTY)
    alreadynull = isnull(req)
    # int MPI_Test(MPI_Request *request, int *flag, MPI_Status *status)
    @mpichk ccall((:MPI_Test, libmpi), Cint,
                  (Ptr{MPI_Request}, Ptr{Cint}, Ptr{Status}),
                  req, flag, stat_ref)
    if flag[] == 0
        return (false, nothing)
    end
    if !alreadynull
        req.buffer = nothing
    end
    (true, stat_ref[])
end

"""
    statuses = Waitall!(reqs::Vector{Request})

Block until all active requests in the array `reqs` are complete. Returns an array of the
[`Status`](@ref) objects corresponding to each request.

# External links
$(_doc_external("MPI_Waitall"))
"""
function Waitall!(reqs::Vector{Request})
    count = length(reqs)
    reqvals = [reqs[i].val for i in 1:count]
    stats = fill(STATUS_EMPTY, count)
    # int MPI_Waitall(int count, MPI_Request array_of_requests[],
    #                 MPI_Status array_of_statuses[])
    @mpichk ccall((:MPI_Waitall, libmpi), Cint,
                  (Cint, Ptr{MPI_Request}, Ptr{Status}),
                  count, reqvals, stats)
    for i in 1:count
        req = reqs[i]
        if !isnull(req)
            req.val = reqvals[i]
            req.buffer = nothing
        end
    end
    return stats
end

"""
    (flag, statuses) = Testall!(reqs::Vector{Request})

Check if all active requests in the array `reqs` are complete. If so, the requests are
deallocated and `flag` is returned as `true` and `statuses` is an array of the
[`Status`](@ref) objects corresponding to each request is returned. Otherwise no requests
are modified a tuple of `false, nothing` is returned.

# External links
$(_doc_external("MPI_Testall"))
"""
function Testall!(reqs::Vector{Request})
    count = length(reqs)
    reqvals = [reqs[i].val for i in 1:count]
    flag = Ref{Cint}()
    stats = fill(STATUS_EMPTY, count)
    # int MPI_Testall(int count, MPI_Request array_of_requests[], int *flag,
    #                 MPI_Status array_of_statuses[])
    @mpichk ccall((:MPI_Testall, libmpi), Cint,
                  (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Status}),
                  count, reqvals, flag, stats)
    if flag[] == 0
        return (false, nothing)
    end
    for i in 1:count
        req = reqs[i]
        if !isnull(req)
            req.val = reqvals[i]
            req.buffer = nothing
        end
    end
    (true, stats)
end


"""
    (index, status) = Waitany!(reqs::Vector{Request})

Blocks until one of the requests in the array `reqs` is complete: if more than one is
complete, one is chosen arbitrarily. The request is deallocated and a tuple of the index
of the completed request and its [`Status`](@ref) is returned. If there are no active
requests, then `index` is returned as `0`.

# External links
$(_doc_external("MPI_Waitany"))
"""
function Waitany!(reqs::Vector{Request})
    count = length(reqs)
    reqvals = [reqs[i].val for i in 1:count]
    ind = Ref{Cint}()
    stat_ref = Ref{Status}(MPI.STATUS_EMPTY)
    # int MPI_Waitany(int count, MPI_Request array_of_requests[], int *index,
    #                 MPI_Status *status)
    @mpichk ccall((:MPI_Waitany, libmpi), Cint,
                  (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Status}),
                  count, reqvals, ind, stat_ref)
    if ind[] == MPI_UNDEFINED
        return (0, stat_ref[])
    end
    i = Int(ind[]) + 1
    req = reqs[i]
    if !isnull(req)
        req.val = reqvals[i]
        req.buffer = nothing
    end
    (i, stat_ref[])
end

"""
    (flag, index, status) = Testany!(reqs::Vector{Request})

Check if any one of the requests in the array `reqs` is complete.

If one or more requests are complete, then one is chosen arbitrarily, deallocated and `flag` is
returned as `true`, along with the index and the [`Status`](@ref) of the request.

Otherwise, if there are no complete requests, then `index` is returned as `0`, `status` as
`nothing`, and `flag` as `true` if there are no active requests and `false` otherwise.

# External links
$(_doc_external("MPI_Testany"))
"""
function Testany!(reqs::Vector{Request})
    count = length(reqs)
    reqvals = [req.val for req in reqs]
    ind = Ref{Cint}()
    flag = Ref{Cint}()
    stat_ref = Ref{Status}(MPI.STATUS_EMPTY)
    # int MPI_Testany(int count, MPI_Request array_of_requests[], int *index,
    #                 int *flag, MPI_Status *status)
    @mpichk ccall((:MPI_Testany, libmpi), Cint,
                  (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{Status}),
                  count, reqvals, ind, flag, stat_ref)
    if flag[] == 0
        return (false, 0, nothing)
    elseif ind[] == MPI_UNDEFINED
        return (true, 0, nothing)
    end
    i = Int(ind[]) + 1
    req = reqs[i]
    if !isnull(req)
        req.val = reqvals[i]
        req.buffer = nothing
    end
    (true, i, stat_ref[])
end

"""
    (indices, statuses) = Waitsome!(reqs::Vector{Request})

Block until at least one of the active requests in the array `reqs` is complete. The
completed requests are deallocated, and a tuple of their indices in `reqs` and their
corresponding [`Status`](@ref) objects are returned. If there are no active requests, then
the function returns immediately and `indices` and `statuses` are empty.

# External links
$(_doc_external("MPI_Waitsome"))
"""
function Waitsome!(reqs::Vector{Request})
    count = length(reqs)
    reqvals = [reqs[i].val for i in 1:count]
    outcnt = Ref{Cint}()
    inds = Array{Cint}(undef, count)
    stats = fill(STATUS_EMPTY, count)
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
    for j in 1:outcount
        i = Int(inds[j])+1
        req = reqs[i]
        if !isnull(req)
            req.val = reqvals[i]
            req.buffer = nothing
        end
        indices[j] = i
    end
    resize!(stats, outcount)
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
    stats = fill(STATUS_EMPTY, count)
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
    for j in 1:outcount
        i = Int(inds[j])+1
        req = reqs[i]
        if !isnull(req)
            req.val = reqvals[i]
            req.buffer = nothing
        end
        indices[j] = i
    end
    resize!(stats, outcount)
    (indices, stats)
end

"""
    Cancel!(req::Request)

Marks a pending [`Irecv!`](@ref) operation for cancellation (cancelling a [`Isend`](@ref),
while supported in some implementations, is deprecated as of MPI 3.1). Note that the
request is not deallocated, and can still be queried using the test or wait functions.

# External links
$(_doc_external("MPI_Cancel"))
"""
function Cancel!(req::Request)
    # int MPI_Cancel(MPI_Request *request)
    @mpichk ccall((:MPI_Cancel, libmpi), Cint, (Ptr{MPI_Request},), req)
    nothing
end
