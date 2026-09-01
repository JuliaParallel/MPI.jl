using Test, MPIPreferences

if ARGS[1] == "cuda"
    @test only(MPIPreferences.System.preloads) ==  "libmpi_gtl_cuda.so"
elseif ARGS[1] == "cpu"
    @test isnothing(MPIPreferences.System.preloads)
end