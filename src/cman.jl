import Base: launch, manage, kill, procs, connect
export MPIManager, launch, manage, kill, procs, connect, mpiprocs, @mpi_do
export TransportMode, MPI_ON_WORKERS, TCP_TRANSPORT_ALL, MPI_TRANSPORT_ALL



################################################################################
# MPI Cluster Manager
# Note: The cluster manager object lives only in the manager process,
# except for MPI_TRANSPORT_ALL

# There are three different transport modes:

# MPI_ON_WORKERS: Use MPI between the workers only, not for the manager. This
# allows interactive use from a Julia shell, using the familiar `addprocs`
# interface.

# MPI_TRANSPORT_ALL: Use MPI on all processes; there is no separate manager
# process. This corresponds to the "usual" way in which MPI is used in a
# headless mode, e.g. submitted as a script to a queueing system.

# TCP_TRANSPORT_ALL: Same as MPI_TRANSPORT_ALL, but Julia uses TCP for its
# communication between processes. MPI can still be used by the user.

@enum TransportMode MPI_ON_WORKERS MPI_TRANSPORT_ALL TCP_TRANSPORT_ALL

type MPIManager <: ClusterManager
    np::Int # number of worker processes (excluding the manager process)
    mpi2j::Dict{Int,Int} # map MPI ranks to Julia processes
    j2mpi::Dict{Int,Int} # map Julia to MPI ranks
    mode::TransportMode

    launched::Bool # Are the MPI processes running?
    mpirun_cmd::Cmd # How to start MPI processes
    launch_timeout::Int # seconds

    initialized::Bool # All workers registered with us
    cond_initialized::Condition # notify this when all workers registered

    # TCP Transport
    port::UInt16
    stdout_ios::Array

    # MPI transport
    rank2streams::Dict{Int,Tuple{IO,IO}} # map MPI ranks to (input,output) streams
    ranks_left::Array{Int,1} # MPI ranks for which there is no stream pair yet

    # MPI_TRANSPORT_ALL
    comm::MPI.Comm
    initiate_shutdown::Channel{Void}
    sending_done::Channel{Void}
    receiving_done::Channel{Void}

    function MPIManager(; np::Integer = Sys.CPU_CORES,
                          mpirun_cmd::Cmd = `mpiexec -n $np`,
                          launch_timeout::Real = 60.0,
                          mode::TransportMode = MPI_ON_WORKERS)
        mgr = new()
        mgr.np = np
        mgr.mpi2j = Dict{Int,Int}()
        mgr.j2mpi = Dict{Int,Int}()
        mgr.mode = mode

        # Only start MPI processes for MPI_ON_WORKERS
        mgr.launched = mode != MPI_ON_WORKERS
        @assert MPI.Initialized() == mgr.launched
        mgr.mpirun_cmd = mpirun_cmd
        mgr.launch_timeout = launch_timeout

        mgr.initialized = false
        mgr.cond_initialized = Condition()
        if np == 0
            # Special case: no workers
            mgr.initialized = true
            if mgr.mode != MPI_ON_WORKERS
                # Set up mapping for the manager
                mgr.j2mpi[1] = 0
                mgr.mpi2j[0] = 1
            end
        end

        # Listen to TCP sockets if necessary
        if mode != MPI_TRANSPORT_ALL
            # Start a listener for capturing stdout from the workers
            port, server = listenany(11000)
            @schedule begin
                while true
                    sock = accept(server)
                    push!(mgr.stdout_ios, sock)
                end
            end
            mgr.port = port
            mgr.stdout_ios = IO[]
        else
            mgr.rank2streams = Dict{Int,Tuple{IO,IO}}()
            size = MPI.Comm_size(MPI.COMM_WORLD)
            mgr.ranks_left = collect(1:size-1)
        end

        if mode == MPI_TRANSPORT_ALL
            mgr.initiate_shutdown = Channel{Void}(1)
            mgr.sending_done = Channel{Void}(np)
            mgr.receiving_done = Channel{Void}(1)
            global initiate_shutdown = mgr.initiate_shutdown
        end
        mgr.initiate_shutdown = Channel{Void}(1)
        global initiate_shutdown = mgr.initiate_shutdown

        return mgr
    end
end

function Base.show(io::IO, mgr::MPIManager)
    print(io, "MPI.MPIManager(np=$(mgr.np),launched=$(mgr.launched),mode=$(mgr.mode))")
end

################################################################################
# Cluster Manager functionality required by Base, mostly targeting the
# MPI_ON_WORKERS case

