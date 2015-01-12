import MPI
include("01-hello-impl.jl")

function main()
    MPI.Init()

    do_hello()

    MPI.Finalize()
end

main()
