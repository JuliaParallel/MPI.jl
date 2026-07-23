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
    # collectives, so implementations are expected to error, but the error
    # must come from the MPI library, not from the Julia wrapper.
    @test try
        MPI.Neighbor_alltoall!(UBuffer(fill(-1, rank + 1), 1), graph_comm)
        true
    catch e
        if e isa MPI.MPIError
            true
        else
            io = IOBuffer()
            Base.showerror(io, e)
            @error String(take!(io))
            false
        end
    end
catch e
    if isa(e, MPI.FeatureLevelError)
        @test_broken e.min_version <= MPI.Get_version()
    else
        rethrow(e)
    end
end

MPI.Finalize()
@test MPI.Finalized()
