import MPI
using CuArrays
using CuArrays.CUDAdrv
using CUDAnative

MPI.Init()
comm = MPI.COMM_WORLD
lcomm = MPI.Comm_split_type(comm, MPI.MPI_COMM_TYPE_SHARED, MPI.Comm_rank(comm))
CUDAnative.device!(MPI.Comm_rank(lcomm) % length(devices()))

include("03-reduce-impl.jl")
function main()

    println("Hello world, I am $(MPI.Comm_rank(comm)) of $(MPI.Comm_size(comm))")
    do_reduce()

end

main()

MPI.Finalize()
