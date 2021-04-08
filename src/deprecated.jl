import Base: @deprecate


## deprecated in v0.16

@deprecate(Bcast!(buffer, count::Integer, root::Integer, comm::Comm),
           Bcast!(view(buffer, 1:count), root, comm), false)

@deprecate(Scatter!(sendbuf, recvbuf, count::Integer, root::Integer, comm::Comm),
           Scatter!(UBuffer(sendbuf, count), recvbuf, root, comm), false)
@deprecate(Scatter!(sendbuf, recvbuf::AbstractArray, count::Integer, root::Integer, comm::Comm),
           Scatter!(UBuffer(sendbuf, count), view(recvbuf, 1:count), root, comm), false)
@deprecate(Scatter!(sendbuf, recvbuf::Nothing, count::Integer, root::Integer, comm::Comm),
           Scatter!(UBuffer(sendbuf, count), MPI.IN_PLACE, root, comm), false)
@deprecate(Scatter!(sendbuf::Nothing, recvbuf, count::Integer, root::Integer, comm::Comm),
           Scatter!(nothing, recvbuf, root, comm), false)
@deprecate(Scatter!(sendbuf::Nothing, recvbuf::AbstractArray, count::Integer, root::Integer, comm::Comm),
           Scatter!(nothing, view(recvbuf, 1:count), root, comm), false)

@deprecate(Scatter(sendbuf, count::Integer, root::Integer, comm::Comm),
           MPI.Comm_rank(comm) == root ?
           Scatter!(UBuffer(sendbuf, count), similar(sendbuf, count), root, comm) :
           Scatter!(nothing, similar(sendbuf, count), root, comm), false)

@deprecate(Scatterv!(sendbuf, recvbuf, counts::Vector, root::Integer, comm::Comm),
           MPI.Comm_rank(comm) == root ?
           Scatterv!(VBuffer(sendbuf, counts), recvbuf, root, comm) :
           Scatterv!(nothing, recvbuf, root, comm), false)
@deprecate(Scatterv!(sendbuf, recvbuf::AbstractArray, counts::Vector, root::Integer, comm::Comm),
           MPI.Comm_rank(comm) == root ?
           Scatterv!(VBuffer(sendbuf, counts), view(recvbuf,1:counts[MPI.Comm_rank(comm)+1]), root, comm) :
           Scatterv!(nothing, view(recvbuf,1:counts[MPI.Comm_rank(comm)+1]), root, comm), false)
@deprecate(Scatterv!(sendbuf, recvbuf::Nothing, counts::Vector, root::Integer, comm::Comm),
           MPI.Comm_rank(comm) == root ?
           Scatterv!(VBuffer(sendbuf, counts), MPI.IN_PLACE, root, comm) :
           Scatterv!(nothing, MPI.IN_PLACE, root, comm), false)
@deprecate(Scatterv!(sendbuf::Nothing, recvbuf, counts::Vector, root::Integer, comm::Comm),
           Scatterv!(nothing, recvbuf, root, comm), false)
@deprecate(Scatterv!(sendbuf::Nothing, recvbuf::AbstractArray, counts::Vector, root::Integer, comm::Comm),
           Scatterv!(nothing, view(recvbuf,1:counts[MPI.Comm_rank(comm)+1]), root, comm), false)

@deprecate(Scatterv(sendbuf, counts::Vector, root::Integer, comm::Comm),
           MPI.Comm_rank(comm) == root ?
           Scatterv!(VBuffer(sendbuf, counts), similar(sendbuf, counts[Comm_rank(comm) + 1]), root, comm) :
           Scatterv!(nothing, similar(sendbuf, counts[Comm_rank(comm) + 1]), root, comm), false)

@deprecate(Gather!(sendbuf, recvbuf, count::Integer, root::Integer, comm::Comm),
           Gather!(sendbuf, MPI.Comm_rank(comm) == root ? UBuffer(recvbuf, count) : nothing, root, comm), false)
