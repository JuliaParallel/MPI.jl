using Printf
using CuArrays
using CuArrays.CUDAdrv
using MPI
using GPUArrays

function do_broadcast()
    comm = MPI.COMM_WORLD

    if MPI.Comm_rank(comm) == 0
        println(repeat("-",78))
        println(" Running on $(MPI.Comm_size(comm)) processes")
        println(repeat("-",78))
    end

    MPI.Barrier(comm)

    N = 9
    
    root = 0
    
    A = CuArrays.CuArray{Float64}(undef, 3, 3)
    if MPI.Comm_rank(comm) == root
        @sync copyto!(A, reshape(collect(1:N)*1.0,  (3, 3)))
        # CUDA streams should be synchronized before calling MPI functions, 
        # implicitly or explicitly.
    end
    

    MPI.Bcast!(A, root, comm)
    

    @printf("[%02d] A:%s, device:%s\n", MPI.Comm_rank(comm), A, GPUArrays.device(A))

end
