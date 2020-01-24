import Base: @deprecate

## deprecated in v0.11

@deprecate Reduce_in_place!(buf, count::Integer, op, root::Integer, comm::Comm) begin
    @assert count == length(buf)
    Reduce!(buf, op, root, comm)
end false

@deprecate Scatter_in_place!(buf, count::Integer, root::Integer, comm::Comm) begin
    if root == MPI.Comm_rank(comm)
        Scatter!(buf, nothing, count, root, comm)
    else
        Scatter!(nothing, buf, count, root, comm)        
    end
end false

@deprecate Scatterv_in_place!(buf, counts::Vector, root::Integer, comm::Comm) begin
    if root == MPI.Comm_rank(comm)
        Scatterv!(buf, nothing, counts, root, comm)
    else
        Scatterv!(nothing, buf, counts, root, comm)
    end
end false

@deprecate Gather_in_place!(buf, count::Integer, root::Integer, comm::Comm) begin
    if root == MPI.Comm_rank(comm)
        Gather!(nothing, buf, count, root, comm)
    else
        Gather!(buf, nothing, count, root, comm)
    end
end false    

@deprecate Gatherv_in_place!(buf, counts::Vector{Cint}, root::Integer, comm::Comm) begin
    if root == MPI.Comm_rank(comm)
        Gatherv!(nothing, buf, counts, root, comm)
    else
        Gatherv!(buf, nothing, counts, root, comm)
    end
end false    

@deprecate(mpitype(T), Datatype(T), false)

@deprecate(Type_Create_Subarray(ndims::Integer, sizes::MPIBuffertype{Cint}, subsizes::MPIBuffertype{Cint},
                                starts::MPIBuffertype{Cint}, order::Integer, oldtype),
           Type.create_subarray(sizes, subsizes, starts, Datatype(oldtype); rowmajor = order == MPI_ORDER_C), false)
@deprecate(Type_Create_Struct(nfields::Integer, blocklengths::MPIBuffertype{Cint},
                              displacements::MPIBuffertype{Cptrdiff_t}, types::MPIBuffertype{MPI_Datatype}),
           Type.create_struct(blocklengths, displacements, types), false)
@deprecate(Type_Commit!(datatype), Type.commit!(datatype), false)


@deprecate(Send(buf, count::Integer, datatype::Datatype, dest::Integer, tag::Integer, comm::Comm),
           Send(Buffer(buf, count, datatype), dest, tag, comm), false)
@deprecate(Send(buf::AbstractArray, count::Integer, dest::Integer, tag::Integer, comm::Comm),
           Send(view(buf, 1:count), dest, tag, comm), false)
@deprecate(Send(buf::Ref, count::Integer, dest::Integer, tag::Integer, comm::Comm),
           Send(buf, dest, tag, comm), false)

@deprecate(Isend(buf, count::Integer, datatype::Datatype, dest::Integer, tag::Integer, comm::Comm),
           Isend(Buffer(buf,count,datatype), dest, tag, comm), false)
@deprecate(Isend(buf::AbstractArray, count::Integer, dest::Integer, tag::Integer, comm::Comm),
           Isend(view(buf,1:count), dest, tag, comm), false)
@deprecate(Isend(buf::Ref, count::Integer, dest::Integer, tag::Integer, comm::Comm),
           Isend(buf, dest, tag, comm), false)

@deprecate(Recv!(buf, count::Integer, datatype::Datatype, src::Integer, tag::Integer, comm::Comm),
           Recv!(Buffer(buf, count, datatype), src, tag, comm), false)
@deprecate(Recv!(buf::AbstractArray, count::Integer, src::Integer, tag::Integer, comm::Comm),
           Recv!(view(buf, 1:count), src, tag, comm), false)
@deprecate(Recv!(buf::Ref, count::Integer, src::Integer, tag::Integer, comm::Comm),
           Recv!(buf, src, tag, comm), false)

@deprecate(Irecv!(buf, count::Integer, datatype::Datatype, src::Integer, tag::Integer, comm::Comm),           
           Irecv!(Buffer(buf,count,datatype), src, tag, comm), false)
@deprecate(Irecv!(buf::AbstractArray, count::Integer, src::Integer, tag::Integer, comm::Comm),           
           Irecv!(view(buf,1:count), src, tag, comm), false)
@deprecate(Irecv!(buf::Ref, count::Integer, src::Integer, tag::Integer, comm::Comm),           
           Irecv!(buf, src, tag, comm), false)

@deprecate(Sendrecv!(sendbuf, sendcount::Integer, sendtype,   dest::Integer, sendtag::Integer,
                     recvbuf, recvcount::Integer, recvtype, source::Integer, recvtag::Integer,
                     comm::Comm),
           Sendrecv!(Buffer(sendbuf, sendcount, sendtype), dest, sendtag,
                     Buffer(recvbuf, recvcount, recvtype), source, recvtag, comm), false)           
@deprecate(Sendrecv!(sendbuf, sendcount::Integer,   dest::Integer, sendtag::Integer,
                     recvbuf, recvcount::Integer, source::Integer, recvtag::Integer,
                     comm::Comm),
           Sendrecv!(view(sendbuf, 1:sendcount), dest, sendtag,
                     view(recvbuf, 1:recvcount), source, recvtag, comm), false)