@deprecate(Gather!(sendbuf::AbstractArray, recvbuf, count::Integer, root::Integer, comm::Comm),
           Gather!(view(sendbuf, 1:count), MPI.Comm_rank(comm) == root ? UBuffer(recvbuf, count) : nothing, root, comm), false)
@deprecate(Gather!(sendbuf::Nothing, recvbuf, count::Integer, root::Integer, comm::Comm),
           Gather!(MPI.IN_PLACE, UBuffer(recvbuf, count), root, comm), false)
@deprecate(Gather!(sendbuf, recvbuf::Nothing, count::Integer, root::Integer, comm::Comm),
           Gather!(sendbuf, nothing, root, comm), false)
@deprecate(Gather!(sendbuf::AbstractArray, recvbuf::Nothing, count::Integer, root::Integer, comm::Comm),
           Gather!(view(sendbuf, 1:count), nothing, root, comm), false)

@deprecate(Gather(sendbuf, count::Integer, root::Integer, comm::Comm),
           Gather(sendbuf, root, comm), false)
@deprecate(Gather(sendbuf::AbstractArray, count::Integer, root::Integer, comm::Comm),
           Gather(view(sendbuf, 1:count), root, comm), false)

@deprecate(Gatherv!(sendbuf, recvbuf, counts::Vector{Cint}, root::Integer, comm::Comm),
           Gatherv!(sendbuf, MPI.Comm_rank(comm) == root ? VBuffer(recvbuf, counts) : nothing, root, comm), false)
@deprecate(Gatherv!(sendbuf::AbstractArray, recvbuf, counts::Vector{Cint}, root::Integer, comm::Comm),
           Gatherv!(view(sendbuf,1:counts[MPI.Comm_rank(comm)+1]), MPI.Comm_rank(comm) == root ? VBuffer(recvbuf, counts) : nothing, root, comm), false)
@deprecate(Gatherv!(sendbuf::Nothing, recvbuf, counts::Vector{Cint}, root::Integer, comm::Comm),
           Gatherv!(MPI.IN_PLACE, VBuffer(recvbuf, counts), root, comm), false)
@deprecate(Gatherv!(sendbuf, recvbuf::Nothing, counts::Vector{Cint}, root::Integer, comm::Comm),
           Gatherv!(sendbuf, nothing, root, comm), false)
@deprecate(Gatherv!(sendbuf::AbstractArray, recvbuf::Nothing, counts::Vector{Cint}, root::Integer, comm::Comm),
           Gatherv!(view(sendbuf,1:counts[MPI.Comm_rank(comm)+1]), nothing, root, comm), false)

@deprecate(Gatherv(sendbuf, counts::Vector{Cint}, root::Integer, comm::Comm),
           Gatherv!(sendbuf, Comm_rank(comm) == root ? VBuffer(similar(sendbuf, sum(counts)), counts) : nothing, root, comm), false)
@deprecate(Gatherv(sendbuf::AbstractArray, counts::Vector{Cint}, root::Integer, comm::Comm),
           Gatherv!(view(sendbuf,1:counts[MPI.Comm_rank(comm)+1]), Comm_rank(comm) == root ? VBuffer(similar(sendbuf, sum(counts)), counts) : nothing, root, comm), false)

@deprecate(Allgather!(sendbuf, recvbuf, count::Integer, comm::Comm),
           Allgather!(sendbuf, UBuffer(recvbuf, count), comm::Comm), false)
@deprecate(Allgather!(sendbuf::AbstractArray, recvbuf, count::Integer, comm::Comm),
           Allgather!(view(sendbuf,1:count), UBuffer(recvbuf, count), comm::Comm), false)
@deprecate(Allgather!(sendbuf::Nothing, recvbuf, count::Integer, comm::Comm),
           Allgather!(MPI.IN_PLACE, UBuffer(recvbuf, count), comm::Comm), false)
