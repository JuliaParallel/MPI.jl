const MPIDatatype = Union{Char,
                            Int8, UInt8, Int16, UInt16, Int32, UInt32, Int64,
                            UInt64,
                            Float32, Float64, ComplexF32, ComplexF64}
MPIBuffertype{T} = Union{Ptr{T}, Array{T}, SubArray{T}, Ref{T}}

# Type used to hold constant void pointers such as MPI_IN_PLACE and MPI_BOTTOM
primitive type ConstantPtr sizeof(Ptr{Cvoid})*8 end
Base.cconvert(::Type{Ptr{T}}, x::ConstantPtr) where {T} = reinterpret(Ptr{T}, x)

MPIBuffertypeOrConst{T} = Union{MPIBuffertype{T}, ConstantPtr}

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

    if nfields == 0  # primitive type
      if sizeof(T) == 0
        error("Can't convert 0-size type to MPI")
      end
      nfields, blocklengths, displacements, types = factorPrimitiveType(T)
    else  # struct
      # put data in MPI format
      blocklengths = ones(Cint, nfields)
      displacements = zeros(Cptrdiff_t, nfields)  # size_t == MPI_Aint ?
      types = zeros(Cint, nfields)
      for i=1:nfields
          displacements[i] = offsets[i]
          # create an MPI_Datatype for the current field if it does not exist yet
          types[i] = mpitype(fieldtypes[i])
      end

    end

    newtype = Type_Create_Struct(nfields, blocklengths, displacements, types)

    # commit the datatatype
    Type_Commit(newtype)

    # add it to the dictonary of known types
    recordDataType(T, newtype)

    return mpitype_dict[T]
end


function factorPrimitiveType(::Type{T}) where {T}

  tsize = sizeof(T)  # size in bytes
  displacements = zeros(Cptrdiff_t, 0)  # size_t == MPI_Aint ?
  types = zeros(Cint, 0)

  # put largest sizes first
  mpi_types = [MPI_INTEGER8, MPI_INTEGER4, MPI_INTEGER2, MPI_INTEGER1]
  mpi_sizes = [8, 4, 2, 1]
  curr_disp = 0

  while curr_disp != tsize
    remsize = tsize - curr_disp
    for i=1:length(mpi_types)
      size_i = mpi_sizes[i]
      # because each size is a multiple of the smaller sizes, taking the largest
      # size always results in the smallest number of types and doesn't result
      # in avoidable small remainders
      if remsize >= size_i
        push!(types, mpi_types[i])
        push!(displacements, curr_disp)
        curr_disp += size_i
        break
      end
    end
  end
  
  nfields = length(types)
  blocklengths = ones(Cint, nfields)

  return nfields, blocklengths, displacements, types
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

include("mpi-info.jl")

mutable struct Status
    val::Array{Cint,1}
    Status() = new(Array{Cint}(undef, MPI_STATUS_SIZE))
end
Get_error(stat::Status) = Int(stat.val[MPI_ERROR])
Get_source(stat::Status) = Int(stat.val[MPI_SOURCE])
Get_tag(stat::Status) = Int(stat.val[MPI_TAG])

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
    Serialization.serialize(s, x)
    take!(s)
end

function deserialize(x)
    s = IOBuffer(x)
    Serialization.deserialize(s)
end

const REFCOUNT = Threads.Atomic{Int}(1)

"""
    refcount_inc()

Increment the MPI reference counter. This should be called at initialization of any object
which calls an MPI routine in its finalizer. A matching [`refcount_dec`](@ref) should be
added to the finalizer.

For more details, see [Finalizers](@ref).
"""
function refcount_inc()
    Threads.atomic_add!(REFCOUNT, 1)
end

"""
    refcount_dec()

Decrement the MPI reference counter. This should be added after an MPI call in an object
finalizer, with a matching [`refcount_inc`](@ref) when the object is initialized.

For more details, see [Finalizers](@ref).
"""
function refcount_dec()
    # refcount zero, all objects finalized, now finalize MPI
    if Threads.atomic_sub!(REFCOUNT, 1) == 1
        !Finalized() && _Finalize()
    end
end

# Administrative functions
"""
    Init()

Initialize MPI in the current process.

All MPI programs must contain exactly one call to `MPI.Init()`.

The only MPI functions that may be called before `MPI.Init()` are
[`MPI.Initialized`](@ref) and [`MPI.Finalized`](@ref).
"""
function Init()
    if REFCOUNT[] != 1
        error("MPI REFCOUNT in incorrect state")
    end
    ccall(MPI_INIT, Nothing, (Ref{Cint},), 0)
    atexit(refcount_dec)

    # initialise constants
    INFO_NULL.cinfo = CInfo(MPI_INFO_NULL)
end

"""
    Finalize()

Marks MPI state for cleanup. This should be called after [`Init`](@ref), at most once, and
no further MPI calls (other than [`Initialized`](@ref) or [`Finalized`](@ref)) should be
made after it is called.

Note that this does not correspond exactly to `MPI_FINALIZE` in the MPI specification. In
particular:

- It may not finalize MPI immediately. Julia will wait until all MPI-related objects are
  garbage collected before finalizing MPI. As a result, [`Finalized()`](@ref) may return
  `false` after `Finalize()` has been called. See [Finalizers](@ref) for more details.

- It is optional: [`Init`](@ref) will automatically insert a hook to finalize MPI when
  Julia exits.

"""
function Finalize()
    # calling atexit here is a bit silly, but it's to avoid a case where MPI is finalized
    # one object early, e.g.
    #
    # event         | REFCOUNT
    # ---------------------
    # Init()        |   1  : MPI_INIT
    # new object    |   2  : MPI_X_CREATE
    # Finalize()    |   1
    # atexit        |
    #  refcount_inc |   2  : relies on LIFO ordering
    #  refcount_dec |   1  : MPI_FINALIZE would otherwise be called here
    # finalizers    |
    #  refcount_dec |   0  : MPI_X_FREE, MPI_FINALIZE
    atexit(refcount_inc)    
    refcount_dec()
end

function _Finalize()
    ccall(MPI_FINALIZE, Nothing, (Ref{Cint},), 0)
end

