using Test
using MPI

if get(ENV,"JULIA_MPI_TEST_ARRAYTYPE","") == "CuArray"
    import CUDA
    ArrayType = CUDA.CuArray
    synchronize() = CUDA.synchronize()
else
    ArrayType = Array
    synchronize() = nothing
end
