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

counts = Cint[mod(i,2) + 1 for i in 0:(size-1)]
check = collect(Iterators.flatten([fill(r, counts[r+1]) for r = 0:size-1]))

for T in Base.uniontypes(MPI.MPIDatatype)
    A = ArrayType(fill(T(rank), mod(rank,2) + 1))

    # Test passing the output buffer
    B = ArrayType{T}(undef, sum(counts))
    MPI.Gatherv!(A, isroot ? VBuffer(B, counts) : nothing, comm; root=root)
    if isroot
        @test B == ArrayType{T}(check)
    end

    # Test assertion when output size is too small
    B = ArrayType{T}(undef, sum(counts)-1)
    if isroot
        @test_throws AssertionError MPI.Gatherv!(A, VBuffer(B, counts), comm; root=root)
    end

    # Test explicit MPI_IN_PLACE
    if isroot
        B = ArrayType(fill(T(rank), sum(counts)))
        MPI.Gatherv!(MPI.IN_PLACE, VBuffer(B, counts), comm; root=root)
    else
        B = ArrayType(fill(T(rank), counts[rank+1]))
        MPI.Gatherv!(B, nothing, comm; root=root)
    end
    if isroot
        @test B == ArrayType{T}(check)
    end
end


MPI.Finalize()
@test MPI.Finalized()
