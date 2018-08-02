using Test
using MPI

MPI.Init()

comm = MPI.COMM_WORLD
MPI.Barrier(comm)
comm2 = MPI.Comm_dup(comm)
MPI.Barrier(comm2)
comm3 = MPI.Comm_dup(comm2)
MPI.Barrier(comm3)
MPI.Comm_free(comm2)
MPI.Barrier(comm3)
# Don't free comm2

MPI.Finalize()