# Launch a new worker, called from Base.addprocs
function launch(mgr::MPIManager, params::Dict,
                instances::Array, cond::Condition)
    try
        if mgr.mode == MPI_ON_WORKERS
            # Start the workers
            if mgr.launched
                println("Reuse of an MPIManager is not allowed.")
                println("Try again with a different instance of MPIManager.")
                throw(ErrorException("Reuse of MPIManager is not allowed."))
            end
            if VERSION >= v"0.5.0-dev+4047"
                # Pass the cookie as symbol to `setup_worker` to work around
                # the mangling issues with command objects, strings and `julia -e` option.
                # Same reason that the ip-address is passed as an integer.
                # Prefix cookie with a "cookie_" since symbols do not
                # lend itself well to strings starting with a "0"
                cookie = string(":cookie_",Base.cluster_cookie())
            else
                cookie = `nothing`
            end
            setup_cmds = `using MPI;MPI.setup_worker($(getipaddr().host),$(mgr.port),$cookie)`
            mpi_cmd = `$(mgr.mpirun_cmd) $(params[:exename]) -e $(Base.shell_escape(setup_cmds))`
            open(detach(mpi_cmd))
            mgr.launched = true
        end

        if mgr.mode != MPI_TRANSPORT_ALL
            # Wait for the workers to connect back to the manager
            t0 = time()
            while (length(mgr.stdout_ios) < mgr.np &&
                   time() - t0 < mgr.launch_timeout)
                sleep(1.0)
            end
            if length(mgr.stdout_ios) != mgr.np
                error("Timeout -- the workers did not connect to the manager")
            end

            # Traverse all worker I/O streams and receive their MPI rank
            configs = Array{WorkerConfig}(mgr.np)
            @sync begin
                for io in mgr.stdout_ios
                    @async let io=io
                        config = WorkerConfig()
                        config.io = io
                        # Add config to the correct slot so that MPI ranks and
                        # Julia pids are in the same order
                        rank = Base.deserialize(io)
                        idx = mgr.mode == MPI_ON_WORKERS ? rank+1 : rank
                        configs[idx] = config
                    end
                end
            end

            # Append our configs and notify the caller
            append!(instances, configs)
            notify(cond)
        else
            # This is a pure MPI configuration -- we don't need any bookkeeping
            for cnt in 1:mgr.np
                push!(instances, WorkerConfig())
            end
            notify(cond)
        end

    catch e
        println("Error in MPI launch $e")
        rethrow(e)
    end
end

# Entry point for MPI worker processes for MPI_ON_WORKERS and TCP_TRANSPORT_ALL
setup_worker(host, port) = setup_worker(host, port, nothing)
function setup_worker(host, port, cookie)
    !MPI.Initialized() && MPI.Init()
    # Connect to the manager
    io = connect(IPv4(host), port)
    Base.wait_connected(io)
    redirect_stdout(io)
    redirect_stderr(io)

    # Send our MPI rank to the manager
    rank = MPI.Comm_rank(MPI.COMM_WORLD)
    Base.serialize(io, rank)

    # Hand over control to Base
    if cookie == nothing
        Base.start_worker(io)
    else
        if isa(cookie, Symbol)
            cookie = string(cookie)[8:end] # strip the leading "cookie_"
        end
        Base.start_worker(io, cookie)
    end
end

# Manage a worker (e.g. register / deregister it)
function manage(mgr::MPIManager, id::Integer, config::WorkerConfig, op::Symbol)
    if op == :register
        # Retrieve MPI rank from worker
        # TODO: Why is this necessary? The workers already sent their rank.
        rank = remotecall_fetch(()->MPI.Comm_rank(MPI.COMM_WORLD), id)
        mgr.j2mpi[id] = rank
        mgr.mpi2j[rank] = id

        if length(mgr.j2mpi) == mgr.np
            # All workers registered
            mgr.initialized = true
            notify(mgr.cond_initialized)
            if mgr.mode != MPI_ON_WORKERS
                # Set up mapping for the manager
                mgr.j2mpi[1] = 0
                mgr.mpi2j[0] = 1
            end
        end
    elseif op == :deregister
        info("pid=$(getpid()) id=$id op=$op")
        # TODO: Sometimes -- very rarely -- Julia calls this `deregister`
        # function, and then outputs a warning such as """error in running
        # finalizer: ErrorException("no process with id 3 exists")""". These
        # warnings seem harmless; still, we should find out what is going wrong
        # here.
    elseif op == :interrupt
        # TODO: This should never happen if we rmprocs the workers properly
        info("pid=$(getpid()) id=$id op=$op")
        @assert false
    elseif op == :finalize
        # This is called from within a finalizer after deregistering; do nothing
    else
        info("pid=$(getpid()) id=$id op=$op")
        @assert false # Unsupported operation
    end
