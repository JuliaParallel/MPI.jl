using Compat

const MPIDatatype = Union{Char,
                            Int8, UInt8, Int16, UInt16, Int32, UInt32, Int64,
                            UInt64,
                            Float32, Float64, ComplexF32, ComplexF64}
MPIBuffertype{T} = Union{Ptr{T}, Array{T}, SubArray{T}, Ref{T}}

fieldoffsets(::Type{T}) where {T} = Int[fieldoffset(T, i) for i in 1:length(fieldnames(T))]

# Define a function mpitype(T) that returns the MPI datatype code for
# a given type T. In the case the the type does not exist, it is created and
# then returned. The dictonary is defined in __init__ so the module can be
# precompiled

# accessor and creation function for getting MPI datatypes
function mpitype(::Type{T}) where T

    if haskey(mpitype_dict, T)  # if the datatype already exists
      return mpitype_dict[T]
    end

    if !isbitstype(T)
        throw(ArgumentError("Type must be isbitstype()"))
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
    ccall(MPI_TYPE_CREATE_STRUCT, Nothing, (Ref{Cint}, Ptr{Cint}, Ptr{Cptrdiff_t},
          Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), nfields, blocklengths,
          displacements, types, newtype_ref, flag)

    if flag[] != 0
        throw(ErrorException("MPI_Type_create_struct returned non-zero exit status"))
    end

    # commit the datatatype
    flag2 = Ref{Cint}()
    ccall(MPI_TYPE_COMMIT, Nothing, (Ptr{Cint}, Ptr{Cint}), newtype_ref, flag2)

    if flag2[] != 0
        throw(ErrorException("MPI_Type_commit returned non-zero exit status"))
    end

    # add it to the dictonary of known types
    mpitype_dict[T] = newtype_ref[]
    mpitype_dict_inverse[newtype_ref[]] = T

    return mpitype_dict[T]
end


mutable struct Comm
    val::Cint
    Comm(val::Integer) = new(val)
end
const COMM_NULL  = Comm(MPI_COMM_NULL)
const COMM_SELF  = Comm(MPI_COMM_SELF)
const COMM_WORLD = Comm(MPI_COMM_WORLD)

mutable struct Op
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
const NO_OP   = Op(MPI_NO_OP)
const PROD    = Op(MPI_PROD)
const REPLACE = Op(MPI_REPLACE)
const SUM     = Op(MPI_SUM)

mutable struct Request
    val::Cint
    buffer
end
const REQUEST_NULL = Request(MPI_REQUEST_NULL, nothing)

mutable struct Info
    val::Cint
    function Info()
        newinfo = Ref{Cint}()
        ccall(MPI_INFO_CREATE, Nothing, (Ptr{Cint}, Ref{Cint}), newinfo, 0)
        info=new(newinfo[])
        finalizer(info) do x
          ccall(MPI_INFO_FREE, Nothing, (Ref{Cint}, Ref{Cint}), x.val, 0)
          x.val = MPI_INFO_NULL
        end
        info
    end

    function Info(val::Cint)
        if val != MPI_INFO_NULL
            error("Info can only be created using Info()")
        end
        return new(MPI_INFO_NULL)
    end
end
const INFO_NULL = Info(MPI_INFO_NULL)

# the info functions assume that Fortran hidden arguments are placed at the end of the argument list
function Info_set(info::Info,key::AbstractString,value::AbstractString)
    @assert isascii(key) && isascii(value)
    ccall(MPI_INFO_SET, Nothing,
          (Ref{Cint}, Ptr{UInt8}, Ptr{UInt8}, Ref{Cint}, Csize_t, Csize_t),
           info.val, key, value, 0, sizeof(key), sizeof(value))
end

function Info_get(info::Info,key::AbstractString)
    @assert isascii(key)
    keyexists=Ref{Bool}()
    len=Ref{Cint}()
    ccall(MPI_INFO_GET_VALUELEN, Nothing,
          (Ref{Cint}, Ptr{UInt8}, Ptr{Cint}, Ptr{Bool}, Ref{Cint}, Csize_t),
           info.val, key, len, keyexists, 0, sizeof(key))
    if keyexists[]
        value=" "^(len[])
        ccall(MPI_INFO_GET, Nothing,
              (Ref{Cint}, Ptr{UInt8}, Ptr{Cint}, Ptr{UInt8}, Ptr{Bool}, Ref{Cint}, Csize_t, Csize_t),
               info.val, key, len, value, keyexists, 0, sizeof(key), sizeof(value))
    else
        value=""
    end
    value
end

