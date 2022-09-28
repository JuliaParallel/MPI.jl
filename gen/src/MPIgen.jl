module MPIgen
  using Clang.Generators
  using OpenMPI_jll
  using MPICH_jll

  export mpich, openmpi

  mkpath(joinpath(@__DIR__, "..", "out"))

  mpich(dir = MPICH_jll.artifact_dir) = begin
    @info "Generate MPI bindings for MPICH in $dir"
    include_dir = normpath(dir, "include")

    # wrapper generator options
    options = load_options(joinpath(@__DIR__, "mpich_generator.toml"))

    # add compiler flags, e.g. "-DXXXXXXXXX"
    args = get_default_args()
    # @show args
    push!(args, "-I$include_dir", "-include$include_dir/mpi.h")

    headers = joinpath.(Ref(include_dir), ["mpio.h", "mpi_proto.h"])
    # headers = detect_headers(include_dir, args)

    # create context
    ctx = create_context(headers, args, options)

    # run generator
    build!(ctx)
  end

  openmpi(dir = OpenMPI_jll.artifact_dir) = begin
    @info "Generate MPI bindings for OpenMPI in $dir"
    include_dir = normpath(dir, "include")

    # wrapper generator options
    options = load_options(joinpath(@__DIR__, "openmpi_generator.toml"))

    # add compiler flags, e.g. "-DXXXXXXXXX"
    args = get_default_args()
    push!(args, "-I$include_dir")

    headers = joinpath.(Ref(include_dir), ["mpi.h"])
    # headers = detect_headers(include_dir, args)

    # create context
    ctx = create_context(headers, args, options)

    # run generator
    build!(ctx)
  end

  # other MPI implementations ...
end
