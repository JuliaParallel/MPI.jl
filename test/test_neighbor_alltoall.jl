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

    send = Array{Int}(undef,rank+size)
    fill!(send, rank*rank)
    recv = collect(1:(rank+1))
    fill!(recv,-1)
    MPI.Neighbor_alltoall!(UBuffer(send,1), UBuffer(recv,1), graph_comm);

    @test sort(recv) == collect(0:rank).^2

    # Allocating variant
    recv2 = MPI.Neighbor_alltoall(UBuffer(send, 1), graph_comm)
    @test sort(recv2[1:(rank + 1)]) == collect(0:rank).^2

    # The MPI standard does not allow `MPI_IN_PLACE` in neighborhood
    # collectives, and implementations are not required to detect the error
    # (MPICH crashes with a segfault), so the wrapper rejects it.
    @test_throws ArgumentError MPI.Neighbor_alltoall!(UBuffer(fill(-1, rank + 1), 1), graph_comm)
    @test_throws ArgumentError MPI.Neighbor_alltoall!(MPI.IN_PLACE, UBuffer(fill(-1, rank + 1), 1), graph_comm)
catch e
    if isa(e, MPI.FeatureLevelError)
        @test_broken e.min_version <= MPI.Get_version()
    else
        rethrow(e)
    end
end

MPI.Finalize()
@test MPI.Finalized()
