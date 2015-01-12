import Base.launch, Base.manage, Base.procs
export MPIManager, mpi_init, launch, manage, @mpi_do, procs, mpiprocs

type MPIManager <: ClusterManager
    np::Integer
    mpi_cmd::Cmd
    output_filename::String
    launch_timeout::Integer
    mpi2j::Dict
    j2mpi::Dict
    initialized::RemoteRef
    launched::Bool

    function MPIManager(;np=Sys.CPU_CORES, mpi_cmd=false, output_filename=tempname(), launch_timeout=60.0)
        if mpi_cmd == false
            mpi_cmd = `mpirun -np $np --output-filename $output_filename`
        end
        l_path = tempname()
        l_socket = listen(l_path)

        new(np, mpi_cmd, output_filename, launch_timeout, Dict{Int, Int}(), Dict{Int, Int}(), RemoteRef(), false)
    end
end

function launch(manager::MPIManager, params::Dict, instances_arr::Array, c::Condition)
    try
        if manager.launched
            println("Reuse of an MPIManager is not allowed.")
            println("Try again with a different instance of MPIManager.")
            throw(ErrorException("Reuse of MPIManager is not allowed."))
        end

        setup_cmds = "using MPI; (!MPI.Initialized()) && MPI.Init(); atexit(() -> (!MPI.Finalized()) && MPI.Finalize()); Base.start_worker()"

        out, proc = open(detach(`$(manager.mpi_cmd) $(params[:exename]) -e "$setup_cmds" --worker`))

        # Get list of files with the same prefix as output_filename
        output_dir = dirname(manager.output_filename)

        t0=time()
        allf = []
        while (time() - t0) < manager.launch_timeout
            allf = filter(x->startswith(x, basename(manager.output_filename)), readdir(output_dir))
            (length(allf) == manager.np) && break
            sleep(1.0)
        end

        @assert length(allf) == manager.np
        for f in allf
            config = WorkerConfig()
            io, proc = open(`tail -f $output_dir/$f`)
            finalizer(proc, (x)->kill(x))
            config.io = io
            config.userdata = proc
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


