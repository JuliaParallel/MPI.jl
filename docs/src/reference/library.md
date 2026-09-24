# Library information

## Constants

```@docs
MPI.MPI_VERSION
MPI.MPI_LIBRARY
MPI.MPI_LIBRARY_VERSION
MPI.MPI_LIBRARY_VERSION_STRING
```

Whether the library provides the MPI 4.0 large-count entry points is reported by
[`MPI.API.HAS_LARGE_COUNT`](@ref), and by [`MPI.versioninfo`](@ref).

## Functions

```@docs
MPI.versioninfo
MPI.has_cuda
MPI.has_rocm
MPI.has_oneapi
MPI.has_gpu
MPI.identify_implementation
```
