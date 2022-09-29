module MPIgenerator
    using Clang.Generators
    using MPICH_jll

    signatures(dir = MPICH_jll.artifact_dir) = begin
        @info "Generate MPI bindings for MPICH located in $dir"

        # scratch directory for `Clang.jl`
        out = joinpath(@__DIR__, "..", "out")
        mkpath(out)

        include_dir = normpath(dir, "include")

        # wrapper generator options
        options = load_options(joinpath(@__DIR__, "generator.toml"))

        # add compiler flags, e.g. "-DXXXXXXXXX"
        args = get_default_args()
        push!(args, "-I$include_dir", "-include$include_dir/mpi.h")

        headers = joinpath(include_dir, "mpi_proto.h")

        # create context
        ctx = create_context(headers, args, options)

        # run generator
        build!(ctx)

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

        fn = joinpath(out, "api.jl")
        lines = String["# WARNING: this file has been auto-generated, please edit $(replace(@__FILE__, r".*MPI.jl" => "MPI.jl")) instead !\n"]
        for line in readlines(fn)
            if startswith(lstrip(line), "ccall")
                m = match(r".*(:[\w_]+)", line)
                repl = if m !== nothing && first(m.captures) ∈ mpicall
                    "@mpicall ccall"
                else
                    "@mpichk ccall"
                end
                line = replace(line, "ccall" => repl)
                line = replace(line, "Ptr{Cvoid}" => "MPIPtr")
            end
            push!(lines, line)
        end
        write(fn, join(lines, "\n"))

        # move the generated file to src
        mv(fn, joinpath(@__DIR__, "..", "..", "src", "auto_generated_api.jl"); force=true)

        rm(out)  # cleanup

        nothing
    end

end
