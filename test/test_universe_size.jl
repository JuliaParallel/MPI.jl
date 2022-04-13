using Test
using MPI

MPI.Init()

usize = MPI.universe_size()
@test usize === nothing || usize >= 1

@test MPI.tag_ub() >= 32767

MPI.Finalize()
