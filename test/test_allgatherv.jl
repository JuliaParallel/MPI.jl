using Test
using MPI

MPI.Init()

function allgatherv_array(A, counts::Vector{Cint})
    comm = MPI.COMM_WORLD
    B = MPI.Allgatherv(A, counts, comm)
end

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

# Defining this to make ones work for Char
Base.one(::Type{Char}) = '\01'

for typ in Base.uniontypes(MPI.MPIDatatype)

    A = ones(typ, mod(rank,2) + 1)
    counts = Cint[mod(i,2) + 1 for i in 0:(size-1)]
    B = allgatherv_array(A, counts)
    @test B == ones(typ, 3 * div(size,2) + mod(size,2))

    # Test passing the output buffer
    A = ones(typ, mod(rank,2) + 1)
    counts = Cint[mod(i,2) + 1 for i in 0:(size-1)]
    B = ones(typ, sum(counts)-1)
    @test_throws AssertionError MPI.Allgatherv!(A, B, counts, comm)

    # Test assertion when output size is too small
    A = ones(typ, mod(rank,2) + 1)
    counts = Cint[mod(i,2) + 1 for i in 0:(size-1)]
    B = ones(typ, sum(counts))
    MPI.Allgatherv!(A, B, counts, comm)
    @test B == ones(typ, 3 * div(size,2) + mod(size,2))

    # Test explicit MPI_IN_PLACE
    A = ones(typ, mod(rank,2) + 1)
    counts = Cint[mod(i,2) + 1 for i in 0:(size-1)]
    B = ones(typ, sum(counts))
    start = (cumsum(counts)-counts.+1)[MPI.Comm_rank(comm)+1]
    len   = counts[MPI.Comm_rank(comm)+1]
    B[start:(start+len-1)] .= A
    MPI.Allgatherv!(MPI.IN_PLACE, B, counts, comm)
    @test B == ones(typ, 3 * div(size,2) + mod(size,2))
end

MPI.Finalize()
@test MPI.Finalized()
