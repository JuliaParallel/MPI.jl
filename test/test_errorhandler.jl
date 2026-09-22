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
    # @test unsafe_load(comm_ptr) == DUMMY_COMM
    @test unsafe_load(err_ptr) == DUMMY_ERR
    @warn "custom error handler"
    nothing
end

error_handler_c = @cfunction(error_handler, Cvoid, (Ptr{MPI.MPI_Comm}, Ptr{Cint}))

comm = MPI.Comm(DUMMY_COMM)
errh = MPI.Errhandler()

MPI.API.MPI_Comm_create_errhandler(error_handler_c, errh)
MPI.set_errorhandler!(comm, errh)
@test_logs (:warn, "custom error handler") MPI.API.MPI_Comm_call_errhandler(comm, DUMMY_ERR)

# `get_errorhandler` owns what it returns (MPI-5.0 §9.3: it behaves as if a new
# error handler object were created), so an owned handler must be freed at
# finalization.  A predefined handler is owned by nobody and must be left alone.
# COMM_SELF was set to the predefined ERRORS_ARE_FATAL above.  (COMM_WORLD is
# no longer usable for this: DUMMY_COMM is MPI_COMM_WORLD and just got a custom
# handler.)
let errh = MPI.get_errorhandler(MPI.COMM_SELF)
    @test errh == MPI.ERRORS_ARE_FATAL
    @test MPI.is_predefined(errh)
    finalize(errh)
    @test errh == MPI.ERRORS_ARE_FATAL            # no finalizer, nothing freed
end

let custom = MPI.Errhandler()
    MPI.API.MPI_Comm_create_errhandler(error_handler_c, custom)
    @test !MPI.is_predefined(custom)

    dup = MPI.Comm_dup(MPI.COMM_WORLD)
    MPI.set_errorhandler!(dup, custom)
    got = MPI.get_errorhandler(dup)
    @test !MPI.is_predefined(got)

    # MPI_Errhandler_free sets the handle to MPI_ERRHANDLER_NULL, so this
    # observes that the finalizer really did free it.
    finalize(got)
    @test got == MPI.ERRHANDLER_NULL

    MPI.free(dup)
    MPI.free(custom)
end

MPI.Finalize()
