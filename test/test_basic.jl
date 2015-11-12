using Base.Test
using MPI

@test !MPI.Initialized()
MPI.Init()
@test MPI.Initialized()

@test MPI.Comm(MPI.CComm(MPI.COMM_WORLD)).val == MPI.COMM_WORLD.val

@test !MPI.Finalized()
MPI.Finalize()
@test MPI.Finalized()
