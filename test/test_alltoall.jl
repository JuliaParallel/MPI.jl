using Test

using MPI

MPI.Init()
comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

for typ in Base.uniontypes(MPI.MPIDatatype)

    # Allocating version
    a = fill(convert(typ, rank),size)
    b = MPI.Alltoall(a, 1, comm)
    @test b == convert.(typ, collect(0:(size-1)))

    # Non Allocating version
    a = fill(convert(typ, rank),size)
    b = Array{typ}(undef, size*1)
    MPI.Alltoall!(a, b, 1, comm)
    @test b == convert.(typ, collect(0:(size-1)))

    # IN_PLACE version
    a = fill(convert(typ, rank),size)
    MPI.Alltoall!(MPI.IN_PLACE, a, 1, comm)
    @test a == convert.(typ, collect(0:(size-1)))

end

MPI.Finalize()
