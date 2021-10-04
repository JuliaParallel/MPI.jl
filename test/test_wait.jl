# tests for the various kinds of waits
using Test
using MPI

if get(ENV,"JULIA_MPI_TEST_ARRAYTYPE","") == "CuArray"
    import CUDA
    ArrayType = CUDA.CuArray
else
    ArrayType = Array
end

MPI.Init()

myrank = MPI.Comm_rank(MPI.COMM_WORLD)
commsize = MPI.Comm_rank(MPI.COMM_WORLD)

nsends = 2
send_arr = [ArrayType{Int}([i]) for i = 1:nsends]
recv_arr = [ArrayType{Int}(undef,1) for i = 1:nsends]

# send to self
send_reqs = [MPI.Isend(send_arr[i], MPI.COMM_WORLD; dest=myrank, tag=i) for i = 1:nsends]
recv_reqs = [MPI.Irecv!(recv_arr[i], MPI.COMM_WORLD; source=myrank, tag=i) for i = 1:nsends]

send_check = zeros(Int, nsends)
recv_check = zeros(Int, nsends)

for i = 1:nsends
    idx = MPI.Waitany(send_reqs)
    @test send_reqs[idx] == MPI.REQUEST_NULL
    send_check[idx] += 1
end
@test send_check == ones(Int, nsends)

for i = 1:nsends
    idx = MPI.Waitany(recv_reqs)
    @test recv_reqs[idx] == MPI.REQUEST_NULL
    recv_check[idx] += 1
end
@test recv_check == ones(Int, nsends)

MPI.Barrier(MPI.COMM_WORLD)
MPI.Finalize()
@test MPI.Finalized()
