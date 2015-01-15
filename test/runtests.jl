using Base.Test
using MPI

import MPI

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

rank == 0 && println("Testing bcast...")
include("test_bcast.jl")
test_bcast()

rank == 0 && println("Testing reduce...")
include("test_reduce.jl")
test_reduce()

rank == 0 && println("Testing sendrecv...")
include("test_sendrecv.jl")
test_sendrecv()

MPI.Finalize()
