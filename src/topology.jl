"""
    Dims_create!(nnodes::Integer, [ndims::Integer], dims)

Create a division of `nnodes` processes in a Cartesian grid.

# External links
$(_doc_external("MPI_Dims_create"))
"""
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

"""
    comm_cart = Cart_create(comm_old::Comm, [ndims::Integer], dims, periods, reorder)

Create new MPI communicator with Cartesian structure from an existent communicator.

# External links
$(_doc_external("MPI_Cart_create"))
"""
function Cart_create(comm_old::Comm, ndims::Integer, dims::MPIBuffertype{Cint}, periods::MPIBuffertype{Cint}, reorder)
    comm_cart = Comm()
    # int MPI_Cart_create(MPI_Comm comm_old, int ndims, const int dims[],
    #                     const int periods[], int reorder, MPI_Comm *comm_cart)
    @mpichk ccall((:MPI_Cart_create, libmpi), Cint,
                  (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{MPI_Comm}),
                  comm_old, ndims, dims, periods, reorder, comm_cart)
    if comm_cart != COMM_NULL
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

"""
    rank = Cart_rank(comm::Comm, coords)

Determine process rank in communicator `comm` with Cartesian structure.
The `coords` array specifies the Cartesian coordinates of the process.

# External links
$(_doc_external("MPI_Cart_rank"))
"""
function Cart_rank(comm::Comm, coords::MPIBuffertype{Cint})
    rank = Ref{Cint}()
    # int MPI_Cart_rank(MPI_Comm comm, const int coords[], int *rank)
    @mpichk ccall((:MPI_Cart_rank, libmpi), Cint,
                  (MPI_Comm, Ptr{Cint}, Ptr{Cint}),
                  comm, coords, rank)
    Int(rank[])
end

function Cart_rank(comm::Comm, coords::AbstractArray{T}) where {T <: Integer}
    ccoords = Cint.(coords[:])
    Cart_rank(comm, ccoords)
end

"""
    dims, periods, coords = Cart_get(comm::Comm)

Obtain information on the Cartesian topology of dimension `N` underlying the 
communicator `comm`. This is specified by two `Cint` arrays of `N` elements
for the number of processes and periodicity properties along each Cartesian dimension. 
A third `Cint` array is returned, containing the Cartesian coordinates of the calling process.

# External links
$(_doc_external("MPI_Cart_get"))
"""
function Cart_get(comm::Comm)
    maxdims = Cartdim_get(comm)
    # preallocate with nontrivial values
    dims    = Cint[-1 for i = 1:maxdims]
    periods = Cint[-1 for i = 1:maxdims]
    coords  = Cint[-1 for i = 1:maxdims]
    # int MPI_Cart_get(MPI_Comm comm, int maxdims, int dims[], int periods[], int coords[])
    @mpichk ccall((:MPI_Cart_get, libmpi), Cint,
                  (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
                  comm, maxdims, dims, periods, coords)
    return dims, periods, coords
end

"""
    ndims = Cartdim_get(comm::Comm)

Return number of dimensions of the Cartesian topology associated with the communicator `comm`.

# External links
$(_doc_external("MPI_Cartdim_get"))
"""
function Cartdim_get(comm::Comm)
    dims = Ref{Cint}()
    # int MPI_Cartdim_get(MPI_Comm comm, int *ndims)
    @mpichk ccall((:MPI_Cartdim_get, libmpi), Cint,
                  (MPI_Comm, Ptr{Cint}),
                  comm, dims)
    return Int(dims[])
end

"""
    Cart_coords!(comm::Comm, rank::Integer, coords)

Determine coordinates of a given process in Cartesian communicator.

# External links
$(_doc_external("MPI_Cart_coords"))
"""
function Cart_coords!(comm::Comm, rank::Integer, coords::MPIBuffertype{Cint})
    maxdims = Cartdim_get(comm)
    # int MPI_Cart_coords(MPI_Comm comm, int rank, int maxdims, int coords[])
    @mpichk ccall((:MPI_Cart_coords, libmpi), Cint,
                  (MPI_Comm, Cint, Cint, Ptr{Cint}),
                  comm, rank, maxdims, coords)
end

"""
    Cart_coords(comm::Comm)

Determine coordinates of local process in Cartesian communicator.

See also [`Cart_coords!`](@ref).
"""
function Cart_coords(comm::Comm)
    maxdims = Cartdim_get(comm)
    ccoords = Vector{Cint}(undef, maxdims)
    rank    = Comm_rank(comm)
    Cart_coords!(comm, rank, ccoords)
    Int.(ccoords)
end

"""
    rank_source, rank_dest = Cart_shift(comm::Comm, direction::Integer, disp::Integer)

Return the source and destination ranks associated to a shift along a given
direction.

# External links
$(_doc_external("MPI_Cart_shift"))
"""
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

"""
    comm_sub = Cart_sub(comm::Comm, remain_dims)

Create lower-dimensional Cartesian communicator from existent Cartesian
topology.

`remain_dims` should be a boolean vector specifying the dimensions that should
be kept in the generated subgrid.

# External links
$(_doc_external("MPI_Cart_sub"))
"""
function Cart_sub(comm::Comm, remain_dims::MPIBuffertype{Cint})
    comm_sub = Comm()
    # int MPI_Cart_sub(MPI_Comm comm, const int remain_dims[], MPI_Comm *comm_new)
    @mpichk ccall((:MPI_Cart_sub, libmpi), Cint,
                  (MPI_Comm, Ptr{Cint}, Ptr{MPI_Comm}),
                  comm, remain_dims, comm_sub)
    if comm_sub != COMM_NULL
        finalizer(free, comm_sub)
    end
    comm_sub
end

function Cart_sub(comm::Comm, remain_dims)
    cremain_dims = [Cint(dim) for dim in remain_dims]
    Cart_sub(comm, cremain_dims)
end
