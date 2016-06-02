using Base.Test

using MPI

MPI.Init()
comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

a = fill(rank,size)
@test MPI.Alltoall(a, 1, comm) == collect(0:(size-1))

b = fill(-rank, size)
recv = zeros(eltype(b), size)
MPI.Alltoall!(recv, b, 1, comm)
@test recv == -collect(0:(size-1))

MPI.Finalize()
