include("common.jl")

MPI.Init()

comm = MPI.COMM_WORLD
rank = MPI.Comm_rank(comm)
sz = MPI.Comm_size(comm)
filename = MPI.bcast(tempname(), 0, comm)

MPI.Barrier(comm)

# Collective write
fh = MPI.File.open(comm, filename, read=true, write=true, create=true)
@test MPI.File.get_position_shared(fh) == 0

if !MPI.File.get_atomicity(fh)
    MPI.File.set_atomicity(fh, true)
end

@test MPI.File.get_atomicity(fh)

MPI.Barrier(comm)
MPI.File.sync(fh)

header = "my header"

if rank == 0
    MPI.File.write_shared(fh, header)
end

# TODO: is there a better way to synchronise shared pointers?
MPI.Barrier(comm)
MPI.File.sync(fh)

offset = MPI.File.get_position_shared(fh)
@test offset == sizeof(header)
byte_offset = MPI.File.get_byte_offset(fh, offset)
@test byte_offset == offset

MPI.File.set_view!(fh, byte_offset, MPI.Datatype(Int64), MPI.Datatype(Int64))
MPI.Barrier(comm)
MPI.File.sync(fh)
@test MPI.File.get_position_shared(fh) == 0

MPI.Barrier(comm)
MPI.File.sync(fh)

MPI.File.write_ordered(fh, fill(Int64(rank), rank+1))
@test MPI.File.get_position_shared(fh) == sum(1:sz)

MPI.File.seek_shared(fh, 0)
@test MPI.File.get_position_shared(fh) == 0

MPI.Barrier(comm)
MPI.File.sync(fh)

buf = zeros(Int64, rank+1)
MPI.File.read_ordered!(fh, buf)
@test buf == fill(Int64(rank), rank+1)

MPI.Barrier(comm)
MPI.File.sync(fh)
@test MPI.File.get_position_shared(fh) == sum(1:sz)

MPI.File.set_view!(fh, 0, MPI.Datatype(UInt8), MPI.Datatype(UInt8))
MPI.Barrier(comm)
MPI.File.sync(fh)
MPI.File.seek_shared(fh, 0)
@test MPI.File.get_position_shared(fh) == 0

MPI.Barrier(comm)
MPI.File.sync(fh)

if rank == sz-1
    buf = Array{UInt8}(undef, sizeof(header))
    MPI.File.read_shared!(fh, buf)
    @test String(buf) == header
end

MPI.Barrier(comm)
MPI.File.sync(fh)

@test MPI.File.get_position_shared(fh) == sizeof(header)

close(fh)
