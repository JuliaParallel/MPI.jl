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
        # NOTE: in Clang.jl v0.19+ the callback takes also the docstring extracted from the
        # C comments as second argument, which we ignore
        options["general"]["callback_documentation"] = (node, doc) -> [string('$', "(_doc_external(:", node.id, "))")]

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
            :MPI_Get_library_version,
            :MPI_Get_processor_name,
            :MPI_Get_version,
            :MPI_Wtime,
            :MPI_Wtick,
        )

        # these methods are called with `gc_safe=true`, to allow the garbage
        # collector to run concurrently with the (potentially blocking) MPI call.
        # The criterion for inclusion is that the worst-case duration of the call
        # is unbounded because it waits on the progress of peer ranks, rather than
        # being bounded by local work, and that the call can only re-enter Julia
        # through `@cfunction` callbacks (e.g. custom reduction operators), which
        # are safe in `gc_safe` regions
        gc_safe = (
            # request completion and probes
            :MPI_Wait,
            :MPI_Waitall,
            :MPI_Waitany,
            :MPI_Waitsome,
            :MPI_Probe,
            :MPI_Mprobe,
            :MPI_Mrecv,
            # blocking point-to-point
            :MPI_Send,
            :MPI_Ssend,
            :MPI_Recv,
            :MPI_Sendrecv,
            :MPI_Sendrecv_replace,
            # blocking collectives
            :MPI_Barrier,
            :MPI_Bcast,
            :MPI_Gather,
            :MPI_Gatherv,
            :MPI_Scatter,
            :MPI_Scatterv,
            :MPI_Allgather,
            :MPI_Allgatherv,
            :MPI_Alltoall,
            :MPI_Alltoallv,
            :MPI_Alltoallw,
            :MPI_Reduce,
            :MPI_Allreduce,
            :MPI_Reduce_scatter,
            :MPI_Reduce_scatter_block,
            :MPI_Scan,
            :MPI_Exscan,
            # blocking neighborhood collectives
            :MPI_Neighbor_allgather,
            :MPI_Neighbor_allgatherv,
            :MPI_Neighbor_alltoall,
            :MPI_Neighbor_alltoallv,
            :MPI_Neighbor_alltoallw,
        )

        versioned = Dict(
            :MPI_Dist_graph_create_adjacent => v"2.2",
            :MPI_Dist_graph_neighbors_count => v"2.2",
            :MPI_Dist_graph_neighbors => v"2.2",
            :MPI_Dist_graph_create => v"2.2",
            :MPI_Neighbor_allgatherv => v"3.0",
            :MPI_Neighbor_alltoallv => v"3.0",
            :MPI_Neighbor_allgather => v"3.0",
            :MPI_Neighbor_alltoall => v"3.0",
        )

        src, fn = joinpath(out, "api.jl"), joinpath("MPI.jl", relpath(@__FILE__, normpath(@__DIR__, "..", "..")))
        lines = String[]
        for line in readlines(src)
            if (m = match(r"^ccall.*:([\w_]+)", lstrip(line))) ≢ nothing
                sym = first(m.captures) |> Symbol
                repl = (sym ∈ mpicall ? "@mpicall" : "@mpichk") *
                    (sym ∈ gc_safe ? " gc_safe=true" : "") * " ccall"
                line = replace(line, "Ptr{Cvoid}" => "MPIPtr", "ccall" => repl)
                if (ver = get(versioned, sym, nothing)) ≢ nothing
                    line *= " $(repr(ver))"
                end
            end
            push!(lines, replace(line, raw"\$" => '$'))
        end

        # group the lines into blocks (docstring + function definition) and sort them by
        # name of the function, to make the output stable: the order in which the
        # functions are declared in the headers may change between releases of the MPI
        # implementations
        blocks = Vector{Vector{String}}()
        block = String[]
        for line in lines
            # drop the blank lines separating the blocks, they are re-added below
            isempty(block) && isempty(line) && continue
            push!(block, line)
            if line == "end"  # end of a function definition
                push!(blocks, block)
                block = String[]
            end
        end
        isempty(block) || error("malformed generated file $src, trailing lines: $block")
        function_name(block) = match(r"^function (\w+)", block[findfirst(startswith("function "), block)]).captures[1]
        sort!(blocks; by=function_name)

        lines = String["# WARNING: this signature file for $(MPIPreferences.binary) has been auto-generated, please edit $fn instead !\n"]
        for block in blocks
            append!(lines, block)
            push!(lines, "")
        end
        write(src, join(lines, "\n"))

        dst = normpath(@__DIR__, "..", "..", "src", "api", "generated_api.jl")
        mv(src, dst; force=true)  # move the generated file to src
        rm(out)  # cleanup

        @info "Auto-generated file $dst written"

        nothing
    end

end