"""
    Abort(comm::Comm, errcode::Integer)

Make a “best attempt” to abort all tasks in the group of `comm`. This function does not
require that the invoking environment take any action with the error code. However, a Unix
or POSIX environment should handle this as a return errorcode from the main program.
"""
function Abort(comm::Comm, errcode::Integer)
    ccall(MPI_ABORT, Nothing, (Ref{Cint}, Ref{Cint}, Ref{Cint}),
          comm.val, errcode, 0)
end

"""
    Initialized()

Returns `true` if [`MPI.Init`](@ref) has been called, `false` otherwise. 

It is unaffected by [`MPI.Finalize`](@ref), and is one of the few functions that may be
called before [`MPI.Init`](@ref).
"""
function Initialized()
    flag = Ref{Cint}()
    ccall(MPI_INITIALIZED, Nothing, (Ptr{Cint}, Ref{Cint}), flag, 0)
    flag[] != 0
end

"""
    Finalized()

Returns `true` if [`MPI.Finalize`](@ref) has completed, `false` otherwise. 

It is safe to call before [`MPI.Init`](@ref) and after [`MPI.Finalize`](@ref).
"""
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

"""
    Comm_rank(comm:Comm)

The rank of the process in the particular communicator’s group. 

Returns an integer in the range `0:MPI.Comm_size()-1`.
"""
function Comm_rank(comm::Comm)
    rank = Ref{Cint}()
    ccall(MPI_COMM_RANK, Nothing, (Ref{Cint}, Ptr{Cint}, Ref{Cint}),
          comm.val, rank, 0)
    Int(rank[])
end

"""
    Comm_size(comm:Comm)

The number of processes involved in communicator.
"""
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

function Comm_split_type(comm::Comm,split_type::Integer,key::Integer; kwargs...)
    newcomm = Ref{Cint}()
    ccall(MPI_COMM_SPLIT_TYPE, Nothing,
          (Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ptr{Cint}, Ref{Cint}),
          comm.val, split_type, key, Info(kwargs...), newcomm, 0)
    MPI.Comm(newcomm[])
end

function Dims_create!(nnodes::Integer, ndims::Integer, dims::MPIBuffertype{T}) where T <: Integer
    ccall(MPI_DIMS_CREATE, Nothing, (Ref{Cint}, Ref{Cint}, Ptr{T}, Ref{Cint}),
          nnodes, ndims, dims, 0)
end

function Dims_create!(nnodes::Integer, dims::AbstractArray{T,N}) where T <: Integer where N
    cdims = Cint.(dims[:])
    ndims = length(cdims)
    Dims_create!(nnodes, ndims, cdims)
    dims[:] .= cdims
end

function Cart_create(comm_old::Comm, ndims::Integer, dims::MPIBuffertype{T}, periods::MPIBuffertype{T}, reorder::Integer) where T <: Integer
    comm_cart = Ref{Cint}()
    ccall(MPI_CART_CREATE, Nothing, 
          (Ref{Cint}, Ref{Cint}, Ptr{T}, Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          comm_old.val, ndims, dims, periods, reorder, comm_cart, 0)
    MPI.Comm(comm_cart[])
end

function Cart_create(comm_old::Comm, dims::AbstractArray{T,N}, periods::Array{T,N}, reorder::Integer) where T <: Integer where N
    cdims    = Cint.(dims[:])
    cperiods = Cint.(periods[:])
    ndims    = length(cdims)
    Cart_create(comm_old, ndims, cdims, cperiods, reorder)
end

function Cart_coords!(comm::Comm, rank::Integer, maxdims::Integer, coords::MPIBuffertype{T}) where T <: Integer
    ccall(MPI_CART_COORDS, Nothing,
          (Ref{Cint}, Ref{Cint}, Ref{Cint}, Ptr{T}, Ref{Cint}),
          comm.val, rank, maxdims, coords, 0)
end

function Cart_coords(comm::Comm, maxdims::Integer)
    ccoords = Vector{Cint}(undef, maxdims)
    rank    = Comm_rank(comm)
    Cart_coords!(comm, rank, maxdims, ccoords)
    Int.(ccoords)
end

function Cart_shift(comm::Comm, direction::Integer, disp::Integer)
    rank_source = Ref{Cint}()
    rank_dest   = Ref{Cint}()
    ccall(MPI_CART_SHIFT, Nothing,
          (Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          comm.val, direction, disp, rank_source, rank_dest, 0)
    Int(rank_source[]), Int(rank_dest[])
end

function Wtick()
    ccall(MPI_WTICK, Cdouble, ())
end

function Wtime()
    ccall(MPI_WTIME, Cdouble, ())
end

#=
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
=#

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

"""
    Send(buf::MPIBuffertype{T}, count::Integer, datatype::Cint, dest::Integer, 
        tag::Integer, comm::Comm) where T

Complete a blocking send of `count` elements of type `datatype` from `buf` to MPI 
rank `dest` of communicator `comm` using the message tag `tag`
"""
function Send(buf::MPIBuffertype{T}, count::Integer, datatype::Cint, dest::Integer,
              tag::Integer, comm::Comm) where T
    ccall(MPI_SEND, Nothing,
          (Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint},
           Ref{Cint}),
          buf, count, datatype, dest, tag, comm.val, 0)
end

"""
    Send(buf::MPIBuffertype{T}, count::Integer, dest::Integer, tag::Integer,
         comm::Comm) where T

Complete a blocking send of `count` elements of `buf` to MPI rank `dest`
of communicator `comm` using with the message tag `tag`
"""
function Send(buf::MPIBuffertype{T}, count::Integer, dest::Integer,
              tag::Integer, comm::Comm) where T
    Send(buf, count, mpitype(T), dest, tag, comm)
end

"""
    Send(buf::Array{T}, dest::Integer, tag::Integer, comm::Comm) where T

Complete a blocking send of `buf` to MPI rank `dest` of communicator `comm`
using with the message tag `tag`
"""
function Send(buf::Array{T}, dest::Integer, tag::Integer, comm::Comm) where T
    Send(buf, length(buf), dest, tag, comm)
end

"""
    Send(buf::SubArray{T}, dest::Integer, tag::Integer, comm::Comm) where T

Complete a blocking send of `SubArray` `buf` to MPI rank `dest` of communicator
`comm` using with the message tag `tag`. Note that the `buf` must be contiguous.
"""
function Send(buf::SubArray{T}, dest::Integer, tag::Integer, comm::Comm) where T
    @assert Base.iscontiguous(buf)
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
    Isend(buf::MPIBuffertype{T}, count::Integer, datatype::Cint, dest::Integer, 
          tag::Integer, comm::Comm) where T

Starts a nonblocking send of `count` elements of type `datatype` from `buf` to 
MPI rank `dest` of communicator `comm` using with the message tag `tag`

Returns the commication `Request` for the nonblocking send.
"""
function Isend(buf::MPIBuffertype{T}, count::Integer, datatype::Cint,
               dest::Integer, tag::Integer, comm::Comm) where T
    rval = Ref{Cint}()
    ccall(MPI_ISEND, Nothing,
          (Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint},
           Ptr{Cint}, Ref{Cint}),
          buf, count, datatype, dest, tag, comm.val, rval, 0)
    return Request(rval[], buf)
end

"""
    Isend(buf::MPIBuffertype{T}, count::Integer, dest::Integer, tag::Integer,
          comm::Comm) where T

Starts a nonblocking send of `count` elements of `buf` to MPI rank `dest`
of communicator `comm` using with the message tag `tag`

Returns the commication `Request` for the nonblocking send.
"""
function Isend(buf::MPIBuffertype{T}, count::Integer,
               dest::Integer, tag::Integer, comm::Comm) where T
    Isend(buf, count, mpitype(T), dest, tag, comm)
end

"""
    Isend(buf::Array{T}, dest::Integer, tag::Integer, comm::Comm) where T

Starts a nonblocking send of `buf` to MPI rank `dest` of communicator `comm`
using with the message tag `tag`

Returns the commication `Request` for the nonblocking send.
"""
function Isend(buf::Array{T}, dest::Integer, tag::Integer, comm::Comm) where T
    Isend(buf, length(buf), dest, tag, comm)
end

"""
    Isend(buf::SubArray{T}, dest::Integer, tag::Integer, comm::Comm) where T

Starts a nonblocking send of `SubArray` `buf` to MPI rank `dest` of communicator
`comm` using with the message tag `tag`. Note that the `buf` must be contiguous.

Returns the commication `Request` for the nonblocking send.
"""
function Isend(buf::SubArray{T}, dest::Integer, tag::Integer,
               comm::Comm) where T
    @assert Base.iscontiguous(buf)
    Isend(buf, length(buf), dest, tag, comm)
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
    Recv!(buf::MPIBuffertype{T}, count::Integer, datatype::Cint, src::Integer, 
          tag::Integer, comm::Comm) where T

Completes a blocking receive of up to `count` elements of type `datatype` into `buf` 
from MPI rank `src` of communicator `comm` using with the message tag `tag`

Returns the `Status` of the receive
"""
function Recv!(buf::MPIBuffertype{T}, count::Integer, datatype::Cint, src::Integer,
               tag::Integer, comm::Comm) where T
    stat = Status()
    ccall(MPI_RECV, Nothing,
          (Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint},
           Ptr{Cint}, Ref{Cint}),
          buf, count, datatype, src, tag, comm.val, stat.val, 0)
    return stat
