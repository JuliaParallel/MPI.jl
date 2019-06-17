using Test
using MPI

MPI.Init()

function alltoallv_array(A, scounts::Vector{Cint}, rcounts::Vector{Cint})
    comm = MPI.COMM_WORLD
    MPI.Alltoallv(A,scounts,rcounts,comm)
end

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

for typ in Base.uniontypes(MPI.MPIDatatype)
    A = typ[]
    B = typ[]
    for i in 1:size
        A = vcat(A,convert(Vector{typ},collect(1:i)))
        B = vcat(B,convert(Vector{typ},collect(1:(rank+1))))
    end
    scounts = convert(Vector{Cint}, collect(1:size))
    rcounts = fill(convert(Cint,rank + 1),size)

    # Allocating version
    C = alltoallv_array(A, scounts, rcounts)
    @test B == C

    # Non Allocating version
    C = Array{typ}(undef, sum(rcounts))
    MPI.Alltoallv!(A, C, scounts, rcounts, comm)
    @test B == C

    # Test assertion on wrong output buffer length
    C = Array{typ}(undef, sum(rcounts)-1)
    @test_throws AssertionError MPI.Alltoallv!(A, C, scounts, rcounts, comm)
end

MPI.Finalize()
@test MPI.Finalized()
