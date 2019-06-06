using Test
using MPI

MPI.Init()
comm = MPI.COMM_WORLD
nnodes = MPI.Comm_size(comm)
ndims = 3
reorder = 1
periods = [0 1 0]
dims = [0 0 0]
MPI.Dims_create!(nnodes, dims)

cperiods = Cint.(periods[:])
cdims = Cint.(dims[:])
comm_cart = MPI.Cart_create(comm, ndims, cdims, cperiods, reorder)
@test MPI.Comm_size(comm_cart) == nnodes

comm_cart2 = MPI.Cart_create(comm, dims, periods, reorder)
@test MPI.Comm_size(comm_cart2) == nnodes

MPI.Finalize()
#@test MPI.Finalized()
