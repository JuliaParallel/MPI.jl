# Known issues

## UCX and Julia multi-threading

When using [multi-threading](https://docs.julialang.org/en/v1/manual/parallel-computing/#man-multithreading-1), the Julia garbage collector internally uses [`SIGSEGV` to synchronize threads](https://docs.julialang.org/en/v1/devdocs/debuggingtips/#Dealing-with-signals-1). This can cause issues with the UCX library, which is often used as a communication layer by OpenMPI, which by default will error this signal is raised ([#337](https://github.com/JuliaParallel/MPI.jl/issues/337)).

This signal interception can be disabled by setting the environment variable `UCX_ERROR_SIGNALS` to be an empty string, e.g.
```
mpiexec -x JULIA_NUM_THREADS=4 -x UCX_ERROR_SIGNALS="" julia script.jl
```