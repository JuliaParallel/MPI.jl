using Base.Test

using MPI

MPI.Init()
comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

a = fill(rank,size)
@test MPI.Alltoall(a, 1, comm) == collect(0:(size-1))

b = fill(rank,size)
req,c = MPI.Ialltoall(b, 1, comm)
MPI.Wait!(req)
MPI.Barrier(MPI.COMM_WORLD)
@test c == collect(0:(size-1))
MPI.Finalize()
