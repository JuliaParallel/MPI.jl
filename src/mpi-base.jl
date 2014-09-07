typealias MPIDatatype Union(Char,
                            Int8, Uint8, Int16, Uint16, Int32, Uint32, Int64,
                            Uint64,
                            Float32, Float64, Complex64, Complex128)

const datatypes =
    {Char => MPI_WCHAR,
     Int8 => MPI_INT8_T,
     Uint8 => MPI_UINT8_T,
     Int16 => MPI_INT16_T,
     Uint16 => MPI_UINT16_T,
     Int32 => MPI_INT32_T,
     Uint32 => MPI_UINT32_T,
     Int64 => MPI_INT64_T,
     Uint64 => MPI_UINT64_T,
     Float32 => MPI_REAL4,
     Float64 => MPI_REAL8,
     Complex64 => MPI_COMPLEX8,
     Complex128 => MPI_COMPLEX16}

type Comm
    val::Cint
end
const COMM_NULL  = Comm(MPI_COMM_NULL)
const COMM_SELF  = Comm(MPI_COMM_SELF)
const COMM_WORLD = Comm(MPI_COMM_WORLD)

type Op
    val::Cint
end
const OP_NULL = Op(MPI_OP_NULL)
const BAND    = Op(MPI_BAND)
const BOR     = Op(MPI_BOR)
const BXOR    = Op(MPI_BXOR)
const LAND    = Op(MPI_LAND)
const LOR     = Op(MPI_LOR)
const LXOR    = Op(MPI_LXOR)
const MAX     = Op(MPI_MAX)
const MIN     = Op(MPI_MIN)
const PROD    = Op(MPI_PROD)
const SUM     = Op(MPI_SUM)

type Request
    val::Cint
    buffer
end
const REQUEST_NULL = Request(MPI_REQUEST_NULL, nothing)

type Status
    val::Array{Cint,1}
    Status() = new(Array(Cint, MPI_STATUS_SIZE))
end
Get_error(stat::Status) = stat.val[MPI_ERROR]
Get_source(stat::Status) = stat.val[MPI_SOURCE]
Get_tag(stat::Status) = stat.val[MPI_TAG]

const ANY_SOURCE = int(MPI_ANY_SOURCE)
const ANY_TAG    = int(MPI_ANY_TAG)
const TAG_UB     = int(MPI_TAG_UB)
const UNDEFINED  = int(MPI_UNDEFINED)



function serialize(x)
    s = IOBuffer()
    Base.serialize(s, x)
    Base.takebuf_array(s)
end

function deserialize(x)
    s = IOBuffer(x)
    Base.deserialize(s)
end

# Administrative functions

function Init()
    ccall(MPI_INIT, Void, (Ptr{Cint},), &0)
end

function Finalize()
    ccall(MPI_FINALIZE, Void, (Ptr{Cint},), &0)
end

function Abort(comm::Comm, errcode::Integer)
    ccall(MPI_ABORT, Void, (Ptr{Cint},Ptr{Cint},Ptr{Cint}),
          &comm.val, &errcode, &0)
end

function Initialized()
    flag = Array(Cint, 1)
    ccall(MPI_INITIALIZED, Void, (Ptr{Cint},Ptr{Cint}), flag, &0)
    bool(flag[1])
end

function Finalized()
    flag = Array(Cint, 1)
    ccall(MPI_FINALIZED, Void, (Ptr{Cint},Ptr{Cint}), flag, &0)
    bool(flag[1])
end

