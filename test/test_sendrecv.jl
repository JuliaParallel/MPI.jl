using Base.Test
import MPI

MPI.init()

comm = MPI.COMM_WORLD
size = MPI.size(comm)
rank = MPI.rank(comm)

dst = mod(rank+1, size)
src = mod(rank-1, size)

N = 32

send_mesg = Array(Float64, N)
recv_mesg = Array(Float64, N)
recv_mesg_expected = Array(Float64, N)

fill!(send_mesg, float64(rank))
fill!(recv_mesg_expected, float64(src))

rreq = MPI.Irecv!(recv_mesg, src,  src+32, comm)
sreq = MPI.Isend!(send_mesg, dst, rank+32, comm)

stats = MPI.waitall!([sreq, rreq])
@test isequal(typeof(rreq), typeof(MPI.REQUEST_NULL))
@test isequal(typeof(sreq), typeof(MPI.REQUEST_NULL))

@test stats[MPI.SOURCE,2] == src
@test stats[MPI.TAG,2] == src+32
@test isapprox(norm(recv_mesg-recv_mesg_expected), 0.0)

rreq = Nothing
sreq = Nothing
gc()

if rank == 0
    MPI.send(send_mesg, dst, rank+32, comm)
    recv_mesg = recv_mesg_expected
elseif rank == size-1
    recv_mesg = MPI.recv(src, src+32, comm)
else
    recv_mesg = MPI.recv(src, src+32, comm)
    MPI.send(send_mesg, dst, rank+32, comm)
end

@test isapprox(norm(recv_mesg-recv_mesg_expected), 0.0)

MPI.finalize()
