using Test
using MPI

MPI.Init()

comm = MPI.COMM_WORLD
nnodes = MPI.Comm_size(comm)

# setting
maxdims = 3
periods = Cint[0, 1,      0]
dims    = Cint[1, 1, nnodes]

# create
comm_cart = MPI.Cart_create(comm, maxdims, dims, periods, false)

# get info
_dims, _periods, _coords = MPI.Cart_get(comm_cart, maxdims) 

# test
@test _dims    == dims
@test _periods == periods
@test _coords  == MPI.Cart_coords(comm_cart, maxdims)

MPI.Finalize()

