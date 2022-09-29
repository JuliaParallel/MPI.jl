module MPIgenerator
    using Clang.Generators
    using MPIPreferences

    if MPIPreferences.binary == "MPICH_jll"
        import MPICH_jll: artifact_dir
    elseif MPIPreferences.binary == "OpenMPI_jll"
        import OpenMPI_jll: artifact_dir
    else
        error("Unknown MPI binary: $(MPIPreferences.binary)")
    end

    signatures() = begin
        @info "Generate MPI bindings from $(MPIPreferences.binary)"

        # temporary directory for `Clang.jl` - must match path in `generator.toml`
        out = joinpath(@__DIR__, "..", "out")
        mkpath(out)

        options = load_options(joinpath(@__DIR__, "generator.toml"))  # wrapper generator options

        include_dir = normpath(artifact_dir, "include")

        args = vcat(get_default_args(), "-I$include_dir")  # add compiler flags

        headers = if MPIPreferences.binary == "MPICH_jll"
            push!(args, "-include$include_dir/mpi.h")
            joinpath(include_dir, "mpi_proto.h")
        elseif MPIPreferences.binary == "OpenMPI_jll"
            joinpath(include_dir, "mpi.h")
        end

        ctx = create_context(headers, args, options)

        build!(ctx)  # run generator

        ############################
        # custom MPI post-processing
        rm(joinpath(out, "common.jl"))  # remove un-needed file

        # these methods must be called with `@mpicall` instead of `@mpichk`
        mpicall = (
            ":MPI_Get_library_version",
            ":MPI_Get_processor_name",
            ":MPI_Get_version",
            ":MPI_Wtime",
            ":MPI_Wtick",
        )

        src = joinpath(out, "api.jl")
        fn = replace(@__FILE__, r".*MPI.jl" => "MPI.jl")
        lines = String["# WARNING: this signature file for $(MPIPreferences.binary) has been auto-generated, please edit $fn instead !\n"]
        for line in readlines(src)
            if startswith(lstrip(line), "ccall")
                m = match(r".*(:[\w_]+)", line)
                repl = if m ≢ nothing && first(m.captures) ∈ mpicall
                    "@mpicall ccall"
                else
                    "@mpichk ccall"
                end
                line = replace(line, "Ptr{Cvoid}" => "MPIPtr", "ccall" => repl)
            end
            push!(lines, line)
        end
        write(src, join(lines, "\n"))

        dst = normpath(@__DIR__, "..", "..", "src", "auto_generated_api.jl")
        mv(src, dst; force=true)  # move the generated file to src
        rm(out)  # cleanup

        @info "Auto-generated file $dst written"

        nothing
    end

end
