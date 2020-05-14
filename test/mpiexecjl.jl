using Test, Pkg
using MPI

@testset "mpiexecjl" begin
    mktempdir() do dir
        # Install MPI locally, so that we can test the `--project` flag to
        # `mpiexecjl`
        Pkg.activate(dir)
        Pkg.add("MPI")
        # Test installation
        @test_logs (:info, r"Installing") (:info, r"Done") MPI.install_mpiexecjl(; destdir = dir)
        # Test a run of mpiexec
        mpiexecjl = joinpath(dir, "mpiexecjl")
        julia = joinpath(Sys.BINDIR, Base.julia_exename())
        example = joinpath(@__DIR__, "..", "docs", "examples", "01-hello.jl")
        @test success(`$(mpiexecjl) --project=$(dir) $(julia) --startup-file=no -q $(example)`)
        # Test help messages
        for help_flag in ("-h", "--help")
            help_message = read(`$(mpiexecjl) --project=$(dir) --help`, String)
            @test occursin(r"Usage:.*MPIEXEC_ARGUMENTS", help_message)
        end
        # Without arguments, or only with the `--project` option, the wrapper will fail
        @test !success(`$(mpiexecjl) --project=$(dir)`)
        @test !success(`$(mpiexecjl)`)
    end
end
