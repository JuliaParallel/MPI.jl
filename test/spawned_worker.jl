using Test
using MPI

MPI.Init()

parent_comm = MPI.Comm_get_parent()
world_comm = MPI.Intercomm_merge(parent_comm, true)
rank = MPI.Comm_rank(world_comm)

@test rank != 0

size = MPI.Comm_size(world_comm)
rank = MPI.Comm_rank(world_comm)
root = 0

val = rank == root ? size : nothing
@test MPI.Reduce(1, +, root, world_comm) == val

MPI.free(world_comm)
MPI.free(parent_comm)
MPI.Finalize()
