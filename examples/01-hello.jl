import MPI

function main()
    (myid() == 1) && MPI.Init()

    comm = MPI.COMM_WORLD

    println("Hello world, I am $(MPI.Comm_rank(comm)) of $(MPI.Comm_size(comm))")

    MPI.Barrier(comm)

    (myid() == 1) && MPI.Finalize()
end

main()
