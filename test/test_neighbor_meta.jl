using Test
using MPI

MPI.Init()

try
    comm = MPI.COMM_WORLD
    size = MPI.Comm_size(comm)
    rank = MPI.Comm_rank(comm)

    # Tests with MPI.UNWEIGHTED
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

    # Tests with MPI.WEIGHTS_EMPTY
    sources      = Cint[]
    destinations = Cint[]
    graph_comm = MPI.Dist_graph_create_adjacent(comm, sources, destinations, source_weights=MPI.WEIGHTS_EMPTY,destination_weights=MPI.WEIGHTS_EMPTY)
    indegree, outdegree, weighted = MPI.Dist_graph_neighbors_count(graph_comm)
    @test indegree == 0
    @test outdegree == 0
    @test weighted == true
catch e
    if isa(e, MPI.FeatureLevelError)
        current_version = MPI.Get_version();
        println("""Could not test '$(@__FILE__)', feature level is too low. Minimum required MPI version: $(e.min_feature_level).
               Current MPI version: $(current_version)
               """)
        @test_broken false
    else
        rethrow(e)
    end
end

MPI.Finalize()
@test MPI.Finalized()
