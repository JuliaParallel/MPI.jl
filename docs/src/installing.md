# Setup

## Requirements

### Unix systems (Linux and MacOS)

MPI.jl requires:

- A shared library MPI installation for C (supporting MPI standard 3.0), and
- A C compiler available via the `mpicc` command: this is required as part of the build
  process to determine the necessary type definitions and constants.

This has been tested with [Open MPI](http://www.open-mpi.org/) and [MPICH](http://www.mpich.org/)).

### Windows

MPI.jl requires the [Microsoft MPI (MS-MPI)](https://docs.microsoft.com/en-us/message-passing-interface/microsoft-mpi) runtime to be installed.

## Installation

The MPI.jl package can be installed via `add MPI` in the [Julia package manager](https://docs.julialang.org/en/v1/stdlib/Pkg/index.html). 

The build script will attempt to find the shared library and constants: this can be
controlled with the optional environment variables:

- `JULIA_MPI_PATH`: the top-level installation directory of MPI.
- `JULIA_MPI_LIBRARY_PATH`: the directory containing the MPI library files.
- `JULIA_MPI_INCLUDE_PATH`: the directory containing the MPI header files.
- `JULIA_MPI_CFlAGS`: C flags passed to the constant generation build (default: `-lmpi`)
- `JULIA_MPICC`: MPI C compiler (default: `mpicc`)

If your MPI installation changes (e.g. it is upgraded by the system, or you switch
libraries), you will need to re-run `build MPI` at the package prompt.
