using MPI, Test
MPI.Init()

@test MPI.ERRORS_ARE_FATAL != MPI.ERRORS_RETURN
@test MPI.get_errhandler(MPI.COMM_SELF) == MPI.ERRORS_RETURN
@test_throws MPI.MPIError MPI.Send(rand(10), 2, 0, MPI.COMM_SELF)

MPI.set_errhandler!(MPI.COMM_SELF, MPI.ERRORS_ARE_FATAL)
@test MPI.get_errhandler(MPI.COMM_SELF) == MPI.ERRORS_ARE_FATAL

