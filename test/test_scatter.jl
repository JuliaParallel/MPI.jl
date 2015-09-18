using Base.Test
using MPI

MPI.Init()

function scatter_array(A, root)
    comm = MPI.COMM_WORLD
    T = eltype(A)
    if MPI.Comm_rank(comm) == root
        B = copy(A)
    else
        B = Array(T,1)
    end
    C = MPI.Scatter(B, 1, root, comm)
end

comm = MPI.COMM_WORLD
root = 0

A = collect(1:MPI.Comm_size(comm))
B = scatter_array(A, root)
@test B[1] == MPI.Comm_rank(comm) + 1
for typ in MPI.MPIDatatype.types
    A = convert(Vector{typ},collect(1:MPI.Comm_size(comm)))
    B = scatter_array(A, root)
    @test B[1] == convert(typ,MPI.Comm_rank(comm) + 1)
end

MPI.Finalize()
