using Test
using MPI

if get(ENV,"JULIA_MPI_TEST_ARRAYTYPE","") == "CuArray"
    import CUDA
    ArrayType = CUDA.CuArray
else
    ArrayType = Array
end

MPI.Init()

comm = MPI.COMM_WORLD
comm_size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

dest = mod(rank+1, comm_size)
src  = mod(rank-1, comm_size)

@testset "contiguous" begin
    X = ArrayType(rank .+ collect(reshape(1.0:16.0, 4, 4)))
    Y = ArrayType(zeros(4))
    req_send = MPI.Isend(@view(X[:,1]), comm; dest=dest)
    req_recv = MPI.Irecv!(Y, comm; source=src)

    MPI.Waitall([req_send, req_recv])

    @test Y == X[:,1] .- rank .+ src

    Y = ArrayType(zeros(2))

    req_send = MPI.Isend(Y, comm; dest=dest, tag=1)
    req_recv = MPI.Irecv!(@view(X[3:4,1]), comm; source=src, tag=1)

    MPI.Waitall([req_send, req_recv])

    @test X[3:4,1] == Y
end

@testset "strided" begin
    X = ArrayType(rank .+ collect(reshape(1.0:16.0, 4, 4)))
    Y = ArrayType(zeros(4))
    req_send = MPI.Isend(@view(X[2,:]), comm; dest=dest, tag=0)
    req_recv = MPI.Irecv!(Y, comm; source=src, tag=0)

    MPI.Waitall([req_send, req_recv])

    @test Y == X[2,:] .- rank .+ src

    Y = ArrayType(zeros(2))

    req_send = MPI.Isend(Y, comm; dest=dest, tag=1)
    req_recv = MPI.Irecv!(@view(X[3,1:2]), comm; source=src, tag=1)

    MPI.Waitall([req_send, req_recv])

    @test X[3,1:2] == Y
end

@testset "dense subarray" begin
    X = ArrayType(rank .+ collect(reshape(1.0:16.0, 4, 4)))
    Y = ArrayType(zeros(2,2))
    req_send = MPI.Isend(@view(X[2:3,3:4]), comm; dest=dest, tag=0)
    req_recv = MPI.Irecv!(Y, comm; source=src, tag=0)

    MPI.Waitall([req_send, req_recv])

    @test Y == X[2:3,3:4] .- rank .+ src

    Y = ArrayType(zeros(2,2))

    req_send = MPI.Isend(Y, comm; dest=dest, tag=1)
    req_recv = MPI.Irecv!(@view(X[3:4,1:2]), comm; source=src, tag=1)

    MPI.Waitall([req_send, req_recv])

    @test X[3:4,1:2] == Y
end

GC.gc()
MPI.Finalize()
@test MPI.Finalized()
