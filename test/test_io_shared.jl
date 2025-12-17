include("common.jl")

MPI.Init()

comm = MPI.COMM_WORLD
rank = MPI.Comm_rank(comm)
sz = MPI.Comm_size(comm)
filename = MPI.bcast(tempname(), 0, comm)

# Collective write
fh = MPI.File.open(comm, filename, read=true, write=true, create=true)
@test MPI.File.get_position_shared(fh) == 0

function sync()
    # First ensure that all local changes are flushed ...
    MPI.File.sync(fh)
    # ... then wait for all other process to finish doing that ...
    MPI.Barrier(comm)
    # ... then make sure we see all changes that the other processes made.
    MPI.File.sync(fh)
end

if !MPI.File.get_atomicity(fh)
    MPI.File.set_atomicity(fh, true)
end
@test MPI.File.get_atomicity(fh)
sync()

header = "my header"

if rank == 0
    MPI.File.write_shared(fh, header)
end
sync()

offset = MPI.File.get_position_shared(fh)
@test offset == sizeof(header)
byte_offset = MPI.File.get_byte_offset(fh, offset)
@test byte_offset == offset

MPI.File.set_view!(fh, byte_offset, MPI.Datatype(Int64), MPI.Datatype(Int64))
sync()
@test MPI.File.get_position_shared(fh) == 0

MPI.File.write_ordered(fh, fill(Int64(rank), rank+1))
sync()
#TODO # TODO: this has to be fixed:
#TODO # https://github.com/JuliaParallel/MPI.jl/issues/555,
#TODO # https://github.com/JuliaParallel/MPI.jl/issues/579
#TODO @test MPI.File.get_position_shared(fh) == sum(1:sz) skip = Sys.isapple() || Sys.iswindows()
# TODO: still broken on Apple with MPICH
@test MPI.File.get_position_shared(fh) == sum(1:sz)

MPI.File.seek_shared(fh, 0)
@test MPI.File.get_position_shared(fh) == 0
sync()

buf = zeros(Int64, rank+1)
MPI.File.read_ordered!(fh, buf)
@test buf == fill(Int64(rank), rank+1)
sync()

#TODO # TODO: this has to be fixed:
#TODO # https://github.com/JuliaParallel/MPI.jl/issues/555
#TODO @test MPI.File.get_position_shared(fh) == sum(1:sz) skip = Sys.iswindows()
# TODO: still broken on Windows with MPICH
@test MPI.File.get_position_shared(fh) == sum(1:sz)

MPI.File.set_view!(fh, 0, MPI.Datatype(UInt8), MPI.Datatype(UInt8))
sync()
MPI.File.seek_shared(fh, 0)
@test MPI.File.get_position_shared(fh) == 0
sync()

if rank == sz-1
    buf = Array{UInt8}(undef, sizeof(header))
    MPI.File.read_shared!(fh, buf)
    @test String(buf) == header
end
sync()

@test MPI.File.get_position_shared(fh) == sizeof(header)

close(fh)
