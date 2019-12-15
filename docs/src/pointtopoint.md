# Point-to-point communication

## Types

```@docs
MPI.Request
MPI.Status
```

## Functions

### Accessor

```@docs
MPI.Get_count
```

### Blocking

```@docs
MPI.Send
MPI.send
MPI.Recv!
MPI.Recv
MPI.recv
MPI.Sendrecv!
```

### Non-blocking

```@docs
MPI.Isend
MPI.isend
MPI.Irecv!
MPI.Test!
MPI.Testall!
MPI.Testany!
MPI.Testsome!
MPI.Wait!
MPI.Waitall!
MPI.Waitany!
MPI.Waitsome!
```

### Probe and cancel

```@docs
MPI.Iprobe
MPI.Probe
MPI.Cancel!
```
