using Compat.Test
using MPI

# This uses MPI to communicate with the workers
mgr = MPI.start_main_loop(MPI.MPI_TRANSPORT_ALL)

comm = MPI.COMM_WORLD
rank = MPI.Comm_rank(comm)
size = MPI.Comm_size(comm)

refs = []
for w in workers()
    push!(refs, @spawnat w MPI.Comm_rank(MPI.COMM_WORLD))
end
ids = falses(size)
for r in refs
    id = fetch(r)
    @test !ids[id+1]
    ids[id+1] = true
end
@test ids[1] == (length(procs()) == 1)
ids[1] = true
for id in ids
    @test id
end

s = @parallel (+) for i in 1:10
    i^2
end
@test s == 385

MPI.stop_main_loop(mgr)
