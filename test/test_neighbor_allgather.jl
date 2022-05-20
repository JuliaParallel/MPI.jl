using Test
using MPI

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

source = Cint[rank]
send = [rank]

if rank == 0
    dest   = Cint[1,3]
    degree = Cint[length(dest)]
    recv   = [-1, -1, -1]
elseif rank == 1
    dest = Cint[0]
    degree = Cint[length(dest)]
    recv   = [-1, -1, -1]
elseif rank == 2
    dest = Cint[3,0,1]
    degree = Cint[length(dest)]
    recv   = [-1]
elseif rank == 3
    dest = Cint[0,2,1]
    degree = Cint[length(dest)]
    recv   = [-1, -1]
end

graph_comm = MPI.Dist_graph_create(comm, source, degree, dest)
MPI.Neighbor_allgather!(send, recv, graph_comm);

@test !issubset(recv, [-1])
rank == 0 && @test issubset(recv, [1, 2, 3])
rank == 1 && @test issubset(recv, [0, 2, 3])
rank == 2 && @test issubset(recv, [3])
rank == 3 && @test issubset(recv, [0, 2])

MPI.Finalize()
@test MPI.Finalized()

