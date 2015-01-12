import MPI
include("02-broadcast-impl.jl")

function main()
    MPI.Init()

    do_broadcast()

    MPI.Finalize()
end

main()
