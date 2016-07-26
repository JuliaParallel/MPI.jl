typealias MPIDatatype Union{Char,
                            Int8, UInt8, Int16, UInt16, Int32, UInt32, Int64,
                            UInt64,
                            Float32, Float64, Complex64, Complex128}
typealias MPIBuffertype{T} Union{Ptr{T}, Array{T}, Ref{T}}

if VERSION >= v"0.5.0-"
    # TODO: Use Compat for this
    fieldoffsets{T}(::Type{T}) = Int[fieldoffset(T, i) for i in 1:nfields(T)]
end

if !is_windows()
    if success(`ompi_info`)
        MPIString = "OpenRTE"
    else
        MPIString = readstring(`mpiexec --version`)
    end
else
    MPIString = readstring(`mpiexec`)
end

if ismatch(r"OpenRTE", MPIString)
    MPIName = :OpenMPI
elseif ismatch(r"mpich", MPIString)
    MPIName = :MPICH
elseif ismatch(r"Intel", MPIString)
    MPIName = :Intel
elseif ismatch(r"Microsoft", MPIString)
    MPIName = :Microsoft
else
    error("Your MPI implementation is not known to MPI.jl. Please add the necessary constant from
        from mpi.h of your MPI implementation ans submit pull request.")
end

if MPIName == :OpenMPI

    # See issue #17584
    # immutable Status
    #     # These fields are publicly defined in the MPI specification.
    #     # User applications may freely read from these fields.
    #     source::Cint
    #     tag::Cint
    #     error::Cint

    #     _cancelled::Cint
    #     _ucount::Csize_t
    #     # The following fields is buffer space
    #     # buf::NTuple{6,Cint}
    # end


    typealias MPI_Comm          Ptr{Void}
    typealias MPI_Datatype      Ptr{Void}
    typealias MPI_Op            Ptr{Void}
    typealias MPI_Request       Ptr{Void}
    typealias MPI_User_function Ptr{Void}

    const WCHAR            = cglobal((:ompi_mpi_wchar, libmpi))
    const UINT8_T          = cglobal((:ompi_mpi_uint8_t, libmpi))
    const UINT16_T         = cglobal((:ompi_mpi_uint16_t, libmpi))
    const UINT32_T         = cglobal((:ompi_mpi_uint32_t, libmpi))
    const UINT64_T         = cglobal((:ompi_mpi_uint64_t, libmpi))
    const INT8_T           = cglobal((:ompi_mpi_int8_t, libmpi))
    const INT16_T          = cglobal((:ompi_mpi_int16_t, libmpi))
    const INT32_T          = cglobal((:ompi_mpi_int32_t, libmpi))
    const INT64_T          = cglobal((:ompi_mpi_int64_t, libmpi))
    const FLOAT            = cglobal((:ompi_mpi_float, libmpi))
    const DOUBLE           = cglobal((:ompi_mpi_double, libmpi))
    const C_FLOAT_COMPLEX  = cglobal((:ompi_mpi_c_float_complex, libmpi))
    const C_DOUBLE_COMPLEX = cglobal((:ompi_mpi_c_double_complex, libmpi))

    const MAX              = cglobal((:ompi_mpi_op_max, libmpi))
    const MIN              = cglobal((:ompi_mpi_op_min, libmpi))
    const PROD             = cglobal((:ompi_mpi_op_prod, libmpi))
    const SUM              = cglobal((:ompi_mpi_op_sum, libmpi))
    const BAND             = cglobal((:ompi_mpi_op_band, libmpi))
    const BOR              = cglobal((:ompi_mpi_op_bor, libmpi))
    const BXOR             = cglobal((:ompi_mpi_op_bxor, libmpi))
    const OP_NULL          = cglobal((:ompi_mpi_op_null, libmpi))

    const ANY_SOURCE       = Cint(-1)
    const UNDEFINED        = Cint(-32766)

elseif MPIName in (:MPICH, :Intel)

    typealias MPI_Comm          Cint
    typealias MPI_Datatype      Cint
    typealias MPI_Errhandler    Cint
    typealias MPI_Group         Cint
    typealias MPI_Message       Cint
    typealias MPI_Op            Cint
    typealias MPI_Request       Cint
    typealias MPI_User_function Cint

    const CHAR               = MPI_Datatype(0x4c000101)
    const SIGNED_CHAR        = MPI_Datatype(0x4c000118)
    const UNSIGNED_CHAR      = MPI_Datatype(0x4c000102)
    const BYTE               = MPI_Datatype(0x4c00010d)
    const WCHAR              = MPI_Datatype(0x4c00040e)
    const SHORT              = MPI_Datatype(0x4c000203)
    const UNSIGNED_SHORT     = MPI_Datatype(0x4c000204)
    const INT                = MPI_Datatype(0x4c000405)
    const UNSIGNED           = MPI_Datatype(0x4c000406)
    const LONG               = MPI_Datatype(0x4c000807)
    const UNSIGNED_LONG      = MPI_Datatype(0x4c000808)
    const FLOAT              = MPI_Datatype(0x4c00040a)
    const DOUBLE             = MPI_Datatype(0x4c00080b)
    const LONG_DOUBLE        = MPI_Datatype(0x4c00100c)
    const LONG_LONG_INT      = MPI_Datatype(0x4c000809)
    const UNSIGNED_LONG_LONG = MPI_Datatype(0x4c000819)
    const LONG_LONG          = LONG_LONG_INT

    const INT8_T         = MPI_Datatype(0x4c000137)
    const INT16_T        = MPI_Datatype(0x4c000238)
    const INT32_T        = MPI_Datatype(0x4c000439)
    const INT64_T        = MPI_Datatype(0x4c00083a)
    const UINT8_T        = MPI_Datatype(0x4c00013b)
    const UINT16_T       = MPI_Datatype(0x4c00023c)
    const UINT32_T       = MPI_Datatype(0x4c00043d)
    const UINT64_T       = MPI_Datatype(0x4c00083e)

    const C_BOOL                = MPI_Datatype(0x4c00013f)
    const C_FLOAT_COMPLEX       = MPI_Datatype(0x4c000840)
    const C_COMPLEX             = C_FLOAT_COMPLEX
    const C_DOUBLE_COMPLEX      = MPI_Datatype(0x4c001041)
    const C_LONG_DOUBLE_COMPLEX = MPI_Datatype(0x4c002042)

    const MAX     = MPI_Op(0x58000001)
    const MIN     = MPI_Op(0x58000002)
    const SUM     = MPI_Op(0x58000003)
    const PROD    = MPI_Op(0x58000004)
    const LAND    = MPI_Op(0x58000005)
    const BAND    = MPI_Op(0x58000006)
    const LOR     = MPI_Op(0x58000007)
    const BOR     = MPI_Op(0x58000008)
    const LXOR    = MPI_Op(0x58000009)
    const BXOR    = MPI_Op(0x5800000a)
    const MINLOC  = MPI_Op(0x5800000b)
    const MAXLOC  = MPI_Op(0x5800000c)
    const REPLACE = MPI_Op(0x5800000d)
    const NO_OP   = MPI_Op(0x5800000e)

    const ANY_SOURCE       = Cint(-2)
    const UNDEFINED        = Cint(-32766)
end


immutable Comm
    val::MPI_Comm
end

type Request
    val::MPI_Request
    buffer
end

if MPIName == :OpenMPI
    const COMM_WORLD           = Comm(cglobal((:ompi_mpi_comm_world, libmpi)))

    const REQUEST_NULL         = Request(cglobal((:ompi_request_null, libmpi)), nothing)
elseif MPIName in (:MPICH, :Intel)
    const COMM_WORLD      = Comm(MPI_Comm(0x44000000))
    const COMM_SELF       = MPI_Comm(0x44000001)

    const COMM_NULL       = Comm(MPI_Comm(0x04000000))
    const OP_NULL         = MPI_Op(0x18000000)
    const GROUP_NULL      = MPI_Group(0x08000000)
    const DATATYPE_NULL   = MPI_Datatype(0x0c000000)
    const REQUEST_NULL    = Request(MPI_Request(0x2c000000), nothing)
    const ERRHANDLER_NULL = MPI_Errhandler(0x14000000)
    const MESSAGE_NULL    = MPI_Message(0x2c000000)
    const MESSAGE_NO_PROC = MPI_Message(0x6c000000)
end

if MPIName == :OpenMPI
    immutable Status
        # These fields are publicly defined in the MPI specification.
        # User applications may freely read from these fields.
        source::Cint
        tag::Cint
        error::Cint

        _cancelled::Cint
        _ucount::Csize_t
        # The following fields is buffer space
        # buf::NTuple{6,Cint}
    end
elseif MPIName in (:MPICH, :Intel)
    immutable Status
        count_lo::Cint
        count_hi_and_cancelled::Cint
        source::Cint
        tag::Cint
        error::Cint
    end
end

const mpitype_dict = Dict{DataType, MPI_Datatype}()
const mpitype_dict_inverse = Dict{MPI_Datatype, DataType}()

function __init__()
    for (T,S) in (Char       => INT32_T,
                  Int8       => INT8_T,
                  UInt8      => UINT8_T,
                  Int16      => INT16_T,
                  UInt16     => UINT16_T,
                  Int32      => INT32_T,
                  UInt32     => UINT32_T,
                  Int64      => INT64_T,
                  UInt64     => UINT64_T,
                  Float32    => FLOAT,
                  Float64    => DOUBLE,
                  Complex64  => C_FLOAT_COMPLEX,
                  Complex128 => C_DOUBLE_COMPLEX)
        mpitype_dict[T] = S
        mpitype_dict_inverse[S] = T
    end
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
    types = Array(MPI_Datatype, nfields)
    for i=1:nfields
        displacements[i] = offsets[i]
        # create an MPI_Datatype for the current field if it does not exist yet
        types[i] = mpitype(fieldtypes[i])
    end

    # create the datatype
    newtype_ref = Ref{MPI_Datatype}()
    flag = Ref{Cint}()
    err = ccall((:MPI_Type_create_struct, libmpi), Cint,
                (Cint, Ptr{Cint}, Ptr{Cptrdiff_t}, Ptr{MPI_Datatype}, Ref{MPI_Datatype}),
                 nfields, blocklengths, displacements, types, newtype_ref)

    if err != 0
        throw(ErrorException("MPI_Type_create_struct returned non-zero exit status"))
    end

    # commit the datatatype
    err = ccall((:MPI_Type_commit, libmpi), Cint, (Ref{MPI_Datatype},), newtype_ref)

    if err != 0
        throw(ErrorException("MPI_Type_commit returned non-zero exit status"))
    end

    # add it to the dictonary of known types
    mpitype_dict[T] = newtype_ref[]
    mpitype_dict_inverse[newtype_ref[]] = T

    return mpitype_dict[T]
end

include("mpi-op.jl")

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


function Abort(comm::Comm, errcode::Integer)
    ccall((:MPI_Abort, libmpi), Cint,
           (Ptr{MPI_Comm}, Cint),
           comm.val, errcode)
end


function Allgather{T}(sendbuf::MPIBuffertype{T}, count::Integer, comm::Comm)
    recvbuf = Array(T, Comm_size(comm) * count)
    ccall((:MPI_Allgather, libmpi), Cint,
          (Ptr{Void}, Cint, MPI_Datatype, Ptr{Void}, Cint, MPI_Datatype, MPI_Comm),
          sendbuf, count, mpitype(T), recvbuf, count, mpitype(T), comm.val)
    return recvbuf
end

function Allgather{T}(sendbuf::Array{T}, comm::Comm)
    Allgather(sendbuf, length(sendbuf), comm)
end

function Allgather{T}(object::T, comm::Comm)
    sendbuf = T[object]
    recvbuf = Allgather(sendbuf, comm)
    return recvbuf
end


function Allgatherv{T}(sendbuf::MPIBuffertype{T}, counts::Vector{Cint}, comm::Comm)
    displs = cumsum(counts) - counts
    sendcnt = counts[Comm_rank(comm) + 1]
    recvbuf = Array(T, sum(counts))
    ccall((:MPI_Allgatherv, libmpi), Cint,
          (Ptr{Void}, Cint, MPI_Datatype, Ptr{Void}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm),
          sendbuf, sendcnt, mpitype(T), recvbuf, counts, displs, mpitype(T), comm.val)
    return recvbuf
end


function Allreduce!{T}(sendbuf::MPIBuffertype{T}, recvbuf::MPIBuffertype{T}, count::Integer, op, comm::Comm)
    ccall((:MPI_Allreduce, libmpi), Cint,
        (Ptr{Void}, Ptr{Void}, Cint, MPI_Datatype, MPI_Op, MPI_Comm), 
        sendbuf, recvbuf, count, mpitype(T), mpiop(op), comm.val)

    return recvbuf
end

function Allreduce!{T}(sendbuf::MPIBuffertype{T}, recvbuf::MPIBuffertype{T}, op, comm::Comm)
    Allreduce!(sendbuf, recvbuf, length(recvbuf), op, comm)
end

function Allreduce{T}(obj::T, op, comm::Comm)
    objref = Ref(obj)
    outref = Ref{T}()
    Allreduce!(objref, outref, 1, op, comm)

    outref[]
end

# allocate receive buffer automatically
function allreduce{T}(sendbuf::MPIBuffertype{T}, op, comm::Comm)

  recvbuf = similar(sendbuf)
  Allreduce!(sendbuf, recvbuf, length(recvbuf), op, comm)
end


function Alltoall{T}(sendbuf::MPIBuffertype{T}, count::Integer, comm::Comm)
    recvbuf = Array(T, Comm_size(comm)*count)
    ccall((:MPI_Alltoall, libmpi), Cint,
          (Ptr{Void}, Cint, MPI_Datatype, Ptr{Void}, Cint, MPI_Datatype, MPI_Comm),
          sendbuf, count, mpitype(T), recvbuf, count, mpitype(T), comm.val)
    return recvbuf
end


function Alltoallv{T}(sendbuf::MPIBuffertype{T}, scounts::Vector{Cint}, rcounts::Vector{Cint}, comm::Comm)
    recvbuf = Array(T, sum(rcounts))
    sdispls = cumsum(scounts) - scounts
    rdispls = cumsum(rcounts) - rcounts
    ccall((:MPI_Alltoallv, libmpi), Cint,
          (Ptr{Void}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Void}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm),
          sendbuf, scounts, sdispls, mpitype(T), recvbuf, rcounts, rdispls, mpitype(T), comm.val)
    return recvbuf
