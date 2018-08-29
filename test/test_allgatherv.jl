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
end

MPI.Finalize()
