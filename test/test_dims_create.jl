using Test
using MPI

MPI.Init()
comm = MPI.COMM_WORLD
nnodes = MPI.Comm_size(comm)
ndims = 3

cdims = Cint[0,0,0]
MPI.Dims_create!(nnodes, ndims, cdims)
@test prod(cdims) == nnodes

cdims = Cint[1,0,1]
MPI.Dims_create!(nnodes, ndims, cdims)
@test cdims == Cint[1,nnodes,1]

for dims in ([0,0,0], [0 0 0])
    MPI.Dims_create!(nnodes, dims)
    @test prod(dims) == nnodes
end

MPI.Finalize()
@test MPI.Finalized()