end


function Barrier(comm::Comm)
    ccall((:MPI_Barrier, libmpi), Cint, (MPI_Comm,), comm.val)
end


function Bcast!{T}(buffer::MPIBuffertype{T}, count::Integer, root::Integer, comm::Comm)
    ccall((:MPI_Bcast, libmpi), Cint,
          (Ptr{Void}, Cint, MPI_Datatype, Cint, MPI_Comm),
          buffer, count, mpitype(T), root, comm.val)
    return buffer
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
    return obj
end


function Cancel!(req::Request)
    ccall((:MPI_Cancel, libmpi), Cint, (Ptr{MPI_Request},), &req.val)
    req.buffer = nothing
    nothing
end


function Comm_dup(comm::Comm)
    newcomm = Ref{MPI_Comm}()
    ccall((:MPI_Comm_dup, libmpi), Cint, (MPI_Comm, Ref{MPI_Comm}),
          comm.val, newcomm)
    MPI.Comm(newcomm[])
end


function Comm_free(comm::Comm)
    ccall((:MPI_Comm_free, libmpi), Cint, (Ptr{MPI_Comm},), &comm.val)
end


function Comm_rank(comm::Comm)
    r = Ref{Cint}()
    ccall((:MPI_Comm_rank, libmpi), Cint, (MPI_Comm, Ref{Cint}),
          comm.val, r)
    Int(r[])
