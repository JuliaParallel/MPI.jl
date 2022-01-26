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
coords = MPI.Cart_coords(comm_cart)
disp = 1

for i in 0:2
    neighbors = MPI.Cart_shift(comm_cart, i, disp)
    @test all(rank ->  0 <= rank < nnodes || rank == MPI.Consts.MPI_PROC_NULL[], neighbors)
end

comm_cart = nothing
GC.gc()

MPI.Finalize()
@test MPI.Finalized()
