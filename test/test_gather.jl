using Test
using MPI

MPI.Init()

function gather(A, root)
    comm = MPI.COMM_WORLD
    C = MPI.Gather(A, root, comm)
end

comm = MPI.COMM_WORLD
root = 0

for typ in Base.uniontypes(MPI.MPIDatatype)
    A = typ[MPI.Comm_rank(comm) + 1]
    C = gather(A, root)
    if MPI.Comm_rank(comm) == root
        @test typeof(C) === Vector{typ}
        @test C == map(typ, collect(1:MPI.Comm_size(comm)))
    end
    A = convert(typ,MPI.Comm_rank(comm) + 1)
    C = gather(A, root)
    if MPI.Comm_rank(comm) == root
        @test typeof(C) === Vector{typ}
        @test C == map(typ, collect(1:MPI.Comm_size(comm)))
    end
end

MPI.Finalize()
