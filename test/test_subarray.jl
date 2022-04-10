using Test
using MPI

if get(ENV,"JULIA_MPI_TEST_ARRAYTYPE","") == "CuArray"
    import CUDA
    ArrayType = CUDA.CuArray
elseif get(ENV,"JULIA_MPI_TEST_ARRAYTYPE","") == "ROCArray"
    import AMDGPU
    ArrayType = AMDGPU.ROCArray
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
    req_send = MPI.Isend(@view(X[:,1]), dest, 0, comm)
    req_recv = MPI.Irecv!(Y, src, 0, comm)

    MPI.Wait!(req_send)
    MPI.Wait!(req_recv)
    
    @test Y == X[:,1] .- rank .+ src

    Y = ArrayType(zeros(2))

    req_send = MPI.Isend(Y, dest, 1, comm)
    req_recv = MPI.Irecv!(@view(X[3:4,1]), src, 1, comm)

    MPI.Wait!(req_send)
    MPI.Wait!(req_recv)

    @test X[3:4,1] == Y
end

@testset "strided" begin
    X = ArrayType(rank .+ collect(reshape(1.0:16.0, 4, 4)))
    Y = ArrayType(zeros(4))
    req_send = MPI.Isend(@view(X[2,:]), dest, 0, comm)
    req_recv = MPI.Irecv!(Y, src, 0, comm)

    MPI.Wait!(req_send)
    MPI.Wait!(req_recv)
    
    @test Y == X[2,:] .- rank .+ src

    Y = ArrayType(zeros(2))

    req_send = MPI.Isend(Y, dest, 1, comm)
    req_recv = MPI.Irecv!(@view(X[3,1:2]), src, 1, comm)

    MPI.Wait!(req_send)
    MPI.Wait!(req_recv)

    @test X[3,1:2] == Y
end

@testset "dense subarray" begin
    X = ArrayType(rank .+ collect(reshape(1.0:16.0, 4, 4)))
    Y = ArrayType(zeros(2,2))
    req_send = MPI.Isend(@view(X[2:3,3:4]), dest, 0, comm)
    req_recv = MPI.Irecv!(Y, src, 0, comm)

    MPI.Wait!(req_send)
    MPI.Wait!(req_recv)
    
    @test Y == X[2:3,3:4] .- rank .+ src

    Y = ArrayType(zeros(2,2))

    req_send = MPI.Isend(Y, dest, 1, comm)
    req_recv = MPI.Irecv!(@view(X[3:4,1:2]), src, 1, comm)

    MPI.Wait!(req_send)
    MPI.Wait!(req_recv)

    @test X[3:4,1:2] == Y
end

GC.gc()
MPI.Finalize()
@test MPI.Finalized()
