function Dims_create!(nnodes::Integer, ndims::Integer, dims::MPIBuffertype{T}) where {T <: Integer}
    # int MPI_Dims_create(int nnodes, int ndims, int dims[])
    @mpichk ccall((:MPI_Dims_create, libmpi), Cint,
                  (Cint, Cint, Ptr{Cint}), nnodes, ndims, dims)
end

function Dims_create!(nnodes::Integer, dims::AbstractArray{T,N}) where {T<:Integer, N}
    cdims = Cint.(dims[:])
    ndims = length(cdims)
    Dims_create!(nnodes, ndims, cdims)
    dims[:] .= cdims
end

function Cart_create(comm_old::Comm, ndims::Integer, dims::MPIBuffertype{Cint}, periods::MPIBuffertype{Cint}, reorder)
    comm_cart = Comm()
    # int MPI_Cart_create(MPI_Comm comm_old, int ndims, const int dims[],
    #                     const int periods[], int reorder, MPI_Comm *comm_cart)
    @mpichk ccall((:MPI_Cart_create, libmpi), Cint,
                  (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{MPI_Comm}),
                  comm_old, ndims, dims, periods, reorder, comm_cart)
    if comm_cart.val != MPI_COMM_NULL
        refcount_inc()
        finalizer(free, comm_cart)
    end
    comm_cart
end

function Cart_create(comm_old::Comm, dims::AbstractArray{T,N}, periods::Array{T,N}, reorder) where T <: Integer where N
    cdims    = Cint.(dims[:])
    cperiods = Cint.(periods[:])
    ndims    = length(cdims)
    Cart_create(comm_old, ndims, cdims, cperiods, reorder)
end

function Cart_coords!(comm::Comm, rank::Integer, maxdims::Integer, coords::MPIBuffertype{Cint})
    # int MPI_Cart_coords(MPI_Comm comm, int rank, int maxdims, int coords[])
    @mpichk ccall((:MPI_Cart_coords, libmpi), Cint,
                  (MPI_Comm, Cint, Cint, Ptr{Cint}),
                  comm, rank, maxdims, coords)
end

function Cart_coords(comm::Comm, maxdims::Integer)
    ccoords = Vector{Cint}(undef, maxdims)
    rank    = Comm_rank(comm)
    Cart_coords!(comm, rank, maxdims, ccoords)
    Int.(ccoords)
end

function Cart_shift(comm::Comm, direction::Integer, disp::Integer)
    rank_source = Ref{Cint}()
    rank_dest   = Ref{Cint}()
    # int MPI_Cart_shift(MPI_Comm comm, int direction, int disp,
    #                    int *rank_source, int *rank_dest)
    @mpichk ccall((:MPI_Cart_shift, libmpi), Cint,
                  (MPI_Comm, Cint, Cint, Ptr{Cint}, Ptr{Cint}),
                  comm, direction, disp, rank_source, rank_dest)
    Int(rank_source[]), Int(rank_dest[])
end
