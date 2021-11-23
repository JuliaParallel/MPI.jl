# MPIconstants

* [![GitHub
  CI](https://github.com/eschnett/MPIconstants/actions/workflows/CI.yml/badge.svg)](https://github.com/eschnett/MPIconstants/actions)

Extract compile-time and load-time constants from and MPI library.
This is useful for libraries or applications that are not written in
C, C++, or Fortran, and want to link against an MPI library as a
binary dependency.

For the compile-time constants (e.g. `MPI_VERSION`), an executable
`generate_compile_time_mpi_constants` is created that outputs their
definitions.

For the load-time constants (e.g. `MPI_COMM_WORLD`), a shared library
`libload_time_mpi_constants.so` is created that defines global
variables holding the respective values.

Example output from `generate_compile_time_mpi_constants`:
```Julia
  const MPI_VERSION_ = Cint(3)
  const MPI_SUBVERSION_ = Cint(1)
```
(This output is actually Julia code.)

Example definition in `libload_time_mpi_constants.so`:
```C
const MPI_Comm MPICONSTANTS_COMM_NULL;
const MPI_Comm MPICONSTANTS_COMM_SELF;
const MPI_Comm MPICONSTANTS_COMM_WORLD;
```
This shared library can be loaded via `dlopen`, and the constants
`MPICONSTANTS_COMM_NULL` etc. can be read to determine the respective
values.

# Using `cmake` to build this library

```sh
rm -rf build $HOME/src/c/MPIstuff/mpiconstants-openmpi
cmake -S . -B build -G Ninja -DMPIEXEC_EXECUTABLE=$(which mpiexec-openmpi-gcc11) -DCMAKE_C_COMPILER=mpicc-openmpi-gcc11 -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$HOME/src/c/MPIstuff/mpiconstants-openmpi
cmake --build build
cmake --install build
```
