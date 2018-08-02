using Compat
using Test
using MPI

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

dst = mod(rank+1, size)
src = mod(rank-1, size)

N = 32

send_mesg = Array{Float64}(undef,N)
recv_mesg = Array{Float64}(undef,N)
recv_mesg_expected = Array{Float64}(undef,N)
fill!(send_mesg, Float64(rank))
fill!(recv_mesg_expected, Float64(src))

rreq = MPI.Irecv!(recv_mesg, src,  src+32, comm)
sreq = MPI.Isend(send_mesg, dst, rank+32, comm)

(ind,stats) = MPI.Waitsome!([sreq, rreq])
(done, ind, stats) = MPI.Testany!([sreq, rreq])
arr = [sreq,rreq]
if done
    (onedone,stats) = MPI.Test!(arr[ind])
    @test onedone
end

MPI.Finalize()
