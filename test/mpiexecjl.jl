using Test
using MPI

@testset "mpiexecjl" begin
    mktempdir() do dir
        @test_logs (:info, r"Installing") (:info, r"Done") MPI.install_mpiexecjl(; destdir = dir)
        @test success(`$(joinpath(dir, "mpiexecjl")) $(joinpath(Sys.BINDIR, Base.julia_exename())) --startup-file=no -q $(joinpath(@__DIR__, "..", "docs", "examples", "01-hello.jl"))`)
    end
end
