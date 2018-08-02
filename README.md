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

If you would like to wrap an MPI function on Windows, keep in mind you may need to add its signature to `src/win_mpiconstants.jl`.

## Usage : MPI-Only mode

To run a Julia script with MPI, first make sure that `using MPI` or
`import MPI` is included at the top of your script. You should then be
able to run the MPI job as expected, e.g., with

`mpirun -np 3 julia 01-hello.jl`

### Cleanup
In Julia code building on this package, it may happen that you want to run MPI cleanup functions in a finalizer.
This makes it impossible to manually call `MPI.Finalize()`, since the Julia finalizers may run after this call.
To solve this, a C `atexit` hook to run `MPI.Finalize()` can be set using `MPI.finalize_atexit()`. It is possible
to check if this function was called by checking the global `Ref` `MPI.FINALIZE_ATEXIT`.

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

`MPIManager(;np=Sys.CPU_THREADS, mpi_cmd=false, launch_timeout=60.0)`

If not specified, `mpi_cmd` defaults to `mpirun -np $np`
`stdout` from the launched workers is redirected back to the julia session calling `addprocs` via a TCP connection.
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
juliacomm = MPI.COMM_WORLD
ccomm = MPI.CComm(juliacomm)
```

### Currently wrapped MPI functions
Convention: `MPI_Fun => MPI.Fun`

Constants like `MPI_SUM` are wrapped as `MPI.SUM`.   Note also that
arbitrary Julia functions `f(x,y)` can be passed as reduction operations
to the MPI `Allreduce` and `Reduce` functions.

#### Administrative functions
Julia Function (assuming `import MPI`) | Fortran Function
---------------------------------------|--------------------------------------------------------
 `MPI.Abort`                           | [`MPI_Abort`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Abort.3.php)
 `MPI.Comm_dup`                        | [`MPI_Comm_dup`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Comm_dup.3.php)
 `MPI.Comm_free`                       | [`MPI_Comm_free`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Comm_free.3.php)
 `MPI.Comm_get_parent`                 | [`MPI_Comm_get_parent`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Comm_get_parent.3.php)
 `MPI.Comm_rank`                       | [`MPI_Comm_rank`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Comm_rank.3.php)
 `MPI.Comm_size`                       | [`MPI_Comm_size`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Comm_size.3.php)
 `MPI.Comm_spawn`                      | [`MPI_Comm_spawn`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Comm_spawn.3.php)
 `MPI.Finalize`                        | [`MPI_Finalize`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Finalize.3.php)
 `MPI.Finalized`                       | [`MPI_Finalized`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Finalized.3.php)
 `MPI.Get_address`                     | [`MPI_Get_address`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Get_address.3.php)
 `MPI.Init`                            | [`MPI_Init`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Init.3.php)
 `MPI.Initialized`                     | [`MPI_Initialized`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Initialized.3.php)
 `MPI.Intercomm_merge`                 | [`MPI_Intercomm_merge`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Intercomm_merge.3.php)
 `MPI.mpitype`                         | [`MPI_Type_create_struct`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Type_create_struct.3.php) and [`MPI_Type_commit`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Type_commit.3.php) (see: [mpitype note](#mpitypenote))

<a name="mpitypenote">mpitype note</a>: This is not strictly a wrapper for
`MPI_Type_create_struct` and `MPI_Type_commit`, it also is an accessor for
previously created types.

#### Point-to-point communication
Julia Function (assuming `import MPI`) | Fortran Function
---------------------------------------|--------------------------------------------------------
 `MPI.Cancel!`                         | [`MPI_Cancel`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Cancel.3.php)
 `MPI.Get_count`                       | [`MPI_Get_count`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Get_count.3.php)
 `MPI.Iprobe`                          | [`MPI_Iprobe`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Iprobe.3.php)
 `MPI.Irecv!`                          | [`MPI_Irecv`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Irecv.3.php)
 `MPI.Isend`                           | [`MPI_Isend`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Isend.3.php)
 `MPI.Probe`                           | [`MPI_Probe`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Probe.3.php)
 `MPI.Recv!`                           | [`MPI_Recv`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Recv.3.php)
 `MPI.Send`                            | [`MPI_Send`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Send.3.php)
 `MPI.Test!`                           | [`MPI_Test`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Test.3.php)
 `MPI.Testall!`                        | [`MPI_Testall`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Testall.3.php)
 `MPI.Testany!`                        | [`MPI_Testany`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Testany.3.php)
 `MPI.Testsome!`                       | [`MPI_Testsome`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Testsome.3.php)
 `MPI.Wait!`                           | [`MPI_Wait`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Wait.3.php)
 `MPI.Waitall!`                        | [`MPI_Waitall`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Waitall.3.php)
 `MPI.Waitany!`                        | [`MPI_Waitany`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Waitany.3.php)
 `MPI.Waitsome!`                       | [`MPI_Waitsome`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Waitsome.3.php)


#### Collective communication
Julia Function (assuming `import MPI`) | Fortran Function
---------------------------------------|--------------------------------------------------------
 `MPI.Allgather`                       | [`MPI_Allgather`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Allgather.3.php)
 `MPI.Allgatherv`                      | [`MPI_Allgatherv`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Allgatherv.3.php)
 `MPI.Alltoall`                        | [`MPI_Alltoall`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Alltoall.3.php)
 `MPI.Alltoallv`                       | [`MPI_Alltoallv`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Alltoallv.3.php)
 `MPI.Barrier`                         | [`MPI_Barrier`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Barrier.3.php)
 `MPI.Bcast!`                          | [`MPI_Bcast`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Bcast.3.php)
 `MPI.Exscan`                          | [`MPI_Exscan`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Exscan.3.php)
 `MPI.Gather`                          | [`MPI_Gather`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Gather.3.php)
 `MPI.Gatherv`                         | [`MPI_Gatherv`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Gatherv.3.php)
 `MPI.Reduce`                          | [`MPI_Reduce`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Reduce.3.php)
 `MPI.Scan`                            | [`MPI_Scan`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Scan.3.php)
 `MPI.Scatter`                         | [`MPI_Scatter`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Scatter.3.php)
 `MPI.Scatterv`                        | [`MPI_Scatterv`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Scatterv.3.php)

#### One-sided communication
Julia Function (assuming `import MPI`) | Fortran Function
---------------------------------------|--------------------------------------------------------
 `MPI.Win_create`                      | [`MPI_Win_create`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Win_create.3.php)
 `MPI.Win_create_dynamic`              | [`MPI_Win_create_dynamic`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Win_create_dynamic.3.php)
 `MPI.Win_attach`                      | [`MPI_Win_attach`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Win_attach.3.php)
 `MPI.Win_detach`                      | [`MPI_Win_detach`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Win_detach.3.php)
 `MPI.Win_fence`                       | [`MPI_Win_fence`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Win_fence.3.php)
 `MPI.Win_flush`                       | [`MPI_Win_flush`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Win_flush.3.php)
 `MPI.Win_free`                        | [`MPI_Win_free`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Win_free.3.php)
 `MPI.Win_sync`                        | [`MPI_Win_sync`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Win_sync.3.php)
 `MPI.Win_lock`                        | [`MPI_Win_lock`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Win_lock.3.php)
 `MPI.Win_unlock`                      | [`MPI_Win_unlock`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Win_unlock.3.php)
 `MPI.Get`                             | [`MPI_Get`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Get.3.php)
 `MPI.Put`                             | [`MPI_Put`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Put.3.php)
 `MPI.Fetch_and_op`                    | [`MPI_Fetch_and_op`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Fetch_and_op.3.php)
 `MPI.Accumulate`                      | [`MPI_Accumulate`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Accumulate.3.php)
 `MPI.Get_accumulate`                      | [`MPI_Get_accumulate`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Get_accumulate.3.php)

[Julia]: http://julialang.org/
[MPI]: http://www.mpi-forum.org/
[mpi4py]: http://mpi4py.scipy.org
[CMake]: http://www.cmake.org/
[FindMPI]: http://www.cmake.org/cmake/help/v3.3/module/FindMPI.html
[Open MPI]: http://www.open-mpi.org/
[MPICH]: http://www.mpich.org/
