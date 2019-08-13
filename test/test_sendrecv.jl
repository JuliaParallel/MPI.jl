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

sreq = MPI.Isend(send_mesg, dst, rank+32, comm)
MPI.Cancel!(sreq)
@test sreq.buffer == nothing

GC.gc()

MPI.Finalize()
@test MPI.Finalized()
