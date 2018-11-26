using Compat
using Test
using MPI

@test !MPI.Initialized()
MPI.Init()
@test MPI.Initialized()

@test MPI.Comm(MPI.CComm(MPI.COMM_WORLD)).val == MPI.COMM_WORLD.val

if !Sys.iswindows()
    MPI.finalize_atexit()
    @test MPI.FINALIZE_ATEXIT[]
end

@test !MPI.Finalized()
MPI.Finalize()
@test MPI.Finalized()
