include("common.jl")

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

N = 1
send_mesg = ArrayType{Float64}(undef,N)
recv_mesg = ArrayType{Float64}(undef,N)
recv_mesg_expected = ArrayType{Float64}(undef,N)

fill!(send_mesg, rank)
synchronize()

sendreq = MPI.Send_init(send_mesg, comm; tag=7, dest=mod(rank + 1, size))
recvreq = MPI.Recv_init(recv_mesg, comm; tag=7, source=mod(rank - 1, size))

@test MPI.Test(sendreq)
@test MPI.Test(recvreq)

@test Base.sprint(show, sendreq) == Base.sprint(show, recvreq) == "MPI.Request: inactive request"

for i = 1:3
    MPI.Start(recvreq)

    @test !MPI.Test(recvreq)
    @test Base.sprint(show, recvreq) == "MPI.Request: incomplete request"

    MPI.Barrier(comm)

    MPI.Start(sendreq)

    MPI.Waitall([sendreq, recvreq])

    @test MPI.Test(sendreq)
    @test MPI.Test(recvreq)
    @test Base.sprint(show, sendreq) == Base.sprint(show, recvreq) == "MPI.Request: inactive request"

    copyto!(send_mesg, recv_mesg)

    fill!(recv_mesg_expected, mod(rank-i, size))
    synchronize()
    @test recv_mesg == recv_mesg_expected
end

reqs = MPI.RequestSet([sendreq,recvreq])

@test MPI.Testall(reqs)
for i = 4:6
    MPI.Startall(reqs)
    MPI.Waitall(reqs)
    @test MPI.Testall(reqs)

    copyto!(send_mesg, recv_mesg)

    fill!(recv_mesg_expected, mod(rank-i, size))
    synchronize()
    @test recv_mesg == recv_mesg_expected
end

MPI.free(sendreq)
MPI.free(recvreq)

@test MPI.isnull(sendreq)
@test MPI.isnull(recvreq)


reqs = MPI.MultiRequest(2)
MPI.Send_init(send_mesg, comm, reqs[1]; tag=8, dest=mod(rank + 1, size))
MPI.Recv_init(recv_mesg, comm, reqs[2]; tag=8, source=mod(rank - 1, size))
@test MPI.Testall(reqs)

for i = 7:9
    MPI.Startall(reqs)
    MPI.Waitall(reqs)
    @test MPI.Testall(reqs)

    copyto!(send_mesg, recv_mesg)

    fill!(recv_mesg_expected, mod(rank-i, size))
    synchronize()
    @test recv_mesg == recv_mesg_expected
end

MPI.free(reqs)
@test MPI.Testall(reqs)
@test all(MPI.isnull, reqs)
