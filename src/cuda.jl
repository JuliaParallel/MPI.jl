import .CUDA

function Base.cconvert(::Type{MPIPtr}, buf::CUDA.CuArray{T}) where T
    CUDA.synchronize(CUDA.CuDefaultStream())
    Base.cconvert(CUDA.CuPtr{T}, buf) # returns DeviceBuffer
end

function Base.unsafe_convert(::Type{MPIPtr}, X::CUDA.CuArray{T}) where T
    reinterpret(MPIPtr, Base.unsafe_convert(CUDA.CuPtr{T}, X))
end

# only need to define this for strided arrays: all others can be handled by generic machinery
function Base.unsafe_convert(::Type{MPIPtr}, V::SubArray{T,N,P,I,true}) where {T,N,P<:CUDA.CuArray,I}
    X = parent(V)
    pX = Base.unsafe_convert(CUDA.CuPtr{T}, X)
    pV = pX + ((V.offset1 + V.stride1) - first(LinearIndices(X)))*sizeof(T)
    return reinterpret(MPIPtr, pV)
end

function Buffer(arr::CUDA.CuArray)
    Buffer(arr, Cint(length(arr)), Datatype(eltype(arr)))
end
