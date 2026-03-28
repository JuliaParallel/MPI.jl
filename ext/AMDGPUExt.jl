module AMDGPUExt

import MPI
isdefined(Base, :get_extension) ? (import AMDGPU) : (import ..AMDGPU)
import MPI: MPIPtr, Buffer, Datatype, CConvWrapper

function Base.cconvert(::Type{MPIPtr}, x::AMDGPU.ROCArray{T}) where T
    CConvWrapper(Ptr{T}, x)
end

function Buffer(arr::AMDGPU.ROCArray)
    Buffer(arr, Cint(length(arr)), Datatype(eltype(arr)))
end

end # AMDGPUExt
