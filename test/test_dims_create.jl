using Test
using MPI

MPI.Init()
comm = MPI.COMM_WORLD
nnodes = MPI.Comm_size(comm)
ndims = 3

@test prod(MPI.Dims_create(nnodes, (0,0,0))) == nnodes
@test prod(MPI.Dims_create(nnodes, [0,0,0])) == nnodes
@test MPI.Dims_create(nnodes, (1,0,1)) == [1, nnodes, 1]

MPI.Finalize()
@test MPI.Finalized()
