# Configuration

By default, MPI.jl will download and link against the following MPI implementations:
- [Microsoft MPI](https://docs.microsoft.com/en-us/message-passing-interface/microsoft-mpi) on Windows
- [MPICH](http://www.mpich.org/) on all other platforms

This is suitable for most single-node use cases, but for larger systems, such as HPC
clusters or multi-GPU machines, you will probably want to configure against a
system-provided MPI implementation in order to exploit features such as fast network
interfaces and CUDA-aware MPI interfaces.

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

## Using MPIPreferences.jl

MPI.jl uses [Preferences.jl](https://github.com/JuliaPackaging/Preferences.jl) to
allow the user to choose which MPI implementation to use for a project. This provides
a single source of truth that can be used for JLL packages (Julia packages providing C libraries)
that link against MPI, localizes the choice of MPI implementation to a project.

Users can use the provided [`use_system_binary`](@ref) or [`use_jll_binary`](@ref)
to switch MPI implementations. By default, the JLL-provided binaries are used.

### Migration from MPI.jl `v0.19`

Prior to MPI.jl `v0.20` environment variables were used to configure which MPI
library to use. These have now been removed and have no effect anymore:

- `JULIA_MPI_BINARY`
- `JULIA_MPIEXEC`
- `JULIA_MPI_INCLUDE_PATH`
- `JULIA_MPI_CFLAGS`
- `JULIA_MPICC`

### Using a system-provided MPI backend

#### Requirements

MPI.jl requires a shared library installation of a C MPI library, supporting the MPI 3.0
standard or later.

### Configuration

To use the system MPI library, run `MPI.use_system_binary()`.
This will attempt to locate and to identify any available MPI implementation, and create
a file called `LocalPreferences.toml` adjacent to the current `Project.toml`.
Use `Base.active_project()` to obtain the location of the currently active project.

```sh
julia --project -e 'using MPI; MPI.use_system_binary()'
```

!!! note
    You can copy `LocalPreferences.toml` to a different project folder, but you must list
    `MPIPreferences` in the `[extras]` section of the `Project.toml` for the settings
    to take effect. Due to a bug in Julia (until `v1.6.5` and `v1.7.1`), getting preferences
    from transitive dependencies is broken (https://github.com/JuliaPackaging/Preferences.jl/issues/24).
    To fix this update your version of Julia, or add `MPIPreferences` as a direct dependency to your project.


The following MPI implementations should work out-of-the-box with MPI.jl:

- [Open MPI](http://www.open-mpi.org/)
- [MPICH](http://www.mpich.org/) (v3.1 or later)
- [Intel MPI](https://software.intel.com/en-us/mpi-library)
- [Microsoft MPI](https://docs.microsoft.com/en-us/message-passing-interface/microsoft-mpi)
- [IBM Spectrum MPI](https://www.ibm.com/us-en/marketplace/spectrum-mpi)
- [MVAPICH](http://mvapich.cse.ohio-state.edu/)
- [Cray MPICH](https://docs.nersc.gov/development/compilers/wrappers/)
- [Fujitsu MPI](https://www.fujitsu.com/global/about/resources/publications/technicalreview/2020-03/article07.html#cap-03)

If the implementation is changed, you will need to use [`MPI.use_system_binary()`](@ref) or
[`MPI.use_jll_binary()`](@ref).

#### Advanced options

```@doc
MPI.use_system_binary
```

You can use the argument `mpiexec` to provide the name (or full path) of the MPI launcher executable. The default is
`mpiexec`, but some clusters require using the scheduler launcher interface (e.g. `srun`
on Slurm, `aprun` on PBS). If the MPI library has an uncommon name you can provide it in `library_names`.
The MPI standard does not specify the exact application binary interface (ABI).
In case ABI detection fails you can provide a manual choice (either `MPICH`, `MPItrampoline`, `OpenMPI`, or `MicrosoftMPI`),
but also open an issue such that the automatic detection can be improved.
`export_prefs=true` can be used to copy the preferences into the `Project.toml` instead of creating a
`LocalPreferences.toml` file to hold them.

#### Notes to HPC cluster adminstators

Preferences are merged across the Julia load path, such that it is feasible to provide a module file that appends a path to
`JULIA_LOAD_PATH` variable that contains system-wide preferences.

As an example you can use [`MPI.use_system_binary()`](@ref) to create a file `LocalPreferences.toml` containing:

```toml
[MPIPreferences]
abi = "OpenMPI"
binary = "system"
libmpi = "/software/mpi/lib/libmpi.so"
mpiexec = "/software/mpi/bin/mpiexec"
```

Copying this `LocalPreferences.toml` to a central location such as `/software/mpi/julia` and
create adjacent to it a `Project.toml` containing:

```toml
[extras]
MPIPreferences = "3da0fdf6-3ccc-4f1b-acd9-58baa6c99267"
```

Now exporting the environment variable `JULIA_LOAD_PATH=":/software/mpi/julia"`
(note the `:` before the path) in the corresponding
module file (preferably the module file for the MPI installation or for Julia),
will cause MPI.jl to default to your cluster MPI installation.

The user can still provide differing MPI configurations for each Julia project that
will take precedent by modifying the local `Project.toml` or by providing a `LocalPreferences.toml` file.

### Using a different JLL provided MPI library

The following MPI implementations are provided as JLL packages and automatically obtained when installing MPI.jl:

- `MicrosoftMPI_jll`: Default for Windows
- `MPICH_jll`: Default for all Unix-like systems
- [`MPItrampoline_jll`](https://github.com/eschnett/MPItrampoline): Binaries built against MPItrampoline can be efficiently retargetted to a system MPI implementation.
- `OpenMPI_jll`:

```@doc
MPI.use_jll_binary
```

## Configuration of the MPI.jl testsuite

### Testing against a different MPI implementation

The `LocalPreferences.toml` must be located within the `test` folder, you can
either create it in place or copy it into place.

```
~/MPI> julia --project=test
julia> using MPIPreferences
julia> MPIPreferences.use_system_binary()
~/MPI> rm test/Manifest.toml
~/MPI> julia --project
(MPI) pkg> test
```

### Environment variables
The test suite can also be modified by the following variables:

- `JULIA_MPI_TEST_NPROCS`: How many ranks to use within the tests
- `JULIA_MPI_TEST_ARRAYTYPE`: Set to `CuArray` to test the CUDA-aware interface with
  [`CUDA.CuArray](https://github.com/JuliaGPU/CUDA.jl) buffers.
- `JULIA_MPI_TEST_BINARY`: Check that the specified MPI binary is used for the tests
- `JULIA_MPI_TEST_ABI`: Check that the specified MPI ABI is used for the tests
