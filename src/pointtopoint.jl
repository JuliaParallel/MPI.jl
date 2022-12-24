
"""
    Send(buf, comm::Comm; dest::Integer, tag::Integer=0)

Perform a blocking send from the buffer `buf` to MPI rank `dest` of communicator
`comm` using the message tag `tag`.

    Send(obj, comm::Comm; dest::Integer, tag::Integer=0)

Complete a blocking send of an `isbits` object `obj` to MPI rank `dest` of
communicator `comm` using with the message tag `tag`.

# External links
$(_doc_external("MPI_Send"))
"""
Send(data, comm::Comm; dest::Integer, tag::Integer=Cint(0)) =
    Send(data, dest, tag, comm)


function Send(buf::Buffer, dest::Integer, tag::Integer, comm::Comm)
    # int MPI_Send(const void* buf, int count, MPI_Datatype datatype, int dest,
    #              int tag, MPI_Comm comm)
    API.MPI_Send(buf.data, buf.count, buf.datatype, dest, tag, comm)
    return nothing
end
Send(arr::Union{Ref,AbstractArray}, dest::Integer, tag::Integer, comm::Comm) =
    Send(Buffer(arr), dest, tag, comm)
function Send(obj::T, dest::Integer, tag::Integer, comm::Comm) where T
    buf = Ref{T}(obj)
    Send(buf, dest, tag, comm)
end

"""
    send(obj, comm::Comm; dest::Integer, tag::Integer=0)

Complete a blocking send using a serialized version of `obj` to MPI rank
`dest` of communicator `comm` using with the message tag `tag`.
"""
send(obj, comm::Comm; dest::Integer, tag::Integer=0) =
    send(obj, dest, tag, comm)
function send(obj, dest::Integer, tag::Integer, comm::Comm)
    buf = MPI.serialize(obj)
    Send(buf, dest, tag, comm)
end

"""
    Isend(data, comm::Comm[, req::AbstractRequest = Request()]; dest::Integer, tag::Integer=0)

Starts a nonblocking send of `data` to MPI rank `dest` of communicator `comm` using with
the message tag `tag`.

`data` can be a [`Buffer`](@ref), or any object for which [`Buffer_send`](@ref) is defined.

Returns the [`AbstractRequest`](@ref) object for the nonblocking send.

# External links
$(_doc_external("MPI_Isend"))
"""
Isend(data, comm::Comm, req::AbstractRequest=Request(); dest::Integer, tag::Integer=0) =
    Isend(data, dest, tag, comm, req)

function Isend(buf::Buffer, dest::Integer, tag::Integer, comm::Comm, req::AbstractRequest=Request())
    @assert isnull(req)
    # int MPI_Isend(const void* buf, int count, MPI_Datatype datatype, int dest,
    #               int tag, MPI_Comm comm, MPI_Request *request)
    API.MPI_Isend(buf.data, buf.count, buf.datatype, dest, tag, comm, req)
    setbuffer!(req, buf)
    return req
end
Isend(data, dest::Integer, tag::Integer, comm::Comm, req::AbstractRequest=Request()) =
    Isend(Buffer_send(data), dest, tag, comm, req)

"""
    isend(obj, comm::Comm[, req::AbstractRequest = Request()]; dest::Integer, tag::Integer=0)

Starts a nonblocking send of using a serialized version of `obj` to MPI rank
`dest` of communicator `comm` using with the message tag `tag`.

Returns the commication `Request` for the nonblocking send.
"""
isend(data, comm::Comm, req::AbstractRequest = Request(); dest::Integer, tag::Integer=0) =
    isend(data, dest, tag, comm, req)
function isend(obj, dest::Integer, tag::Integer, comm::Comm, req::AbstractRequest = Request())
    buf = MPI.serialize(obj)
    Isend(buf, dest, tag, comm, req)
end

