using MPI, Test
MPI.Init()

@test MPI.ERRORS_ARE_FATAL != MPI.ERRORS_RETURN
@test MPI.get_errorhandler(MPI.COMM_SELF) == MPI.ERRORS_RETURN
@test_throws MPI.MPIError MPI.Send(rand(10), 2, 0, MPI.COMM_SELF)

MPI.set_errorhandler!(MPI.COMM_SELF, MPI.ERRORS_ARE_FATAL)
@test MPI.get_errorhandler(MPI.COMM_SELF) == MPI.ERRORS_ARE_FATAL

# the following is testing function pointers, and is adapted from
# mpi.deino.net/mpi_functions/MPI_Comm_call_errhandler.html

DUMMY_ERR = MPI.API.MPI_ERR_OTHER[]
DUMMY_COMM = MPI.API.MPI_COMM_WORLD[]

function error_handler(comm_ptr::Ptr, err_ptr::Ptr)
    @test unsafe_load(comm_ptr) == DUMMY_COMM
    @test unsafe_load(err_ptr) == DUMMY_ERR
    @warn "custom error handler"
    nothing
end

error_handler_c = @cfunction(error_handler, Cvoid, (Ptr{MPI.MPI_Comm}, Ptr{Cint}))

comm = MPI.Comm(DUMMY_COMM)
errh = MPI.get_errorhandler(comm)

MPI.API.MPI_Comm_create_errhandler(error_handler_c, errh)
MPI.set_errorhandler!(comm, errh)
@test_logs (:warn, "custom error handler") MPI.API.MPI_Comm_call_errhandler(comm, DUMMY_ERR)

MPI.Finalize()
