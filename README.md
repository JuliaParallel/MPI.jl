# MPI interface for the Julia language

This is a basic [Julia] wrapper for the portable message passing
system Message Passing Interface ([MPI]). Inspiration is taken from
mpi4py, although we generally follow the C and not the C++ MPI API.
(The C++ MPI API is deprecated.)

## Installing

[CMake] is used to piece together the MPI wrapper. Currently a shared
library MPI installation for C and Fortran is required (tested with
[Open MPI] and [MPICH]). To install MPI.jl using the Julia packaging
system, run
```julia
Pkg.update()
Pkg.add("MPI")
```
Alternatively,
```julia
Pkg.clone("https://github.com/JuliaParallel/MPI.jl.git")
Pkg.build()
```
which will build and install the wrapper into `$HOME/.julia/vX.Y/MPI`.

## Usage

To run a Julia script with MPI, first make sure that `using MPI` or
`import MPI` is included at the top of your script. You should then be
able to run the MPI job as expected, e.g., with

  mpirun -np 3 julia 01-hello.jl

## Using MPI and Julia parallel constructs together

In order for MPI calls to be made from a Julia cluster, it requires the use of
MPIManager, a cluster manager that will start the julia workers using `mpirun`

An example is provided in `examples/05-juliacman.jl`.
The julia master process is NOT part of the MPI cluster. All the workers
started via MPIManager will be part of the MPI cluster.

`MPIManager(;np=Sys.CPU_CORES, launch_cmd=false, output_filename=tempname(), launch_timeout=60.0)`

If not specified, `launch_cmd` defaults to `mpirun -np $np --output-filename $output_filename julia --worker`
If `launch_cmd` is specified, it is important that `--output-filename` is also specified and that it
match exactly, since the julia cluster setup requires access to the STDOUT of each worker. Also note that
`--worker` MUST be specified as an argument to the julia processes started via `mpirun`.

The following lines will be typically required on the julia master process to support both julia and mpi

```
# to import MPIManager
using MPI

# specify, number of mpi workers, launch cmd, etc.
manager=MPIManager(np=4)

# start mpi workers and add them as julia workers too.
addprocs(manager)

# load module MPI on all newly launched workers
@everywhere using MPI

# calls MPI.Init() on all workers and sets up atexit() handlers to call MPI.Finalize()
mpi_init(manager)
```

To execute code with MPI calls on all workers, use `@mpi_do`, for example

`@mpi_do  include("01-hello.jl")` loads and runs `01-hello.jl` on all the mpi workers only

`examples/05-juliacman.jl` is a simple example of calling MPI functions on all workers
interspersed with Julia parallel methods.



[Julia]: http://julialang.org/
[MPI]: http://www.mpi-forum.org/
[mpi4py]: http://mpi4py.scipy.org
[CMake]: http://www.cmake.org/
[Open MPI]: http://www.open-mpi.org/
[MPICH]: http://www.mpich.org/
