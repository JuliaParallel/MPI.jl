# MPI interface for the Julia language

[![Docs latest](https://img.shields.io/badge/docs-latest-blue.svg)](https://juliaparallel.github.io/MPI.jl/latest/)
[![Docs stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://juliaparallel.github.io/MPI.jl/stable/)
[![Unit Tests](https://github.com/JuliaParallel/MPI.jl/actions/workflows/UnitTests.yml/badge.svg)](https://github.com/JuliaParallel/MPI.jl/actions/workflows/UnitTests.yml)
[![GPU tests](https://badge.buildkite.com/ed813bc4d79f557adbdb821b1c8c8de98999686e697df4a373.svg?branch=master)](https://buildkite.com/julialang/mpi-dot-jl)
[![codecov.io](https://codecov.io/github/JuliaParallel/MPI.jl/coverage.svg?branch=master)](https://codecov.io/github/JuliaParallel/MPI.jl?branch=master)
[![Coverage Status](https://coveralls.io/repos/JuliaParallel/MPI.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/JuliaParallel/MPI.jl?branch=master)

This provides [Julia](https://julialang.org/) interface to the Message Passing Interface ([MPI](https://www.mpi-forum.org/)), roughly inspired by [mpi4py](https://github.com/mpi4py/mpi4py/).

Please see the [documentation](https://juliaparallel.github.io/MPI.jl/stable/) for instructions on [configuration](https://juliaparallel.github.io/MPI.jl/stable/configuration/) and [usage](https://juliaparallel.github.io/MPI.jl/stable/usage/).

**Breaking changes with v0.20:** The way how MPI.jl is configured to use
different MPI implementations has changed from v0.19 to v0.20 in a
*non-backward-compatible* manner.
Specifically, most `JULIA_MPI_XXX` variables do not have an effect anymore.
Please refer to the
[docs](https://juliaparallel.org/MPI.jl/stable/configuration/#Migration-from-MPI.jl-v0.19-or-earlier)
for information on how to migrate your existing configuration.

# Help and discussion

For help and discussion, we suggest asking on the following venues:
 - ["Julia at Scale" topic on the Julia Discourse](https://discourse.julialang.org/c/domain/parallel/34)
 - #distributed channel on the [Julia Slack](https://julialang.slack.com/) (visit [https://julialang.org/slack/](https://julialang.org/slack/) to join).

# Contributing

Contributions are encouraged. In particular, MPI provides several hundred functions, only a small number of which are currently exposed. If there are additional functions you would like to use, please open an [issue](https://github.com/JuliaParallel/MPI.jl/issues) or [pull request](https://github.com/JuliaParallel/MPI.jl/pulls).

Additional examples and documentation improvements are also very welcome.

# Citation

If you use MPI.jl in your work, please cite the following paper:

> Simon Byrne, Lucas C. Wilcox, and Valentin Churavy (2021) "MPI.jl: Julia bindings for the Message Passing Interface". _JuliaCon Proceedings_, 1(1), 68, doi: [10.21105/jcon.00068](https://doi.org/10.21105/jcon.00068)
