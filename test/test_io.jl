using Test
using MPI
using Random

if get(ENV,"JULIA_MPI_TEST_ARRAYTYPE","") == "CuArray"
    using CuArrays
    ArrayType = CuArray
else
    ArrayType = Array
end

MPI.Init()
comm = MPI.COMM_WORLD
rank = MPI.Comm_rank(comm)
sz = MPI.Comm_size(comm)
filename = MPI.bcast(tempname(), 0, comm)

# Write
MPI.Barrier(comm)

f = MPI.File.open(comm, filename, write=true)
MPI.File.set_view!(f, 0, MPI.Datatype(Int64), MPI.Datatype(Int64))
MPI.File.write_at(f, rank*2, ArrayType([Int64(rank+1) for i = 1:2]))
close(f)

MPI.Barrier(comm)

if rank == 0
    @test read!(filename, zeros(Int64, (2,sz))) == [j for i = 1:2, j=1:sz]
end

MPI.Barrier(comm)

f = MPI.File.open(comm, filename, write=true)
MPI.File.set_view!(f, 0, MPI.Datatype(Int64), MPI.Datatype(Int64))
MPI.File.write_at_all(f, rank*2, ArrayType([Int64(rank+1) for i = 1:2]))
close(f)

MPI.Barrier(comm)

if rank == 0
    @test read!(filename, zeros(Int64, (2,sz))) == [j for i = 1:2, j=1:sz]
end

MPI.Barrier(comm)

# Read
if rank == 0
    write(filename, [Float64(j) for i = 1:3, j = 1:sz])
end

MPI.Barrier(comm)


f = MPI.File.open(comm, filename, read=true)
MPI.File.set_view!(f, 0, MPI.Datatype(Float64), MPI.Datatype(Float64))

data = ArrayType(zeros(Float64, 3))
MPI.File.read_at!(f, rank*3, data)
@test data == Float64[rank+1 for i = 1:3]

MPI.Barrier(comm)

data = ArrayType(zeros(Float64, 3))
MPI.File.read_at_all!(f, rank*3, data)
@test data == Float64[rank+1 for i = 1:3]