@deprecate(Allgather!(sendrecvbuf, count::Integer, comm::Comm),
           Allgather!(UBuffer(sendrecvbuf, count), comm), false)

@deprecate(Allgather(sendbuf, count::Integer, comm::Comm),
           Allgather(view(sendbuf, 1:count), comm), false)

@deprecate(Allgatherv!(sendbuf, recvbuf, counts::Vector{Cint}, comm::Comm),
           Allgatherv!(sendbuf, VBuffer(recvbuf, counts), comm), false)
@deprecate(Allgatherv!(sendbuf::AbstractArray, recvbuf, counts::Vector{Cint}, comm::Comm),
           Allgatherv!(view(sendbuf,1:counts[MPI.Comm_rank(comm)+1]), VBuffer(recvbuf, counts), comm), false)
@deprecate(Allgatherv!(sendrecvbuf, counts::Vector{Cint}, comm::Comm),
           Allgatherv!(VBuffer(sendrecvbuf, counts), comm), false)

@deprecate(Allgatherv(sendbuf, counts::Vector{Cint}, comm::Comm),
           Allgatherv!(sendbuf, VBuffer(similar(sendbuf, sum(counts)), counts), comm), false)

@deprecate(Alltoall!(sendbuf, recvbuf, count::Integer, comm::Comm),
           Alltoall!(UBuffer(sendbuf, count), UBuffer(recvbuf, count), comm), false)
@deprecate(Alltoall!(sendbuf::InPlace, recvbuf, count::Integer, comm::Comm),
           Alltoall!(sendbuf, UBuffer(recvbuf, count), comm), false)
@deprecate(Alltoall!(sendrecvbuf, count::Integer, comm::Comm),
           Alltoall!(UBuffer(sendrecvbuf, count), comm), false)

@deprecate(Alltoall(sendbuf, count::Integer, comm::Comm),
           Alltoall(UBuffer(sendbuf, count), comm), false)

@deprecate(Alltoallv!(sendbuf, recvbuf, sendcounts, recvcounts, comm::Comm),
           Alltoallv!(VBuffer(sendbuf, sendcounts), VBuffer(recvbuf, recvcounts), comm), false)

@deprecate(Alltoallv(buf, sendcounts, recvcounts, comm::Comm),
           Alltoallv!(VBuffer(buf, sendcounts), VBuffer(similar(buf,sum(recvcounts)), recvcounts), comm), false)

@deprecate(Reduce!(send::AbstractArray, recv::AbstractArray, count::Integer, op, root::Integer, comm::Comm),
           Reduce!(view(send, 1:count), view(recv, 1:count), op, root, comm), false)
@deprecate(Reduce!(send, recv::AbstractArray, count::Integer, op, root::Integer, comm::Comm),
           Reduce!(send, view(recv, 1:count), op, root, comm), false)
@deprecate(Reduce!(send::AbstractArray, recv, count::Integer, op, root::Integer, comm::Comm),
           Reduce!(view(send, 1:count), recv, op, root, comm), false)
@deprecate(Reduce!(send, recv, count::Integer, op, root::Integer, comm::Comm),
           Reduce!(send, recv, op, root, comm), false)
@deprecate(Reduce!(sendrecvbuf::AbstractArray, count::Integer, op, root::Integer, comm::Comm),
           Reduce!(view(sendrecvbuf, 1:count), op, root, comm), false)
@deprecate(Reduce!(sendrecvbuf, count::Integer, op, root::Integer, comm::Comm),
           Reduce!(sendrecvbuf, op, root, comm), false)

@deprecate(Allreduce!(send::AbstractArray, recv::AbstractArray, count::Integer, op, comm::Comm),
           Allreduce!(view(send, 1:count), view(recv, 1:count), op, comm), false)
@deprecate(Allreduce!(send, recv::AbstractArray, count::Integer, op, comm::Comm),
           Allreduce!(send, view(recv, 1:count), op, comm), false)
