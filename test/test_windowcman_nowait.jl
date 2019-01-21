using Distributed
using MPI
using Test

mgr = MPI.start_main_loop(MPI_WINDOW_NOWAIT)

comm = mgr.comm
rank = MPI.Comm_rank(comm)
size = MPI.Comm_size(comm)
@test rank == myid()-1
@test size == nprocs()

const ARRSIZE = 1024^2*100
@test ARRSIZE % size == 0
const my_arr = fill(1*(rank+1),ARRSIZE ÷ size)

function mpi_sum(arr)::Int
  mysum = 0
  for x in arr
    mysum += x
  end
  totalsum = MPI.Reduce(mysum, +, 0, comm)
  return rank == 0 ? totalsum[1] : 0
end

const sumresult = mpi_sum(my_arr)
const expected = sum((ARRSIZE ÷ size) * (1:size))
if rank == 0
  @test sumresult == expected
end
if rank == 0
  println("Timings for MPI_WINDOW_NOWAIT reduce:")
  for i in 1:5
    @time mpi_sum(my_arr)
  end
else
  for i in 1:5
    mpi_sum(my_arr)
  end
end

# Do some Julia cluster stuff
@cluster begin
  @everywhere println("test")

  for w in workers()
    @test @fetchfrom w myid() == w
  end
end

sleep(1)

# Verify that the reduce still works
if rank == 0
  println("Timing after cluster communication:")
  for i in 1:5
    @time mpi_sum(my_arr)
  end
else
  for i in 1:5
    mpi_sum(my_arr)
  end
end

MPI.stop_main_loop(mgr)
