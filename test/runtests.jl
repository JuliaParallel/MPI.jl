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

if Sys.isunix()
    # This test doesn't need to be run with mpiexec.  `mpiexecjl` is currently
    # available only on Unix systems
    include("mpiexecjl.jl")
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

testdir = @__DIR__
istest(f) = endswith(f, ".jl") && startswith(f, "test_")
testfiles = sort(filter(istest, readdir(testdir)))

@testset "$f" for f in testfiles
    mpiexec() do cmd
        if f == "test_spawn.jl"
            run(`$cmd -n 1 $(Base.julia_cmd()) $(joinpath(testdir, f))`)
        elseif f == "test_threads.jl"
            withenv("JULIA_NUM_THREADS" => "4") do
                run(`$cmd -n $nprocs $(Base.julia_cmd()) $(joinpath(testdir, f))`)
            end
        elseif f == "test_error.jl"
            r = run(ignorestatus(`$cmd -n $nprocs $(Base.julia_cmd()) $(joinpath(testdir, f))`))
            @test !success(r)
        else
            # MPI_Reduce with MPICH 3.4.2 on macOS when root != 0 and
            # when recvbuf == C_NULL segfaults
            # <https://github.com/pmodels/mpich/issues/5700>
            if get(ENV, "JULIA_MPI_TEST_DISABLE_REDUCE_ON_APPLE", "") != "" && Sys.isapple() && f == "test_reduce.jl"
                return
            end
            run(`$cmd -n $nprocs $(Base.julia_cmd()) $(joinpath(testdir, f))`)
        end
        @test true
    end
end
