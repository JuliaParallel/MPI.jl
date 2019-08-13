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

counts = Cint[mod(i,2) + 1 for i in 0:(size-1)]
check = collect(Iterators.flatten([fill(r, counts[r+1]) for r = 0:size-1]))

for T in Base.uniontypes(MPI.MPIDatatype)
    A = ArrayType(fill(T(rank), mod(rank,2) + 1))
    B = MPI.Gatherv(A, counts, root, comm)
    if isroot
        @test B isa ArrayType{T}
        @test B == ArrayType{T}(check)
    end

    # Test passing the output buffer
    B = ArrayType{T}(undef, sum(counts))
    MPI.Gatherv!(A, B, counts, root, comm)
    if isroot
        @test B == ArrayType{T}(check)
    end

    # Test assertion when output size is too small
    B = ArrayType{T}(undef, sum(counts)-1)
    if isroot
        @test_throws AssertionError MPI.Gatherv!(A, B, counts, root, comm)
    end

    # Test explicit MPI_IN_PLACE
    B = ArrayType(fill(T(rank), sum(counts)))
    MPI.Gatherv_in_place!(B, counts, root, comm)
    if isroot
        @test B == ArrayType{T}(check)
    end
end


MPI.Finalize()
@test MPI.Finalized()
