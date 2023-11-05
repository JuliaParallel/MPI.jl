using Pkg, Test, MPIPreferences

project_path = dirname(Pkg.project().path)
test_dir = @__DIR__
test_data = joinpath(@__DIR__, "test_data")

cmd(f; a="") = `$(Base.julia_cmd()) --startup-file=no --project=$(project_path) $(joinpath(test_dir, f)) $(a)`

function test_generated_prefs(suffix)
    MPIPreferences.use_system_binary(vendor="cray"; mpiexec="srun")

    local_pref_1 = joinpath(project_path, "JuliaLocalPreferences.toml")
    local_pref_2 = joinpath(project_path, "LocalPreferences.toml")
    pref_file = isfile(local_pref_1) ? local_pref_1 : local_pref_2

    genereated_settings = readchomp(pref_file)
    expected_settings = readchomp(
        joinpath(test_data, "LocalPreferences_$(suffix).toml")
    )

    @test genereated_settings == expected_settings
    r = run(cmd("test_libmpi.jl"))
    @test success(r)
end

function test_existing_prefs(suffix)
    local_pref_1 = joinpath(project_path, "JuliaLocalPreferences.toml")
    local_pref_2 = joinpath(project_path, "LocalPreferences.toml")

    # ensure any previous tests have been cleaned up
    if isfile(local_pref_1) rm(local_pref_1) end
    if isfile(local_pref_2) rm(local_pref_2) end

    cp(
        joinpath(test_data, "LocalPreferences_$(suffix).toml"),
        joinpath(project_path, "LocalPreferences.toml")
    )

    r = run(cmd("test_libmpi.jl"))
    @test success(r)
end

withenv("JULIA_MPI_CC_OPTS_FILE" => joinpath(test_data, "cc_opts_cuda.txt")) do
    test_generated_prefs("cuda")
end

withenv("JULIA_MPI_CC_OPTS_FILE" => joinpath(test_data, "cc_opts_cpu.txt")) do
    test_generated_prefs("cpu")
end

test_existing_prefs("cuda")
r = run(cmd("test_gtl_preload.jl"; a="cuda"))
@test success(r)
test_existing_prefs("cpu")
r = run(cmd("test_gtl_preload.jl"; a="cpu"))
@test success(r)