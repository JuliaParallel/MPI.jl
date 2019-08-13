using Test, Pkg
using MPI

if haskey(Pkg.installed(), "CuArrays")
    using CuArrays
    ArrayType = CuArray
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
    @test typeof(C) === ArrayType{T,1}
    @test C == ArrayType{T,1}(1:size)

    # test scalar input
    A = convert(T, rank + 1)
    C = MPI.Allgather(A, comm)
    @test typeof(C) === Vector{T}
    @test C == Vector{T}(1:size)

    val = T(rank + 1)

    # Test passing output buffer with set size
    A = ArrayType(T[val])
    C = ArrayType{T}(undef, size)
    MPI.Allgather!(A, C, length(A), comm)
    @test C == ArrayType{T}(1:size)

    # Test assertion error
    C = ArrayType{T}(undef, size-1)
    @test_throws AssertionError MPI.Allgather!(A, C, length(A), comm)

    # Test explicit IN_PLACE
    C = ArrayType{T}([i == rank ? i : size + 1 for i = 0:size-1])
    MPI.Allgather!(MPI.IN_PLACE, C, 1, comm)
    @test typeof(C) === ArrayType{T,1}
    @test C == ArrayType{T}(0:size-1)

    # Test IN_PLACE
    C = ArrayType{T}([i == rank ? i : size + 1 for i = 0:size-1])
    MPI.Allgather!(C, 1, comm)
    @test typeof(C) === ArrayType{T,1}
    @test C == ArrayType{T}(0:size-1)
end

MPI.Finalize()
@test MPI.Finalized()
