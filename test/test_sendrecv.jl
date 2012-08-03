require("nearequal.jl")
require("test.jl")

import MPI
test_context("Testing MPI Isend Irecv functions")
MPI.init()

test_group("Isend Irecv tests")

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

stats = MPI.waitall!([rreq, sreq])

@test isequal(rreq, MPI.REQUEST_NULL)
@test isequal(sreq, MPI.REQUEST_NULL)

@test stats[MPI.SOURCE,1] == src
@test stats[MPI.SOURCE,2] == rank
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
