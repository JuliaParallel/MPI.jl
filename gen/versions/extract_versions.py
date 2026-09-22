#!/usr/bin/env python3
"""Derive, for every MPI procedure, the MPI standard version that introduced it.

Emits ``gen/src/versions.jl``, which ``gen/src/MPIgenerator.jl`` reads to annotate
each generated wrapper with a minimum MPI version and to decide which wrappers get
a large-count fallback.

Run by hand, not from ``gen.sh``; the output is committed to the repo.  See README.md.

Data sources
------------
* ``pympistandard`` wheels from PyPI.  Each ships one ``apis.json`` extracted from
  the MPI Standard's own build, so the procedure sets are authoritative:
  releases 0.1.0/0.1.1 have the MPI-4.0 dataset, 0.1.2/0.2.0 have the MPI-5.0 one.
  ``apis.json`` also records each parameter's *kind*: a ``POLY*`` kind marks a
  parameter that widens in the large-count ("embiggened") interface, which is how
  we obtain the set of procedures that have an ``MPI_*_c`` variant.
* MPICH headers, to resolve the earlier boundaries not described by ``apis.json``:
  MPICH 3.4.3 is MPI 3.1, MPICH 4.3.2 is MPI 4.1.

Buckets, in order of application:
    <= 3.1  -> no version recorded (MPI.jl requires MPI 3.0 or later anyway),
               except for the hand-curated overrides below
    4.0     -> in the MPI-4.0 dataset but absent from MPICH 3.4.3
    4.1     -> new since the MPI-4.0 dataset and present in MPICH 4.3.2
    5.0     -> new since the MPI-4.0 dataset and absent from MPICH 4.3.2
"""

import json
import re
import sys
import urllib.request
import zipfile
from io import BytesIO
from pathlib import Path

# Procedures whose exact pre-3.1 version matters, because MPI.jl supports
# libraries older than the version that introduced them.  These predate the
# oldest MPICH we can obtain as a JLL, so they cannot be derived.
OVERRIDES = {
    "MPI_Dist_graph_create_adjacent": "2.2",
    "MPI_Dist_graph_neighbors_count": "2.2",
    "MPI_Dist_graph_neighbors": "2.2",
    "MPI_Dist_graph_create": "2.2",
    "MPI_Neighbor_allgatherv": "3.0",
    "MPI_Neighbor_alltoallv": "3.0",
    "MPI_Neighbor_allgather": "3.0",
    "MPI_Neighbor_alltoall": "3.0",
}

PYMPI = "https://pypi.org/pypi/pympistandard/{}/json"
PROTO_RE = re.compile(r"\b(MPI_[A-Za-z0-9_]+)\s*\(")


def apis_json(release):
    """Fetch one pympistandard release's apis.json."""
    meta = json.load(urllib.request.urlopen(PYMPI.format(release)))
    url = next(f["url"] for f in meta["urls"] if f["filename"].endswith(".whl"))
    wheel = zipfile.ZipFile(BytesIO(urllib.request.urlopen(url).read()))
    return json.loads(wheel.read("pympistandard/data/apis.json"))


def vkey(version):
    """Sort key for a "major.minor" version string."""
    return tuple(int(part) for part in version.split("."))


def header_names(*paths):
    """Every MPI_* identifier that looks like a function declaration.

    At least one of `paths` has to exist and yield names. A missing include directory --
    an MPICH_jll artifact garbage-collected out of the depot, say -- would otherwise
    silently contribute nothing, and every procedure in the newer dataset would be
    misclassified as new in that version.
    """
    names = set()
    found = []
    for path in paths:
        if path.exists():
            found.append(path)
            names |= set(PROTO_RE.findall(path.read_text(errors="replace")))
    if not names:
        sys.exit(
            f"no MPI declarations found in {[str(p) for p in paths]}"
            + ("" if found else " (none of these paths exist)")
        )
    return names


def main():
    if len(sys.argv) != 3:
        sys.exit(f"usage: {sys.argv[0]} <MPICH-3.4.x include dir> <MPICH-4.3.x include dir>")
    mpich31, mpich41 = (Path(a) for a in sys.argv[1:3])

    std40 = apis_json("0.1.0")
    std50 = apis_json("0.1.2")

    # Sanity-check that the two datasets are the versions we think they are.
    assert "mpi_abi_get_version" not in std40, "0.1.0 is not the MPI-4.0 dataset"
    assert "mpi_abi_get_version" in std50, "0.1.2 is not the MPI-5.0 dataset"

    names40 = {e["name"] for e in std40.values()}
    names50 = {e["name"] for e in std50.values()}

    in31 = header_names(mpich31 / "mpi.h", mpich31 / "mpio.h")
    in41 = header_names(mpich41 / "mpi.h", mpich41 / "mpi_proto.h", mpich41 / "mpio.h")

    # A POLY* parameter kind marks a procedure that has a large-count variant.
    # Callbacks (MPI_User_function, MPI_Datarep_conversion_function) and predefined
    # functions (MPI_CONVERSION_FN_NULL) also have POLY parameters, but they are
    # typedefs and constants rather than callable entry points, so they must not get a wrapper.
    embiggened = sorted(
        e["name"]
        for e in std50.values()
        if any(p["kind"].startswith("POLY") for p in e["parameters"])
        and not e["attributes"]["callback"]
        and e["attributes"]["predefined_function"] is None
    )

    introduced = {}
    for name in sorted(names50):
        if name in OVERRIDES:
            introduced[name] = OVERRIDES[name]
        elif name in names40:
            if name not in in31:
                introduced[name] = "4.0"
            # else: MPI 3.1 or earlier, left unrecorded
        elif name in in41:
            introduced[name] = "4.1"
        else:
            introduced[name] = "5.0"

    # Large-count entry points arrived with MPI 4.0 -- except where the base
    # procedure itself is newer, e.g. MPI_Comm_attach_buffer_c is MPI 4.1.
    for name in embiggened:
        introduced[name + "_c"] = max("4.0", introduced.get(name, "4.0"), key=vkey)

    out = Path(__file__).resolve().parent.parent / "src" / "versions.jl"
    with out.open("w") as f:
        f.write("# WARNING: auto-generated by MPI.jl/gen/versions/extract_versions.py,\n")
        f.write("# please edit that script instead!\n")
        f.write("#\n")
        f.write("# INTRODUCED maps a procedure to the MPI standard version that added it.\n")
        f.write("# Procedures available in MPI 3.1 or earlier are omitted: MPI.jl requires\n")
        f.write("# MPI 3.0 or later, so a version would not be useful.\n")
        f.write("const INTRODUCED = Dict{Symbol,VersionNumber}(\n")
        for name, ver in sorted(introduced.items()):
            f.write(f'    :{name} => v"{ver}",\n')
        f.write(")\n\n")
        f.write("# Procedures with a large-count (\"embiggened\") `MPI_*_c` variant, i.e. those\n")
        f.write("# having at least one polymorphic parameter in the MPI standard's own\n")
        f.write("# machine-readable binding description.\n")
        f.write("const EMBIGGENED = Set{Symbol}([\n")
        for name in embiggened:
            f.write(f"    :{name},\n")
        f.write("])\n")

    print(f"wrote {out}")
    print(f"  {len(introduced)} versioned procedures, {len(embiggened)} embiggened")
    for ver in ("2.2", "3.0", "4.0", "4.1", "5.0"):
        n = sum(1 for v in introduced.values() if v == ver)
        print(f"    {ver}: {n}")


if __name__ == "__main__":
    main()
