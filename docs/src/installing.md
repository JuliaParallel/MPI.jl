# Installing

## Unix systems (OSX and Linux)

[CMake](http://www.cmake.org/) is used to piece together the MPI wrapper. Currently a shared
library MPI installation for C and Fortran is required (tested with
[Open MPI](http://www.open-mpi.org/) and [MPICH](http://www.mpich.org/)). To install MPI.jl using the Julia packaging
system, run

```julia
Pkg.update()
Pkg.add("MPI")
```
Alternatively,
```julia
Pkg.clone("https://github.com/JuliaParallel/MPI.jl.git")
Pkg.build()
```
which will build and install the wrapper into `$HOME/.julia/vX.Y/MPI`.

### Platform specific notes:
* If you are trying to build on OSX with Homebrew, the necessary Fortran headers are not included in the OpenMPI bottle.  To workaround this you can build OpenMPI from source: `brew install --build-from-source openmpi`

### Overriding compilers

Currently, MPI.jl relies on CMake for building a few C/Fortran source files needed by the library. Unfortunately, CMake does not follow the `PATH` variable when determining which compiler to use, which could cause problem if the compiler you want to use does not reside in a standard directory like `/usr/bin`. You can override CMake's detection of the compiler by specifying the environment variables `CC`, `CXX`, and `FC` on the command line. The following example forces the compilation process to use the compilers found in the path:

    CC=$(which gcc) CXX=$(which g++) FC=$(which gfortran) julia -e 'Pkg.add("MPI")'

### Overriding the auto-detected MPI version

It may be that CMake selects the wrong MPI version, or that CMake
fails to correctly detect and configure your MPI implementation. You
can override CMake's mechanism by setting certain environment variables:
```sh
JULIA_MPI_C_LIBRARIES
JULIA_MPI_Fortran_INCLUDE_PATH
JULIA_MPI_Fortran_LIBRARIES
```
This will set `MPI_C_LIBRARIES`, `MPI_Fortran_INCLUDE_PATH`, and
`MPI_Fortran_LIBRARIES` when calling CMake as described in its [FindMPI](http://www.cmake.org/cmake/help/v3.3/module/FindMPI.html) module.
You can set these variables either in your shell startup file, or e.g. via your
`~/.juliarc` file. Here is an example:
```Julia
ENV["JULIA_MPI_C_LIBRARIES"] = "-L/opt/local/lib/openmpi-gcc5 -lmpi"
ENV["JULIA_MPI_Fortran_INCLUDE_PATH"] = "-I/opt/local/include"
ENV["JULIA_MPI_Fortran_LIBRARIES"] = "-L/opt/local/lib/openmpi-gcc5 -lmpi_usempif08 -lmpi_mpifh -lmpi"
```

You can set other configuration variables as well (by adding a `JULIA_` prefix);
the full list of variables currently supported is
```sh
MPI_C_COMPILER
MPI_C_COMPILE_FLAGS
MPI_C_INCLUDE_PATH
MPI_C_LINK_FLAGS
MPI_C_LIBRARIES
MPI_Fortran_COMPILER
MPI_Fortran_COMPILE_FLAGS
MPI_Fortran_INCLUDE_PATH
MPI_Fortran_LINK_FLAGS
MPI_Fortran_LIBRARIES
MPI_INCLUDE_PATH
MPI_LIBRARIES
```

## Windows

You need to install the [Microsoft MPI](https://www.microsoft.com/en-us/download/details.aspx?id=49926) runtime on your system (the SDK is not required). Then simply add the MPI.jl package with

```julia
Pkg.update()
Pkg.add("MPI")
```

If you would like to wrap an MPI function on Windows, keep in mind you may need to add its signature to `src/win_mpiconstants.jl`.