function Info_delete(info::Info,key::AbstractString)
    @assert isascii(key)
    ccall(MPI_INFO_DELETE, Nothing,
          (Ref{Cint}, Ptr{UInt8}, Ref{Cint}, Csize_t), info.val, key, 0, sizeof(key))
end
Info_free(info::Info) = finalize(info)

mutable struct Status
    val::Array{Cint,1}
    Status() = new(Array{Cint}(undef, MPI_STATUS_SIZE))
end
Get_error(stat::Status) = Int(stat.val[MPI_ERROR])
Get_source(stat::Status) = Int(stat.val[MPI_SOURCE])
Get_tag(stat::Status) = Int(stat.val[MPI_TAG])

mutable struct Win
    val::Cint
    Win() = new(0)
end

struct LockType
    val::Cint
end
const LOCK_EXCLUSIVE = LockType(MPI_LOCK_EXCLUSIVE)
const LOCK_SHARED = LockType(MPI_LOCK_SHARED)

const ANY_SOURCE = Int(MPI_ANY_SOURCE)
const ANY_TAG    = Int(MPI_ANY_TAG)
const TAG_UB     = Int(MPI_TAG_UB)
const UNDEFINED  = Int(MPI_UNDEFINED)

function serialize(x)
    s = IOBuffer()
    Compat.Serialization.serialize(s, x)
    take!(s)
end

function deserialize(x)
    s = IOBuffer(x)
    Compat.Serialization.deserialize(s)
end

# Administrative functions

function Init()
    ccall(MPI_INIT, Nothing, (Ref{Cint},), 0)
end

function Finalize()
    ccall(MPI_FINALIZE, Nothing, (Ref{Cint},), 0)
end

const FINALIZE_ATEXIT = Ref(false)

"""
    finalize_atexit()

Indicate that MPI.Finalize() should be called automatically at exit, if not called manually already.
The global variable `FINALIZE_ATEXIT` indicates if this function was called.
"""
function finalize_atexit()
    if Sys.iswindows()
        error("finalize_atexit is not supported on Windows")
    end
    ret = ccall((:install_finalize_atexit_hook, libmpi), Cint, ())
    if ret != 0
        error("Failed to set finalize_atexit")
    end
    FINALIZE_ATEXIT[] = true
end

function Abort(comm::Comm, errcode::Integer)
    ccall(MPI_ABORT, Nothing, (Ref{Cint}, Ref{Cint}, Ref{Cint}),
          comm.val, errcode, 0)
end

function Initialized()
    flag = Ref{Cint}()
    ccall(MPI_INITIALIZED, Nothing, (Ptr{Cint}, Ref{Cint}), flag, 0)
    flag[] != 0
end

function Finalized()
    flag = Ref{Cint}()
    ccall(MPI_FINALIZED, Nothing, (Ptr{Cint}, Ref{Cint}), flag, 0)
    flag[] != 0
end

function Comm_dup(comm::Comm)
    newcomm = Ref{Cint}()
    ccall(MPI_COMM_DUP, Nothing, (Ref{Cint}, Ptr{Cint}, Ref{Cint}),
          comm.val, newcomm, 0)
    MPI.Comm(newcomm[])
end

function Comm_free(comm::Comm)
    ccall(MPI_COMM_FREE, Nothing, (Ref{Cint}, Ref{Cint}), comm.val, 0)
end

function Comm_rank(comm::Comm)
    rank = Ref{Cint}()
    ccall(MPI_COMM_RANK, Nothing, (Ref{Cint}, Ptr{Cint}, Ref{Cint}),
          comm.val, rank, 0)
    Int(rank[])
end

function Comm_size(comm::Comm)
    size = Ref{Cint}()
    ccall(MPI_COMM_SIZE, Nothing, (Ref{Cint}, Ptr{Cint}, Ref{Cint}),
          comm.val, size, 0)
    Int(size[])
end

function Comm_split(comm::Comm,color::Integer,key::Integer)
    newcomm = Ref{Cint}()
    ccall(MPI_COMM_SPLIT, Nothing,
          (Ref{Cint}, Ref{Cint}, Ref{Cint}, Ptr{Cint}, Ref{Cint}),
          comm.val, color, key, newcomm, 0)
    MPI.Comm(newcomm[])
end

function Comm_split_type(comm::Comm,split_type::Integer,key::Integer;info::Info=INFO_NULL)
    newcomm = Ref{Cint}()
    ccall(MPI_COMM_SPLIT_TYPE, Nothing,
          (Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ptr{Cint}, Ref{Cint}),
          comm.val, split_type, key, info.val, newcomm, 0)
    MPI.Comm(newcomm[])
end

