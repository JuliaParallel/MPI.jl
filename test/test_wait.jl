# tests for the various kinds of waits
using Test, Pkg
using MPI

if haskey(Pkg.installed(), "CuArrays")
    using CuArrays
    ArrayType = CuArray
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
send_reqs = [MPI.Isend(send_arr[i], myrank, i, MPI.COMM_WORLD) for i = 1:nsends]
recv_reqs = [MPI.Irecv!(recv_arr[i], myrank, i, MPI.COMM_WORLD) for i = 1:nsends]

send_check = zeros(Int, nsends)
recv_check = zeros(Int, nsends)

for i = 1:nsends
    idx, stat = MPI.Waitany!(send_reqs)
    @test send_reqs[idx] == MPI.REQUEST_NULL
    send_check[idx] += 1
end
@test send_check == ones(Int, nsends)

for i = 1:nsends
    idx, stat = MPI.Waitany!(recv_reqs)
    @test recv_reqs[idx] == MPI.REQUEST_NULL
    recv_check[idx] += 1
end
@test recv_check == ones(Int, nsends)

MPI.Barrier(MPI.COMM_WORLD)
MPI.Finalize()
@test MPI.Finalized()