end


function Comm_size(comm::Comm)
    s = Ref{Cint}()
    ccall((:MPI_Comm_size, libmpi), Cint, (MPI_Comm, Ref{Cint}),
          comm.val, s)
    Int(s[])
end


function Exscan{T}(sendbuf::MPIBuffertype{T}, count::Integer, op, comm::Comm)
    recvbuf = Array(T, count)
    ccall((:MPI_Exscan, libmpi), Cint,
          (Ptr{Void}, Ptr{Void}, Cint, MPI_Datatype, MPI_Op, MPI_Comm),
          sendbuf, recvbuf, count, mpitype(T), mpiop(op), comm.val)
    return recvbuf
end

function Exscan{T}(object::T, op, comm::Comm)
    sendbuf = Ref{T}(object)
    Exscan(sendbuf, 1, op, comm)
end


function Finalize()
    ccall((:MPI_Finalize, libmpi), Cint, ())
end


function Finalized()
    flag = Ref{Cint}()
    ccall((:MPI_Finalized, libmpi), Cint, (Ref{Cint},), flag)
    flag[] != 0
end


function Gather{T}(sendbuf::MPIBuffertype{T}, count::Integer, root::Integer, comm::Comm)
    isroot = Comm_rank(comm) == root
    recvbuf = Array(T, isroot ? Comm_size(comm) * count : 0)
    ccall((:MPI_Gather, libmpi), Cint,
          (Ptr{Void}, Cint, MPI_Datatype, Ptr{Void}, Cint, MPI_Datatype, Cint, MPI_Comm),
          sendbuf, count, mpitype(T), recvbuf, count, mpitype(T), root, comm.val)
    return isroot ? recvbuf : nothing
