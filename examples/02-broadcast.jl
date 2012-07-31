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

    MPI.bcast!(A, root, comm)

    printf("[%02d] A:%s\n", MPI.rank(comm), A)

    if MPI.rank(comm) == root
        B = {"foo" => "bar"}
    else
        B = Nothing
    end

    B = MPI.bcast(B, root, comm)
    printf("[%02d] B:%s\n", MPI.rank(comm), B)


    if MPI.rank(comm) == root
        f = x -> x^2 + 2x - 1
    else
        f = Nothing
    end

    f = MPI.bcast(f, root, comm)
    printf("[%02d] f(3):%d\n", MPI.rank(comm), f(3))

    MPI.finalize()
end

main()
