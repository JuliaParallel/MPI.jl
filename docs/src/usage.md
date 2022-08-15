# Usage

MPI is based on a [single program, multiple data (SPMD)](https://en.wikipedia.org/wiki/SPMD) model, where multiple processes are launched running independent programs, which then communicate as necessary via messages.

## Basic example

A script should include `using MPI` and [`MPI.Init()`](@ref) statements before calling any MPI operations, for example

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


## Julia wrapper for `mpiexec`

Since you can configure `MPI.jl` to use one of several MPI implementations, you
may have different Julia projects using different implementation.  Thus, it may
be cumbersome to find out which `mpiexec` executable is associated to a specific
project.  To make this easy, on Unix-based systems `MPI.jl` comes with a thin
project-aware wrapper around `mpiexec`, called `mpiexecjl`.

### Installation

You can install `mpiexecjl` with [`MPI.install_mpiexecjl()`](@ref).  The default
destination directory is `joinpath(DEPOT_PATH[1], "bin")`, which usually
translates to `~/.julia/bin`, but check the value on your system.  You can also
tell `MPI.install_mpiexecjl` to install to a different directory.

```sh
$ julia
julia> using MPI
julia> MPI.install_mpiexecjl()
```

To quickly call this wrapper we recommend you to add the destination directory
to your [`PATH`](https://en.wikipedia.org/wiki/PATH_(variable)) environment
variable.

### Usage

`mpiexecjl` has the same syntax as the `mpiexec` binary that will be called, but
it takes in addition a `--project` option to call the specific binary associated
to the `MPI.jl` version in the given project.  If no `--project` flag is used,
the `MPI.jl` in the global Julia environment will be used instead.

After installing `mpiexecjl` and adding its directory to `PATH`, you can run it
with:

```sh
$ mpiexecjl --project=/path/to/project -n 20 julia script.jl
```

## CUDA-aware MPI support

If your MPI implementation has been compiled with CUDA support, then `CUDA.CuArray`s (from the
[CUDA.jl](https://github.com/JuliaGPU/CUDA.jl) package) can be passed directly as
send and receive buffers for point-to-point and collective operations (they may also work with one-sided operations, but these are not often supported).

If using Open MPI, the status of CUDA support can be checked via the
[`MPI.has_cuda()`](@ref) function.

## ROCm-aware MPI support

If your MPI implementation has been compiled with ROCm support (AMDGPU), then `AMDGPU.ROCArray`s (from the
[AMDGPU.jl](https://github.com/JuliaGPU/AMDGPU.jl) package) can be passed directly as send and receive buffers for point-to-point and collective operations (they may also work with one-sided operations, but these are not often supported).

Successfully running the [alltoall\_test\_rocm.jl](https://gist.github.com/luraess/c228ec08629737888a18c6a1e397643c) 
should confirm your MPI implementation to have the ROCm support (AMDGPU) enabled. Moreover, successfully running the 
[alltoall\_test\_rocm\_multigpu.jl](https://gist.github.com/luraess/a47931d7fb668bd4348a2c730d5489f4) should confirm 
your ROCm-aware MPI implementation to use multiple AMD GPUs (one GPU per rank).

The status of ROCm (AMDGPU) support cannot currently be queried.

## Writing MPI tests

It is recommended to use the `mpiexec()` wrapper when writing your package tests in `runtests.jl`:

```julia
# test/runtests.jl
using MPI
using Test

@testset "hello" begin
    n = 2  # number of processes
    mpiexec() do exe  # MPI wrapper
        run(`$exe -n $n $(Base.julia_cmd()) [...]/01-hello.jl`)
        # alternatively:
        # p = run(ignorestatus(`...`))
        # @test success(p)
    end
end
```
