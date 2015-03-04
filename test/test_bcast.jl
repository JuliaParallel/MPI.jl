function bcast_array(A, root)
    comm = MPI.COMM_WORLD

    if MPI.Comm_rank(comm) == root
        B = copy(A)
    else
        B = similar(A)
    end

    MPI.Bcast!(B, root, comm)
    B
end

function test_bcast()
    root = 0

    srand(17)

    matsize = (17,17)
    for typ in ( Float32, Float64, Complex64, Complex128,
                Int8, Int16, Int32, Int64,
                Uint8, Uint16, Uint32, Uint64)
        A = rand(typ, matsize...)
        @test bcast_array(A, root) == A
    end

    # Char
    A = ['s', 't', 'a', 'r', ' ', 'w', 'a', 'r', 's']
    @test bcast_array(A, root) == A

    g = x -> x^2 + 2x - 1
    if MPI.Comm_rank(comm) == root
        f = copy(g)
    else
        f = nothing
    end
    f = MPI.bcast(f, root, comm)
    @test f(3) == g(3)
    @test f(5) == g(5)
    @test f(7) == g(7)


    A = Dict("foo" => "bar")
    if MPI.Comm_rank(comm) == root
        B = A
    else
        B = nothing
    end
    B = MPI.bcast(B, root, comm)
    @test B["foo"] == "bar"

end