end

function Gather{T}(sendbuf::Array{T}, root::Integer, comm::Comm)
    Gather(sendbuf, length(sendbuf), root, comm)
end

function Gather{T}(object::T, root::Integer, comm::Comm)
    isroot = Comm_rank(comm) == root
    sendbuf = T[object]
    recvbuf = Gather(sendbuf, root, comm)
    return isroot ? recvbuf : nothing
end


function Gatherv{T}(sendbuf::MPIBuffertype{T}, counts::Vector{Cint}, root::Integer, comm::Comm)
    isroot = Comm_rank(comm) == root
    displs = cumsum(counts) - counts
    sendcnt = counts[Comm_rank(comm) + 1]
    recvbuf = Array(T, isroot ? sum(counts) : 0)
    ccall((:MPI_Gatherv, libmpi), Cint,
          (Ptr{Void}, Cint, MPI_Datatype, Ptr{Void}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm),
          sendbuf, sendcnt, mpitype(T), recvbuf, counts, displs, mpitype(T), root, comm.val)
    return isroot ? recvbuf : nothing
end


function Get_count{T}(stat::Status, ::Type{T})
    count = Ref{Cint}()
    ccall((:MPI_Get_count, libmpi), Cint,
        (Ptr{Status}, MPI_Datatype, Ref{Cint}),
         &stat, mpitype(T), count)
    Int(count[])
