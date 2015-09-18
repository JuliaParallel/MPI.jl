using Base.Test

function runtests()
    nprocs = min(4, CPU_CORES)
    exename = joinpath(JULIA_HOME, Base.julia_exename())
    testdir = dirname(@__FILE__)
    testfiles = sort(filter(x->x!="runtests.jl", readdir(testdir)))
    nfail = 0
    print_with_color(:white, "Running MPI.jl tests\n")
    for f in testfiles
        try
            run(`mpirun -np $nprocs $exename $(joinpath(testdir, f))`)
            if success(`mpirun -np $nprocs $exename $(joinpath(testdir, f))`)
                Base.with_output_color(:green,STDOUT) do io
                    println(io,"\tSUCCESS: $f")
                end
            else
                Base.with_output_color(:red,STDERR) do io
                    println(io, "\tFAILED: $(joinpath(testdir, f))")
                end
                nfail += 1
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