end

# Kill a worker
function kill(mgr::MPIManager, pid::Int, config::WorkerConfig)
    # Do nothing, as the worker will self-terminate after calling MPI.Finalize
    Base.set_worker_state(Base.Worker(pid), Base.W_TERMINATED)
end

# Set up a connection to a worker
function connect(mgr::MPIManager, pid::Int, config::WorkerConfig)
    if mgr.mode != MPI_TRANSPORT_ALL
        # Forward the call to the connect function in Base
        return invoke(connect, (ClusterManager, Int, WorkerConfig),
                      mgr, pid, config)
    end

    rank = MPI.Comm_rank(mgr.comm)
    if rank == 0
        # Choose a rank for this worker
        to_rank = pop!(mgr.ranks_left)
        config.connect_at = to_rank
        return start_send_event_loop(mgr, to_rank)
    else
        return start_send_event_loop(mgr, get(config.connect_at))
    end
end

# Event loop for sending data to one other process, for the MPI_TRANSPORT_ALL
# case
function start_send_event_loop(mgr::MPIManager, rank::Int)
    try
        r_s = BufferStream()
        w_s = BufferStream()
        mgr.rank2streams[rank] = (r_s, w_s)

        # TODO: There is one task per communication partner -- this can be
        # quite expensive when there are many workers. Design something better.
        # For example, instead of maintaining two streams per worker, provide
        # only abstract functions to write to / read from these streams.
        @schedule begin
            rr = MPI.Comm_rank(mgr.comm)
            reqs = MPI.Request[]
            while !isready(mgr.initiate_shutdown)
                # When data are available, send them
                while nb_available(w_s) > 0
                    data = takebuf_array(w_s.buffer)
                    push!(reqs, MPI.Isend(data, rank, 0, mgr.comm))
                end
                if !isempty(reqs)
                    (indices, stats) = MPI.Testsome!(reqs)
                    filter!(req -> req != MPI.REQUEST_NULL, reqs)
                end
                # TODO: Need a better way to integrate with libuv's event loop
                yield()
            end
            put!(mgr.sending_done, nothing)
        end
        (r_s, w_s)
    catch e
        Base.show_backtrace(STDOUT, catch_backtrace())
        println(e)
        rethrow(e)
    end
end

################################################################################
# Alternative startup model: All Julia processes are started via an external
# mpirun, and the user does not call addprocs.

# Enter the MPI cluster manager's main loop (does not return on the workers)
function start_main_loop(mode::TransportMode=TCP_TRANSPORT_ALL;
                         comm::MPI.Comm=MPI.COMM_WORLD)
    !MPI.Initialized() && MPI.Init()
    @assert MPI.Initialized() && !MPI.Finalized()
    if mode == TCP_TRANSPORT_ALL
        # Base is handling the workers and their event loop
        # The workers have no manager object where to store the communicator.
        # TODO: Use a global variable?
        comm = MPI.COMM_WORLD
        rank = MPI.Comm_rank(comm)
        size = MPI.Comm_size(comm)
        if rank == 0
            # On the manager: Perform the usual steps
            # Create manager object
            mgr = MPIManager(np=size-1, mode=mode)
            mgr.comm = comm
            # Send connection information to all workers
            # TODO: Use Bcast
            for j in 1:size-1
                cookie = VERSION >= v"0.5.0-dev+4047" ? Base.cluster_cookie() : nothing
                MPI.send((getipaddr().host, mgr.port, cookie), j, 0, comm)
            end
            # Tell Base about the workers
            addprocs(mgr)
            return mgr
        else
            # On a worker: Receive connection information
            (obj, status) = MPI.recv(0, 0, comm)
            (host, port, cookie) = obj
            # Call the regular worker entry point
            setup_worker(host, port, cookie) # does not return
        end
    elseif mode == MPI_TRANSPORT_ALL
        comm = MPI.Comm_dup(comm)
        rank = MPI.Comm_rank(comm)
        size = MPI.Comm_size(comm)
        # We are handling the workers and their event loops on our own
        if rank == 0
            # On the manager:
            # Create manager object
            mgr = MPIManager(np=size-1, mode=mode)
            mgr.comm = comm

            # Send the cookie over. Introduced in v"0.5.0-dev+4047". Irrelevant under MPI
            # transport, but need it to satisfy the changed protocol.
            if VERSION >= v"0.5.0-dev+4047"
                MPI.bcast(Base.cluster_cookie(), 0, comm)
            end
            # Start event loop for the workers
            @schedule receive_event_loop(mgr)
            # Tell Base about the workers
            addprocs(mgr)
            return mgr
        else
            # On a worker:
            # Create a "fake" manager object since Base wants one
            mgr = MPIManager(np=size-1, mode=mode)
            mgr.comm = comm
            # Recv the cookie
            if VERSION >= v"0.5.0-dev+4047"
                cookie = MPI.bcast(nothing, 0, comm)
                Base.init_worker(cookie, mgr)
            else
                Base.init_worker(mgr)
            end
            # Start a worker event loop
            receive_event_loop(mgr)
            MPI.Finalize()
            exit()
        end
    else
        error("Unknown mode $mode")
    end
