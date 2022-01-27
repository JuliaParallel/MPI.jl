using Test
using MPI

MPI.Init()
comm = MPI.COMM_WORLD
nnodes = MPI.Comm_size(comm)
ndims = 3
reorder = 1
periods = [0,1,0]
dims = MPI.Dims_create(nnodes, [0,0,0])
comm_cart = MPI.Cart_create(comm, dims; periodic=periods, reorder=reorder)

for k = 1:dims[3], j = 1:dims[2], i = 1:dims[1]
    cart_coords = [i, j, k] .- 1  # zero-based location
    cart_rank = MPI.Cart_rank(comm_cart, cart_coords)
    @test 0 <= cart_rank < nnodes

    coords_check = MPI.Cart_coords(comm_cart, cart_rank)
    @test all(cart_coords .== coords_check)
end

MPI.free(comm_cart)

MPI.Finalize()
