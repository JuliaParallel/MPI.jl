# I/O

## File manipulation

```@docs
MPI.File.open
```

## Views

```@docs
MPI.File.set_view!
MPI.File.get_byte_offset
```

## Consistency

```@docs
MPI.File.sync
MPI.File.get_atomicity
MPI.File.set_atomicity
```

## Data access

### Individual pointer

```@docs
MPI.File.read!
MPI.File.read_all!
MPI.File.write
MPI.File.write_all
```

### Explicit offsets

```@docs
MPI.File.read_at!
MPI.File.read_at_all!
MPI.File.write_at
MPI.File.write_at_all
```

### Shared pointer

```@docs
MPI.File.read_shared!
MPI.File.write_shared
MPI.File.read_ordered!
MPI.File.write_ordered
MPI.File.seek_shared
MPI.File.get_position_shared
```
