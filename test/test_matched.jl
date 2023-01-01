include("common.jl")

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

dst = mod(rank+1, size)
src = mod(rank-1, size)

N = 32

sendbuf1 = ArrayType(Float64[1 for i = 1:N])
sendbuf2 = ArrayType(Float64[2 for i = 1:N+2])
sendbuf3 = ArrayType(Float64[3 for i = 1:N])
sendbuf4 = ArrayType(Float64[3 for i = 1:N+2])

synchronize()

sendreq1 = MPI.Isend(sendbuf1, comm; dest=dst, tag=rank+32)
sendreq2 = MPI.Isend(sendbuf2, comm; dest=dst, tag=rank+32)
sendreq3 = MPI.Isend(sendbuf3, comm; dest=dst, tag=rank+32)
sendreq4 = MPI.Isend(sendbuf4, comm; dest=dst, tag=rank+32)

recvmsg1 = MPI.Mprobe(comm; source=src)
while true
    global recvmsg2
    ismsg, recvmsg2 = MPI.Improbe(comm; source=src)
    if ismsg
        break
    end
end
recvmsg3, status3 = MPI.Mprobe(comm, MPI.Status; source=src, tag=src+32)
@test MPI.Get_count(status3, Float64) == N

while true
    global status4, recvmsg4
    ismsg, recvmsg4, status4 = MPI.Improbe(comm, MPI.Status; source=src)
    if ismsg
        break
    end
end
@test MPI.Get_count(status4, Float64) == N + 2

recvbuf1 = ArrayType{Float64}(undef, N)
recvbuf2 = ArrayType{Float64}(undef, N+2)
recvbuf3 = ArrayType{Float64}(undef, N)
recvbuf4 = ArrayType{Float64}(undef, N+2)

MPI.Mrecv!(recvbuf4, recvmsg4)
MPI.Mrecv!(recvbuf3, recvmsg3)
recvreq2 = MPI.Imrecv!(recvbuf2, recvmsg2)
recvreq1 = MPI.Imrecv!(recvbuf1, recvmsg1)

MPI.Waitall([sendreq1, sendreq2, sendreq3, sendreq4, recvreq1, recvreq2])

@test recvbuf1 == sendbuf1
@test recvbuf2 == sendbuf2
@test recvbuf3 == sendbuf3
@test recvbuf4 == sendbuf4

MPI.Finalize()
