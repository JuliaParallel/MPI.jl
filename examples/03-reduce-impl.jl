using Printf

function do_reduce()
    comm = MPI.COMM_WORLD

    MPI.Barrier(comm)

    root = 0
    r = MPI.Comm_rank(comm)

    sr = MPI.Reduce(r, MPI.SUM, root, comm)

    if(MPI.Comm_rank(comm) == root)
        @printf("sum of ranks: %s\n", sr)
    end
end
