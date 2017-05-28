using Base.Test
using MPI

MPI.Init()

#MPI.mpitype_dict[Boundary] = MPI.mpitype_dict[Int]
comm_size = MPI.Comm_size(MPI.COMM_WORLD)
comm_rank = MPI.Comm_rank(MPI.COMM_WORLD) + 1

# send to next higher process, with wraparound
dest = (comm_rank % comm_size) + 1
if comm_rank > 1
  src = comm_rank - 1
else
  src = comm_size
end


# test simple type 

type NotABits
  a::Any
end

@test_throws ArgumentError MPI.mpitype(NotABits)

immutable Boundary
  c::UInt16  # force some padding to be inserted
  a::Int
  b::UInt8
end

MPI.mpitype(Boundary)

arr = Array(Boundary, 3)
for i=1:3
  arr[i] = Boundary( (comm_rank + i) % 127, i + comm_rank, i % 64)
end

req_send = MPI.Isend(arr, dest - 1, 1, MPI.COMM_WORLD)

# receive the message
arr_recv = Array(Boundary, 3)
req_recv = MPI.Irecv!(arr_recv, src - 1, 1, MPI.COMM_WORLD)

MPI.Wait!(req_send)
MPI.Wait!(req_recv)

# check received array
for i=1:3
  bndry_i = arr_recv[i]
  @test bndry_i.a == (src + i)
  @test bndry_i.b == i % 64
  @test bndry_i.c == (src + i) % 127
end


# test nested types
immutable Boundary2
  a::UInt32
  b::Tuple{Int, UInt8}
end

MPI.mpitype(Boundary2)

arr = Array(Boundary2, 3)
arr_recv = Array(Boundary2, 3)

for i=1:3
  arr[i] = Boundary2( (comm_rank + i) % 127, ( Int(i + comm_rank), UInt8(i % 64) ) )
end

req_send = MPI.Isend(arr, dest - 1, 1, MPI.COMM_WORLD)
req_recv = MPI.Irecv!(arr_recv, src - 1, 1, MPI.COMM_WORLD)

MPI.Wait!(req_send)
MPI.Wait!(req_recv)

# check received array
for i=1:3
  bndry_i = arr_recv[i]
  @test bndry_i.a == (src + i) % 127
  @test bndry_i.b[1] == (src + i)
  @test bndry_i.b[2] == (i % 64)
end



MPI.Barrier(MPI.COMM_WORLD)
MPI.Finalize()
