include("common.jl")
using Random

MPI.Init()

comm = MPI.COMM_WORLD
root = 0
matsize = (17,17)

for T in MPITestTypes
    # This test depends on the stability of the rng and we have observed with
    # CUDA.jl that it is not guaranteed that the same number of rand calls will
    # occur on each rank. (This is a hypothesis). To be sure we shall seed the rng
    # just before we call rand.
    Random.seed!(17)
    A = ArrayType(rand(T, matsize))
    B = MPI.Comm_rank(comm) == root ? A : similar(A)
    req = MPI.Ibcast!(B, comm; root=root)
    sleep(rand())
    MPI.Wait(req)
    @test B == A
end

# Char
A = ['s', 't', 'a', 'r', ' ', 'w', 'a', 'r', 's']
B = MPI.Comm_rank(comm) == root ? A : similar(A)
req = MPI.Ibcast!(B, comm; root=root)
sleep(rand())
MPI.Wait(req)
@test B == A



MPI.Finalize()
@test MPI.Finalized()
