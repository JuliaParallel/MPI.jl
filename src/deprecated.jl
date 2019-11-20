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
