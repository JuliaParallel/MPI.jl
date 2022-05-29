using Test
using MPI

MPI.Init()

comm = MPI.COMM_WORLD
comm_rank = MPI.Comm_rank(comm)
comm_size = MPI.Comm_size(comm)

@test MPI.Comm_compare(comm, comm) == MPI.IDENT
@test comm == comm
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

splitcomm1 = MPI.Comm_split(comm, comm_rank % 2, 0)
@test div(comm_size, 2) <= MPI.Comm_size(splitcomm1) <= div(comm_size+1, 2)
@test MPI.Comm_rank(splitcomm1) == div(comm_rank, 2)

splitcomm2 = MPI.Comm_split(comm, comm_rank < 2 ? 0 : nothing, 0)
if comm_rank < 2
    @test MPI.Comm_size(splitcomm2) <= 2
    @test MPI.Comm_rank(splitcomm2) == comm_rank
else
    @test splitcomm2 == MPI.COMM_NULL
end

splitcomm3 = MPI.Comm_split_type(comm, comm_rank < 2 ? MPI.COMM_TYPE_SHARED : nothing, 0)
if comm_rank < 2
    @test MPI.Comm_size(splitcomm3) <= 2
    @test MPI.Comm_rank(splitcomm3) < 2
else
    @test splitcomm3 == MPI.COMM_NULL
end

MPI.Finalize()
@test MPI.Finalized()
