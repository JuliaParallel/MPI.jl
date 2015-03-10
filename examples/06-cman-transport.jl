using MPI

comm, comm_size, rank = MPI.init_mpi()

include("01-hello-impl.jl")
include("02-broadcast-impl.jl")
include("03-reduce-impl.jl")
include("04-sendrecv-impl.jl")

if length(ARGS) == 0
    print("Please specify a transport option to use [MPI|TCP]\n")
    exit()
elseif ARGS[1] == "TCP"
    manager = MPI.start(TCP_TRANSPORT_ALL) # does not return on worker
elseif ARGS[1] == "MPI"
    manager = MPI.start(MPI_TRANSPORT_ALL) # does not return on worker
else
    print("Valid transport options are [MPI|TCP]\n")
    exit()
end

if rank == 0
    nloops = 10^2
    function foo(n)
        a=ones(n)
        remotecall_fetch(2, x->x, a);

        @elapsed for i in 1:nloops
            remotecall_fetch(2, x->x, a)
        end
    end

    n=10^3
    foo(1)
    t=foo(n)
    println("$t seconds for $nloops loops of send-recv of array size $n")

    n=10^6
    foo(1)
    t=foo(n)
    println("$t seconds for $nloops loops of send-recv of array size $n")


    print("EXAMPLE: HELLO\n")
    @mpi_do manager do_hello()
    print("EXAMPLE: BROADCAST\n")
    @mpi_do manager do_broadcast()
    print("EXAMPLE: REDUCE\n")
    @mpi_do manager do_reduce()
    print("EXAMPLE: SENDRECV\n")
    @mpi_do manager do_sendrecv()

    # Abscence of a MPI Finalize causes the cluster to hang - don't yet know why
    if ARGS[1] == "TCP"
        @mpi_do manager MPI.Finalize()
    elseif ARGS[1] == "MPI"
        @everywhere (MPI.Finalize(); exit())
    end
end
