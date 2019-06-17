# Usage

## MPI-only mode

To run a Julia script with MPI, first make sure that `using MPI` or
`import MPI` is included at the top of your script. You should then be
able to run the MPI job as expected, e.g. to run [`examples/01-hello.jl`](https://github.com/JuliaParallel/MPI.jl/blob/master/examples/01-hello.jl),

```
mpirun -np 3 julia 01-hello.jl
```

## MPI and Julia parallel constructs together

In order for MPI calls to be made from a Julia cluster, it requires the use of
`MPIManager`, a cluster manager that will start the julia workers using `mpirun`

It has three modes of operation

- Only worker processes execute MPI code. The Julia master process executes outside of and
  is not part of the MPI cluster. Free bi-directional TCP/IP connectivity is required
  between all processes

- All processes (including Julia master) are part of both the MPI as well as Julia cluster.
  Free bi-directional TCP/IP connectivity is required between all processes.

- All processes are part of both the MPI as well as Julia cluster. MPI is used as the transport
  for julia messages. This is useful on environments which do not allow TCP/IP connectivity
  between worker processes

### MPIManager: only workers execute MPI code

An example is provided in `examples/05-juliacman.jl`.
The julia master process is NOT part of the MPI cluster. The main script should be
launched directly, `MPIManager` internally calls `mpirun` to launch julia/MPI workers.
All the workers started via `MPIManager` will be part of the MPI cluster.

```
MPIManager(;np=Sys.CPU_THREADS, mpi_cmd=false, launch_timeout=60.0)
```

If not specified, `mpi_cmd` defaults to `mpirun -np $np`
`stdout` from the launched workers is redirected back to the julia session calling `addprocs` via a TCP connection.
Thus the workers must be able to freely connect via TCP to the host session.
The following lines will be typically required on the julia master process to support both julia and MPI:

```julia
# to import MPIManager
using MPI

# need to also import Distributed to use addprocs()
using Distributed

# specify, number of mpi workers, launch cmd, etc.
manager=MPIManager(np=4)

# start mpi workers and add them as julia workers too.
addprocs(manager)
```

To execute code with MPI calls on all workers, use `@mpi_do`.

`@mpi_do manager expr` executes `expr` on all processes that are part of `manager`.

For example:
```
@mpi_do manager begin
  comm=MPI.COMM_WORLD
  println("Hello world, I am $(MPI.Comm_rank(comm)) of $(MPI.Comm_size(comm))"))
end
```
executes on all MPI workers belonging to `manager` only

[`examples/05-juliacman.jl`](https://github.com/JuliaParallel/MPI.jl/blob/master/examples/05-juliacman.jl) is a simple example of calling MPI functions on all workers interspersed with Julia parallel methods.

This should be run _without_ `mpirun`:
```
julia 05-juliacman.jl
```

A single instation of `MPIManager` can be used only once to launch MPI workers (via `addprocs`).
To create multiple sets of MPI clusters, use separate, distinct `MPIManager` objects.

`procs(manager::MPIManager)` returns a list of julia pids belonging to `manager`
`mpiprocs(manager::MPIManager)` returns a list of MPI ranks belonging to `manager`

Fields `j2mpi` and `mpi2j` of `MPIManager` are associative collections mapping julia pids to MPI ranks and vice-versa.

### MPIManager: TCP/IP transport - all processes execute MPI code

Useful on environments which do not allow TCP connections outside of the cluster

An example is in [`examples/06-cman-transport.jl`](https://github.com/JuliaParallel/MPI.jl/blob/master/examples/06-cman-transport.jl):
```
mpirun -np 5 julia 06-cman-transport.jl TCP
```

This launches a total of 5 processes, mpi rank 0 is the julia pid 1. mpi rank 1 is julia pid 2 and so on.

The program must call `MPI.start(TCP_TRANSPORT_ALL)` with argument `TCP_TRANSPORT_ALL`.
On mpi rank 0, it returns a `manager` which can be used with `@mpi_do`
On other processes (i.e., the workers) the function does not return


### MPIManager: MPI transport - all processes execute MPI code

`MPI.start` must be called with option `MPI_TRANSPORT_ALL` to use MPI as transport.
```
mpirun -np 5 julia 06-cman-transport.jl MPI
```
will run the example using MPI as transport.


## Finalizers

In order to ensure MPI routines are called in the correct order at finalization time,
MPI.jl maintains a reference count. If you define an object that needs to call an MPI
routine during its finalization, you should call [`MPI.refcount_inc()`](@ref) when it is
initialized, and [`MPI.refcount_dec()`](@ref) in its finalizer (after the relevant MPI
call).

For example
```julia
mutable struct MyObject
    ...
    function MyObject(args...)
        obj = new(args...)
        # MPI call to create object
        refcount_inc()
        finalizer(obj) do x
            # MPI call to free object
            refcount_dec()
        end
        return obj
    end
end
```
    