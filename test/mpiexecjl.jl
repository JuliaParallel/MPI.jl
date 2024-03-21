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
        mpiexecjl = if Sys.isunix()
            joinpath(dir, "mpiexecjl")
        elseif Sys.iswindows()
            joinpath(dir, "mpiexecjl.ps1")
        else
            error("Unsupported platform: $(Sys.KERNEL)")
        end

        additional_initial_parts_cmd = if Sys.isunix()
            String[]
        else
            String["powershell.exe", "-ExecutionPolicy", "Bypass", "-File"]
        end

        # `Base.julia_cmd()` ensures keeping consistent flags when running subprocesses.
        julia = Base.julia_cmd()
        example = joinpath(@__DIR__, "..", "docs", "examples", "01-hello.jl")
        env = ["JULIA_BINDIR" => Sys.BINDIR]
        p = withenv(env...) do
            run(`$(additional_initial_parts_cmd) $(mpiexecjl) -n $(nprocs) --project=$(dir) $(julia) --startup-file=no -q $(example)`)
        end
        @test success(p)
        # Test help messages
        for help_flag in ("-h", "--help")
            help_message = withenv(env...) do
                read(`$(additional_initial_parts_cmd) $(mpiexecjl) --project=$(dir) $help_flag`, String)
            end
            @test occursin(r"Usage:.*MPIEXEC_ARGUMENTS", help_message)
        end
        # Without arguments, or only with the `--project` option, the wrapper will fail
        @test !withenv(() -> success(`$(additional_initial_parts_cmd) $(mpiexecjl) --project=$(dir)`), env...)
        @test !withenv(() -> success(`$(additional_initial_parts_cmd) $(mpiexecjl)`), env...)
    end
end
