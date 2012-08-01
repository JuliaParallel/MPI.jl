# MPI interface for the Julia language

This is a basic [Julia] wrapper for the portable message passing system
Message Passing Interface ([MPI]).  Inspiration is taken from [mpi4py].

## Installing

[CMake] is used to piece together the MPI wrapper.  Currently a shared
library MPI installation for C and Fortran is required (tested with
[Open MPI] and [MPICH2]).  To build and install the wrapper run from the
root source directory

    mkdir build
    cd build
    cmake ..
    make
    make test
    make install

which will install the wrapper into `$HOME/.julia/mpi`.  Examples can be
run using the `$HOME/.julia/mpi/juliampi` script as in

    mpirun -np 3 $HOME/.julia/mpi/juliampi ../examples/01-hello.jl

[Julia]: http://julialang.org/
[MPI]: http://www.mpi-forum.org/
[mpi4py]: http://mpi4py.scipy.org
[CMake]: http://www.cmake.org/
[Open MPI]: http://www.open-mpi.org/
