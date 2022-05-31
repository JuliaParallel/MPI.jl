include("common.jl")

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

counts = Cint[mod(i,2) + 1 for i in 0:(size-1)]
check = collect(Iterators.flatten([fill(r, counts[r+1]) for r = 0:size-1]))

for T in Base.uniontypes(MPI.MPIDatatype)
    A = ArrayType{T}(fill(T(rank), counts[rank+1]))
    synchronize()

    # Test passing the output buffer
    B = ArrayType{T}(undef, sum(counts))
    MPI.Allgatherv!(A, VBuffer(B, counts), comm)
    @test B == ArrayType{T}(check)

    # Test assertion when output size is too small
    B = ArrayType{T}(undef, sum(counts)-1)
    @test_throws AssertionError MPI.Allgatherv!(A, VBuffer(B, counts), comm)

    # Test explicit MPI_IN_PLACE
    B = ArrayType(fill(T(rank), sum(counts)))
    synchronize()
    MPI.Allgatherv!(MPI.IN_PLACE, VBuffer(B, counts), comm)
    @test B == ArrayType{T}(check)
end

MPI.Finalize()
@test MPI.Finalized()
