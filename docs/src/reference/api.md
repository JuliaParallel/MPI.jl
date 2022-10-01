# Low-level API

The `MPI.API` submodule provides a low-level interface which closely matches the MPI C API.
While these functions are not intended for general usage, they are useful for calling MPI routines not yet available in `MPI.jl` main interface, and is the basis for the high-level wrappers. The methods suffixed with `_c` allow `MPI_count` typed arguments (vs `int` for the standard ones). The size of `MPI_count` depends on the implementation, but usually allows `64bit` integer offsets.

```@autodocs
Modules = [MPI.API]
Order = [:function]
```
