const MPIInteger = Union{Int8, UInt8, Int16, UInt16, Int32, UInt32, Int64, UInt64}
const MPIFloatingPoint = Union{Float32, Float64}
const MPIComplex = Union{ComplexF32, ComplexF64}

const MPIDatatype = Union{Char,
                            Int8, UInt8, Int16, UInt16, Int32, UInt32, Int64,
                            UInt64,
                            Float32, Float64, ComplexF32, ComplexF64}
MPIBuffertype{T} = Union{Ptr{T}, Array{T}, SubArray{T}, Ref{T}}

MPIBuffertypeOrConst{T} = Union{MPIBuffertype{T}, SentinelPtr}

Base.cconvert(::Type{MPIPtr}, x::Union{Ptr{T}, Array{T}, Ref{T}}) where T = Base.cconvert(Ptr{T}, x)
Base.cconvert(::Type{MPIPtr}, x::SubArray{T}) where T = Base.cconvert(Ptr{T}, x)
function Base.unsafe_convert(::Type{MPIPtr}, x::MPIBuffertype{T}) where T
    ptr = Base.unsafe_convert(Ptr{T}, x)
    reinterpret(MPIPtr, ptr)
end


Base.cconvert(::Type{MPIPtr}, x::String) = x
Base.unsafe_convert(::Type{MPIPtr}, x::String) = reinterpret(MPIPtr, pointer(x))

Base.cconvert(::Type{MPIPtr}, ::Nothing) = reinterpret(MPIPtr, C_NULL)

macro assert_minlength(buffer, count)
    quote
        if $(esc(buffer)) isa AbstractArray
            @assert length($(esc(buffer))) >= $(esc(count))
        end
    end
end

"""
    MPI.MPIPtr

A pointer to an MPI buffer. This type is used only as part of the implicit conversion in
`ccall`: a Julia object can be passed to MPI by defining methods for
`Base.cconvert(::Type{MPIPtr}, ...)`/`Base.unsafe_convert(::Type{MPIPtr}, ...)`.

Currently supported are:
 - `Ptr`
 - `Ref`
 - `Array`
 - `SubArray`
 - `CUDA.CuArray` if CUDA.jl is loaded.
 - `AMDGPU.ROCArray` if AMDGPU.jl is loaded.

Additionally, certain sentinel values can be used, e.g. `MPI_IN_PLACE` or `MPI_BOTTOM`.
"""
MPIPtr

# MPI_IN_PLACE

struct InPlace
end
Base.cconvert(::Type{MPIPtr}, ::InPlace) = Consts.MPI_IN_PLACE[]


"""
    MPI.IN_PLACE

A sentinel value that can be passed as a buffer argument for certain collective operations
to use the same buffer for send and receive operations.

- [`Scatter!`](@ref) and [`Scatterv!`](@ref): can be used as the `recvbuf` argument on the
  root process.

- [`Gather!`](@ref) and [`Gatherv!`](@ref): can be used as the `sendbuf` argument on the
  root process.

- [`Allgather!`](@ref), [`Allgatherv!`](@ref), [`Alltoall!`](@ref) and
  [`Alltoallv!`](@ref): can be used as the `sendbuf` argument on all processes.

- [`Reduce!`](@ref) (root only), [`Allreduce!`](@ref), [`Scan!`](@ref) and
  [`Exscan!`](@ref): can be used as `sendbuf` argument.

"""
const IN_PLACE = InPlace()

# TODO: MPI_BOTTOM


"""
    MPI.Buffer

An MPI buffer for communication with a single rank. It is used for point-to-point
and one-sided operations, as well as some collective operations. Operations will implicitly construct a `Buffer` when required via the generic constructor, but it can be advantageous to manually construct `Buffer`s when doing so incurs additional overhead, for example when using a non-predefined [`MPI.Datatype`](@ref).

# Fields
$(DocStringExtensions.FIELDS)

# Usage

    Buffer(data, count::Integer, datatype::Datatype)

Generic constructor.

    Buffer(data)

Construct a `Buffer` backed by `data`, automatically determining the appropriate `count`
and `datatype`. Methods are provided for

 - `Ref`
 - `Array`
 - `CUDA.CuArray` if CUDA.jl is loaded.
 - `AMDGPU.ROCArray` if AMDGPU.jl is loaded.
 - `SubArray`s of an `Array`, `CUDA.CuArray` or `AMDGPU.ROCArray` where the layout is contiguous, sequential or
   blocked.

# See also

- [`Buffer_send`](@ref)

"""
struct Buffer{A}
    """a Julia object referencing a region of memory to be used for communication. It is
    required that the object can be `cconvert`ed to an [`MPIPtr`](@ref)."""
    data::A

    """the number of elements of `datatype` in the buffer. Note that this may not
    correspond to the number of elements in the array if derived types are used."""
    count::Cint

    """the [`MPI.Datatype`](@ref) stored in the buffer."""
    datatype::Datatype
