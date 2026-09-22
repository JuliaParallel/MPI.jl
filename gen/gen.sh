#!/usr/bin/env bash
#
# Regenerate ../src/api/generated_api.jl by running Clang.jl over an MPI
# implementation's headers. Run this by hand and commit the result; it is not wired
# into CI.
#
#   cd gen
#   JULIA="julia +1.10" ./gen.sh              # read MPICH's headers (the default)
#   JULIA="julia +1.10" ./gen.sh OpenMPI_jll  # read Open MPI's instead
#
# Julia 1.10, specifically: the pinned Clang.jl needs Clang_jll <= 15, which in turn
# needs the LLVM 15 that only that Julia ships. `juliaup add 1.10` if you have not got
# it. JULIA may carry arguments, so a juliaup channel works as above; leave it unset to
# use whatever `julia` is on PATH. The first run downloads Clang_jll, which is over a
# gigabyte, so expect it to take a while.
#
# Which MPI standard version the bindings cover is decided by the JLL versions that
# gen/Project.toml pins -- MPICH 5.0 is MPI 5.0, Open MPI 5.0 is only MPI 3.1. To move
# to a newer standard, raise the bound there and rerun. Bump the Clang bound on its own,
# in its own commit: Clang.jl drives the formatting of the whole output file, so mixing
# the two makes the diff unreviewable.
#
# Afterwards, read the diff rather than committing it blind. Worth looking for:
#
#   * signature changes to procedures that already existed -- const-correctness or an
#     int -> MPI_Count change in a header silently changes a `ccall` argument type;
#   * procedures whose C return value is not an error code. `@mpichk` would treat one as
#     an errcode and throw on any nonzero result. Those are caught automatically from the
#     `ccall` return type, so a new one shows up as `@mpicall`; a `Cint`-returning
#     procedure that is not error-checked has to go in `mpicall` in src/MPIgenerator.jl;
#   * names that collide with something hand-written in ../src/api/, which is what the
#     ignorelist in src/generator.toml is for.
#
# A new MPI standard version also means refreshing src/versions.jl, which carries the
# minimum version of each procedure and the set that has large-count `MPI_*_c` entry
# points. That has its own script and its own instructions; see versions/README.md.
#
# The braces make the script immune to being edited while it runs.
{
    set -euo pipefail
    cd "$(dirname "$0")"

    binary=${1:-MPICH_jll}

    # Pin which implementation's headers to read, rather than following whatever
    # MPIPreferences the surrounding environment resolves to -- which may not even be one
    # the generator supports. Written directly instead of through
    # `MPIPreferences.use_jll_binary` because `Pkg.instantiate` below already consults
    # this preference (MPICH_jll's platform augmentation reads it at resolve time), so it
    # has to be in place before any Julia code can run.
    cat >LocalPreferences.toml <<TOML
[MPIPreferences]
_format = "1.0"
binary = "$binary"
preloads = []
__clear__ = ["libmpi", "abi", "mpiexec", "cclibs", "preloads_env_switch"]
TOML

    # Allow JULIA to carry arguments, e.g. a juliaup channel.
    read -r -a julia <<<"${JULIA:-julia}"

    # Start from a clean resolution every time. gen/Manifest.toml is not committed, so
    # it is not part of what makes this reproducible -- the compat bounds in
    # gen/Project.toml are -- and a stale one left over from an earlier run would
    # otherwise be reused verbatim and quietly generate against the wrong MPI version.
    rm -f Manifest.toml
    "${julia[@]}" --project=. -e 'using Pkg; Pkg.instantiate()'
    "${julia[@]}" --project=. -e 'import MPIgenerator; MPIgenerator.signatures()'

    exit
}