"""
    data = Recv!(recvbuf, comm::Comm;
            source::Integer=MPI.ANY_SOURCE, tag::Integer=MPI.ANY_TAG)
    data, status = Recv!(recvbuf, comm::Comm, MPI.Status;
            source::Integer=MPI.ANY_SOURCE, tag::Integer=MPI.ANY_TAG)

Completes a blocking receive into the buffer `recvbuf` from MPI rank `source` of communicator
`comm` using with the message tag `tag`.

`recvbuf` can be a [`Buffer`](@ref), or any object for which `Buffer(recvbuf)` is defined.

Optionally returns the [`Status`](@ref) object of the receive.

# See also
- [`Recv`](@ref)
- [`recv`](@ref)

# External links
$(_doc_external("MPI_Recv"))
"""
Recv!(recvbuf, comm::Comm, status=nothing; source=API.MPI_ANY_SOURCE[], tag=API.MPI_ANY_TAG[]) =
    Recv!(recvbuf, source, tag, comm, status)

function Recv!(recvbuf::Buffer, source::Integer, tag::Integer, comm::Comm, status::Union{Ref{Status},Nothing})
    # int MPI_Recv(void* buf, int count, MPI_Datatype datatype, int source,
    #              int tag, MPI_Comm comm, MPI_Status *status)
    API.MPI_Recv(recvbuf.data, recvbuf.count, recvbuf.datatype, source, tag, comm, something(status, API.MPI_STATUS_IGNORE[]))
    return recvbuf.data
end
Recv!(recvbuf, source::Integer, tag::Integer, comm::Comm, status::Union{Ref{Status},Nothing}) =
    Recv!(Buffer(recvbuf), source, tag, comm, status)
function Recv!(recvbuf, source::Integer, tag::Integer, comm::Comm, ::Type{Status})
    status = Ref(STATUS_ZERO)
    data = Recv!(recvbuf, source, tag, comm, status)
    return data, status[]
end

"""
    data = Recv(::Type{T}, comm::Comm;
            source::Integer=MPI.ANY_SOURCE, tag::Integer=MPI.ANY_TAG)
    data, status = Recv(::Type{T}, comm::Comm, MPI.Status;
            source::Integer=MPI.ANY_SOURCE, tag::Integer=MPI.ANY_TAG)

Completes a blocking receive of a single `isbits` object of type `T` from MPI rank `source` of
communicator `comm` using with the message tag `tag`.

Returns a tuple of the object of type `T` and optionally the [`Status`](@ref) of the receive.

# See also
- [`Recv!`](@ref)
- [`recv`](@ref)

# External links
$(_doc_external("MPI_Recv"))
"""
Recv(::Type{T}, comm::Comm, status=nothing; source=API.MPI_ANY_SOURCE[], tag=API.MPI_ANY_TAG[]) where {T} =
    Recv(T, source, tag, comm, status)

function Recv(::Type{T}, source::Integer, tag::Integer, comm::Comm, status::Union{Ref{Status}, Nothing}) where T
    data = Recv!(Ref{T}(), source, tag, comm, status)
    return data[]
end
function Recv(::Type{T}, source::Integer, tag::Integer, comm::Comm, ::Type{Status}) where T
    status = Ref(STATUS_ZERO)
    val = Recv(T, source, tag, comm, status)
    return val, status[]
end

"""
    obj = recv(comm::Comm;
            source::Integer=MPI.ANY_SOURCE, tag::Integer=MPI.ANY_TAG)
    obj, status = recv(comm::Comm, MPI.Status;
            source::Integer=MPI.ANY_SOURCE, tag::Integer=MPI.ANY_TAG)

Completes a blocking receive of a serialized object from MPI rank `source` of communicator
`comm` using with the message tag `tag`.

Returns the deserialized object and optionally the [`Status`](@ref) of the receive.
"""
recv(comm::Comm, status=nothing; source::Integer=API.MPI_ANY_SOURCE[], tag::Integer=API.MPI_ANY_TAG[]) =
    recv(source, tag, comm, status)
