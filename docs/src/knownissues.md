# Known issues

## Julia module precompilation

If multiple MPI ranks trigger Julia's module precompilation, then a race condition can result in an error such as:
```
ERROR: LoadError: IOError: mkdir: file already exists (EEXIST)
Stacktrace:
 [1] uv_error at ./libuv.jl:97 [inlined]
 [2] mkdir(::String; mode::UInt16) at ./file.jl:177
 [3] mkpath(::String; mode::UInt16) at ./file.jl:227
 [4] mkpath at ./file.jl:222 [inlined]
 [5] compilecache_path(::Base.PkgId) at ./loading.jl:1210
 [6] compilecache(::Base.PkgId, ::String) at ./loading.jl:1240
 [7] _require(::Base.PkgId) at ./loading.jl:1029
 [8] require(::Base.PkgId) at ./loading.jl:927
 [9] require(::Module, ::Symbol) at ./loading.jl:922
 [10] include(::Module, ::String) at ./Base.jl:377
 [11] exec_options(::Base.JLOptions) at ./client.jl:288
 [12] _start() at ./client.jl:484
```

See [julia issue #30174](https://github.com/JuliaLang/julia/pull/30174) for more discussion of this problem. There are similar issues with Pkg operations, see [Pkg issue #1219](https://github.com/JuliaLang/Pkg.jl/issues/1219).

This can be worked around be either:

1. Triggering precompilation before launching MPI processes, for example:

   ```
   julia --project -e 'using Pkg; pkg"instantiate"'
   julia --project -e 'using Pkg; pkg"precompile"'
   mpiexec julia --project script.jl
   ```

2. Launching julia with the  `--compiled-modules=no` option. This can result in much longer package load times.

## UCX

[UCX](https://www.openucx.org/) is a communication framework used by several MPI implementations.

### Memory cache

When used with CUDA, UCX intercepts `cudaMalloc` so it can determine whether the pointer passed to MPI is on the host (main memory) or the device (GPU). Unfortunately, there are several known issues with how this works with Julia:
- [UCX issue #5061](https://github.com/openucx/ucx/issues/5061)
- [UCX issue #4001](https://github.com/openucx/ucx/issues/4001) (fixed in UCX v1.7.0)

By default, MPI.jl disables this by setting
```
ENV["UCX_MEMTYPE_CACHE"] = "no"
```
at `__init__` which may result in reduced performance, especially for smaller messages.

### Multi-threading and signal handling

When using [Julia multi-threading](https://docs.julialang.org/en/v1/manual/parallel-computing/#man-multithreading-1), the Julia garbage collector internally [uses `SIGSEGV` to synchronize threads](https://docs.julialang.org/en/v1/devdocs/debuggingtips/#Dealing-with-signals-1).

By default, UCX will error if this signal is raised ([#337](https://github.com/JuliaParallel/MPI.jl/issues/337)), resulting in a message such as:
```
Caught signal 11 (Segmentation fault: invalid permissions for mapped object at address 0xXXXXXXXX)
```

This signal interception can be controlled by setting the environment variable `UCX_ERROR_SIGNALS`: if not already defined, MPI.jl will set it as:
```
ENV["UCX_ERROR_SIGNALS"] = "SIGILL,SIGBUS,SIGFPE"
```
at `__init__`. If set externally, it should be modified to exclude `SIGSEGV` from the list.

## CUDA-aware MPI

### Memory pool

Using CUDA-aware MPI on multi-GPU nodes with recent CUDA.jl may trigger (see [here](https://github.com/JuliaGPU/CUDA.jl/issues/1053#issue-946826096))
```
The call to cuIpcGetMemHandle failed. This means the GPU RDMA protocol
cannot be used.
  cuIpcGetMemHandle return value:   1
```
in the MPI layer, or fail on a segmentation fault (see [here](https://discourse.julialang.org/t/cuda-aware-mpi-works-on-system-but-not-for-julia/75060)) with
```
[1642930332.032032] [gcn19:4087661:0] gdr_copy_md.c:122 UCX ERROR gdr_pin_buffer failed. length :65536 ret:22
```
This is due to the MPI implementation using legacy `cuIpc*` APIs, which are incompatible with stream-ordered allocator, now default in CUDA.jl, see [UCX issue #7110](https://github.com/openucx/ucx/issues/7110).

To circumvent this, one has to ensure the CUDA memory pool to be set to `none`:
```
export JULIA_CUDA_MEMORY_POOL=none
```
_More about CUDA.jl [memory environment-variables](https://cuda.juliagpu.org/stable/usage/memory/#Memory-pool)._

### Hints to ensure CUDA-aware MPI to be functional

Make sure to:
- Have MPI and CUDA on path (or module loaded) that were used to build the CUDA-aware MPI
- Make sure to have:
    ```
    export JULIA_CUDA_MEMORY_POOL=none
    export JULIA_MPI_BINARY=system
    export JULIA_CUDA_USE_BINARYBUILDER=false
    ```
- Add CUDA and MPI packages in Julia. Build MPI.jl in verbose mode to check whether correct versions are built/used: 
    ```
    julia -e 'using Pkg; pkg"add CUDA"; pkg"add MPI"; Pkg.build("MPI"; verbose=true)'
    ```
- Then in Julia, upon loading MPI and CUDA modules, you can check
  - CUDA version: `CUDA.versioninfo()`
  - If MPI has CUDA: `MPI.has_cuda()`
  - If you are using correct MPI implementation: `MPI.identify_implementation()`

After that, it may be preferred to run the Julia MPI script (as suggested [here](https://discourse.julialang.org/t/cuda-aware-mpi-works-on-system-but-not-for-julia/75060/11)) launching it from a shell script (as suggested [here](https://discourse.julialang.org/t/cuda-aware-mpi-works-on-system-but-not-for-julia/75060/4)).

## Microsoft MPI

### Custom operators on 32-bit Windows

It is not possible to use [custom operators with 32-bit Microsoft MPI](https://github.com/JuliaParallel/MPI.jl/issues/246), as it uses the `stdcall` calling convention, which is not supported by [Julia's C-compatible function pointers](https://docs.julialang.org/en/v1/manual/calling-c-and-fortran-code/index.html#Creating-C-Compatible-Julia-Function-Pointers-1).
