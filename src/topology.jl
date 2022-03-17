"""
    newdims = Dims_create(nnodes::Integer, dims)

A convenience function for selecting a balanced Cartesian grid of a total of `nnodes`
nodes, for example to use with [`MPI.Cart_create`](@ref).

`dims` is an array or tuple of integers specifying the number of nodes in each dimension.
The function returns an array `newdims` of the same length, such that if `newdims[i] =
dims[i]` if `dims[i]` is non-zero, and `prod(newdims) == nnodes`, and values `newdims` are
as close to each other as possible.

`nnodes` should be divisible by the product of the non-zero entries of `dims`.

# External links
$(_doc_external("MPI_Dims_create"))
"""
function Dims_create(nnodes::Integer, dims)
    dims = Cint[dim for dim in dims]
    @mpichk ccall((:MPI_Dims_create, libmpi), Cint,
                  (Cint, Cint, Ptr{Cint}), nnodes, length(dims), dims)
    return dims
end


"""
    comm_cart = Cart_create(comm::Comm, dims; periodic=map(_->false, dims), reorder=false)

Create new MPI communicator with Cartesian topology information attached.

`dims` is an array or tuple of integers specifying the number of MPI processes in each
coordinate direction, and `periodic` is an array or tuple of `Bool`s indicating the
periodicity of each coordinate. `prod(dims)` must be less than or equal to the size of
`comm`; if it is smaller than some processes are returned a null communicator.

If `reorder == false` then the rank of each process in the new group is identical to its
rank in the old group, otherwise the function may reorder the processes.

See also [`MPI.Dims_create`](@ref).

# External links
$(_doc_external("MPI_Cart_create"))
"""
function Cart_create(comm::Comm, dims; periodic = map(_->false, dims), reorder=false)
    if !(dims isa Array{Cint})
        dims = Cint[dim for dim in dims]
    end
    if !(periodic isa Array{Cint})
        periodic = Cint[flag for flag in periodic]
    end
    length(dims) == length(periodic) || error("dims and periodic arguments are not the same length")
    comm_cart = Comm()
    # int MPI_Cart_create(MPI_Comm comm_old, int ndims, const int dims[],
    #                     const int periods[], int reorder, MPI_Comm *comm_cart)
    @mpichk ccall((:MPI_Cart_create, libmpi), Cint,
                  (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{MPI_Comm}),
                  comm, length(dims), dims, periodic, reorder, comm_cart)
    if comm_cart != COMM_NULL
        finalizer(free, comm_cart)
    end
    comm_cart
end    

"""
    rank = Cart_rank(comm::Comm, coords)

Determine process rank in communicator `comm` with Cartesian structure.  The `coords`
array specifies the 0-based Cartesian coordinates of the process. This is the inverse of [`MPI.Cart_coords`](@ref)

# External links
$(_doc_external("MPI_Cart_rank"))
"""
function Cart_rank(comm::Comm, coords)
    if !(coords isa Vector{Cint})
        coords = Cint[coord for coord in coords]
    end
    rank = Ref{Cint}()
    # int MPI_Cart_rank(MPI_Comm comm, const int coords[], int *rank)
    @mpichk ccall((:MPI_Cart_rank, libmpi), Cint,
                  (MPI_Comm, Ptr{Cint}, Ptr{Cint}),
                  comm, coords, rank)
    Int(rank[])
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
    coords = Cart_coords(comm::Comm, rank::Integer=Comm_rank(comm))

Determine coordinates of a process with rank `rank` in the Cartesian communicator
`comm`. If no `rank` is provided, it returns the coordinates of the current process.

Returns an integer array of the 0-based coordinates. The inverse of [`Cart_rank`](@ref).

# External links
$(_doc_external("MPI_Cart_coords"))
"""
function Cart_coords(comm::Comm, rank::Integer=Comm_rank(comm))
    maxdims = Cartdim_get(comm)
    coords = Vector{Cint}(undef, maxdims)
    # int MPI_Cart_coords(MPI_Comm comm, int rank, int maxdims, int coords[])
    @mpichk ccall((:MPI_Cart_coords, libmpi), Cint,
                  (MPI_Comm, Cint, Cint, Ptr{Cint}),
                  comm, rank, maxdims, coords)
    return Int.(coords)
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
function Cart_sub(comm::Comm, remain_dims)
    if !(remain_dims isa Array{Cint})
        remain_dims = Cint[dim for dim in remain_dims]
    end
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
