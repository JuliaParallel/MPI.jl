using Base.Test
using MPI

MPI.Init()

function allgatherv_array(A, counts::Vector{Cint})
    comm = MPI.COMM_WORLD
    B = MPI.Allgatherv(A, counts, comm)
end

function iallgatherv_array(A, counts::Vector{Cint})
    comm = MPI.COMM_WORLD
    req, B = MPI.Iallgatherv(A, counts, comm)
    MPI.Wait!(req)
    B
end

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

# Defining this to make ones work for Char
Base.one(::Type{Char}) = '\01'

for typ in MPI.MPIDatatype.types

    A = ones(typ, mod(rank,2) + 1)
    counts = Cint[ mod(i,2) + 1 for i in 0:(size-1)]
    B = allgatherv_array(A, counts)
    @test B == ones(typ, 3 * div(size,2) + mod(size,2))
    A = ones(typ, mod(rank,2) + 1)
    counts = Cint[ mod(i,2) + 1 for i in 0:(size-1)]
    B = iallgatherv_array(A, counts)
    @test B == ones(typ, 3 * div(size,2) + mod(size,2))
end

MPI.Finalize()
