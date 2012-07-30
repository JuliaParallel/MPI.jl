# MPI interface for the Julia language

This is a basic [Julia] wrapper for the portable message passing system
Message Passing Interface ([MPI]).

## Implementation Issues

For now we will assume that MPI will be running on homogeneous cluster so
that we can use `MPI_BYTE` while sending data.

[Julia]: http://julialang.org/
[MPI]: http://www.mpi-forum.org/