end

"""
    Recv!(buf::MPIBuffertype{T}, count::Integer, src::Integer, tag::Integer,
          comm::Comm) where T

Completes a blocking receive of up to `count` elements into `buf` from MPI rank
`src` of communicator `comm` using with the message tag `tag`

Returns the `Status` of the receive
"""
function Recv!(buf::MPIBuffertype{T}, count::Integer, src::Integer,
               tag::Integer, comm::Comm) where T
    Recv!(buf, count, mpitype(T), src, tag, comm)
end


"""
    Recv!(buf::Array{T}, src::Integer, tag::Integer, comm::Comm) where T

Completes a blocking receive into `buf` from MPI rank `src` of communicator
`comm` using with the message tag `tag`

Returns the `Status` of the receive
"""
function Recv!(buf::Array{T}, src::Integer, tag::Integer, comm::Comm) where T
    Recv!(buf, length(buf), src, tag, comm)
end

"""
    Recv!(buf::SubArray{T}, src::Integer, tag::Integer, comm::Comm) where T

Completes a blocking receive into `SubArray` `buf` from MPI rank `src` of
communicator `comm` using with the message tag `tag`. Note that `buf` must be
contiguous.

Returns the `Status` of the receive
"""
function Recv!(buf::SubArray{T}, src::Integer, tag::Integer, comm::Comm) where T
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

"""
    Irecv!(buf::MPIBuffertype{T}, count::Integer, datatype::Cint, src::Integer, tag::Integer,
           comm::Comm) where T

Starts a nonblocking receive of up to `count` elements of type `datatype` into `buf` 
from MPI rank `src` of communicator `comm` using with the message tag `tag`

Returns the communication `Request` for the nonblocking receive.
"""
function Irecv!(buf::MPIBuffertype{T}, count::Integer, datatype::Cint,
                    src::Integer, tag::Integer, comm::Comm) where T
    val = Ref{Cint}()
    ccall(MPI_IRECV, Nothing,
          (Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint},
           Ptr{Cint}, Ref{Cint}),
          buf, count, datatype, src, tag, comm.val, val, 0)
    Request(val[], buf)
end

"""
    Irecv!(buf::MPIBuffertype{T}, count::Integer, src::Integer, tag::Integer,
           comm::Comm) where T

Starts a nonblocking receive of up to `count` elements into `buf` 
from MPI rank `src` of communicator `comm` using with the message tag `tag`

Returns the communication `Request` for the nonblocking receive.
"""
function Irecv!(buf::MPIBuffertype{T}, count::Integer,
                    src::Integer, tag::Integer, comm::Comm) where T
    Irecv!(buf, count, mpitype(T), src, tag, comm)
end

"""
    Irecv!(buf::Array{T}, src::Integer, tag::Integer, comm::Comm) where T

Starts a nonblocking receive into `buf` from MPI rank `src` of communicator
`comm` using with the message tag `tag`

Returns the communication `Request` for the nonblocking receive.
"""
function Irecv!(buf::Array{T}, src::Integer, tag::Integer,
                             comm::Comm) where T
    Irecv!(buf, length(buf), src, tag, comm)
end

