include("common.jl")

MPI.Init()

# initialise communicator variables
comm = MPI.COMM_WORLD
comm_rank = MPI.Comm_rank(comm)
comm_size = MPI.Comm_size(comm) 

# cartesian comunicator topology
comm_cart = MPI.Cart_create(comm, (comm_size,); periodic=(true,), reorder=false)
src_rank, dest_rank = MPI.Cart_shift(comm_cart, 0, -1)

# construct buffers
sendbuf = Float64[comm_rank, comm_rank, comm_rank]
recvbuf = Float64[       -1,        -1,        -1]

# send entire buffer
req = MPI.Isendrecv!(sendbuf, recvbuf, comm_cart;
        dest=dest_rank, sendtag=10, source=src_rank, recvtag=10)

@test req isa MPI.Request
@test !isnothing(req.buffer)

status = MPI.Wait(req, MPI.Status)

# ! doesn't work with MPICH backend
@test_broken MPI.Get_source(status) == src_rank
@test_broken MPI.Get_tag(status) == 10
@test recvbuf == [((comm_rank+1) % comm_size) for _ in 1:length(recvbuf)]

# compare to blocking Sendrecv!
a = Float64[comm_rank, comm_rank, comm_rank]
b = Float64[       -1,        -1,        -1]
MPI.Sendrecv!(a, b, comm_cart;
        dest=dest_rank, sendtag=11, source=src_rank, recvtag=11)
@test b == recvbuf

MPI.Finalize()
