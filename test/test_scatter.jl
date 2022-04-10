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

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)
root = 0
isroot = rank == root

for T in Base.uniontypes(MPI.MPIDatatype)

    A = isroot ? ArrayType{T}(1:size) : ArrayType{T}(undef, 1)

    # Non Allocating version
    B = ArrayType{T}(undef, 1)
    MPI.Scatter!(A, B, root, comm)
    @test Array(B)[1] == T(rank+1)

    # In place version
    B = isroot ? copy(A) : ArrayType{T}(undef, 1)
    if root == MPI.Comm_rank(comm)
        MPI.Scatter!(UBuffer(B,1), MPI.IN_PLACE, root, comm)
    else
        MPI.Scatter!(nothing, B, root, comm)
    end
    @test Array(B)[1] == T(rank+1)

    # Test throwing
    if isroot
        B = ArrayType{T}(undef, 0)
        @test_throws DivideError MPI.Scatter!(A, B, root, comm)
        B = ArrayType{T}(undef, 8)
        @test_throws AssertionError MPI.Scatter!(A, B, root, comm)
    end
end

MPI.Finalize()
@test MPI.Finalized()
