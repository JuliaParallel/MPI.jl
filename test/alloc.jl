using MPI

MPI.Init()

function sendrecv(send_buf, recv_buf, req)
    MPI.Isend(send_buf, MPI.COMM_WORLD, req; dest=0, tag=0)
    MPI.Recv!(recv_buf, MPI.COMM_WORLD; source=0, tag=0)
    MPI.Wait(req)
end

req = MPI.Request()
send_buf = ones(10)
recv_buf = zeros(10)

sendrecv(send_buf, recv_buf, req)

@timev sendrecv(send_buf, recv_buf, req)


using Profile

Profile.Allocs.clear()
Profile.Allocs.@profile sample_rate=1.0 sendrecv(send_buf, recv_buf, req);
results = Profile.Allocs.fetch()

using PProf
PProf.Allocs.pprof(results)