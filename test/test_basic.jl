using Test
using MPI

if get(ENV,"JULIA_MPI_TEST_ARRAYTYPE","") == "CuArray"
    import CUDA
    ArrayType = CUDA.CuArray
elseif get(ENV,"JULIA_MPI_TEST_ARRAYTYPE","") == "ROCArray"
    import AMDGPU
    ArrayType = AMDGPU.ROCArray
else
    ArrayType = Array
end

@test !MPI.Initialized()
MPI.Init()
@test MPI.Initialized()

@test 0 <= MPI.Comm_rank(MPI.COMM_WORLD) < MPI.Comm_size(MPI.COMM_WORLD)

@test MPI.has_cuda() isa Bool

# DEBUG: needs another mechanism to fikter out CuArrays
if ArrayType != Array
    @test MPI.has_cuda()
end

@test !MPI.Finalized()
MPI.Finalize()
@test MPI.Finalized()
