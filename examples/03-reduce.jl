import MPI
include("03-reduce-impl.jl")

function main()
    MPI.Init()

    do_reduce()

    MPI.Finalize()
end

main()
