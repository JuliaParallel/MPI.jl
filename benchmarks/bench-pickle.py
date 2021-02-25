import time
import numpy
import pickle


def runpickle(bufsize, iters):
    buffer = numpy.rand(bufsize)
    tag = 0

    tic = time.time()
    for i in range(iters):
        p = pickle.dumps(buffer)
        pickle.loads(p)

    toc = time.time()
    avgtime = (toc - tic) / iters
    
    return avgtime

for k in range(21):
    bufsize = 2**k
    iters = 10_000 if k < 15 else 1000
    avgtime = runpickle(bufsize, iters)
    print(f'{bufsize}, {avgtime}')
