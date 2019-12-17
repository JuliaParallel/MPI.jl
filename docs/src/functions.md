# Function reference

The following functions are currently wrapped, with the convention: `MPI_Fun => MPI.Fun`

Constants like `MPI_SUM` are wrapped as `MPI.SUM`.   Note also that
arbitrary Julia functions `f(x,y)` can be passed as reduction operations
to the MPI `Allreduce` and `Reduce` functions.

## Datatype functions

Julia Function (assuming `import MPI`) | C Function
---------------------------------------|--------------------------------------------------------
 [`MPI.Get_address`](@ref)             | [`MPI_Get_address`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Get_address.3.php)
 [`MPI.mpitype`](@ref)                 | [`MPI_Type_create_struct`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Type_create_struct.3.php)/[`MPI_Type_commit`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Type_commit.3.php)

!!! note
    `mpitype` is not strictly a wrapper for
    `MPI_Type_create_struct` and `MPI_Type_commit`, it also is an accessor for
    previously created types.


```@docs
MPI.Get_address
MPI.mpitype
```

## One-sided communication

Julia Function (assuming `import MPI`) | C Function
---------------------------------------|--------------------------------------------------------
 [`MPI.Win_create`](@ref)              | [`MPI_Win_create`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Win_create.3.php)
 [`MPI.Win_create_dynamic`](@ref)      | [`MPI_Win_create_dynamic`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Win_create_dynamic.3.php)
 [`MPI.Win_allocate_shared`](@ref)     | [`MPI_Win_allocate_shared`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Win_allocate_shared.3.php)
 [`MPI.Win_shared_query`](@ref)        | [`MPI_Win_shared_query`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Win_shared_query.3.php)
 [`MPI.Win_attach`](@ref)              | [`MPI_Win_attach`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Win_attach.3.php)
 [`MPI.Win_detach`](@ref)              | [`MPI_Win_detach`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Win_detach.3.php)
 [`MPI.Win_fence`](@ref)               | [`MPI_Win_fence`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Win_fence.3.php)
 [`MPI.Win_flush`](@ref)               | [`MPI_Win_flush`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Win_flush.3.php)
 [`MPI.Win_free`](@ref)                | [`MPI_Win_free`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Win_free.3.php)
 [`MPI.Win_sync`](@ref)                | [`MPI_Win_sync`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Win_sync.3.php)
 [`MPI.Win_lock`](@ref)                | [`MPI_Win_lock`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Win_lock.3.php)
 [`MPI.Win_unlock`](@ref)              | [`MPI_Win_unlock`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Win_unlock.3.php)
 [`MPI.Get`](@ref)                     | [`MPI_Get`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Get.3.php)
 [`MPI.Put`](@ref)                     | [`MPI_Put`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Put.3.php)
 [`MPI.Fetch_and_op`](@ref)            | [`MPI_Fetch_and_op`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Fetch_and_op.3.php)
 [`MPI.Accumulate`](@ref)              | [`MPI_Accumulate`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Accumulate.3.php)
 [`MPI.Get_accumulate`](@ref)          | [`MPI_Get_accumulate`](https://www.open-mpi.org/doc/v3.0/man3/MPI_Get_accumulate.3.php)


```@docs
MPI.Win_create
MPI.Win_create_dynamic
MPI.Win_allocate_shared
MPI.Win_shared_query
MPI.Win_attach
MPI.Win_detach
MPI.Win_fence
MPI.Win_flush
MPI.Win_free
MPI.Win_sync
MPI.Win_lock
MPI.Win_unlock
MPI.Get
MPI.Put
MPI.Fetch_and_op
MPI.Accumulate
MPI.Get_accumulate
```

# Info objects

```@docs
MPI.Info
MPI.infoval
```
