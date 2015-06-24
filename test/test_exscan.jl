using Base.Test

import MPI

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

for typ in ( Float32, Float64, Complex64, Complex128,
             Int8, Int16, Int32, Int64,
             Uint8, Uint16, Uint32, Uint64)
    val = convert(typ,rank+1)
    B = MPI.ExScan(val, MPI.PROD, comm)
    if rank > 0
        @test_approx_eq B[1] factorial(rank)
    end
end

MPI.Finalize()