end

# Event loop for receiving data, for the MPI_TRANSPORT_ALL case
function receive_event_loop(mgr::MPIManager)
    num_send_loops = 0
    while !isready(mgr.initiate_shutdown)
        (hasdata, stat) = MPI.Iprobe(MPI.ANY_SOURCE, 0, mgr.comm)
        if hasdata
            count = Get_count(stat, UInt8)
            buf = Array(UInt8, count)
            from_rank = Get_source(stat)
            MPI.Recv!(buf, from_rank, 0, mgr.comm)

            streams = get(mgr.rank2streams, from_rank, nothing)
            if streams == nothing
                # This is the first time we communicate with this rank.
                # Set up a new connection.
                (r_s, w_s) = start_send_event_loop(mgr, from_rank)
                Base.process_messages(r_s, w_s)
                num_send_loops += 1
            else
                (r_s, w_s) = streams
            end
            write(r_s, buf)
        else
            # TODO: Need a better way to integrate with libuv's event loop
            yield()
        end
    end
    for i in 1:num_send_loops
        fetch(mgr.sending_done)
    end
    put!(mgr.receiving_done, nothing)
end

# Stop the main loop
# This function should be called by the main process only.
function stop_main_loop(mgr::MPIManager)
    if mgr.mode == TCP_TRANSPORT_ALL
        # Shut down all workers
        for i in workers()
            if i != myid()
                @spawnat i begin
                    MPI.Finalize()
                    exit()
                end
            end
        end
        # Poor man's flush of the send queue
        sleep(1)
        put!(mgr.initiate_shutdown, nothing)
        MPI.Finalize()
    elseif mgr.mode == MPI_TRANSPORT_ALL
        # Shut down all workers, but not ourselves yet
        for i in workers()
            if i != myid()
                @spawnat i begin
                    global initiate_shutdown
                    put!(initiate_shutdown, nothing)
                end
            end
        end
        # Poor man's flush of the send queue
        sleep(1)
        # Shut down ourselves
        put!(mgr.initiate_shutdown, nothing)
        wait(mgr.receiving_done)
        MPI.Finalize()
    else
        @assert false
    end
end

################################################################################
# MPI-specific communication methods

# Execute a command on all MPI ranks
# This uses MPI as communication method even if @everywhere uses TCP
function mpi_do(mgr::MPIManager, expr)
    !mgr.initialized && wait(mgr.cond_initialized)
    jpids = keys(mgr.j2mpi)
    refs = Array(Any, length(jpids))
    for (i,p) in enumerate(filter(x -> x != myid(), jpids))
        refs[i] = remotecall(expr, p)
    end
    # Execution on local process should be last, since it can block the main
    # event loop
    if myid() in jpids
        refs[end] = remotecall(expr, myid())
    end

    # Retrieve remote exceptions if any
    @sync begin
        for r in refs
            @async begin
                resp = remotecall_fetch(r.where, r) do rr
                    wrkr_result = rr[]
                    # Only return result if it is an exception, i.e. don't
                    # return a valid result of a worker computation. This is
                    # a mpi_do and not mpi_callfetch.
                    isa(wrkr_result, Exception) ? wrkr_result : nothing
                end
                isa(resp, Exception) && throw(resp)
            end
        end
    end
    nothing
end

macro mpi_do(mgr, expr)
    quote
        # Evaluate expression in Main module
        thunk = () -> (eval(Main, $(Expr(:quote, expr))); nothing)
        mpi_do($(esc(mgr)), thunk)
    end
end

# All managed Julia processes
procs(mgr::MPIManager) = sort(keys(mgr.j2mpi))

# All managed MPI ranks
mpiprocs(mgr::MPIManager) = sort(keys(mgr.mpi2j))
