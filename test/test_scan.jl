using Test

using MPI

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

# Not possible to PROD a Char (and neither Int8 with OpenMPI)
typs = setdiff([(Base.uniontypes(MPI.MPIDatatype))...], [Char, Int8, UInt8])
for typ in typs
    val = convert(typ,rank + 1)
    B = MPI.Scan(val, MPI.PROD, comm)
    @test B[1] ≈ convert(typ, prod(1:(rank+1)))
end

MPI.Finalize()
