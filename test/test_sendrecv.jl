using Test
using MPI
using Compat
using Compat.LinearAlgebra

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

stats = MPI.Waitall!([sreq, rreq])
@test isequal(typeof(rreq), typeof(MPI.REQUEST_NULL))
@test isequal(typeof(sreq), typeof(MPI.REQUEST_NULL))
@test MPI.Get_source(stats[2]) == src
@test MPI.Get_tag(stats[2]) == src+32
@test isapprox(norm(recv_mesg-recv_mesg_expected), 0.0)

global (done, stats) = MPI.Testall!([sreq, rreq])
@test done
rreq = nothing
sreq = nothing
Compat.GC.gc()

if rank == 0
    MPI.send(send_mesg, dst, rank+32, comm)
    recv_mesg = recv_mesg_expected
elseif rank == size-1
    (recv_mesg, _) = MPI.recv(src, src+32, comm)
else
    (recv_mesg, _) = MPI.recv(src, src+32, comm)
    MPI.send(send_mesg, dst, rank+32, comm)
end

@test isapprox(norm(recv_mesg-recv_mesg_expected), 0.0)

rreq = nothing
sreq = nothing
Compat.GC.gc()

if rank == 0
    MPI.send(send_mesg, dst, rank+32, comm)
    recv_mesg = recv_mesg_expected
elseif rank == size-1
    (recv_mesg, _) = MPI.recv(src, src+32, comm)
else
    (recv_mesg, _) = MPI.recv(src, src+32, comm)
    MPI.send(send_mesg, dst, rank+32, comm)
end

send_mesg = Float64(rank)
recv_mesg = Array{Float64}(undef,N)
recv_mesg_expected = Array{Float64}(undef,N)

fill!(recv_mesg_expected, Float64(src))

rreq = nothing
sreq = nothing
Compat.GC.gc()

send_mesg = Float64(rank)
recv_mesg = Array{Float64}(undef,N)
recv_mesg_expected = Array{Float64}(undef,N)

fill!(recv_mesg_expected, Float64(src))

if rank == 0
    MPI.Send(send_mesg, dst, rank+32, comm)
    recv_mesg = recv_mesg_expected
elseif rank == size-1
    (recv_mesg, _) = MPI.Recv(Float64,src, src+32, comm)
else
    (recv_mesg, _) = MPI.Recv(Float64,src, src+32, comm)
    MPI.Send(send_mesg, dst, rank+32, comm)
end

rreq = nothing
sreq = nothing
Compat.GC.gc()

recv_mesg = Array{Float64}(undef,N)
rreq = MPI.Irecv!(recv_mesg, src,  src+32, comm)
sreq = MPI.Isend(send_mesg, dst, rank+32, comm)

(inds, stats) = MPI.Waitsome!([sreq, rreq])
req_arr = [sreq,rreq]
for i in inds
    global (done, status) = MPI.Test!( req_arr[i] )
    @test done 
end

rreq = nothing
sreq = nothing
Compat.GC.gc()

recv_mesg = Array{Float64}(undef,N)
sreq = MPI.Isend(send_mesg, dst, rank+32, comm)
MPI.Cancel!(sreq)
@test sreq.buffer == nothing
Compat.GC.gc()

MPI.Finalize()
