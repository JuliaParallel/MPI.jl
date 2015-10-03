import Base: launch, manage, procs, connect
export MPIManager, launch, manage, @mpi_do, procs, mpiprocs, start
export MPI_ON_WORKERS, TCP_TRANSPORT_ALL, MPI_TRANSPORT_ALL

const MPI_ON_WORKERS = 0
const MPI_TRANSPORT_ALL  = 1
const TCP_TRANSPORT_ALL  = 2

type MPIManager <: ClusterManager
    np::Integer
    mpi2j::Dict
    j2mpi::Dict
    mode::Int

    mpi_cmd::Cmd

    launch_timeout::Integer
    initialized::Bool
    cond_initialized::Condition
    launched::Bool

    # TCP Transport
    port::UInt16
    stdout_ios::Array

    # MPI transport
    id_to_streams::Dict
    ranks::Array


    function MPIManager(;np=Sys.CPU_CORES, mpi_cmd=false, launch_timeout=60.0, mode=MPI_ON_WORKERS)
        launched = false

        if mode != MPI_ON_WORKERS
            launched = true
            mpi_cmd = ``
        elseif mpi_cmd == false
            mpi_cmd = `mpirun -np $np`
        end

        mgr = new(np, Dict{Int, Int}(), Dict{Int, Int}(), mode, mpi_cmd, launch_timeout, false, Condition(), launched)

        if mode != MPI_TRANSPORT_ALL
            # Start a listener for capturing stdout's from the workers
            (port, server) = listenany(11000)
            @schedule begin
                while true
                    sock = accept(server)
                    push!(mgr.stdout_ios, sock)
                end
            end
            mgr.port = port
            mgr.stdout_ios = IO[]
        else
            mgr.id_to_streams = Dict()
            comm, comm_size, rank = comm_info()
            mgr.ranks = [i for i in 1:(comm_size-1)]
        end

        return mgr
    end
end

function launch(manager::MPIManager, params::Dict, instances_arr::Array, c::Condition)
    try
        if manager.mode == MPI_ON_WORKERS
            if manager.launched
                println("Reuse of an MPIManager is not allowed.")
                println("Try again with a different instance of MPIManager.")
                throw(ErrorException("Reuse of MPIManager is not allowed."))
            end

            setup_cmds = "using MPI; MPI.setup_worker($(getipaddr().host), $(manager.port))"
            open(detach(`$(manager.mpi_cmd) $(params[:exename]) -e "$setup_cmds"`))
        end

        if manager.mode != MPI_TRANSPORT_ALL
            t0=time()
            while (time() - t0) < manager.launch_timeout
                (length(manager.stdout_ios) == manager.np) && break
                sleep(1.0)
            end

            @assert length(manager.stdout_ios) == manager.np

            configs = Array(WorkerConfig, manager.np)
            @sync begin
                for io in manager.stdout_ios
                    @async let io=io
                        config = WorkerConfig()
                        config.io = io

                        # Add it to the right slot so that MPI ranks and Julia pids are in the same order
                        rank = Base.deserialize(io)
                        idx = (manager.mode == MPI_ON_WORKERS ? rank+1 : rank)
                        configs[idx] = config
                    end
                end
            end

            append!(instances_arr, configs)
            notify(c)

            manager.launched = true
        else
            for cnt in 1:manager.np
                push!(instances_arr, WorkerConfig())
            end
            notify(c)
        end

    catch e
        println("Error in MPI launch $e")
        rethrow(e)
    end

#   @everywhere using MPI

end

function manage(manager::MPIManager, id::Integer, config::WorkerConfig, op::Symbol)
    if op == :register
        mpi_id = remotecall_fetch(()->MPI.Comm_rank(MPI.COMM_WORLD), id)
        manager.j2mpi[id] = mpi_id
        manager.mpi2j[mpi_id] = id

        if length(manager.j2mpi) == manager.np
            manager.initialized = true
            notify(manager.cond_initialized)
            if manager.mode != MPI_ON_WORKERS
                manager.j2mpi[1] = 0
                manager.mpi2j[0] = 1
            end
        end
    elseif op == :finalize
#         if !isnull(config.io)
#             close(config.io)
#         end
    elseif op == :interrupt
#        warn("Interrupting MPI workers is currently unsupported")
    end
end

