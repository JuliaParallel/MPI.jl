using Compat
# tests for the various kinds of waits
using Test
using MPI

MPI.Init()
myrank = MPI.Comm_rank(MPI.COMM_WORLD)
commsize = MPI.Comm_rank(MPI.COMM_WORLD)

nsends = 2
send_arr = Array{Array{Int, 1}}(undef,nsends)
recv_arr = Array{Array{Int, 1}}(undef,nsends)

for i=1:nsends
    send_arr[i] = [i]
    recv_arr[i] = Array{Int}(undef,1)
end

send_reqs = Array{MPI.Request}(undef,nsends)
recv_reqs = Array{MPI.Request}(undef,nsends)

# send to self
for i=1:nsends
    send_reqs[i] = MPI.Isend(send_arr[i], myrank, i, MPI.COMM_WORLD)
    recv_reqs[i] = MPI.Irecv!(recv_arr[i], myrank, i, MPI.COMM_WORLD)
end

send_check = zeros(Int, nsends)
recv_check = zeros(Int, nsends)
for i=1:nsends
    idx, stat = MPI.Waitany!(send_reqs)
    send_check[idx] += 1
    send_reqs[idx] = MPI.REQUEST_NULL
end

for i=1:nsends
  @test send_check[i] == 1
end

for i=1:nsends
    idx, stat = MPI.Waitany!(recv_reqs)
    recv_check[idx] += 1
    recv_reqs[idx] = MPI.REQUEST_NULL
end

for i=1:nsends
  @test recv_check[i] == 1
end

MPI.Barrier(MPI.COMM_WORLD)
MPI.Finalize()