function Comm_rank(comm::Comm)
    rank = Array(Cint, 1)
    ccall(MPI_COMM_RANK, Void, (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &comm.val, rank, &0)
    int(rank[1])
end

function Comm_size(comm::Comm)
    size = Array(Cint, 1)
    ccall(MPI_COMM_SIZE, Void, (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &comm.val, size, &0)
    int(size[1])
end

# Point-to-point communication

function Probe(src::Integer, tag::Integer, comm::Comm)
    stat = Status()
    ccall(MPI_PROBE, Void,
          (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &src, &tag, &comm.val, stat.val, &0)
    stat
end

function Iprobe(src::Integer, tag::Integer, comm::Comm)
    flag = Array(Cint, 1)
    stat = Status()
    ccall(MPI_IPROBE, Void,
          (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
           Ptr{Cint}),
          &src, &tag, &comm.val, flag, stat.val, &0)
    flag = bool(flag[1])
    if !flag
        return (false, nothing)
    end
    (true, stat)
end

function Get_count{T<:MPIDatatype}(stat::Status, ::Type{T})
    count = Array(Cint, 1)
    ccall(MPI_GET_COUNT, Void, (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          stat.val, &datatypes[T], count, &0)
    int(count[1])
end

function Send{T<:MPIDatatype}(buf::Union(Ptr{T},Array{T}), count::Integer,
                              dest::Integer, tag::Integer, comm::Comm)
    ccall(MPI_SEND, Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
           Ptr{Cint}),
          buf, &count, &datatypes[T], &dest, &tag, &comm.val, &0)
end

function Send{T<:MPIDatatype}(buf::Array{T}, dest::Integer, tag::Integer,
                              comm::Comm)
    Send(buf, length(buf), dest, tag, comm)
end

#=
function Send{T<:MPIDatatype}(obj::T, dest::Integer, tag::Integer, comm::Comm)
    buf = [obj]
    Send(buf, dest, tag, comm)
end
=#

function send(obj, dest::Integer, tag::Integer, comm::Comm)
    buf = serialize(obj)
    Send(buf, dest, tag, comm)
end

function Isend{T<:MPIDatatype}(buf::Union(Ptr{T},Array{T}), count::Integer,
                               dest::Integer, tag::Integer, comm::Comm)
    rval = Array(Cint, 1)
    ccall(MPI_ISEND, Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
           Ptr{Cint}, Ptr{Cint}),
          buf, &count, &datatypes[T], &dest, &tag, &comm.val, rval, &0)
    Request(rval[1], buf)
end

function Isend{T<:MPIDatatype}(buf::Array{T}, dest::Integer, tag::Integer,
                               comm::Comm)
    Isend(buf, length(buf), dest, tag, comm)
end

#=
function Isend{T<:MPIDatatype}(obj::T, dest::Integer, tag::Integer, comm::Comm)
    buf = [obj]
    Isend(buf, dest, tag, comm)
end
=#

function isend(obj, dest::Integer, tag::Integer, comm::Comm)
    buf = serialize(obj)
    Isend(buf, dest, tag, comm)
end

function Recv!{T<:MPIDatatype}(buf::Union(Ptr{T},Array{T}), count::Integer,
                               src::Integer, tag::Integer, comm::Comm)
    stat = Status()
    ccall(MPI_RECV, Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
           Ptr{Cint}, Ptr{Cint}),
          buf, &count, &datatypes[T], &src, &tag, &comm.val, stat.val, &0)
    stat
end

function Recv!{T<:MPIDatatype}(buf::Array{T}, src::Integer, tag::Integer,
                               comm::Comm)
    Recv!(buf, length(buf), src, tag, comm)
end

#=
function Recv{T<:MPIDatatype}(::Type{T}, src::Integer, tag::Integer, comm::Comm)
    buf = Array(T, 1)
    Recv!(buf, src, tag, comm)
    buf[1]
end
=#

function recv(src::Integer, tag::Integer, comm::Comm)
    stat = Probe(src, tag, comm)
    count = Get_count(stat, Uint8)
    buf = Array(Uint8, count)
    stat = Recv!(buf, Get_source(stat), Get_tag(stat), comm)
    (deserialize(buf), stat)
end

function Irecv!{T<:MPIDatatype}(buf::Union(Ptr{T},Array{T}), count::Integer,
                                src::Integer, tag::Integer, comm::Comm)
    rval = Array(Cint, 1)
    ccall(MPI_IRECV, Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
           Ptr{Cint}, Ptr{Cint}),
          buf, &count, &datatypes[T], &src, &tag, &comm.val, rval, &0)
    Request(rval[1], buf)
end

function Irecv!{T<:MPIDatatype}(buf::Array{T}, src::Integer, tag::Integer,
                                comm::Comm)
    Irecv!(buf, length(buf), src, tag, comm)
end

function irecv(src::Integer, tag::Integer, comm::Comm)
    (flag, stat) = Iprobe(src, tag, comm)
    if !flag
        return (false, nothing, nothing)
    end
    count = Get_count(stat, Uint8)
    buf = Array(Uint8, count)
    stat = Recv!(buf, Get_source(stat), Get_tag(stat), comm)
    (true, deserialize(buf), stat)
