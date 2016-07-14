typealias MPIDatatype Union{Char,
                            Int8, UInt8, Int16, UInt16, Int32, UInt32, Int64,
                            UInt64,
                            Float32, Float64, Complex64, Complex128}
typealias MPIBuffertype{T} Union{Ptr{T}, Array{T}, Ref{T}}

if VERSION >= v"0.5.0-"
    # TODO: Use Compat for this
    fieldoffsets{T}(::Type{T}) = Int[fieldoffset(T, i) for i in 1:nfields(T)]
end

# Define a function mpitype(T) that returns the MPI datatype code for
# a given type T. In the case the the type does not exist, it is created and
# then returned. The dictonary is defined in __init__ so the module can be
# precompiled

# accessor and creation function for getting MPI datatypes
function mpitype{T}(::Type{T})

    if haskey(mpitype_dict, T)  # if the datatype already exists
      return mpitype_dict[T]
    end

    if !isbits(T)
        throw(ArgumentError("Type must be isbits()"))
    end

    # get the data from the type
    fieldtypes = T.types
    offsets = fieldoffsets(T)
    nfields = Cint(length(fieldtypes))

    # put data in MPI format
    blocklengths = ones(Cint, nfields)
    displacements = zeros(Cptrdiff_t, nfields)  # size_t == MPI_Aint ?
    types = zeros(Cint, nfields)
    for i=1:nfields
        displacements[i] = offsets[i]
        # create an MPI_Datatype for the current field if it does not exist yet
        types[i] = mpitype(fieldtypes[i])
    end

    # create the datatype
    newtype_ref = Ref{Cint}()
    flag = Ref{Cint}()
    ccall(MPI_TYPE_CREATE_STRUCT, Void, (Ptr{Cint}, Ptr{Cint}, Ptr{Cptrdiff_t},
          Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), &nfields, blocklengths,
          displacements, types, newtype_ref, flag)

    if flag[] != 0
        throw(ErrorException("MPI_Type_create_struct returned non-zero exit status"))
    end

    # commit the datatatype
    flag2 = Ref{Cint}()
    ccall(MPI_TYPE_COMMIT, Void, (Ptr{Cint}, Ptr{Cint}), newtype_ref, flag2)

    if flag2[] != 0
        throw(ErrorException("MPI_Type_commit returned non-zero exit status"))
    end

    # add it to the dictonary of known types
    mpitype_dict[T] = newtype_ref[]
    mpitype_dict_inverse[newtype_ref[]] = T

    return mpitype_dict[T]
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
    ccall(MPI_INIT, Void, (Ptr{Cint},), &0)
end

function Finalize()
    ccall(MPI_FINALIZE, Void, (Ptr{Cint},), &0)
end

