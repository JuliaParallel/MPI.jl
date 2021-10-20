using Test
using MPI

# TODO: enable CUDA tests once OpenMPI has full support
ArrayType = Array

MPI.Init()

comm = MPI.COMM_WORLD

const rank = MPI.Comm_rank(comm)
const N = MPI.Comm_size(comm)

buf = ArrayType{Int}(fill(Int(rank),N))
received = ArrayType{Int}(fill(-1,N))

# Test Get using fence
win = MPI.Win_create(buf, comm)
MPI.Win_fence(win)
MPI.Get!(received, win; rank=(rank+1)%N)
MPI.Win_fence(win)

@test received == ArrayType{Int}(fill(Int(rank+1)%N, size(received)))

# Test locked window
if rank != 0
  MPI.Win_lock(win; rank=0, type=:exclusive)
  received[1] = rank
  MPI.Put!(view(received,1:1), win; rank=0, disp=rank)
  MPI.Win_unlock(win; rank=0)
else
  buf[1] = 0
end

MPI.Win_fence(win)

if rank == 0
  @test buf == collect(0:N-1)
end

MPI.Barrier(comm)

if rank == 1
  MPI.Win_lock(win; rank=1, type=:exclusive)
  fill!(buf,3)
  MPI.Win_unlock(win; rank=1)
end

MPI.Barrier(comm)

if rank == 0
  MPI.Win_lock(win; rank=0, type=:exclusive)
  fill!(buf, 2)
  MPI.Win_unlock(win; rank=0)
  MPI.Win_lock(win; rank=1, type=:exclusive)
  result = similar(buf)
  MPI.Get_accumulate!(buf, result, MPI.SUM, win; rank=1)
  MPI.Win_unlock(win; rank=1)
  @test all(result .== 3)
end

MPI.Barrier(comm)

if rank == 1
  MPI.Win_lock(win; rank=1, type=:exclusive)
  @test all(buf .== 5)
  fill!(buf,-2)
  MPI.Win_unlock(win; rank=1)
  MPI.Win_lock(win; rank=0, type=:exclusive)
  MPI.Accumulate!(buf, MPI.SUM, win; rank=0)
  MPI.Win_unlock(win; rank=0)
  MPI.Win_lock(win; rank=1, type=:exclusive)
  fill!(buf,1)
  MPI.Win_unlock(win; rank=1)
end

MPI.Barrier(comm)

if rank == 0
  MPI.Win_lock(win; rank=0, type=:exclusive)
  @test all(buf .== 0)
  MPI.Win_unlock(win; rank=0)
end

MPI.Barrier(comm)
MPI.free(win)
MPI.Barrier(comm)

# Try a dynamic window
win = MPI.Win_create_dynamic(comm)
MPI.Win_attach!(win, buf)

address_buf = Vector{Cptrdiff_t}(undef, 1)
address_win = MPI.Win_create(address_buf, comm)

# Address for dynamic window is global instead of relative to the start of the buffer, so we need to share it
MPI.Win_lock(address_win; rank=rank, type=:exclusive)
address_buf[1] = MPI.Get_address(buf)
MPI.Win_unlock(address_win; rank=rank)

MPI.Barrier(comm)

# Test atomic operation
if rank == 0
  received = Ref(0)
  to_send = Ref(0)
  for r in 0:N-1
    address = Ref{Cptrdiff_t}(0)
    MPI.Win_lock(address_win; rank=r, type=:exclusive)
    MPI.Get!(address, address_win; rank=r)
    MPI.Win_flush(address_win; rank=r)
    to_send[] = r+5
    MPI.Win_lock(win; rank=r, type=:exclusive)
    MPI.Fetch_and_op!(to_send, received, MPI.REPLACE, win; rank=r, disp=address[]+r*sizeof(Int))
    MPI.Win_flush(win; rank=r)
    @test received[] == r
    MPI.Win_unlock(win; rank=r)
    MPI.Win_unlock(address_win; rank=r)
  end
end

MPI.Barrier(comm)

@test buf[rank+1] == rank+5

MPI.Barrier(comm)
MPI.Win_detach!(win, buf)
MPI.free(win)
MPI.free(address_win)

MPI.Finalize()
@test MPI.Finalized()
