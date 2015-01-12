import MPI
include("04-sendrecv-impl.jl")

function main()
    MPI.Init()

    do_sendrecv()

    MPI.Finalize()
end

main()
