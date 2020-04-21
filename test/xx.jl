using MPI, CuArrays

MPI.Init()

send_mesg = CuArray{Float64}(1:3)
recv_mesg = CuArray{Float64}(undef,3)

rreq = MPI.Irecv!(recv_mesg, 0, 32, MPI.COMM_WORLD)
sreq = MPI.Isend(send_mesg, 0, 32, MPI.COMM_WORLD)

MPI.Waitall!([rreq, sreq])

