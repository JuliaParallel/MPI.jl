using Documenter
using MPI
using MPIPreferences

# generate example markdown
EXAMPLES = [
    "Hello world" => "examples/01-hello.md",
    "Broadcast" => "examples/02-broadcast.md",
    "Reduce" => "examples/03-reduce.md",
    "Send/receive" => "examples/04-sendrecv.md",
    "Job Scheduling" => "examples/05-job_schedule.md",
    "Scatterv and Gatherv" => "examples/06-scatterv.md",
    "Active RMA" => "examples/07-rma_active.md",
    "Passive RMA" => "examples/08-rma_passive.md",
    "Graph Communication" => "examples/09-graph_communication.md",
]

examples_md_dir = joinpath(@__DIR__,"src/examples")
isdir(examples_md_dir) || mkdir(examples_md_dir)

for (example_title, example_md) in EXAMPLES
    example_jl = example_md[1:end-2]*"jl"
    @info "Building $example_md"
    open(joinpath(@__DIR__, "src", example_md), "w") do mdfile
        println(mdfile, """
            ```@meta
            EditURL = "https://github.com/JuliaParallel/MPI.jl/blob/master/docs/$(example_jl)"
            ```
            """
        )
        println(mdfile, "# $example_title")
        println(mdfile)
        println(mdfile, "```julia")
        println(mdfile, "# $example_jl")
        println(mdfile, readchomp(joinpath(@__DIR__,example_jl)))
        println(mdfile, "```")
        println(mdfile)

        println(mdfile, "```")
        println(mdfile, "> mpiexecjl -n 4 julia $example_jl")
        cd(@__DIR__) do
            write(mdfile, mpiexec(cmd -> read(`$cmd -n 4 $(Base.julia_cmd()) --project $example_jl`)))
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
    modules = [MPI, MPIPreferences],
    pages = Any[
        "index.md",
        "configuration.md",
        "usage.md",
        "knownissues.md",
        "Examples" => EXAMPLES,
        "Reference" => [
            "reference/mpipreferences.md",
            "reference/library.md",
            "reference/environment.md",
            "reference/comm.md",
            "reference/buffers.md",
            "reference/pointtopoint.md",
            "reference/collective.md",
            "reference/onesided.md",
            "reference/topology.md",
            "reference/io.md",
            "reference/advanced.md",
        ],
        "refindex.md",
    ],
    strict = true,
)

deploydocs(
    repo = "github.com/JuliaParallel/MPI.jl.git",
    push_preview = true,
)
