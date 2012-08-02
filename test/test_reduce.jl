require("nearequal.jl")
require("test.jl")

import MPI
test_context("Testing MPI Reduce functions")
MPI.init()

test_group("reduce tests")

comm = MPI.COMM_WORLD
size = MPI.size(comm)
rank = MPI.rank(comm)

root = size-1
val = rank == root ? sum([0:size-1]) : Nothing
@test MPI.reduce(rank, MPI.SUM, root, comm) == val

val = rank == root ? size-1 : Nothing
@test MPI.reduce(rank, MPI.MAX, root, comm) == val

val = rank == root ? 0 : Nothing
@test MPI.reduce(rank, MPI.MIN, root, comm) == val

mesg = [1.0:5.0]
sum_mesg = MPI.reduce(mesg, MPI.SUM, root, comm)
sum_mesg = rank == root ? sum_mesg : size*mesg
@test isapprox(norm(sum_mesg-size*mesg), 0.0)

MPI.finalize()
