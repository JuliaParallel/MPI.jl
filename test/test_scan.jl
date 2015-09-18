using Base.Test

using MPI

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

for typ in setdiff([MPI.MPIDatatype.types...], [Char]) # Not possible to PROD a Char
    val = convert(typ,rank + 1)
    B = MPI.Scan(val, MPI.PROD, comm)
    @test_approx_eq B[1] factorial(val)
end

MPI.Finalize()
