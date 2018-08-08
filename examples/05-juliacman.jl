# Note: Run this script without using `mpirun`

using MPI, Distributed
using LinearAlgebra: svd

manager = MPIManager(np=4)
addprocs(manager)

println("Added procs $(procs())")

println("Running 01-hello as part of a Julia cluster")
@mpi_do manager (include("01-hello-impl.jl"); do_hello())

# Interspersed julia parallel call
nheads = @distributed (+) for i=1:10^8
  Int(rand(Bool))
end
println("@distributed nheads $nheads")

println("Running 02-broadcast as part of a Julia cluster")
@mpi_do manager (include("02-broadcast-impl.jl"); do_broadcast())

M = [rand(10,10) for i=1:10]
pmap(svd, M)
println("pmap successful")

println("Running 03-reduce as part of a Julia cluster")
@mpi_do manager (include("03-reduce-impl.jl"); do_reduce())

pids = [remotecall_fetch(myid, p) for p in workers()]
println("julia pids $pids")

println("Running 04-sendrecv as part of a Julia cluster")
@mpi_do manager (include("04-sendrecv-impl.jl"); do_sendrecv())

println("Exiting")
exit()
