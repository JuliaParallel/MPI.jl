# Function reference

The following functions are currently wrapped, with the convention: `MPI_Fun => MPI.Fun`

Constants like `MPI_SUM` are wrapped as `MPI.SUM`.   Note also that
arbitrary Julia functions `f(x,y)` can be passed as reduction operations
to the MPI `Allreduce` and `Reduce` functions.

## Datatype functions

Julia Function (assuming `import MPI`) | Fortran Function
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

## Point-to-point communication

Julia Function (assuming `import MPI`) | Fortran Function
---------------------------------------|--------------------------------------------------------
 [`MPI.Cancel!`](@ref)                 | [`MPI_Cancel`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Cancel.3.php)
 [`MPI.Get_count`](@ref)               | [`MPI_Get_count`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Get_count.3.php)
 [`MPI.Iprobe`](@ref)                  | [`MPI_Iprobe`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Iprobe.3.php)
 [`MPI.Irecv!`](@ref)                  | [`MPI_Irecv`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Irecv.3.php)
 [`MPI.Isend`](@ref)                   | [`MPI_Isend`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Isend.3.php)
 [`MPI.Probe`](@ref)                   | [`MPI_Probe`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Probe.3.php)
 [`MPI.Recv!`](@ref)                   | [`MPI_Recv`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Recv.3.php)
 [`MPI.Send`](@ref)                    | [`MPI_Send`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Send.3.php)
 [`MPI.Test!`](@ref)                   | [`MPI_Test`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Test.3.php)
 [`MPI.Testall!`](@ref)                | [`MPI_Testall`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Testall.3.php)
 [`MPI.Testany!`](@ref)                | [`MPI_Testany`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Testany.3.php)
 [`MPI.Testsome!`](@ref)               | [`MPI_Testsome`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Testsome.3.php)
 [`MPI.Wait!`](@ref)                   | [`MPI_Wait`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Wait.3.php)
 [`MPI.Waitall!`](@ref)                | [`MPI_Waitall`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Waitall.3.php)
 [`MPI.Waitany!`](@ref)                | [`MPI_Waitany`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Waitany.3.php)
 [`MPI.Waitsome!`](@ref)               | [`MPI_Waitsome`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Waitsome.3.php)

```@docs
MPI.Cancel!
MPI.Get_count
MPI.Iprobe
MPI.Irecv!
MPI.Isend
MPI.Probe
MPI.Recv!
MPI.Send
MPI.Test!
MPI.Testall!
MPI.Testany!
MPI.Testsome!
MPI.Wait!
MPI.Waitall!
MPI.Waitany!
MPI.Waitsome!
```

## Collective communication

 Non-Allocating Julia Function         |Allocating Julia Function              | Fortran Function                                                                  | Supports `MPI_IN_PLACE`
 --------------------------------------|---------------------------------------|-----------------------------------------------------------------------------------|-----------
 [`MPI.Allgather!`](@ref)              | [`MPI.Allgather`](@ref)               | [`MPI_Allgather`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Allgather.3.php)    | ✅
 [`MPI.Allgatherv!`](@ref)             | [`MPI.Allgatherv`](@ref)              | [`MPI_Allgatherv`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Allgatherv.3.php)  | ✅
 [`MPI.Allreduce!`](@ref)              | [`MPI.Allreduce`](@ref)               | [`MPI_Allreduce`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Allreduce.3.php)    | ✅
 [`MPI.Alltoall!`](@ref)               | [`MPI.Alltoall`](@ref)                | [`MPI_Alltoall`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Alltoall.3.php)      | ✅
 [`MPI.Alltoallv!`](@ref)              | [`MPI.Alltoallv`](@ref)               | [`MPI_Alltoallv`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Alltoallv.3.php)    | ❌
 --                                    | [`MPI.Barrier`](@ref)                 | [`MPI_Barrier`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Barrier.3.php)        | ❌
 [`MPI.Bcast!`](@ref)                  | [`MPI.Bcast!`](@ref)                  | [`MPI_Bcast`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Bcast.3.php)            | ❌
 --                                    | [`MPI.Exscan`](@ref)                  | [`MPI_Exscan`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Exscan.3.php)          | ❌
 [`MPI.Gather!`](@ref)                 | [`MPI.Gather`](@ref)                  | [`MPI_Gather`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Gather.3.php)          | [`Gather_in_place!`](@ref)
 [`MPI.Gatherv!`](@ref)                | [`MPI.Gatherv`](@ref)                 | [`MPI_Gatherv`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Gatherv.3.php)        | [`Gatherv_in_place!`](@ref)
 [`MPI.Reduce!`](@ref)                 | [`MPI.Reduce`](@ref)                  | [`MPI_Reduce`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Reduce.3.php)          | [`Reduce_in_place!`](@ref)
 [`MPI.Scan`](@ref)                    | [`MPI.Scan`](@ref)                    | [`MPI_Scan`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Scan.3.php)              | missing
 [`MPI.Scatter!`](@ref)                | [`MPI.Scatter`](@ref)                 | [`MPI_Scatter`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Scatter.3.php)        | [`Scatter_in_place!`](@ref)
 [`MPI.Scatterv!`](@ref)               | [`MPI.Scatterv`](@ref)                | [`MPI_Scatterv`](https://www.open-mpi.org/doc/v1.10/man3/MPI_Scatterv.3.php)      | [`Scatterv_in_place!`](@ref)

The non-allocating Julia functions map directly to the corresponding MPI operations, after asserting that the size of the output buffer is sufficient to store the result.

The allocating Julia functions allocate an output buffer and then call the non-allocating method.

All-to-all collective communications support in place operations by passing
`MPI.IN_PLACE` with the same syntax documented by MPI.
One-to-All communications support it by calling the function `*_in_place!`, calls the MPI functions with the right syntax on root and non root process.


```@docs
MPI.Allgather!
MPI.Allgather
MPI.Allgatherv!
MPI.Allgatherv
MPI.Allreduce!
MPI.Allreduce
MPI.Alltoall!
MPI.Alltoall
MPI.Alltoallv!
MPI.Alltoallv
MPI.Barrier
MPI.Bcast!
MPI.Bcast!
MPI.Exscan
MPI.Gather!
MPI.Gather
MPI.Gather_in_place!
MPI.Gatherv!
MPI.Gatherv
MPI.Gatherv_in_place!
MPI.Reduce!
MPI.Reduce
MPI.Reduce_in_place!
MPI.Scan
MPI.Scan
MPI.Scatter!
MPI.Scatter
MPI.Scatter_in_place!
MPI.Scatterv!
MPI.Scatterv
MPI.Scatterv_in_place!
```

## One-sided communication

Julia Function (assuming `import MPI`) | Fortran Function
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