import .AMDGPU

function Base.cconvert(::Type{MPIPtr}, A::AMDGPU.ROCArray{T}) where T
    A
end

function Base.unsafe_convert(::Type{MPIPtr}, X::AMDGPU.ROCArray{T}) where T
    reinterpret(MPIPtr, Base.unsafe_convert(Ptr{T}, X.buf.ptr+X.offset))
end

# only need to define this for strided arrays: all others can be handled by generic machinery
function Base.unsafe_convert(::Type{MPIPtr}, V::SubArray{T,N,P,I,true}) where {T,N,P<:AMDGPU.ROCArray,I}
    X = parent(V)
    pX = Base.unsafe_convert(Ptr{T}, X)
    pV = pX + ((V.offset1 + V.stride1) - first(LinearIndices(X)))*sizeof(T)
    return reinterpret(MPIPtr, pV)
end

function Buffer(arr::AMDGPU.ROCArray)
    Buffer(arr, Cint(length(arr)), Datatype(eltype(arr)))
end
