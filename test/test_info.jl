using Test
using MPI

MPI.Init()

info = MPI.Info()
@test typeof(info) == MPI.Info
@test info.val != MPI.Info
MPI.Info_set(info, "foo", "fast")
MPI.Info_set(info, "bar", "evenfaster")
@test MPI.Info_get(info, "foo" ) == "fast"
MPI.Info_delete(info, "bar")
@test MPI.Info_get(info, "bar" ) == ""
finalize(info)
@test info.val == MPI.MPI_INFO_NULL

MPI.Finalize()