"""
    Irecv!(buf::SubArray{T}, src::Integer, tag::Integer, comm::Comm) where T

Starts a nonblocking receive into `SubArray` `buf` from MPI rank `src` of
communicator `comm` using with the message tag `tag`. Note that `buf` must be
contiguous.

Returns the communication `Request` for the nonblocking receive.
"""
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

"""
    Wait!(req::Request)

Wait on the request `req` to be complete. Returns the `Status` of the request.
"""
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

"""
    Waitall!(reqs::Array{Request,1})

Wait on all the requests in the array `reqs` to be complete. Returns an arrays
of the all the requests statuses.
"""
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


"""
    Waitany!(reqs::Array{Request,1})

Wait on any the requests in the array `reqs` to be complete. Returns the index
of the completed request and its `Status` as a tuple.
"""
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
"""
    Barrier(comm::Comm)

Blocks until `comm` is synchronized.

If `comm` is an intracommunicator, then it blocks until all members of the group have called it.

If `comm` is an intercommunicator, then it blocks until all members of the other group have called it.
"""
function Barrier(comm::Comm)
    ccall(MPI_BARRIER, Nothing, (Ref{Cint},Ref{Cint}), comm.val, 0)
end

"""
    Bcast!(buf[, count=length(buf)], root, comm::Comm)

Broadcast the first `count` elements of the buffer `buf` from `root` to all processes.
"""
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

"""
    Reduce!(sendbuf, recvbuf[, count=length(sendbuf)], op, root, comm)

Performs `op` reduction on the first `count` elements of the  buffer `sendbuf`
and stores the result in `recvbuf` on the process of rank `root`.

On non-root processes `recvbuf` is ignored.

To perform the reduction in place, see [`Reduce_in_place!`](@ref).

To handle allocation of the output buffer, see [`Reduce`](@ref).
"""
function Reduce!(sendbuf::MPIBuffertype{T}, recvbuf::MPIBuffertype{T},
                 count::Integer, op::Op, root::Integer,
                 comm::Comm) where T
    isroot = Comm_rank(comm) == root
    isroot && @assert length(recvbuf) >= count
    ccall(MPI_REDUCE, Nothing,
          (Ptr{T}, Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint},
           Ref{Cint}, Ref{Cint}),
          sendbuf, recvbuf, count, mpitype(T), op.val, root, comm.val,
          0)
    isroot ? recvbuf : nothing
end

# Convert user-provided functions to MPI.Op
Reduce!(sendbuf::MPIBuffertype{T}, recvbuf::MPIBuffertype{T},
        count::Integer, opfunc::Function, root::Integer,
        comm::Comm) where {T} =
    Reduce!(sendbuf, recvbuf, count, user_op(opfunc), root, comm)

function Reduce!(sendbuf::MPIBuffertype{T}, recvbuf::MPIBuffertype{T},
                 op::Union{Op, Function}, root::Integer, comm::Comm) where T
    Reduce!(sendbuf, recvbuf, length(sendbuf), op, root, comm)
end

"""
    Reduce(sendbuf, count, op, root, comm)

Performs `op` reduction on the buffer `sendbuf` and stores the result in
an output buffer allocated on the process of rank `root`. An empty array
will be returned on all other processes.

To specify the output buffer, see [`Reduce!`](@ref).

To perform the reduction in place, see [`Reduce_in_place!`](@ref).
"""
function Reduce(sendbuf::MPIBuffertype{T}, count::Integer,
                op::Union{Op, Function}, root::Integer, comm::Comm) where T
    isroot = Comm_rank(comm) == root
    recvbuf = Array{T}(undef, isroot ? count : 0)
    Reduce!(sendbuf, recvbuf, count, op, root, comm)
end

function Reduce(sendbuf::Array{T,N}, op::Union{Op,Function},
    root::Integer, comm::Comm) where {T,N}
    isroot = Comm_rank(comm) == root
    recvbuf = Array{T,N}(undef, isroot ? size(sendbuf) : Tuple(zeros(Int, ndims(sendbuf))))
    Reduce!(sendbuf, recvbuf, length(sendbuf), op, root, comm)
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

"""
    Reduce_in_place!(buf, count, op, root, comm)

Performs `op` reduction on the first `count` elements of the buffer `buf` and
stores the result on `buf` of the `root` process in the group.

This is equivalent to calling
```julia
if root == MPI.Comm_rank(comm)
    Reduce!(MPI.IN_PLACE, buf, count, root, comm)
else
    Reduce!(buf, C_NULL, count, root, comm)
end
```

To handle allocation of the output buffer, see [`Reduce`](@ref).

To specify a separate output buffer, see [`Reduce!`](@ref).
"""
function Reduce_in_place!(buf::MPIBuffertype{T}, count::Integer,
                          op::Op, root::Integer,
                          comm::Comm) where T
    if Comm_rank(comm) == root
        @assert length(buf) >= count
        ccall(MPI_REDUCE, Nothing,
              (Ptr{T}, Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint},
               Ref{Cint}, Ref{Cint}),
               MPI.IN_PLACE, buf, count, mpitype(T), op.val, root, comm.val,
               0)
    else
        ccall(MPI_REDUCE, Nothing,
              (Ptr{T}, Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint},
               Ref{Cint}, Ref{Cint}),
               buf, C_NULL, count, mpitype(T), op.val, root, comm.val,
               0)
    end
    buf
end

# Convert to MPI.Op
Reduce_in_place!(buf::MPIBuffertype{T}, count::Integer, op::Function,
                 root::Integer, comm::Comm) where T =
                    Reduce_in_place!(buf, count, user_op(op), root, comm)

"""
    Allreduce!(sendbuf, recvbuf[, count=length(sendbuf)], op, comm)

Performs `op` reduction on the first `count` elements of the buffer
`sendbuf` storing the result in the `recvbuf` of all processes in the
group.

All-reduce is equivalent to a [`Reduce!`](@ref) operation followed by
a [`Bcast!`](@ref), but can lead to better performance.

If `sendbuf==MPI.IN_PLACE` the data is read from `recvbuf` and then overwritten
with the results.

To handle allocation of the output buffer, see [`Allreduce`](@ref).
"""
function Allreduce!(sendbuf::MPIBuffertypeOrConst{T}, recvbuf::MPIBuffertype{T},
                   count::Integer, op::Op, comm::Comm) where T
    @assert length(recvbuf) >= count
    ccall(MPI_ALLREDUCE, Nothing, (Ptr{T}, Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint},
          Ref{Cint}, Ref{Cint}), sendbuf, recvbuf, count, mpitype(T),
          op.val, comm.val, 0)
    recvbuf
