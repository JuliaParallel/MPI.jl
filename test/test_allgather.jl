using Base.Test
using MPI

MPI.Init()

function allgather(A)
    comm = MPI.COMM_WORLD
    C = MPI.Allgather(A, comm)
end

comm = MPI.COMM_WORLD

for typ in MPI.MPIDatatype.types
    A = typ[MPI.Comm_rank(comm) + 1]
    C = allgather(A)
    @test typeof(C) === Vector{typ}
    @test C == map(typ, collect(1:MPI.Comm_size(comm)))
    A = convert(typ,MPI.Comm_rank(comm) + 1)
    C = allgather(A)
    @test typeof(C) === Vector{typ}
    @test C == map(typ, collect(1:MPI.Comm_size(comm)))
end

MPI.Finalize()
