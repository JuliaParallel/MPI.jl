using Test
using MPI

MPI.Init()

comm = MPI.COMM_WORLD
grp = MPI.Comm_group(comm)
@test MPI.Comm_size(comm) == MPI.Group_size(grp)
@test MPI.Comm_rank(comm) == MPI.Group_rank(grp)
@test MPI.Group_compare(grp, grp) == MPI.IDENT
grp2 = MPI.Group_union(grp, MPI.GROUP_EMPTY)
@test MPI.Group_compare(grp, grp2) == MPI.IDENT
grp3 = MPI.Group_difference(grp, grp2)
@test MPI.Group_compare(grp3, MPI.GROUP_EMPTY) == MPI.IDENT
grp4 = MPI.Group_intersection(grp, grp2)
@test MPI.Group_compare(grp4, MPI.GROUP_EMPTY) == MPI.UNEQUAL
grp5 = MPI.Group_excl(grp, Int32[0])
@test MPI.Group_size(grp5) == MPI.Group_size(grp) - 1
grp6 = MPI.Group_incl(grp, Int32[0])
@test MPI.Group_size(grp6) == 1

# Don't free the other groups
MPI.free(grp)

MPI.Finalize()
@test MPI.Finalized()
