using Test
using MPI

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

#
# Setup the following communication graph
#
#   +-----+
#   |     |
#   v     v
#   0<-+  3
#   ^  |  ^
#   |  |  |
#   v  |  v
#   1  +--2
#   ^     |
#   |     |
#   +-----+
#
#

if rank == 0
    dest   = Cint[1,3]
    degree = Cint[length(dest)]
elseif rank == 1
    dest   = Cint[0]
    degree = Cint[length(dest)]
elseif rank == 2
    dest   = Cint[3,0,1]
    degree = Cint[length(dest)]
elseif rank == 3
    dest   = Cint[0,2,1]
    degree = Cint[length(dest)]
end

source = Cint[rank]
graph_comm = MPI.Dist_graph_create(comm, source, degree, dest)

#
# Now send the rank across the edges.
#
# Version 1: use allgather primitive
#

send = [rank]
if rank == 0
    recv = [-1, -1, -1]
elseif rank == 1
    recv = [-1, -1, -1]
elseif rank == 2
    recv = [-1]
elseif rank == 3
    recv = [-1, -1]
end

MPI.Neighbor_allgather!(send, recv, graph_comm);

println("rank = $(rank): $(recv)")

#
# Version 2: use alltoall primitive
#

if rank == 0
    send   = [rank, rank]
    recv   = [-1, -1, -1]
elseif rank == 1
    send = [rank]
    recv   = [-1, -1, -1]
elseif rank == 2
    send = [rank, rank, rank]
    recv   = [-1]
elseif rank == 3
    send = [rank, rank, rank]
    recv   = [-1, -1]
end

MPI.Neighbor_alltoall!(UBuffer(send,1), UBuffer(recv,1), graph_comm);

println("rank = $(rank): $(recv)")

#
# Now send the rank exactly rank times across the edges.
#
# Rank i receives i+1 values from each adjacent process
if rank == 0
    send       = [rank, rank,
                  rank, rank, rank, rank]
    send_count = [2, 4]

    recv   = [-1, -1, -1]
    recv_count = [1, 1, 1]
elseif rank == 1
    send       = [rank]
    send_count = [1]

    recv       = [-1, -1, -1, -1, -1, -1]
    recv_count = [2, 2, 2]
elseif rank == 2
    send       = [rank, rank, rank, rank,
                  rank,
                  rank,rank]
    send_count = [4, 1, 2]

    recv       = [-1, -1, -1]
    recv_count = [3]
elseif rank == 3
    send       = [rank, 
                  rank, rank,rank,
                  rank, rank]
    send_count = [1, 3, 2]

    recv       = [-1, -1, -1, -1, -1, -1, -1, -1]
    recv_count = [4, 4]
end

MPI.Neighbor_alltoallv!(VBuffer(send,send_count), VBuffer(recv,recv_count), graph_comm);
println("rank = $(rank): $(recv)")

MPI.Finalize()
