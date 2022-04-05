import .AMDGPU

function Base.cconvert(::Type{MPI.MPIPtr}, A::AMDGPU.ROCArray{T}) where T
    Base.cconvert(Ptr{T}, A.buf.ptr) # returns DeviceBuffer
end

function Base.unsafe_convert(::Type{MPI.MPIPtr}, X::AMDGPU.ROCArray{T}) where T
    reinterpret(MPIPtr, Base.unsafe_convert(Ptr{T}, X.buf.ptr))
end

# only need to define this for strided arrays: all others can be handled by generic machinery
function Base.unsafe_convert(::Type{MPI.MPIPtr}, V::SubArray{T,N,P,I,true}) where {T,N,P<:AMDGPU.ROCArray,I}
    X = parent(V)
    pX = Base.unsafe_convert(Ptr{T}, X)
    pV = pX + ((V.offset1 + V.stride1) - first(LinearIndices(X)))*sizeof(T)
    return reinterpret(MPI.MPIPtr, pV)
end

function Buffer(arr::AMDGPU.ROCArray)
    Buffer(arr, Cint(length(arr)), Datatype(eltype(arr)))
end
