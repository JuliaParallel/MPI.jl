using Test, MPI

using MPIPreferences

# load test packages to trigger precompilation
using DoubleFloats
if get(ENV, "JULIA_MPI_TEST_ARRAYTYPE", "") == "CuArray"
    import CUDA
    CUDA.version()
    CUDA.precompile_runtime()
    ArrayType = CUDA.CuArray
elseif get(ENV,"JULIA_MPI_TEST_ARRAYTYPE","") == "ROCArray"
    import AMDGPU
    AMDGPU.versioninfo()
    # DEBUG: currently no `precompile_runtime()` functionnality is implemented in AMDGPU.jl. If needed, it could be added by analogy of CUDA; no use of caps in AMDGPU.jl, but https://github.com/JuliaGPU/AMDGPU.jl/blob/cfaade146977594bf18e14b285ee3a9c84fbc7f2/src/execution.jl#L351-L357 shows how to construct a CompilerJob for a given agent.
    ArrayType = AMDGPU.ROCArray
else
    ArrayType = Array
end

nprocs_str = get(ENV, "JULIA_MPI_TEST_NPROCS", "")
nprocs = nprocs_str == "" ? clamp(Sys.CPU_THREADS, 2, 4) : parse(Int, nprocs_str)

@info "Running MPI tests" ArrayType nprocs MPIPreferences.abi MPIPreferences.binary

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

testdir = @__DIR__
istest(f) = endswith(f, ".jl") && startswith(f, "test_")
testfiles = sort(filter(istest, readdir(testdir)))

@testset "$f" for f in testfiles
    mpiexec() do mpirun
        cmd(n=nprocs) = `$mpirun -n $n $(Base.julia_cmd()) $(joinpath(testdir, f))`
        if f == "test_spawn.jl"
            # Some command as the others, but always use a single process
            run(cmd(1))
        elseif f == "test_threads.jl"
            withenv("JULIA_NUM_THREADS" => "4") do
                run(cmd())
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
end
