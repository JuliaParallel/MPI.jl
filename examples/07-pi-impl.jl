import MPI
function montecarlo(mc_eval::Function, mc_monitor::Function,
                    reps::Integer, n_returns::Integer, pooled::Integer=1,
                    sleeptime::Real=0)
    # set up the MPI communicator
    MPI.Init()
    comm = MPI.COMM_WORLD
    rank = MPI.Comm_rank(comm)
    commsize = MPI.Comm_size(comm)

    # containers and bookkeeping
    contrib = zeros(pooled, n_returns)
    results = zeros(reps, n_returns)
    pernode = div(reps, commsize - 1)
    if mod(reps, commsize - 1) != 0
        if rank == 0
            println("Error (montecarlo):")
            println("    reps=$reps, commsize=$commsize")
            println("Choose commsize so that reps/(commsize-1) is integer")
        end
        MPI.Finalize()
        exit(1)
    end

    if mod(pernode, pooled) != 0
        pooled = div(pernode, commsize-1)
    end

    if rank > 0
        # workers
        @inbounds for i = 1:div(pernode, pooled)
            # do work
            for j = 1:pooled
                contrib[j,:] = mc_eval()
            end
            MPI.Isend(contrib, 0, rank, comm)
        end

    else
        # manager
        sofar = 0 # results collected so far
        while sofar < div(reps, pooled)
            sleep(sleeptime) # flood control if job is costly
            @inbounds for node = 1:commsize-1
                # check for results
                ready, _ = MPI.Iprobe(node, node, comm)
                if ready # get them if they're ready
                    sofar +=1
                    if sofar*pooled <= reps
                        MPI.Recv!(contrib, node, node, comm)
                        results[sofar*pooled-pooled+1:sofar*pooled,:] = contrib
                        mc_monitor(sofar*pooled, results)
                    end
                    if sofar == div(reps, pooled)
                        break
                    end
                end
            end
        end
    end

    MPI.Finalize()
end
