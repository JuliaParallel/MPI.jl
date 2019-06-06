# Setup

## Requirements

### Unix systems (Linux and MacOS)

MPI.jl requires:

- A shared library MPI installation for C (supporting MPI standard 3.0), and
- A C compiler available via the `mpicc` command.

This has been tested with [Open MPI](http://www.open-mpi.org/) and [MPICH](http://www.mpich.org/)).

### Windows

MPI.jl requires the [Microsoft MPI (MS-MPI)](https://docs.microsoft.com/en-us/message-passing-interface/microsoft-mpi) runtime to be installed.

## Installation

The MPI.jl package can be installed via `add MPI` in the [Julia package manager](https://docs.julialang.org/en/v1/stdlib/Pkg/index.html).

If your MPI installation changes (e.g. it is upgraded by the system, or you switch libraries), you will need to re-run `build MPI` at the package prompt.
