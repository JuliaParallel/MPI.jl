function do_sendrecv()

    comm = MPI.COMM_WORLD

    MPI.Barrier(comm)

    rank = MPI.Comm_rank(comm)
    size = MPI.Comm_size(comm)

    dst = mod(rank+1, size)
    src = mod(rank-1, size)

    N = 4

    send_mesg = Array{Float64}(undef, N)
    recv_mesg = Array{Float64}(undef, N)

    fill!(send_mesg, Float64(rank))

    rreq = MPI.Irecv!(recv_mesg, src,  src+32, comm)

    println("$rank: Sending   $rank -> $dst = $send_mesg")
    sreq = MPI.Isend(send_mesg, dst, rank+32, comm)

    stats = MPI.Waitall!([rreq, sreq])

    println("$rank: Receiving $src -> $rank = $recv_mesg")

    MPI.Barrier(comm)
end
