# This example demonstrates a job scheduling through adding the
# number 100 to every component of the vector data. The root
# assigns one element to each worker to compute the operation.
# When the worker is finished, the root sends another element
# until each element is added 100
# Inspired on
# https://www.hpc.ntnu.no/ntnu-hpc-group/vilje/user-guide/software/mpi-and-mpi-io-training-tutorial/basic-mpi/job-queue

using MPI

function job_queue(data,f)
    MPI.Init()

    comm = MPI.COMM_WORLD
    rank = MPI.Comm_rank(comm)
    world_size = MPI.Comm_size(comm)
    nworkers = world_size - 1

    root = 0

    MPI.Barrier(comm)
    T = eltype(data)
    N = size(data)[1]
    send_mesg = Array{T}(undef, 1)
    recv_mesg = Array{T}(undef, 1)

    if rank == root # I am root

        idx_recv = 0
        idx_sent = 1

        new_data = Array{T}(undef, N)
        # Array of workers requests
        sreqs_workers = Array{MPI.Request}(undef,nworkers)
        # -1 = start, 0 = channel not available, 1 = channel available
        status_workers = ones(nworkers).*-1
        
        # Send message to workers
        for dst in 1:nworkers
            if idx_sent > N
                break
            end
            send_mesg[1] = data[idx_sent]
            sreq = MPI.Isend(send_mesg, dst, dst+32, comm)
            idx_sent += 1
            sreqs_workers[dst] = sreq
            status_workers[dst] = 0
            print("Root: Sent number $(send_mesg[1]) to Worker $dst\n")
        end

        # Send and receive messages until all elements are added
        while idx_recv != N
            # Check to see if there is an available message to receive
            for dst in 1:nworkers
                if status_workers[dst] == 0
                    (flag, status) = MPI.Test!(sreqs_workers[dst])
                    if flag
                        status_workers[dst] = 1
                    end
                end
            end
            for dst in 1:nworkers
                if status_workers[dst] == 1
                    ismessage, status = MPI.Iprobe(dst,dst+32, comm)
                    if ismessage
                        # Receives message
                        MPI.Recv!(recv_mesg, dst, dst+32, comm)
                        idx_recv += 1
                        new_data[idx_recv] = recv_mesg[1]
                        print("Root: Received number $(recv_mesg[1]) from Worker $dst\n")
                        if idx_sent <= N
                            send_mesg[1] = data[idx_sent]
                            # Sends new message
                            sreq = MPI.Isend(send_mesg, dst, dst+32, comm)
                            idx_sent += 1
                            sreqs_workers[dst] = sreq
                            status_workers[dst] = 1
                            print("Root: Sent number $(send_mesg[1]) to Worker $dst\n")
                        end
                    end
                end
            end
        end
        
        for dst in 1:nworkers
            # Termination message to worker
            send_mesg[1] = -1
            sreq = MPI.Isend(send_mesg, dst, dst+32, comm)
            sreqs_workers[dst] = sreq
            status_workers[dst] = 0
            print("Root: Finish Worker $dst\n")
        end
        
        MPI.Waitall!(sreqs_workers)
        print("Root: New data = $new_data\n")
    else # If rank == worker
        # -1 = start, 0 = channel not available, 1 = channel available
        status_worker = -1
        while true
            sreqs_workers = Array{MPI.Request}(undef,1)
            ismessage, status = MPI.Iprobe(root, rank+32, comm)
            
            if ismessage
                # Receives message
                MPI.Recv!(recv_mesg, root, rank+32, comm)
                # Termination message from root
                if recv_mesg[1] == -1
                    print("Worker $rank: Finish\n")
                    break
                end
                print("Worker $rank: Received number $(recv_mesg[1]) from root\n")
                # Apply function (add number 100) to array
                send_mesg = f(recv_mesg)
                sreq = MPI.Isend(send_mesg, root, rank+32, comm)
                sreqs_workers[1] = sreq
                status_worker = 0
            end
            # Check to see if there is an available message to receive
            if status_worker == 0
                (flag, status) = MPI.Test!(sreqs_workers[1])
                if flag
                    status_worker = 1
                end
            end
        end
    end
    MPI.Barrier(comm)
    MPI.Finalize()
end

f = x -> x.+100
data = collect(1:10)
job_queue(data,f)
