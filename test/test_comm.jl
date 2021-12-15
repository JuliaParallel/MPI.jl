using Test
using MPI

MPI.Init()

comm = MPI.COMM_WORLD
@test MPI.Comm_compare(comm, comm) == MPI.IDENT
@test MPI.Comm_compare(comm, MPI.COMM_SELF) == (MPI.Comm_size(comm) == 1 ? MPI.CONGRUENT : MPI.UNEQUAL)
MPI.Barrier(comm)
comm2 = MPI.Comm_dup(comm)
@test MPI.Comm_compare(comm, comm2) == MPI.CONGRUENT
MPI.Barrier(comm2)
comm3 = MPI.Comm_dup(comm2)
@test MPI.Comm_compare(comm, comm3) == MPI.CONGRUENT
MPI.Barrier(comm3)
MPI.free(comm2)
MPI.Barrier(comm3)
# Don't free comm2
MPI.free(comm3)

MPI.Finalize()
@test MPI.Finalized()
