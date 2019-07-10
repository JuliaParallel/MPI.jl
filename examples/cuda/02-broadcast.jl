import MPI
MPI.Init()
comm = MPI.COMM_WORLD
using CuArrays
using CuArrays.CUDAdrv
using CUDAnative
CUDAnative.device!(MPI.Comm_rank(comm) % length(devices()))
include("02-broadcast-impl.jl")
function main()
    do_broadcast()
end



main()

MPI.Finalize()
