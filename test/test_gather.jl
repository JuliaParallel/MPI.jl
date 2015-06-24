using Base.Test
import MPI

MPI.Init()

function gather_array(A, root)
    comm = MPI.COMM_WORLD

    B = copy(A)
    C = MPI.Gather(B, root, comm)
end

comm = MPI.COMM_WORLD
root = 0

for typ in ( Float32, Float64, Complex64, Complex128,
             Int8, Int16, Int32, Int64,
             Uint8, Uint16, Uint32, Uint64)
    A = typ[MPI.Comm_rank(comm) + 1]
    C = gather_array(A, root)
    if MPI.Comm_rank(comm) == root
        @test C == collect(1:MPI.Comm_size(comm))
    end
end

MPI.Finalize()
