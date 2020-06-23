using Test, MPI

# load test packages to trigger precompilation
using DoubleFloats
if get(ENV,"JULIA_MPI_TEST_ARRAYTYPE","") == "CuArray"
    import CUDA
    ArrayType = CUDA.CuArray
else
    ArrayType = Array
end

if Sys.isunix()
    # This test doesn't need to be run with mpiexec.  `mpiexecjl` is currently
    # available only on Unix systems
    include("mpiexecjl.jl")
end

mpiexec_args = Base.shell_split(get(ENV, "JULIA_MPIEXEC_TEST_ARGS", ""))

nprocs_str = get(ENV, "JULIA_MPI_TEST_NPROCS","")
nprocs = nprocs_str == "" ? clamp(Sys.CPU_THREADS, 2, 4) : parse(Int, nprocs_str)
testdir = @__DIR__
istest(f) = endswith(f, ".jl") && startswith(f, "test_")
testfiles = sort(filter(istest, readdir(testdir)))

@info "Running MPI tests" ArrayType nprocs mpiexec_args

@testset "$f" for f in testfiles
    mpiexec() do cmd
        cmd = `$cmd $mpiexec_args`
        if f == "test_spawn.jl"
            run(`$cmd -n 1 $(Base.julia_cmd()) $(joinpath(testdir, f))`)
        elseif f == "test_threads.jl"
            withenv("JULIA_NUM_THREAD" => "4") do
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
