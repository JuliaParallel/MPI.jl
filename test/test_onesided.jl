using Compat
using Test
using MPI

MPI.Init()

comm = MPI.COMM_WORLD

const rank = MPI.Comm_rank(comm)
const N = MPI.Comm_size(comm)

win = MPI.Win()
buf = fill(Int(rank),N)
received = fill(-1,N)

# Test Get using fence
MPI.Win_create(buf, MPI.INFO_NULL, comm, win)
MPI.Win_fence(0, win)
MPI.Get(received, (rank+1)%N, win)
MPI.Win_fence(0, win)

@test received == fill(Int(rank+1)%N, size(received))

# Test locked window
if rank != 0
  MPI.Win_lock(MPI.LOCK_EXCLUSIVE, 0, 0, win)
  received[1] = rank
  MPI.Put(received, 1, 0, rank, win)
  MPI.Win_unlock(0, win)
else
  buf[1] = 0
end

MPI.Win_fence(0, win)

if rank == 0
  @test buf == collect(0:N-1)
end

MPI.Barrier(comm)

if rank == 1
  MPI.Win_lock(MPI.LOCK_EXCLUSIVE, 1, 0, win)
  fill!(buf,3)
  MPI.Win_unlock(1,win)
end

MPI.Barrier(comm)

if rank == 0
  MPI.Win_lock(MPI.LOCK_EXCLUSIVE, 0, 0, win)
  fill!(buf, 2)
  MPI.Win_unlock(0,win)
  MPI.Win_lock(MPI.LOCK_EXCLUSIVE, 1, 0, win)
  result = similar(buf)
  MPI.Get_accumulate(buf, result, length(buf), 1, 0, MPI.SUM, win)
  MPI.Win_unlock(1,win)
  @test all(result .== 3)
end

MPI.Barrier(comm)

if rank == 1
  MPI.Win_lock(MPI.LOCK_EXCLUSIVE, 1, 0, win)
  @test all(buf .== 5)
  fill!(buf,-2)
  MPI.Win_unlock(1,win)
  MPI.Win_lock(MPI.LOCK_EXCLUSIVE, 0, 0, win)
  MPI.Accumulate(buf, length(buf), 0, 0, MPI.SUM, win)
  MPI.Win_unlock(0,win)
  MPI.Win_lock(MPI.LOCK_EXCLUSIVE, 1, 0, win)
  fill!(buf,1)
  MPI.Win_unlock(1,win)
end

MPI.Barrier(comm)

if rank == 0
  MPI.Win_lock(MPI.LOCK_EXCLUSIVE, 0, 0, win)
  @test all(buf .== 0)
  MPI.Win_unlock(0,win)
end

MPI.Barrier(comm)
MPI.Win_free(win)
MPI.Barrier(comm)

# Try a dynamic window
MPI.Win_create_dynamic(MPI.INFO_NULL, comm, win)
MPI.Win_attach(win, buf)

address_win = MPI.Win()
address_buf = Vector{Cptrdiff_t}(undef, 1)
MPI.Win_create(address_buf, MPI.INFO_NULL, comm, address_win)

# Address for dynamic window is global instead of relative to the start of the buffer, so we need to share it
MPI.Win_lock(MPI.LOCK_EXCLUSIVE, rank, 0, address_win)
address_buf[1] = MPI.Get_address(buf)
MPI.Win_unlock(rank, address_win)

MPI.Barrier(comm)

# Test atomic operation
if rank == 0
  received = Ref(0)
  to_send = Ref(0)
  for r in 0:N-1
    address = Ref{Cptrdiff_t}(0)
    MPI.Win_lock(MPI.LOCK_EXCLUSIVE, r, 0, address_win)
    MPI.Get(address, r, address_win)
    MPI.Win_flush(r, address_win)
    to_send[] = r+5
    MPI.Win_lock(MPI.LOCK_EXCLUSIVE, r, 0, win)
    MPI.Fetch_and_op(to_send, received, r, address[]+r*sizeof(Int), MPI.REPLACE, win)
    MPI.Win_flush(r, win)
    @test received[] == r
    MPI.Win_unlock(r, win)
    MPI.Win_unlock(r, address_win)
  end
end

MPI.Barrier(comm)

@test buf[rank+1] == rank+5

MPI.Barrier(comm)
MPI.Win_detach(win, buf)
MPI.Win_free(win)
MPI.Finalize()
