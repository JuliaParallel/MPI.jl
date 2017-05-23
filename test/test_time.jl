# test wtime and wtick

using Base.Test
using MPI

MPI.Init()

sleeptime = 1
val1 = MPI.Wtime()
sleep(sleeptime)
val2 = MPI.Wtime()

resolution = MPI.Wtick()

@test resolution > 0
@test resolution < 1  # pretty sure all clocks are have 1 second accuracy
@test val2 - val1 > sleeptime - resolution

MPI.Finalize()

