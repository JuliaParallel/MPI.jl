using MPI
function main()
    MPI.Init()
    comm = MPI.COMM_WORLD
    rank = MPI.Comm_rank(comm)
    if rank == 1
        error("Goodbye")
    end
    MPI.Barrier(comm)
end
main()