end


function Ialltoallv{T}(sendbuf::MPIBuffertype{T}, scounts::Vector{Cint}, rcounts::Vector{Cint}, comm::Comm)
    recvbuf = Array(T, sum(rcounts))
    sdispls = cumsum(scounts) - scounts
    rdispls = cumsum(rcounts) - rcounts
    req = Ref{MPI_Request}()
    ccall((:MPI_Ialltoallv, libmpi), Cint,
          (Ptr{Void}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Void},
           Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ref{MPI_Request}),
           sendbuf, scounts, sdispls, mpitype(T), recvbuf,
           rcounts, rdispls, mpitype(T), comm.val, req)
    Request(req[], recvbuf)
end

### Should take ARG arguments
function Init()
    ccall((:MPI_Init, libmpi), Cint, (Ptr{Cint}, Ptr{Ptr{Ptr{UInt8}}}), C_NULL, C_NULL)
end


function Initialized()
    flag = Ref{Cint}()
    ccall((:MPI_Initialized, libmpi), Cint, (Ref{Cint},), flag)
    flag[] != 0
end


function Iprobe(src::Integer, tag::Integer, comm::Comm)
    flag = Ref{Cint}()
    stat = Ref{Status}()
    ccall((:MPI_Iprobe, libmpi), Cint,
          (Cint, Cint, MPI_Comm, Ref{Cint}, Ref{Status}),
           src, tag, comm.val, flag, stat)
    if flag[] == 0
        return false, nothing
    end
    true, stat[]
