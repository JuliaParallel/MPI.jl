import MPI

function main()
    MPI.init()

    comm = MPI.COMM_WORLD

    MPI.barrier(comm)

    root = 0
    r = MPI.rank(comm)

    sr = MPI.Reduce(r, MPI.SUM, root, comm)

    if(MPI.rank(comm) == root)
        printf("sum of ranks: %s\n", sr)
    end

    MPI.finalize()
end

main()
