# Usage

MPI is based on a [single program, multiple data (SPMD)](https://en.wikipedia.org/wiki/SPMD) model, where multiple processes are launched running independent programs, which then communicate as necessary via messages.

## Basic example

A script should include `using MPI` and [`MPI.Init()`](@ref) statements before calling any MPI operaions, for example

```julia
# examples/01-hello.jl
using MPI
MPI.Init()

comm = MPI.COMM_WORLD
println("Hello world, I am $(MPI.Comm_rank(comm)) of $(MPI.Comm_size(comm))")
MPI.Barrier(comm)
```

Calling [`MPI.Finalize()`](@ref) at the end of the program is optional, as it will be called automatically when Julia exits.

The program can then be launched via an MPI launch command (typically `mpiexec`, `mpirun` or `srun`), e.g.
```
$ mpiexec -n 3 julia --project examples/01-hello.jl
Hello world, I am rank 0 of 3
Hello world, I am rank 2 of 3
Hello world, I am rank 1 of 3
```

The [`mpiexec`](@ref) function is provided for launching MPI programs from Julia itself.

## CUDA-aware MPI support

If your MPI implementation has been compiled with CUDA support, then `CUDA.CuArray`s (from the
[CUDA.jl](https://github.com/JuliaGPU/CUDA.jl) package) can be passed directly as
send and receive buffers for point-to-point and collective operations (they may also work
with one-sided operations, but these are not often supported).

If using Open MPI, the status of CUDA support can be checked via the
[`MPI.has_cuda()`](@ref) function.

## ROCm-aware MPI support

If your MPI implementation has been compiled with ROCm support (AMD GPU), then `AMDGPU.ROCArray`s (from the
[AMDGPU.jl](https://github.com/JuliaGPU/AMDGPU.jl) package) can be passed directly as
send and receive buffers for point-to-point and collective operations (they may also work
with one-sided operations, but these are not often supported).

There is currently no mechanism implemented in order to check the status of ROCm support (AMD GPU).
