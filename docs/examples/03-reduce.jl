using MPI
MPI.Init()

comm = MPI.COMM_WORLD
root = 0

r = MPI.Comm_rank(comm)

sr = MPI.Reduce(r, +, root, comm)

if MPI.Comm_rank(comm) == root
    println("sum of ranks = $sr")
end

