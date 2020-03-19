# Installation

## Requirements

MPI.jl requires a shared library installation of a C MPI library, supporting the MPI 3.0 standard or later.

## Building

The MPI.jl package can be installed via `add MPI` in the [Julia package
manager](https://docs.julialang.org/en/v1/stdlib/Pkg/index.html). The package will attempt
to find and identify the MPI installation.

The MPI standard doesn't specify the exact application binary interface (ABI), but the
following implementations should work directly:

- [Open MPI](http://www.open-mpi.org/)
- [MPICH](http://www.mpich.org/) (v3.1 or later)
- [Intel MPI](https://software.intel.com/en-us/mpi-library)
- [Microsoft MPI](https://docs.microsoft.com/en-us/message-passing-interface/microsoft-mpi)
- [IBM Spectrum MPI](https://www.ibm.com/us-en/marketplace/spectrum-mpi)

For other implementations, the build script will attempt to build a small C program to
determine the appropriate type definitions and constants. This requires a compatible C
compiler (`mpicc` by default).

## Environment variables

The following optional environment variables can be used to control certain aspects of the
build script and other library behaviour:

- `JULIA_MPI_ABI`: the application binary interface, a string matching an [`MPIABI`](@ref) value.
- `JULIA_MPI_PATH`: the top-level installation directory of MPI.
- `JULIA_MPI_LIBRARY`: the path of the MPI shared library.
- `JULIA_MPI_LIBRARY_PATH`: the directory containing the MPI library files.
- `JULIA_MPI_INCLUDE_PATH`: the directory containing the MPI header files.
- `JULIA_MPI_CFLAGS`: C flags passed to the constant generation build (default: `-lmpi`)
- `JULIA_MPICC`: MPI C compiler (default: `mpicc`)
- `JULIA_MPIEXEC`: MPI launcher command (default: `mpiexec`)
- `JULIA_MPIEXEC_ARGS`: Additional arguments to be passed to MPI launcher.
- `JULIA_MPI_HAS_CUDA`: override the [`MPI.has_cuda`](@ref) function.
