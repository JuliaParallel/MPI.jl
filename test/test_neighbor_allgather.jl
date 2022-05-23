using Test
using MPI

MPI.Init()
try
    comm = MPI.COMM_WORLD
    size = MPI.Comm_size(comm)
    rank = MPI.Comm_rank(comm)

    source = Cint[rank]
    dest = Cint.(rank:(size-1))
    degree = Cint[length(dest)]
    graph_comm = MPI.Dist_graph_create(comm, source, degree, dest)

    send = [rank*rank]
    recv = collect(1:(rank+1))
    fill!(recv,-1)
    MPI.Neighbor_allgather!(send, recv, graph_comm)

    @test sort(recv) == collect(0:rank).^2
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
