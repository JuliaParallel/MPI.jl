# Point-to-point communication

## Types

```@docs
MPI.Request
MPI.RequestSet
MPI.Status
```

### Fields

```
MPI.Status.source::Cint
MPI.Status.tag::Cint
MPI.Status.error::Cint
```

### Accessors

```@docs
MPI.Get_count
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
