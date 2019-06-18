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
coords = MPI.Cart_coords(comm_cart, ndims)
disp = 1

for i in 0:2
    neighbors = MPI.Cart_shift(comm_cart, i, disp)
    @test all( ((neighbors .>= 0) .& (neighbors .< nnodes)) .| (neighbors .== MPI.MPI_PROC_NULL) )
end

MPI.Finalize()
#@test MPI.Finalized()
