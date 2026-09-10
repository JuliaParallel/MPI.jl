#!/usr/bin/env bash
#
# Regenerate MPI.jl/src/api/generated_api.jl from an MPI implementation's headers.
#
#   ./gen.sh [MPICH_jll|OpenMPI_jll]
#
# Set JULIA to pick the interpreter, e.g. `JULIA="julia +1.10" ./gen.sh`. The pinned
# Clang.jl needs an LLVM that only some Julia versions ship, so `gen/Project.toml`
# constrains which ones work.
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
