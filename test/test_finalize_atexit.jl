using Test
using MPI

@test !MPI.Initialized()
MPI.Init()
MPI.finalize_atexit()
@test MPI.FINALIZE_ATEXIT[]

@test MPI.Initialized()
@test !MPI.Finalized()
