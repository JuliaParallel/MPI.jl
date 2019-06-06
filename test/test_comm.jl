using Test
using MPI

MPI.Init()

comm = MPI.COMM_WORLD
MPI.Barrier(comm)
comm2 = MPI.Comm_dup(comm)
MPI.Barrier(comm2)
comm3 = MPI.Comm_dup(comm2)
MPI.Barrier(comm3)
MPI.free(comm2)
MPI.Barrier(comm3)
# Don't free comm2
MPI.free(comm3)

MPI.Finalize()
@test MPI.Finalized()