end

# Convert user-provided functions to MPI.Op
Allreduce!(sendbuf::MPIBuffertypeOrConst{T}, recvbuf::MPIBuffertype{T},
           count::Integer, opfunc::Function, comm::Comm) where {T} =
    Allreduce!(sendbuf, recvbuf, count, user_op(opfunc), comm)

function Allreduce!(sendbuf::MPIBuffertypeOrConst{T}, recvbuf::MPIBuffertype{T},
                   op::Union{Op,Function}, comm::Comm) where T
    Allreduce!(sendbuf, recvbuf, length(recvbuf), op, comm)
end

"""
    Allreduce!(buf, op, comm)

Performs `op` reduction in place on the buffer `sendbuf`, overwriting it with
the results on all the processes in the group.

Equivalent to calling `Allreduce!(MPI.IN_PLACE, buf, op, comm)`
"""
function Allreduce!(buf::MPIBuffertype{T}, op::Union{Op, Function}, comm::Comm) where T
    Allreduce!(MPI.IN_PLACE, buf, length(buf), op, comm)
end

"""
    Allreduce(sendbuf, op, comm)

Performs `op` reduction on the buffer `sendbuf`, allocating and returning the
output buffer in all processes of the group.

To specify the output buffer or perform the operation in pace, see [`Allreduce!`](@ref).
"""
function Allreduce(sendbuf::MPIBuffertype{T}, op::Union{Op,Function}, comm::Comm) where T

  recvbuf = similar(sendbuf)
  Allreduce!(sendbuf, recvbuf, length(recvbuf), op, comm)
end

function Allreduce(sendbuf::Array{T, N}, op::Union{Op, Function}, comm::Comm) where {T, N}
    recvbuf = Array{T,N}(undef, size(sendbuf))
    Allreduce!(sendbuf, recvbuf, length(sendbuf), op, comm)
end

function Allreduce(obj::T, op::Union{Op,Function}, comm::Comm) where T
    objref = Ref(obj)
    outref = Ref{T}()
    Allreduce!(objref, outref, 1, op, comm)

    outref[]
end

# Deprecation warning for lowercase allreduce that was used until v. 0.7.2
# Should be removed at some point in the future
function allreduce(sendbuf::MPIBuffertype{T}, op::Union{Op,Function},
                   comm::Comm) where T
    @warn "`allreduce` is deprecated, use `Allreduce` instead."
    Allreduce(sendbuf, op, comm)
end

include("mpi-op.jl")

"""
    Scatter!(sendbuf, recvbuf, count, root, comm)

Splits the buffer `sendbuf` in the `root` process into `Comm_size(comm)` chunks
and sends the j-th chunk to the process of rank j into the `recvbuf` buffer,
which must be of length at least `count`.

`count` should be the same for all processes. If the number of elements varies between
processes, use [`Scatter!`](@ref) instead.

To perform the reduction in place, see [`Scatter_in_place!`](@ref).

To handle allocation of the output buffer, see [`Scatter`](@ref).
"""
function Scatter!(sendbuf::MPIBuffertype{T}, recvbuf::MPIBuffertype{T},
                  count::Integer, root::Integer,
                  comm::Comm) where T
    @assert length(recvbuf) >= count
    isroot = Comm_rank(comm) == root
    isroot && @assert length(sendbuf) >= count*Comm_size(comm)
    ccall(MPI_SCATTER, Nothing,
          (Ptr{T}, Ref{Cint}, Ref{Cint}, Ptr{T}, Ref{Cint}, Ref{Cint},
           Ref{Cint}, Ref{Cint}, Ref{Cint}), sendbuf, count, mpitype(T),
           recvbuf, count, mpitype(T), root, comm.val, 0)
    recvbuf
end

"""
    Scatter_in_place!(buf, count, root, comm)

Splits the buffer `buf` in the `root` process into `Comm_size(comm)` chunks
and sends the j-th chunk to the process of rank j. No data is sent to the `root`
process.

This is functionally equivalent to calling
```
if root == MPI.Comm_rank(comm)
    Scatter!(buf, MPI.IN_PLACE, count, root, comm)
else
    Scatter!(C_NULL, buf, count, root, comm)
end
```

To specify a separate output buffer, see [`Scatter!`](@ref).

To handle allocation of the output buffer, see [`Scatter`](@ref).
"""
function Scatter_in_place!(buf::MPIBuffertype{T},
                  count::Integer, root::Integer,
                  comm::Comm) where T
    if Comm_rank(comm) == root
        ccall(MPI_SCATTER, Nothing,
              (Ptr{T}, Ref{Cint}, Ref{Cint}, Ptr{Cvoid}, Ref{Cint}, Ref{Cint},
               Ref{Cint}, Ref{Cint}, Ref{Cint}), buf, count, mpitype(T),
               MPI.IN_PLACE, count, mpitype(T), root, comm.val, 0)
    else
        ccall(MPI_SCATTER, Nothing,
            (Ptr{Cvoid}, Ref{Cint}, Ref{Cint}, Ptr{T}, Ref{Cint}, Ref{Cint},
            Ref{Cint}, Ref{Cint}, Ref{Cint}), C_NULL, count, mpitype(T),
            buf, count, mpitype(T), root, comm.val, 0)
    end
    buf
end

"""
    Scatter(sendbuf, count, root, comm)

Splits the buffer `sendbuf` in the `root` process into `Comm_size(comm)` chunks
and sends the j-th chunk to the process of rank j, allocating the output buffer.
"""
function Scatter(sendbuf::MPIBuffertype{T}, count::Integer, root::Integer,
                 comm::Comm) where T
    recvbuf = Array{T}(undef, count)
    Scatter!(sendbuf, recvbuf, count, root, comm)
end

