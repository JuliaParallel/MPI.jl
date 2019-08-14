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

Get_source(status::Status) = Int(status.source)
Get_tag(status::Status) = Int(status.tag)
Get_error(status::Status) = Int(status.error)


@mpi_handle Request buffer

const REQUEST_NULL = _Request(MPI_REQUEST_NULL, nothing)
Request() = Request(REQUEST_NULL.val, nothing)

function Probe(src::Integer, tag::Integer, comm::Comm)
    stat_ref = Ref{Status}()
    @mpichk ccall((:MPI_Probe, libmpi), Cint,
          (Cint, Cint, MPI_Comm, Ptr{Status}),
          src, tag, comm, stat_ref)
    stat_ref[]
end

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

function Get_count(stat::Status, ::Type{T}) where T
    count = Ref{Cint}()
    @mpichk ccall((:MPI_Get_count, libmpi), Cint,
                  (Ptr{Status}, MPI_Datatype, Ptr{Cint}),
                  Ref(stat), mpitype(T), count)
    Int(count[])
end



"""
    Send(buf::MPIBuffertype{T}, count::Integer, datatype::Datatype,
         dest::Integer, tag::Integer, comm::Comm) where T

Complete a blocking send of `count` elements of type `datatype` from `buf` to MPI
rank `dest` of communicator `comm` using the message tag `tag`
"""
function Send(buf, count::Integer, datatype::Union{Datatype, MPI_Datatype},
              dest::Integer, tag::Integer, comm::Comm)
    # int MPI_Send(const void* buf, int count, MPI_Datatype datatype, int dest,
    #              int tag, MPI_Comm comm)
    @mpichk ccall((:MPI_Send, libmpi), Cint,
          (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm),
          buf, count, datatype, dest, tag, comm)
end

"""
    Send(buf::MPIBuffertype{T}, count::Integer, dest::Integer, tag::Integer,
         comm::Comm) where T

Complete a blocking send of `count` elements of `buf` to MPI rank `dest`
of communicator `comm` using with the message tag `tag`
"""
function Send(buf, count::Integer, dest::Integer,
              tag::Integer, comm::Comm)
    Send(buf, count, mpitype(eltype(buf)), dest, tag, comm)
end

"""
    Send(buf::AbstractArray{T}, dest::Integer, tag::Integer, comm::Comm) where T

Complete a blocking send of `buf` to MPI rank `dest` of communicator `comm`
using with the message tag `tag`
"""
function Send(buf::AbstractArray{T}, dest::Integer, tag::Integer, comm::Comm) where T
    Send(buf, length(buf), dest, tag, comm)
end

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
    Isend(buf::MPIBuffertype{T}, count::Integer, datatype::Datatype,
          dest::Integer, tag::Integer, comm::Comm) where T

Starts a nonblocking send of `count` elements of type `datatype` from `buf` to
MPI rank `dest` of communicator `comm` using with the message tag `tag`

Returns the commication `Request` for the nonblocking send.
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

"""
    Isend(buf::MPIBuffertype{T}, count::Integer, dest::Integer, tag::Integer,
          comm::Comm) where T

Starts a nonblocking send of `count` elements of `buf` to MPI rank `dest`
of communicator `comm` using with the message tag `tag`

Returns the commication `Request` for the nonblocking send.
"""
function Isend(buf, count::Integer,
               dest::Integer, tag::Integer, comm::Comm)
    Isend(buf, count, mpitype(eltype(buf)), dest, tag, comm)
end

"""
    Isend(buf::Array{T}, dest::Integer, tag::Integer, comm::Comm) where T

Starts a nonblocking send of `buf` to MPI rank `dest` of communicator `comm`
using with the message tag `tag`

Returns the commication `Request` for the nonblocking send.
"""
function Isend(buf::AbstractArray{T}, dest::Integer, tag::Integer, comm::Comm) where T
    Isend(buf, length(buf), mpitype(T), dest, tag, comm)
end

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
    Recv!(buf::MPIBuffertype{T}, count::Integer, datatype::Datatype,
          src::Integer, tag::Integer, comm::Comm) where T

Completes a blocking receive of up to `count` elements of type `datatype` into `buf`
from MPI rank `src` of communicator `comm` using with the message tag `tag`

Returns the `Status` of the receive
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

"""
    Recv!(buf::MPIBuffertype{T}, count::Integer, src::Integer, tag::Integer,
          comm::Comm) where T

Completes a blocking receive of up to `count` elements into `buf` from MPI rank
`src` of communicator `comm` using with the message tag `tag`

Returns the `Status` of the receive
"""
function Recv!(buf, count::Integer, src::Integer,
               tag::Integer, comm::Comm)
    Recv!(buf, count, mpitype(eltype(buf)), src, tag, comm)
end


"""
    Recv!(buf::Array{T}, src::Integer, tag::Integer, comm::Comm) where T

Completes a blocking receive into `buf` from MPI rank `src` of communicator
`comm` using with the message tag `tag`

Returns the `Status` of the receive
"""
function Recv!(buf::AbstractArray{T}, src::Integer, tag::Integer, comm::Comm) where T
    Recv!(buf, length(buf), src, tag, comm)
end

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
    Irecv!(buf::MPIBuffertype{T}, count::Integer, datatype::Datatype,
           src::Integer, tag::Integer, comm::Comm) where T

Starts a nonblocking receive of up to `count` elements of type `datatype` into `buf`
from MPI rank `src` of communicator `comm` using with the message tag `tag`

Returns the communication `Request` for the nonblocking receive.
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

"""
    Irecv!(buf::MPIBuffertype{T}, count::Integer, src::Integer, tag::Integer,
           comm::Comm) where T

Starts a nonblocking receive of up to `count` elements into `buf`
from MPI rank `src` of communicator `comm` using with the message tag `tag`

Returns the communication `Request` for the nonblocking receive.
"""
function Irecv!(buf, count::Integer,
                    src::Integer, tag::Integer, comm::Comm) 
    Irecv!(buf, count, mpitype(eltype(buf)), src, tag, comm)
end

"""
    Irecv!(buf::Array{T}, src::Integer, tag::Integer, comm::Comm) where T

Starts a nonblocking receive into `buf` from MPI rank `src` of communicator
`comm` using with the message tag `tag`

Returns the communication `Request` for the nonblocking receive.
"""
function Irecv!(buf::AbstractArray{T}, src::Integer, tag::Integer,
                             comm::Comm) where T
    Irecv!(buf, length(buf), mpitype(T), src, tag, comm)
end

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
    Wait!(req::Request)

Wait on the request `req` to be complete. Returns the `Status` of the request.
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
    Waitall!(reqs::Vector{Request})

Wait on all the requests in the array `reqs` to be complete. Returns an arrays
of the all the requests statuses.
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
    Waitany!(reqs::Vector{Request})

Wait on any the requests in the array `reqs` to be complete. Returns the index
of the completed request and its `Status` as a tuple.
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

function Cancel!(req::Request)
    # int MPI_Cancel(MPI_Request *request)
    @mpichk ccall((:MPI_Cancel, libmpi), Cint, (Ptr{MPI_Request},), req)
    req.buffer = nothing
    nothing
end
