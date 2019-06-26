using Test
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

mutable struct NotABits
  a::Any
end

@test_throws ArgumentError MPI.mpitype(NotABits)

struct Boundary
  c::UInt16  # force some padding to be inserted
  a::Int
  b::UInt8
end

MPI.mpitype(Boundary)

arr = [Boundary( (comm_rank + i) % 127, i + comm_rank, i % 64) for i = 1:3]
req_send = MPI.Isend(arr, dest - 1, 1, MPI.COMM_WORLD)

# receive the message
arr_recv = Array{Boundary}(undef, 3)
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
struct Boundary2
  a::UInt32
  b::Tuple{Int, UInt8}
end

MPI.mpitype(Boundary2)

arr = Array{Boundary2}(undef,3)
arr_recv = Array{Boundary2}(undef,3)

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


# test a primitive type
primitive type Primitive16 16 end
primitive type Primitive24 24 end

nfields, blocklengths, displacements, types = MPI.factorPrimitiveType(Primitive16)
@test nfields == 1
@test displacements[1] == 0
@test types[1] == MPI.mpitype(Int16)
@test blocklengths[1] == 1

nfields, blocklengths, displacements, types = MPI.factorPrimitiveType(Primitive24)
@test nfields == 2
@test displacements[1] == 0
@test displacements[2] == 2
@test types[1] == MPI.mpitype(Int16)
@test types[2] == MPI.mpitype(Int8)
@test blocklengths[1] == 1
@test blocklengths[2] == 1


obj = [Ptr{Int}(comm_rank)]
obj_recv = Array{Ptr{Int}}(undef, 1)
recv_req = MPI.Irecv!(obj_recv, src - 1, 2, MPI.COMM_WORLD)
send_req = MPI.Isend(obj, dest - 1, 2, MPI.COMM_WORLD)

MPI.Wait!(recv_req)
MPI.Wait!(send_req)

@test obj_recv[1] == Ptr{Int}(src)


MPI.Barrier(MPI.COMM_WORLD)
MPI.Finalize()
@test MPI.Finalized()