"""
    Scatterv!(sendbuf, recvbuf, counts, root, comm)

Splits the buffer `sendbuf` in the `root` process into `Comm_size(comm)` chunks
of length `counts[j]` and sends the j-th chunk to the process of rank j into the
`recvbuf` buffer, which must be of length at least `count`.

To perform the reduction in place refer to [`Scatterv_in_place!`](@ref).
"""
function Scatterv!(sendbuf::MPIBuffertype{T}, recvbuf::MPIBuffertype{T},
                  counts::Vector{Cint}, root::Integer, comm::Comm) where T
    recvcnt = counts[Comm_rank(comm) + 1]
    disps = accumulate(+, counts) - counts
    @assert length(recvbuf) >= recvcnt
    ccall(MPI_SCATTERV, Nothing,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ref{Cint}, Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          sendbuf, counts, disps, mpitype(T), recvbuf, recvcnt, mpitype(T), root, comm.val, 0)
    recvbuf
end

"""
    Scatterv(sendbuf, counts, root, comm)

Splits the buffer `sendbuf` in the `root` process into `Comm_size(comm)` chunks
of length `counts[j]` and sends the j-th chunk to the process of rank j, which
allocates the output buffer
"""
function Scatterv(sendbuf::MPIBuffertype{T}, counts::Vector{Cint},
                   root::Integer, comm::Comm) where T
    recvbuf = Array{T}(undef, counts[Comm_rank(comm) + 1])
    Scatterv!(sendbuf, recvbuf, counts, root, comm)
end

