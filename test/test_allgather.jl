using Base.Test
import MPI

MPI.Init()

function allgather_array(A)
    comm = MPI.COMM_WORLD

    B = copy(A)
    C = MPI.Allgather(B, comm)
end

comm = MPI.COMM_WORLD

for typ in ( Float32, Float64, Complex64, Complex128,
             Int8, Int16, Int32, Int64,
             Uint8, Uint16, Uint32, Uint64)
    A = typ[MPI.Comm_rank(comm) + 1]
    C = allgather_array(A)
    @test C == collect(1:MPI.Comm_size(comm))
end

MPI.Finalize()
