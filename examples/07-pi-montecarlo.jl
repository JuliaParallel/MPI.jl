#=
Simple example of use of montecarlo.jl
From the system prompt, execute
mpirun -np X julia pi_mpi.jl
setting X to the number of ranks you'd
like to use, subject to  X-1 being an even divisor
of 1e6, e.g., set X=5.
=#

include("montecarlo.jl")

function pi_wrapper()
    4.0 * (norm(rand(2)) < 1)
end

# this function reports intermediate results during MC runs
function pi_monitor(sofar, results)
    # Examine results every 12.5*10^5 draws
    if mod(sofar, 10^6) == 0
        m = mean(results[1:sofar,:],1)
        println("reps: $sofar, pihat: $m")
    end
end

# do the monte carlo: 10^6 reps of single draws
function main()
    MPI.Init()
    n_evals = 10^7 # desired number of MC reps
    n_returns = 1
    batchsize = 10^5
    montecarlo(pi_wrapper, pi_monitor,
               MPI.COMM_WORLD, n_evals, n_returns, batchsize)
    MPI.Finalize()
end

main()
