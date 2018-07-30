using MPI
using Test

using Compat
import Compat.String
import Compat.Sys: BINDIR

# Code coverage command line options; must correspond to src/julia.h
# and src/ui/repl.c
const JL_LOG_NONE = 0
const JL_LOG_USER = 1
const JL_LOG_ALL = 2
const coverage_opts =
    Dict{Int, String}(JL_LOG_NONE => "none",
                      JL_LOG_USER => "user",
                      JL_LOG_ALL => "all")

# Files to run without mpiexec
juliafiles = ["test_cman_julia.jl"]
# Files to run with mpiexec -n 1
singlefiles = ["test_spawn.jl"]

excludedfiles = []
if Sys.iswindows()
    push!(excludedfiles, "test_info.jl")
    push!(excludedfiles, "test_onesided.jl")
    push!(excludedfiles, "test_finalize_atexit.jl")
    if Sys.WORD_SIZE == 32
        push!(excludedfiles, "test_spawn.jl")
    end
end

function runtests()
    nprocs = clamp(Sys.CPU_THREADS, 2, 4)
    exename = joinpath(BINDIR, Base.julia_exename())
    testdir = dirname(@__FILE__)
    istest(f) = endswith(f, ".jl") && startswith(f, "test_")
    testfiles = sort(filter(istest, readdir(testdir)))

    extra_args = []
    @static if !Compat.Sys.iswindows()
      if Compat.occursin( "OpenRTE", Compat.open(f->read(f, String),`mpiexec --version`))
            push!(extra_args,"--oversubscribe")
        end
    end

    nfail = 0
    Compat.printstyled("Running MPI.jl tests\n"; color=:white)
    for f in testfiles
        if f ∈ excludedfiles
            println("Skipping disabled test $f")
            continue
        end
        try
            coverage_opt = coverage_opts[Base.JLOptions().code_coverage]
            if f ∈ singlefiles
                run(`mpiexec $extra_args -n 1 $exename --code-coverage=$coverage_opt $(joinpath(testdir, f))`)
            elseif f ∈ juliafiles
                run(`$exename --code-coverage=$coverage_opt $(joinpath(testdir, f))`)
            else
                run(`mpiexec $extra_args -n $nprocs $exename --code-coverage=$coverage_opt $(joinpath(testdir, f))`)
            end
            Base.with_output_color(:green,stdout) do io
                println(io,"\tSUCCESS: $f")
            end
        catch ex
            Base.with_output_color(:red,stderr) do io
                println(io,"\tError: $(joinpath(testdir, f))")
                showerror(io,ex,backtrace())
            end
            nfail += 1
        end
    end
    return nfail
end

exit(runtests())
