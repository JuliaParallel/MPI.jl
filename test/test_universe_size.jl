using Test
using MPI

MPI.Init()

universe_size = MPI.universe_size(MPI.COMM_WORLD)

@test universe_size >= 1

MPI.Finalize()
