using Test

using MPI
using Compat.LinearAlgebra

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

root = size-1
val = rank == root ? sum(0:size-1) : nothing
@test MPI.Reduce(rank, MPI.SUM, root, comm) == val

val = rank == root ? size-1 : nothing
@test MPI.Reduce(rank, MPI.MAX, root, comm) == val

val = rank == root ? 0 : nothing
@test MPI.Reduce(rank, MPI.MIN, root, comm) == val

val = rank == root ? size : nothing
@test MPI.Reduce(1, +, root, comm) == val

mesg = collect(1.0:5.0)
sum_mesg = MPI.Reduce(mesg, MPI.SUM, root, comm)
sum_mesg = rank == root ? sum_mesg : size*mesg
@test isapprox(norm(sum_mesg-size*mesg), 0.0)

# For comparison with the clustermanager version
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
  println("Timings for MPI reduce:")
  @time expected == mpi_sum(my_arr)
  @time expected == mpi_sum(my_arr)
  @time expected == mpi_sum(my_arr)
else
  mpi_sum(my_arr)
  mpi_sum(my_arr)
  mpi_sum(my_arr)
end


MPI.Finalize()
