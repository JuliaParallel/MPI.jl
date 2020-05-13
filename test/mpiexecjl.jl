using Test
using MPI

@testset "mpiexecjl" begin
    mktempdir() do dir
        @test_logs (:info, r"Installing") (:info, r"Done") MPI.install_mpiexecjl(; destdir = dir)
        mpiexecjl = joinpath(dir, "mpiexecjl")
        julia = joinpath(Sys.BINDIR, Base.julia_exename())
        example = joinpath(@__DIR__, "..", "docs", "examples", "01-hello.jl")
        @test success(`$(mpiexecjl) $(julia) --startup-file=no -q $(example)`)
    end
end
