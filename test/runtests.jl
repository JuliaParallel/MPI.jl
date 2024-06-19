using Test, MPI

using MPIPreferences
using Pkg

function parse_flags!(args, flag; default=nothing, typ=typeof(default))
    for f in args
        startswith(f, flag) || continue

        if f != flag
            val = split(f, '=')[2]
            if !(typ ≡ nothing || typ <: AbstractString)
                @show typ val
                val = parse(typ, val)
            end
        else
            val = default
        end

        filter!(x -> x != f, args)
        return true, val
    end
    return false, default
end

_, backend_name = parse_flags!(ARGS, "--backend"; default="CPU", typ=String)

# load test packages to trigger precompilation
using DoubleFloats
@static if backend_name == "CUDA"
    Pkg.add("CUDA")
    ENV["JULIA_MPI_TEST_ARRAYTYPE"] = "CuArray"
    import CUDA
    if isdefined(CUDA, :versioninfo)
        CUDA.versioninfo()
    else
        CUDA.version()
    end
    CUDA.precompile_runtime()
    ArrayType = CUDA.CuArray

    MPI.Init()
    if !MPI.has_cuda()
        @error """
        Your MPI implementation may not support CUDA.
        To force running the tests anyway set the environment
        variable `JULIA_MPI_HAS_CUDA=true`.
        """
        MPI.versioninfo()
        exit(1)
    end
elseif backend_name == "AMDGPU"
    Pkg.add("AMDGPU")
    ENV["JULIA_MPI_TEST_ARRAYTYPE"] = "ROCArray"
    import AMDGPU
    AMDGPU.versioninfo()
    ArrayType = AMDGPU.ROCArray
else
    ArrayType = Array
end

nprocs_str = get(ENV, "JULIA_MPI_TEST_NPROCS", "")
nprocs = nprocs_str == "" ? clamp(Sys.CPU_THREADS, 2, 4) : parse(Int, nprocs_str)

MPI.versioninfo()

if haskey(ENV,"JULIA_MPI_TEST_BINARY")
    @test ENV["JULIA_MPI_TEST_BINARY"] == MPIPreferences.binary
end
if haskey(ENV,"JULIA_MPI_TEST_ABI")
    @test ENV["JULIA_MPI_TEST_ABI"] == MPIPreferences.abi
end

if Sys.isunix()
    # This test doesn't need to be run with mpiexec.  `mpiexecjl` is currently
    # available only on Unix systems
    include("mpiexecjl.jl")
end

excludefiles = split(get(ENV,"JULIA_MPI_TEST_EXCLUDE",""),',')

testdir = @__DIR__
istest(f) = endswith(f, ".jl") && startswith(f, "test_") && !in(f, excludefiles)
testfiles = sort(filter(istest, readdir(testdir)))

@testset "$f" for f in testfiles
    cmd(n=nprocs) = `$(mpiexec()) -n $n $(Base.julia_cmd()) --startup-file=no $(joinpath(testdir, f))`
    if f == "test_spawn.jl"
        # Some command as the others, but always use a single process
        run(cmd(1))
    elseif f == "test_threads.jl"
        # Legacy Intel MPI (before 2020) crashes threads tests:
        # <https://github.com/JuliaParallel/MPI.jl/issues/725>.  These tests fail also on
        # 32-bit Windows: <https://github.com/JuliaParallel/MPI.jl/issues/711>.
        if (MPI.MPI_LIBRARY == "IntelMPI" && MPI.MPI_LIBRARY_VERSION < v"2020") || (Sys.iswindows() && Sys.WORD_SIZE == 32)
            @test_broken false
        else
            withenv("JULIA_NUM_THREADS" => "4") do
                run(cmd())
            end
        end
    elseif f == "test_error.jl"
        r = run(ignorestatus(cmd()))
        @test !success(r)
    elseif f == "test_errorhandler.jl" && MPI.MPI_LIBRARY in ("unknown", "FujitsuMPI")
        # Fujitsu MPI is known to not work with custom error handlers.  Also
        # unknown implementations may fail for the same reason.
        try
            run(cmd())
        catch e
            @error """
                   $(f) tests failed.  This may due to the fact this implementation of MPI doesn't support custom error handlers.
                   See the full error message for more details.  Some messages may have been written above.
                   """ exception=(e, catch_backtrace())
            @test_broken false
        end
    else
        # MPI_Reduce with MPICH 3.4.2 on macOS when root != 0 and
        # when recvbuf == C_NULL segfaults
        # <https://github.com/pmodels/mpich/issues/5700>
        if get(ENV, "JULIA_MPI_TEST_DISABLE_REDUCE_ON_APPLE", "") != "" && Sys.isapple() && f == "test_reduce.jl"
            return
        end
        run(cmd())
    end
    @test true
end
