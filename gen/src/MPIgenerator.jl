module MPIgenerator
    __precompile__(false)
    using Clang.Generators
    using MPIPreferences
    using Clang

    if MPIPreferences.binary == "MPICH_jll"
        import MPICH_jll: artifact_dir
    elseif MPIPreferences.binary == "OpenMPI_jll"
        import OpenMPI_jll: artifact_dir
    else
        error("Unknown MPI binary: $(MPIPreferences.binary)")
    end

    @eval Clang.Generators translate(jlty::JuliaCpointer, options=Dict()) = begin
        # @show jlty getPointeeType(jlty.ref) getNamedType(getPointeeType(jlty.ref)) propertynames(jlty)
        is_jl_funcptr(jlty) && return translate(JuliaPtrCvoid(), options)
        jlptree = tojulia(getPointeeType(jlty.ref))
        if get(options, "always_NUL_terminated_string", false)
            is_jl_char(jlptree) && return :Cstring
            is_jl_wchar(jlptree) && return :Cwstring
        end
        return Expr(:curly, :Ptr, translate(jlptree, options))
    end

    rewrite!(dag::ExprDAG) = begin
        replace!(get_nodes(dag)) do node
            # signature = name(node.cursor)
            # @show signature node.cursor 

            for a in get_function_args(node.cursor)
                startswith(name(a), "type_") || continue
                # @show a, typeof(a)
                if (ct = Clang.getCursorType(a)) isa CLPointer
                    # @show translate(tojulia(ct))
                    # if Clang.Generators.is_jl_funcptr(tojulia(ct))
                    if (pt = Clang.getPointeeType(ct)) isa CLTypedef
                        dumpobj(a)
                        repl = "MPI_" * replace(name(a), "type_" => "Type_")
                        @show repl
                        # FIXME: how do we replace node function arguments ?
                        # translate(tojulia(ct)) should replace "Ptr{Cvoid}" => repl

                        # the following approach doesn't work since some information is lost during julia code generation
                        #=
                        replace!(get_exprs(node)) do ex
                            out = Expr(ex.head)
                            for a in ex.args
                                push!(out.args, a)
                            end
                            @show out
                            out
                        end
                        =#
                    end
                    # end
                end
            end
            # dump(node)

            node
        end
    end

    signatures() = begin
        @info "Generate MPI bindings from $(MPIPreferences.binary)"

        # temporary directory for `Clang.jl` - must match path in `generator.toml`
        out = joinpath(@__DIR__, "..", "out")
        mkpath(out)

        options = load_options(joinpath(@__DIR__, "generator.toml"))  # wrapper generator options
        options["general"]["callback_documentation"] = node -> [string('$', "(_doc_external(:", node.id, "))")]

        include_dir = normpath(artifact_dir, "include")

        args = vcat(get_default_args(), "-I$include_dir")  # add compiler flags

        headers = if MPIPreferences.binary == "MPICH_jll"
            push!(args, "-include$include_dir/mpi.h")
            joinpath(include_dir, "mpi_proto.h")
        elseif MPIPreferences.binary == "OpenMPI_jll"
            joinpath(include_dir, "mpi.h")
        end

        ctx = create_context(headers, args, options)

        build!(ctx, BUILDSTAGE_NO_PRINTING)
        rewrite!(ctx.dag)
        build!(ctx, BUILDSTAGE_PRINTING_ONLY)

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

        src, fn = joinpath(out, "api.jl"), replace(@__FILE__, r".*MPI.jl" => "MPI.jl")
        lines = String["# WARNING: this signature file for $(MPIPreferences.binary) has been auto-generated, please edit $fn instead !\n"]
        for line in readlines(src)
            if (m = match(r"^ccall.*:([\w_]+)", lstrip(line))) ≢ nothing
                sym = first(m.captures) |> Symbol
                repl = sym ∈ mpicall ? "@mpicall ccall" : "@mpichk ccall"
                line = replace(line, "Ptr{Cvoid}" => "MPIPtr", "ccall" => repl)
                if (ver = get(versioned, sym, nothing)) ≢ nothing
                    line *= " $(repr(ver))"
                end
            end
            push!(lines, replace(line, raw"\$" => '$'))
        end
        write(src, join(lines, "\n"))

        dst = normpath(@__DIR__, "..", "..", "src", "api", "generated_api.jl")
        mv(src, dst; force=true)  # move the generated file to src
        rm(out)  # cleanup

        @info "Auto-generated file $dst written"

        nothing
    end

end
