using Test
using MPI

MPI.Init()

function scatterv_array(A, counts::Vector{Cint}, root)
    comm = MPI.COMM_WORLD
    T = eltype(A)
    if MPI.Comm_rank(comm) == root
        B = copy(A)
    else
        B = Array{T}(undef,1)
    end
    C = MPI.Scatterv(B, counts, root, comm)
end

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)
root = 0
isroot = (MPI.Comm_rank(comm) == root)
# Defining this to make ones work for Char
Base.one(::Type{Char}) = '\01'

for typ in Base.uniontypes(MPI.MPIDatatype)

    # Allocating
    A = ones(typ, 3 * div(size,2) + mod(size,2))
    counts = Cint[ mod(i,2) + 1 for i in 0:(size-1)]
    B = scatterv_array(A, counts, root)
    @test B == ones(typ, mod(rank,2) + 1)

    # Non Allocating
    A = ones(typ, 3 * div(size,2) + mod(size,2))
    counts = Cint[ mod(i,2) + 1 for i in 0:(size-1)]
    B = Array{typ}(undef, counts[MPI.Comm_rank(comm) + 1])
    MPI.Scatterv!(A, B, counts, root, comm)
    @test B == ones(typ, mod(rank,2) + 1)

    # IN_PLACE
    counts = Cint[ mod(i,2) + 1 for i in 0:(size-1)]
    A = ones(typ, 3 * div(size,2) + mod(size,2))
    if isroot
        B = deepcopy(A)
    else
        B = Array{typ}(undef, counts[MPI.Comm_rank(comm) + 1])
    end
    MPI.Scatterv_in_place!(B, counts, root, comm)
    isroot  && @test B == A
    !isroot && @test B == ones(typ, mod(rank,2) + 1)
end

MPI.Finalize()
