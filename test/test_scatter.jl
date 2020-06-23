using Test
using MPI

if get(ENV,"JULIA_MPI_TEST_ARRAYTYPE","") == "CuArray"
    import CUDA
    ArrayType = CUDA.CuArray
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

    # Allocating version
    A = isroot ? ArrayType{T}(1:size) : ArrayType{T}(undef, 1)
    B = MPI.Scatter(A, 1, root, comm)
    @test B isa ArrayType{T}
    @test Array(B)[1] == T(rank+1)

    # Non Allocating version
    B = ArrayType{T}(undef, 1)
    MPI.Scatter!(A, B, 1, root, comm)
    @test Array(B)[1] == T(rank+1)

    # In place version
    B = isroot ? copy(A) : ArrayType{T}(undef, 1)
    if root == MPI.Comm_rank(comm)
        MPI.Scatter!(B, nothing, 1, root, comm)
    else
        MPI.Scatter!(nothing, B, 1, root, comm)
    end
    @test Array(B)[1] == T(rank+1)

    # Test throwing
    B = ArrayType{T}(undef, 0)
    @test_throws AssertionError MPI.Scatter!(A, B, 1, root, comm)
end

MPI.Finalize()
@test MPI.Finalized()
