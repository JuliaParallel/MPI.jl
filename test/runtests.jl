using Test, MPI

# load test packages to trigger precompilation
using DoubleFloats
if get(ENV,"JULIA_MPI_TEST_ARRAYTYPE","") == "CuArray"
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

nprocs_str = get(ENV, "JULIA_MPI_TEST_NPROCS","")
nprocs = nprocs_str == "" ? clamp(Sys.CPU_THREADS, 2, 4) : parse(Int, nprocs_str)
testdir = @__DIR__
istest(f) = endswith(f, ".jl") && startswith(f, "test_")
testfiles = sort(filter(istest, readdir(testdir)))

@info "Running MPI tests" ArrayType nprocs

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
            run(`$cmd -n $nprocs $(Base.julia_cmd()) $(joinpath(testdir, f))`)
        end
        @test true
    end
end
