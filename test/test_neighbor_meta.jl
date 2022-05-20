using Test
using MPI

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

sources      = Cint.(0:rank)
destinations = Cint.(rank:(size-1))
graph_comm = MPI.Dist_graph_create_adjacent(comm, sources, destinations)

indegree, outdegree, weighted = MPI.Dist_graph_neighbors_count(graph_comm)
@test indegree == (rank+1)
@test outdegree == (size-rank)
@test weighted == false

incoming_edges = Vector{Cint}(undef,indegree)
outgoing_edges = Vector{Cint}(undef,outdegree)
MPI.Dist_graph_neighbors!(graph_comm, incoming_edges, outgoing_edges)

@test sort(incoming_edges) == collect(0:rank)
@test sort(outgoing_edges) == collect(rank:(size-1))

MPI.Finalize()
@test MPI.Finalized()
