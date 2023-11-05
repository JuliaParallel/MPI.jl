using Pkg, Test, MPIPreferences

project_path = dirname(Pkg.project().path)
test_dir = @__DIR__
test_data = joinpath(@__DIR__, "test_data")

cmd(f) = `$(Base.julia_cmd()) --startup-file=no --project=$(project_path) $(joinpath(test_dir, f))`

withenv("JULIA_MPI_CC_OPTS_FILE" => joinpath(test_data, "cc_opts_cuda.txt")) do
    MPIPreferences.use_system_binary(vendor="cray"; mpiexec="srun")

    local_pref_1 = joinpath(project_path, "JuliaLocalPreferences.toml")
    local_pref_2 = joinpath(project_path, "LocalPreferences.toml")
    pref_file = isfile(local_pref_1) ? local_pref_1 : local_pref_2

    genereated_settings = readchomp(pref_file)
    expected_settings = readchomp(
        joinpath(test_data, "LocalPreferences_cuda.toml")
    )

    @test genereated_settings == expected_settings
    run(cmd("test_libmpi.jl"))
end