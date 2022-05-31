include("common.jl")

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

rreq = MPI.Irecv!(recv_mesg, comm; source=src,  tag=src+32)
sreq = MPI.Isend(send_mesg, comm; dest=dst, tag=rank+32)

stats = MPI.Waitall([sreq, rreq], MPI.Status)
@test rreq isa MPI.Request
@test sreq isa MPI.Request
@test MPI.Get_source(stats[2]) == src
@test MPI.Get_tag(stats[2]) == src+32
@test MPI.Get_count(stats[2], Float64) == N
@test recv_mesg == recv_mesg_expected

@test MPI.Testall([sreq, rreq])


if size > 1
    if rank == 0
        MPI.send(send_mesg, comm; dest=dst, tag=rank+32)
        recv_mesg = recv_mesg_expected
    elseif rank == size-1
        recv_mesg = MPI.recv(comm; source=src, tag=src+32)
    else
        recv_mesg = MPI.recv(comm; source=src, tag=src+32)
        MPI.send(send_mesg, comm; dest=dst, tag=rank+32)
    end
end


if size > 1
    if rank == 0
        MPI.Send(Float64(rank), comm; dest=dst, tag=rank+32)
        recv_val = Float64(src)
    elseif rank == size-1
        recv_val = MPI.Recv(Float64, comm; source=src, tag=src+32)
    else
        recv_val = MPI.Recv(Float64, comm; source=src, tag=src+32)
        MPI.Send(Float64(rank), comm; dest=dst, tag=rank+32)
    end
end


rreq = MPI.Irecv!(recv_mesg, comm; source=src,  tag=src+32)
sreq = MPI.Isend(send_mesg, comm; dest=dst, tag=rank+32)

req_arr = [sreq,rreq]
inds = MPI.Waitsome(req_arr)
for i in inds
    global done
    done = MPI.Test(req_arr[i])
    @test done
end

rreq = MPI.Irecv!(recv_mesg, comm; source=src,  tag=src+32)
MPI.Cancel!(rreq)
MPI.Wait(rreq)
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

# construct cartesian communicator with 1D topology
comm_cart = MPI.Cart_create(comm, (comm_size,); periodic=(true,), reorder=false)

# get source and dest ranks using Cart_shift
src_rank, dest_rank = MPI.Cart_shift(comm_cart, 0, -1)

# execute left shift using subarrays
MPI.Sendrecv!(@view(a[1]), @view(a[3]), comm_cart;
        dest=dest_rank, sendtag=0, source=src_rank, recvtag=0)

@test a == [comm_rank, comm_rank, (comm_rank+1) % comm_size]

# send elements from a buffer
# ---------------------------
a = Float64[comm_rank, comm_rank, comm_rank]
b = Float64[       -1,        -1,        -1]
MPI.Sendrecv!(@view(a[1:2]), @view(b[1:2]), comm_cart;
        dest=dest_rank, sendtag=1, source=src_rank, recvtag=1)
@test b == [(comm_rank+1) % comm_size, (comm_rank+1) % comm_size, -1]

# send entire buffer
# ---------------------------
a = Float64[comm_rank, comm_rank, comm_rank]
b = Float64[       -1,        -1,        -1]
MPI.Sendrecv!(a, b,  comm_cart;
        dest=dest_rank, sendtag=2, source=src_rank, recvtag=2)

@test b == [(comm_rank+1) % comm_size, (comm_rank+1) % comm_size, (comm_rank+1) % comm_size]

@test MPI.Waitall(MPI.Request[], MPI.Status) == MPI.Status[]

MPI.Finalize()
# @test MPI.Finalized()
