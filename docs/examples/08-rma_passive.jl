# This example demonstrates one-sided communication,
# specifically passive Remote Memory Access (RMA)

using MPI

MPI.Init()
const world_sz = MPI.Comm_size(MPI.COMM_WORLD)
const rank = MPI.Comm_rank(MPI.COMM_WORLD)

# allocate memory
all_ranks = fill(-1, world_sz)
# create RMA window on all ranks
win = MPI.Win_create(all_ranks, MPI.COMM_WORLD)

# let each rank write its rank number into window
if rank != 0
    # lock window (MPI.LOCK_SHARED works as well)
    MPI.Win_lock(MPI.LOCK_EXCLUSIVE, 0, 0, win)
    # each rank writes to exposed windows of rank 0
    # Signature: obj, target_rank, target_displacement, window
    MPI.Put(rank, 0, rank, win)
    # finish the communication epoch
    MPI.Win_unlock(0, win)
else
    all_ranks[1] = 0
end

# wait with printing
MPI.Win_fence(0, win)

# print window content on all ranks
if rank == 0
    println("After Put with lock / unlock, window content on rank 0:")
    @show all_ranks
end

# free window
MPI.free(win)