end
Buffer(buf::Buffer) = buf
Buffer(data, count::Integer, datatype::Datatype) = Buffer(data, Cint(count), datatype)

function Buffer(arr::Array)
    Buffer(arr, Cint(length(arr)), Datatype(eltype(arr)))
end
function Buffer(ref::Ref)
    Buffer(ref, Cint(1), Datatype(eltype(ref)))
end

# SubArray
function Buffer(sub::Base.FastContiguousSubArray)
    Buffer(sub, Cint(length(sub)), Datatype(eltype(sub)))
end
function Buffer(sub::Base.FastSubArray)
    datatype = Types.create_vector(length(sub), 1, sub.stride1,
                                   Datatype(eltype(sub)))
    Types.commit!(datatype)
    Buffer(sub, Cint(1), datatype)
end
function Buffer(sub::SubArray{T,N,P,I,false}) where {T,N,P,I<:Tuple{Vararg{Union{Base.ScalarIndex, Base.Slice, AbstractUnitRange}}}}
    datatype = Types.create_subarray(size(parent(sub)),
                                     map(length, sub.indices),
                                     map(i -> first(i)-1, sub.indices),
                                     Datatype(eltype(sub)))
    Types.commit!(datatype)
    Buffer(parent(sub), Cint(1), datatype)
end

# NTuple: avoid creating a new datatype if possible
function Buffer(data::Ref{NTuple{N,T}}) where {N,T}
    Buffer(data, Cint(N), Datatype(T))
end


Buffer(::InPlace) = Buffer(IN_PLACE, 0, DATATYPE_NULL)
Buffer(::Nothing) = Buffer(nothing, 0, DATATYPE_NULL)


"""
    Buffer_send(data)

Construct a [`Buffer`](@ref) object for a send operation from `data`, allowing cases where
`isbits(data)`.
"""
Buffer_send(data) = isbits(data) ? Buffer(Ref(data)) : Buffer(data)
Buffer_send(str::String) = Buffer(str, sizeof(str), MPI.CHAR)
Buffer_send(::InPlace) = Buffer(InPlace())
Buffer_send(::Nothing) = Buffer(nothing)






"""
    MPI.UBuffer

An MPI buffer for chunked collective communication, where all chunks are of uniform size.

# Fields
$(DocStringExtensions.FIELDS)

# Usage

    UBuffer(data, count::Integer, nchunks::Union{Nothing, Integer}, datatype::Datatype)

Generic constructor.

    UBuffer(data, count::Integer)

Construct a `UBuffer` backed by `data`, where `count` is the number of elements in each chunk.

# See also

- [`VBuffer`](@ref): similar, but supports chunks of non-uniform sizes.
"""
struct UBuffer{A}
    """A Julia object referencing a region of memory to be used for communication. It is
    required that the object can be `cconvert`ed to an [`MPIPtr`](@ref)."""
    data::A

    """The number of elements of `datatype` in each chunk."""
    count::Cint

    """The maximum number of chunks stored in the buffer. This is used only for
    validation, and can be set to `nothing` to disable checks."""
    nchunks::Union{Nothing,Cint}

    """The [`MPI.Datatype`](@ref) stored in the buffer."""
    datatype::Datatype
end
UBuffer(data, count::Integer, nchunks::Union{Integer, Nothing}, datatype::Datatype) =
    UBuffer(data, Cint(count), nchunks isa Integer ? Cint(nchunks) : nothing, datatype)

function UBuffer(arr::AbstractArray, count::Integer)
    @assert stride(arr, 1) == 1
    UBuffer(arr, count, div(length(arr), count), Datatype(eltype(arr)))
end
Base.similar(buf::UBuffer) =
    UBuffer(similar(buf.data), buf.count, buf.nchunks, buf.datatype)

UBuffer(::Nothing) = UBuffer(nothing, 0, nothing, DATATYPE_NULL)
UBuffer(::InPlace) = UBuffer(IN_PLACE, 0, nothing, DATATYPE_NULL)



