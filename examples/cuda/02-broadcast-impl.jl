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

    N = 100
    
    root = 0
    
    A = CuArrays.CuArray{Float64}(undef, 10, 10)
    if MPI.Comm_rank(comm) == root
        copyto!(A, reshape(collect(1:N)*1.0,  (10, 10)))
    end
    

    MPI.Bcast!(A, root, comm)
    

    @printf("[%02d] A:%s, device:%s\n", MPI.Comm_rank(comm), A, GPUArrays.device(A))
    #map(println, CUDAdrv.devices())


end
