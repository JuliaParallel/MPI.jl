# Configuration

By default, MPI.jl will download and link against the following MPI implementations:
- [Microsoft MPI](https://docs.microsoft.com/en-us/message-passing-interface/microsoft-mpi) on Windows
- [MPICH](http://www.mpich.org/) on all other platforms

This is suitable for most single-node use cases, but for larger systems, such as HPC
clusters or multi-GPU machines, you will probably want to configure against a
specialized MPI implementation in order to exploit features such as fast network
interfaces and CUDA-aware or ROCm-aware MPI interfaces.

There are three ways to point Julia to an MPI implementation:
- *jll binaries* (preferred). A jll binary is a package that is built
  via [BinaryBuilder](https://docs.binarybuilder.org/stable/) and can
  be downloaded for all architectures. Almost all external libraries
  (such as CUDA, HDF5, libpng, OpenSSL, ...) are provided as jll
  binaries because they are quick and easy to download and work out of
  the box.
- *system binaries* (for experts only). A system binary is a shared
  library that you need to configure and build yourself. This is
  tricky even for experts. The problem is not just build the shared
  library, in addition one has to be careful to ensure that the shared
  library is ABI compatible with all other package you are using.
  (More details on this below.)

If you want to use an MPI implementation on your system, then you can
either use it as *system binary* (this is for experts only), or you
can use MPItrampoline as *jll binary*, and point MPItrampoline to the
other MPI library. This is preferred since it automatically ensures
ABI compatibility.

The MPIPreferences.jl package allows the user to choose which MPI implementation to use in MPI.jl. It uses
[Preferences.jl](https://github.com/JuliaPackaging/Preferences.jl) to configure the MPI backend for each
project separately. This provides a single source of truth that can be used for JLL packages (Julia packages
providing C libraries) that link against MPI. It can be installed by

```sh
julia --project -e 'using Pkg; Pkg.add("MPIPreferences")'
```

!!! note
    The way MPI.jl is configured has changed with MPI.jl v0.20.
    See [Migration from MPI.jl v0.19 or earlier](@ref) for more information on
    how to migrate your configuration from earlier MPI.jl versions.



## [Using a jll MPI backend](@id using_jll_mpi)

This is the recommended way to use MPI.jl. By default, MPI.jl will use
`MPICH_jll` as jll MPI backend.

You can select from four different jll MPI binaries:
- [`MPICH_jll`](http://www.mpich.org/)),  the default
- [`OpenMPI_jll`](https://www.open-mpi.org/), an alternative to MPICH
- [`MPItrampoline_jll`](https://github.com/eschnett/MPItrampoline), a
  forwarding MPI implementation that uses another MPI implementation
- [`MicrosoftMPI_jll`](https://docs.microsoft.com/en-us/message-passing-interface/microsoft-mpi)
  for Windows

For example, to switch to OpenMPI, you would first use MPIPreferenes.jl to switch:

```sh
julia> using MPIPreferences

julia> MPIPreferences.use_jll_binary("OpenMPI_jll")
┌ Info: MPIPreferences changed
└   binary = "OpenMPI_jll"
```

Next you need to restart Julia (!) and re-instantiate your packages:

```sh
julia> using Pkg

julia> Pkg.instantiate()
```

This is necessary because other jll packages (e.g. `HDF5_jll`) may
depend on MPI, and a different build of `HDF5_jll` needs to be
installed for ABI compatibility.

To switch back to `MPICH_jll`, repeat the steps above with
`"MPICH_JLL"` as argument to `MPIPreferences.use_jll_binary`. Don't
forget to restart Julia and re-instantiate your packages again.



## [Using MPItrampoline](@id using_mpitrampoline)

MPItrampoline is an easier and safer way to use external MPI
implementations. MPItrampoline defines an ABI for MPI calls (similar
to the way
[`libblastrampoline`](https://github.com/JuliaLinearAlgebra/libblastrampoline)
works for linear algebra), which allows switching between different
MPI backends without recompiling code. Unfortunately this ABI is not
yet standardized (but it might be in [MPI
5](https://www.mpi-forum.org)!), and therefore you have to install a
small wrapper library for every MPI implementation that you want to
use via MPItrampoline.

The general design is:
- There is a pre-installed MPI implementation on your system (e.g.
  supporting CUDA or Slingshot)
- You (or a system administrator) installs
  [`MPIwrapper`](https://github.com/eschnett/MPIwrapper), which
  implements the MPI ABI

On the Julia side, the following happens:
- MPItrampoline provides the regular MPI functionality, internally
  calling out via the MPI ABI to any MPI implementation
- Other packages (ADIOS2, HDF5, or MPI.jl) can always rely on
  MPItrampoline
- At run time (when starting Julia), you choose which MPI
  implementation you use by setting an environment variable


The documentation for
[MPItrampoline](https://github.com/eschnett/MPItrampoline) describes
how to install MPIwrapper. This is possibly as simple as

```sh
cmake -B build -DMPIEXEC_EXECUTABLE=mpiexec -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$HOME/mpiwrapper
cmake --build build
cmake --install build
```

but nothing is ever simple on an HPC system. It might be necessary to
load certain modules, or to specify more cmake MPI configuration
options.

Define an environment variable to select this MPI implemenation:

```sh
export MPITRAMPOLINE_LIB="$HOME/mpiwrapper/lib/libmpiwrapper.so"
```

pointing to the shared library provided by the MPIwrapper you just
built. (If you do not set this environment variable the MPItrampoline
will fall back onto a built-in MPICH. That is, in principle MPI.jl
could switch over to always using `MPItrampoline_jll`!)

Next you switch MPI.jl over to using `MPItrampoline_jll` as jll
binary:

```sh
julia> using MPIPreferences

julia> MPIPreferences.use_jll_binary("MPItrampoline_jll")
┌ Info: MPIPreferences changed
└   binary = "MPItrampoline_jll"
```

and then restart Julia (see above) and re-instantiate your packages:

```sh
julia> using Pkg

julia> Pkg.instantiate()
```

You are ready to test this out:
```sh
julia> using MPI

julia> MPI.Get_library_version()
"MPIwrapper 2.11.0, using MPIABI 2.10.0, wrapping:\nMPICH Version:      4.2.1\nMPICH Release date: Wed Apr 17 15:30:02 CDT 2024\nMPICH ABI:          16:1:4\nMPICH Device:       ch3:nemesis\nMPICH configure:    --build=x86_64-linux-musl --host=x86_64-apple-darwin14 --disable-dependency-tracking --disable-doc --enable-shared=no --enable-static=yes --enable-threads=multiple --with-device=ch3 --prefix=/workspace/destdir/lib/mpich --enable-two-level-namespace\nMPICH CC:           cc -fPIC -DPIC  -fno-common  -O2\nMPICH CXX:          c++ -fPIC -DPIC  -O2\nMPICH F77:          gfortran -fPIC -DPIC  -O2\nMPICH FC:           gfortran -fPIC -DPIC  -O2\nMPICH features:     \n"
```



## [Using a system-provided MPI backend](@id using_system_mpi)

This is an alternative way to using an external MPI implementation
that does not rely on MPItrampoline.

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

2. Create a file called `Project.toml` or `JuliaProject.toml` in a central location (for example `/software/mpi/julia`, or in the same directory as the MPI module file), and add the following contents:

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

   !!! note
       If this variable is _not_ already set, it should be prefixed with a colon to ensure correct
       behavior of the Julia load path (e.g. `JULIA_LOAD_PATH=":/software/mpi/julia"`)

   If using environment modules, this can be achieved with
   ```
   append-path -d {} JULIA_LOAD_PATH :/software/mpi/julia
   ```
   or if using an older version of environment modules
   ```
   if { ![info exists ::env(JULIA_LOAD_PATH)] } {
       append-path JULIA_LOAD_PATH ""
   }
   append-path JULIA_LOAD_PATH /software/mpi/julia
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
`cclibs` preferences. These are determined by parsing `cc --cray-print-opts=all`
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

If these are set, the `_format` key will be set to `"1.1"`.

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
run on a non-GPU enabled node without needing a separate `LocalPreferences.toml`).

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

### Testing GPU-aware buffers
The test suite can target CUDA-aware interface with [`CUDA.CuArray`](https://github.com/JuliaGPU/CUDA.jl)
and the ROCm-aware interface with [`AMDGPU.ROCArray`](https://github.com/JuliaGPU/AMDGPU.jl) upon selecting
the corresponding `test_args` kwarg when calling `Pkg.test`.

Run Pkg.test with `--backend=CUDA` to test CUDA-aware MPI buffers
```
import Pkg; Pkg.test("MPI"; test_args=["--backend=CUDA"])
```
and with `--backend=AMDGPU` to test ROCm-aware MPI buffers
```
import Pkg; Pkg.test("MPI"; test_args=["--backend=AMDGPU"])
```

!!! note
    The `JULIA_MPI_TEST_ARRAYTYPE` environment variable has no effect anymore.

### Environment variables
The test suite can also be modified by the following variables:

- `JULIA_MPI_TEST_NPROCS`: How many ranks to use within the tests
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
