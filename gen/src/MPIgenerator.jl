module MPIgenerator
    using Clang.Generators
    using MPIPreferences

    # INTRODUCED: procedure => the MPI version that added it
    # EMBIGGENED: procedures that have a large-count `MPI_*_c` entry point
    # Both are derived from the MPI standard's own data; see gen/versions/README.md.
    include("versions.jl")

    # Note: We could, in principle, also use the MPI standard itself to generate these functions,
    # instead of looking at a particular MPI library.
    if MPIPreferences.binary == "MPICH_jll"
        import MPICH_jll: artifact_dir
    elseif MPIPreferences.binary == "OpenMPI_jll"
        import OpenMPI_jll: artifact_dir
    else
        error("Unknown MPI binary: $(MPIPreferences.binary)")
    end

    """
        embiggened_base(sym, line)

    For a large-count entry point `MPI_Foo_c`, the narrow `MPI_Foo` to fall back on when
    the MPI library does not provide it (see `@mpichk`'s `fallback=`), or `nothing`.

    A function which takes a callback argument that is also widened is excluded: `MPI_Op_create_c` takes an
    `MPI_User_function_c` (`MPI_Count *len`) while `MPI_Op_create` takes an
    `MPI_User_function` (`int *len`), so handing one creator's callback to the other
    would make it load the wrong width. Same for `MPI_Register_datarep_c`. Such a function is
    detected by a `*_function_c` argument type rather than listed by name.
    """
    function embiggened_base(sym, line)
        name = string(sym)
        endswith(name, "_c") || return nothing
        base = Symbol(chop(name; tail=2))
        base ∈ EMBIGGENED || return nothing
        occursin(r"_function_c\}", line) && return nothing
        return base
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

        build!(ctx)  # run generator

        ############################
        # custom MPI post-processing
        rm(joinpath(out, "common.jl"))  # remove un-needed file

        # These methods must be called with `@mpicall` instead of `@mpichk`. They do
        # return an error code, but they are called during precompilation, before MPI.jl can
        # turn one into an `MPIError` (whose message comes from `MPI_Error_string`).
        #
        # Functions whose return value is not an error code at all are detected below
        # from their `ccall` return type instead of being listed here -- `MPI_Wtime` and
        # `MPI_Wtick` return a `Cdouble`, `MPI_Aint_add` and `MPI_Aint_diff` an
        # `MPI_Aint`. We cannot error-check them.
        mpicall = (
            :MPI_Get_library_version,
            :MPI_Get_processor_name,
            :MPI_Get_version,
        )

        # Repo-relative rather than derived from the absolute path: `r".*MPI.jl"` keeps
        # everything after the last "MPI.jl" in the path, which in a git worktree is
        # ".claude/worktrees/<name>/gen/src/...", leaking the checkout into the banner.
        src = joinpath(out, "api.jl")
        fn = "MPI.jl/" * replace(relpath(@__FILE__, normpath(@__DIR__, "..", "..")), '\\' => '/')
        lines = String["# WARNING: this signature file for $(MPIPreferences.binary) has been auto-generated, please edit $fn instead!\n"]
        for line in readlines(src)
            if (m = match(r"^ccall\(\(:([\w_]+), libmpi\), ([^,]+),", lstrip(line))) ≢ nothing
                sym, returntype = Symbol(m.captures[1]), strip(m.captures[2])
                errorchecked = returntype == "Cint" && sym ∉ mpicall
                repl = errorchecked ? "@mpichk ccall" : "@mpicall ccall"
                line = replace(line, "Ptr{Cvoid}" => "MPIPtr", "ccall" => repl)
                if errorchecked
                    if (ver = get(INTRODUCED, sym, nothing)) ≢ nothing
                        line *= " $(repr(ver))"
                    end
                    if (base = embiggened_base(sym, line)) ≢ nothing
                        line *= " fallback=$base"
                    end
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
