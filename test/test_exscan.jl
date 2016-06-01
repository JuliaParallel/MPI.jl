using Base.Test

using MPI

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

# Not possible to PROD a Char (and neither Int8 with OpenMPI)
typs = setdiff([MPI.MPIDatatype.types...], [Char, Int8, UInt8])
for typ in typs
    val = convert(typ,rank+1)
    B = MPI.ExScan(val, MPI.PROD, comm)
    if rank > 0
        @test_approx_eq B[1] factorial(rank)
    end
    req, C = MPI.IExScan(val, MPI.PROD, comm)
    MPI.Wait!(req)
    if rank > 0
        @test_approx_eq C[1] factorial(rank)
    end
end

MPI.Finalize()
