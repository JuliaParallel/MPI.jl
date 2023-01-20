using Test
using MPI

MPI.Init()

const N = clamp(Sys.CPU_THREADS, 2, 4)

exename = joinpath(Sys.BINDIR, Base.julia_exename())
@test isfile(exename)
errors = Vector{Cint}(undef, N-1)
# Ensure using consistent flags when spawning subprocesses by using same arguments as `Base.julia_cmd`.
intercomm = MPI.Comm_spawn(exename, vcat(Base.julia_cmd()[2:end], "--startup-file=no", joinpath(@__DIR__, "spawned_worker.jl")), N-1, MPI.COMM_WORLD, errors)
@test errors == zeros(Cint,N-1)
world_comm = MPI.Intercomm_merge(intercomm, false)

size = MPI.Comm_size(world_comm)
rank = MPI.Comm_rank(world_comm)
root = 0

val = rank == root ? size : nothing
@test MPI.Reduce(1, +, root, world_comm) == val

MPI.free(world_comm)
MPI.free(intercomm)
MPI.Finalize()
@test MPI.Finalized()
