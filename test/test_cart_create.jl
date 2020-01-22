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

@test prod(dims) == nnodes

cperiods = Cint.(periods[:])
cdims = Cint.(dims[:])
comm_cart = MPI.Cart_create(comm, ndims, cdims, cperiods, reorder)
@test MPI.Comm_size(comm_cart) == nnodes

comm_cart2 = MPI.Cart_create(comm, dims, periods, reorder)
@test MPI.Comm_size(comm_cart2) == nnodes

comm_sub1 = MPI.Cart_sub(comm_cart, (false, true, true))
@test MPI.Comm_size(comm_sub1) == div(nnodes, dims[1])

comm_sub2 = MPI.Cart_sub(comm_cart, (true, false, true))
@test MPI.Comm_size(comm_sub2) == div(nnodes, dims[2])

comm_sub3 = MPI.Cart_sub(comm_cart, (true, true, false))
@test MPI.Comm_size(comm_sub3) == div(nnodes, dims[3])

comm_sub4 = MPI.Cart_sub(comm_cart, Cint[true, true, false])
@test MPI.Comm_size(comm_sub4) == MPI.Comm_size(comm_sub3)

comm_cart = comm_cart2 = comm_sub1 = comm_sub2 = comm_sub3 = comm_sub4 = nothing

GC.gc()

MPI.Finalize()
@test MPI.Finalized()
