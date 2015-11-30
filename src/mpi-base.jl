typealias MPIDatatype Union{Char,
                            Int8, UInt8, Int16, UInt16, Int32, UInt32, Int64,
                            UInt64,
                            Float32, Float64, Complex64, Complex128}

# Define a function mpitype(T) that returns the MPI datatype code
# for a given type T<:MPIDatatype.  This works better with precompilation
# than a dictionary (since DataType keys need to be re-hashed at runtime),
# and also allows the datatype code to be inlined at compile-time.
let _int_datatypes = Dict{Int, Cint}(
                                     1 => MPI_INTEGER1,
                                     2 => MPI_INTEGER2,
                                     4 => MPI_INTEGER4,
                                     8 => MPI_INTEGER8),
    _real_datatypes = Dict{Int, Cint}(
                                      4 => MPI_REAL4,
                                      8 => MPI_REAL8)
    _complex_datatypes = Dict{Int, Cint}(
                                         8 => MPI_COMPLEX8,
                                         16 => MPI_COMPLEX16)
    _datatypes = Dict{DataType, Cint}(
    # Older versions of OpenMPI (such as those used by default by
    # Travis) do not define MPI_WCHAR and the MPI_*INT*_T types for
    # Fortran. We thus don't require them (yet).
    # Char => MPI_WCHAR,
    # Int8 => MPI_INT8_T,
    # UInt8 => MPI_UINT8_T,
    # Int16 => MPI_INT16_T,
    # UInt16 => MPI_UINT16_T,
    # Int32 => MPI_INT32_T,
    # UInt32 => MPI_UINT32_T,
    # Int64 => MPI_INT64_T,
    # UInt64 => MPI_UINT64_T,
    Char => _int_datatypes[sizeof(Char)],
    Int8 => _int_datatypes[sizeof(Int8)],
    UInt8 => _int_datatypes[sizeof(UInt8)],
    Int16 => _int_datatypes[sizeof(Int16)],
    UInt16 => _int_datatypes[sizeof(UInt16)],
    Int32 => _int_datatypes[sizeof(Int32)],
    UInt32 => _int_datatypes[sizeof(UInt32)],
    Int64 => _int_datatypes[sizeof(Int64)],
    UInt64 => _int_datatypes[sizeof(UInt64)],
    Float32 => _real_datatypes[sizeof(Float32)],
    Float64 => _real_datatypes[sizeof(Float64)],
    Complex64 => _complex_datatypes[sizeof(Complex64)],
    Complex128 => _complex_datatypes[sizeof(Complex128)])

    global mpitype
    for (T,t) in _datatypes
        @eval mpitype(::Type{$T}) = $t
    end
end

type Comm
    val::Cint
    Comm(val::Integer) = new(val)
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
Get_error(stat::Status) = Int(stat.val[MPI_ERROR])
Get_source(stat::Status) = Int(stat.val[MPI_SOURCE])
Get_tag(stat::Status) = Int(stat.val[MPI_TAG])

const ANY_SOURCE = Int(MPI_ANY_SOURCE)
const ANY_TAG    = Int(MPI_ANY_TAG)
const TAG_UB     = Int(MPI_TAG_UB)
const UNDEFINED  = Int(MPI_UNDEFINED)

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
    ccall((MPI_INIT,libmpi), Void, (Ptr{Cint},), &0)
end

function Finalize()
    ccall((MPI_FINALIZE,libmpi), Void, (Ptr{Cint},), &0)
end

