import MPI

function main()
    MPI.init()

    comm = MPI.COMM_WORLD

    if MPI.rank(comm) == 0
        println(repeat("-",78))
        println(" Running on $(MPI.size(comm)) processes")
        println(repeat("-",78))
    end

    MPI.barrier(comm)

    N = 5
    root = 0

    if MPI.rank(comm) == root
        A = [1:N] * (1.0 + im*2.0)
    else
        A = Array(Complex128, N)
    end

    MPI.bcast(A, root, comm)

    printf("[%02d] %s\n", MPI.rank(comm), A)

    MPI.finalize()
end

main()
