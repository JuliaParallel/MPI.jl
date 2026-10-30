using Test
using MPI

# element types the device used for testing cannot handle
skip_eltypes = Type[]

if get(ENV,"JULIA_MPI_TEST_ARRAYTYPE","") == "CuArray"
    import CUDA
    ArrayType = CUDA.CuArray
    synchronize() = CUDA.synchronize()
elseif get(ENV,"JULIA_MPI_TEST_ARRAYTYPE","") == "ROCArray"
    import AMDGPU
    ArrayType = AMDGPU.ROCArray
    synchronize() = AMDGPU.synchronize()
elseif get(ENV,"JULIA_MPI_TEST_ARRAYTYPE","") == "oneArray"
    import oneAPI
    ArrayType = oneAPI.oneArray
    synchronize() = oneAPI.synchronize()
    # Integrated Intel GPUs generally have no native Float64 support, and
    # `oneArray` refuses to hold element types the device cannot handle.
    if oneAPI.oneL0.module_properties(oneAPI.device()).fp64flags &
       oneAPI.oneL0.ZE_DEVICE_MODULE_FLAG_FP64 != oneAPI.oneL0.ZE_DEVICE_MODULE_FLAG_FP64
        append!(skip_eltypes, [Float64, ComplexF64])
    end
else
    ArrayType = Array
    synchronize() = nothing
end

# those are the tested MPI types, don't remove !
const MPITestTypes = setdiff([
    Char,
    Int8, Int16, Int32, Int64,
    UInt8, UInt16, UInt32, UInt64,
    Float32, Float64, ComplexF32, ComplexF64
], skip_eltypes)

# Custom reduction operators are wrapped in a C callback. That is not possible for 32-bit
# Microsoft MPI, which expects the `stdcall` calling convention, and the callback runs on
# the host, so it is only meaningful for host arrays.
const can_do_closures =
    ArrayType === Array &&
    !(MPI.MPI_LIBRARY == "MicrosoftMPI" && Sys.WORD_SIZE == 32)
