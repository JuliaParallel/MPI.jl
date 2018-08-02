using Test

using MPI

MPI.Init()
comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

a = fill(rank,size)
@test MPI.Alltoall(a, 1, comm) == collect(0:(size-1))
MPI.Finalize()
