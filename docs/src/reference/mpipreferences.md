# MPIPreferences.jl

MPIPreferences.jl is a small package based on [Preferences.jl](https://github.com/JuliaPackaging/Preferences.jl/) for selecting MPI implementations.
These choices are compile-time constants, and so any changes will require a Julia restart.

## Consts

```@docs
MPIPreferences.binary
MPIPreferences.abi
```

## Changing implementations

```@docs
MPIPreferences.use_system_binary
MPIPreferences.use_jll_binary
```

## Utils

```@docs
MPIPreferences.check_unchanged
MPIPreferences.identify_abi
MPIPreferences.dlopen_preloads
```

## Preferences schema

MPIPreferences utilizes the following keys to store information in the Preferences key-value store.

- `_format`: the version number of the schema. Currently only `"1.0"` is supported.
- `binary`: the choice of binary. This should be one of the strings listed in [`MPIPreferences.binary`](@ref).

If `binary == "system"`, then the following keys are also required (otherwise they have no effect):
- `libmpi`: the filename or path of the MPI dynamic library.
- `abi`: The ABI of the MPI implementation. This should be one of the strings listed in [`MPIPreferences.abi`](@ref).
- `mpiexec`: either
  - a string corresponding to the MPI launcher executable
  - an array of strings, with the first entry being the executable and remaining entried being additional flags that should be used with the executable.