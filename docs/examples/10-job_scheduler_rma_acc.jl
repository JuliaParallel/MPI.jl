# examples/10-job_scheduler_rma_acc.jl
# This example demonstrates a job scheduler with rma and use of
# MPI.Accumulate!. Each column of a rows x cols matrix with random values (0 or 1)
# is compared to corresonding columns in N matrices of the same size,
# also filled with random values (0 or 1). Each worker node obtains the matrix
# on root using passive RMA.
# The manager on root assigns jobs to available workers.
# Root also holds an accumulation vector with size cols that records matches
# between columns.  Each node adds to the accumulation vector using the 
# RMA function MPI.Accumulate!
# When the worker finishes a job, root assigns another job to the worker until
# all N comparisons are complete.  The example should be run with less than N+1
# nodes to demonstrate manager/worker capabilities, although any number greater 
# than 1 is functional.
# 05-job_schedule.jl and 08-rma_passive are sources of most of the code used here


using MPI

function job_queue_rma_acc(rows,cols,N)
    MPI.Init()

    comm = MPI.COMM_WORLD
    rank = MPI.Comm_rank(comm)
    world_size = MPI.Comm_size(comm)
    nworkers = world_size - 1

    # Notice that the number of nodes is specified in the command line, i.e.
    # mpiexec -n 4 julia --project 10-job_scheduler_rma_acc.jl
    # This command creates four nodes, three of which are workers.
    # If the number of nodes + 1 is >= N, then there 
    # is no need for a job scheduler.  However, a job scheduler will handle
    # this case by not sending jobs to the extra nodes.

    # Space for matrices must be allocated on all nodes
    data_0 = zeros(Int64,rows,cols)
    accumulate_matches = zeros(Int64,cols)

    # Windows must be created on all nodes. This is space in memory
    # to allow transfers between nodes.  The created matrices are independent
    # memory locations.  Changes to a matrix on one node do
    # not affect matrices on other nodes.  Only calls to Put, Get,
    # Accumulate!, etc. affect another node's memory
    win_match = MPI.Win_create(data_0, MPI.COMM_WORLD)
    win_accumulate = MPI.Win_create(accumulate_matches, MPI.COMM_WORLD)

    # To illustrate the independence, random values are assigned to data_0 on root
    # but data_0 on other nodes remains unchanged (all zeros)
    root = 0
    if rank == root
        data_0 .= rand(0:1,(rows,cols))
    end
    @show rank, data_0

    MPI.Barrier(comm) # Stop worker threads from proceeding until root is finished

    # Messages are used for monitoring job status.  Here the job number is 
    # passed back and forth between manager and workers
    T = Int64
    send_mesg = Array{T}(undef, 1)
    recv_mesg = Array{T}(undef, 1)


    if rank == root
        idx_recv = 0
        idx_sent = 1

        # 'completed' records completion of jobs, not required but informative
        completed = Array{T}(undef, N)

        # Array of worker requests. This keeps track of messages sent and received
        # by workers
        sreqs_workers = Array{MPI.Request}(undef,nworkers)
        # status_workers indicates the phase of the jobs on each node
        # -1 = start, 0 = message sent, 1 = message received and working on job
        status_workers = ones(nworkers).*-1

        # Send message to workers
        # This loop takes advantage of the fact that all worker nodes are initially
        # free.  Allows a quick start, but at the cost of repeating the Isend, etc.
        # in the for loop below
        for dst in 1:nworkers
            if idx_sent > N
                break
            end
            send_mesg[1] = idx_sent
            sreq = MPI.Isend(send_mesg, comm; dest=dst, tag=dst+32)
            idx_sent += 1
            sreqs_workers[dst] = sreq
            status_workers[dst] = 0
            print("Root: Sent number $(send_mesg[1]) to Worker $dst\n")
        end

        # Send and receive messages until all jobs completed
        while idx_recv != N
            # Check to see if message from Isend was received by worker
            # If so, then the worker should be working and set status to 1
            for dst in 1:nworkers
                if status_workers[dst] == 0
                    flag = MPI.Test(sreqs_workers[dst])
                    if flag
                        status_workers[dst] = 1
                    end
                end
            end
            # Check to see if there is an available message to receive
            # from a worker that we know is working
            for dst in 1:nworkers
                if status_workers[dst] == 1 # worker is working
                    # is worker finished and thus sent a reply?
                    ismessage = MPI.Iprobe(comm; source=dst, tag=dst+42)
                    if ismessage
                        # If so, receive message
                        MPI.Recv!(recv_mesg, comm; source=dst, tag=dst+42)
                        # Count number of times complete jobs and record 
                        # results in 'completed'
                        idx_recv += 1
                        completed[idx_recv] = recv_mesg[1]
                        print("Root: Received number $(recv_mesg[1]) from Worker $dst\n")
                        # If there are still jobs left to do, send a new job to the node
                        # that just finished its job and reset its status
                        if idx_sent <= N
                            send_mesg[1] = idx_sent
                            sreq = MPI.Isend(send_mesg, comm; dest=dst, tag=dst+32)
                            idx_sent += 1
                            sreqs_workers[dst] = sreq
                            status_workers[dst] = 0
                            print("Root: Sent number $(send_mesg[1]) to Worker $dst\n")
                        end
                    end
                end
            end
        end

        for dst in 1:nworkers
            # Termination message to worker
            send_mesg[1] = -1
            sreq = MPI.Isend(send_mesg, comm; dest=dst, tag=dst+32)
            sreqs_workers[dst] = sreq
            status_workers[dst] = 0
            print("Root: Finish Worker $dst\n")
        end

        MPI.Waitall(sreqs_workers) # Make sure all nodes received 'finish' message
        print("Root: Completed jobs = $completed\n")

    else # If rank == worker
        # -1 = start, 0 = final message sent back to root, 1 = final message received can work on new job
        status_worker = -1
        
        # Read data_0 from root.  The data should not change, so read it
        # once on each worker node.  Must lock the window while reading
        MPI.Win_lock(MPI.LOCK_EXCLUSIVE, 0, 0, win_match)
        MPI.Get(data_0, 0, win_match) # Copies data_0 on root into data_0 on current node        
        MPI.Win_unlock(0, win_match)

        sreqs_workers = Array{MPI.Request}(undef,1)
        while true # only break when receiving -1 from root in recv_mesg
            if status_worker != 0 # Not waiting for root to receive completion message
                # Did root send a job message?
                ismessage = MPI.Iprobe(comm; source=root, tag=rank+32)
                if ismessage # job message available
                    # Receive message with a blocking receive
                    MPI.Recv!(recv_mesg, comm; source=root, tag=rank+32)
                    # Termination message from root?
                    if recv_mesg[1] == -1
                        print("Worker $rank: Finish\n")
                        break
                    end
                    print("Worker $rank: Received number $(recv_mesg[1]) from root\n")

                    # Compare data_local to data_0 that was copied from root
                    # Creates new values in data_local for each new job
                    data_local = rand(0:1,(rows,cols))

                    # Create local storage for matches, must re-zero for each job
                    # This could just be accumulate_matches on this node,
                    # but might be confusing to do that and not as educational
                    matches = zeros(Int64,cols)

                    # Iterate through data_0 and see if each column
                    # matches with the corresponding column in data_local
                    for (iter,data) in enumerate(eachcol(data_0))
                        if data == data_local[1:rows,iter]
                            matches[iter] = 1 # 1 = match, 0 = no match
                        end
                    end
                    
                    # Use an MPI.Accumulate call to add to the accumulate_matches
                    # matrix on root.  Must lock the window during the operation
                    MPI.Win_lock(MPI.LOCK_EXCLUSIVE, 0, 0, win_accumulate)
                    for iter in range(1,cols)
                        if matches[iter] > 0
                            # MPI.Accumulate!(array element to send,destination,offset from 
                            # start of vector,type of operation,window)
                            MPI.Accumulate!(matches[iter], 0,iter,MPI.SUM, win_accumulate) 
                        end
                    end
                    MPI.Win_unlock(0, win_accumulate)

                    status_worker = 0

                    # recv_mesg was the job number, just send it back to the manager
                    # to record that this job was completed
                    send_mesg[1] = recv_mesg[1]
                    # Non-blocking send to root
                    sreq = MPI.Isend(send_mesg[1], comm; dest=root, tag=rank+42)
                    sreqs_workers[1] = sreq
                end          
            else # Check to see if final message was received
                flag = MPI.Test(sreqs_workers[1])
                if flag
                    status_worker = 1
                end
            end
        end
    end
    MPI.Barrier(comm)
    
    if rank == 0
        @show accumulate_matches
        @show sum(accumulate_matches)/cols # Should be close to 0.25*N
    end
    # MPI.free(win_match) # These error for some reason
    # MPI.free(win_accumulate)
    MPI.Finalize()
end

# Size of matrices to match
rows = 2
cols = 100
# Number of matrices
N = 10
job_queue_rma_acc(rows,cols,N)
