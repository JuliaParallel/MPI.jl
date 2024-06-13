using Test, Pkg
using MPI

@testset "mpiexecjl" begin
    mktempdir() do dir
        # Install MPI locally, so that we can test the `--project` flag to
        # `mpiexecjl`
        Pkg.activate(dir; io=devnull)
        Pkg.develop(PackageSpec(path=joinpath(@__DIR__, "..")); io=devnull)
        # Precompile in advance to avoid race conditions when running multiple Julia
        # processes in parallel.
        Pkg.precompile(; io=devnull)
        # Test installation
        @test_logs (:info, r"Installing") (:info, r"Done") MPI.install_mpiexecjl(; destdir = dir)
        # Test a run of mpiexec
        nprocs_str = get(ENV, "JULIA_MPI_TEST_NPROCS", "")
        nprocs = nprocs_str == "" ? clamp(Sys.CPU_THREADS, 2, 4) : parse(Int, nprocs_str)
        mpiexecjl = joinpath(dir, "mpiexecjl")
        # `Base.julia_cmd()` ensures keeping consistent flags when running subprocesses.
        julia = Base.julia_cmd()
        example = joinpath(@__DIR__, "..", "docs", "examples", "01-hello.jl")
        env = ["JULIA_BINDIR" => Sys.BINDIR]
        p = withenv(env...) do
            run(`$(mpiexecjl) -n $(nprocs) --project=$(dir) $(julia) --startup-file=no -q $(example)`)
        end
        @test success(p)
        # Test help messages
        for help_flag in ("-h", "--help")
            help_message = withenv(env...) do
                read(`$(mpiexecjl) --project=$(dir) --help`, String)
            end
            @test occursin(r"Usage:.*MPIEXEC_ARGUMENTS", help_message)
        end
        # Without arguments, or only with the `--project` option, the wrapper will fail
        @test !withenv(() -> success(`$(mpiexecjl) --project=$(dir)`), env...)
        @test !withenv(() -> success(`$(mpiexecjl)`), env...)
        # Test that the wrapper exits with the same exit code as the MPI process
        exit_code = 10
        p = run(`$(mpiexecjl) -n $(nprocs) --project=$(dir) $(julia) --startup-file=no -e "exit($(exit_code))"`; wait=false)
        wait(p)
        @test p.exitcode == exit_code
    end
end
