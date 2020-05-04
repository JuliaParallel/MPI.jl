using Test, MPI

# load test packages to trigger precompilation
using DoubleFloats
if get(ENV,"JULIA_MPI_TEST_ARRAYTYPE","") == "CuArray"
    using CuArrays
end

args = Base.shell_split(get(ENV, "JULIA_MPIEXEC_TEST_ARGS", ""))


# Code coverage command line options; must correspond to src/julia.h
# and src/ui/repl.c
const JL_LOG_NONE = 0
const JL_LOG_USER = 1
const JL_LOG_ALL = 2
const coverage_opts =
    Dict{Int, String}(JL_LOG_NONE => "none",
                      JL_LOG_USER => "user",
                      JL_LOG_ALL => "all")

function runtests()
    nprocs = clamp(Sys.CPU_THREADS, 2, 4)
    exename = joinpath(Sys.BINDIR, Base.julia_exename())
    testdir = dirname(@__FILE__)
    istest(f) = endswith(f, ".jl") && startswith(f, "test_")
    testfiles = sort(filter(istest, readdir(testdir)))

    nfail = 0
    printstyled("Running MPI.jl tests\n"; color=:white)
    
    for f in testfiles
        coverage_opt = coverage_opts[Base.JLOptions().code_coverage]
        mpiexec() do cmd
            cmd = `$cmd $args`
            if f == "test_spawn.jl"
                run(`$cmd -n 1 $exename --code-coverage=$coverage_opt $(joinpath(testdir, f))`)
            elseif f == "test_threads.jl"
                withenv("JULIA_NUM_THREAD" => "4") do
                    run(`$cmd -n $nprocs $exename --code-coverage=$coverage_opt $(joinpath(testdir, f))`)
                end
            else
                run(`$cmd -n $nprocs $exename --code-coverage=$coverage_opt $(joinpath(testdir, f))`)
            end
        end
        Base.with_output_color(:green,stdout) do io
            println(io,"\tSUCCESS: $f")
        end
    end
    return nfail
end

exit(runtests())
