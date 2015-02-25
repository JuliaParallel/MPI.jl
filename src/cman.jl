import Base.launch, Base.manage, Base.procs
export MPIManager, mpi_init, launch, manage, @mpi_do, procs, mpiprocs

type MPIManager <: ClusterManager
    np::Integer
    mpi_cmd::Cmd
    launch_timeout::Integer
    mpi2j::Dict
    j2mpi::Dict
    initialized::RemoteRef
    launched::Bool
    port::UInt16
    stdout_ios::Array

    function MPIManager(;np=Sys.CPU_CORES, mpi_cmd=false, launch_timeout=60.0)
        if mpi_cmd == false
            mpi_cmd = `mpirun -np $np`
        end
        # Start a listener for capturing stdout's from the workers
        (port, server) = listenany(11000)

        mgr = new(np, mpi_cmd, launch_timeout, Dict{Int, Int}(), Dict{Int, Int}(), RemoteRef(), false, port, IO[])
        @schedule begin
            while true
                sock = accept(server)
                push!(mgr.stdout_ios, sock)
            end
        end
        mgr

    end
end

function launch(manager::MPIManager, params::Dict, instances_arr::Array, c::Condition)
    try
        if manager.launched
            println("Reuse of an MPIManager is not allowed.")
            println("Try again with a different instance of MPIManager.")
            throw(ErrorException("Reuse of MPIManager is not allowed."))
        end


        setup_cmds = "using MPI; MPI.setup_worker($(getipaddr().host), $(manager.port))"
        out, proc = open(detach(`$(manager.mpi_cmd) $(params[:exename]) --worker=custom -e "$setup_cmds"`))

        t0=time()
        while (time() - t0) < manager.launch_timeout
            (length(manager.stdout_ios) == manager.np) && break
            sleep(1.0)
        end

        @assert length(manager.stdout_ios) == manager.np
        for io in manager.stdout_ios
            config = WorkerConfig()
            config.io = io
            push!(instances_arr, config)
            notify(c)
        end

        manager.launched = true

    catch e
        println("Error in MPI launch $e")
        rethrow(e)
    end

#   @everywhere using MPI

end

function manage(manager::MPIManager, id::Integer, config::WorkerConfig, op::Symbol)
    if op == :register
        mpi_id = remotecall_fetch(id, ()->MPI.Comm_rank(MPI.COMM_WORLD))
        manager.j2mpi[id] = mpi_id
        manager.mpi2j[mpi_id] = id

        (length(manager.j2mpi) == manager.np) && put!(manager.initialized, :DONE)
    elseif op == :finalize
#         if !isnull(config.io)
#             close(config.io)
#         end
    elseif op == :interrupt
        warn("Interrupting MPI workers is currently unsupported")
    end
end

function setup_worker(host, port)
    !MPI.Initialized() && MPI.Init()
    atexit(() -> (!MPI.Finalized()) && MPI.Finalize())

    c = connect(IPv4(host), port)
    Base.wait_connected(c)
    redirect_stdout(c)
    redirect_stderr(c)

    Base.start_worker(c)
end

macro mpi_do(manager, expr)
    quote
        mgr = $(esc(manager))
        wait(mgr.initialized)
        jpids = keys(mgr.j2mpi)
        refs = cell(length(jpids))
        for (i,p) in enumerate(jpids)
            refs[i] = remotecall(p, ()->eval(Main,$(Expr(:quote,expr))))
        end

        # wait for all of them to complete
        [wait(r) for r in refs]
        nothing
    end
end

procs(manager::MPIManager) = sort([p for p in keys(manager.j2mpi)])
mpiprocs(manager::MPIManager) = sort([p for p in keys(manager.mpi2j)])