end

function Wait!(req::Request)
    stat = Status()
    ccall(MPI_WAIT, Void, (Ptr{Cint},Ptr{Cint},Ptr{Cint}),
          &req.val, stat.val, &0)
    req.buffer = nothing
    stat
end

function Test!(req::Request)
    flag = Array(Cint, 1)
    stat = Status()
    ccall(MPI_TEST, Void, (Ptr{Cint},Ptr{Cint},Ptr{Cint},Ptr{Cint}),
          &req.val, flag, stat.val, &0)
    flag = bool(flag[1])
    if !flag
        return (false, nothing)
    end
    req.buffer = nothing
    (true, stat)
end

function Waitall!(reqs::Array{Request,1})
    count = length(reqs)
    reqvals = [reqs[i].val for i in 1:count]
    statvals = Array(Cint, MPI_STATUS_SIZE, count)
    ccall(MPI_WAITALL, Void, (Ptr{Cint},Ptr{Cint},Ptr{Cint},Ptr{Cint}),
          &count, reqvals, statvals, &0)
    stats = Array(Status, count)
    for i in 1:count
        reqs[i].val = reqvals[i]
        reqs[i].buffer = nothing
        stats[i] = Status()
        stats[i].val[:] = statvals[:,i]
    end
    stats
end

function Testany!(reqs::Array{Request,1})
    count = length(reqs)
    reqvals = [reqs[i].val for i in 1:count]
    index = Array(Cint, 1)
    flag = Array(Cint, 1)
    stat = Status()
    ccall(MPI_TESTANY, Void,
          (Ptr{Cint},Ptr{Cint},Ptr{Cint},Ptr{Cint},Ptr{Cint},Ptr{Cint}),
          &count, reqvals, index, flag, stat.val, &0)
    flag = bool(flag[1])
    if !flag
        return (false, index, nothing)
    end
    reqs[index].val = reqvals[index]
    reqs[index].buffer = nothing
    (true, index, stat)
end

# Collective communication

function Barrier(comm::Comm)
    ccall(MPI_BARRIER, Void, (Ptr{Cint},Ptr{Cint}), &comm.val, &0)
end

function Bcast!{T<:MPIDatatype}(buffer::Union(Ptr{T},Array{T}), count::Integer,
                                root::Integer, comm::Comm)
    ccall(MPI_BCAST, Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          buffer, &count, &datatypes[T], &root, &comm.val, &0)
    buffer
end

function Bcast!{T<:MPIDatatype}(buffer::Array{T}, root::Integer, comm::Comm)
    Bcast!(buffer, length(buffer), root, comm)
end

#=
function Bcast{T<:MPIDatatype}(obj::T, root::Integer, comm::Comm)
    buf = [T]
    Bcast!(buf, root, comm)
    buf[1]
end
=#

function bcast(obj, root::Integer, comm::Comm)
    isroot = Comm_rank(comm) == root
    count = Array(Cint, 1)
    if isroot
        buf = serialize(obj)
        count[1] = length(buf)
    end
    Bcast!(count, root, comm)
    if !isroot
        buf = Array(Uint8, count[1])
    end
    Bcast!(buf, root, comm)
    if !isroot
        obj = deserialize(buf)
    end
    obj
end

function Reduce{T<:MPIDatatype}(sendbuf::Union(Ptr{T},Array{T}), count::Integer,
                                op::Op, root::Integer, comm::Comm)
    isroot = Comm_rank(comm) == root
    recvbuf = Array(T, isroot ? count : 0)
    ccall(MPI_REDUCE, Void,
          (Ptr{T}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
           Ptr{Cint}, Ptr{Cint}),
          sendbuf, recvbuf, &count, &datatypes[T], &op.val, &root, &comm.val,
          &0)
    isroot ? recvbuf : nothing
end

function Reduce{T<:MPIDatatype}(sendbuf::Array{T}, op::Op, root::Integer,
                                comm::Comm)
    Reduce(sendbuf, length(sendbuf), op, root, comm)
end

function Reduce{T<:MPIDatatype}(object::T, op::Op, root::Integer, comm::Comm)
    isroot = Comm_rank(comm) == root
    sendbuf = T[object]
    recvbuf = Reduce(sendbuf, op, root, comm)
    isroot ? recvbuf[1] : nothing
end
