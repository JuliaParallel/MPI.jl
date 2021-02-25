using MPI

MPI.Init()

@assert MPI.Comm_size(MPI.COMM_WORLD) == 2

function pingpong(T, bufsize, iters)

    buffer = rand(T, bufsize)

    rank = MPI.Comm_rank(MPI.COMM_WORLD)
    tag = 0

    MPI.Barrier(MPI.COMM_WORLD)

    tic = MPI.Wtime()
    for i = 1:iters
        if rank == 0
            MPI.Send(buffer, 1, tag, MPI.COMM_WORLD)
            MPI.Recv!(buffer, 1, tag, MPI.COMM_WORLD)
        else
            MPI.Recv!(buffer, 0, tag, MPI.COMM_WORLD)
            MPI.Send(buffer, 0, tag, MPI.COMM_WORLD)
        end
    end
    toc = MPI.Wtime()

    avgtime = (toc-tic)/iters
    return avgtime
end

pingpong(Float64, 1, 10)

for k = 0:20
    bufsize = 2^k
    iters = 1 << (k < 10 ? 20 : 30-k)
    avgtime = pingpong(Float64, bufsize, iters)
    if MPI.Comm_rank(MPI.COMM_WORLD) == 0
        println(bufsize, ", ", avgtime)
    end
end
