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

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
#=deploydocs(
    repo = "<repository url>"
)=#
