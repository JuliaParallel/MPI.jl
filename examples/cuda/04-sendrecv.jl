using MPI
using CuArrays
using CuArrays.CUDAdrv
using CUDAnative

MPI.Init()
comm = MPI.COMM_WORLD
lcomm = MPI.Comm_split_type(comm, MPI.MPI_COMM_TYPE_SHARED, MPI.Comm_rank(comm))
CUDAnative.device!(MPI.Comm_rank(lcomm) % length(devices()))

include("04-sendrecv-impl.jl")
function main()
    do_sendrecv()
end

main()

MPI.Finalize()
