require("nearequal.jl")
require("test.jl")

import MPI
test_context("Testing MPI Bcast")
MPI.init()

test_group("Bcast! tests")

function bcast_array(A, root)
    comm = MPI.COMM_WORLD

    if MPI.rank(comm) == root
        B = copy(A)
    else
        B = similar(A)
    end

    MPI.Bcast!(B, root, comm)
    B
end

root = 0

srand(17)

# Float64
A = rand(13)
@test bcast_array(A, root) == A
@testfails bcast_array(A, root) == rand(13)

# Complex128
A = rand(13) + im * rand(13)
@test bcast_array(A, root) == A

# Float32
A = float32(rand(15))
@test bcast_array(A, root) == A

# Complex64
A = float32(rand(15)) + im * float32(rand(15))
@test bcast_array(A, root) == A

# Char
A = ['s', 't', 'a', 'r', ' ', 'w', 'a', 'r', 's']
@test bcast_array(A, root) == A

# Int8
A = int8(randi(143, 34))
@test bcast_array(A, root) == A

# Uint8
A = uint8(randi(34, 123))
@test bcast_array(A, root) == A

# Int16
A = int16(randi(1430, 340))
@test bcast_array(A, root) == A

# Uint16
A = uint16(randi(340, 1230))
@test bcast_array(A, root) == A

# Int32
A = randi(typemax(Int32), 34)
@test bcast_array(A, root) == A

# Uint32
A = randi(typemax(Uint32), 28)
@test bcast_array(A, root) == A

# Int64
A = randi(typemax(Int64), 33)
@test bcast_array(A, root) == A

# Uint64
A = randi(typemax(Uint64), 128)
@test bcast_array(A, root) == A

test_group("bcast tests")

comm = MPI.COMM_WORLD

g = x -> x^2 + 2x - 1
if MPI.rank(comm) == root
    f = copy(g)
else
    f = Nothing
end
f = MPI.bcast(f, root, comm)
@test f(3) == g(3)
@test f(5) == g(5)
@test f(7) == g(7)


A = {"foo" => "bar"}
if MPI.rank(comm) == root
    B = A
else
    B = Nothing
end
B = MPI.bcast(B, root, comm)
@test B["foo"] == "bar"

MPI.finalize()
