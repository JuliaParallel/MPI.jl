using Test
using MPI

MPI.Init()

comm_size = MPI.Comm_size(MPI.COMM_WORLD)

send_arr = Int[1, 2, 3]

for op in (MPI.SUM, +, (x,y) -> 2x+y-x)
  recv_arr = zeros(Int, 3)

  MPI.Allreduce!(send_arr, recv_arr, op, MPI.COMM_WORLD)

  for i=1:3
    @test recv_arr[i] == comm_size*send_arr[i]
  end


  val = MPI.Allreduce(2, op, MPI.COMM_WORLD)
  @test val == comm_size*2

  vals = MPI.allreduce(send_arr, op, MPI.COMM_WORLD)
  for i=1:3
    @test vals[i] == comm_size*send_arr[i]
    @test length(vals) == 3
    @test eltype(vals) == Int
  end
end

MPI.Barrier( MPI.COMM_WORLD )
MPI.Finalize()
