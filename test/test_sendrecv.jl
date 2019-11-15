using Test
using MPI
using LinearAlgebra

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
GC.gc()

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
GC.gc()

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
GC.gc()

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
GC.gc()

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
GC.gc()

recv_mesg = Array{Float64}(undef,N)
sreq = MPI.Isend(send_mesg, dst, rank+32, comm)
MPI.Cancel!(sreq)
@test sreq.buffer == nothing
GC.gc()

# MPI_Sendrecv function
# We test this function by executing a left shift of the leftmost element in a 1D 
# cartesian topology with periodic boundary conditions.
#
# Assume we have two processors, the data will look like this
# proc 0 | proc 1
#  0 0 0 |  1 1 1
#
# After the shift the data will contain
# proc 0 | proc 1
#  0 0 1 |  1 1 0
#
# init data
comm_rank = MPI.Comm_rank(comm)
comm_size = MPI.Comm_size(comm)
a = Float64[comm_rank, comm_rank, comm_rank]

# construct subarray type
subarr_send = MPI.Type_Create_Subarray(1, Cint[3], Cint[1], Cint[0], MPI.MPI_ORDER_FORTRAN, Float64)
subarr_recv = MPI.Type_Create_Subarray(1, Cint[3], Cint[1], Cint[2], MPI.MPI_ORDER_FORTRAN, Float64)
MPI.Type_Commit!(subarr_send)
MPI.Type_Commit!(subarr_recv)

# construct cartesian communicator with 1D topology
comm_cart = MPI.Cart_create(comm, 1, Cint[comm_size], Cint[1], false)

# get source and dest ranks using Cart_shift
src_rank, dest_rank = MPI.Cart_shift(comm_cart, 0, -1)

# execute left shift using subarrays
MPI.Sendrecv(a, 1, subarr_send, dest_rank, 0,
             a, 1, subarr_recv,  src_rank, 0, comm_cart)

@test a == [comm_rank, comm_rank, (comm_rank+1) % comm_size]

MPI.Finalize()
# @test MPI.Finalized()
