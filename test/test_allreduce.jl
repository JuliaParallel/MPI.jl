using Base.Test

using MPI

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

val = sum(0:size-1)
@test MPI.Allreduce(rank, MPI.SUM, comm) == val

val = size-1
@test MPI.Allreduce(rank, MPI.MAX, comm) == val

val = 0
@test MPI.Allreduce(rank, MPI.MIN, comm) == val

mesg = collect(1.0:5.0)
sum_mesg = MPI.Allreduce(mesg, MPI.SUM, comm)
@test isapprox(norm(sum_mesg-size*mesg), 0.0)

mesg = collect(1.0:5.0)
req, sum_mesg = MPI.Iallreduce(mesg, MPI.SUM, comm)
MPI.Wait!(req)
sum_mesg = sum_mesg
@test isapprox(norm(sum_mesg-size*mesg), 0.0)

MPI.Finalize()
