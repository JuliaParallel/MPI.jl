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

send = Array{Int}(undef,rank+size)
fill!(send, rank*rank)
recv = collect(1:(rank+1))
fill!(recv,-1)
MPI.Neighbor_alltoall!(UBuffer(send,1), UBuffer(recv,1), graph_comm);

@test sort(recv) == collect(0:rank).^2

MPI.Finalize()
@test MPI.Finalized()