end


function Irecv!{T}(buf::MPIBuffertype{T}, count::Integer, src::Integer, tag::Integer, comm::Comm)
    req = Ref{MPI_Request}()
    ccall((:MPI_Irecv, libmpi), Cint,
          (Ptr{Void}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ref{MPI_Request}),
          buf, count, mpitype(T), src, tag, comm.val, req)
    Request(req[], buf)
end

function Irecv!{T}(buf::Array{T}, src::Integer, tag::Integer, comm::Comm)
    Irecv!(buf, length(buf), src, tag, comm)
end

function irecv(src::Integer, tag::Integer, comm::Comm)
    (flag, stat) = Iprobe(src, tag, comm)
    if !flag
        return (false, nothing, nothing)
    end
    count = Get_count(stat, UInt8)
    buf = Array(UInt8, count)
    stat = Recv!(buf, stat.source, stat.tag, comm)
    (true, MPI.deserialize(buf), stat)
end


function Isend{T}(buf::MPIBuffertype{T}, count::Integer, dest::Integer, tag::Integer, comm::Comm)
    req = Ref{MPI_Request}()
    ccall((:MPI_Isend, libmpi), Cint,
          (Ptr{Void}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ref{MPI_Request}),
          buf, count, mpitype(T), dest, tag, comm.val, req)
    Request(req[], buf)
end

function Isend{T}(buf::Array{T}, dest::Integer, tag::Integer, comm::Comm)
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


function Probe(src::Integer, tag::Integer, comm::Comm)
    stat = Ref{Status}()
    ccall((:MPI_Probe, libmpi), Cint,
          (Cint, Cint, MPI_Comm, Ref{Status}),
          src, tag, comm.val, stat)
    stat[]
end


function Recv!{T}(buf::MPIBuffertype{T}, count::Integer, src::Integer, tag::Integer, comm::Comm)
    stat = Ref{Status}()
    ccall((:MPI_Recv, libmpi), Cint,
          (Ptr{Void}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ref{Status}),
          buf, count, mpitype(T), src, tag, comm.val, stat)
    return stat[]
end

function Recv!{T}(buf::Array{T}, src::Integer, tag::Integer, comm::Comm)
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
    stat = Recv!(buf, stat.source, stat.tag, comm)
    (MPI.deserialize(buf), stat)
end


function Reduce{T}(sendbuf::MPIBuffertype{T}, count::Integer, op, root::Integer, comm::Comm)
    isroot = Comm_rank(comm) == root
    recvbuf = Array(T, isroot ? count : 0)
    ccall((:MPI_Reduce, libmpi), Cint,
          (Ptr{Void}, Ptr{Void}, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm),
          sendbuf, recvbuf, count, mpitype(T), mpiop(op), root, comm.val)
    return isroot ? recvbuf : nothing
end

function Reduce{T}(sendbuf::Array{T}, op, root::Integer, comm::Comm)
    Reduce(sendbuf, length(sendbuf), op, root, comm)
end

function Reduce{T}(object::T, op, root::Integer, comm::Comm)
    isroot = Comm_rank(comm) == root
    sendbuf = T[object]
    recvbuf = Reduce(sendbuf, op, root, comm)
    return isroot ? recvbuf[1] : nothing
end


