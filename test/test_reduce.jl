using Test

using MPI
using Compat.LinearAlgebra

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

root = size-1
val = rank == root ? sum(0:size-1) : nothing
@test MPI.Reduce(rank, MPI.SUM, root, comm) == val

val = rank == root ? size-1 : nothing
@test MPI.Reduce(rank, MPI.MAX, root, comm) == val

val = rank == root ? 0 : nothing
@test MPI.Reduce(rank, MPI.MIN, root, comm) == val

val = rank == root ? size : nothing
@test MPI.Reduce(1, +, root, comm) == val

mesg = collect(1.0:5.0)
sum_mesg = MPI.Reduce(mesg, MPI.SUM, root, comm)
sum_mesg = rank == root ? sum_mesg : size*mesg
@test isapprox(norm(sum_mesg-size*mesg), 0.0)

MPI.Finalize()
