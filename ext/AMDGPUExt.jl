module AMDGPUExt

using AMDGPU: AMDGPU
using MPI: MPI, Buffer, Datatype

function MPI.Buffer(arr::AMDGPU.ROCArray)
    Buffer(arr, Cint(length(arr)), Datatype(eltype(arr)))
end

end # AMDGPUExt
