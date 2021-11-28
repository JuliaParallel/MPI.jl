# Groups

An MPI group is a set of process identifiers identified by their *rank* (see 
[`MPI.Comm_rank`](@ref) and [`MPI.Group_rank`](@ref)). They are used within a 
communicator to describe the participants in a communication *universe*.

## Types and enums

```@docs
MPI.Group
MPI.Comparison
```

## Constants

```@docs
MPI.GROUP_NULL
MPI.GROUP_EMPTY
```

## Functions

### Operations

```@docs
MPI.Group_size
MPI.Group_rank
MPI.Group_compare
```

### Constructors

```@docs
MPI.Group_difference
MPI.Group_intersection
MPI.Group_union
MPI.Group_excl
MPI.Group_incl
```