function recv(source::Integer, tag::Integer, comm::Comm, status::Union{Ref{Status}, Nothing})
    stat = Probe(comm, Status; source=source, tag=tag)
    count = Get_count(stat, UInt8)
    buf = Array{UInt8}(undef, count)
    stat = Recv!(buf, comm, status; source=Get_source(stat), tag=Get_tag(stat))
    return MPI.deserialize(buf)
end
function recv(source::Integer, tag::Integer, comm::Comm, ::Type{Status})
    status = Ref(STATUS_ZERO)
    val = recv(source, tag, comm, status)
    return val, status[]
end



"""
    req = Irecv!(recvbuf, comm::Comm[, req::AbstractRequest = Request()];
            source::Integer=MPI.ANY_SOURCE, tag::Integer=MPI.ANY_TAG)

Starts a nonblocking receive into the buffer `data` from MPI rank `source` of communicator
`comm` using with the message tag `tag`.

`data` can be a [`Buffer`](@ref), or any object for which `Buffer(data)` is defined.

Returns the [`AbstractRequest`](@ref) object for the nonblocking receive.

# External links
$(_doc_external("MPI_Irecv"))
"""
Irecv!(recvbuf, comm::Comm, req::AbstractRequest=Request(); source::Integer=API.MPI_ANY_SOURCE[], tag::Integer=API.MPI_ANY_TAG[]) =
    Irecv!(recvbuf, source, tag, comm, req)
function Irecv!(buf::Buffer, source::Integer, tag::Integer, comm::Comm, req::AbstractRequest=Request())
    @assert isnull(req)
    # int MPI_Irecv(void* buf, int count, MPI_Datatype datatype, int source,
    #               int tag, MPI_Comm comm, MPI_Request *request)
    API.MPI_Irecv(buf.data, buf.count, buf.datatype, source, tag, comm, req)
    setbuffer!(req, buf)
    return req
end
Irecv!(data, source::Integer, tag::Integer, comm::Comm, req::AbstractRequest=Request()) =
    Irecv!(Buffer(data), source, tag, comm, req)


"""
    data = Sendrecv!(sendbuf, recvbuf, comm;
            dest::Integer, sendtag::Integer=0, source::Integer=MPI.ANY_SOURCE, recvtag::Integer=MPI.ANY_TAG)
    data, status = Sendrecv!(sendbuf, recvbuf, comm, MPI.Status;
            dest::Integer, sendtag::Integer=0, source::Integer=MPI.ANY_SOURCE, recvtag::Integer=MPI.ANY_TAG)

Complete a blocking send-receive operation over the MPI communicator `comm`. Send `sendbuf`
to the MPI rank `dest` using message tag `sendtag`, and receive from MPI rank `source` into the
buffer `recvbuf` using message tag `recvtag`. Return a [`Status`](@ref) object.

# External links
$(_doc_external("MPI_Sendrecv"))
"""
Sendrecv!(sendbuf, recvbuf, comm::MPI.Comm, status=nothing; dest::Integer, sendtag::Integer=0, source::Integer=API.MPI_ANY_SOURCE[], recvtag::Integer=API.MPI_ANY_TAG[]) =
    Sendrecv!(sendbuf, dest, sendtag, recvbuf, source, recvtag, comm, status)

function Sendrecv!(sendbuf::Buffer, dest::Integer, sendtag::Integer,
                   recvbuf::Buffer, source::Integer, recvtag::Integer,
                   comm::Comm, status::Union{Ref{Status}, Nothing})
    # int MPI_Sendrecv(const void *sendbuf, int sendcount, MPI_Datatype sendtype, int dest,   int sendtag,
    #                        void *recvbuf, int recvcount, MPI_Datatype recvtype, int source, int recvtag,
    #                    MPI_Comm comm, MPI_Status *status)
    API.MPI_Sendrecv(sendbuf.data, sendbuf.count, sendbuf.datatype, dest, sendtag,
                     recvbuf.data, recvbuf.count, recvbuf.datatype, source, recvtag,
                     comm, something(status, API.MPI_STATUS_IGNORE[]))
    return recvbuf.data