function Abort(comm::Comm, errcode::Integer)
    ccall(MPI_ABORT, Void, (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &comm.val, &errcode, &0)
end

function Initialized()
    flag = Ref{Cint}()
    ccall(MPI_INITIALIZED, Void, (Ptr{Cint}, Ptr{Cint}), flag, &0)
    flag[] != 0
end

function Finalized()
    flag = Ref{Cint}()
    ccall(MPI_FINALIZED, Void, (Ptr{Cint}, Ptr{Cint}), flag, &0)
    flag[] != 0
end

function Comm_dup(comm::Comm)
    newcomm = Ref{Cint}()
    ccall(MPI_COMM_DUP, Void, (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &comm.val, newcomm, &0)
    MPI.Comm(newcomm[])
end

function Comm_free(comm::Comm)
    ccall(MPI_COMM_FREE, Void, (Ptr{Cint}, Ptr{Cint}), &comm.val, &0)
end

function Comm_rank(comm::Comm)
    rank = Ref{Cint}()
    ccall(MPI_COMM_RANK, Void, (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &comm.val, rank, &0)
    Int(rank[])
end

function Comm_size(comm::Comm)
    size = Ref{Cint}()
    ccall(MPI_COMM_SIZE, Void, (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &comm.val, size, &0)
    Int(size[])
end

function type_create(T::DataType)
    if !isbits(T)
        throw(ArgumentError("Type must be isbits()"))
    end

    if haskey(mpitype_dict, T)  # if the datatype already exists
        return nothing
    end

    # get the data from the type
    fieldtypes = T.types
    nfields = Cint(length(fieldtypes))
    if VERSION < v"0.5.0-dev+2285"
        offsets = fieldoffsets(T)
    else
        offsets = map(idx->fieldoffset(T, idx), 1:nfields)
    end

    # put data in MPI format
    blocklengths = ones(Cint, nfields)
    displacements = zeros(Cptrdiff_t, nfields)  # size_t == MPI_Aint ?
    types = zeros(Cint, nfields)
    for i=1:nfields
        displacements[i] = offsets[i]
        # create an MPI_Datatype for the current field if it does not exist yet
        if !haskey(mpitype_dict, fieldtypes[i])
            type_create(fieldtypes[i])
        end
        types[i] = mpitype(fieldtypes[i])
    end

    # create the datatype
    newtype_ref = Ref{Cint}()
    flag = Ref{Cint}()
    ccall(MPI_TYPE_CREATE_STRUCT, Void, (Ptr{Cint}, Ptr{Cint}, Ptr{Cptrdiff_t},
          Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), &nfields, blocklengths, displacements,
          types, newtype_ref, flag)

    if flag[] != 0
        throw(ErrorException("MPI_Type_create_struct returned non-zero exit status"))
    end

    # commit the datatatype
    flag2 = Ref{Cint}()
    ccall(MPI_TYPE_COMMIT, Void, (Ptr{Cint}, Ptr{Cint}), newtype_ref, flag2)

    if flag2[] != 0
        throw(ErrorException("MPI_Type_commit returned non-zero exit status"))
    end

    # add it to the dictonary of known types
    mpitype_dict[T] = newtype_ref[]

    return nothing
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
    flag = Ref{Cint}()
    stat = Status()
    ccall(MPI_IPROBE, Void,
          (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &src, &tag, &comm.val, flag, stat.val, &0)
    if flag[] == 0
        return false, nothing
    end
    true, stat
end

function Get_count{T}(stat::Status, ::Type{T})
    count = Ref{Cint}()
    ccall(MPI_GET_COUNT, Void, (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          stat.val, &mpitype(T), count, &0)
    Int(count[])
end

function Send{T}(buf::MPIBuffertype{T}, count::Integer,
                              dest::Integer, tag::Integer, comm::Comm)
    ccall(MPI_SEND, Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
           Ptr{Cint}),
          buf, &count, &mpitype(T), &dest, &tag, &comm.val, &0)
end

function Send{T}(buf::Array{T}, dest::Integer, tag::Integer,
                              comm::Comm)
    Send(buf, length(buf), dest, tag, comm)
end

function Send{T}(obj::T, dest::Integer, tag::Integer, comm::Comm)
    buf = [obj]
    Send(buf, dest, tag, comm)
end

function send(obj, dest::Integer, tag::Integer, comm::Comm)
    buf = MPI.serialize(obj)
    Send(buf, dest, tag, comm)
end

function Isend{T}(buf::MPIBuffertype{T}, count::Integer,
                               dest::Integer, tag::Integer, comm::Comm)
    rval = Ref{Cint}()
    ccall(MPI_ISEND, Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
           Ptr{Cint}, Ptr{Cint}),
          buf, &count, &mpitype(T), &dest, &tag, &comm.val, rval, &0)
    Request(rval[], buf)
end

function Isend{T}(buf::Array{T}, dest::Integer, tag::Integer,
                               comm::Comm)
    Isend(buf, length(buf), dest, tag, comm)
end

function Isend{T}(obj::T, dest::Integer, tag::Integer, comm::Comm)
    buf = [obj]
    Isend(buf, dest, tag, comm)
end

function isend(obj, dest::Integer, tag::Integer, comm::Comm)
    buf = MPI.serialize(obj)
    Isend(buf, dest, tag, comm)
end

function Recv!{T}(buf::MPIBuffertype{T}, count::Integer,
                               src::Integer, tag::Integer, comm::Comm)
    stat = Status()
    ccall(MPI_RECV, Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
           Ptr{Cint}, Ptr{Cint}),
          buf, &count, &mpitype(T), &src, &tag, &comm.val, stat.val, &0)
    stat
end

function Recv!{T}(buf::Array{T}, src::Integer, tag::Integer,
                               comm::Comm)
    Recv!(buf, length(buf), src, tag, comm)
end

function Recv{T}(::Type{T}, src::Integer, tag::Integer, comm::Comm)
    buf = Ref{T}()
    stat = Recv!(buf, 1, src, tag, comm)
    (buf[], stat)
end

function recv(src::Integer, tag::Integer, comm::Comm)
    stat = Probe(src, tag, comm)
    count = Get_count(stat, UInt8)
    buf = Array(UInt8, count)
    stat = Recv!(buf, Get_source(stat), Get_tag(stat), comm)
    (MPI.deserialize(buf), stat)
end

function Irecv!{T}(buf::MPIBuffertype{T}, count::Integer,
                                src::Integer, tag::Integer, comm::Comm)
    val = Ref{Cint}()
    ccall(MPI_IRECV, Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
           Ptr{Cint}, Ptr{Cint}),
          buf, &count, &mpitype(T), &src, &tag, &comm.val, val, &0)
    Request(val[], buf)
end

function Irecv!{T}(buf::Array{T}, src::Integer, tag::Integer,
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
    ccall(MPI_WAIT, Void, (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &req.val, stat.val, &0)
    req.buffer = nothing
    stat
end

function Test!(req::Request)
    flag = Ref{Cint}()
    stat = Status()
    ccall(MPI_TEST, Void, (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &req.val, flag, stat.val, &0)
    if flag[] == 0
        return (false, nothing)
    end
    req.buffer = nothing
    (true, stat)
end

function Waitall!(reqs::Array{Request,1})
    count = length(reqs)
    reqvals = [reqs[i].val for i in 1:count]
    statvals = Array(Cint, MPI_STATUS_SIZE, count)
    ccall(MPI_WAITALL, Void,
          (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &count, reqvals, statvals, &0)
    stats = Array(Status, count)
    for i in 1:count
        reqs[i].val = reqvals[i]
        reqs[i].buffer = nothing
        stats[i] = Status()
        for v in 1:MPI_STATUS_SIZE
            stats[i].val[v] = statvals[v,i]
        end
    end
    stats
end

function Testall!(reqs::Array{Request,1})
    count = length(reqs)
    reqvals = [reqs[i].val for i in 1:count]
    flag = Ref{Cint}()
    statvals = Array(Cint, MPI_STATUS_SIZE, count)
    ccall(MPI_TESTALL, Void,
          (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &count, reqvals, flag, statvals, &0)
    if flag[] == 0
        return (false, nothing)
    end
    stats = Array(Status, count)
    for i in 1:count
        reqs[i].val = reqvals[i]
        reqs[i].buffer = nothing
        stats[i] = Status()
        for v in 1:MPI_STATUS_SIZE
            stats[i].val[v] = statvals[v,i]
        end
    end
    (true, stats)
end

function Waitany!(reqs::Array{Request,1})
    count = length(reqs)
    reqvals = [reqs[i].val for i in 1:count]
    ind = Ref{Cint}()
    stat = Status()
    ccall(MPI_WAITANY, Void,
          (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &count, reqvals, ind, stat.val, &0)
    index = Int(ind[])
    reqs[index].val = reqvals[index]
    reqs[index].buffer = nothing
    (index, stat)
end

function Testany!(reqs::Array{Request,1})
    count = length(reqs)
    reqvals = [reqs[i].val for i in 1:count]
    ind = Ref{Cint}()
    flag = Ref{Cint}()
    stat = Status()
    ccall(MPI_TESTANY, Void,
          (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &count, reqvals, ind, flag, stat.val, &0)
    index = Int(ind[])
    if flag[] == 0 || index == MPI_UNDEFINED
        return (false, 0, nothing)
    end
    reqs[index].val = reqvals[index]
    reqs[index].buffer = nothing
    (true, index, stat)
end

function Waitsome!(reqs::Array{Request,1})
    count = length(reqs)
    reqvals = [reqs[i].val for i in 1:count]
    outcnt = Ref{Cint}()
    inds = Array(Cint, count)
    statvals = Array(Cint, MPI_STATUS_SIZE, count)
    ccall(MPI_WAITSOME, Void,
          (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &count, reqvals, outcnt, inds, statvals, &0)
    outcount = Int(outcnt[])
    # This can happen if there were no valid requests
    if outcount == UNDEFINED
        outcount = 0
    end
    indices = Array(Int, outcount)
    stats = Array(Status, outcount)
    for i in 1:outcount
        ind = Int(inds[i])
        reqs[ind].val = reqvals[ind]
        reqs[ind].buffer = nothing
        indices[i] = inds[i]
        stats[i] = Status()
        for v in 1:MPI_STATUS_SIZE
            stats[i].val[v] = statvals[v,i]
        end
    end
    (indices, stats)
end

function Testsome!(reqs::Array{Request,1})
    count = length(reqs)
    reqvals = [reqs[i].val for i in 1:count]
    outcnt = Ref{Cint}()
    inds = Array(Cint, count)
    statvals = Array(Cint, MPI_STATUS_SIZE, count)
    ccall(MPI_TESTSOME, Void,
          (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          &count, reqvals, outcnt, inds, statvals, &0)
    outcount = outcnt[]
    # This can happen if there were no valid requests
    if outcount == UNDEFINED
        outcount = 0
    end
    indices = Array(Int, outcount)
    stats = Array(Status, outcount)
    for i in 1:outcount
        ind = Int(inds[i])
        reqs[ind].val = reqvals[ind]
        reqs[ind].buffer = nothing
        indices[i] = inds[i]
        stats[i] = Status()
        for v in 1:MPI_STATUS_SIZE
            stats[i].val[v] = statvals[v,i]
        end
    end
    (indices, stats)
end

function Cancel!(req::Request)
    ccall(MPI_CANCEL, Void, (Ptr{Cint},Ptr{Cint}), &req.val, &0)
    req.buffer = nothing
    nothing
end

# Collective communication

function Barrier(comm::Comm)
    ccall(MPI_BARRIER, Void, (Ptr{Cint},Ptr{Cint}), &comm.val, &0)
end

function Bcast!{T}(buffer::MPIBuffertype{T}, count::Integer,
                   root::Integer, comm::Comm)
    ccall(MPI_BCAST, Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          buffer, &count, &mpitype(T), &root, &comm.val, &0)
    buffer
end

function Bcast!{T}(buffer::Array{T}, root::Integer, comm::Comm)
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

function Reduce{T}(sendbuf::MPIBuffertype{T}, count::Integer,
                   op::Op, root::Integer, comm::Comm)
    isroot = Comm_rank(comm) == root
    recvbuf = Array(T, isroot ? count : 0)
    ccall(MPI_REDUCE, Void,
          (Ptr{T}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
           Ptr{Cint}, Ptr{Cint}),
          sendbuf, recvbuf, &count, &mpitype(T), &op.val, &root, &comm.val,
          &0)
    isroot ? recvbuf : nothing
end

function Reduce{T}(sendbuf::Array{T}, op::Union{Op,Function}, root::Integer, comm::Comm)
    Reduce(sendbuf, length(sendbuf), op, root, comm)
end

function Reduce{T}(object::T, op::Union{Op,Function}, root::Integer, comm::Comm)
    isroot = Comm_rank(comm) == root
    sendbuf = T[object]
    recvbuf = Reduce(sendbuf, op, root, comm)
    isroot ? recvbuf[1] : nothing
end

function Allreduce!{T}(sendbuf::MPIBuffertype{T}, recvbuf::MPIBuffertype{T},
                      count::Integer, op::Op, comm::Comm)
    ccall(MPI_ALLREDUCE, Void, (Ptr{T}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
          Ptr{Cint}, Ptr{Cint}), sendbuf, recvbuf, &count, &mpitype(T),
          &op.val, &comm.val, &0)

    recvbuf
end

function Allreduce!{T}(sendbuf::MPIBuffertype{T}, recvbuf::MPIBuffertype{T},
                      op::Union{Op,Function}, comm::Comm)
    Allreduce!(sendbuf, recvbuf, length(recvbuf), op, comm)
end

function Allreduce{T}(obj::T, op::Union{Op,Function}, comm::Comm)
    objref = Ref(obj)
    outref = Ref{T}()
    Allreduce!(objref, outref, 1, op, comm)

    outref[]
end

# allocate receive buffer automatically
function allreduce{T}(sendbuf::MPIBuffertype{T}, op::Union{Op,Function}, comm::Comm)

  recvbuf = similar(sendbuf)
  Allreduce!(sendbuf, recvbuf, length(recvbuf), op, comm)
end

include("mpi-op.jl")

function Scatter{T}(sendbuf::MPIBuffertype{T},count::Integer, root::Integer,
                    comm::Comm)
    recvbuf = Array(T, count)
    ccall(MPI_SCATTER, Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{T}, Ptr{Cint}, Ptr{Cint},
           Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), sendbuf, &count, &mpitype(T),
           recvbuf, &count, &mpitype(T), &root, &comm.val, &0)
    recvbuf
end

function Scatterv{T}(sendbuf::MPIBuffertype{T},
                     counts::Vector{Cint}, root::Integer,
                     comm::Comm)
    recvbuf = Array(T, counts[Comm_rank(comm) + 1])
    recvcnt = counts[Comm_rank(comm) + 1]
    disps = cumsum(counts) - counts
    ccall(MPI_SCATTERV, Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          sendbuf, counts, disps, &mpitype(T), recvbuf, &recvcnt, &mpitype(T), &root, &comm.val, &0)
    recvbuf
end

function Gather{T}(sendbuf::MPIBuffertype{T}, count::Integer,
                   root::Integer, comm::Comm)
    isroot = Comm_rank(comm) == root
    recvbuf = Array(T, isroot ? Comm_size(comm) * count : 0)
    ccall(MPI_GATHER, Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          sendbuf, &count, &mpitype(T), recvbuf, &count, &mpitype(T), &root, &comm.val, &0)
    isroot ? recvbuf : nothing
end

function Gather{T}(sendbuf::Array{T}, root::Integer, comm::Comm)
    Gather(sendbuf, length(sendbuf), root, comm)
end

function Gather{T}(object::T, root::Integer, comm::Comm)
    isroot = Comm_rank(comm) == root
    sendbuf = T[object]
    recvbuf = Gather(sendbuf, root, comm)
    isroot ? recvbuf : nothing
end

function Allgather{T}(sendbuf::MPIBuffertype{T}, count::Integer,
                      comm::Comm)
    recvbuf = Array(T, Comm_size(comm) * count)
    ccall(MPI_ALLGATHER, Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          sendbuf, &count, &mpitype(T), recvbuf, &count, &mpitype(T), &comm.val, &0)
    recvbuf
end

function Allgather{T}(sendbuf::Array{T}, comm::Comm)
    Allgather(sendbuf, length(sendbuf), comm)
end

function Allgather{T}(object::T, comm::Comm)
    sendbuf = T[object]
    recvbuf = Allgather(sendbuf, comm)
    recvbuf
end

function Gatherv{T}(sendbuf::MPIBuffertype{T}, counts::Vector{Cint},
                    root::Integer, comm::Comm)
    isroot = Comm_rank(comm) == root
    displs = cumsum(counts) - counts
    sendcnt = counts[Comm_rank(comm) + 1]
    recvbuf = Array(T, isroot ? sum(counts) : 0)
    ccall(MPI_GATHERV, Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          sendbuf, &sendcnt, &mpitype(T), recvbuf, counts, displs, &mpitype(T), &root, &comm.val, &0)
    isroot ? recvbuf : nothing
end

function Allgatherv{T}(sendbuf::MPIBuffertype{T}, counts::Vector{Cint},
                       comm::Comm)
    displs = cumsum(counts) - counts
    sendcnt = counts[Comm_rank(comm) + 1]
    recvbuf = Array(T, sum(counts))
    ccall(MPI_ALLGATHERV, Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          sendbuf, &sendcnt, &mpitype(T), recvbuf, counts, displs, &mpitype(T), &comm.val, &0)
    recvbuf
end

function Alltoall{T}(sendbuf::MPIBuffertype{T}, count::Integer,
                     comm::Comm)
    recvbuf = Array(T, Comm_size(comm)*count)
    ccall(MPI_ALLTOALL, Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          sendbuf, &count, &mpitype(T), recvbuf, &count, &mpitype(T), &comm.val, &0)
    recvbuf
end

function Alltoallv{T}(sendbuf::MPIBuffertype{T}, scounts::Vector{Cint},
                      rcounts::Vector{Cint}, comm::Comm)
    recvbuf = Array(T, sum(rcounts))
    sdispls = cumsum(scounts) - scounts
    rdispls = cumsum(rcounts) - rcounts
    ccall(MPI_ALLTOALLV, Void,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          sendbuf, scounts, sdispls, &mpitype(T), recvbuf, rcounts, rdispls, &mpitype(T), &comm.val, &0)
    recvbuf
end

function Scan{T}(sendbuf::MPIBuffertype{T}, count::Integer,
                 op::Op, comm::Comm)
    recvbuf = Array(T, count)
    ccall(MPI_SCAN, Void,
          (Ptr{T}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          sendbuf, recvbuf, &count, &mpitype(T), &op.val, &comm.val, &0)
    recvbuf
end

function Scan{T}(object::T, op::Op, comm::Comm)
    sendbuf = T[object]
    Scan(sendbuf,1,op,comm)
end

function Exscan{T}(sendbuf::MPIBuffertype{T}, count::Integer,
                   op::Op, comm::Comm)
    recvbuf = Array(T, count)
    ccall(MPI_EXSCAN, Void,
          (Ptr{T}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          sendbuf, recvbuf, &count, &mpitype(T), &op.val, &comm.val, &0)
    recvbuf
end

function Exscan{T}(object::T, op::Op, comm::Comm)
    sendbuf = T[object]
    Exscan(sendbuf,1,op,comm)
end

# Conversion between C and Fortran Comm handles:
if HAVE_MPI_COMM_C2F
    # use MPI_Comm_f2c and MPI_Comm_c2f
    Base.convert(::Type{CComm}, comm::Comm) =
        ccall(:MPI_Comm_f2c, CComm, (Cint,), comm.val)
    Base.convert(::Type{Comm}, ccomm::CComm) =
        Comm(ccall(:MPI_Comm_c2f, Cint, (CComm,), ccomm))
elseif sizeof(CComm) == sizeof(Cint)
    # in MPICH, both C and Fortran use identical Cint comm handles
    # and MPI_Comm_c2f is not provided.
    Base.convert(::Type{CComm}, comm::Comm) = reinterpret(CComm, comm.val)
    Base.convert(::Type{Comm}, ccomm::CComm) = Comm(reinterpret(Cint, ccomm))
else
    warn("No MPI_Comm_c2f found - conversion to/from MPI.CComm will not work")
end
