using Base.Test
using MPI

MPI.Init()

#MPI.mpitype_dict[Boundary] = MPI.mpitype_dict[Int]
comm_size = MPI.Comm_size(MPI.COMM_WORLD)
comm_rank = MPI.Comm_rank(MPI.COMM_WORLD) + 1

send_arr = Int[1, 2, 3]
recv_arr = zeros(Int, 3)

MPI.Allreduce(send_arr, recv_arr, MPI.SUM, MPI.COMM_WORLD)

for i=1:3
  @test recv_arr[i] == comm_size*send_arr[i]
end


val = MPI.Allreduce(2, MPI.SUM, MPI.COMM_WORLD)
@test val == comm_size*2

vals = MPI.allreduce(send_arr, MPI.SUM, MPI.COMM_WORLD)
for i=1:3
  @test vals[i] == comm_size*send_arr[i]
end

#=
# test in-place operation
send_arr2 = Int32[1,2,3]
send_arr3 = copy(send_arr2)
MPI.Allreduce(send_arr3, MPI.SUM, MPI.COMM_WORLD)
println("send_arr2 = ", send_arr2)
println("send_arr3 = ", send_arr3)
for i=1:3
  @test send_arr3[i] == comm_size*send_arr2[i]
end
=#


MPI.Barrier( MPI.COMM_WORLD )
MPI.Finalize()
