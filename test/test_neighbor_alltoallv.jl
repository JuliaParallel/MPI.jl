using Test
using MPI

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

source = Cint[rank]
dest = Cint.(rank:(size-1))
degree = Cint[length(dest)]
graph_comm = MPI.Dist_graph_create(comm, source, degree, dest)

send_count = dest.+1
send = Array{Int}(undef, sum((send_count)))
fill!(send, rank)

recv = Array{Int}(undef, (rank+1)^2)
fill!(recv, -1)
recv_count = Array{Cint}(undef, rank+1)
fill!(recv_count, Cint(rank+1))

MPI.Neighbor_alltoallv!(VBuffer(send,send_count), VBuffer(recv,recv_count), graph_comm);

@test sort(recv) == sort(repeat(0:rank, rank+1))

MPI.Finalize()
@test MPI.Finalized()
