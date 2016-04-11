# MPI interface for the Julia language
[![Build Status](https://travis-ci.org/JuliaParallel/MPI.jl.svg?branch=master)](https://travis-ci.org/JuliaParallel/MPI.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/e8mr8rx8sjryyba6/branch/master?svg=true)](https://ci.appveyor.com/project/eschnett/mpi-jl/branch/master)
[![codecov.io](https://codecov.io/github/JuliaParallel/MPI.jl/coverage.svg?branch=master)](https://codecov.io/github/JuliaParallel/MPI.jl?branch=master)
[![Coverage Status](https://coveralls.io/repos/JuliaParallel/MPI.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/JuliaParallel/MPI.jl?branch=master)

This is a basic [Julia] wrapper for the portable message passing
system Message Passing Interface ([MPI]). Inspiration is taken from
mpi4py, although we generally follow the C and not the C++ MPI API.
(The C++ MPI API is deprecated.)

## Installing

### Unix systems (OSX and Linux)

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

#### Overriding the auto-detected MPI version

It may be that CMake selects the wrong MPI version, or that CMake
fails to correctly detect and configure your MPI implementation. You
can override CMake's mechanism by setting certain environment variables:
```sh
JULIA_MPI_C_LIBRARIES
JULIA_MPI_Fortran_INCLUDE_PATH
JULIA_MPI_Fortran_LIBRARIES
```
This will set `MPI_C_LIBRARIES`, `MPI_Fortran_INCLUDE_PATH`, and
`MPI_Fortran_LIBRARIES` when calling CMake as described in its [FindMPI] module.
You can set these variables either in your shell startup file, or e.g. via your
`~/.juliarc` file. Here is an example:
```Julia
ENV["JULIA_MPI_C_LIBRARIES"] = "-L/opt/local/lib/openmpi-gcc5 -lmpi"
ENV["JULIA_MPI_Fortran_INCLUDE_PATH"] = "-I/opt/local/include"
ENV["JULIA_MPI_Fortran_LIBRARIES"] = "-L/opt/local/lib/openmpi-gcc5 -lmpi_usempif08 -lmpi_mpifh -lmpi"
```

You can set other configuration variables as well (by adding a `JULIA_` prefix);
the full list of variables currently supported is
```sh
MPI_C_COMPILER
MPI_C_COMPILE_FLAGS
MPI_C_INCLUDE_PATH
MPI_C_LINK_FLAGS
MPI_C_LIBRARIES
MPI_Fortran_COMPILER
MPI_Fortran_COMPILE_FLAGS
MPI_Fortran_INCLUDE_PATH
MPI_Fortran_LINK_FLAGS
MPI_Fortran_LIBRARIES
MPI_INCLUDE_PATH
MPI_LIBRARIES
```

### Windows

You need to install the [Microsoft MPI](https://www.microsoft.com/en-us/download/details.aspx?id=49926) runtime on your system (the SDK is not required). Then simply add the MPI.jl package with

```julia
Pkg.update()
Pkg.add("MPI")
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

## Julia MPI-only interface

### Communicators:
Julia interfaces to the Fortran versions of the MPI functions. Since the C and
Fortran communicators are different, if a C communicator is required (e.g., to
interface with a C library), this can be achieved with the Fortran to C
communicator conversion:

```
juliacomm = MPI.MPI_COMM_WORLD
ccomm = MPI.CComm(juliacomm)
```

### Currently wrapped MPI functions
Convention: `MPI_Fun => MPI.Fun`

#### Administrative functions
Julia Function (assuming `import MPI`) | Fortran Function
---------------------------------------|--------------------------------------------------------
 `MPI.Abort`                           | [`MPI_Abort`](http://www.mpich.org/static/docs/latest/www3/MPI_Abort.html)
 `MPI.Comm_dup`                        | [`MPI_Comm_dup`](http://www.mpich.org/static/docs/latest/www3/MPI_Comm_dup.html)
 `MPI.Comm_free`                       | [`MPI_Comm_free`](http://www.mpich.org/static/docs/latest/www3/MPI_Comm_free.html)
 `MPI.Comm_rank`                       | [`MPI_Comm_rank`](http://www.mpich.org/static/docs/latest/www3/MPI_Comm_rank.html)
 `MPI.Comm_size`                       | [`MPI_Comm_size`](http://www.mpich.org/static/docs/latest/www3/MPI_Comm_size.html)
 `MPI.Finalize`                        | [`MPI_Finalize`](http://www.mpich.org/static/docs/latest/www3/MPI_Finalize.html)
 `MPI.Finalized`                       | [`MPI_Finalized`](http://www.mpich.org/static/docs/latest/www3/MPI_Finalized.html)
 `MPI.Init`                            | [`MPI_Init`](http://www.mpich.org/static/docs/latest/www3/MPI_Init.html)
 `MPI.Initialized`                     | [`MPI_Initialized`](http://www.mpich.org/static/docs/latest/www3/MPI_Initialized.html)

#### Point-to-point communication
Julia Function (assuming `import MPI`) | Fortran Function
---------------------------------------|--------------------------------------------------------
 `MPI.Cancel!`                         | [`MPI_Cancel`](http://www.mpich.org/static/docs/latest/www3/MPI_Cancel.html)
 `MPI.Get_count`                       | [`MPI_Get_count`](http://www.mpich.org/static/docs/latest/www3/MPI_Get_count.html)
 `MPI.Iprobe`                          | [`MPI_Iprobe`](http://www.mpich.org/static/docs/latest/www3/MPI_Iprobe.html)
 `MPI.Irecv!`                          | [`MPI_Irecv`](http://www.mpich.org/static/docs/latest/www3/MPI_Irecv.html)
 `MPI.Isend`                           | [`MPI_Isend`](http://www.mpich.org/static/docs/latest/www3/MPI_Isend.html)
 `MPI.Probe`                           | [`MPI_Probe`](http://www.mpich.org/static/docs/latest/www3/MPI_Probe.html)
 `MPI.Recv!`                           | [`MPI_Recv`](http://www.mpich.org/static/docs/latest/www3/MPI_Recv.html)
 `MPI.Send`                            | [`MPI_Send`](http://www.mpich.org/static/docs/latest/www3/MPI_Send.html)
 `MPI.Test!`                           | [`MPI_Test`](http://www.mpich.org/static/docs/latest/www3/MPI_Test.html)
 `MPI.Testall!`                        | [`MPI_Testall`](http://www.mpich.org/static/docs/latest/www3/MPI_Testall.html)
 `MPI.Testany!`                        | [`MPI_Testany`](http://www.mpich.org/static/docs/latest/www3/MPI_Testany.html)
 `MPI.Testsome!`                       | [`MPI_Testsome`](http://www.mpich.org/static/docs/latest/www3/MPI_Testsome.html)
 `MPI.Wait!`                           | [`MPI_Wait`](http://www.mpich.org/static/docs/latest/www3/MPI_Wait.html)
 `MPI.Waitall!`                        | [`MPI_Waitall`](http://www.mpich.org/static/docs/latest/www3/MPI_Waitall.html)
 `MPI.Waitany!`                        | [`MPI_Waitany`](http://www.mpich.org/static/docs/latest/www3/MPI_Waitany.html)
 `MPI.Waitsome!`                       | [`MPI_Waitsome`](http://www.mpich.org/static/docs/latest/www3/MPI_Waitsome.html)


#### Collective communication
Julia Function (assuming `import MPI`) | Fortran Function
---------------------------------------|--------------------------------------------------------
 `MPI.Allgather`                       | [`MPI_Allgather`](http://www.mpich.org/static/docs/latest/www3/MPI_Allgather.html)
 `MPI.Allgatherv`                      | [`MPI_Allgatherv`](http://www.mpich.org/static/docs/latest/www3/MPI_Allgatherv.html)
 `MPI.Alltoall`                        | [`MPI_Alltoall`](http://www.mpich.org/static/docs/latest/www3/MPI_Alltoall.html)
 `MPI.Alltoallv`                       | [`MPI_Alltoallv`](http://www.mpich.org/static/docs/latest/www3/MPI_Alltoallv.html)
 `MPI.Barrier`                         | [`MPI_Barrier`](http://www.mpich.org/static/docs/latest/www3/MPI_Barrier.html)
 `MPI.Bcast!`                          | [`MPI_Bcast`](http://www.mpich.org/static/docs/latest/www3/MPI_Bcast.html)
 `MPI.ExScan`                          | [`MPI_Exscan`](http://www.mpich.org/static/docs/latest/www3/MPI_Exscan.html)
 `MPI.Gather`                          | [`MPI_Gather`](http://www.mpich.org/static/docs/latest/www3/MPI_Gather.html)
 `MPI.Gatherv`                         | [`MPI_Gatherv`](http://www.mpich.org/static/docs/latest/www3/MPI_Gatherv.html)
 `MPI.Reduce`                          | [`MPI_Reduce`](http://www.mpich.org/static/docs/latest/www3/MPI_Reduce.html)
 `MPI.Scan`                            | [`MPI_Scan`](http://www.mpich.org/static/docs/latest/www3/MPI_Scan.html)
 `MPI.Scatter`                         | [`MPI_Scatter`](http://www.mpich.org/static/docs/latest/www3/MPI_Scatter.html)
 `MPI.Scatterv`                        | [`MPI_Scatterv`](http://www.mpich.org/static/docs/latest/www3/MPI_Scatterv.html)


[Julia]: http://julialang.org/
[MPI]: http://www.mpi-forum.org/
[mpi4py]: http://mpi4py.scipy.org
[CMake]: http://www.cmake.org/
[FindMPI]: http://www.cmake.org/cmake/help/v3.3/module/FindMPI.html
[Open MPI]: http://www.open-mpi.org/
[MPICH]: http://www.mpich.org/
