using MPI

const DIR = @__DIR__

MPI.mpiexec() do cmd
    @info "Running pingpong.jl"
    run(pipeline(`$cmd -n 2 $(Base.julia_cmd()) --project=$DIR $(joinpath(DIR, "pingpong.jl"))`,
                 stdout=joinpath(DIR, "julia.csv")))
    
    @info "Running pingpong-generic.jl"
    run(pipeline(`$cmd -n 2 $(Base.julia_cmd()) --project=$DIR $(joinpath(DIR, "pingpong-generic.jl"))`,
                 stdout=joinpath(DIR, "julia-generic.csv")))
    
    @info "Running pingpong.py"
    run(pipeline(`$cmd -n 2 python3 $(joinpath(DIR, "pingpong.py"))`,
                 stdout=joinpath(DIR, "python.csv")))
    
    @info "Running pingpong-generic.py"
    run(pipeline(`$cmd -n 2 python3 $(joinpath(DIR, "pingpong-generic.py"))`,
                 stdout=joinpath(DIR, "python-generic.csv")))
    
    @info "Running pingpong.c"
    run(`mpicc -std=c99 $(joinpath(DIR, "pingpong.c")) -o $(joinpath(DIR, "pingpong"))`)
    run(pipeline(`$cmd -n 2 $(joinpath(DIR, "pingpong"))`,
                 stdout=joinpath(DIR, "c.csv")))


    @info "Running bench-serialize.jl"
    run(pipeline(`$(Base.julia_cmd()) --project=$DIR $(joinpath(DIR, "bench-serialize.jl"))`,
                 stdout=joinpath(DIR, "serialize.csv")))

    @info "Running bench-pickle.jl"
    run(pipeline(`python3 $(joinpath(DIR, "bench-pickle.py"))`,
                 stdout=joinpath(DIR, "pickle.csv")))
end
