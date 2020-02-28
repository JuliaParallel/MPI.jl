import .CuArrays: CuArray
import .CuArrays.CUDAdrv: CuPtr, synchronize
import .CuArrays.CUDAdrv.Mem: DeviceBuffer


function Base.cconvert(::Type{MPIPtr}, buf::CuArray{T}) where T
    Base.cconvert(CuPtr{T}, buf) # returns DeviceBuffer
end

# CuArrays <= v1.3
function Base.unsafe_convert(::Type{MPIPtr}, buf::DeviceBuffer)
    reinterpret(MPIPtr, buf.ptr)
end
# CuArrays > v1.3
function Base.unsafe_convert(::Type{MPIPtr}, X::CuArray{T}) where T
    reinterpret(MPIPtr, Base.unsafe_convert(CuPtr{T}, X))
end
# only need to define this for strided arrays: all others can be handled by generic machinery
function Base.unsafe_convert(::Type{MPIPtr}, V::SubArray{T,N,P,I,true}) where {T,N,P<:CuArray,I}
    X = parent(V)
    pX = Base.unsafe_convert(CuPtr{T}, X)
    pV = pX + ((V.offset1 + V.stride1) - first(LinearIndices(X)))*sizeof(T)
    return reinterpret(MPIPtr, pV)
end

function Buffer(arr::CuArray)
    Buffer(arr, Cint(length(arr)), Datatype(eltype(arr)))
end
