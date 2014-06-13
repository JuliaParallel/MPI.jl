# MPI interface for the Julia language

This is a basic [Julia] wrapper for the portable message passing system
Message Passing Interface ([MPI]).  Inspiration is taken from [mpi4py].

## Installing

[CMake] is used to piece together the MPI wrapper.  Currently a shared
library MPI installation for C and Fortran is required (tested with
[Open MPI] and [MPICH]).  This package can be installed using the Julia package
system

```julia
Pkg.init()
Pkg.clone("https://github.com/lcw/MPI.jl.git")
Pkg.build()
```

which will build and install the wrapper into `$HOME/.julia`.  Examples can be
run with like this

    mpirun -np 3 julia 01-hello.jl

[Julia]: http://julialang.org/
[MPI]: http://www.mpi-forum.org/
[mpi4py]: http://mpi4py.scipy.org
[CMake]: http://www.cmake.org/
[Open MPI]: http://www.open-mpi.org/
[MPICH]: http://www.mpich.org/
