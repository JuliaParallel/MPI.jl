using Base.Test
import MPI

MPI.Init()

function alltoallv_array(A, scounts::Vector{Cint}, rcounts::Vector{Cint})
    comm = MPI.COMM_WORLD
    MPI.Alltoallv(A,scounts,rcounts,comm)
end

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

for typ in ( Float32, Float64, Complex64, Complex128,
             Int8, Int16, Int32, Int64,
             Uint8, Uint16, Uint32, Uint64)
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
