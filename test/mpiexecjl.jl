using Test, Pkg
using MPI

function my_julia_cmd(julia=joinpath(Sys.BINDIR, Base.julia_exename()); cpu_target::Union{Nothing,String} = nothing)
    opts = Base.JLOptions()
    if cpu_target === nothing
        cpu_target = unsafe_string(opts.cpu_target)
    end
    image_file = unsafe_string(opts.image_file)
    addflags = String[]
    let compile = if opts.compile_enabled == 0
                      "no"
                  elseif opts.compile_enabled == 2
                      "all"
                  elseif opts.compile_enabled == 3
                      "min"
                  else
                      "" # default = "yes"
                  end
        isempty(compile) || push!(addflags, "--compile=$compile")
    end
    let depwarn = if opts.depwarn == 1
                      "yes"
                  elseif opts.depwarn == 2
                      "error"
                  else
                      "" # default = "no"
                  end
        isempty(depwarn) || push!(addflags, "--depwarn=$depwarn")
    end
    let check_bounds = if opts.check_bounds == 1
                      "yes" # on
                  elseif opts.check_bounds == 2
                      "no" # off
                  else
                      "" # default = "auto"
                  end
        isempty(check_bounds) || push!(addflags, "--check-bounds=$check_bounds")
    end
    opts.can_inline == 0 && push!(addflags, "--inline=no")
    opts.use_compiled_modules == 0 && push!(addflags, "--compiled-modules=no")
    opts.opt_level == 2 || push!(addflags, "-O$(opts.opt_level)")
    opts.opt_level_min == 0 || push!(addflags, "--min-optlevel=$(opts.opt_level_min)")
    push!(addflags, "-g$(opts.debug_level)")
    if opts.code_coverage != 0
        # Forward the code-coverage flag only if applicable (if the filename is pid-dependent)
        coverage_file = (opts.output_code_coverage != C_NULL) ?  unsafe_string(opts.output_code_coverage) : ""
        if isempty(coverage_file) || occursin("%p", coverage_file)
            if opts.code_coverage == 1
                push!(addflags, "--code-coverage=user")
            elseif opts.code_coverage == 2
                push!(addflags, "--code-coverage=all")
            elseif opts.code_coverage == 3
                push!(addflags, "--code-coverage=@$(unsafe_string(opts.tracked_path))")
            end
            isempty(coverage_file) || push!(addflags, "--code-coverage=$coverage_file")
        end
    end
    if opts.malloc_log == 1
        push!(addflags, "--track-allocation=user")
    elseif opts.malloc_log == 2
        push!(addflags, "--track-allocation=all")
    elseif opts.malloc_log == 3
        push!(addflags, "--track-allocation=@$(unsafe_string(opts.tracked_path))")
    end
    if opts.color == 1
        push!(addflags, "--color=yes")
    elseif opts.color == 2
        push!(addflags, "--color=no")
    end
    if opts.startupfile == 2
        push!(addflags, "--startup-file=no")
    end
    if opts.use_sysimage_native_code == 0
        push!(addflags, "--sysimage-native-code=no")
    end
    if opts.use_pkgimages == 0
        push!(addflags, "--pkgimages=no")
    else
        # If pkgimage is set, malloc_log and code_coverage should not
        @assert opts.malloc_log == 0 && opts.code_coverage == 0
    end
    return `$julia -C$cpu_target --sysimage=$image_file $addflags`
end

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
        julia = my_julia_cmd()
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