function Scan{T}(sendbuf::MPIBuffertype{T}, count::Integer, op, comm::Comm)
    recvbuf = Array(T, count)
    ccall((:MPI_Scan, libmpi), Cint,
          (Ptr{Void}, Ptr{Void}, Cint, MPI_Datatype, MPI_Op, MPI_Comm),
          sendbuf, recvbuf, count, mpitype(T), mpiop(op), comm.val)
    return recvbuf
end

function Scan{T}(object::T, op, comm::Comm)
    sendbuf = Ref{T}(object)
    Scan(sendbuf, 1, op, comm)
end


function Scatter{T}(sendbuf::MPIBuffertype{T}, count::Integer, root::Integer, comm::Comm)
    recvbuf = Array(T, count)
    ccall((:MPI_Scatter, libmpi), Cint,
          (Ptr{Void}, Cint, MPI_Datatype, Ptr{Void}, Cint, MPI_Datatype, Cint, MPI_Comm),
           sendbuf, count, mpitype(T), recvbuf, count, mpitype(T), root, comm.val)
    return recvbuf
end


function Scatterv{T}(sendbuf::MPIBuffertype{T}, counts::Vector{Cint}, root::Integer, comm::Comm)
    recvbuf = Array(T, counts[Comm_rank(comm) + 1])
    recvcnt = counts[Comm_rank(comm) + 1]
    disps = cumsum(counts) - counts
    ccall((:MPI_Scatterv, libmpi), Cint,
          (Ptr{Void}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Void}, Cint, MPI_Datatype, Cint, MPI_Comm),
          sendbuf, counts, disps, mpitype(T), recvbuf, recvcnt, mpitype(T), root, comm.val)
    return recvbuf
end


function Send{T}(buf::MPIBuffertype{T}, count::Integer, dest::Integer, tag::Integer, comm::Comm)
    ccall((:MPI_Send, libmpi), Cint,
          (Ptr{Void}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm),
          buf, count, mpitype(T), dest, tag, comm.val)
end

function Send{T}(buf::Array{T}, dest::Integer, tag::Integer, comm::Comm)
    Send(buf, length(buf), dest, tag, comm)
end

function Send{T}(obj::T, dest::Integer, tag::Integer, comm::Comm)
    buf = [obj]
    Send(buf, dest, tag, comm)[]
end

function send(obj, dest::Integer, tag::Integer, comm::Comm)
    buf = MPI.serialize(obj)
    Send(buf, dest, tag, comm)
end


function Test!(req::Request)
    flag = Ref{Cint}()
    stat = Ref{Status}()
    ccall((:MPI_Test, libmpi), Cint,
        (Ptr{MPI_Request}, Ref{Cint}, Ref{Status}),
         &req.val, flag, stat)
    if flag[] == 0
        return (false, nothing)
    end
    req.buffer = nothing
    (true, stat[])
end


function Testall!(reqs::Array{Request,1})
    count = length(reqs)
    reqvals = MPI_Request[reqs[i].val for i in 1:count]
    flag = Ref{Cint}()
    stats = Array(Status, count)
    ccall((:MPI_Testall, libmpi), Cint,
          (Cint, Ptr{MPI_Request}, Ref{Cint}, Ptr{Status}),
          count, reqvals, flag, stats)
    if flag[] == 0
        return (false, nothing)
    end
    for i in 1:count
        reqs[i].val = reqvals[i]
        reqs[i].buffer = nothing
    end
    return (true, stats)
end


function Testany!(reqs::Array{Request,1})
    count = length(reqs)
    reqvals = [reqs[i].val for i in 1:count]
    ind = Ref{Cint}()
    flag = Ref{Cint}()
    stat = Ref{Status}()
    ccall((:MPI_Testany, libmpi), Cint,
        (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ref{Status}),
         count, reqvals, ind, flag, stat)
    index = Int(ind[])
    if flag[] == 0 || index == UNDEFINED
        return (false, 0, nothing)
    end
    index += 1 # C is zero based
    reqs[index].val = reqvals[index]
    reqs[index].buffer = nothing
    (true, index, stat[])
end