function Wtick()
    ccall(MPI_WTICK, Cdouble, ())
end

function Wtime()
    ccall(MPI_WTIME, Cdouble, ())
end

function type_create(T::DataType)
    if !isbitstype(T)
        throw(ArgumentError("Type must be isbitstype()"))
    end

    if haskey(mpitype_dict, T)  # if the datatype already exists
        return nothing
    end

    # get the data from the type
    fieldtypes = T.types
    nfields = Cint(length(fieldtypes))
    offsets = map(idx->fieldoffset(T, idx), 1:nfields)

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
    ccall(MPI_TYPE_CREATE_STRUCT, Nothing,
          (Ref{Cint}, Ptr{Cint}, Ptr{Cptrdiff_t}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
          nfields, blocklengths, displacements, types, newtype_ref, flag)

    if flag[] != 0
        throw(ErrorException("MPI_Type_create_struct returned non-zero exit status"))
    end

    # commit the datatatype
    flag2 = Ref{Cint}()
    ccall(MPI_TYPE_COMMIT, Nothing, (Ptr{Cint}, Ptr{Cint}), newtype_ref, flag2)

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
    ccall(MPI_PROBE, Nothing,
          (Ref{Cint}, Ref{Cint}, Ref{Cint}, Ptr{Cint}, Ref{Cint}),
          src, tag, comm.val, stat.val, 0)
    stat
end

function Iprobe(src::Integer, tag::Integer, comm::Comm)
    flag = Ref{Cint}()
    stat = Status()
    ccall(MPI_IPROBE, Nothing,
          (Ref{Cint}, Ref{Cint}, Ref{Cint}, Ptr{Cint}, Ptr{Cint}, Ref{Cint}),
          src, tag, comm.val, flag, stat.val, 0)
    if flag[] == 0
        return false, nothing
    end
    true, stat
end

function Get_count(stat::Status, ::Type{T}) where T
    count = Ref{Cint}()
    ccall(MPI_GET_COUNT, Nothing, (Ptr{Cint}, Ref{Cint}, Ptr{Cint}, Ref{Cint}),
          stat.val, mpitype(T), count, 0)
    Int(count[])
end

function Send(buf::MPIBuffertype{T}, count::Integer,
                           dest::Integer, tag::Integer, comm::Comm) where T
    ccall(MPI_SEND, Nothing,
          (Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint},
           Ref{Cint}),
          buf, count, mpitype(T), dest, tag, comm.val, 0)
end

function Send(buf::Array{T}, dest::Integer, tag::Integer,
                           comm::Comm) where T
    Send(buf, length(buf), dest, tag, comm)
end

function Send(buf::SubArray{T}, dest::Integer, tag::Integer,
                           comm::Comm) where T
    @assert Base.iscontiguous(buf)
    Send(buf, length(buf), dest, tag, comm)
end

function Send(obj::T, dest::Integer, tag::Integer, comm::Comm) where T
    buf = [obj]
    Send(buf, dest, tag, comm)
end

function send(obj, dest::Integer, tag::Integer, comm::Comm)
    buf = MPI.serialize(obj)
    Send(buf, dest, tag, comm)
end

function Isend(buf::MPIBuffertype{T}, count::Integer,
                            dest::Integer, tag::Integer, comm::Comm) where T
    rval = Ref{Cint}()
    ccall(MPI_ISEND, Nothing,
          (Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint},
           Ptr{Cint}, Ref{Cint}),
          buf, count, mpitype(T), dest, tag, comm.val, rval, 0)
    Request(rval[], buf)
end

function Isend(buf::Array{T}, dest::Integer, tag::Integer,
                            comm::Comm) where T
    Isend(buf, length(buf), dest, tag, comm)
end

function Isend(buf::SubArray{T}, dest::Integer, tag::Integer,
                            comm::Comm) where T
    @assert Base.iscontiguous(buf)
    Isend(buf, length(buf), dest, tag, comm)
end

function Isend(obj::T, dest::Integer, tag::Integer, comm::Comm) where T
    buf = [obj]
    Isend(buf, dest, tag, comm)
end

function isend(obj, dest::Integer, tag::Integer, comm::Comm)
    buf = MPI.serialize(obj)
    Isend(buf, dest, tag, comm)
end

function Recv!(buf::MPIBuffertype{T}, count::Integer,
                            src::Integer, tag::Integer, comm::Comm) where T
    stat = Status()
    ccall(MPI_RECV, Nothing,
          (Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint},
           Ptr{Cint}, Ref{Cint}),
          buf, count, mpitype(T), src, tag, comm.val, stat.val, 0)
    stat
end

