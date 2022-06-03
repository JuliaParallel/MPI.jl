include("common.jl")
using Random

MPI.Init()

comm = MPI.COMM_WORLD
rank = MPI.Comm_rank(comm)
sz = MPI.Comm_size(comm)
filename = MPI.bcast(tempname(), 0, comm)

MPI.Barrier(comm)

# Collective write
fh = MPI.File.open(comm, filename, read=true, write=true, create=true)
MPI.File.set_view!(fh, 0, MPI.Datatype(Int64), MPI.Datatype(Int64))
MPI.File.write_at_all(fh, rank*2, ArrayType([Int64(rank+1) for i = 1:2]))

MPI.File.sync(fh)

# Noncollective read
if rank == 0
    data = zeros(Int64, (2,sz))
    MPI.File.read_at!(fh, 0, data)
    @test data == [j for i = 1:2, j=1:sz]
end

MPI.File.sync(fh)
MPI.Barrier(comm)

if rank == sz-1
    MPI.File.write_at(fh, 0, ArrayType([Int64(-1) for i = 1:2]))
end

MPI.File.sync(fh)

# Collective read
data = zeros(Int64, 1)
MPI.File.read_at_all!(fh, rank*2, data)
@test data == [rank == 0 ? -1 : rank+1]
close(fh)
