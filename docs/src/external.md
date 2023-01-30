# External libraries and packages

Other libraries and packages may also make use of MPI. There are several concerns to ensure things are set up correctly.

## Binary requirements

You need to ensure that external libraries are built correctly. In particular, if you are [using a system-provided MPI backend](@ref using_system_mpi) in Julia, you also need to use the *same* system-provided binary for all packages and external libraries you use.

## Passing MPI handles via `ccall`

When passing MPI.jl handle objects ([`MPI.Comm`](@ref), [`MPI.Info`](@ref), etc) to C/C++ functions [via `ccall`](https://docs.julialang.org/en/v1/manual/calling-c-and-fortran-code/), you should pass the object directly as an argument, and specify the argument type as either the underlying handle type (`MPI.MPI_Comm`, `MPI.API.MPI_Info`, etc.), or a pointer (`Ptr{MPI.MPI_Comm}`, `Ptr{MPI.MPI_Info}`, etc.). This will internally handle the unwrapping, but ensure that a reference is kept to avoid premature garbage collection.

For example the C function signatures
```C
int cfunc1(MPI_Comm comm);
int cfunc2(MPI_Comm * comm);
```
would be called as
```julia
ccall((:cfunc1, lib), Cint, (MPI.MPI_Comm,), comm)
ccall((:cfunc2, lib), Cint, (Ptr{MPI.MPI_Comm},), comm)
```

## Object finalizers and `MPI.Finalize`

External libraries may allocate their own MPI handles (e.g., create or duplicate MPI communictors), which need to be cleaned up before MPI is finalized. If these are attached to [object finalizers](https://docs.julialang.org/en/v1/base/base/#Base.finalizer), they may not be guaranteed to be called before `MPI.Finalize`, which can result in an error upon program exit. (By default, MPI.jl will install an [`atexit`](https://docs.julialang.org/en/v1/base/base/#Base.atexit) hook that calls `MPI.Finalize` if it hasn't already been invoked.)

There are two typical solutions to this problem:

1. Gate the clean up functions behind an [`MPI.Finalized`](@ref) call, e.g.

   ```julia
   finalizer(obj) do obj
       if !MPI.Finalized
           # call clean up funciton
       end
   end
   ```

2. Keep track of all such objects, clean them up via [`MPI.add_finalize_hook!`](@ref), e.g.

   ```julia
   finalizer(obj) do obj
       # call clean up funciton
   end
   MPI.add_finalize_hook!(() -> finalize(obj))
   ```
