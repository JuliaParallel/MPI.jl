include("common.jl")

# Syncing parallel MPI I/O is a bit involved:
function sync(comm, fh)
    # First ensure that all local changes are flushed ...
    MPI.File.sync(fh)
    # ... then wait for all other process to finish doing that ...
    MPI.Barrier(comm)
    # ... then make sure we see all changes that the other processes made.
    MPI.File.sync(fh)
end

# Find MPI vendor
library_version = MPI.Get_library_version()
# Peel off MPItrampoline if present
if startswith(library_version, "MPIwrapper ")
    library_version = join(split(library_version, "\n")[2:end], "\n")
end
if startswith(library_version, "MPICH ")
    vendor = :MPICH
elseif startswith(library_version, "Open MPI ")
    vendor = :OpenMPI
else
    vendor = nothing
end

MPI.Init()

comm = MPI.COMM_WORLD
rank = MPI.Comm_rank(comm)
sz = MPI.Comm_size(comm)
filename = MPI.bcast(tempname(), 0, comm)

# Collective write
fh = MPI.File.open(comm, filename, read=true, write=true, create=true)
@test MPI.File.get_position_shared(fh) == 0

if !MPI.File.get_atomicity(fh)
    MPI.File.set_atomicity(fh, true)
end
@test MPI.File.get_atomicity(fh)
sync(comm, fh)

header = "my header"

if rank == 0
    MPI.File.write_shared(fh, header)
end
sync(comm, fh)

offset = MPI.File.get_position_shared(fh)
@test offset == sizeof(header)
byte_offset = MPI.File.get_byte_offset(fh, offset)
@test byte_offset == offset

MPI.File.set_view!(fh, byte_offset, MPI.Datatype(Int64), MPI.Datatype(Int64))
sync(comm, fh)
# https://github.com/JuliaParallel/MPI.jl/issues/555
# https://github.com/JuliaParallel/MPI.jl/issues/879
@test MPI.File.get_position_shared(fh) == 0 skip = Sys.isapple() || (vendor == :MPICH && Sys.isunix()) || Sys.iswindows()

MPI.File.write_ordered(fh, fill(Int64(rank), rank+1))
sync(comm, fh)
# https://github.com/JuliaParallel/MPI.jl/issues/879
@test MPI.File.get_position_shared(fh) == sum(1:sz) skip = Sys.isapple()

MPI.File.seek_shared(fh, 0)
@test MPI.File.get_position_shared(fh) == 0
sync(comm, fh)

buf = zeros(Int64, rank+1)
MPI.File.read_ordered!(fh, buf)
@test buf == fill(Int64(rank), rank+1)
sync(comm, fh)

# https://github.com/JuliaParallel/MPI.jl/issues/555
@test MPI.File.get_position_shared(fh) == sum(1:sz) skip = Sys.iswindows()

MPI.File.set_view!(fh, 0, MPI.Datatype(UInt8), MPI.Datatype(UInt8))
sync(comm, fh)
MPI.File.seek_shared(fh, 0)
@test MPI.File.get_position_shared(fh) == 0
sync(comm, fh)

if rank == sz-1
    buf = Array{UInt8}(undef, sizeof(header))
    MPI.File.read_shared!(fh, buf)
    @test String(buf) == header
end
sync(comm, fh)

@test MPI.File.get_position_shared(fh) == sizeof(header)

close(fh)
