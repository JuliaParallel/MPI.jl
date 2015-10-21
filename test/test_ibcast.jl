using Base.Test
using MPI

MPI.Init()

function bcast_array(A, root)
    comm = MPI.COMM_WORLD

    if MPI.Comm_rank(comm) == root
        B = copy(A)
    else
        B = similar(A)
    end

    request = MPI.IBcast!(B, root, comm)
    MPI.Wait!(request)
    B
end

root = 0

srand(17)

matsize = (17,17)
for typ in MPI.MPIDatatype.types
    A = rand(typ, matsize...)
    @test bcast_array(A, root) == A
end

# Char
A = ['s', 't', 'a', 'r', ' ', 'w', 'a', 'r', 's']
@test bcast_array(A, root) == A
MPI.Finalize()
