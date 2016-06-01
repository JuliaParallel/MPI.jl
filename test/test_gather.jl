using Base.Test
using MPI

MPI.Init()

function gather(A, root)
    comm = MPI.COMM_WORLD
    C = MPI.Gather(A, root, comm)
end

function igather(A, root)
    comm = MPI.COMM_WORLD
    req, C = MPI.Igather(A, root, comm)
    MPI.Wait!(req)
    C
end

comm = MPI.COMM_WORLD
root = 0

for typ in MPI.MPIDatatype.types
    A = typ[MPI.Comm_rank(comm) + 1]
    C = gather(A, root)
    if MPI.Comm_rank(comm) == root
        @test C == collect(1:MPI.Comm_size(comm))
    end
    A = convert(typ,MPI.Comm_rank(comm) + 1)
    C = gather(A, root)
    if MPI.Comm_rank(comm) == root
        @test C == collect(1:MPI.Comm_size(comm))
    end
    A = typ[MPI.Comm_rank(comm) + 1]
    C = igather(A, root)
    if MPI.Comm_rank(comm) == root
        @test C == collect(1:MPI.Comm_size(comm))
    end
    A = convert(typ,MPI.Comm_rank(comm) + 1)
    C = igather(A, root)
    if MPI.Comm_rank(comm) == root
        @test C == collect(1:MPI.Comm_size(comm))
    end
end

MPI.Finalize()