function Testsome!(reqs::Array{Request,1})
    count = length(reqs)
    reqvals = [reqs[i].val for i in 1:count]
    outcnt = Ref{Cint}()
    inds = Array(Cint, count)
    stats = Array(Status, count)
    ccall((:MPI_Testsome, libmpi), Cint,
        (Cint, Ptr{MPI_Request}, Ref{Cint}, Ptr{Cint}, Ptr{Status}),
         count, reqvals, outcnt, inds, stats)
    outcount = outcnt[]
    # This can happen if there were no valid requests
    if outcount == UNDEFINED
        outcount = 0
    end
    indices = Array(Int, outcount)
    for i in 1:outcount
        ind = Int(inds[i]) + 1 # C is zero based
        reqs[ind].val = reqvals[ind]
        reqs[ind].buffer = nothing
        indices[i] = inds[i] + 1 # C is zero based
    end
    (indices, stats[])
end


function Wait!(req::Request)
    stat = Ref{Status}()
    ccall((:MPI_Wait, libmpi), Cint, (Ptr{MPI_Request}, Ref{Status}), &req.val, stat)
    req.buffer = nothing
    stat[]
end


function Waitall!(reqs::Array{Request,1})
    count = length(reqs)
    reqvals = MPI_Request[reqs[i].val for i in 1:count]
    stats = Array(Status, count)
    ccall((:MPI_Waitall, libmpi), Cint,
          (Cint, Ptr{MPI_Request}, Ptr{Status}),
          count, reqvals, stats)
    for i in 1:count
        reqs[i].val = reqvals[i]
        reqs[i].buffer = nothing
    end
    return stats
end


function Waitany!(reqs::Array{Request,1})
    count = length(reqs)
    reqvals = [reqs[i].val for i in 1:count]
    ind = Ref{Cint}()
    stat = Ref{Status}()
    ccall((:MPI_Waitany, libmpi), Cint,
        (Cint, Ptr{MPI_Request}, Ref{Cint}, Ref{Status}),
         count, reqvals, ind, stat)
    index = Int(ind[]) + 1 # C is zero based
    reqs[index].val = reqvals[index]
    reqs[index].buffer = nothing
    (index, stat[])
end


function Waitsome!(reqs::Array{Request,1})
    count = length(reqs)
    reqvals = [reqs[i].val for i in 1:count]
    outcnt = Ref{Cint}()
    inds = Array(Cint, count)
    stats = Array(Status, count)
    ccall((:MPI_Waitsome, libmpi), Cint,
        (Cint, Ptr{MPI_Request}, Ref{Cint}, Ptr{Cint}, Ptr{Status}),
         count, reqvals, outcnt, inds, stats)
    outcount = Int(outcnt[])
    # This can happen if there were no valid requests
    if outcount == UNDEFINED
        outcount = 0
    end
    indices = Array(Int, outcount)
    for i in 1:outcount
        ind = Int(inds[i]) + 1 # C is zero based
        reqs[ind].val = reqvals[ind]
        reqs[ind].buffer = nothing
        indices[i] = inds[i] + 1 # C is zero based
    end
    (indices, stats)
end




# Conversion between C and Fortran Comm handles:
# if HAVE_MPI_COMM_C2F
#     # use MPI_Comm_f2c and MPI_Comm_c2f
#     Base.convert(::Type{CComm}, comm::Comm) =
#         ccall(:MPI_Comm_f2c, CComm, (Cint,), comm.val)
#     Base.convert(::Type{Comm}, ccomm::CComm) =
#         Comm(ccall(:MPI_Comm_c2f, Cint, (CComm,), ccomm))
# elseif sizeof(CComm) == sizeof(Cint)
#     # in MPICH, both C and Fortran use identical Cint comm handles
#     # and MPI_Comm_c2f is not provided.
#     Base.convert(::Type{CComm}, comm::Comm) = reinterpret(CComm, comm.val)
#     Base.convert(::Type{Comm}, ccomm::CComm) = Comm(reinterpret(Cint, ccomm))
# else
#     warn("No MPI_Comm_c2f found - conversion to/from MPI.CComm will not work")
# end
