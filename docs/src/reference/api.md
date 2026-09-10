# Low-level API

The `MPI.API` submodule provides a low-level interface which closely matches the MPI C API.
While these functions are not intended for general usage, they are useful for calling MPI routines not yet available in `MPI.jl` main interface, and is the basis for the high-level wrappers.

## Large counts

The methods suffixed with `_c` are the MPI 4.0 large-count entry points: they take
`MPI_Count` typed arguments where the others take `int`. The size of `MPI_Count` depends
on the implementation, but usually allows 64-bit integer counts, so these are the methods
to use for messages of more than `typemax(Cint)` elements.

They can be called against any supported MPI library. Where the library predates MPI 4.0
and does not provide them, each `MPI_Foo_c` falls back to the narrow `MPI_Foo` at
precompilation time; a count that does not fit in an `int` then raises an `InexactError`
rather than being silently truncated. [`MPI.API.HAS_LARGE_COUNT`](@ref) says which of the
two is in use.

That fallback is transparent for a count passed by value, since `ccall` converts it, but
not for one passed through a pointer. Type arrays and `Ref`s with
[`MPI.API.Count`](@ref), [`MPI.API.Displ`](@ref) or [`MPI.API.TypeDispl`](@ref), which
follow whichever entry point is in use — a `Ref{MPI_Count}` reaching a fallback that
expects a `Ptr{Cint}` is a `MethodError`.

Two of them are deliberately excluded from that fallback, because their callback
signature widens along with the counts: `MPI_Op_create_c` takes an `MPI_User_function_c`
(whose `len` argument is an `MPI_Count *`) rather than an `MPI_User_function` (an
`int *`), and `MPI_Register_datarep_c` likewise. Both raise
[`MPI.FeatureLevelError`](@ref) on a library that does not provide them.

## Feature levels

Wrappers for procedures the MPI library does not provide are replaced, when MPI.jl is
precompiled, by a `throw(`[`MPI.FeatureLevelError`](@ref)`)`. The reported minimum MPI
version comes from a table derived from the MPI standard's own machine-readable binding
description; see `MPI.jl/gen/versions/README.md`. Procedures that have been in MPI since
3.1 or earlier carry no version, since MPI.jl requires MPI 3.0 or later anyway.

```@docs
MPI.API.@mpichk
MPI.API.HAS_LARGE_COUNT
MPI.API.Count
MPI.API.Displ
MPI.API.TypeDispl
```

```@autodocs
Modules = [MPI.API]
Order = [:function]
```
