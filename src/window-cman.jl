import Base: launch, kill, manage, connect
export MPIWindowIOManager, launch, kill, manage, connect, @cluster

"""
Stores the buffers needed for communication, in one instance per rank. Loop stops when the stop_condition is triggered
"""
mutable struct MPIWindowIOManager <: ClusterManager
    comm::MPI.Comm
    connection_windows::Vector{WindowIO}
    stdio_windows::Vector{WindowIO}
    workers_wait::Bool

    function MPIWindowIOManager(comm::MPI.Comm, workers_wait::Bool)
        nb_procs = MPI.Comm_size(comm)
        connection_windows = Vector{WindowIO}(nb_procs)
        stdio_windows = Vector{WindowIO}(nb_procs)

        for i in 1:nb_procs
            connection_windows[i] = WindowIO(comm)
            stdio_windows[i] = WindowIO(comm)
        end

        # Make sure all windows are created before continuing
        MPI.Barrier(comm)

        return new(comm, connection_windows, stdio_windows, workers_wait)
    end
end

# Closes all local MPI Windows in a manager. Must be called collectively on all ranks
function closeall(manager::MPIWindowIOManager)
    for w in manager.connection_windows
        close(w)
    end
    for w in manager.stdio_windows
        close(w)
    end
end

function launch(mgr::MPIWindowIOManager, params::Dict,
                instances::Array, cond::Condition)
    try
        nprocs = MPI.Comm_size(mgr.comm)
        for cnt in 1:(nprocs-1)
            push!(instances, WorkerConfig())
        end
        notify(cond)
    catch e
        println("Error in MPI launch $e")
        rethrow(e)
    end
end

function kill(mgr::MPIWindowIOManager, pid::Int, config::WorkerConfig)
    @spawnat pid notify(_stop_requested)
    Distributed.set_worker_state(Distributed.Worker(pid), Distributed.W_TERMINATED)
end

function manage(mgr::MPIWindowIOManager, id::Integer, config::WorkerConfig, op::Symbol) end

function connect(mgr::MPIWindowIOManager, pid::Int, config::WorkerConfig)
    myrank = MPI.Comm_rank(mgr.comm)
    if myrank == 0
        proc_stdio = mgr.stdio_windows[pid]
        @schedule while !eof(proc_stdio)
            try
                println("\tFrom worker $(pid):\t$(readline(proc_stdio))")
            catch e
            end
        end
    end
    return (mgr.connection_windows[pid], WindowWriter(mgr.connection_windows[myrank+1], pid-1))
end

function redirect_to_mpi(s::WindowWriter)
    (rd, wr) = redirect_stdout()
    @schedule while !eof(rd) && isopen(s.winio)
        av = readline(rd)
        if isopen(s.winio)
            println(s,av)
            flush(s)
        end
    end
end

function checkworkers()
    for w in workers()
        if w != (@fetchfrom w myid())
            error("worker $w is not waiting")
        end
    end
end

function notify_workers()
    for w in workers()
        @spawnat(w, notify(_stop_requested))
    end
end

function wait_for_events()
    global _stop_requested
    wait(_stop_requested)
end

"""
Initialize the current process as a Julia parallel worker. Must be called on all ranks.
If comm is not supplied, MPI is initialized and MPI_COMM_WORLD is used.
"""
function start_window_worker(comm::Comm, workers_wait)
    rank = MPI.Comm_rank(comm)
    N = MPI.Comm_size(comm)

    manager = MPIWindowIOManager(comm, workers_wait)
    cookie = string(comm)
    if length(cookie) > Base.Distributed.HDR_COOKIE_LEN
        cookie = cookie[1:Base.Distributed.HDR_COOKIE_LEN]
    end

    try
        if rank == 0
            Base.cluster_cookie(cookie)
            MPI.Barrier(comm)
            addprocs(manager)
            @assert nprocs() == N
            @assert nworkers() == (N == 1 ? 1 : N-1)

            if !workers_wait
                checkworkers()
                notify_workers()
            end
        else
            init_worker(cookie, manager)
            MPI.Barrier(comm)
            redirect_to_mpi(WindowWriter(manager.stdio_windows[rank+1], 0))
            for i in vcat([1], (rank+2):N)
                # Receiving end of connections to all higher workers and master
                Base.process_messages(manager.connection_windows[i], WindowWriter(manager.connection_windows[rank+1], i-1))
            end

            global _stop_requested = Condition()
            wait_for_events()
        end
    catch e
        Base.display_error(STDERR,"exception $e on rank $rank",backtrace())
    end

    if workers_wait && rank != 0
        closeall(manager)
        MPI.Finalize()
        exit(0)
    end

    return manager
end

"""
Stop the manager. This closes all windows and calls MPI.Finalize on all workers
"""
function stop_main_loop(manager::MPIWindowIOManager)
    if myid() != 1
        wait_for_events()
    else
        checkworkers()
        if nprocs() > 1
            rmprocs(workers())
        end
    end
    closeall(manager)
    MPI.Finalize()
end

"""
Runs the given expression using the Julia parallel cluster. Useful when running with MPI_WINDOW_NOWAIT,
since this will temporarily activate the worker event loops to listen for messages.
"""
macro cluster(expr)
    quote
        if myid() != 1
            wait_for_events()
        else
            $(esc(expr))
            notify_workers()
        end
    end
end