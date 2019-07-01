using Test
using MPI

MPI.Init()

usize = MPI.universe_size()
@test usize === nothing || usize >= 1

MPI.Finalize()
