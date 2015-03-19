using Base.Test

function runtests()
    nprocs = min(4, CPU_CORES)
    exename = joinpath(JULIA_HOME, Base.julia_exename())
    testfiles = sort(filter(x->x!="runtests.jl", readdir(dirname(@__FILE__))))
    nfail = 0
    for f in testfiles
        nfail += !success(`mpirun -np $nprocs $exename $f`)
    end
    return nfail
end

exit(runtests())
