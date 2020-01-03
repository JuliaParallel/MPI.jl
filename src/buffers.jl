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
function Base.cconvert(::Type{MPIPtr}, x::SubArray{T}) where T
    Base.cconvert(Ptr{T}, x)
end
function Base.unsafe_convert(::Type{MPIPtr}, x::MPIBuffertype{T}) where T
    ptr = Base.unsafe_convert(Ptr{T}, x)
    reinterpret(MPIPtr, ptr)
end
function Base.cconvert(::Type{MPIPtr}, ::Nothing)
    reinterpret(MPIPtr, C_NULL)
end

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
 - `CuArray` if CuArrays.jl is loaded.

Additionally, certain sentinel values can be used, e.g. `MPI_IN_PLACE` or `MPI_BOTTOM`.
"""
MPIPtr


"""
    MPI.Buffer

An MPI buffer for communication operations.

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
 - `CuArray` if CuArrays.jl is loaded
 - `SubArray`s of an `Array` or `CuArray` where the layout is contiguous, sequential or
   blocked.

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
                                   Datatype(eltype(sub); commit=false))
    Types.commit!(datatype)
    Buffer(sub, Cint(1), datatype)
end
function Buffer(sub::SubArray{T,N,P,I,false}) where {T,N,P,I<:Tuple{Vararg{Union{Base.ScalarIndex, Base.Slice, AbstractUnitRange}}}}
    datatype = Types.create_subarray(size(parent(sub)),
                                     map(length, sub.indices),
                                     map(i -> first(i)-1, sub.indices),
                                     Datatype(eltype(sub), commit=false))
    Types.commit!(datatype)
    Buffer(parent(sub), Cint(1), datatype)
end

"""
    Buffer_send(data)

Construct a [`Buffer`](@ref) object for a send operation from `data`, allowing cases where
`isbits(data)`.
"""
Buffer_send(data) = isbits(data) ? Buffer(Ref(data)) : Buffer(data)

const BUFFER_NULL = Buffer(C_NULL, 0, DATATYPE_NULL)