"""
    MPI.VBuffer

An MPI buffer for chunked collective communication, where chunks can be of different sizes and at different offsets.


# Fields
$(DocStringExtensions.FIELDS)

# Usage

    VBuffer(data, counts[, displs[, datatype]])

Construct a `VBuffer` backed by `data`, where `counts[j]` is the number of elements in the
`j`th chunk, and `displs[j]` is the 0-based displacement. In other words, the `j`th chunk
occurs in indices `displs[j]+1:displs[j]+counts[j]`.

The default value for `displs[j] = sum(counts[1:j-1])`.

# See also

- [`UBuffer`](@ref) when chunks are all of the same size.
"""
struct VBuffer{A}
    """A Julia object referencing a region of memory to be used for communication. It is
    required that the object can be `cconvert`ed to an [`MPIPtr`](@ref)."""
    data::A

    """An array containing the length of each chunk."""
    counts::Vector{Cint}

    """An array containing the (0-based) displacements of each chunk."""
    displs::Vector{Cint}

    """The [`MPI.Datatype`](@ref) stored in the buffer."""
    datatype::Datatype
end
VBuffer(data, counts, displs, datatype::Datatype) =
    VBuffer(data, convert(Vector{Cint}, counts),
                 convert(Vector{Cint}, displs), datatype)
VBuffer(data, counts, displs) =
    VBuffer(data, counts, displs, Datatype(eltype(data)))

function VBuffer(arr::AbstractArray, counts)
    @assert stride(arr,1) == 1
    counts = convert(Vector{Cint}, counts)
    displs = similar(counts)
    d = zero(Cint)
    for i in eachindex(displs)
        displs[i] = d
        d += counts[i]
    end
    @assert length(arr) >= d
    VBuffer(arr, counts, displs, Datatype(eltype(arr)))
end

VBuffer(::Nothing) = VBuffer(nothing, Cint[], Cint[], DATATYPE_NULL)
VBuffer(::InPlace) = VBuffer(IN_PLACE, Cint[], Cint[], DATATYPE_NULL)


"""
    MPI.RBuffer

An MPI buffer for reduction operations ([`MPI.Reduce!`](@ref), [`MPI.Allreduce!`](@ref), [`MPI.Scan!`](@ref), [`MPI.Exscan!`](@ref)).

# Fields
$(DocStringExtensions.FIELDS)

# Usage

    RBuffer(senddata, recvdata[, count, datatype])

Generic constructor.

    RBuffer(senddata, recvdata)

Construct a `Buffer` backed by `senddata` and `recvdata`, automatically determining the
appropriate `count` and `datatype`.

- `senddata` can be [`MPI.IN_PLACE`](@ref)
- `recvdata` can be `nothing` on a non-root node with [`MPI.Reduce!`](@ref)
"""
struct RBuffer{S,R}
    """A Julia object referencing a region of memory to be used for the send buffer. It is
    required that the object can be `cconvert`ed to an [`MPIPtr`](@ref)."""
    senddata::S

    """A Julia object referencing a region of memory to be used for the receive buffer. It is
    required that the object can be `cconvert`ed to an [`MPIPtr`](@ref)."""
    recvdata::R

    """the number of elements of `datatype` in the buffer. Note that this may not
    correspond to the number of elements in the array if derived types are used."""
    count::Cint

    """the [`MPI.Datatype`](@ref) stored in the buffer."""
    datatype::Datatype
end

RBuffer(senddata, recvdata, count::Integer, datatype::Datatype) =
    RBuffer(senddata, recvdata, Cint(count), datatype)

function RBuffer(senddata::AbstractArray{T}, recvdata::AbstractArray{T}) where {T}
    count = length(senddata)
    @assert length(recvdata) == count
    @assert stride(senddata,1) == stride(recvdata,1) == 1
    RBuffer(senddata, recvdata, count, Datatype(T))
end
function RBuffer(::InPlace, recvdata::AbstractArray{T}) where {T}
    count = length(recvdata)
    @assert stride(recvdata,1) == 1
    RBuffer(IN_PLACE, recvdata, count, Datatype(T))
end
function RBuffer(senddata::AbstractArray{T}, recvdata::Nothing) where {T}
    count = length(senddata)
    @assert stride(senddata,1) == 1
    RBuffer(senddata, nothing, count, Datatype(T))
end

function RBuffer(senddata::Ref{T}, recvdata::Ref{T}) where {T}
    RBuffer(senddata, recvdata, 1, Datatype(T))
end
function RBuffer(senddata::InPlace, recvdata::Ref{T}) where {T}
    RBuffer(IN_PLACE, recvdata, 1, Datatype(T))
end
function RBuffer(senddata::Ref{T}, recvdata::Nothing) where {T}
    RBuffer(senddata, nothing, 1, Datatype(T))
end


Base.eltype(rbuf::RBuffer) = eltype(rbuf.senddata)
Base.eltype(rbuf::RBuffer{InPlace}) = eltype(rbuf.recvdata)
