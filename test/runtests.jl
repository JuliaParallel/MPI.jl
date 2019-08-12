using Pkg
pkg"precompile"

using MPI
using Test

import MPI: mpiexec

# Code coverage command line options; must correspond to src/julia.h
# and src/ui/repl.c
const JL_LOG_NONE = 0
const JL_LOG_USER = 1
const JL_LOG_ALL = 2
const coverage_opts =
    Dict{Int, String}(JL_LOG_NONE => "none",
                      JL_LOG_USER => "user",
                      JL_LOG_ALL => "all")

# Files to run with mpiexec -n 1
singlefiles = ["test_spawn.jl"]

function runtests()
    nprocs = clamp(Sys.CPU_THREADS, 2, 4)
    exename = joinpath(Sys.BINDIR, Base.julia_exename())
    testdir = dirname(@__FILE__)
    istest(f) = endswith(f, ".jl") && startswith(f, "test_")
    testfiles = sort(filter(istest, readdir(testdir)))
    extra_args = []
    @static if !Sys.iswindows()
        if occursin( "OpenRTE", read(`$mpiexec --version`, String))
            push!(extra_args,"--oversubscribe")
        end
    end

    nfail = 0
    printstyled("Running MPI.jl tests\n"; color=:white)
    
    for f in testfiles
        coverage_opt = coverage_opts[Base.JLOptions().code_coverage]
        if f ∈ singlefiles
            run(`$mpiexec $extra_args -n 1 $exename --code-coverage=$coverage_opt $(joinpath(testdir, f))`)
        else
            run(`$mpiexec $extra_args -n $nprocs $exename --code-coverage=$coverage_opt $(joinpath(testdir, f))`)
        end
        Base.with_output_color(:green,stdout) do io
            println(io,"\tSUCCESS: $f")
        end
    end
    return nfail
end

exit(runtests())
