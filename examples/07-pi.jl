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
    pihat = 4.*float((norm(rand(2,1)) .< 1.))
end

# this function reports intermediate results during MC runs
function pi_monitor(sofar, results)
    # examine results every 2.5*10^5 draws
    if mod(sofar,2.5e5)==0.
        m = mean(results[1:sofar,:],1)
        println("reps so far: ", sofar)
        println("pihat: ", m)
        println()
        #if sofar == size(results,1)
        #    writedlm("mcresults.out", results)
        #end
    end
end    

# do the monte carlo: 10^6 reps of single draws
function main()
    reps = Int(1e6)  # desired number of MC reps
    nreturns = 1
    pooled = Int(50000)
    montecarlo(pi_wrapper, pi_monitor, reps, nreturns, pooled)
end

main()
