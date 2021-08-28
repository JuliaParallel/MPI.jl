
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

`data` can be a [`Buffer`](@ref), or any object for which [`Buffer_send`](@ref) is defined.

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
    data = Recv!(recvbuf, src::Integer, tag::Integer, comm::Comm, nothing)
    data, status = Recv!(recvbuf, src::Integer, tag::Integer, comm::Comm, MPI.Status)

Completes a blocking receive into the buffer `recvbuf` from MPI rank `src` of communicator
`comm` using with the message tag `tag`.

`recvbuf` can be a [`Buffer`](@ref), or any object for which `Buffer(recvbuf)` is defined.

Returns the [`Status`](@ref) of the receive.

# See also
- [`Recv`](@ref) 
- [`recv`](@ref) 

# External links
$(_doc_external("MPI_Recv"))
"""
function Recv!(recvbuf::Buffer, src::Integer, tag::Integer, comm::Comm, status::Union{Ref{Status},Nothing})
    # int MPI_Recv(void* buf, int count, MPI_Datatype datatype, int source,
    #              int tag, MPI_Comm comm, MPI_Status *status)
    @mpichk ccall((:MPI_Recv, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{Status}),
                  recvbuf.data, recvbuf.count, recvbuf.datatype, src, tag, comm, something(status, MPI_STATUS_IGNORE))
    return recvbuf.data
end
Recv!(recvbuf, src::Integer, tag::Integer, comm::Comm, status::Union{Ref{Status},Nothing}) =
    Recv!(Buffer(recvbuf), src, tag, comm, status)
function Recv!(recvbuf, src::Integer, tag::Integer, comm::Comm, ::Type{Status})
    status = Ref{Status}()
    data = Recv!(recvbuf, src, tag, comm, status)
    return data, status[]
end

"""
    data = Recv(::Type{T}, src::Integer, tag::Integer, comm::Comm, nothing)
    data, status = Recv(::Type{T}, src::Integer, tag::Integer, comm::Comm, MPI.Status)

Completes a blocking receive of a single object of type `T` from MPI rank `src` of
communicator `comm` using with the message tag `tag`.

Returns a tuple of the object of type `T` and the [`Status`](@ref) of the receive.

# See also
- [`Recv!`](@ref) 
- [`recv`](@ref) 

# External links
$(_doc_external("MPI_Recv"))
"""
function Recv(::Type{T}, src::Integer, tag::Integer, comm::Comm, status::Union{Ref{Status}, Nothing}) where T
    data = Recv!(Ref{T}(), src, tag, comm, status)
    return data[]
end
function Recv(::Type{T}, src::Integer, tag::Integer, comm::Comm, ::Type{Status}) where T
    status = Ref{Status}()
    val = Recv(T, src, tag, comm, status)
    return val, status[]
end

"""
    recv(src::Integer, tag::Integer, comm::Comm)

Completes a blocking receive of a serialized object from MPI rank `src` of communicator
`comm` using with the message tag `tag`.

Returns the deserialized object and the [`Status`](@ref) of the receive.
"""
function recv(src::Integer, tag::Integer, comm::Comm, status::Union{Ref{Status}, Nothing})
    stat = Probe(src, tag, comm)
    count = Get_count(stat, UInt8)
    buf = Array{UInt8}(undef, count)
    stat = Recv!(buf, Get_source(stat), Get_tag(stat), comm)
    return MPI.deserialize(buf)
end
function recv(src::Integer, tag::Integer, comm::Comm, ::Type{Status})
    status = Ref{Status}()
    val = recv(src, tag, comm, status)
    return val, status[]
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
    data = Sendrecv!(
            sendbuf, dest::Integer, sendtag::Integer,
            recvbuf, source::Integer, recvtag::Integer,
            comm::Comm, nothing)
    data, status = Sendrecv!(
            sendbuf, dest::Integer, sendtag::Integer,
            recvbuf, source::Integer, recvtag::Integer,
            comm::Comm, MPI.Status)

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
                   comm::Comm, status::Union{Ref{Status}, Nothing})
    # int MPI_Sendrecv(const void *sendbuf, int sendcount, MPI_Datatype sendtype, int dest,   int sendtag,
    #                        void *recvbuf, int recvcount, MPI_Datatype recvtype, int source, int recvtag,
    #                    MPI_Comm comm, MPI_Status *status)
    @mpichk ccall((:MPI_Sendrecv, libmpi), Cint,
                  (MPIPtr, Cint, MPI_Datatype, Cint, Cint,
                   MPIPtr, Cint, MPI_Datatype, Cint, Cint,
                   MPI_Comm, Ptr{Status}),
                  sendbuf.data, sendbuf.count, sendbuf.datatype, dest, sendtag,
                  recvbuf.data, recvbuf.count, recvbuf.datatype, source, recvtag,
                  comm, status)
    return recvbuf.data
end
Sendrecv!(sendbuf, dest::Integer, sendtag::Integer, recvbuf, source::Integer, recvtag::Integer, comm::Comm, status::Union{Ref{Status}, Nothing}) =
    Sendrecv!(Buffer(sendbuf), dest, sendtag, Buffer(recvbuf), source, recvtag, comm, status)

function Sendrecv!(sendbuf, dest::Integer, sendtag::Integer, recvbuf, source::Integer, recvtag::Integer, comm::Comm, ::Type{Status})
    status = Ref{Status}()
    data = Sendrecv!(sendbuf, dest, sendtag, recvbuf, source, recvtag, comm, status)
    return data, status[]
end
