using Base.Test
using MPI

MPI.Init()

function allgather(A)
    comm = MPI.COMM_WORLD
    C = MPI.Allgather(A, comm)
end

function iallgather(A)
    comm = MPI.COMM_WORLD
    req, C = MPI.Iallgather(A, comm)
    MPI.Wait!(req)
    C
end

comm = MPI.COMM_WORLD

for typ in MPI.MPIDatatype.types
    A = typ[MPI.Comm_rank(comm) + 1]
    C = allgather(A)
    @test C == collect(1:MPI.Comm_size(comm))
    A = convert(typ,MPI.Comm_rank(comm) + 1)
    C = allgather(A)
    @test C == collect(1:MPI.Comm_size(comm))
    A = typ[MPI.Comm_rank(comm) + 1]
    C = iallgather(A)
    @test C == collect(1:MPI.Comm_size(comm))
    A = convert(typ,MPI.Comm_rank(comm) + 1)
    C = iallgather(A)
    @test C == collect(1:MPI.Comm_size(comm))
end

MPI.Finalize()