function Recv!(buf::Array{T}, src::Integer, tag::Integer,
                            comm::Comm) where T
    Recv!(buf, length(buf), src, tag, comm)
end

function Recv!(buf::SubArray{T}, src::Integer, tag::Integer,
                            comm::Comm) where T
    @assert Base.iscontiguous(buf)
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

function Irecv!(buf::MPIBuffertype{T}, count::Integer,
                             src::Integer, tag::Integer, comm::Comm) where T
    val = Ref{Cint}()
    ccall(MPI_IRECV, Nothing,
          (Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint},
           Ptr{Cint}, Ref{Cint}),
          buf, count, mpitype(T), src, tag, comm.val, val, 0)
    Request(val[], buf)
end

function Irecv!(buf::Array{T}, src::Integer, tag::Integer,
                             comm::Comm) where T
    Irecv!(buf, length(buf), src, tag, comm)
end

function Irecv!(buf::SubArray{T}, src::Integer, tag::Integer,
                             comm::Comm) where T
    @assert Base.iscontiguous(buf)
    Irecv!(buf, length(buf), src, tag, comm)
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

function Wait!(req::Request)
    stat = Status()
    ccall(MPI_WAIT, Nothing, (Ref{Cint}, Ptr{Cint}, Ref{Cint}),
          req.val, stat.val, 0)
    req.buffer = nothing
    stat
end

function Test!(req::Request)
    flag = Ref{Cint}()
    stat = Status()
    ccall(MPI_TEST, Nothing, (Ref{Cint}, Ptr{Cint}, Ptr{Cint}, Ref{Cint}),
          req.val, flag, stat.val, 0)
    if flag[] == 0
        return (false, nothing)
    end
    req.buffer = nothing
    (true, stat)
end

