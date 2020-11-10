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
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

for T in Base.uniontypes(MPI.MPIDatatype)
    # test vector input
    A = ArrayType{T}([rank + 1])
    C = MPI.Allgather(A, comm)
    @test C isa ArrayType{T,1}
    @test C == ArrayType{T,1}(1:size)

    # test scalar input
    A = convert(T, rank + 1)
    C = MPI.Allgather(A, comm)
    @test C isa Vector{T}
    @test C == Vector{T}(1:size)

    val = T(rank + 1)

    # Test passing output buffer with set size
    A = ArrayType(T[val])
    
    C = ArrayType{T}(undef, size)
    MPI.Allgather!(A, C, comm) # implied size
    @test C == ArrayType{T}(1:size)
    
    C = ArrayType{T}(undef, size)
    MPI.Allgather!(A, UBuffer(C,1), comm)
    @test C == ArrayType{T}(1:size)

    # Test assertion error
    C = ArrayType{T}(undef, size-1)
    @test_throws AssertionError MPI.Allgather!(A, C, comm)

    # Test explicit IN_PLACE
    C = ArrayType{T}([i == rank ? i : size + 1 for i = 0:size-1])
    MPI.Allgather!(MPI.IN_PLACE, UBuffer(C, 1), comm)
    @test C isa ArrayType{T,1}
    @test C == ArrayType{T}(0:size-1)

    # Test IN_PLACE
    C = ArrayType{T}([i == rank ? i : size + 1 for i = 0:size-1])
    MPI.Allgather!(UBuffer(C, 1), comm)
    @test C isa ArrayType{T,1}
    @test C == ArrayType{T}(0:size-1)
end

MPI.Finalize()
@test MPI.Finalized()
