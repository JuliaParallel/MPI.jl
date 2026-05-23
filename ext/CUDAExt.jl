module CUDAExt

using CUDA: CUDA
using MPI: MPI, MPIPtr, Buffer, Datatype, CConvWrapper

function Base.cconvert(::Type{MPIPtr}, buf::CUDA.CuArray{T}) where T
    CConvWrapper(CUDA.CuPtr{T}, buf)
end

function Base.cconvert(::Type{MPIPtr}, buf::SubArray{T,N,P,I,true}) where {T,N,P<:CUDA.CuArray,I}
    CConvWrapper(CUDA.CuPtr{T}, buf)
end

function MPI.Buffer(arr::CUDA.CuArray)
    Buffer(arr, Cint(length(arr)), Datatype(eltype(arr)))
end

end #CUDAExt
