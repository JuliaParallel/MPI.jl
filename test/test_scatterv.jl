using Base.Test
using MPI

MPI.Init()

function scatterv_array(A, counts::Vector{Cint}, root)
    comm = MPI.COMM_WORLD
    T = eltype(A)
    if MPI.Comm_rank(comm) == root
        B = copy(A)
    else
        B = Array(T,1)
    end
    C = MPI.Scatterv(B, counts, root, comm)
end

function iscatterv_array(A, counts::Vector{Cint}, root)
    comm = MPI.COMM_WORLD
    T = eltype(A)
    if MPI.Comm_rank(comm) == root
        B = copy(A)
    else
        B = Array(T,1)
    end
    req, C = MPI.Iscatterv(B, counts, root, comm)
    MPI.Wait!(req)
    C
end

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)
root = 0

# Defining this to make ones work for Char
Base.one(::Type{Char}) = '\01'

for typ in MPI.MPIDatatype.types
    A = ones(typ, 3 * div(size,2) + mod(size,2))
    counts = Cint[ mod(i,2) + 1 for i in 0:(size-1)]
    B = scatterv_array(A, counts, root)
    @test B == ones(typ, mod(rank,2) + 1)
    A = ones(typ, 3 * div(size,2) + mod(size,2))
    counts = Cint[ mod(i,2) + 1 for i in 0:(size-1)]
    B = iscatterv_array(A, counts, root)
    @test B == ones(typ, mod(rank,2) + 1)
end

MPI.Finalize()
