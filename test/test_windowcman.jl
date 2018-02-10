const using_mpi = (nprocs() == 1)

if using_mpi
    using MPI
    using Base.Test
    transport_mode = MPI.MPI_WINDOW_IO # This test can run with MPPI_TRANSPORT_ALL and MPI_WINDOW_IO
    mgr = MPI.start_main_loop(transport_mode)
    @everywhere const comm = MPI.COMM_WORLD
    rank = MPI.Comm_rank(comm)
    size = MPI.Comm_size(comm)
else
    @everywhere using Base.Test
end

@everywhere const N = nprocs()

if using_mpi
    @test N == size
end

@test procs() == collect(1:N)
if N > 1
    @test workers() == collect(2:N)
end

results = Vector{Any}(N)
for i in 1:N
    results[i] = remotecall(myid, i)
end

for i in 1:N
    @test fetch(results[i]) == i
end

@everywhere function test_nprocs()
    @test N == nprocs()
end
for i in 1:N
    remotecall_wait(test_nprocs, i)
end

results = zeros(Int, N)
for i in 1:N
  results[i] = fetch(@spawnat i myid() + 1)
end
for i in 1:N
    @test results[i] == i+1
end

# Check if DistributedArrays is available
has_arrays = true
try
    @everywhere using DistributedArrays
catch e
    has_arrays = false
end

if has_arrays
    @everywhere begin
        const ARRSIZE = 1024^2*100
        @test ARRSIZE % N == 0
        
        function myrange()
            my_nb_indices = ARRSIZE ÷ N
            range_start = ((myid()-1)*my_nb_indices+1)
            return range_start:range_start+my_nb_indices-1
        end
    end

    const d_arr = dfill(1,(ARRSIZE,), procs(), (N,))
    for i in 1:N
        @test fetch(@spawnat i localindexes(d_arr))[1] == remotecall_fetch(myrange, i)
    end

    println("Normal array sum timings:")
    const arr = fill(1,ARRSIZE)
    @test sum(arr) == ARRSIZE
    @time sum(arr)
    @time sum(arr)
    @time sum(arr)

    println("DArray sum timings:")
    @test sum(d_arr) == ARRSIZE
    @time sum(d_arr)
    @time sum(d_arr)
    @time sum(d_arr)

    @everywhere const my_arr = fill(1*myid(),ARRSIZE ÷ N)
    
    @everywhere function do_sum(result)
        put!(result, sum(my_arr))
        return
    end

    function collect_sum()
        result = sum(my_arr)
        result_chan = RemoteChannel(()->Channel{Int}(N-1))
        for p in workers()
            remote_do(do_sum, p, result_chan)
        end
        nb_collected = 0
        while nb_collected != N-1
            result += take!(result_chan)
            nb_collected += 1
        end
        return result
    end

    println("Split array sum timings:")
    @test collect_sum() == sum((ARRSIZE ÷ N) * (1:N))
    @time collect_sum()
    @time collect_sum()
    @time collect_sum()

    if using_mpi
        @everywhere function mpi_sum()
            global my_arr
            my_sum = [0]
            for x in my_arr
                my_sum[1] += x
            end
            return MPI.Reduce(my_sum, MPI.SUM, 0, comm)
        end

        function do_mpi_sum()
            for w in workers()
                @spawnat w mpi_sum()
            end
            return mpi_sum()[1]
        end
        
        println("MPI_Reduce sum timings:")
        @test do_mpi_sum() == sum((ARRSIZE ÷ N) * (1:N))
        @time do_mpi_sum()
        @time do_mpi_sum()
        @time do_mpi_sum()
    end
end

const the_channel = RemoteChannel()
for p in workers()
    @spawnat p put!(the_channel, myid())
end

chan_results = []
for i in 2:N
    push!(chan_results, take!(the_channel))
end
@test sort(chan_results) == workers()

if using_mpi
    MPI.stop_main_loop(mgr)
end