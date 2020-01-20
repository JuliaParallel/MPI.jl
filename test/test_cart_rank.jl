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

coords_check = Cint[-1, -1, -1]

for k = 1:dims[3], j = 1:dims[2], i = 1:dims[1]
    cart_coords = [i, j, k] .- 1  # zero-based location
    cart_rank = MPI.Cart_rank(comm_cart, cart_coords)
    @test cart_rank >= 0
    @test cart_rank < nnodes

    MPI.Cart_coords!(comm_cart, cart_rank, coords_check)
    @test all(cart_coords .== coords_check)
end

MPI.free(comm_cart)

MPI.Finalize()
