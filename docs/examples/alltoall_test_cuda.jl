# This example demonstrates your MPI implementation to have the CUDA support enabled.

using MPI
using CUDA

MPI.Init()

comm = MPI.COMM_WORLD
rank = MPI.Comm_rank(comm)

size = MPI.Comm_size(comm)
dst  = mod(rank+1, size)
src  = mod(rank-1, size)
println("rank=$rank, size=$size, dst=$dst, src=$src")

N = 4

send_mesg = CuArray{Float64}(undef, N)
recv_mesg = CuArray{Float64}(undef, N)

fill!(send_mesg, Float64(rank))
CUDA.synchronize()

println("start sending...")
MPI.Sendrecv!(send_mesg, dst, 0, recv_mesg, src, 0, comm)
println("recv_mesg on proc $rank: $recv_mesg")
rank==0 && println("done.")
