using Base.Test

using MPI

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

root = 1

mesg = collect(1.0:5.0)
sum_mesg, request = MPI.IReduce(mesg, MPI.SUM, root, comm)
sum_mesg = rank == root ? sum_mesg : size*mesg
MPI.Wait!(request)
@test isapprox(norm(sum_mesg-size*mesg), 0.0)

mesg = collect(1.0:5.0)
_, request = MPI.IReduce!(mesg, MPI.SUM, root, comm)
sum_mesg = rank == root ? mesg : size*mesg
MPI.Wait!(request)
@test isapprox(norm(sum_mesg-size*collect(1.0:5.0)), 0.0)

MPI.Finalize()