function Abort(comm::Comm, errcode::Integer)
    ccall((MPI_ABORT,libmpi), Void, (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &comm.val, &errcode, &0)
end

function Initialized()
    flag = Array(Cint, 1)
    ccall((MPI_INITIALIZED,libmpi), Void, (Ptr{Cint}, Ptr{Cint}), flag, &0)
    flag[1] != 0
end

function Finalized()
    flag = Array(Cint, 1)
    ccall((MPI_FINALIZED,libmpi), Void, (Ptr{Cint}, Ptr{Cint}), flag, &0)
    flag[1] != 0
end

function Comm_dup(comm::Comm)
    newcomm = Array(Cint, 1)
    ccall((MPI_COMM_DUP,libmpi), Void, (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &comm.val, newcomm, &0)
    MPI.Comm(newcomm[1])
end

function Comm_free(comm::Comm)
    ccall((MPI_COMM_FREE,libmpi), Void, (Ptr{Cint}, Ptr{Cint}), &comm.val, &0)
end

function Comm_rank(comm::Comm)
    rank = Array(Cint, 1)
    ccall((MPI_COMM_RANK,libmpi), Void, (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &comm.val, rank, &0)
    Int(rank[1])
end

function Comm_size(comm::Comm)
    size = Array(Cint, 1)
    ccall((MPI_COMM_SIZE,libmpi), Void, (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &comm.val, size, &0)
    Int(size[1])
end

# Point-to-point communication

function Probe(src::Integer, tag::Integer, comm::Comm)
    stat = Status()
    ccall((MPI_PROBE,libmpi), Void,
          (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &src, &tag, &comm.val, stat.val, &0)
    stat
end

function Iprobe(src::Integer, tag::Integer, comm::Comm)
    flag = Array(Cint, 1)
    stat = Status()
    ccall((MPI_IPROBE,libmpi), Void,
          (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &src, &tag, &comm.val, flag, stat.val, &0)
    if flag[1] == 0
        return (false, nothing)
    end
    (true, stat)
end

function Get_count{T<:MPIDatatype}(stat::Status, ::Type{T})
    count = Array(Cint, 1)
    ccall((MPI_GET_COUNT,libmpi), Void, (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          stat.val, &mpitype(T), count, &0)
    Int(count[1])
end

function Send{T<:MPIDatatype}(buf::Union{Ptr{T},Array{T}}, count::Integer,
                              dest::Integer, tag::Integer, comm::Comm)
    ccall((MPI_SEND,libmpi), Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
           Ptr{Cint}),
          buf, &count, &mpitype(T), &dest, &tag, &comm.val, &0)
end

function Send{T<:MPIDatatype}(buf::Array{T}, dest::Integer, tag::Integer,
                              comm::Comm)
    Send(buf, length(buf), dest, tag, comm)
end

function Send{T<:MPIDatatype}(obj::T, dest::Integer, tag::Integer, comm::Comm)
    buf = [obj]
    Send(buf, dest, tag, comm)
end

function send(obj, dest::Integer, tag::Integer, comm::Comm)
    buf = MPI.serialize(obj)
    Send(buf, dest, tag, comm)
end

function Isend{T<:MPIDatatype}(buf::Union{Ptr{T},Array{T}}, count::Integer,
                               dest::Integer, tag::Integer, comm::Comm)
    rval = Array(Cint, 1)
    ccall((MPI_ISEND,libmpi), Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
           Ptr{Cint}, Ptr{Cint}),
          buf, &count, &mpitype(T), &dest, &tag, &comm.val, rval, &0)
    Request(rval[1], buf)
end

function Isend{T<:MPIDatatype}(buf::Array{T}, dest::Integer, tag::Integer,
                               comm::Comm)
    Isend(buf, length(buf), dest, tag, comm)
end

function Isend{T<:MPIDatatype}(obj::T, dest::Integer, tag::Integer, comm::Comm)
    buf = [obj]
    Isend(buf, dest, tag, comm)
end

function isend(obj, dest::Integer, tag::Integer, comm::Comm)
    buf = MPI.serialize(obj)
    Isend(buf, dest, tag, comm)
end

function Recv!{T<:MPIDatatype}(buf::Union{Ptr{T},Array{T}}, count::Integer,
                               src::Integer, tag::Integer, comm::Comm)
    stat = Status()
    ccall((MPI_RECV,libmpi), Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
           Ptr{Cint}, Ptr{Cint}),
          buf, &count, &mpitype(T), &src, &tag, &comm.val, stat.val, &0)
    stat
end

function Recv!{T<:MPIDatatype}(buf::Array{T}, src::Integer, tag::Integer,
                               comm::Comm)
    Recv!(buf, length(buf), src, tag, comm)
end

function Recv{T<:MPIDatatype}(::Type{T}, src::Integer, tag::Integer, comm::Comm)
    buf = Array(T, 1)
    stat = Recv!(buf, src, tag, comm)
    (buf[1], stat)
end

function recv(src::Integer, tag::Integer, comm::Comm)
    stat = Probe(src, tag, comm)
    count = Get_count(stat, UInt8)
    buf = Array(UInt8, count)
    stat = Recv!(buf, Get_source(stat), Get_tag(stat), comm)
    (MPI.deserialize(buf), stat)
end

function Irecv!{T<:MPIDatatype}(buf::Union{Ptr{T},Array{T}}, count::Integer,
                                src::Integer, tag::Integer, comm::Comm)
    rval = Array(Cint, 1)
    ccall((MPI_IRECV,libmpi), Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
           Ptr{Cint}, Ptr{Cint}),
          buf, &count, &mpitype(T), &src, &tag, &comm.val, rval, &0)
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
    count = Get_count(stat, UInt8)
    buf = Array(UInt8, count)
    stat = Recv!(buf, Get_source(stat), Get_tag(stat), comm)
    (true, MPI.deserialize(buf), stat)
end

function Wait!(req::Request)
    stat = Status()
    ccall((MPI_WAIT,libmpi), Void, (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &req.val, stat.val, &0)
    req.buffer = nothing
    stat
end

function Test!(req::Request)
    flag = Array(Cint, 1)
    stat = Status()
    ccall((MPI_TEST,libmpi), Void, (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &req.val, flag, stat.val, &0)
    if flag[1] == 0
        return (false, nothing)
    end
    req.buffer = nothing
    (true, stat)
end

function Waitall!(reqs::Array{Request,1})
    count = length(reqs)
    reqvals = [reqs[i].val for i in 1:count]
    statvals = Array(Cint, MPI_STATUS_SIZE, count)
    ccall((MPI_WAITALL,libmpi), Void,
          (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
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

function Testall!(reqs::Array{Request,1})
    count = length(reqs)
    reqvals = [reqs[i].val for i in 1:count]
    flag = Array(Cint, 1)
    statvals = Array(Cint, MPI_STATUS_SIZE, count)
    ccall((MPI_TESTALL,libmpi), Void,
          (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &count, reqvals, flag, statvals, &0)
    if flag[1] == 0
        return (false, nothing)
    end
    stats = Array(Status, count)
    for i in 1:count
        reqs[i].val = reqvals[i]
        reqs[i].buffer = nothing
        stats[i] = Status()
        stats[i].val[:] = statvals[:,i]
    end
    (true, stats)
end

function Waitany!(reqs::Array{Request,1})
    count = length(reqs)
    reqvals = [reqs[i].val for i in 1:count]
    ind = Array(Cint, 1)
    stat = Status()
    ccall((MPI_WAITANY,libmpi), Void,
          (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &count, reqvals, index, statvals, &0)
    index = ind[1]
    reqs[index].val = reqvals[index]
    reqa[index].buffer = nothing
    (index, stat)
end

function Testany!(reqs::Array{Request,1})
    count = length(reqs)
    reqvals = [reqs[i].val for i in 1:count]
    ind = Array(Cint, 1)
    flag = Array(Cint, 1)
    stat = Status()
    ccall((MPI_TESTANY,libmpi), Void,
          (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &count, reqvals, ind, flag, stat.val, &0)
    if flag[1] == 0
        return (false, 0, nothing)
    end
    index = ind[1]
    reqs[index].val = reqvals[index]
    reqs[index].buffer = nothing
    (true, index, stat)
end

function Waitsome!(reqs::Array{Request,1})
    count = length(reqs)
    reqvals = [reqs[i].val for i in 1:count]
    outcnt = Array(Cint, 1)
    inds = Array(Cint, count)
    statvals = Array(Cint, MPI_STATUS_SIZE, count)
    ccall((MPI_WAITSOME,libmpi), Void,
          (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &count, reqvals, outcnt, inds, statvals, &0)
    outcount = outcnt[1]
    # This can happen if there were no valid requests
    if outcount == MPI_UNDEFINED
        outcount = 0
    end
    indices = Array(Int, outcount)
    stats = Array(Status, outcount)
    for i in 1:outcount
        ind = inds[i]
        reqs[ind].val = reqvals[ind]
        reqs[ind].buffer = nothing
        indices[i] = inds[i]
        stats[i] = Status()
        stats[i].val[:] = statvals[:,i]
    end
    (indices, stats)
end

function Testsome!(reqs::Array{Request,1})
    count = length(reqs)
    reqvals = [reqs[i].val for i in 1:count]
    outcnt = Array(Cint, 1)
    inds = Array(Cint, count)
    statvals = Array(Cint, MPI_STATUS_SIZE, count)
    ccall((MPI_TESTSOME,libmpi), Void,
          (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &count, reqvals, outcnt, inds, statvals, &0)
    outcount = outcnt[1]
    # This can happen if there were no valid requests
    if outcount == MPI_UNDEFINED
        outcount = 0
    end
    indices = Array(Int, outcount)
    stats = Array(Status, outcount)
    for i in 1:outcount
        ind = inds[i]
        reqs[ind].val = reqvals[ind]
        reqs[ind].buffer = nothing
        indices[i] = inds[i]
        stats[i] = Status()
        stats[i].val[:] = statvals[:,i]
    end
    (indices, stats)
end

function Cancel!(res::Request)
    ccall((MPI_CANCEL,libmpi), Void, (Ptr{Cint},), &req.val, &0)
    req.buffer = nothing
    nothing
end

# Collective communication

function Barrier(comm::Comm)
    ccall((MPI_BARRIER,libmpi), Void, (Ptr{Cint},Ptr{Cint}), &comm.val, &0)
end

function Bcast!{T<:MPIDatatype}(buffer::Union{Ptr{T},Array{T}}, count::Integer,
                                root::Integer, comm::Comm)
    ccall((MPI_BCAST,libmpi), Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          buffer, &count, &mpitype(T), &root, &comm.val, &0)
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
        buf = MPI.serialize(obj)
        count[1] = length(buf)
    end
    Bcast!(count, root, comm)
    if !isroot
        buf = Array(UInt8, count[1])
    end
    Bcast!(buf, root, comm)
    if !isroot
        obj = MPI.deserialize(buf)
    end
    obj
end

function Reduce{T<:MPIDatatype}(sendbuf::Union{Ptr{T},Array{T}}, count::Integer,
                                op::Op, root::Integer, comm::Comm)
    isroot = Comm_rank(comm) == root
    recvbuf = Array(T, isroot ? count : 0)
    ccall((MPI_REDUCE,libmpi), Void,
          (Ptr{T}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
           Ptr{Cint}, Ptr{Cint}),
          sendbuf, recvbuf, &count, &mpitype(T), &op.val, &root, &comm.val,
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

function Scatter{T<:MPIDatatype}(sendbuf::Union{Ptr{T},Array{T}},
                                 count::Integer, root::Integer, comm::Comm)
    recvbuf = Array(T, count)
    ccall((MPI_SCATTER,libmpi), Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          sendbuf, &count, &mpitype(T), recvbuf, &count, &mpitype(T), &root, &comm.val, &0)
    recvbuf
end

function Scatterv{T<:MPIDatatype}(sendbuf::Union{Ptr{T},Array{T}},
                                  counts::Vector{Cint}, root::Integer,
                                  comm::Comm)
    recvbuf = Array(T, counts[Comm_rank(comm) + 1])
    recvcnt = counts[Comm_rank(comm) + 1]
    disps = cumsum(counts) - counts
    ccall((MPI_SCATTERV,libmpi), Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          sendbuf, counts, disps, &mpitype(T), recvbuf, &recvcnt, &mpitype(T), &root, &comm.val, &0)
    recvbuf
end

function Gather{T<:MPIDatatype}(sendbuf::Union{Ptr{T},Array{T}}, count::Integer,
                                 root::Integer, comm::Comm)
    isroot = Comm_rank(comm) == root
    recvbuf = Array(T, isroot ? Comm_size(comm) * count : 0)
    ccall((MPI_GATHER,libmpi), Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          sendbuf, &count, &mpitype(T), recvbuf, &count, &mpitype(T), &root, &comm.val, &0)
    isroot ? recvbuf : nothing
end

function Gather{T<:MPIDatatype}(sendbuf::Array{T}, root::Integer,
                                 comm::Comm)
    Gather(sendbuf, length(sendbuf), root, comm)
end

function Gather{T<:MPIDatatype}(object::T, root::Integer, comm::Comm)
    isroot = Comm_rank(comm) == root
    sendbuf = T[object]
    recvbuf = Gather(sendbuf, root, comm)
    isroot ? recvbuf : nothing
end

function Allgather{T<:MPIDatatype}(sendbuf::Union{Ptr{T},Array{T}}, count::Integer,
                                   comm::Comm)
    recvbuf = Array(T, Comm_size(comm) * count)
    ccall((MPI_ALLGATHER,libmpi), Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          sendbuf, &count, &mpitype(T), recvbuf, &count, &mpitype(T), &comm.val, &0)
    recvbuf
end

function Allgather{T<:MPIDatatype}(sendbuf::Array{T}, comm::Comm)
    Allgather(sendbuf, length(sendbuf), comm)
end

function Allgather{T<:MPIDatatype}(object::T, comm::Comm)
    sendbuf = T[object]
    recvbuf = Allgather(sendbuf, comm)
    recvbuf
end

function Gatherv{T<:MPIDatatype}(sendbuf::Union{Ptr{T},Array{T}}, counts::Vector{Cint},
                                 root::Integer, comm::Comm)
    isroot = Comm_rank(comm) == root
    displs = cumsum(counts) - counts
    sendcnt = counts[Comm_rank(comm) + 1]
    recvbuf = Array(T, isroot ? sum(counts) : 0)
    ccall((MPI_GATHERV,libmpi), Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          sendbuf, &sendcnt, &mpitype(T), recvbuf, counts, displs, &mpitype(T), &root, &comm.val, &0)
    isroot ? recvbuf : nothing
end

function Allgatherv{T<:MPIDatatype}(sendbuf::Union{Ptr{T},Array{T}}, counts::Vector{Cint},
                                    comm::Comm)
    displs = cumsum(counts) - counts
    sendcnt = counts[Comm_rank(comm) + 1]
    recvbuf = Array(T, sum(counts))
    ccall((MPI_ALLGATHERV,libmpi), Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          sendbuf, &sendcnt, &mpitype(T), recvbuf, counts, displs, &mpitype(T), &comm.val, &0)
    recvbuf
end

function Alltoall{T<:MPIDatatype}(sendbuf::Union{Ptr{T},Array{T}}, count::Integer,
				 comm::Comm)
    recvbuf = Array(T, Comm_size(comm)*count)
    ccall((MPI_ALLTOALL,libmpi), Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          sendbuf, &count, &mpitype(T), recvbuf, &count, &mpitype(T), &comm.val, &0)
    recvbuf
end

function Alltoallv{T<:MPIDatatype}(sendbuf::Union{Ptr{T},Array{T}}, scounts::Vector{Cint},
				                   rcounts::Vector{Cint}, comm::Comm)
    recvbuf = Array(T, sum(rcounts))
    sdispls = cumsum(scounts) - scounts
    rdispls = cumsum(rcounts) - rcounts
    ccall((MPI_ALLTOALLV,libmpi), Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          sendbuf, scounts, sdispls, &mpitype(T), recvbuf, rcounts, rdispls, &mpitype(T), &comm.val, &0)
    recvbuf
end

function Scan{T<:MPIDatatype}(sendbuf::Union{Ptr{T},Array{T}}, count::Integer,
		              op::Op, comm::Comm)
    recvbuf = Array(T, count)
    ccall((MPI_SCAN,libmpi), Void,
          (Ptr{T}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          sendbuf, recvbuf, &count, &mpitype(T), &op.val, &comm.val, &0)
    recvbuf
end

function Scan{T<:MPIDatatype}(object::T, op::Op, comm::Comm)
    sendbuf = T[object]
    Scan(sendbuf,1,op,comm)
end

function ExScan{T<:MPIDatatype}(sendbuf::Union{Ptr{T},Array{T}}, count::Integer,
	                        op::Op, comm::Comm)
    recvbuf = Array(T, count)
    ccall((MPI_EXSCAN,libmpi), Void,
          (Ptr{T}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          sendbuf, recvbuf, &count, &mpitype(T), &op.val, &comm.val, &0)
    recvbuf
end

function ExScan{T<:MPIDatatype}(object::T, op::Op, comm::Comm)
    sendbuf = T[object]
    ExScan(sendbuf,1,op,comm)
end

# Conversion between C and Fortran Comm handles:
if HAVE_MPI_COMM_C2F
    # use MPI_Comm_f2c and MPI_Comm_c2f
    Base.convert(::Type{CComm}, comm::Comm) =
        ccall((:MPI_Comm_f2c,libmpi), CComm, (Cint,), comm.val)
    Base.convert(::Type{Comm}, ccomm::CComm) =
        Comm(ccall((:MPI_Comm_c2f,libmpi), Cint, (CComm,), ccomm))
elseif sizeof(CComm) == sizeof(Cint)
    # in MPICH, both C and Fortran use identical Cint comm handles
    # and MPI_Comm_c2f is not provided.
    Base.convert(::Type{CComm}, comm::Comm) = reinterpret(CComm, comm.val)
    Base.convert(::Type{Comm}, ccomm::CComm) = Comm(reinterpret(Cint, ccomm))
else
    warn("No MPI_Comm_c2f found - conversion to/from MPI.CComm will not work")
end
