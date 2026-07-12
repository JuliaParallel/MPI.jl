module AMDGPUExt

using AMDGPU: AMDGPU
using MPI: MPI, MPIPtr, Buffer, Datatype, CConvWrapper

function Base.cconvert(::Type{MPIPtr}, x::AMDGPU.ROCArray{T}) where T
    CConvWrapper(Ptr{T}, x)
end

function MPI.Buffer(arr::AMDGPU.ROCArray)
    Buffer(arr, Cint(length(arr)), Datatype(eltype(arr)))
end

end # AMDGPUExt
