from mpi4py import MPI
import numpy

comm = MPI.COMM_WORLD
rank = comm.Get_rank()

def pingpong(bufsize, iters):
    buffer = numpy.random.rand(bufsize)
    tag = 0

    comm.Barrier()
    tic = MPI.Wtime()
    for i in range(iters):
        if rank == 0:
            comm.Send([buffer, MPI.DOUBLE], dest=1, tag=tag)
            comm.Recv([buffer, MPI.DOUBLE], source=1, tag=tag)
        else:
            comm.Recv([buffer, MPI.DOUBLE], source=0, tag=tag)
            comm.Send([buffer, MPI.DOUBLE], dest=0, tag=tag)

    toc = MPI.Wtime()
    avgtime = (toc - tic) / iters
    
    return avgtime


for k in range(21):
    bufsize = 2**k
    iters = 1 << (20 if k < 10 else 30-k)
    avgtime = pingpong(bufsize, iters)
    if rank == 0:
        print(f'{bufsize}, {avgtime}')
