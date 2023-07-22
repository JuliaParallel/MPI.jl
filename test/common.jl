using Test
using MPI

if get(ENV,"JULIA_MPI_TEST_ARRAYTYPE","") == "CuArray"
    import CUDA
    ArrayType = CUDA.CuArray
    synchronize() = CUDA.synchronize()
elseif get(ENV,"JULIA_MPI_TEST_ARRAYTYPE","") == "ROCArray"
    import AMDGPU
    ArrayType = AMDGPU.ROCArray
    synchronize() = AMDGPU.HIP.synchronize() # HIP backend since AMDGPU v0.5
else
    ArrayType = Array
    synchronize() = nothing
end

# those are the tested MPI types, don't remove !
const MPITestTypes = [
    Char,
    Int8, Int16, Int32, Int64,
    UInt8, UInt16, UInt32, UInt64,
    Float32, Float64, ComplexF32, ComplexF64
]
