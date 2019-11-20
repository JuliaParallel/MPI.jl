using Test, Pkg
using MPI

if haskey(Pkg.installed(), "CuArrays")
    using CuArrays
    ArrayType = CuArray
else
    ArrayType = Array
end

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

dst = mod(rank+1, size)
src = mod(rank-1, size)

N = 32

send_mesg = ArrayType{Float64}(undef,N)
recv_mesg = ArrayType{Float64}(undef,N)
recv_mesg_expected = ArrayType{Float64}(undef,N)

fill!(send_mesg, Float64(rank))
fill!(recv_mesg_expected, Float64(src))

rreq = MPI.Irecv!(recv_mesg, src,  src+32, comm)
sreq = MPI.Isend(send_mesg, dst, rank+32, comm)

stats = MPI.Waitall!([sreq, rreq])
@test rreq isa MPI.Request
@test sreq isa MPI.Request
@test MPI.Get_source(stats[2]) == src
@test MPI.Get_tag(stats[2]) == src+32
@test recv_mesg == recv_mesg_expected

(done, stats) = MPI.Testall!([sreq, rreq])
@test done

if rank == 0
    MPI.send(send_mesg, dst, rank+32, comm)
    recv_mesg = recv_mesg_expected
elseif rank == size-1
    (recv_mesg, _) = MPI.recv(src, src+32, comm)
else
    (recv_mesg, _) = MPI.recv(src, src+32, comm)
    MPI.send(send_mesg, dst, rank+32, comm)
end
@test recv_mesg == recv_mesg_expected


if rank == 0
    MPI.Send(Float64(rank), dst, rank+32, comm)
    recv_val = Float64(src)
elseif rank == size-1
    (recv_val, _) = MPI.Recv(Float64, src, src+32, comm)
else
    (recv_val, _) = MPI.Recv(Float64, src, src+32, comm)
    MPI.Send(Float64(rank), dst, rank+32, comm)
end
@test recv_val == Float64(src)


rreq = MPI.Irecv!(recv_mesg, src,  src+32, comm)
sreq = MPI.Isend(send_mesg, dst, rank+32, comm)

(inds, stats) = MPI.Waitsome!([sreq, rreq])
req_arr = [sreq,rreq]
for i in inds
    (done, status) = MPI.Test!( req_arr[i] )
    @test done
end

rreq = MPI.Irecv!(recv_mesg, src,  src+32, comm)
MPI.Cancel!(rreq)
MPI.Wait!(rreq)
@test rreq.buffer == nothing

GC.gc()

# ---------------------
# MPI_Sendrecv function
# ---------------------
# 
# send datatype
# ---------------------
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
MPI.Sendrecv!(a, 1, subarr_send, dest_rank, 0,
              a, 1, subarr_recv,  src_rank, 0, comm_cart)

@test a == [comm_rank, comm_rank, (comm_rank+1) % comm_size]

# send elements from a buffer
# ---------------------------
a = Float64[comm_rank, comm_rank, comm_rank]
b = Float64[       -1,        -1,        -1]
MPI.Sendrecv!(a, 2, dest_rank, 1,
              b, 2,  src_rank, 1, comm_cart)

@test b == [(comm_rank+1) % comm_size, (comm_rank+1) % comm_size, -1]

# send entire buffer
# ---------------------------
a = Float64[comm_rank, comm_rank, comm_rank]
b = Float64[       -1,        -1,        -1]
MPI.Sendrecv!(a, dest_rank, 2,
              b,  src_rank, 2, comm_cart)

@test b == [(comm_rank+1) % comm_size, (comm_rank+1) % comm_size, (comm_rank+1) % comm_size]

MPI.Finalize()
# @test MPI.Finalized()