end
Sendrecv!(sendbuf, dest::Integer, sendtag::Integer, recvbuf, source::Integer, recvtag::Integer, comm::Comm, status::Union{Ref{Status}, Nothing}) =
    Sendrecv!(Buffer(sendbuf), dest, sendtag, Buffer(recvbuf), source, recvtag, comm, status)

function Sendrecv!(sendbuf, dest::Integer, sendtag::Integer, recvbuf, source::Integer, recvtag::Integer, comm::Comm, ::Type{Status})
    status = Ref(STATUS_ZERO)
    data = Sendrecv!(sendbuf, dest, sendtag, recvbuf, source, recvtag, comm, status)
    return data, status[]
end

# persistent requests
"""
    Send_init(buf, comm[, req::AbstractRequest = Request()];
        dest, tag=0)

Allocate a persistent send request, returning a [`AbstractRequest`](@ref) object. Use
[`Start`](@ref) or [`Startall`](@ref) to start the communication operation, and
`free` to deallocate the request.

# External links
$(_doc_external("MPI_Send_init"))
"""
Send_init(buf, comm::Comm, req::AbstractRequest=Request(); dest::Integer, tag::Integer=0) =
    Send_init(buf, dest, tag, comm, req)
function Send_init(buf::Buffer, dest::Integer, tag::Integer, comm::Comm, req::AbstractRequest=Request())
    @assert isnull(req)
    API.MPI_Send_init(buf.data, buf.count, buf.datatype, dest, tag, comm, req)
    setbuffer!(req, buf)
    return req
end
Send_init(buf, dest::Integer, tag::Integer, comm::Comm, req::AbstractRequest=Request()) =
    Send_init(Buffer(buf), dest, tag, comm, req)

"""
    Recv_init(buf, comm[, req::AbstractRequest = Request()];
        source=MPI.ANY_SOURCE, tag=MPI.ANY_TAG)

Allocate a persistent receive request, returning a [`AbstractRequest`](@ref) object. Use
[`Start`](@ref) or [`Startall`](@ref) to start the communication operation, and
`free` to deallocate the request.

# External links
$(_doc_external("MPI_Recv_init"))
"""
Recv_init(buf, comm::Comm, req::AbstractRequest=Request(); source=API.MPI_ANY_SOURCE[], tag=API.MPI_ANY_TAG[]) =
    Recv_init(buf, source, tag, comm, req)
function Recv_init(buf::Buffer, source::Integer, tag::Integer, comm::Comm, req::AbstractRequest=Request())
    @assert isnull(req)
    API.MPI_Recv_init(buf.data, buf.count, buf.datatype, source, tag, comm, req)
    setbuffer!(req, buf)
    return req
end
Recv_init(buf, source::Integer, tag::Integer, comm::Comm, req::AbstractRequest=Request()) =
    Recv_init(Buffer(buf), source, tag, comm, req)

"""
    Start(request::AbstractRequest)

Start a persistent communication request created by [`Send_init`](@ref) or
[`Recv_init`](@ref). Call [`Wait`](@ref) to complete the request.

# External links
$(_doc_external("MPI_Start"))
"""
function Start(req::AbstractRequest)
    API.MPI_Start(req)
    return nothing
end

"""
    Startall(reqs::AbstractVector{Request})

Start a set of persistent communication requests created by [`Send_init`](@ref)
or [`Recv_init`](@ref). Call [`Waitall`](@ref) to complete the requests.

# External links
$(_doc_external("MPI_Startall"))
"""
Startall(reqs::AbstractVector{Request}) = Startall(RequestSet(reqs))
function Startall(reqs::Union{AbstractMultiRequest, RequestSet})
    API.MPI_Startall(length(reqs), reqs.vals)
    update!(reqs)
    return nothing
end
