using MPI, Distributed

MPI.Init()
rank = MPI.Comm_rank(MPI.COMM_WORLD)
size = MPI.Comm_size(MPI.COMM_WORLD)

include("01-hello-impl.jl")
include("02-broadcast-impl.jl")
include("03-reduce-impl.jl")
include("04-sendrecv-impl.jl")

if length(ARGS) == 0
    println("Please specify a transport option to use [MPI|TCP]")
    MPI.Finalize()
    exit(1)
elseif ARGS[1] == "TCP"
    manager = MPI.start_main_loop(TCP_TRANSPORT_ALL) # does not return on worker
elseif ARGS[1] == "MPI"
    manager = MPI.start_main_loop(MPI_TRANSPORT_ALL) # does not return on worker
else
    println("Valid transport options are [MPI|TCP]")
    MPI.Finalize()
    exit(1)
end

# Check whether a worker accidentally returned
@assert rank == 0

nloops = 10^2
function foo(n)
    a=ones(n)
    remotecall_fetch(x->x, mod1(2, size), a);
    @elapsed for i in 1:nloops
        remotecall_fetch(x->x, mod1(2, size), a)
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

# We cannot run these examples since they use MPI.Barrier and other blocking
# communication, disabling our event loop
# print("EXAMPLE: HELLO\n")
# @mpi_do manager do_hello()
# print("EXAMPLE: BROADCAST\n")
# @mpi_do manager do_broadcast()
# print("EXAMPLE: REDUCE\n")
# @mpi_do manager do_reduce()
# print("EXAMPLE: SENDRECV\n")
# @mpi_do manager do_sendrecv()

MPI.stop_main_loop(manager)
