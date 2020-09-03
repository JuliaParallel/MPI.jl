using Test
using MPI
using Random

if get(ENV,"JULIA_MPI_TEST_ARRAYTYPE","") == "CuArray"
    import CUDA
    ArrayType = CUDA.CuArray
else
    ArrayType = Array
end

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

MPI.Barrier(comm)

# File Info hints
fh = MPI.File.open(comm, filename, read=true)
fh_info = MPI.File.get_info(fh)

# Test that default info hints on mpi-io implementation are present
# cb_buffer_size is one of the reserved MPI 3.1 keywords
@test parse(Int, fh_info[:cb_buffer_size]) > 0

# Test that we can attach custom info to an existing FileHandle
MPI.File.set_info!(fh, MPI.Info(:cb_buffer_size=>33554432))
fh_info = MPI.File.get_info(fh)
@test parse(Int, fh_info[:cb_buffer_size]) == 33554432
