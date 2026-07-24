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

    # The MPI standard does not allow `MPI_IN_PLACE` in neighborhood
    # collectives, so the wrapper rejects it.
    @test_throws ArgumentError MPI.Neighbor_allgather!(UBuffer(recv, 1), graph_comm)
    @test_throws ArgumentError MPI.Neighbor_allgather!(MPI.IN_PLACE, UBuffer(recv, 1), graph_comm)
catch e
    if isa(e, MPI.FeatureLevelError)
        @test_broken e.min_version <= MPI.Get_version()
    else
        rethrow(e)
    end
end

MPI.Finalize()
@test MPI.Finalized()
