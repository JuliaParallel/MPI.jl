using MPI
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
