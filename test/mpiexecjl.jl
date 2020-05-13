using Test, Pkg
using MPI

@testset "mpiexecjl" begin
    mktempdir() do dir
        # Install MPI locally, so that we can test the `--project` flag to
        # `mpiexecjl`
        Pkg.activate(dir)
        Pkg.add("MPI")
        @test_logs (:info, r"Installing") (:info, r"Done") MPI.install_mpiexecjl(; destdir = dir)
        mpiexecjl = joinpath(dir, "mpiexecjl")
        julia = joinpath(Sys.BINDIR, Base.julia_exename())
        example = joinpath(@__DIR__, "..", "docs", "examples", "01-hello.jl")
        @test success(`$(mpiexecjl) --project=$(dir) $(julia) --startup-file=no -q $(example)`)
    end
end
