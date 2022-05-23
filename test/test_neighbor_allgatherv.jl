using Test
using MPI

MPI.Init()
try
    comm = MPI.COMM_WORLD
    size = MPI.Comm_size(comm)
    rank = MPI.Comm_rank(comm)

    sources      = Cint.(0:rank)
    destinations = Cint.(rank:(size-1))
    graph_comm = MPI.Dist_graph_create_adjacent(comm, sources, destinations)

    send = Array{Int}(undef, rank+1)
    fill!(send, rank)

    recv_count = Cint.(collect(1:(rank+1)))
    recv = Array{Int}(undef, sum(recv_count))
    fill!(recv,-1)
    
    MPI.Neighbor_allgatherv!(send, VBuffer(recv, recv_count), graph_comm)

    @test sort(recv) == [j for j ∈ 0:rank for i ∈ 0:j]
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
