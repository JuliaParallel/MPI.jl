using Printf
using GPUArrays
using CuArrays
using MPI


function do_reduce()
    comm = MPI.COMM_WORLD

    MPI.Barrier(comm)

    root = 0
    rank = MPI.Comm_rank(comm)

    N = 9

    A = CuArray{Float64}(undef,3, 3)
    @sync copyto!(A, rank * reshape(collect(1:N)*1.0, (3, 3)))
    # CUDA streams should be synchronized before MPI call.

    B = CuArray{Float64}(undef, 3, 3)
    

    sr = MPI.Reduce!(A, B, MPI.SUM, root, comm) 

    if(MPI.Comm_rank(comm) == root)
        println("sum: $B")
    end
end
