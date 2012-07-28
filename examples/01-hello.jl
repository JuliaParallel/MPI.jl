import MPI

function main()
    MPI.init()

    comm = MPI.COMM_WORLD

    println("Hello world, I am $(MPI.rank(comm)) of $(MPI.size(comm))")

    MPI.barrier(comm)

    MPI.finalize()
end

main()
