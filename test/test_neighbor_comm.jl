using Test
using MPI

MPI.Init()

const comm = MPI.COMM_WORLD
const rank = MPI.Comm_rank(comm)
const comm_size = MPI.Comm_size(comm)

# Generate a ring graph with optional weights: 0 -> 1 -> 2 -> ... -> comm_size -> 0
const prev_rank = (rank + comm_size - 1) % comm_size
const next_rank = (rank + 1) % comm_size
function ring_graph(; weighted)
    sources = Cint[rank]
    degrees = Cint.(length.(sources))
    destinations = Cint[next_rank]
    weights = weighted ? Cint[rank + comm_size] : MPI.UNWEIGHTED
    return MPI.Dist_graph_create(comm, sources, degrees, destinations; weights=weights)
end

# Unweighted graph
let
    graph_comm = ring_graph(; weighted=false)
    indeg, outdeg, weighted = MPI.Dist_graph_neighbors_count(graph_comm)
    @test indeg == outdeg == 1
    @test !weighted
    src = Vector{Cint}(undef, indeg)
    dst = Vector{Cint}(undef, outdeg)
    MPI.Dist_graph_neighbors!(graph_comm, src, dst)
    src2, srcw2, dst2, dstw2 = MPI.Dist_graph_neighbors(graph_comm)
    @test src == src2 == Cint[prev_rank]
    @test dst == dst2 == Cint[next_rank]
    @test srcw2 === dstw2 === nothing
end

# Weighted graph
let
    graph_comm = ring_graph(; weighted=true)
    indeg, outdeg, weighted = MPI.Dist_graph_neighbors_count(graph_comm)
    @test indeg == outdeg == 1
    @test weighted
    src = Vector{Cint}(undef, indeg)
    dst = Vector{Cint}(undef, outdeg)
    MPI.Dist_graph_neighbors!(graph_comm, src, dst)
    src2 = Vector{Cint}(undef, indeg)
    srcw2 = Vector{Cint}(undef, indeg)
    dst2 = Vector{Cint}(undef, outdeg)
    dstw2 = Vector{Cint}(undef, outdeg)
    MPI.Dist_graph_neighbors!(graph_comm, src2, srcw2, dst2, dstw2)
    src3, srcw3, dst3, dstw3 = MPI.Dist_graph_neighbors(graph_comm)
    @test src == src2 == src3 == Cint[prev_rank]
    @test dst == dst2 == dst3 == Cint[next_rank]
    @test srcw2 == srcw3 == Cint[prev_rank + comm_size]
end

MPI.Finalize()
@test MPI.Finalized()
