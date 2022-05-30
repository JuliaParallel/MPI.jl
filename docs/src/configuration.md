# Configuration

By default, MPI.jl will download and link against the following MPI implementations:
- [Microsoft MPI](https://docs.microsoft.com/en-us/message-passing-interface/microsoft-mpi) on Windows
- [MPICH](http://www.mpich.org/) on all other platforms

This is suitable for most single-node use cases, but for larger systems, such as HPC
clusters or multi-GPU machines, you will probably want to configure against a
system-provided MPI implementation in order to exploit features such as fast network
interfaces and CUDA-aware MPI interfaces.

The MPIPreferences.jl package allows the user to choose which MPI implementation to use in MPI.jl. It uses [Preferences.jl](https://github.com/JuliaPackaging/Preferences.jl) to
configure the MPI backend for each project separately. This provides
a single source of truth that can be used for JLL packages (Julia packages providing C libraries)
that link against MPI. It can be installed by

```sh
julia -e 'using Pkg; Pkg.add("MPIPreferences")'
```

## Using a system-provided MPI backend

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

If you are using an MPI implementation that is not ABI-compatible with any one
of these, please read the section on [Supporting an unknown ABI](@ref) below.

### Configuration

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


### Notes to HPC cluster adminstators

Preferences are merged across the Julia load path, such that it is feasible to provide a module file that appends a path to
`JULIA_LOAD_PATH` variable that contains system-wide preferences. The steps are as follows:

1. Run [`MPIPreferences.use_system_binary()`](@ref MPIPreferences.use_system_binary), which will generate a file `LocalPreferences.toml` containing something like the following:

   ```toml
   [MPIPreferences]
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
   append-path  -d {} JULIA_LOAD_PATH :/software/mpi/julia
   ```
   in the corresponding module file (preferably the module file for the MPI installation or for Julia).

   The user can still provide differing MPI configurations for each Julia project
   that will take precedent by modifying the local `Project.toml` or by providing a
   `LocalPreferences.toml` file.


### Supporting an unknown ABI
If you want to use an MPI implementation not officially supported by MPI.jl, you
need to create your own ABI file with all relevant MPI constants. The files for supported
ABIs are stored in the `src/consts/` folder, e.g.,
[`mpich.jl`](https://github.com/JuliaParallel/MPI.jl/blob/master/src/consts/mpich.jl)
for MPICH-compatible implementations. To create your own ABI file, it is
advisable to start with an existing constants file (e.g., for MPICH) and then
adapt each entry to the contents of your MPI implementations's `mpi.h` C header
file.

For example, if your `mpi.h` header file contains something like
```c
typedef unsigned int MPI_Request;
enum {
  MPI_REQUEST_NULL  = 0
};

#define MPI_ARGV_NULL ((char**) NULL)
```
you need to put the corresponding entries in your ABI file `abi_file.jl`:
```julia
const MPI_Request = Cuint
@const_ref MPI_REQUEST_NULL MPI_Request 0

@const_ref MPI_ARGV_NULL Ptr{Cvoid} C_NULL
```
As you can see, the syntax of such a Julia ABI file is non-trivial, thus the
recommendation to start with an existing ABI file.
It is further advisable to always use the corresponding Julia alias for
standard C types, e.g., `Cuint` for `unsigned int` or `Clonglong` for `long
long`.
Please note that sometimes information is also stored in ancillary header files (e.g.,
`mpi_types.h` or `mpi_ext.h`).

You can then use [`MPIPreferences.use_system_binary`](@ref) to configure MPI.jl
to use your custom file by providing the path via the `abi_file` keyword
argument, e.g.,
```shell
julia --project -e 'using MPIPreferences; MPIPreferences.use_system_binary(; abi_file="path/to/abifile.jl)'
```
You need to restart Julia for the change to take effect.


## Using an alternative JLL-provided MPI library

The following MPI implementations are provided as JLL packages and automatically obtained when installing MPI.jl:

- `MicrosoftMPI_jll`: [Microsoft MPI](https://docs.microsoft.com/en-us/message-passing-interface/microsoft-mpi) Default for Windows
- `MPICH_jll`: [MPICH](https://www.mpich.org/). Default for all other systems
- `OpenMPI_jll`: [Open MPI](https://www.open-mpi.org/)
- `MPItrampoline_jll`: [MPItrampoline](https://github.com/eschnett/MPItrampoline): an MPI forwarding layer.

Call [`MPIPreferences.use_jll_binary`](@ref), for example
```sh
julia --project -e 'using MPIPreferences; MPIPreferences.use_jll_binary("MPItrampoline_jll")'
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


## Migration from MPI.jl version 0.19 or earlier

Prior to MPI.jl version 0.20, environment variables were used to configure which MPI
library to use. These have now been removed and no longer have any effect:

- `JULIA_MPI_BINARY`
- `JULIA_MPIEXEC`
- `JULIA_MPIEXEC_ARGS`
- `JULIA_MPI_INCLUDE_PATH`
- `JULIA_MPI_CFLAGS`
- `JULIA_MPICC`
