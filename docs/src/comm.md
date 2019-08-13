# Communicators

An MPI communicator specifies the communication context for a communication operation. In
particular, it specifies the set of processes which share the context, and assigns each
each process a unique *rank* (see [`MPI.Comm_rank`](@ref)) taking an integer value in
`0:n-1`, where `n` is the number of processes in the communicator (see
[`MPI.Comm_size`](@ref).

## Constants

```@docs
MPI.COMM_WORLD
MPI.COMM_SELF
```

## Functions

```@docs
MPI.Comm_dup
MPI.Comm_get_parent
MPI.Comm_rank
MPI.Comm_size
MPI.Comm_spawn
MPI.Comm_split
MPI.Comm_split_type
MPI.Intercomm_merge
MPI.universe_size
```
