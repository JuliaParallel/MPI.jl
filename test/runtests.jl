using Test, MPI

using MPIPreferences

# load test packages to trigger precompilation
using DoubleFloats
if get(ENV, "JULIA_MPI_TEST_ARRAYTYPE", "") == "CuArray"
    import CUDA
    CUDA.version()
    CUDA.precompile_runtime()
    ArrayType = CUDA.CuArray
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
        cmd = `$mpirun -n $nprocs $(Base.julia_cmd()) $(joinpath(testdir, f))`
        if f == "test_spawn.jl"
            # Some command as the others, but always use a single process
            _cmd = deepcopy(cmd)
            _cmd.exec[findfirst(==("$nprocs"), _cmd.exec)] = "1"
            run(_cmd)
        elseif f == "test_threads.jl"
            withenv("JULIA_NUM_THREADS" => "4") do
                run(cmd)
            end
        elseif f == "test_error.jl"
            r = run(ignorestatus(cmd))
            @test !success(r)
        elseif f == "test_errorhandler.jl" && MPI.identify_implementation()[1] == MPI.UnknownMPI
            try
                run(cmd)
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
            run(cmd)
        end
        @test true
    end
end
