# Configuration

By default, MPI.jl will download and link against the following MPI implementations:
- [Microsoft MPI](https://docs.microsoft.com/en-us/message-passing-interface/microsoft-mpi) on Windows
- [MPICH](http://www.mpich.org/) on all other platforms

This is suitable for most single-node use cases, but for larger systems, such as HPC
clusters or multi-GPU machines, you will probably want to configure against a
system-provided MPI implementation in order to exploit feature such as fast network
interfaces and CUDA-aware MPI interfaces.

MPI.jl will attempt to detect when you are running on a HPC cluster, and warn the user
about this. To disable this warning, set the environment variable
`JULIA_MPI_CLUSTER_WARN=n`.

## Using a system-provided MPI

### Requirements

MPI.jl requires a shared library installation of a C MPI library, supporting the MPI 3.0
standard or later.

### Building

To use the the system MPI, set the environment variable `JULIA_MPI_BINARY=system` and run
`Pkg.build("MPI")`. This can be done by:
```
julia --project -e 'ENV["JULIA_MPI_BINARY"]="system"; using Pkg; Pkg.build("MPI"; verbose=true)'
```
This will attempt find and identify any available MPI implementation.

The MPI standard doesn't specify the exact application binary interface (ABI).
The build script will attempt to build a small C program to
determine the appropriate type definitions and constants. This requires a compatible C
compiler (`mpicc` by default).

The following implementations should work:

- [Open MPI](http://www.open-mpi.org/)
- [MPICH](http://www.mpich.org/) (v3.1 or later)
- [Intel MPI](https://software.intel.com/en-us/mpi-library)
- [Microsoft MPI](https://docs.microsoft.com/en-us/message-passing-interface/microsoft-mpi)
- [IBM Spectrum MPI](https://www.ibm.com/us-en/marketplace/spectrum-mpi)

If the implementation is changed, you will need to re-run `Pkg.build("MPI")`.

### [Environment variables](@id environment_variables)

The following optional environment variables can be used to control certain aspects of the
build script and other library behaviour. The results of these will be cached in a
configuration file located at `~/.julia/prefs/MPI.toml` and so can be used for subsequent
MPI builds.

- `JULIA_MPI_BINARY`: can be set to either the empty string (to use the default implementations
  above) or `system` (to use a system-provided implementation).
- `JULIA_MPI_PATH`: the top-level installation directory of MPI. i.e. the library should
  be located in `${JULIA_MPI_PATH}/lib` and `mpiexec` in `${JULIA_MPI_PATH}/bin`
- `JULIA_MPI_LIBRARY`: the library name or full path of the MPI shared library. By
  default, it will attempt to look for common MPI library names in the standard library
  paths (e.g. `libmpi`, `libmpich`, `msmpi`).
- `JULIA_MPIEXEC`: the name (or full path) of the MPI launcher executable. The default is
  `mpiexec`, but some clusters require using the scheduler launcher interface (e.g. `srun`
  on Slurm, `aprun` on PBS).
- `JULIA_MPIEXEC_ARGS`: Additional arguments to be passed to MPI launcher.

The following variables are also queried:

- `JULIA_MPI_INCLUDE_PATH`: the directory containing the MPI header files.
- `JULIA_MPI_CFLAGS`: C flags passed to the constant generation build (default: `-lmpi`)
- `JULIA_MPICC`: MPI C compiler (default: `mpicc`)

The test suite can also be modified by the following variables:

- `JULIA_MPIEXEC_TEST_ARGS`: Additional arguments to be passed to the MPI launcher for the tests only.
- `JULIA_MPI_TEST_ARRAYTYPE`: Set to `CuArray` to test the CUDA-aware interface with
  [`CUDA.CuArray](https://github.com/JuliaGPU/CUDA.jl) buffers.

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

```
$ mpiexecjl --project=/path/to/project -n 20 julia script.jl
```
