using Base.Test
using MPI

@test !MPI.Initialized()
MPI.Init()
@test MPI.Initialized()

@test !MPI.Finalized()
MPI.Finalize()
@test MPI.Finalized()
