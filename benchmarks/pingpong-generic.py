from mpi4py import MPI
import numpy

comm = MPI.COMM_WORLD
rank = comm.Get_rank()

assert comm.Get_size() == 2

def pingpong(bufsize, iters):
    buffer = numpy.random.rand(bufsize)
    tag = 0

    comm.Barrier()
    tic = MPI.Wtime()
    for i in range(iters):
        if rank == 0:
            comm.send(buffer, dest=1, tag=tag)
            buffer = comm.recv(source=1, tag=tag)
        else:
            buffer = comm.recv(source=0, tag=tag)
            comm.send(buffer, dest=0, tag=tag)

    toc = MPI.Wtime()
    avgtime = (toc - tic) / iters
    
    return avgtime

for k in range(21):
    bufsize = 2**k
    iters = 10_000 if k < 15 else 1000
    avgtime = pingpong(bufsize, iters)
    if rank == 0:
        print(f'{bufsize}, {avgtime}')
