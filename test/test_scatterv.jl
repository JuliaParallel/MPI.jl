using Base.Test
import MPI

MPI.Init()

function scatterv_array(A, counts::Vector{Cint}, root)
    comm = MPI.COMM_WORLD
    T = eltype(A)
    if MPI.Comm_rank(comm) == root
        B = copy(A)
    else
        B = Array(T,1)
    end
    C = MPI.Scatterv(B, counts, root, comm)
end

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)
root = 0

for typ in ( Float32, Float64, Complex64, Complex128,
             Int8, Int16, Int32, Int64,
             Uint8, Uint16, Uint32, Uint64)

    A = ones(typ, 3 * div(size,2) + mod(size,2))
    counts = Cint[ mod(i,2) + 1 for i in 0:(size-1)]
    B = scatterv_array(A, counts, root)
    @test B == ones(typ, mod(rank,2) + 1)
end

MPI.Finalize()
