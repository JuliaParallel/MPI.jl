# Low-level API

The `MPI.API` submodule provides a low-level interface which closely matches the MPI C API.
While these functions are not intended for general usage, they are useful for calling MPI routines not yet available in `MPI.jl` main interface, and is the basis for the high-level wrappers.

```@autodocs
Modules = [MPI.API]
Order = [:function]
```
