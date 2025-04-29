using MPI

MPI.Init()
comm = MPI.COMM_WORLD
rank = MPI.Comm_rank(comm)
@show rank
if rank == 0
    @show MPI.Comm_size(comm)
    @show get(ENV, "MPI_LOCALNRANKS", nothing)
    @show get(ENV, "OMPI_COMM_WORLD_SIZE", nothing)
end

function main()
    MPI.Init()
    comm = MPI.COMM_WORLD
    rank = MPI.Comm_rank(comm)
    if rank == 1
        error("This is an expected error, ignore it")
    end
    MPI.Barrier(comm)
end
main()
