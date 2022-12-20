# Point-to-point communication

## Types

```@docs
MPI.AbstractRequest
MPI.Request
MPI.NoRefRequest
MPI.MultiRequest
MPI.NoRefMultiRequest
MPI.RequestSet
MPI.Status
```

### Accessors

```@docs
MPI.Get_count
```

### Constants

```@docs
MPI.PROC_NULL
MPI.ANY_SOURCE
MPI.ANY_TAG
```

## Blocking communication

```@docs
MPI.Send
MPI.send
MPI.Recv!
MPI.Recv
MPI.recv
MPI.Sendrecv!
```

## Non-blocking communication

### Initiation

```@docs
MPI.Isend
MPI.isend
MPI.Irecv!
```

### Completion

```@docs
MPI.Test
MPI.Testall
MPI.Testany
MPI.Testsome
MPI.Wait
MPI.Waitall
MPI.Waitany
MPI.Waitsome
```

### Probe/Cancel

```@docs
MPI.Cancel!
MPI.Iprobe
MPI.Probe
```

### Persistent requests

```@docs
MPI.Send_init
MPI.Recv_init
MPI.Start
MPI.Startall
```