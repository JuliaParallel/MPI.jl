# tests for the various kinds of waits
include("common.jl")

MPI.Init(threadlevel=:multiple)

myrank = MPI.Comm_rank(MPI.COMM_WORLD)
commsize = MPI.Comm_rank(MPI.COMM_WORLD)

nsends = 2
send_arr = [ArrayType{Int}([i]) for i = 1:nsends]
recv_arr = [ArrayType{Int}(undef,1) for i = 1:nsends]
synchronize()

send_check = zeros(Int, nsends)
recv_check = zeros(Int, nsends)

@sync for i = 1:nsends
    Threads.@spawn begin
        recv_req = MPI.Irecv!(recv_arr[i], MPI.COMM_WORLD; source=myrank, tag=i)
        wait(recv_req)
        @test MPI.isnull(recv_req)
        recv_check[i] += 1
    end
    Threads.@spawn begin
        send_req = MPI.Isend(send_arr[i], MPI.COMM_WORLD; dest=myrank, tag=i)
        wait(send_req)
        @test MPI.isnull(send_req)
        send_check[i] += 1
    end
end

@test recv_check == ones(Int, nsends)
@test send_check == ones(Int, nsends)

MPI.Barrier(MPI.COMM_WORLD)
MPI.Finalize()
@test MPI.Finalized()
