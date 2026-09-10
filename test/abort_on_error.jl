# Loaded into every MPI test process via `julia -L abort_on_error.jl test_foo.jl`; see
# the `cmd` definition in runtests.jl.  Deliberately not named `test_*.jl`, so that
# `istest` in runtests.jl does not pick it up as a test file.
#
# When a test file dies from an uncaught exception (a failing `@test`, an `MPIError`,
# ...), Julia prints it and calls `exit(1)`.  MPI.jl's own atexit hook then skips
# `MPI.Finalize()`, because it is collective.  Two bad things follow:
#
#  * the other ranks stay blocked in their next collective, and
#  * this rank's object finalizers still run, and `free(::Win)`, `free(::Comm)` and
#    `close(::FileHandle)` are collective, so this rank blocks too -- a deadlock in
#    which every process is still alive and which therefore no launcher can detect.
#
# atexit hooks run before object finalizers, so aborting here heads off both.
using MPI

atexit() do exitcode
    # Only interfere with abnormal termination.
    exitcode == 0 && return
    # MPI must be up, and not already finalized: calling MPI_Abort after MPI_Finalize
    # is not allowed.  (Several tests assert after their own MPI.Finalize() call.)
    (MPI.Initialized() && !MPI.Finalized()) || return

    # MPI_Abort terminates this process immediately: no later atexit hook, object
    # finalizer or stream flush will run.  The `Test Failed / Expression: ...` detail
    # block goes to stdout, which may be block-buffered under mpiexec, so get it out
    # first rather than risk losing the only description of what went wrong.  A broken
    # stream must not be able to skip the abort itself, hence the try/catch.
    try
        flush(stdout)
        flush(stderr)
    catch
    end

    # Launchers report errcode as the job's exit status and typically truncate it to
    # 8 bits, so MPI_Abort(comm, 256) is reported as *success*.  Never do that for a
    # failing test.
    errcode = Cint(exitcode)
    if mod(errcode, 256) == 0
        errcode = Cint(1)
    end

    MPI.Abort(MPI.COMM_WORLD, errcode)
end
