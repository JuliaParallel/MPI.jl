using Test
using MPI

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)
root = 0

# Defining this to make ones work for Char
Base.one(::Type{Char}) = '\01'

for typ in Base.uniontypes(MPI.MPIDatatype)

    A = ones(typ, mod(rank,2) + 1)
    counts = Cint[mod(i,2) + 1 for i in 0:(size-1)]
    B = MPI.Gatherv(A, counts, root, comm)
    if rank == root
        @test B == ones(typ, 3 * div(size,2) + mod(size,2))
    end

    # Test passing the output buffer
    A = ones(typ, mod(rank,2) + 1)
    counts = Cint[mod(i,2) + 1 for i in 0:(size-1)]
    B = ones(typ, sum(counts)-1)
    if rank == root
        @test_throws AssertionError MPI.Gatherv!(A, B, counts, root, comm)
    end

    # Test assertion when output size is too small
    A = ones(typ, mod(rank,2) + 1)
    counts = Cint[mod(i,2) + 1 for i in 0:(size-1)]
    B = ones(typ, sum(counts))
    MPI.Gatherv!(A, B, counts, root, comm)
    if rank == root
        @test B == ones(typ, 3 * div(size,2) + mod(size,2))
    end

    # Test explicit MPI_IN_PLACE
    A = ones(typ, mod(rank,2) + 1)
    counts = Cint[mod(i,2) + 1 for i in 0:(size-1)]
    B = ones(typ, sum(counts))
    start = (cumsum(counts)-counts.+1)[MPI.Comm_rank(comm)+1]
    len   = counts[MPI.Comm_rank(comm)+1]
    B[start:(start+len-1)] .= A
    MPI.Gatherv_in_place!(B, counts, root, comm)
    if rank == root
        @test B == ones(typ, 3 * div(size,2) + mod(size,2))
    end
end


MPI.Finalize()
