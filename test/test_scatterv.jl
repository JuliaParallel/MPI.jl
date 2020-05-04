using Test
using MPI

if get(ENV,"JULIA_MPI_TEST_ARRAYTYPE","") == "CuArray"
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

counts = Cint[mod(i,2) + 1 for i in 0:(size-1)]
ref = collect(Iterators.flatten([fill(r, counts[r+1]) for r = 0:size-1]))

for T in Base.uniontypes(MPI.MPIDatatype)
    A = isroot ? ArrayType{T}(ref) : ArrayType{T}(undef, 1)

    # Allocating
    B = MPI.Scatterv(A, counts, root, comm)
    @test B isa ArrayType{T}
    @test B == ArrayType{T}(fill(rank, counts[rank+1]))

    # Non Allocating
    B = ArrayType{T}(undef, counts[rank+1])
    MPI.Scatterv!(A, B, counts, root, comm)
    @test B == ArrayType{T}(fill(rank, counts[rank+1]))

    # IN_PLACE
    B = isroot ? copy(A) : ArrayType{T}(undef, counts[rank+1])
    if root == MPI.Comm_rank(comm)
        MPI.Scatterv!(B, nothing, counts, root, comm)
    else
        MPI.Scatterv!(nothing, B, counts, root, comm)
    end
    if isroot
        @test B == A
    else
        @test B == ArrayType{T}(fill(rank, counts[rank+1]))
    end
end

MPI.Finalize()
@test MPI.Finalized()
