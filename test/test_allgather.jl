using Base.Test
using MPI

MPI.Init()

function allgather_array(A)
    comm = MPI.COMM_WORLD

    B = copy(A)
    C = MPI.Allgather(B, comm)
end

comm = MPI.COMM_WORLD

for typ in MPI.MPIDatatype.types
    A = typ[MPI.Comm_rank(comm) + 1]
    C = allgather_array(A)
    @test C == collect(1:MPI.Comm_size(comm))
end

MPI.Finalize()
