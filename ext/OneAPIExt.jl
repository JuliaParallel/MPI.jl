module OneAPIExt

import MPI
isdefined(Base, :get_extension) ? (import oneAPI) : (import ..oneAPI)
import MPI: MPIPtr, Buffer, Datatype

function Base.cconvert(::Type{MPIPtr}, A::oneAPI.oneArray{T}) where T
    A
end

function Base.unsafe_convert(::Type{MPIPtr}, X::oneAPI.oneArray{T}) where T
    reinterpret(MPIPtr, Base.unsafe_convert(oneAPI.ZePtr{T}, X))
end

# only need to define this for strided arrays: all others can be handled by generic machinery
function Base.unsafe_convert(::Type{MPIPtr}, V::SubArray{T,N,P,I,true}) where {T,N,P<:oneAPI.oneArray,I}
    X = parent(V)
    pX = Base.unsafe_convert(oneAPI.ZePtr{T}, X)
    pV = pX + ((V.offset1 + V.stride1) - first(LinearIndices(X)))*sizeof(T)
    return reinterpret(MPIPtr, pV)
end

function Buffer(arr::oneAPI.oneArray)
    Buffer(arr, Cint(length(arr)), Datatype(eltype(arr)))
end

end # OneAPIExt