function setup_worker(host, port)
    comm, comm_size, rank = init_mpi()

    c = connect(IPv4(host), port)
    Base.wait_connected(c)
    redirect_stdout(c)
    redirect_stderr(c)

    Base.serialize(c, rank)

    Base.start_worker(c)
end

macro mpi_do(manager, expr)
    quote
        mgr = $(esc(manager))
        !mgr.initialized && wait(mgr.cond_initialized)
        jpids = keys(mgr.j2mpi)
        refs = cell(length(jpids))
        for (i,p) in enumerate(filter(x->x!=myid(), jpids))
            refs[i] = remotecall(()->eval(Main,$(Expr(:quote,expr))), p)
        end
        # Execution on local process should be last, since it can block the main event loop
        if myid() in jpids
            refs[end] = remotecall(()->eval(Main,$(Expr(:quote,expr))), myid())
        end

        [wait(r) for r in refs]
        nothing
    end
end

procs(manager::MPIManager) = sort([p for p in keys(manager.j2mpi)])
mpiprocs(manager::MPIManager) = sort([p for p in keys(manager.mpi2j)])


function start(mode=TCP_TRANSPORT_ALL)
    comm, comm_size, rank = init_mpi()
    if mode == TCP_TRANSPORT_ALL
        if rank == 0
            cman = MPIManager(;np=comm_size-1, mode=TCP_TRANSPORT_ALL)
            for j in 1:(comm_size-1)
                MPI.send((getipaddr().host, cman.port), j, j, comm)
            end

            addprocs(cman)
            return cman
         else
            (obj, status) = MPI.recv(0, rank, comm)
            (host, port) = obj
            setup_worker(host, port) # does not return
         end
     elseif mode == MPI_TRANSPORT_ALL
        if rank == 0
            cman = MPIManager(;np=comm_size-1, mode=MPI_TRANSPORT_ALL)
            @schedule main_loop(cman, comm)
            addprocs(cman)
            return cman
        else
            cman = MPIManager(;np=comm_size-1, mode=MPI_TRANSPORT_ALL)
            Base.init_worker(cman)
            main_loop(cman, comm) # does not return
        end
     else
        error("Unknown Mode $mode")
     end
end

function main_loop(manager, comm)
    while !MPI.Finalized()
        (hasdata, stat) = MPI.Iprobe(ANY_SOURCE, 0, comm)
        if hasdata
            count = Get_count(stat, UInt8)
            buf = Array(UInt8, count)
            from_rank = Get_source(stat)
            MPI.Recv!(buf, from_rank, 0, comm)

            streams = get(manager.id_to_streams, from_rank, nothing)
            if streams == nothing
                # First time..
                (r_s, w_s) = setup_connection(manager, from_rank)
                Base.process_messages(r_s, w_s)
            else
                (r_s, w_s) = streams
            end
            write(r_s, buf)
        else
            # FIXME : Need a better way to integrate with libuv's event loop
            yield()
        end
    end
end

function setup_connection(manager, to_rank)
    try
        r_s=BufferStream()
        w_s=BufferStream()

        manager.id_to_streams[to_rank] = (r_s, w_s)

        @schedule begin
            comm, comm_size, rank = comm_info()
            while !MPI.Finalized()
                if nb_available(w_s) > 0
                    data = takebuf_array(w_s.buffer)
                    !MPI.Finalized() && MPI.Isend(data, to_rank, 0, comm)
                else
                    yield()
                end
            end
        end
        (r_s, w_s)
    catch e
        Base.show_backtrace(STDOUT,catch_backtrace())
        println(e)
        rethrow(e)
    end
end


function init_mpi()
    !MPI.Initialized() && MPI.Init()
    atexit(() -> (!MPI.Finalized()) && MPI.Finalize())

    return comm_info()
end

function comm_info()
    comm = MPI.COMM_WORLD
    comm_size = MPI.Comm_size(comm)
    rank = MPI.Comm_rank(comm)

    (comm, comm_size, rank)
end

function connect(manager::MPIManager, pid::Int, config::WorkerConfig)
    if manager.mode != MPI_TRANSPORT_ALL
        return invoke(connect, (ClusterManager, Int, WorkerConfig), manager, pid, config)
    end

    comm, comm_size, rank = comm_info()
    if rank == 0
        to_rank = pop!(manager.ranks)
        config.connect_at = to_rank
        return setup_connection(manager, to_rank)
    else
        return setup_connection(manager, get(config.connect_at))
    end
end

