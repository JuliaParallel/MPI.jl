using Printf
using GPUArrays
using CuArrays
using MPI


function do_reduce()
    comm = MPI.COMM_WORLD

    MPI.Barrier(comm)

    root = 0
    r = MPI.Comm_rank(comm)

    N = 100

    A = CuArray{Float64}(undef,10, 10)
    @sync copyto!(A, r * reshape(collect(1:N)*1.0, (10, 10)))
    # CUDA streams should be synchronized before MPI call.

    B = CuArray{Float64}(undef, 10, 10)
    
    

    sr = MPI.Reduce!(A, B, +, root, comm) 

    if(MPI.Comm_rank(comm) == root)
        @printf("sum: %s\n", B)
    end
end
