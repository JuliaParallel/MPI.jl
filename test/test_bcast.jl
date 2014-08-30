using Base.Test
import MPI

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

srand(17)

# Float64
A = rand(13)
@test bcast_array(A, root) == A
#@testfails bcast_array(A, root) == rand(13)

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
A = int8(rand(1:143, 34))
@test bcast_array(A, root) == A

# Uint8
A = uint8(rand(34, 123))
@test bcast_array(A, root) == A

# Int16
A = int16(rand(1430, 340))
@test bcast_array(A, root) == A

# Uint16
A = uint16(rand(340, 1230))
@test bcast_array(A, root) == A

# Int32
A = rand(34,123)
@test bcast_array(A, root) == A

# Uint32
A = uint32(rand(34, 28))
@test bcast_array(A, root) == A

# Int64
A = int64(rand(1:400, 33))
@test bcast_array(A, root) == A

# Uint64
A = uint64(rand(1:8000, 128))
@test bcast_array(A, root) == A


comm = MPI.COMM_WORLD

g = x -> x^2 + 2x - 1
if MPI.Comm_rank(comm) == root
    f = copy(g)
else
    f = nothing
end
f = MPI.bcast(f, root, comm)
@test f(3) == g(3)
@test f(5) == g(5)
@test f(7) == g(7)


A = {"foo" => "bar"}
if MPI.Comm_rank(comm) == root
    B = A
else
    B = nothing
end
B = MPI.bcast(B, root, comm)
@test B["foo"] == "bar"

MPI.Finalize()
