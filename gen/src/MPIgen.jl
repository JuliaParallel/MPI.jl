module MPIgen
    using Clang.Generators
    using MPICH_jll

    generate_signatures(dir=MPICH_jll.artifact_dir) = begin
        @info "Generate MPI bindings for MPICH in $dir"

        out = joinpath(@__DIR__, "..", "out")
        mkpath(out)

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

        rm(joinpath(out, "common.jl"))  # remove un-needed file

        lines = String[]
        fn = joinpath(out, "api.jl")
        for line in readlines(fn)
            if startswith(lstrip(line), "ccall")
                line = replace(line, "ccall" => "@mpichk ccall")
            end
            push!(lines, line)
        end
        write(fn, join(lines, "\n"))
        nothing
    end

end
