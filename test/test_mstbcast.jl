using Test
using MPI
using Random

function MSTBcast(x, root, left, right, comm)
    me = MPI.Comm_rank(comm)
    tag = 999

    if left == right
        return x
    end
    mid = (left + right) ÷ 2
    dest = root ≤ mid ? right : left

    if me == root
        MPI.send(x, dest, tag, comm)
    end
    if me == dest
        (x, _) = MPI.recv(root, tag, comm)
    end

    if me ≤ mid && root ≤ mid
        MSTBcast(x, root, left, mid, comm)
    elseif me ≤ mid && root > mid
        MSTBcast(x, dest, left, mid, comm)
    elseif me > mid && root ≤ mid
        MSTBcast(x, dest, mid + 1, right, comm)
    elseif me > mid && root > mid
        MSTBcast(x, root, mid + 1, right, comm)
    end
end

let
    MPI.Init()

    comm = MPI.COMM_WORLD
    root = 0
    left = 0
    right = MPI.Comm_size(comm) - 1

    if get(ENV,"JULIA_MPI_TEST_ARRAYTYPE","") == "CuArray"
        import CUDA
        ArrayType = CUDA.CuArray
    else
        ArrayType = Array
    end

    Random.seed!(17)
    matsize = (17,17)

    for T in Base.uniontypes(MPI.MPIDatatype)
        A = ArrayType(rand(T, matsize))
        B = MPI.Comm_rank(comm) == root ? A : nothing
        B = MSTBcast(B, root, left, right, comm)
        @test B == A
    end

    g = x -> x^2 + 2x - 1
    f = MPI.Comm_rank(comm) == root ? g : nothing
    f = MSTBcast(f, root, left, right, comm)
    @test f(3) == g(3)
    @test f(5) == g(5)
    @test f(7) == g(7)

    A = Dict("foo" => "bar")
    B = MPI.Comm_rank(comm) == root ? A : nothing
    B = MSTBcast(B, root, left, right, comm)
    @test B["foo"] == "bar"

    MPI.Finalize()
    @test MPI.Finalized()
end
