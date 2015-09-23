using Base.Test

using MPI

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

# Not possible to PROD a Char (and neither Int8 with OpenMPI)
typs = setdiff([MPI.MPIDatatype.types...], [Char, Int8, UInt8])
for typ in typs
    val = convert(typ,rank + 1)
    B = MPI.Scan(val, MPI.PROD, comm)
    @test_approx_eq B[1] factorial(val)
end

MPI.Finalize()
