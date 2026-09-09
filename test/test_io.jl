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

# `MPI_MODE_EXCL` must only ever be emitted alongside `MPI_MODE_CREATE`.

# Opening an existing file for writing without creating it must work: it must
# not silently become "fail if the file exists".
let path = MPI.bcast(tempname(), 0, comm)
    rank == 0 && Base.write(path, zeros(UInt8, 64))
    MPI.Barrier(comm)
    fh = MPI.File.open(comm, path; write=true, create=false)
    close(fh)
    MPI.Barrier(comm)
    rank == 0 && rm(path; force=true)
end

# `exclusive=true` creates the file, and fails if it is already there.
let path = MPI.bcast(tempname(), 0, comm)
    fh = MPI.File.open(comm, path; write=true, exclusive=true)
    close(fh)
    MPI.Barrier(comm)
    @test_throws MPI.MPIError MPI.File.open(comm, path; write=true, exclusive=true)
    MPI.Barrier(comm)
    # ... whereas the default is not exclusive.
    fh = MPI.File.open(comm, path; write=true, create=true)
    close(fh)
    MPI.Barrier(comm)
    rank == 0 && rm(path; force=true)
end

# `exclusive` is meaningless without creation, and must be rejected rather than
# quietly emitting `MPI_MODE_EXCL` on its own.
let path = MPI.bcast(tempname(), 0, comm)
    @test_throws ArgumentError MPI.File.open(comm, path; write=true, create=false, exclusive=true)
    @test_throws ArgumentError MPI.File.open(comm, path; read=true, exclusive=true)
end
MPI.Barrier(comm)

