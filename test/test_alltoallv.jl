using Base.Test
using MPI

MPI.Init()

function alltoallv_array(A, scounts::Vector{Cint}, rcounts::Vector{Cint})
    comm = MPI.COMM_WORLD
    MPI.Alltoallv(A,scounts,rcounts,comm)
end

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

for typ in MPI.MPIDatatype.types
    A = typ[]
    B = typ[]
    for i in 1:size
        A = vcat(A,convert(Vector{typ},collect(1:i)))
        B = vcat(B,convert(Vector{typ},collect(1:(rank+1))))
    end
    scounts = convert(Vector{Cint}, collect(1:size))
    rcounts = fill(convert(Cint,rank + 1),size)
    C = alltoallv_array(A, scounts, rcounts)
    @test B == C
end

MPI.Finalize()
