using Test, MPI

# load test packages to trigger precompilation
using DoubleFloats
if get(ENV,"JULIA_MPI_TEST_ARRAYTYPE","") == "CuArray"
    using CuArrays
end

# This test doesn't need to be run with mpiexec
include("mpiexecjl.jl")

args = Base.shell_split(get(ENV, "JULIA_MPIEXEC_TEST_ARGS", ""))

function runtests()
    nprocs = clamp(Sys.CPU_THREADS, 2, 4)
    testdir = dirname(@__FILE__)
    istest(f) = endswith(f, ".jl") && startswith(f, "test_")
    testfiles = sort(filter(istest, readdir(testdir)))

    nfail = 0
    printstyled("Running MPI.jl tests\n"; color=:white)
    
    for f in testfiles
        mpiexec() do cmd
            cmd = `$cmd $args`
            if f == "test_spawn.jl"
                run(`$cmd -n 1 $(Base.julia_cmd()) $(joinpath(testdir, f))`)
            elseif f == "test_threads.jl"
                withenv("JULIA_NUM_THREAD" => "4") do
                    run(`$cmd -n $nprocs $(Base.julia_cmd()) $(joinpath(testdir, f))`)
                end
            else
                run(`$cmd -n $nprocs $(Base.julia_cmd()) $(joinpath(testdir, f))`)
            end
        end
        Base.with_output_color(:green,stdout) do io
            println(io,"\tSUCCESS: $f")
        end
    end
    return nfail
end

exit(runtests())
