using MPI
using CuArrays
using CuArrays.CUDAdrv
using CUDAnative

MPI.Init()
comm = MPI.COMM_WORLD

CUDAnative.device!(MPI.Comm_rank(comm) % length(devices()))

include("04-sendrecv-impl.jl")
function main()
    do_sendrecv()
end



main()

MPI.Finalize()
