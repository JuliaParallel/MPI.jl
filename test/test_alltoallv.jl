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

send_counts = Vector{Cint}(1:size)
recv_counts = fill(Cint(rank+1), size)

send_vals = collect(Iterators.flatten([1:i for i = 1:size]))
recv_vals = collect(Iterators.flatten([1:rank+1 for i = 1:size]))

for T in Base.uniontypes(MPI.MPIDatatype)
        
    A = ArrayType{T}(send_vals)

    # Allocating version
    B = MPI.Alltoallv(A, send_counts, recv_counts, comm)
    @test B isa ArrayType{T}
    @test B == ArrayType{T}(recv_vals)

    # Non Allocating version
    C = ArrayType{T}(undef, sum(recv_counts))
    MPI.Alltoallv!(A, C, send_counts, recv_counts, comm)
    @test C == ArrayType{T}(recv_vals)

    # Test assertion on wrong output buffer length
    C = ArrayType{T}(undef, sum(recv_counts)-1)
    @test_throws AssertionError MPI.Alltoallv!(A, C, send_counts, recv_counts, comm)
end

MPI.Finalize()
@test MPI.Finalized()
