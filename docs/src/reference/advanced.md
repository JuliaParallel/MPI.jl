# Advanced

## Object handling

```@docs
MPI.free
```

## Datatype objects

```@docs
MPI.Datatype
MPI.to_type
MPI.Types.extent
MPI.Types.create_contiguous
MPI.Types.create_vector
MPI.Types.create_hvector
MPI.Types.create_subarray
MPI.Types.create_struct
MPI.Types.create_resized
MPI.Types.commit!
MPI.Types.duplicate
```

## Operator objects

```@docs
MPI.Op
MPI.@RegisterOp
```

## Info objects

```@docs
MPI.Info
MPI.infoval
```

## Error handler objects

```@docs
MPI.Errhandler
MPI.get_errorhandler
MPI.set_errorhandler!
MPI.set_default_error_handler_return
```

## Miscellaneous

```@docs
MPI.API.@const_ref
```