@deprecate(Allreduce!(send::AbstractArray, recv, count::Integer, op, comm::Comm),
           Allreduce!(view(send, 1:count), recv, op, comm), false)
@deprecate(Allreduce!(send, recv, count::Integer, op, comm::Comm),
           Allreduce!(send, recv, op, comm), false)
@deprecate(Allreduce!(sendrecvbuf::AbstractArray, count::Integer, op, comm::Comm),
           Allreduce!(view(sendrecvbuf, 1:count), op, comm), false)
@deprecate(Allreduce!(sendrecvbuf, count::Integer, op, comm::Comm),
           Allreduce!(sendrecvbuf, op, comm), false)

@deprecate(Scan!(sendbuf::AbstractArray, recvbuf::AbstractArray, count::Integer, op, comm::Comm),
           Scan!(view(sendbuf, 1:count), view(recvbuf, 1:count), op, comm), false)
@deprecate(Scan!(sendbuf, recvbuf::AbstractArray, count::Integer, op, comm::Comm),
           Scan!(sendbuf, view(recvbuf, 1:count), op, comm), false)
@deprecate(Scan!(sendbuf::AbstractArray, recvbuf, count::Integer, op, comm::Comm),
           Scan!(view(sendbuf, 1:count), recvbuf, op, comm), false)
@deprecate(Scan!(sendbuf, recvbuf, count::Integer, op, comm::Comm),
           Scan!(sendbuf, recvbuf, op, comm), false)
@deprecate(Scan!(sendrecvbuf::AbstractArray, count::Integer, op, comm::Comm),
           Scan!(view(sendrecvbuf, 1:count), op, comm), false)
@deprecate(Scan!(sendrecvbuf, count::Integer, op, comm::Comm),
           Scan!(sendrecvbuf, op, comm), false)

@deprecate(Exscan!(sendbuf::AbstractArray, recvbuf::AbstractArray, count::Integer, op, comm::Comm),
           Exscan!(view(sendbuf, 1:count), view(recvbuf, 1:count), op, comm), false)
@deprecate(Exscan!(sendbuf, recvbuf::AbstractArray, count::Integer, op, comm::Comm),
           Exscan!(sendbuf, view(recvbuf, 1:count), op, comm), false)
@deprecate(Exscan!(sendbuf::AbstractArray, recvbuf, count::Integer, op, comm::Comm),
           Exscan!(view(sendbuf, 1:count), recvbuf, op, comm), false)
@deprecate(Exscan!(sendbuf, recvbuf, count::Integer, op, comm::Comm),
           Exscan!(sendbuf, recvbuf, op, comm), false)
@deprecate(Exscan!(sendrecvbuf::AbstractArray, count::Integer, op, comm::Comm),
           Exscan!(view(sendrecvbuf, 1:count), op, comm), false)
@deprecate(Exscan!(sendrecvbuf, count::Integer, op, comm::Comm),
           Exscan!(sendrecvbuf, op, comm), false)


@deprecate(Get(origin_buffer, count::Integer, target_rank::Integer, target_disp::Integer, win::Win),
           Get(view(origin_buffer, 1:count), target_rank, target_disp, win), false)
@deprecate(Put(origin_buffer, count::Integer, target_rank::Integer, target_disp::Integer, win::Win),
           Put(view(origin_buffer, 1:count), target_rank, target_disp, win), false)
@deprecate(Accumulate(origin_buffer, count::Integer, target_rank::Integer, target_disp::Integer, op::Op, win::Win),
           Accumulate(view(origin_buffer, 1:count), target_rank, target_disp, op, win), false)
@deprecate(Get_accumulate(origin_buffer, result_buffer, count::Integer, target_rank::Integer, target_disp::Integer, op::Op, win::Win),
           Get_accumulate(view(origin_buffer,1:count), view(result_buffer,1:count), target_rank, target_disp, op, win), false)
