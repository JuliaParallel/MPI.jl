include("common.jl")
using Random

MPI.Init()

comm = MPI.COMM_WORLD
rank = MPI.Comm_rank(comm)
sz = MPI.Comm_size(comm)
filename = MPI.bcast(tempname(), 0, comm)

MPI.Barrier(comm)

# Assume `data` is a subarray of a (3sz, 2sz, 5) global array that should be
# written as a contiguous block to a single file. Note that `data` is a
# discontiguous view of the global array.
data = ArrayType(rand(Float64, 3, 2, 5))
offset = (3rank, 2rank, 0)
etype = MPI.Datatype(eltype(data))
filetype = MPI.Types.create_subarray((3sz, 2sz, 5), size(data), offset, etype)
MPI.Types.commit!(filetype)

fh = MPI.File.open(comm, filename, read=true, write=true, create=true)

# Collective write
disp = 0
MPI.File.set_view!(fh, disp, etype, filetype)
MPI.File.write_all(fh, data)

# Noncollective write
disp = sizeof(data) * sz
MPI.File.set_view!(fh, disp, etype, filetype)
MPI.File.write(fh, data)

MPI.File.sync(fh)

# Noncollective read
data_read = similar(data)
disp = 0
MPI.File.set_view!(fh, disp, etype, filetype)
MPI.File.read!(fh, data_read)
@test data_read == data

# Collective read
disp = sizeof(data) * sz
fill!(data_read, 0)
MPI.File.set_view!(fh, disp, etype, filetype)
MPI.File.read_all!(fh, data_read)
@test data_read == data

close(fh)
