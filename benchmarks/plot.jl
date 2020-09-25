using Plots, DelimitedFiles

p = plot(;xlabel="Buffer length", ylabel="Avg time (s)", legend=:bottomright)

for (label, filename, color, linestyle) in [
    ("C MPI", "c.csv", 1, :solid),
    ("MPI.jl", "julia.csv", 3, :solid),
    ("MPI.jl generic", "julia-generic.csv", 3, :dash),
    ("mpi4py", "python.csv", 2, :solid),
    ("mpi4py generic", "python-generic.csv", 2, :dash),
]
        
    D = readdlm(filename, ',')

    plot!(p, D[:,1], D[:,2], xscale=:log10, yscale=:log10, label=label, linecolor=color, linestyle=linestyle)
end

savefig(p, "pingpong.pdf")
