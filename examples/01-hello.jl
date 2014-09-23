import MPI

function main()
    MPI.Init()

    comm = MPI.COMM_WORLD

    println("Hello world, I am $(MPI.Comm_rank(comm)) of $(MPI.Comm_size(comm))")

    MPI.Barrier(comm)

    MPI.Finalize()
end

main()
