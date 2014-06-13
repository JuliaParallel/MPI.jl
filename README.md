# MPI interface for the Julia language

This is a basic [Julia] wrapper for the portable message passing system
Message Passing Interface ([MPI]).  Inspiration is taken from [mpi4py].

## Installing

[CMake] is used to piece together the MPI wrapper; as such, it is required 
MPI.jl to build.  Currently a shared library MPI installation for C and 
Fortran is required (tested with [Open MPI] and [MPICH2]). To install MPI.jl
using the Julia packaging system, simply run

    julia> Pkg.update()
    julia> Pkg.add("MPI")

Alternatively, clone this git repository manually and run

    julia> Pkg.build("MPI")

which will install the MPI library into `$HOME/.julia/vX.Y/MPI/deps/usr/lib`. 

## Usage

To run a Julia script with MPI, first make sure that `using MPI` or 
`import MPI` is included at the top of your script. You should then be able
to run the MPI job as expected, e.g. with

    mpirun -np 3 julia examples/01-hello.jl

[Julia]: http://julialang.org/
[MPI]: http://www.mpi-forum.org/
[mpi4py]: http://mpi4py.scipy.org
[CMake]: http://www.cmake.org/
[Open MPI]: http://www.open-mpi.org/
[MPICH2]: http://www.mcs.anl.gov/research/projects/mpich2/
