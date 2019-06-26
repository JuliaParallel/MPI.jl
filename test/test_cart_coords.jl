using Test
using MPI

MPI.Init()
comm = MPI.COMM_WORLD
nnodes = MPI.Comm_size(comm)
ndims = 3
reorder = 1
periods = [0,1,0]
dims = [0,0,0]
MPI.Dims_create!(nnodes, dims)
comm_cart = MPI.Cart_create(comm, dims, periods, reorder)

rank = MPI.Comm_rank(comm)
ccoords = Cint[-1,-1,-1]
MPI.Cart_coords!(comm_cart, rank, ndims, ccoords)
@test all(ccoords .>= 0)
@test all(ccoords .< dims)

coords = MPI.Cart_coords(comm_cart, ndims)
@test all(coords .>= 0)
@test all(coords .< dims)

MPI.free(comm_cart)

MPI.Finalize()
# @test MPI.Finalized()
