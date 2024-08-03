# MPI.jl

This is a basic [Julia](https://julialang.org/) wrapper for the portable message passing
system Message Passing Interface ([MPI](https://www.mpi-forum.org/)). Inspiration is taken from
[mpi4py](https://mpi4py.readthedocs.io/en/stable/), although we generally follow the C and not the C++ MPI API.
(The C++ MPI API is deprecated.)

If you use MPI.jl in your work, please cite the following paper:

> Simon Byrne, Lucas C. Wilcox, and Valentin Churavy (2021) "MPI.jl: Julia bindings for the Message Passing Interface". _JuliaCon Proceedings_, 1(1), 68, doi: [10.21105/jcon.00068](https://doi.org/10.21105/jcon.00068)
