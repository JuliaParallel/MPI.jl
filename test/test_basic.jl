using Test
using MPI

@test !MPI.Initialized()
MPI.Init()
@test MPI.Initialized()

@test 0 <= MPI.Comm_rank(MPI.COMM_WORLD) < MPI.Comm_size(MPI.COMM_WORLD)

@test !MPI.Finalized()
MPI.Finalize()
@test MPI.Finalized()
