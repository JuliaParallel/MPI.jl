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

sendreq =  MPI.Send_init(send_mesg, comm; tag=7, dest=mod(rank + 1, size))
recvreq = MPI.Recv_init(recv_mesg, comm; tag=7, source=mod(rank - 1, size))

@test MPI.Test(sendreq)
@test MPI.Test(recvreq)

for i = 1:3

    MPI.Start(recvreq)

    @test !MPI.Test(recvreq)

    MPI.Barrier(comm)

    MPI.Start(sendreq)

    MPI.Waitall([sendreq, recvreq])

    @test MPI.Test(sendreq)
    @test MPI.Test(recvreq)

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
