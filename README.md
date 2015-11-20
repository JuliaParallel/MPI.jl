# MPI interface for the Julia language
[![Build Status](https://travis-ci.org/JuliaParallel/MPI.jl.svg?branch=master)](https://travis-ci.org/JuliaParallel/MPI.jl)
[![Coverage Status](https://coveralls.io/repos/JuliaParallel/MPI.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/JuliaParallel/MPI.jl?branch=master)

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

#### Platform specific notes:
* If you are trying to build on OSX with Homebrew, the necessary Fortran headers are not included in the OpenMPI bottle.  To workaround this you can build OpenMPI from source: `brew install --build-from-source openmpi`

### Overriding the auto-detected MPI version

It may be that CMake selects the wrong MPI version, or that CMake
fails to correctly detect and configure your MPI implementation. You
can override CMake's mechanism by setting two environment variables:
```sh
JULIA_MPI_INCLUDE_PATH
JULIA_MPI_LIBRARIES
```
This will set `MPI_Fortran_INCLUDE_PATH` and `MPI_Fortran_LIBRARIES`
when calling CMake as described in its [FindMPI] module. You can set
these variables either in your shell startup file, or e.g. via your
`~/.juliarc` file. Here is an example:
```Julia
ENV["JULIA_MPI_INCLUDE_PATH"] = "-I/opt/local/include"
ENV["JULIA_MPI_LIBRARIES"] = "-L/opt/local/lib/openmpi-gcc5 -lmpi_usempif08 -lmpi_mpifh -lmpi"
```

## Usage : MPI-Only mode

To run a Julia script with MPI, first make sure that `using MPI` or
`import MPI` is included at the top of your script. You should then be
able to run the MPI job as expected, e.g., with

  mpirun -np 3 julia 01-hello.jl

## Usage : MPI and Julia parallel constructs together

In order for MPI calls to be made from a Julia cluster, it requires the use of
MPIManager, a cluster manager that will start the julia workers using `mpirun`

Currently MPIManager only works with Julia 0.4 . It has three modes of operation

- Only worker processes execute MPI code. The Julia master process executes outside of and
  is not part of the MPI cluster. Free bi-directional TCP/IP connectivity is required
  between all processes

- All processes (including Julia master) are part of both the MPI as well as Julia cluster.
  Free bi-directional TCP/IP connectivity is required between all processes.

- All processes are part of both the MPI as well as Julia cluster. MPI is used as the transport
  for julia messages. This is useful on environments which do not allow TCP/IP connectivity
  between worker processes

### MPIManager (only workers execute MPI code)

An example is provided in `examples/05-juliacman.jl`.
The julia master process is NOT part of the MPI cluster. The main script should be
launched directly, MPIManager internally calls `mpirun` to launch julia/mpi workers.
All the workers started via MPIManager will be part of the MPI cluster.

`MPIManager(;np=Sys.CPU_CORES, mpi_cmd=false, launch_timeout=60.0)`

If not specified, `mpi_cmd` defaults to `mpirun -np $np`
STDOUT from the launched workers is redirected back to the julia session calling `addprocs` via a TCP connection.
Thus the workers must be able to freely connect via TCP to the host session.
The following lines will be typically required on the julia master process to support both julia and mpi

```
# to import MPIManager
using MPI

# specify, number of mpi workers, launch cmd, etc.
manager=MPIManager(np=4)

# start mpi workers and add them as julia workers too.
addprocs(manager)

```

To execute code with MPI calls on all workers, use `@mpi_do`.

`@mpi_do manager expr` executes `expr` on all processes that are part of `manager`

For example:
`@mpi_do manager (comm=MPI.COMM_WORLD; println("Hello world, I am $(MPI.Comm_rank(comm)) of $(MPI.Comm_size(comm))")`
executes on all mpi workers belonging to `manager` only

`examples/05-juliacman.jl` is a simple example of calling MPI functions on all workers
interspersed with Julia parallel methods. `cd` to the `examples` directory and run `julia 05-juliacman.jl`

A single instation of `MPIManager` can be used only once to launch MPI workers (via `addprocs`).
To create multiple sets of MPI clusters, use separate, distinct `MPIManager` objects.

procs(manager::MPIManager) returns a list of julia pids belonging to `manager`
mpiprocs(manager::MPIManager) returns a list of MPI ranks belonging to `manager`

Fields `j2mpi` and `mpi2j` of `MPIManager` are associative collections mapping julia pids to MPI ranks and vice-versa.

### MPIManager
### (TCP/IP transport - all processes execute MPI code)

- Useful on environments which do not allow TCP connections outside of the cluster
- An example is in `examples/06-cman-transport.jl`

`mpirun -np 5 julia 06-cman-transport.jl TCP`

This launches a total of 5 processes, mpi rank 0 is the julia pid 1. mpi rank 1 is julia pid 2 and so on.

The program must call `MPI.start(TCP_TRANSPORT_ALL)` with argument `TCP_TRANSPORT_ALL`.
On mpi rank 0, it returns a `manager` which can be used with `@mpi_do`
On other processes (i.e., the workers) the function does not return


### MPIManager
### (MPI transport - all processes execute MPI code)
`MPI.start` must be called with option `MPI_TRANSPORT_ALL` to use MPI as transport.
`mpirun -np 5 julia 06-cman-transport.jl MPI` will run the example using MPI as transport.


[Julia]: http://julialang.org/
[MPI]: http://www.mpi-forum.org/
[mpi4py]: http://mpi4py.scipy.org
[CMake]: http://www.cmake.org/
[FindMPI]: http://www.cmake.org/cmake/help/v3.3/module/FindMPI.html
[Open MPI]: http://www.open-mpi.org/
[MPICH]: http://www.mpich.org/
