import MPI
function montecarlo(mc_eval::Function, mc_monitor::Function, reps, n_returns, pooled=1, sleeptime=0.)
    blas_set_num_threads(1)
    # set up the MPI communicator
    MPI.Init()
    comm = MPI.COMM_WORLD
    MPI.Barrier(comm)
    rank = MPI.Comm_rank(comm)
    commsize = MPI.Comm_size(comm)

    # containers and book keeping
    contrib = zeros(pooled, n_returns)
    results = zeros(reps, n_returns)
    pernode = reps / (commsize - 1)
    if mod(pernode,1) != 0
        if rank == 0
            println("error \(montecarlo\)")
            println("reps is set to ", reps)
            println("choose ranks so that  reps/(ranks-1) is an integer")
        end
        MPI.Barrier(comm)
        MPI.Finalize()
        return 0
    end

    if mod(pernode,pooled) != 0
        pooled = div(pernode, commsize-1)
    end    

    # workers' code
    if rank > 0
        @inbounds for i = 1:pernode/pooled
            # do work
            for j = 1:pooled
                contrib[j,:] = mc_eval()
            end
            MPI.Isend(contrib, 0, rank, comm)
        end

    else # frontend
        sofar = 0 # results collected so far
        done = false
        while ~done
            sleep(sleeptime) # flood control if job is costly 
            @inbounds for node = 1:commsize-1
                # check for results
                ready = false
                ready, junk = MPI.Iprobe(node, node, comm)
                if ready # get them if they're ready
                    sofar +=1
                    if sofar*pooled <= reps
                        MPI.Recv!(contrib, node, node, comm)
                        results[sofar*pooled-pooled+1:sofar*pooled,:] = contrib
                        mc_monitor(sofar*pooled, results)  
                    end
                    if sofar == reps/pooled
                        done = true
                        break
                    end    
                end    
            end
        end    
    end    
    MPI.Barrier(comm)
    MPI.Finalize()
end
