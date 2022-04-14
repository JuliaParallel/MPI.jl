# This example demonstrates one-sided communication,
# specifically activate Remote Memory Access (RMA)

using MPI

MPI.Init()
const world_sz = MPI.Comm_size(MPI.COMM_WORLD)
const rank = MPI.Comm_rank(MPI.COMM_WORLD)

# allocate memory
all_ranks = fill(-1, world_sz)
# create RMA window on all ranks
win = MPI.Win_create(all_ranks, MPI.COMM_WORLD)

#### first, let's MPI.Put on all ranks

# start the communication epoch
MPI.Win_fence(0, win)
# each rank writes to exposed windows of rank 0
# Signature: obj, target_rank, target_displacement, window
MPI.Put(rank, 0, rank, win)
# finish the communication epoch
MPI.Win_fence(0, win)
# print window content on all ranks
for j in 0:world_sz-1
    if rank == j
        println("After Put, Rank $rank:")
        @show all_ranks
    end
    MPI.Barrier(MPI.COMM_WORLD)
end
rank == 0 && println()

#### now, let's MPI.Get on all ranks

# start the communication epoch
MPI.Win_fence(0, win)
# each rank reads from exposed windows of rank 0
MPI.Get(all_ranks, 0, win)
# finish the communication epoch
MPI.Win_fence(0, win)
# print window content on all ranks
for j in 0:world_sz-1
    if rank == j
        println("After Get, Rank $rank:")
        @show all_ranks
    end
    MPI.Barrier(MPI.COMM_WORLD)
end

# free window
MPI.free(win)