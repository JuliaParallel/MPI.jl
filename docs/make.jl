using Documenter
using MPI

makedocs(
    sitename = "MPI.jl",
    format = Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == "true"
    ),
    modules = [MPI],
    pages = Any[
        "index.md",
        "installing.md",
        "usage.md",
        "functions.md",
        ]
)

deploydocs(
    repo = "github.com/JuliaParallel/MPI.jl.git"
)
