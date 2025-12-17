confirm
# This example demonstrates your CUDA-aware MPI implementation can use multiple Nvidia GPUs (one GPU per rank)

using MPI
using CUDA

MPI.Init()

comm = MPI.COMM_WORLD
rank = MPI.Comm_rank(comm)

# select device (specifically relevant if >1 GPU per node)
# using node-local communicator to retrieve node-local rank
comm_l = MPI.Comm_split_type(comm, MPI.COMM_TYPE_SHARED, rank)
rank_l = MPI.Comm_rank(comm_l)

# select device
gpu_id = CUDA.device!(rank_l)
# using default device if the scheduler exposes different GPU per rank (e.g. SLURM `--gpus-per-task=1`)
# gpu_id = CUDA.device!(0)

size = MPI.Comm_size(comm)
dst  = mod(rank+1, size)
src  = mod(rank-1, size)
println("rank=$rank rank_loc=$rank_l (gpu_id=$gpu_id), size=$size, dst=$dst, src=$src")

N = 4

send_mesg = CuArray{Float64}(undef, N)
recv_mesg = CuArray{Float64}(undef, N)

fill!(send_mesg, Float64(rank))
CUDA.synchronize()

rank==0 && println("start sending...")
MPI.Sendrecv!(send_mesg, dst, 0, recv_mesg, src, 0, comm)
println("recv_mesg on proc $rank_l: $recv_mesg")
rank==0 && println("done.")
