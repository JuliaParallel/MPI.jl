using Test
using Random
using MPI

MPI.Init()

function bcast_array(A, root)
    comm = MPI.COMM_WORLD

    if MPI.Comm_rank(comm) == root
        B = copy(A)
    else
        B = similar(A)
    end

    MPI.Bcast!(B, root, comm)
    B
end

root = 0

if VERSION >= v"0.7.0-rc1"
    Random.seed!(17)
else
    srand(17)
end

matsize = (17,17)
for typ in Base.uniontypes(MPI.MPIDatatype)
    A = rand(typ, matsize...)
    @test bcast_array(A, root) == A
end

# Char
A = ['s', 't', 'a', 'r', ' ', 'w', 'a', 'r', 's']
@test bcast_array(A, root) == A

comm = MPI.COMM_WORLD

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
