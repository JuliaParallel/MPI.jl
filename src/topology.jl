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

struct Unweighted 
end
Base.cconvert(::Type{Ptr{Cint}}, ::Unweighted) = Consts.MPI_UNWEIGHTED[] 
const UNWEIGHTED = Unweighted()

struct WeightsEmpty
end
Base.cconvert(::Type{Ptr{Cint}}, ::WeightsEmpty) = Consts.MPI_WEIGHTS_EMPTY[] 
const WEIGHTS_EMPTY = WeightsEmpty()

"""
    graph_comm = Dist_graph_create_adjacent(comm::Comm, sources::Vector{Cint}, destinations::Vector{Cint}; source_weights::Union{Vector{Cint}, Unweighted, WeightsEmpty}=UNWEIGHTED, destination_weights::Union{Vector{Cint}, Unweighted, WeightsEmpty}=UNWEIGHTED, reorder=false, infokws...)

Create a new communicator from a given directed graph topology, described by local incoming and outgoing edges on an existing communicator.

# Arguments
- `comm::Comm`: The communicator on which the distributed graph topology should be induced.
- `sources::Vector{Cint}`: The local, incoming edges on the rank of the calling process.
- `destinations::Vector{Cint}`: The local, outgoing edges on the rank of the calling process.
- `source_weights::Union{Vector{Cint}, Unweighted, WeightsEmpty}=MPI.UNWEIGHTED`: The edge weights of the local, incoming edges.
- `destinations_weights::Union{Vector{Cint}, Unweighted, WeightsEmpty}=MPI.UNWEIGHTED`: The edge weights of the local, outgoing edges.
- `reorder::Bool=false`: If set true, then the MPI implementation can reorder the source and destination indices.

# Example
We can generate a ring graph `1 --> 2 --> ... --> N --> 1`, where N is the number of ranks in the communicator, as follows
```julia
julia> rank = MPI.Comm_rank(comm);
julia> N = MPI.Comm_size(comm);
julia> sources = Cint[mod(rank-1, N)];
julia> destinations = Cint[mod(rank+1, N)];
julia> graph_comm = Dist_graph_create_adjacent(comm, sources, destinations);
```

# External links
$(_doc_external("MPI_Dist_graph_create_adjacent"))
"""
function Dist_graph_create_adjacent(comm::Comm, sources::Vector{Cint}, destinations::Vector{Cint}; source_weights::Union{Vector{Cint}, Unweighted, WeightsEmpty}=UNWEIGHTED, destination_weights::Union{Vector{Cint}, Unweighted, WeightsEmpty}=UNWEIGHTED, reorder=false, infokws...)
    graph_comm = Comm()
    # int MPI_Dist_graph_create_adjacent(MPI_Comm comm_old,
    #       int indegree, const int sources[],
    #       const int sourceweights[],
    #       int outdegree, const int destinations[],
    #       const int destweights[],
    #       MPI_Info info, int reorder, MPI_Comm *comm_dist_graph)
    @mpichk ccall((:MPI_Dist_graph_create_adjacent, libmpi), Cint,
        (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{Cint}, Ptr{Cint}, MPI_Info, Cint, Ptr{MPI_Comm}),
        comm,length(sources),sources,source_weights,length(destinations),destinations,destination_weights,Info(infokws...),reorder,graph_comm) v"2.2"

    return graph_comm
end

"""
    graph_comm = Dist_graph_create(comm::Comm, sources::Vector{Cint}, degrees::Vector{Cint}, destinations::Vector{Cint}; weights::Union{Vector{Cint}, Unweighted, WeightsEmpty}=UNWEIGHTED, reorder=false, infokws...)

Create a new communicator from a given directed graph topology, described by incoming and outgoing edges on an existing communicator.

# Arguments
- `comm::Comm`: The communicator on which the distributed graph topology should be induced.
- `sources::Vector{Cint}`: An array with the ranks for which this call will specify outgoing edges.
- `degrees::Vector{Cint}`: An array with the number of outgoing edges for each entry in the sources array.
- `destinations::Vector{Cint}`: An array containing with lenght of the sum of the entries in the degrees array 
                                describing the ranks towards the edges point.
- `weights::Union{Vector{Cint}, Unweighted, WeightsEmpty}=MPI.UNWEIGHTED`: The edge weights of the specified edges.
- `reorder::Bool=false`: If set true, then the MPI implementation can reorder the source and destination indices.

# Example
We can generate a ring graph `1 --> 2 --> ... --> N --> 1`, where N is the number of ranks in the communicator, as follows
```julia
julia> rank = MPI.Comm_rank(comm);
julia> N = MPI.Comm_size(comm);
julia> sources = Cint[rank];
julia> degrees = Cint[1];
julia> destinations = Cint[mod(rank-1, N)];
julia> graph_comm = Dist_graph_create(comm, sources, degrees, destinations)
```

# External links
$(_doc_external("MPI_Dist_graph_create"))
"""
function Dist_graph_create(comm::Comm, sources::Vector{Cint}, degrees::Vector{Cint}, destinations::Vector{Cint}; weights::Union{Vector{Cint}, Unweighted, WeightsEmpty}=UNWEIGHTED, reorder=false, infokws...)
    graph_comm = Comm()
    # int MPI_Dist_graph_create(MPI_Comm comm_old, int n, const int sources[],
    #       const int degrees[], const int destinations[],
    #       const int weights[],
    #       MPI_Info info, int reorder, MPI_Comm *comm_dist_graph)
    @mpichk ccall((:MPI_Dist_graph_create, libmpi), Cint,
        (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, MPI_Info, Cint, Ptr{MPI_Comm}),
        comm,length(sources),sources,degrees,destinations,weights,Info(infokws...),reorder,graph_comm) v"2.2"

    return graph_comm
