include("common.jl")

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

send_counts = Vector{Cint}(1:size)
recv_counts = fill(Cint(rank+1), size)

send_vals = collect(Iterators.flatten([1:i for i = 1:size]))
recv_vals = collect(Iterators.flatten([1:rank+1 for i = 1:size]))

for T in MPITestTypes

    A = ArrayType{T}(send_vals)
    synchronize()

    # Non Allocating version
    C = ArrayType{T}(undef, sum(recv_counts))
    MPI.Alltoallv!(VBuffer(A,send_counts), VBuffer(C,recv_counts), comm)
    @test C == ArrayType{T}(recv_vals)

    # Test assertion on wrong output buffer length
    C = ArrayType{T}(undef, sum(recv_counts)-1)
    @test_throws AssertionError MPI.Alltoallv!(VBuffer(A,send_counts), VBuffer(C,recv_counts), comm)

    # Test assertion on wrong input buffer length
    C = ArrayType{T}(undef, sum(recv_counts))
    @test_throws AssertionError MPI.Alltoallv!(VBuffer(A,send_counts[1:end-1]), VBuffer(C,recv_counts), comm)

    # IN_PLACE version.  The in-place layout has to be symmetric: the block rank
    # `r` holds for peer `p` must be as long as the block rank `p` holds for `r`,
    # which `counts[j] = rank + j` satisfies.
    inplace_counts = Cint[rank + j for j in 1:size]
    inplace_data() = ArrayType{T}(collect(Iterators.flatten(
        [fill(T(rank), inplace_counts[j]) for j in 1:size])))
    expected = ArrayType{T}(collect(Iterators.flatten(
        [fill(T(j-1), rank + j) for j in 1:size])))

    D = inplace_data()
    synchronize()
    MPI.Alltoallv!(MPI.IN_PLACE, VBuffer(D, inplace_counts), comm)
    @test D == expected

    # One-argument IN_PLACE version
    D = inplace_data()
    synchronize()
    MPI.Alltoallv!(VBuffer(D, inplace_counts), comm)
    @test D == expected
end

MPI.Finalize()
@test MPI.Finalized()
