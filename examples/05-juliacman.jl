using MPI

manager=MPIManager(np=4)
addprocs(manager)

@everywhere using MPI
mpi_init(manager)

println("Running 01-hello as part of a Julia cluster")
@mpi_do  include("01-hello.jl")

#Interspersed julia parallel call
nheads = @parallel (+) for i=1:10^8
  int(rand(Bool))
end
println("@parallel nheads $nheads")

println("Running 02-broadcast as part of a Julia cluster")
@mpi_do  include("02-broadcast.jl")

M = [rand(10,10) for i=1:10]
pmap(svd, M)
println("pmap successful")

println("Running 03-reduce as part of a Julia cluster")
@mpi_do  include("03-reduce.jl")

pids = [remotecall_fetch(p, myid) for p in workers()]
println("julia pids $pids")

println("Running 04-sendrecv as part of a Julia cluster")
@mpi_do  include("04-sendrecv.jl")

exit()

