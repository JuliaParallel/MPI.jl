import MPI

function main()
    MPI.init()

    comm = MPI.COMM_WORLD

    MPI.barrier(comm)

    rank = MPI.rank(comm)
    size = MPI.size(comm)

    dst = mod(rank+1, size)
    src = mod(rank-1, size)

    N = 4

    send_mesg = Array(Float64, N)
    recv_mesg = Array(Float64, N)

    fill!(send_mesg, float64(rank))

    rreq = MPI.Irecv!(recv_mesg, src,  src+32, comm)

    println("$rank: Sending   $rank -> $dst = $send_mesg")
    sreq = MPI.Isend!(send_mesg, dst, rank+32, comm)

    stats = MPI.waitall!([rreq, sreq])

    println("$rank: Receiving $src -> $rank = $recv_mesg")

    MPI.barrier(comm)
   
    MPI.finalize()
end

main()