end

"""
    indegree, outdegree, weighted = Dist_graph_neighbors_count(graph_comm::Comm)

Return the number of in and out edges for the calling processes in a distributed graph topology and a flag indicating whether the distributed graph is weighted.

# Arguments
- `graph_comm::Comm`: The communicator of the distributed graph topology.

# Example
Let us assume the following graph `0 <--> 1 --> 2`, which has no weights on its edges, then the
process with rank 1 will obtain the following result from calling the function

```julia-repl
julia> Dist_graph_neighbors_count(graph_comm)
(1,2,false)
```

# External links
$(_doc_external("MPI_Dist_graph_neighbors_count"))
"""
function Dist_graph_neighbors_count(graph_comm::Comm)
    indegree = Ref{Cint}()
    outdegree = Ref{Cint}()
    weighted = Ref{Cint}()
    # int MPI_Dist_graph_neighbors_count(MPI_Comm comm, int *indegree, int *outdegree, int *weighted)
    @mpichk ccall((:MPI_Dist_graph_neighbors_count, libmpi), Cint,
        (MPI_Comm, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}),
        graph_comm,indegree,outdegree,weighted) v"2.2"

    return (indegree[], outdegree[], weighted[] != 0)
end

"""
    Dist_graph_neighbors!(graph_comm::Comm, sources::Vector{Cint}, source_weights::Vector{Cint}, destinations::Vector{Cint}, destination_weights::Vector{Cint})

Return the neighbors and edge weights of the calling process in a distributed graph topology.

# Arguments
- `graph_comm::Comm`: The communicator of the distributed graph topology.
- `sources::Vector{Cint}`: A preallocated vector, which will be filled with the ranks
                        of the processes whose edges pointing towards the calling process. The
                        length is exactly the indegree returned by [`MPI.Dist_graph_neighbors_count`](@ref).
- `source_weights::Vector{Cint}`: A preallocated vector, which will be filled with the weights
                        associated to the edges pointing towards the calling process. The
                        length is exactly the indegree returned by [`MPI.Dist_graph_neighbors_count`](@ref).
- `destinations::Vector{Cint}`: A preallocated vector, which will be filled with the ranks
                        of the processes towards which the edges of the calling process point. The
                        length is exactly the outdegree returned by [`MPI.Dist_graph_neighbors_count`](@ref).
- `destination_weights::Vector{Cint}`: A preallocated vector, which will be filled with the weights
                        associated to the edges of the outgoing edges of the calling process point. The
                        length is exactly the outdegree returned by [`MPI.Dist_graph_neighbors_count`](@ref).

# Example 
Let us assume the following graph `0 <-3-> 1 -4-> 2`, then the process with rank 1 will require to
preallocate a sources vector of length 1 and a destination vector of length 2. The call will fill
the vectors as follows:

```julia-repl
julia> Dist_graph_neighbors!(graph_comm, sources, source_weights, destinations, destination_weights);
julia> sources
[0]
julia> source_weights
[3]
julia> destinations
[0,2]
julia> destination_weights
[3,4]
```

Note that the edge between ranks 0 and 1 can have a different weight depending on wether it is the 
incoming edge "`(0,1)"` or the outgoing one "`(1,0)"`. 

# External links
$(_doc_external("MPI_Dist_graph_neighbors"))
"""
function Dist_graph_neighbors!(graph_comm::Comm, sources::Vector{Cint}, source_weights::Vector{Cint}, destinations::Vector{Cint}, destination_weights::Vector{Cint})
    # int MPI_Dist_graph_neighbors(MPI_Comm comm,
    #       int maxindegree, int sources[], int sourceweights[],
    #       int maxoutdegree, int destinations[], int destweights[])
    @mpichk ccall((:MPI_Dist_graph_neighbors, libmpi), Cint,
        (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{Cint}, Ptr{Cint}),
        graph_comm,length(sources),sources,source_weights,length(destinations),destinations,destination_weights) v"2.2"
end

"""
    Dist_graph_neighbors!(graph_comm::Comm, sources::Vector{Cint}, destinations::Vector{Cint})

Return the neighbors of the calling process in a distributed graph topology without edge weights.

# Arguments
- `graph_comm::Comm`: The communicator of the distributed graph topology.
- `sources::Vector{Cint}`: A preallocated vector, which will be filled with the ranks of the 
                        processes whose edges pointing towards the calling process. The
                        length is exactly the indegree returned by [`MPI.Dist_graph_neighbors_count`](@ref).
- `destinations::Vector{Cint}`: A preallocated vector, which will be filled with the ranks
                        of the processes towards which the edges of the calling process point. The
                        length is exactly the outdegree returned by [`MPI.Dist_graph_neighbors_count`](@ref).

# Example 
Let us assume the following graph `0 <--> 1 --> 2`, then the process with rank 1 will require to
preallocate a sources vector of length 1 and a destination vector of length 2. The call will fill
the vectors as follows:

```julia-repl
julia> Dist_graph_neighbors!(graph_comm, sources, destinations);
julia> sources
[0]
julia> destinations
[0,2]
```

# External links
$(_doc_external("MPI_Dist_graph_neighbors"))
"""
function Dist_graph_neighbors!(graph_comm::Comm, sources::Vector{Cint}, destinations::Vector{Cint})
    source_weights = Array{Cint}(undef,0)
    destination_weights = Array{Cint}(undef,0)
    Dist_graph_neighbors!(graph_comm, sources::Vector{Cint}, source_weights, destinations::Vector{Cint}, destination_weights)
end
