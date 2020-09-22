---
title: 'MPI.jl: Julia bindings for the Message Passing Interface'
tags:
  - Julia
  - MPI
  - distributed computing
authors:
  - name: Simon Byrne
    orcid: 0000-0001-8048-6810
    affiliation: 1
  - name: Lucas Wilcox
    affiliation: 2
  - name: Valentin Churavy
    affiliation: 3
affiliations:
 - name: California Institute of Technology
   index: 1
 - name: Naval Postgraduate School
   index: 2
 - name: Massachusetts Institute of Technology
   index: 3
date: 21 September 2020
bibliography: paper.bib

---


# Summary

MPI.jl provides Julia bindings to the Message Passing Interface (MPI). 

# Statement of Need

# Basic introduction and running programs

How to use `mpiexec` function


# Implementation details and challenges
## Allocation, serialization and error handling

The C and Fortran interfaces require that users allocate memory buffers for output, and receive 

- Use Julia error handling instead of manual checking of error codes
- For functions which receive output, adopt Julia convention of suffixing functions which mutate their arguments with `!` (e.g. `MPI.Recv!`)
- Use convention from mpi4py of using lowercase for functions which are able to handle arbirary data. These are typically slower as they rely on serialization and are not type-stable, but can be convenient for communicating objects of unknown length (e.g. broadcasting file paths at initialization).

## Buffers and datatypes

MPI communication functions require three arguments (address, count and element datatype,) to specify their input and/or output buffers e.g. the `MPI_Send` signature in C has six arguments:
```C
int MPI_Send(const void* buf, int count, MPI_Datatype datatype, int dest,
             int tag, MPI_Comm comm)
```

In Julia, these can all be determined from an `Array` object, so the corresponding function in MPI.jl only requires 4 arguments:
```julia
MPI.Send(buf, dest::Integer, tag::Integer, comm::Comm)
```

An intermediate `Buffer` type is defined that captures the necessary properties,
and allows defining MPI communication operations for other Julia objects without
requiring that additional methods for every communication function. For example, to
support the CUDA-aware MPI interface across all MPI functions, we only need to
define a `Buffer(arr::CUDA.CuArray)` method.

If the element type of the buffer is not one of the predefined MPI datatypes,
then MPI.jl will automatically build and commit the corresponding MPI
user-defined type. 


Similarly, for collective reduction operations (`MPI.Reduce`, `MPI.Scan`, etc.),
MPI.jl will convert Julia functions to MPI operator objects, either mapping to
predefined operators (e.g. `+` to `MPI.SUM`), or wrapping functions to form
custom operators.

The following example uses both custom datatypes and custom reduction operators
to compute the pooled variance of a distributed dataset in a numerically stable
way, using a single communication operation:
```julia
# Custom struct containing the summary statistics (mean, variance, count)
struct SummaryStat
    mean::Float64
    var::Float64
    n::Float64
end

function SummaryStat(X::AbstractArray)
    m = mean(X)
    v = varm(X,m, corrected=false)
    n = length(X)
    SummaryStat(m,v,n)
end

# Custom reduction operator, computing pooled mean, variance and length
function pool(S1::SummaryStat, S2::SummaryStat)
    n = S1.n + S2.n
    m = (S1.mean*S1.n + S2.mean*S2.n) / n
    v = (S1.n * (S1.var + S1.mean * (S1.mean-m)) +
         S2.n * (S2.var + S2.mean * (S2.mean-m)))/n
    SummaryStat(m,v,n)
end

# Perform a scalar reduction to `root`
summ = MPI.Reduce(SummaryStat(X), pool, root, comm)
```


## Application binary interface

The MPI standard specifies C and Fortran appilication programming interfaces (API), but not an application binary interface (ABI). Consequently, datatypes and enum values vary between different implementations, and require parsing C headers to extract their precise values. We use two approaches to work around this problem:

- Attempt to identify the MPI implementation by querying `MPI_Get_library_version`, and use pre-defined constants if known to be compatible with MPICH, Open MPI or Microsoft MPI.

- Otherwise, at build time it compiles a small C program that outputs the type sizes and constants. One complication is that the opaque C handles might only be defined at link time: in this case, we convert to the Fortran handle values (which are required to be integers), and convert back to C handles when calling `MPI.Init()`. A similar approach is used by `rsmpi` (MPI bindings for Rust).

## Binary support

Similar to many Julia packages, MPI.jl uses BinaryBuilder and the Artifacts system to automatically install an MPI implementation when installing the package (currently Microsoft MPI on Windows, MPICH on other platforms), which considerably simplifies the installation procedure for users on their own computers.

However on high-performance computing systems one would typically want to use system or other externally-provided binaries. To aid this, we provide additional hooks to enable switching this at build time via environment variables, and a warning is show if a user appears to be using the default MPI binary on a HPC system. Challenges remain on how to make it easier to switch implementations (when multiple are present), or how to deal with binaries which depend on MPI.

# Examples
## Pseudo-code

Julia syntax is close to pseudo-code found in the literature to describe
parallel algorithms. For example, consider the minimum-spanning tree algorithm
of Chan et al. (Figure 3a of @chan2007collective). A Julia implementation is
given as:
```julia
function MSTBcast(x, root, left, right, comm)
    me = MPI.Comm_rank(comm)
    tag = 999

    if left == right
        return x
    end
    mid = (left + right) ÷ 2
    dest = root ≤ mid ? right : left

    if me == root
        MPI.send(x, dest, tag, comm)
    end
    if me == dest
        (x, _) = MPI.recv(root, tag, comm)
    end

    if me ≤ mid && root ≤ mid
        MSTBcast(x, root, left, mid, comm)
    elseif me ≤ mid && root > mid
        MSTBcast(x, dest, left, mid, comm)
    elseif me > mid && root ≤ mid
        MSTBcast(x, dest, mid + 1, right, comm)
    elseif me > mid && root > mid
        MSTBcast(x, root, mid + 1, right, comm)
    end
end
```

This is a nearly identical to the pseudo-code and can be called for all of the
datatypes supported by `MPI.Send` and `MPI.Recv`, for example arrays,
functions, and dictionaries:
```julia
using MPI
using Random
using Test

MPI.Init()

comm = MPI.COMM_WORLD
Random.seed!(17)
matsize = (17,17)

for T in (Float64, Float32, Int8)
    A = ArrayType(rand(T, matsize))
    B = MPI.Comm_rank(comm) == root ? A : nothing
    B = MSTBcast(B, root, 0, MPI.Comm_size(comm) - 1, comm)
    @test B == A
end

g = x -> x^2 + 2x - 1
f = MPI.Comm_rank(comm) == root ? g : nothing
f = MSTBcast(f, root, 0, MPI.Comm_size(comm) - 1, comm)
@test f(3) == g(3)
@test f(5) == g(5)
@test f(7) == g(7)

A = Dict("foo" => "bar")
B = MPI.Comm_rank(comm) == root ? A : nothing
B = MSTBcast(B, root, 0, MPI.Comm_size(comm) - 1, comm)
@test B["foo"] == "bar"

MPI.Finalize()
```

## Ping pong benchmark


# Acknowledgements


# References