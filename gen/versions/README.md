# Where `gen/src/versions.jl` comes from

`extract_versions.py` derives two tables that `gen/src/MPIgenerator.jl` needs but
cannot read out of a C header:

* **`INTRODUCED`** — the MPI standard version that added each procedure. The
  generator appends it to the `@mpichk` call, so that a procedure missing from the
  MPI library in use raises a `FeatureLevelError` describing the version it needs
  rather than failing to resolve a symbol.
* **`EMBIGGENED`** — the procedures that have a large-count (MPI-4.0
  "embiggened") `MPI_*_c` entry point. The generator gives each of those a
  fallback to the narrow entry point, so the high-level layer can call
  `MPI_Foo_c` unconditionally.

Run the script manually, and commit the result to the repo. This is not part of
`gen.sh` because it reaches out to the network and its result only changes when
a new MPI standard version is released.

```sh
cd gen/versions
python3 extract_versions.py <MPICH-3.4.x include dir> <MPICH-4.3.x include dir>
```

You can get the two include directories from any Julia with the matching `MPICH_jll`
installed, e.g.

```sh
julia -e 'using Pkg; Pkg.activate(mktempdir()); Pkg.add(PackageSpec(name="MPICH_jll", version=v"3.4.3+1")); using MPICH_jll; println(joinpath(MPICH_jll.artifact_dir, "include"))'
```

## Information sources used by the script

Everything the script reads is public:

* **`pympistandard` wheels from PyPI.** Each release ships one `apis.json`
  extracted from the MPI Standard's own build, so its procedure set is
  authoritative. Releases 0.1.0/0.1.1 have the MPI-4.0 dataset (515 procedures),
  0.1.2/0.2.0 the MPI-5.0 one (567). `apis.json` also gives every parameter's
  *kind*: a `POLY*` kind is the standard's marker for a parameter that
  widens in the large-count interface, which is where `EMBIGGENED` comes from.
* **MPICH headers** for the two earlier boundaries which `apis.json` does not resolve,
  since only two datasets are published: MPICH 3.4.3 is MPI 3.1, MPICH 4.3.2 is MPI 4.1.

`pympistandard` looks like it ought to answer the version question directly, but
it does not: `Procedure.introduced()` exists in `src/pympistandard/procedure.py`
but is commented out. The MPI standard's own change log
(`mpi-forum/mpi-standard`, `chap-changes/changes.tex`) is not usable either — the
`\mpifunc{}` names inside a per-version section are *mentions*, not additions, so
the 4.0-to-4.1 section lists 65 names including `MPI_COMM_DUP` and `MPI_CART_GET`.

## Procedures available in MPI 3.1 or earlier are omitted

MPI.jl requires MPI 3.0 or later, so recording "needs MPI 1.0" for `MPI_Send`
would not be useful, and the oldest MPICH available as a JLL is 3.3.2.
It would be difficult to split 1.0/2.0/2.1/2.2/3.0/3.1 apart.
Anything present in MPICH 3.4.3 therefore gets no entry, and `@mpichk` reports
such a procedure as simply unavailable in the library in use.

The exception is `OVERRIDES` in the script. The eight MPI-2.2 and MPI-3.0
procedures which MPI.jl has always version-gated by hand, because it actually does
support libraries older than those. `test/test_neighbor_*.jl` checks
`e.min_version <= MPI.Get_version()` on them, so they need real version numbers.

## Cross-check against the standard sources

The classification was verified against the `mpi-forum/mpi-standard` repository,
whose per-version tags (`mpi-4.0`, `mpi-4.1`, `mpi-5.0`) have the authoritative
bindings as `function_name("MPI_Foo")` entries inside `\begin{mpi-binding}`
blocks in `chap-*/*.tex`. That repository is private to MPI Forum members, which
is why the script does not depend on it. Extracting and diffing those name sets
gives 470 procedures at 4.0, 494 at 4.1 and 500 at 5.0, with nothing removed
between versions, and:

* the 24 procedures new in 4.1 match the script's 4.1 classification exactly,
  `MPI_Get_hw_resource_info` included — MPICH 4.3 does not run ahead of the
  standard here;
* the 6 procedures new in 5.0 are the `MPI_Abi_*` family. The script also
  classifies the 22 `MPI_<handle>_toint`/`_fromint` functions as 5.0, which the
  `function_name` sweep misses because they are declared in the ABI chapter
  (`mpi-5.0/chap-abi/abi.tex`) rather than as ordinary bindings. 5.0 is correct
  for them: they are absent from the 4.1 tag entirely.

For a member of the MPI Forum, the diff is reproducible with

```sh
gh api repos/mpi-forum/mpi-standard/tarball/mpi-4.1 | tar xz
grep -rhoE 'function_name\("MPI_[A-Za-z0-9_]+"\)' */chap-*/*.tex | sed 's/.*"\(.*\)".*/\1/' | sort -u
```
