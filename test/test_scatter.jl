using Test, Pkg
using MPI

if haskey(Pkg.installed(), "CuArrays")
    using CuArrays
    ArrayType = CuArray
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
    @test B[1] == T(rank+1)

    # Non Allocating version
    B = ArrayType{T}(undef, 1)
    MPI.Scatter!(A, B, 1, root, comm)
    @test B[1] == T(rank+1)

    # In place version
    B = isroot ? copy(A) : ArrayType{T}(undef, 1)
    MPI.Scatter_in_place!(B, 1, root, comm)
    @test B[1] == T(rank+1)

    # Test throwing
    B = ArrayType{T}(undef, 0)
    @test_throws AssertionError MPI.Scatter!(A, B, 1, root, comm)
end

MPI.Finalize()
@test MPI.Finalized()
