module MPIgen
  using Clang.Generators
  using MPICH_jll

  mkpath(joinpath(@__DIR__, "..", "out"))

  generate_signatures(dir = MPICH_jll.artifact_dir) = begin
    @info "Generate MPI bindings for MPICH in $dir"
    include_dir = normpath(dir, "include")

    # wrapper generator options
    options = load_options(joinpath(@__DIR__, "generator.toml"))

    # add compiler flags, e.g. "-DXXXXXXXXX"
    args = get_default_args()
    # @show args
    push!(args, "-I$include_dir", "-include$include_dir/mpi.h")

    headers = joinpath(include_dir, "mpi_proto.h")
    # headers = detect_headers(include_dir, args)

    # create context
    ctx = create_context(headers, args, options)

    # run generator
    build!(ctx)
  end

end
