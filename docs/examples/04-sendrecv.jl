using MPI
MPI.Init()

comm = MPI.COMM_WORLD
rank = MPI.Comm_rank(comm)
size = MPI.Comm_size(comm)

dst = mod(rank+1, size)
src = mod(rank-1, size)

N = 4

send_mesg = Array{Float64}(undef, N)
recv_mesg = Array{Float64}(undef, N)

fill!(send_mesg, Float64(rank))

rreq = MPI.Irecv!(recv_mesg, src,  src+32, comm)

print("$rank: Sending   $rank -> $dst = $send_mesg\n")
sreq = MPI.Isend(send_mesg, dst, rank+32, comm)

stats = MPI.Waitall!([rreq, sreq])

print("$rank: Received $src -> $rank = $recv_mesg\n")

MPI.Barrier(comm)
