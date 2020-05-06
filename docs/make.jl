using Documenter
using MPI

# generate example markdown
EXAMPLES = [
    "Hello world" => "examples/01-hello.md",
    "Broadcast" => "examples/02-broadcast.md",
    "Reduce" => "examples/03-reduce.md",
    "Send/receive" => "examples/04-sendrecv.md",
]

examples_md_dir = joinpath(@__DIR__,"src/examples")
isdir(examples_md_dir) || mkdir(examples_md_dir)

for (example_title, example_md) in EXAMPLES
    example_jl = example_md[1:end-2]*"jl"
    @info "Building $example_md"
    open(joinpath(@__DIR__, "src", example_md), "w") do mdfile
        println(mdfile, "# $example_title")
        println(mdfile)
        println(mdfile, "```julia")
        println(mdfile, "# $example_jl")
        write(mdfile, read(joinpath(@__DIR__,example_jl)))
        println(mdfile, "```")
        println(mdfile)

        println(mdfile, "```")
        println(mdfile, "> mpiexec -n 3 julia $example_jl")
        cd(@__DIR__) do
            write(mdfile, read(`$(MPI.mpiexec_path) -n 3 $(joinpath(Sys.BINDIR, Base.julia_exename())) --project $example_jl`))
        end
        println(mdfile, "```")
    end
end

DocMeta.setdocmeta!(MPI, :DocTestSetup, :(using MPI); recursive=true)

makedocs(
    sitename = "MPI.jl",
    format = Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == "true"
    ),
    modules = [MPI],
    pages = Any[
        "index.md",
        "configuration.md",
        "usage.md",
        "knownissues.md",
        "Examples" => EXAMPLES,
        "Reference" => [
            "library.md",
            "environment.md",
            "comm.md",
            "pointtopoint.md",
            "collective.md",
            "onesided.md",
            "topology.md",
            "io.md",
            "advanced.md",
        ],
        "refindex.md",
    ]
)

deploydocs(
    repo = "github.com/JuliaParallel/MPI.jl.git"
)
