# Configuration

By default, MPI.jl will download and link against the following MPI implementations:
- [Microsoft MPI](https://docs.microsoft.com/en-us/message-passing-interface/microsoft-mpi) on Windows
- [MPICH](http://www.mpich.org/) on all other platforms

This is suitable for most single-node use cases, but for larger systems, such as HPC
clusters or multi-GPU machines, you will probably want to configure against a
system-provided MPI implementation in order to exploit features such as fast network
interfaces and CUDA-aware or ROCm-aware MPI interfaces.

The MPIPreferences.jl package allows the user to choose which MPI implementation to use in MPI.jl. It uses [Preferences.jl](https://github.com/JuliaPackaging/Preferences.jl) to
configure the MPI backend for each project separately. This provides
a single source of truth that can be used for JLL packages (Julia packages providing C libraries)
that link against MPI. It can be installed by

```sh
julia --project -e 'using Pkg; Pkg.add("MPIPreferences")'
```

!!! note
    The way MPI.jl is configured has changed with MPI.jl v0.20.
    See [Migration from MPI.jl v0.19 or earlier](@ref) for more information on
    how to migrate your configuration from earlier MPI.jl versions.

## [Using a system-provided MPI backend](@id using_system_mpi)

### Requirements

MPI.jl requires a shared library installation of a C MPI library, supporting the MPI 3.0
standard or later. The following MPI implementations should work out-of-the-box with MPI.jl:

- [Open MPI](http://www.open-mpi.org/)
- [MPICH](http://www.mpich.org/) (v3.1 or later)
- [Intel MPI](https://software.intel.com/en-us/mpi-library)
- [Microsoft MPI](https://docs.microsoft.com/en-us/message-passing-interface/microsoft-mpi)
- [IBM Spectrum MPI](https://www.ibm.com/us-en/marketplace/spectrum-mpi)
- [MVAPICH](http://mvapich.cse.ohio-state.edu/)
- [Cray MPICH](https://docs.nersc.gov/development/compilers/wrappers/)
- [Fujitsu MPI](https://www.fujitsu.com/global/about/resources/publications/technicalreview/2020-03/article07.html#cap-03)
- [HPE MPT/HMPT](https://support.hpe.com/hpesc/public/docDisplay?docLocale=en_US&docId=a00105727en_us)

### [Configuration](@id configure_system_binary)

Run `MPIPreferences.use_system_binary()`. This will attempt to locate and to identify any available MPI implementation, and create a file called `LocalPreferences.toml` adjacent to the current `Project.toml`.

```sh
julia --project -e 'using MPIPreferences; MPIPreferences.use_system_binary()'
```

If the implementation is changed, you will need to call this function again. See the [`MPIPreferences.use_system_binary`](@ref) documentation for specific options.

!!! note
    You can copy `LocalPreferences.toml` to a different project folder, but you must list
    `MPIPreferences` in the `[extras]` or `[deps]` section of the `Project.toml` for the settings
    to take effect.

!!! note
    Due to a bug in Julia (until `v1.6.5` and `v1.7.1`), getting preferences
    from transitive dependencies is broken ([Preferences.jl#24](https://github.com/JuliaPackaging/Preferences.jl/issues/24)).
    To fix this update your version of Julia, or add `MPIPreferences` as a direct dependency to your project.

### Notes to HPC cluster administrators

Preferences are merged across the Julia load path, such that it is feasible to provide a module file that appends a path to
`JULIA_LOAD_PATH` variable that contains system-wide preferences. The steps are as follows:

1. Run [`MPIPreferences.use_system_binary()`](@ref MPIPreferences.use_system_binary), which will generate a file `LocalPreferences.toml` containing something like the following:

   ```toml
   [MPIPreferences]
   _format = "1.0"
   abi = "OpenMPI"
   binary = "system"
   libmpi = "/software/mpi/lib/libmpi.so"
   mpiexec = "/software/mpi/bin/mpiexec"
   ```

2. Create a file called `Project.toml` or `JuliaProject.toml` in a central location, for example `/software/mpi/julia` or in the same directory as the MPI library module, and add the following contents:

   ```toml
   [extras]
   MPIPreferences = "3da0fdf6-3ccc-4f1b-acd9-58baa6c99267"

   [preferences.MPIPreferences]
   _format = "1.0"
   abi = "OpenMPI"
   binary = "system"
   libmpi = "/software/mpi/lib/libmpi.so"
   mpiexec = "/software/mpi/bin/mpiexec"
   ```

   updating the contents of the `[preferences.MPIPreferences]` section match those of the `[MPIPreferences]` in `LocalPreferences.toml`.

3. Append the directory containing the file to the [`JULIA_LOAD_PATH`](https://docs.julialang.org/en/v1/manual/environment-variables/#JULIA_LOAD_PATH) environment variable, with a colon (`:`) separator.

   If this variable is _not_ already set, it should be prefixed with a colon to ensure correct
   behavior of the Julia load path, e.g. `JULIA_LOAD_PATH=":/software/mpi/julia"`.
   If using environment modules, this can be achieved with
   ```
   append-path -d {} JULIA_LOAD_PATH :/software/mpi/julia
   ```
   in the corresponding module file (preferably the module file for the MPI installation or for Julia).

   The user can still provide differing MPI configurations for each Julia project
   that will take precedent by modifying the local `Project.toml` or by providing a
   `LocalPreferences.toml` file.

### Notes about vendor-provided MPI backends

`MPIPreferences` can load vendor-specific libraries and settings using the
`vendor` parameter, eg `MPIPreferences.use_system_binary(mpiexec="srun", vendor="cray")`
configures `MPIPreferences` for use on Cray systems with `srun`.

!!! note
    Currently `vendor` only supports Cray systems.

This populates the `library_names`, `preloads`, `preloads_env_switch` and
`cclibs` preferences. These are defermined by parsing `cc --cray-print-opts=all`
emitted from the Cray Compiler Wrappers. Therefore `use_system_binary` needs
to be run on the target system, with the corresponding `PrgEnv` loaded.

The function of these settings are as follows:
 * `preloads` specifies a list of libraries that are to be loaded (in order)
   before `libmpi`.
 * `preloads_env_switch` specifies the name of an environment variable that, if
   set to `0`, can disable the `preloads`
 * `cclibs` is a list of libraries also linked by the compiler wrappers. This is
   recorded mainly for debugging purposes, and the libraries listed here are not
   explicitly loaded by `MPI.jl`.

An example of running `MPIPreferences.use_system_library(vendor="cray")` in
`PrgEnv-gnu` is:

```toml
[MPIPreferences]
_format = "1.1"
abi = "MPICH"
binary = "system"
cclibs = ["cupti", "cudart", "cuda", "sci_gnu_82_mpi", "sci_gnu_82", "dl", "dsmml", "xpmem"]
libmpi = "libmpi_gnu_91.so"
mpiexec = "mpiexec"
preloads = ["libmpi_gtl_cuda.so"]
preloads_env_switch = "MPICH_GPU_SUPPORT_ENABLED"
```

This is an example of CrayMPICH requiring `libmpi_gtl_cuda.so` to be preloaded,
unless `MPICH_GPU_SUPPORT_ENABLED=0` (the latter allowing MPI-enabled code to
run on a non-GPU enabled node without needing a seperate `LocalPreferences.toml`).

## [Using an alternative JLL-provided MPI library](@id configure_jll_binary)

The following MPI implementations are provided as JLL packages and automatically obtained when installing MPI.jl:

- `MicrosoftMPI_jll`: [Microsoft MPI](https://docs.microsoft.com/en-us/message-passing-interface/microsoft-mpi) Default for Windows
- `MPICH_jll`: [MPICH](https://www.mpich.org/). Default for all other systems
- `OpenMPI_jll`: [Open MPI](https://www.open-mpi.org/)
- `MPItrampoline_jll`: [MPItrampoline](https://github.com/eschnett/MPItrampoline): an MPI forwarding layer.

Call [`MPIPreferences.use_jll_binary`](@ref), for example
```sh
julia --project -e 'using MPIPreferences; MPIPreferences.use_jll_binary("MPItrampoline_jll")'
```
If you omit the JLL binary name, the default is selected for the respective
operating system.

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
- `JULIA_MPI_TEST_ARRAYTYPE`: Set to `CuArray` or `ROCArray` to test the CUDA-aware interface with
  [`CUDA.CuArray`](https://github.com/JuliaGPU/CUDA.jl) or the ROCm-aware interface with
  [`AMDGPU.ROCArray`](https://github.com/JuliaGPU/AMDGPU.jl) or buffers.
- `JULIA_MPI_TEST_BINARY`: Check that the specified MPI binary is used for the tests
- `JULIA_MPI_TEST_ABI`: Check that the specified MPI ABI is used for the tests


## Migration from MPI.jl v0.19 or earlier

For MPI.jl v0.20, environment variables were used to configure which MPI
library to use. These have been removed and no longer have any effect. The
following subsections explain how to the same effects can be achieved with v0.20
or later.

!!! note
    Please refer to [Notes to HPC cluster administrators](@ref) if you want to
    migrate your MPI.jl preferences on a cluster with a centrally managed MPI.jl
    configuration.

### `JULIA_MPI_BINARY`
Use [`MPIPreferences.use_system_binary`](@ref) to use a system-provided MPI
binary as described [here](@ref configure_system_binary). To switch back or
select a different JLL-provided MPI binary, use
[`MPIPreferences.use_jll_binary`](@ref) as described [here](@ref configure_jll_binary).

### `JULIA_MPI_PATH`
Removed without replacement.

### `JULIA_MPI_LIBRARY`
Use [`MPIPreferences.use_system_binary`](@ref) with keyword argument
`library_names` to specify possible, non-standard library names. Alternatively,
you can also specify the full path to the library.

### `JULIA_MPI_ABI`
Use [`MPIPreferences.use_system_binary`](@ref) with keyword argument
`abi` to specify which ABI to use. See [`MPIPreferences.abi`](@ref) for possible
values.

### `JULIA_MPIEXEC`
Use [`MPIPreferences.use_system_binary`](@ref) with keyword argument
`mpiexec` to specify the MPI launcher executable.

### `JULIA_MPIEXEC_ARGS`
Use [`MPIPreferences.use_system_binary`](@ref) with keyword argument `mpiexec`,
and pass a
[`Cmd`](https://docs.julialang.org/en/v1/manual/running-external-programs/#Cmd-Objects)
object to set the MPI launcher executable and to include specific command
line options.

### `JULIA_MPI_INCLUDE_PATH`
Removed without replacement. Automatic generation of a constants file for
unknown MPI ABIs is not supported anymore. See also
[#574](https://github.com/JuliaParallel/MPI.jl/issues/574).

### `JULIA_MPI_CFLAGS`
Removed without replacement. Automatic generation of a constants file for
unknown MPI ABIs is not supported anymore. See also
[#574](https://github.com/JuliaParallel/MPI.jl/issues/574).

### `JULIA_MPICC`
Removed without replacement. Automatic generation of a constants file for
unknown MPI ABIs is not supported anymore. See also
[#574](https://github.com/JuliaParallel/MPI.jl/issues/574).
