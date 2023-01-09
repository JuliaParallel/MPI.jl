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

# Query number of ranks that point to this rank, and number of ranks this rank point to
indegree, outdegree, _ = MPI.Dist_graph_neighbors_count(graph_comm)

# Query which ranks that point to this rank, and which ranks this rank point to
inranks = Vector{Cint}(undef, indegree)
outranks = Vector{Cint}(undef, outdegree)
MPI.Dist_graph_neighbors!(graph_comm, inranks, outranks)

#
# Now send the rank across the edges.
#
# Version 1: use allgather primitive
#

send = Cint[rank]
recv = Vector{Cint}(undef, indegree)

MPI.Neighbor_allgather!(send, recv, graph_comm);

print("rank = $(rank): $(recv)\n")

#
# Version 2: use alltoall primitive
#

send = fill(Cint(rank), outdegree)
recv = Vector{Cint}(undef, indegree)

MPI.Neighbor_alltoall!(UBuffer(send,1), UBuffer(recv,1), graph_comm);

print("rank = $(rank): $(recv)\n")

#
# Now send the this rank "destination rank"+1 times across the edges.
# Rank i receives i+1 values from each adjacent process
#

send_count = outranks .+ Cint(1)
send = fill(Cint(rank), sum(send_count))
recv_count = fill(Cint(rank + 1), length(inranks))
recv = Vector{Cint}(undef, sum(recv_count))

MPI.Neighbor_alltoallv!(VBuffer(send,send_count), VBuffer(recv,recv_count), graph_comm);
print("rank = $(rank): $(recv)\n")

MPI.Finalize()
