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

# `Group_rank` must report a non-member as `nothing` rather than let MPI's
# `MPI_UNDEFINED` sentinel escape as an ordinary integer.  Rank 0 is not a
# member of grp5, and every other rank is not a member of grp6.
if MPI.Comm_rank(comm) == 0
    @test MPI.Group_rank(grp5) === nothing
    @test MPI.Group_rank(grp6) == 0
else
    @test MPI.Group_rank(grp5) == MPI.Comm_rank(comm) - 1
    @test MPI.Group_rank(grp6) === nothing
end

# Don't free the other groups
MPI.free(grp)

MPI.Finalize()
@test MPI.Finalized()
