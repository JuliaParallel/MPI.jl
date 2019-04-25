# MPI interface for the Julia language

[![Docs latest](https://img.shields.io/badge/docs-latest-blue.svg)](https://juliaparallel.github.io/MPI.jl/latest/)
[![Build Status](https://travis-ci.org/JuliaParallel/MPI.jl.svg?branch=master)](https://travis-ci.org/JuliaParallel/MPI.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/e8mr8rx8sjryyba6/branch/master?svg=true)](https://ci.appveyor.com/project/eschnett/mpi-jl/branch/master)
[![codecov.io](https://codecov.io/github/JuliaParallel/MPI.jl/coverage.svg?branch=master)](https://codecov.io/github/JuliaParallel/MPI.jl?branch=master)
[![Coverage Status](https://coveralls.io/repos/JuliaParallel/MPI.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/JuliaParallel/MPI.jl?branch=master)

This is a basic [Julia] wrapper for the portable message passing
system Message Passing Interface ([MPI]). Inspiration is taken from
mpi4py, although we generally follow the C and not the C++ MPI API.
(The C++ MPI API is deprecated.)

[Julia]: http://julialang.org/
[MPI]: http://www.mpi-forum.org/
[mpi4py]: http://mpi4py.scipy.org