"""
    Scatterv_in_place(buf, counts, root, comm)

Splits the buffer `buf` in the `root` process into `Comm_size(comm)` chunks
of length `counts[j]` and sends the j-th chunk to the process of rank j into the
`buf` buffer, which must be of length at least `count`. The `root` process sends
nothing to itself.

This is functionally equivalent to calling
```
if root == MPI.Comm_rank(comm)
    Scatterv!(buf, MPI.IN_PLACE, counts, root, comm)
else
    Scatterv!(C_NULL, buf, counts, root, comm)
end
```
"""
function Scatterv_in_place!(buf::MPIBuffertype{T}, counts::Vector{Cint},
                           root::Integer, comm::Comm) where T
    recvcnt = counts[Comm_rank(comm) + 1]
    disps = accumulate(+, counts) - counts
    @assert length(buf) >= recvcnt

    if Comm_rank(comm) == root
        ccall(MPI_SCATTERV, Nothing,
              (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ref{Cint}, Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
              buf, counts, disps, mpitype(T), IN_PLACE, recvcnt, mpitype(T), root, comm.val, 0)

    else
        ccall(MPI_SCATTERV, Nothing,
              (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ref{Cint}, Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
              C_NULL, counts, disps, mpitype(T), buf, recvcnt, mpitype(T), root, comm.val, 0)
    end
    buf
end

"""
    Gather!(sendbuf, recvbuf, count, root, comm)

Each process sends the first `count` elements of the buffer `sendbuf` to the
`root` process. The `root` process stores elements in rank order in the buffer
buffer `recvbuf`.

`count` should be the same for all processes. If the number of elements varies between
processes, use [`Gatherv!`](@ref) instead.

To perform the reduction in place refer to [`Gather_in_place!`](@ref).
"""
function Gather!(sendbuf::MPIBuffertype{T}, recvbuf::MPIBuffertype{T},
                count::Integer, root::Integer, comm::Comm) where T
    @assert length(sendbuf) >= count
    isroot = Comm_rank(comm) == root
    isroot && @assert length(recvbuf) >= count*Comm_size(comm)
    ccall(MPI_GATHER, Nothing,
          (Ptr{T}, Ref{Cint}, Ref{Cint}, Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          sendbuf, count, mpitype(T), recvbuf, count, mpitype(T), root, comm.val, 0)
    isroot ? recvbuf : nothing
end

"""
    Gather(sendbuf[, count=length(sendbuf)], root, comm)

Each process sends the first `count` elements of the buffer `sendbuf` to the
`root` process. The `root` allocates the output buffer and stores elements in
rank order.
"""
function Gather(sendbuf::MPIBuffertype{T}, count::Integer,
                root::Integer, comm::Comm) where T
    isroot = Comm_rank(comm) == root
    recvbuf = Array{T}(undef, isroot ? Comm_size(comm) * count : 0)
    Gather!(sendbuf, recvbuf, count, root, comm)
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

"""
    Gather_in_place!(buf, count, root, comm)

Each process sends the first `count` elements of the buffer `buf` to the
`root` process. The `root` process stores elements in rank order in the buffer
buffer `buf`, sending no data to itself.

This is functionally equivalent to calling
```
if root == MPI.Comm_rank(comm)
    Gather!(MPI.IN_PLACE, buf, count, root, comm)
else
    Gather!(buf, C_NULL, count, root, comm)
end
```
"""
function Gather_in_place!(buf::MPIBuffertype{T}, count::Integer, root::Integer,
                          comm::Comm) where T
    if Comm_rank(comm) == root
        @assert length(buf) >= count*Comm_size(comm)
        ccall(MPI_GATHER, Nothing,
              (Ptr{T}, Ref{Cint}, Ref{Cint}, Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
              IN_PLACE, count, mpitype(T), buf, count, mpitype(T), root, comm.val, 0)
    else
        ccall(MPI_GATHER, Nothing,
              (Ptr{T}, Ref{Cint}, Ref{Cint}, Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
              buf, count, mpitype(T), C_NULL, count, mpitype(T), root, comm.val, 0)
    end
    buf
end

"""
    Allgather!(sendbuf, recvbuf, count, comm)

Each process sends the first `count` elements of `sendbuf` to the
other processes, who store the results in rank order into
`recvbuf`.

If `sendbuf==MPI.IN_PLACE` the input data is assumed to be in the
area of `recvbuf` where the process would receive it's own
contribution.
"""
function Allgather!(sendbuf::MPIBuffertypeOrConst{T}, recvbuf::MPIBuffertype{T},
                    count::Integer, comm::Comm) where T
    @assert length(recvbuf) >= Comm_size(comm)*count
    ccall(MPI_ALLGATHER, Nothing,
          (Ptr{T}, Ref{Cint}, Ref{Cint}, Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          sendbuf, count, mpitype(T), recvbuf, count, mpitype(T), comm.val, 0)
    recvbuf
end

"""
    Allgather!(buf, count, comm)

Equivalent to `Allgather!(MPI.IN_PLACE, buf, count, comm)`.
"""
function Allgather!(buf::MPIBuffertype{T}, count::Integer,
                   comm::Comm) where T
    Allgather!(MPI.IN_PLACE, buf, count, comm)
end

"""
    Allgather(sendbuf, count, comm)

Each process sends the first `count` elements of `sendbuf` to the
other processes, who store the results in rank order allocating
the output buffer.
"""
function Allgather(sendbuf::MPIBuffertype{T}, count::Integer,
                   comm::Comm) where T
    recvbuf = Array{T}(undef, Comm_size(comm) * count)
    Allgather!(sendbuf, recvbuf, count, comm)
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

"""
    Gatherv!(sendbuf, recvbuf, counts, root, comm)

Each process sends the first `counts[rank]` elements of the buffer `sendbuf` to
the `root` process. The `root` stores elements in rank order in the buffer
`recvbuf`.

To perform the reduction in place refer to [`Gatherv_in_place!`](@ref).
"""
function Gatherv!(sendbuf::MPIBuffertype{T}, recvbuf::MPIBuffertype{T},
                  counts::Vector{Cint}, root::Integer, comm::Comm) where T
    isroot = Comm_rank(comm) == root
    displs = accumulate(+, counts) - counts
    sendcnt = counts[Comm_rank(comm) + 1]
    isroot && @assert length(recvbuf) >= sum(counts)
    ccall(MPI_GATHERV, Nothing,
          (Ptr{T}, Ref{Cint}, Ref{Cint}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          sendbuf, sendcnt, mpitype(T), recvbuf, counts, displs, mpitype(T), root, comm.val, 0)
    isroot ? recvbuf : nothing
end

"""
    Gatherv(sendbuf, counts, root, comm)

Each process sends the first `counts[rank]` elements of the buffer `sendbuf` to
the `root` process. The `root` allocates the output buffer and stores elements
in rank order.
"""
function Gatherv(sendbuf::MPIBuffertype{T}, counts::Vector{Cint},
                 root::Integer, comm::Comm) where T
    isroot = Comm_rank(comm) == root
    recvbuf = Array{T}(undef, isroot ? sum(counts) : 0)
    Gatherv!(sendbuf, recvbuf, counts, root, comm)
end

"""
    Gatherv_in_place!(buf, counts, root, comm)

Each process sends the first `counts[rank]` elements of the buffer `buf` to
the `root` process. The `root` allocates the output buffer and stores elements
in rank order.

This is functionally equivalent to calling
```
if root == MPI.Comm_rank(comm)
    Gatherv!(MPI.IN_PLACE, buf, counts, root, comm)
else
    Gatherv!(buf, C_NULL, counts, root, comm)
end
```
"""
function Gatherv_in_place!(buf::MPIBuffertype{T}, counts::Vector{Cint},
                           root::Integer, comm::Comm) where T
    isroot = Comm_rank(comm) == root
    displs = accumulate(+, counts) - counts
    sendcnt = counts[Comm_rank(comm) + 1]

    if isroot
        @assert length(buf) >= sum(counts)
        ccall(MPI_GATHERV, Nothing,
              (Ptr{T}, Ref{Cint}, Ref{Cint}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
              IN_PLACE, sendcnt, mpitype(T), buf, counts, displs, mpitype(T), root, comm.val, 0)
    else
        ccall(MPI_GATHERV, Nothing,
              (Ptr{T}, Ref{Cint}, Ref{Cint}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
              buf, sendcnt, mpitype(T), C_NULL, counts, displs, mpitype(T), root, comm.val, 0)
    end
    buf
end


"""
    Allgatherv!(sendbuf, recvbuf, counts, comm)

Each process sends the first `counts[rank]` elements of the buffer `sendbuf` to
all other process. Each process stores the received data in rank order in the
buffer `recvbuf`.

if `sendbuf==MPI.IN_PLACE` every process takes the data to be sent is taken from
the interval of `recvbuf` where it would store it's own data.
"""
function Allgatherv!(sendbuf::MPIBuffertypeOrConst{T}, recvbuf::MPIBuffertype{T},
	                     counts::Vector{Cint}, comm::Comm) where T
        @assert length(recvbuf) >= sum(counts)
        displs = accumulate(+, counts) - counts
        sendcnt = counts[Comm_rank(comm) + 1]
        ccall(MPI_ALLGATHERV, Nothing,
              (Ptr{T}, Ref{Cint}, Ref{Cint}, Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
              sendbuf, sendcnt, mpitype(T), recvbuf, counts, displs, mpitype(T), comm.val, 0)
        recvbuf
end

"""
    Allgatherv(sendbuf, counts, comm)

Each process sends the first `counts[rank]` elements of the buffer `sendbuf` to
all other process. Each process allocates an output buffer and stores the
received data in rank order.
"""
function Allgatherv(sendbuf::MPIBuffertype{T}, counts::Vector{Cint},
                    comm::Comm) where T
    recvbuf = Array{T}(undef, sum(counts))
    Allgatherv!(sendbuf, recvbuf, counts, comm)
end

"""
    Alltoall!(sendbuf, recvbuf, count, comm)

Every process divides the buffer `sendbuf` into `Comm_size(comm)` chunks of
length `count`, sending the `j`-th chunk to the `j`-th process.
Every process stores the data received from the `j`-th process in the `j`-th
chunk of the buffer `recvbuf`.

```
rank    send buf                        recv buf
----    --------                        --------
 0      a,b,c,d,e,f       Alltoall      a,b,A,B,α,β
 1      A,B,C,D,E,F  ---------------->  c,d,C,D,γ,ψ
 2      α,β,γ,ψ,η,ν                     e,f,E,F,η,ν
```

If `sendbuf==MPI.IN_PLACE`, data is sent from the `recvbuf` and then
overwritten.
"""
function Alltoall!(sendbuf::MPIBuffertypeOrConst{T}, recvbuf::MPIBuffertype{T},
                   count::Integer, comm::Comm) where T
    ccall(MPI_ALLTOALL, Nothing,
          (Ptr{T}, Ref{Cint}, Ref{Cint}, Ptr{T}, Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          sendbuf, count, mpitype(T), recvbuf, count, mpitype(T), comm.val, 0)
    recvbuf
end

"""
    Alltoall(sendbuf, count, comm)

Every process divides the buffer `sendbuf` into `Comm_size(comm)` chunks of
length `count`, sending the `j`-th chunk to the `j`-th process.
Every process allocates the output buffer and stores the data received from the
`j`-th process in the `j`-th chunk.

```
rank    send buf                        recv buf
----    --------                        --------
 0      a,b,c,d,e,f       Alltoall      a,b,A,B,α,β
 1      A,B,C,D,E,F  ---------------->  c,d,C,D,γ,ψ
 2      α,β,γ,ψ,η,ν                     e,f,E,F,η,ν
```
"""
function Alltoall(sendbuf::MPIBuffertype{T}, count::Integer,
                  comm::Comm) where T
    recvbuf = Array{T}(undef, Comm_size(comm)*count)
    Alltoall!(sendbuf, recvbuf, count, comm)
end

"""
    Alltoallv!(sendbuf::T, recvbuf::T, scounts, rcounts, comm)

`MPI.IN_PLACE` is not supported for this operation.
"""
function Alltoallv!(sendbuf::MPIBuffertype{T}, recvbuf::MPIBuffertype{T},
                   scounts::Vector{Cint}, rcounts::Vector{Cint},
                   comm::Comm) where T
    @assert length(recvbuf) == sum(rcounts)

    sdispls = accumulate(+, scounts) - scounts
    rdispls = accumulate(+, rcounts) - rcounts
    ccall(MPI_ALLTOALLV, Nothing,
          (Ptr{T}, Ptr{Cint}, Ptr{Cint}, Ref{Cint}, Ptr{T}, Ptr{Cint},
           Ptr{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}),
          sendbuf, scounts, sdispls, mpitype(T), recvbuf, rcounts,
          rdispls, mpitype(T), comm.val, 0)
    recvbuf
end

function Alltoallv(sendbuf::MPIBuffertype{T}, scounts::Vector{Cint},
                   rcounts::Vector{Cint}, comm::Comm) where T
    recvbuf = Array{T}(undef, sum(rcounts))
    Alltoallv!(sendbuf, recvbuf, scounts, rcounts, comm)
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
                    comm::Comm, errors = Vector{Cint}(undef, nprocs); kwargs...)
    c_intercomm = Ref{CComm}()
    ccall((:MPI_Comm_spawn, libmpi), Nothing,
         (Cstring, Ptr{Ptr{Cchar}}, Cint, CInfo, Cint, CComm, Ref{CComm}, Ptr{Cint}),
         command, argv, nprocs, Info(kwargs...), 0, CComm(comm), c_intercomm, errors)
    return Comm(c_intercomm[])
end

function Intercomm_merge(intercomm::Comm, flag::Bool)
    comm_id = Ref{Cint}()
    ccall(MPI_INTERCOMM_MERGE, Nothing, (Ref{Cint}, Ref{Cint}, Ref{Cint}, Ref{Cint}), intercomm.val, Cint(flag), comm_id, 0)
    return Comm(comm_id[])
end

function Type_Create_Struct(nfields::Integer, blocklengths::MPIBuffertype{Cint},
                            displacements::MPIBuffertype{Cptrdiff_t},
                            types::MPIBuffertype{Cint})

  newtype_ref = Ref{Cint}()
  flag = Ref{Cint}()
  ccall(MPI_TYPE_CREATE_STRUCT, Nothing, (Ref{Cint}, Ptr{Cint}, Ptr{Cptrdiff_t},
        Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), nfields, blocklengths,
        displacements, types, newtype_ref, flag)

  if flag[] != 0
    throw(ErrorException("MPI_Type_create_struct returned non-zero exit status: $(flag[])"))
  end

  return newtype_ref[]
end

"""
    Type_Create_Subarray(ndims::Integer, array_of_sizes::MPIBuffertype{Cint},
                         array_of_subsizes::MPIBuffertype{Cint},
                         array_of_starts::MPIBuffertype{Cint}, order::Integer, oldtype)

Creates a data type describing an `ndims`-dimensional subarray of size `array_of_subsizes`
of an `ndims-dimensional` array of size `array_of_sizes` and element type `oldtype`,
starting at the top-left location `array_of_starts`. The parameter `order` refers to
the memory layout of the parent array, and can be either `MPI_ORDER_C` or
`MPI_ORDER_FORTRAN`. Note that, like other MPI data types, the type returned by this
function should be committed with `MPI_Type_commit`.
"""
function Type_Create_Subarray(ndims::Integer,
                              array_of_sizes::MPIBuffertype{Cint},
                              array_of_subsizes::MPIBuffertype{Cint},
                              array_of_starts::MPIBuffertype{Cint},
                              order::Integer,
                              oldtype)

    newtype_ref = Ref{Cint}()
    flag = Ref{Cint}()

    ccall(MPI_TYPE_CREATE_SUBARRAY, Nothing,
        (Ref{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
         Ref{Cint}, Ref{Cint}, Ptr{Cint}, Ptr{Cint}),
        ndims, array_of_sizes, array_of_subsizes, array_of_starts,
        order, mpitype(oldtype), newtype_ref, flag)

    if flag[] != 0
        throw(ErrorException("MPI_Type_create_subarray returned non-zero exit status"))
    end

    return newtype_ref[]
end

function Type_Contiguous(count::Integer, oldtype)
  newtype_ref = Ref{Cint}()
  flag = Ref{Cint}()
  ccall(MPI_TYPE_CONTIGUOUS, Nothing, (Ref{Cint}, Ref{Cint}, Ptr{Cint}, Ptr{Cint}), count, oldtype, newtype_ref, flag)

  if flag[] != 0
    throw(ErrorException("MPI_Type_contiguous returned non-zero exit status: $(flag[])"))
  end

  return newtype_ref[]
end

function Type_Commit(newtype::Cint)

  flag = Ref{Cint}()
  ccall(MPI_TYPE_COMMIT, Nothing, (Ptr{Cint}, Ptr{Cint}), Ref(newtype), flag)

  if flag[] != 0
    throw(ErrorException("MPI_Type_commit returned non-zero exit status: $(flag[])"))
  end

  return nothing
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
elseif sizeof(CComm) == sizeof(Cint)
    # in MPICH, both C and Fortran use identical Cint comm handles
    # and MPI_Comm_c2f is not provided.
    function CComm(comm::Comm)
      reinterpret(CComm, comm.val)
    end
    function Comm(ccomm::CComm)
      Comm(reinterpret(Cint, ccomm))
    end
else
    @warn("No MPI_Comm_c2f found - conversion to/from MPI.CComm will not work")
end