function Waitall!(reqs::Array{Request,1})
    count = length(reqs)
    reqvals = [reqs[i].val for i in 1:count]
    statvals = Array{Cint}(undef, MPI_STATUS_SIZE, count)
    ccall(MPI_WAITALL, Nothing,
          (Ref{Cint}, Ptr{Cint}, Ptr{Cint}, Ref{Cint}),
          count, reqvals, statvals, 0)
    stats = Array{Status}(undef, count)
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
    statvals = Array{Cint}(undef, MPI_STATUS_SIZE, count)
    ccall(MPI_TESTALL, Nothing,
          (Ref{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ref{Cint}),
          count, reqvals, flag, statvals, 0)
    if flag[] == 0
        return (false, nothing)
    end
    stats = Array{Status}(undef, count)
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
    ccall(MPI_WAITANY, Nothing,
          (Ref{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ref{Cint}),
          count, reqvals, ind, stat.val, 0)
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
    ccall(MPI_TESTANY, Nothing,
          (Ref{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ref{Cint}),
          count, reqvals, ind, flag, stat.val, 0)
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
    inds = Array{Cint}(undef, count)
    statvals = Array{Cint}(undef,MPI_STATUS_SIZE, count)
    ccall(MPI_WAITSOME, Nothing,
          (Ref{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ref{Cint}),
          count, reqvals, outcnt, inds, statvals, 0)
    outcount = Int(outcnt[])
    # This can happen if there were no valid requests
    if outcount == UNDEFINED
        outcount = 0
    end
    indices = Array{Int}(undef, outcount)
    stats = Array{Status}(undef, outcount)
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
    inds = Array{Cint}(undef, count)
    statvals = Array{Cint}(undef,MPI_STATUS_SIZE, count)
    ccall(MPI_TESTSOME, Nothing,
          (Ref{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ref{Cint}),
          count, reqvals, outcnt, inds, statvals, 0)
    outcount = outcnt[]
    # This can happen if there were no valid requests
    if outcount == UNDEFINED
        outcount = 0
    end
    indices = Array{Int}(undef, outcount)
    stats = Array{Status}(undef, outcount)
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
    ccall(MPI_CANCEL, Nothing, (Ref{Cint},Ref{Cint}), req.val, 0)
    req.buffer = nothing
    nothing
end

# Collective communication

function Barrier(comm::Comm)
    ccall(MPI_BARRIER, Nothing, (Ref{Cint},Ref{Cint}), comm.val, 0)
end

function Bcast!(buffer::MPIBuffertype{T}, count::Integer,
                root::Integer, comm::Comm) where T
    ccall(MPI_BCAST, Nothing,
          (Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          buffer, count, mpitype(T), root, comm.val, 0)
    buffer
end

function Bcast!(buffer::Array{T}, root::Integer, comm::Comm) where T
    Bcast!(buffer, length(buffer), root, comm)
end

function Bcast!(buffer::SubArray{T}, root::Integer, comm::Comm) where T
    @assert Base.iscontiguous(buffer)
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
    count = Array{Cint}(undef, 1)
    if isroot
        buf = MPI.serialize(obj)
        count[1] = length(buf)
    end
    Bcast!(count, root, comm)
    if !isroot
        buf = Array{UInt8}(undef, count[1])
    end
    Bcast!(buf, root, comm)
    if !isroot
        obj = MPI.deserialize(buf)
    end
    obj
end

function Reduce(sendbuf::MPIBuffertype{T}, count::Integer,
                op::Op, root::Integer, comm::Comm) where T
    isroot = Comm_rank(comm) == root
    recvbuf = Array{T}(undef, isroot ? count : 0)
    ccall(MPI_REDUCE, Nothing,
          (Ptr{T}, Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint},
           Ref{Cint}, Ref{Cint}),
          sendbuf, recvbuf, count, mpitype(T), op.val, root, comm.val,
          0)
    isroot ? recvbuf : nothing
end

function Reduce(sendbuf::Array{T}, op::Union{Op,Function}, root::Integer, comm::Comm) where T
    Reduce(sendbuf, length(sendbuf), op, root, comm)
end

function Reduce(sendbuf::SubArray{T}, op::Union{Op,Function}, root::Integer, comm::Comm) where T
    @assert Base.iscontiguous(sendbuf)
    Reduce(sendbuf, length(sendbuf), op, root, comm)
end

function Reduce(object::T, op::Union{Op,Function}, root::Integer, comm::Comm) where T
    isroot = Comm_rank(comm) == root
    sendbuf = T[object]
    recvbuf = Reduce(sendbuf, op, root, comm)
    isroot ? recvbuf[1] : nothing
end

function Allreduce!(sendbuf::MPIBuffertype{T}, recvbuf::MPIBuffertype{T},
                   count::Integer, op::Op, comm::Comm) where T
    ccall(MPI_ALLREDUCE, Nothing, (Ptr{T}, Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint},
          Ref{Cint}, Ref{Cint}), sendbuf, recvbuf, count, mpitype(T),
          op.val, comm.val, 0)

    recvbuf
end

function Allreduce!(sendbuf::MPIBuffertype{T}, recvbuf::MPIBuffertype{T},
                   op::Union{Op,Function}, comm::Comm) where T
    Allreduce!(sendbuf, recvbuf, length(recvbuf), op, comm)
end

function Allreduce(obj::T, op::Union{Op,Function}, comm::Comm) where T
    objref = Ref(obj)
    outref = Ref{T}()
    Allreduce!(objref, outref, 1, op, comm)

    outref[]
end

# allocate receive buffer automatically
function allreduce(sendbuf::MPIBuffertype{T}, op::Union{Op,Function}, comm::Comm) where T

  recvbuf = similar(sendbuf)
  Allreduce!(sendbuf, recvbuf, length(recvbuf), op, comm)
end

include("mpi-op.jl")

function Scatter(sendbuf::MPIBuffertype{T},count::Integer, root::Integer,
                 comm::Comm) where T
    recvbuf = Array{T}(undef, count)
    ccall(MPI_SCATTER, Nothing,
          (Ptr{T}, Ref{Cint}, Ref{Cint}, Ptr{T}, Ref{Cint}, Ref{Cint},
           Ref{Cint}, Ref{Cint}, Ref{Cint}), sendbuf, count, mpitype(T),
           recvbuf, count, mpitype(T), root, comm.val, 0)
    recvbuf
end

function Scatterv(sendbuf::MPIBuffertype{T},
                  counts::Vector{Cint}, root::Integer,
                  comm::Comm) where T
    recvbuf = Array{T}(undef, counts[Comm_rank(comm) + 1])
    recvcnt = counts[Comm_rank(comm) + 1]
    disps = accumulate(+, counts) - counts
    ccall(MPI_SCATTERV, Nothing,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ref{Cint}, Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          sendbuf, counts, disps, mpitype(T), recvbuf, recvcnt, mpitype(T), root, comm.val, 0)
    recvbuf
end

function Gather(sendbuf::MPIBuffertype{T}, count::Integer,
                root::Integer, comm::Comm) where T
    isroot = Comm_rank(comm) == root
    recvbuf = Array{T}(undef, isroot ? Comm_size(comm) * count : 0)
    ccall(MPI_GATHER, Nothing,
          (Ptr{T}, Ref{Cint}, Ref{Cint}, Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          sendbuf, count, mpitype(T), recvbuf, count, mpitype(T), root, comm.val, 0)
    isroot ? recvbuf : nothing
end

function Gather(sendbuf::Array{T}, root::Integer, comm::Comm) where T
    Gather(sendbuf, length(sendbuf), root, comm)
end

function Gather(sendbuf::SubArray{T}, root::Integer, comm::Comm) where T
    @assert Base.iscontiguous(sendbuf)
    Gather(sendbuf, length(sendbuf), root, comm)
end

function Gather(object::T, root::Integer, comm::Comm) where T
    isroot = Comm_rank(comm) == root
    sendbuf = T[object]
    recvbuf = Gather(sendbuf, root, comm)
    isroot ? recvbuf : nothing
end

function Allgather(sendbuf::MPIBuffertype{T}, count::Integer,
                   comm::Comm) where T
    recvbuf = Array{T}(undef, Comm_size(comm) * count)
    ccall(MPI_ALLGATHER, Nothing,
          (Ptr{T}, Ref{Cint}, Ref{Cint}, Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          sendbuf, count, mpitype(T), recvbuf, count, mpitype(T), comm.val, 0)
    recvbuf
end

function Allgather(sendbuf::Array{T}, comm::Comm) where T
    Allgather(sendbuf, length(sendbuf), comm)
end

function Allgather(sendbuf::SubArray{T}, comm::Comm) where T
    @assert Base.iscontiguous(sendbuf)
    Allgather(sendbuf, length(sendbuf), comm)
end

function Allgather(object::T, comm::Comm) where T
    sendbuf = T[object]
    recvbuf = Allgather(sendbuf, comm)
    recvbuf
end

function Gatherv(sendbuf::MPIBuffertype{T}, counts::Vector{Cint},
                 root::Integer, comm::Comm) where T
    isroot = Comm_rank(comm) == root
    displs = accumulate(+, counts) - counts
    sendcnt = counts[Comm_rank(comm) + 1]
    recvbuf = Array{T}(undef, isroot ? sum(counts) : 0)
    ccall(MPI_GATHERV, Nothing,
          (Ptr{T}, Ref{Cint}, Ref{Cint}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          sendbuf, sendcnt, mpitype(T), recvbuf, counts, displs, mpitype(T), root, comm.val, 0)
    isroot ? recvbuf : nothing
end

function Allgatherv(sendbuf::MPIBuffertype{T}, counts::Vector{Cint},
                    comm::Comm) where T
    displs = accumulate(+, counts) - counts
    sendcnt = counts[Comm_rank(comm) + 1]
    recvbuf = Array{T}(undef, sum(counts))
    ccall(MPI_ALLGATHERV, Nothing,
          (Ptr{T}, Ref{Cint}, Ref{Cint}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          sendbuf, sendcnt, mpitype(T), recvbuf, counts, displs, mpitype(T), comm.val, 0)
    recvbuf
end

function Alltoall(sendbuf::MPIBuffertype{T}, count::Integer,
                  comm::Comm) where T
    recvbuf = Array{T}(undef, Comm_size(comm)*count)
    ccall(MPI_ALLTOALL, Nothing,
          (Ptr{T}, Ref{Cint}, Ref{Cint}, Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          sendbuf, count, mpitype(T), recvbuf, count, mpitype(T), comm.val, 0)
    recvbuf
end

function Alltoallv(sendbuf::MPIBuffertype{T}, scounts::Vector{Cint},
                   rcounts::Vector{Cint}, comm::Comm) where T
    recvbuf = Array{T}(undef, sum(rcounts))
    sdispls = accumulate(+, scounts) - scounts
    rdispls = accumulate(+, rcounts) - rcounts
    ccall(MPI_ALLTOALLV, Nothing,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ref{Cint}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          sendbuf, scounts, sdispls, mpitype(T), recvbuf, rcounts, rdispls, mpitype(T), comm.val, 0)
    recvbuf
end

function Scan(sendbuf::MPIBuffertype{T}, count::Integer,
              op::Op, comm::Comm) where T
    recvbuf = Array{T}(undef, count)
    ccall(MPI_SCAN, Nothing,
          (Ptr{T}, Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          sendbuf, recvbuf, count, mpitype(T), op.val, comm.val, 0)
    recvbuf
end

function Scan(object::T, op::Op, comm::Comm) where T
    sendbuf = T[object]
    Scan(sendbuf,1,op,comm)
end

function Exscan(sendbuf::MPIBuffertype{T}, count::Integer,
                op::Op, comm::Comm) where T
    recvbuf = Array{T}(undef, count)
    ccall(MPI_EXSCAN, Nothing,
          (Ptr{T}, Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          sendbuf, recvbuf, count, mpitype(T), op.val, comm.val, 0)
    recvbuf
end

function Exscan(object::T, op::Op, comm::Comm) where T
    sendbuf = T[object]
    Exscan(sendbuf,1,op,comm)
end

function Win_create(base::Array{T}, info::Info, comm::Comm, win::Win) where T
    out_win = Ref(win.val)
    ccall(MPI_WIN_CREATE, Nothing,
          (Ptr{T}, Ref{Cptrdiff_t}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          base, Cptrdiff_t(length(base)), sizeof(T), info.val, comm.val, out_win, 0)
    win.val = out_win[]
end

function Win_create_dynamic(info::Info, comm::Comm, win::Win)
    out_win = Ref(win.val)
    ccall(MPI_WIN_CREATE_DYNAMIC, Nothing,
          (Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          info.val, comm.val, out_win, 0)
    win.val = out_win[]
end

function Win_attach(win::Win, base::Array{T}) where T
    ccall(MPI_WIN_ATTACH, Nothing,
          (Ref{Cint}, Ptr{T}, Ref{Cptrdiff_t}, Ref{Cint}),
          win.val, base, Cptrdiff_t(sizeof(base)), 0)
end

function Win_detach(win::Win, base::Array{T}) where T
    ccall(MPI_WIN_DETACH, Nothing,
          (Ref{Cint}, Ptr{T}, Ref{Cint}),
          win.val, base, 0)
end

function Win_fence(assert::Integer, win::Win)
    ccall(MPI_WIN_FENCE, Nothing, (Ref{Cint}, Ref{Cint}, Ref{Cint}), assert, win.val, 0)
end

function Win_flush(rank::Integer, win::Win)
    ccall(MPI_WIN_FLUSH, Nothing, (Ref{Cint}, Ref{Cint}, Ref{Cint}), rank, win.val, 0)
end

function Win_free(win::Win)
    ccall(MPI_WIN_FREE, Nothing, (Ref{Cint}, Ref{Cint}), win.val, 0)
end

function Win_sync(win::Win)
    ccall(MPI_WIN_SYNC, Nothing, (Ref{Cint}, Ref{Cint}), win.val, 0)
end

function Win_sync(win::CWin)
    ccall((:MPI_Win_sync, libmpi), Nothing, (CWin,), win)
end

function Win_lock(lock_type::LockType, rank::Integer, assert::Integer, win::Win)
    ccall(MPI_WIN_LOCK, Nothing,
          (Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          lock_type.val, rank, assert, win.val, 0)
end

function Win_unlock(rank::Integer, win::Win)
    ccall(MPI_WIN_UNLOCK, Nothing, (Ref{Cint}, Ref{Cint}, Ref{Cint}), rank, win.val, 0)
end

function Get(origin_buffer::MPIBuffertype{T}, count::Integer, target_rank::Integer, target_disp::Integer, win::Win) where T
    ccall(MPI_GET, Nothing,
          (Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cptrdiff_t}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          origin_buffer, count, mpitype(T), target_rank, Cptrdiff_t(target_disp), count, mpitype(T), win.val, 0)
end
function Get(origin_buffer::Array{T}, target_rank::Integer, win::Win) where T
    count = length(origin_buffer)
    Get(origin_buffer, count, target_rank, 0, win)
end
function Get(origin_value::Ref{T}, target_rank::Integer, win::Win) where T
    Get(origin_value, 1, target_rank, 0, win)
end

function Put(origin_buffer::MPIBuffertype{T}, count::Integer, target_rank::Integer, target_disp::Integer, win::Win) where T
    ccall(MPI_PUT, Nothing,
          (Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cptrdiff_t}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          origin_buffer, count, mpitype(T), target_rank, Cptrdiff_t(target_disp), count, mpitype(T), win.val, 0)
end
function Put(origin_buffer::Array{T}, target_rank::Integer, win::Win) where T
    count = length(origin_buffer)
    Put(origin_buffer, count, target_rank, 0, win)
end
function Put(origin_value::Ref{T}, target_rank::Integer, win::Win) where T
    Put(origin_value, 1, target_rank, 0, win)
end

function Fetch_and_op(sourceval::MPIBuffertype{T}, returnval::MPIBuffertype{T}, target_rank::Integer, target_disp::Integer, op::Op, win::Win) where T
    ccall(MPI_FETCH_AND_OP, Nothing,
          (Ptr{T}, Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cptrdiff_t}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          sourceval, returnval, mpitype(T), target_rank, Cptrdiff_t(target_disp), op.val, win.val, 0)
end

function Fetch_and_op(sourceval::MPIBuffertype{T}, returnval::MPIBuffertype{T}, target_rank::Integer, target_disp::Integer, op::Op, win::CWin) where T
    ccall((:MPI_Fetch_and_op, libmpi), Nothing,
          (Ptr{T}, Ptr{T}, Cint, Cint, Cptrdiff_t, Cint, CWin),
          sourceval, returnval, mpitype(T), target_rank, target_disp, op.val, win)
end

function Accumulate(origin_buffer::MPIBuffertype{T}, count::Integer, target_rank::Integer, target_disp::Integer, op::Op, win::Win) where T
    ccall(MPI_ACCUMULATE, Nothing,
          (Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cptrdiff_t}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          origin_buffer, count, mpitype(T), target_rank, Cptrdiff_t(target_disp), count, mpitype(T), op.val, win.val, 0)
end

function Get_accumulate(origin_buffer::MPIBuffertype{T}, result_buffer::MPIBuffertype{T}, count::Integer, target_rank::Integer, target_disp::Integer, op::Op, win::Win) where T
    ccall(MPI_GET_ACCUMULATE, Nothing,
          (Ptr{T}, Ref{Cint}, Ref{Cint}, Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cptrdiff_t}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          origin_buffer, count, mpitype(T), result_buffer, count, mpitype(T), target_rank, Cptrdiff_t(target_disp), count, mpitype(T), op.val, win.val, 0)
end

function Get_address(location::MPIBuffertype{T}) where T
    addr = Ref{Cptrdiff_t}(0)
    ccall(MPI_GET_ADDRESS, Nothing, (Ptr{T}, Ref{Cptrdiff_t}, Ref{Cint}), location, addr, 0)
    return addr[]
end

function Comm_get_parent()
    comm_id = Ref{Cint}()
    ccall(MPI_COMM_GET_PARENT, Nothing, (Ref{Cint}, Ref{Cint}), comm_id, 0)
    return Comm(comm_id[])
end

function Comm_spawn(command::String, argv::Vector{String}, nprocs::Integer,
                    comm::Comm, errors = Vector{Cint}(undef, nprocs))
    c_intercomm = Ref{CComm}()
    ccall((:MPI_Comm_spawn, libmpi), Nothing,
         (Cstring, Ptr{Ptr{Cchar}}, Cint, CInfo, Cint, CComm, Ref{CComm}, Ptr{Cint}),
         command, argv, nprocs, CInfo(INFO_NULL), 0, CComm(comm), c_intercomm, errors)
    return Comm(c_intercomm[])
end

function Intercomm_merge(intercomm::Comm, flag::Bool)
    comm_id = Ref{Cint}()
    ccall(MPI_INTERCOMM_MERGE, Nothing, (Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}), intercomm.val, Cint(flag), comm_id, 0)
    return Comm(comm_id[])
end

# Conversion between C and Fortran Comm handles:
if HAVE_MPI_COMM_C2F
    # use MPI_Comm_f2c and MPI_Comm_c2f
    function CComm(comm::Comm)
      ccall((:MPI_Comm_f2c, libmpi), CComm, (Cint,), comm.val)
    end
    function Comm(ccomm::CComm)
      Comm(ccall((:MPI_Comm_c2f, libmpi), Cint, (CComm,), ccomm))
    end
    # Assume info is treated the same way
    function CInfo(info::Info)
      ccall((:MPI_Info_f2c, libmpi), CInfo, (Cint,), info.val)
    end
    function Info(cinfo::CInfo)
      Info(ccall((:MPI_Info_c2f, libmpi), Cint, (CInfo,), cinfo))
    end
    function CWin(win::Win)
      ccall((:MPI_Win_f2c, libmpi), CWin, (Cint,), win.val)
    end
    function Win(cwin::CWin)
      Win(ccall((:MPI_Win_c2f, libmpi), Cint, (CWin,), cwin))
    end
elseif sizeof(CComm) == sizeof(Cint)
    # in MPICH, both C and Fortran use identical Cint comm handles
    # and MPI_Comm_c2f is not provided.
    function CComm(comm::Comm)
      reinterpret(CComm, comm.val)
    end
    function Comm(ccomm::CComm)
      Comm(reinterpret(Cint, ccomm))
    end
    function CInfo(info::Info)
      reinterpret(CInfo, info.val)
    end
    function Info(cinfo::CInfo)
      Info(reinterpret(Cint, cinfo))
    end
    function CWin(win::Win)
      reinterpret(CWin, win.val)
    end
    function Win(cwin::CWin)
      Win(reinterpret(Cint, cwin))
    end
else
    @warn("No MPI_Comm_c2f found - conversion to/from MPI.CComm will not work")
end
