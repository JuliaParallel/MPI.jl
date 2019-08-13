using Test, Pkg
using MPI
using Random

if haskey(Pkg.installed(), "CuArrays")
    using CuArrays
    ArrayType = CuArray
else
    ArrayType = Array
end

MPI.Init()


comm = MPI.COMM_WORLD

function bcast_array(A, root)

end

root = 0
Random.seed!(17)
matsize = (17,17)

for T in Base.uniontypes(MPI.MPIDatatype)
    A = ArrayType(rand(T, matsize))
    B = MPI.Comm_rank(comm) == root ? A : similar(A)
    MPI.Bcast!(B, root, comm)
    @test B == A
end

# Char
A = ['s', 't', 'a', 'r', ' ', 'w', 'a', 'r', 's']
B = MPI.Comm_rank(comm) == root ? A : similar(A)
MPI.Bcast!(B, root, comm)
@test B == A


g = x -> x^2 + 2x - 1
if MPI.Comm_rank(comm) == root
    f = g
else
    f = nothing
end
f = MPI.bcast(f, root, comm)
@test f(3) == g(3)
@test f(5) == g(5)
@test f(7) == g(7)


A = Dict("foo" => "bar")
if MPI.Comm_rank(comm) == root
    B = A
else
    B = nothing
end
B = MPI.bcast(B, root, comm)
@test B["foo"] == "bar"

MPI.Finalize()
@test MPI.Finalized()
