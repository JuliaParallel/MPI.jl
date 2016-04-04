using Base.Test
using MPI

MPI.Init()

immutable Boundary
  c::UInt16  # force some padding to be inserted
  a::Int
  b::UInt8
end

MPI.Type_create_struct(Boundary)
#MPI.mpitype_dict[Boundary] = MPI.mpitype_dict[Int]
comm_size = MPI.Comm_size(MPI.COMM_WORLD)
comm_rank = MPI.Comm_rank(MPI.COMM_WORLD) + 1

arr = Array(Boundary, 3)
for i=1:3
  arr[i] = Boundary( (comm_rank + i) % 127, i + comm_rank, i % 64)
end

# send to next higher process, with wraparound
dest = (comm_rank % comm_size) + 1
req_send = MPI.Isend(arr, dest - 1, 1, MPI.COMM_WORLD)

# receive teh message
arr_recv = Array(Boundary, 3)
if comm_rank > 1
  src = comm_rank - 1
else
  src = comm_size
end

req_recv = MPI.Irecv!(arr_recv, src - 1, 1, MPI.COMM_WORLD)

MPI.Wait!(req_send)
MPI.Wait!(req_recv)

# check received array
for i=1:3
  bndry_i = arr_recv[i]
  @test bndry_i.a == src + i
  @test bndry_i.b == i % 64
  @test bndry_i.c == (src + i) % 127
end

MPI.Barrier(MPI.COMM_WORLD)
MPI.Finalize()
