import Base.launch, Base.manage
export MPIManager, mpi_init, launch, manage, @mpi_do

type MPIManager <: ClusterManager
    np::Integer
    launch_cmd::Cmd
    output_filename::String
    launch_timeout::Integer
    map_mpi_julia::Dict
    map_julia_mpi::Dict
    l_socket
    l_path

    function MPIManager(;np=Sys.CPU_CORES, launch_cmd=false, output_filename=tempname(), launch_timeout=60.0)
        if launch_cmd == false
            launch_cmd = `mpirun -np $np --output-filename $output_filename julia --worker`
        end
        l_path = tempname()
        l_socket = listen(l_path)

        new(np, launch_cmd, output_filename, launch_timeout, Dict{Int, Int}(), Dict{Int, Int}(), l_socket, l_path)
    end
end

function launch(manager::MPIManager, params::Dict, instances_arr::Array, c::Condition)
    try
        out, proc = open(detach(manager.launch_cmd))

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
    catch e
        println("Error in MPI launch $e")
        rethrow(e)
    end

#   @everywhere using MPI

end

function manage(manager::MPIManager, id::Integer, config::WorkerConfig, op::Symbol)
    if op == :finalize
#         if !isnull(config.io)
#             close(config.io)
#         end
    elseif op == :interrupt
        warn("Interrupting MPI workers is currently unsupported")
    end
end

macro mpi_do(ex)
    quote
        @sync begin
            for p in workers()
                @spawnat p $ex
            end
        end
    end
end


function mpi_init(manager::MPIManager)
    refs=cell(nworkers())
    for (i,p) in enumerate(workers())
        rr = remotecall(p, ()-> begin
            MPI.Init()
            atexit(MPI.Finalize)
            MPI.Comm_rank(MPI.COMM_WORLD)
        end)
        refs[i] = (rr, p)
    end

    for i in 1:nworkers()
        mpi_id = fetch(refs[i][1])
        manager.map_mpi_julia[mpi_id] = refs[i][2]
        manager.map_mpi_julia[refs[i][2]] = mpi_id
    end
end

