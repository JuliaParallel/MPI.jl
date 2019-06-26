using Test
using MPI

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

# assuming there are at least two processes
x = rank == 0 ? collect(reshape(1.0:16.0, 4, 4)) : zeros(4, 4)

subarray = MPI.Type_Create_Subarray(2,
                                    Cint[4, 4],
                                    Cint[2, 2],
                                    Cint[0, 0],
                                    MPI.MPI_ORDER_FORTRAN,
                                    Float64)
MPI.Type_Commit!(subarray)

# test blocking send
if rank == 0
    MPI.Send(x, 1, subarray, 1, 0, comm)
elseif rank == 1
    MPI.Recv!(x, 1, subarray, 0, 0, comm)
    @test x == [1 5 0 0;
                2 6 0 0;
                0 0 0 0;
                0 0 0 0]
end

# test non blocking send
if rank == 0
    MPI.Isend(x, 1, subarray, 1, 0, comm)
elseif rank == 1
    req = MPI.Irecv!(x, 1, subarray, 0, 0, comm)
    MPI.Wait!(req)
    @test x == [1 5 0 0;
                2 6 0 0;
                0 0 0 0;
                0 0 0 0]
end

MPI.Finalize()
