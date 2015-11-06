using Base.Test

info("DEBUG MPI BUILD")

pth = joinpath(Pkg.dir(), "MPI/deps/usr/lib/")
run(`ls -l $pth`)

pth = joinpath(Pkg.dir(), "MPI/deps/src")
run(`ls -l $pth`)

info("END")

# Code coverage command line options; must correspond to src/julia.h
# and src/ui/repl.c
const JL_LOG_NONE = 0
const JL_LOG_USER = 1
const JL_LOG_ALL = 2
const coverage_opts =
    Dict{Int, ASCIIString}(JL_LOG_NONE => "none",
                           JL_LOG_USER => "user",
                           JL_LOG_ALL => "all")

function runtests()
    nprocs = clamp(CPU_CORES, 2, 4)
    exename = joinpath(JULIA_HOME, Base.julia_exename())
    testdir = dirname(@__FILE__)
    istest(f) = endswith(f, ".jl") && f != "runtests.jl"
    testfiles = sort(filter(istest, readdir(testdir)))
    nfail = 0
    print_with_color(:white, "Running MPI.jl tests\n")
    for f in testfiles
        try
            coverage_opt = coverage_opts[Base.JLOptions().code_coverage]
            run(`mpirun -np $nprocs $exename --code-coverage=$coverage_opt $(joinpath(testdir, f))`)
            Base.with_output_color(:green,STDOUT) do io
                println(io,"\tSUCCESS: $f")
            end
        catch ex
            Base.with_output_color(:red,STDERR) do io
                println(io,"\tError: $(joinpath(testdir, f))")
                showerror(io,ex,backtrace())
            end
            nfail += 1
        end
    end
    return nfail
end

exit(runtests())
