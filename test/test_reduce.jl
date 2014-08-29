using Base.Test

import MPI

MPI.init()

comm = MPI.COMM_WORLD
size = MPI.size(comm)
rank = MPI.rank(comm)

root = size-1
val = rank == root ? sum([0:size-1]) : nothing
@test MPI.Reduce(rank, MPI.SUM, root, comm) == val

val = rank == root ? size-1 : nothing
@test MPI.Reduce(rank, MPI.MAX, root, comm) == val

val = rank == root ? 0 : nothing
@test MPI.Reduce(rank, MPI.MIN, root, comm) == val

mesg = [1.0:5.0]
sum_mesg = MPI.Reduce(mesg, MPI.SUM, root, comm)
sum_mesg = rank == root ? sum_mesg : size*mesg
@test isapprox(norm(sum_mesg-size*mesg), 0.0)

MPI.finalize()
