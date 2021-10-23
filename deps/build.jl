using Pkg.TOML, Libdl

config_toml = joinpath(first(DEPOT_PATH), "prefs", "MPI.toml")
mkpath(dirname(config_toml))

if !isfile(config_toml)
    touch(config_toml)
end

config = TOML.parsefile(config_toml)
update_config = false


# MPI.toml has 4 keys
#  binary   = "" (default) | "system" | "MPICH_jll" | "MPItrampoline_jll" | "OpenMPI_jll" | "MicrosoftMPI_jll"
#  path     = "" (default) | top-level directory location
#  library  = "" (default) | library name/path | list of library names/paths
#  abi      = "" (default) | "MPICH" | "MPItrampoline" | "OpenMPI" | "MicrosoftMPI" | "unknown"
#  mpiexec  = "" (default) | executable name/path | [executable name/path, extra args...]


# 1. check if environment variables have changed
if haskey(ENV, "JULIA_MPI_BINARY")
    config["binary"] = ENV["JULIA_MPI_BINARY"]
    update_config = true
elseif haskey(ENV, "JULIA_MPI_LIBRARY") || haskey(ENV, "JULIA_MPI_PATH")
    config["binary"] = "system"
end

if haskey(ENV, "JULIA_MPI_PATH")
    config["path"] = ENV["JULIA_MPI_PATH"]
    update_config = true
end

if haskey(ENV, "JULIA_MPI_LIBRARY")
    config["library"] = ENV["JULIA_MPI_LIBRARY"]
    update_config = true
end

if haskey(ENV, "JULIA_MPI_ABI")
    config["abi"] = ENV["JULIA_MPI_ABI"]
    update_config = true
end

if haskey(ENV, "JULIA_MPIEXEC")
    if ENV["JULIA_MPIEXEC"] == ""
        delete!(config, "mpiexec")
    else
        config["mpiexec"] = ENV["JULIA_MPIEXEC"]
    end
    update_config = true
end

if update_config
    open(config_toml, write=true) do f
        TOML.print(f, config)
    end
end

binary = get(config, "binary", "")

# 2. generate deps.jl
if binary == "system"

    @info "using system MPI"
    library = get(config, "library", "")
    if library == ""
        library = ["libmpi", "libmpi_ibm", "msmpi", "libmpich", "libmpitrampoline"]
    end
    path    = get(config, "path", "")
    mpiexec = get(config, "mpiexec", path == "" ? "mpiexec" : joinpath(path, "bin", "mpiexec"))
    abi     = get(config, "abi", "")

    const libmpi = find_library(library, path == "" ? [] : [joinpath(path, "lib"), joinpath(path, "lib64")])
    if libmpi == ""
        error("libmpi could not be found")
    end

    const mpiexec_cmd = Cmd(mpiexec isa String ? [mpiexec] : mpiexec)

    _doc_external(fname) = ""

    include(joinpath("..", "src", "implementations.jl"))

    @info "Using implementation" libmpi mpiexec_cmd MPI_LIBRARY_VERSION_STRING

    if abi === ""
        # 3. check ABI
        impl, version = identify_implementation()
        if (impl == MPICH && version >= v"3.1" ||
            impl == IntelMPI && version > v"2014" ||
            impl == MVAPICH && version >= v"2" ||
            impl == CrayMPICH && version >= v"7")
            # https://www.mpich.org/abi/
            abi = "MPICH"
        elseif impl == OpenMPI || impl == IBMSpectrumMPI
            abi = "OpenMPI"
        elseif impl == MicrosoftMPI
            abi = "MicrosoftMPI"
        else
            abi = "unknown"
        end
        @info "MPI implementation detected" impl version abi
    else
        @info "MPI implementation config" abi
    end

    deps = quote
        const libmpi = $libmpi
        const mpiexec_cmd = $mpiexec_cmd
        const mpiexec_path = mpiexec_cmd[1]
        _mpiexec(fn) = fn(mpiexec_cmd)

        using Requires

        function __init__deps()
            if Get_library_version() != $MPI_LIBRARY_VERSION_STRING
                error("MPI library has changed, please re-run `Pkg.build(\"MPI\")`.")
            end

            # error if a jll is loaded.
            @require(MPICH_jll         = "7cb0a576-ebde-5e09-9194-50597f1243b4",
                     error("MPICH_jll cannot be loaded: MPI.jl is configured to use the system MPI library"))
            @require(MPItrampoline_jll = "f1f71cc9-e9ae-5b93-9b94-4fe0e1ad3748",
                     error("MPItrampoline_jll cannot be loaded: MPI.jl is configured to use the system MPI library"))
            @require(MicrosoftMPI_jll  = "9237b28f-5490-5468-be7b-bb81f5f5e6cf",
                     error("MicrosoftMPI_jll cannot be loaded: MPI.jl is configured to use the system MPI library"))
            @require(OpenMPI_jll       = "fe0851c0-eecd-5654-98d4-656369965a5c",
                     error("OpenMPI_jll cannot be loaded: MPI.jl is configured to use the system MPI library"))
        end
    end

elseif binary == ""

    @info "using default MPI jll"

    deps = quote
        if Sys.iswindows()
            using MicrosoftMPI_jll
            const libmpi = MicrosoftMPI_jll.libmpi
            const _mpiexec = MicrosoftMPI_jll.mpiexec
            const mpiexec_path = MicrosoftMPI_jll.mpiexec_path
        else
            using MPICH_jll
            const libmpi = MPICH_jll.libmpi
            const _mpiexec = MPICH_jll.mpiexec
            const mpiexec_path = MPICH_jll.mpiexec_path
        end

        function __init__deps()
            if (haskey(ENV, "SLURM_JOBID") || haskey(ENV, "PBS_JOBID") || haskey(ENV, "LSB_JOBID")) &&
                !(get(ENV, "JULIA_MPI_CLUSTER_WARN", "") == "n")
                @warn """
                    You appear to be using MPI.jl with the default MPI binary on a cluster.
                    We recommend using the system-provided MPI, see the Configuration section of the MPI.jl docs.
                    """
            end
        end
    end

elseif binary == "MPICH_jll"

    @info "using MPICH_jll"

    deps = quote
        using MPICH_jll
        const libmpi = MPICH_jll.libmpi
        const _mpiexec = MPICH_jll.mpiexec
        const mpiexec_path = MPICH_jll.mpiexec_path

        __init__deps() = nothing
    end

elseif binary == "MPItrampoline_jll"

    @info "using MPItrampoline_jll"

    deps = quote
        @info "[MPI] Initializating MPItrampoline"
        using MPItrampoline_jll
        @assert MPItrampoline_jll.is_available()
        if "MPITRAMPOLINE_LIB" ∉ keys(ENV)
            @info "[MPI] Using built-in MPICH with MPItrampoline"
            # MPItrampoline_jll has the correct default for
            # MPITRAMPOLINE_LIB already built in; we don't need to set
            # it (and it would be too late by now anyway since
            # MPItrampoline_jll is already loadedd)
            ENV["MPITRAMPOLINE_MPIEXEC"] = MPItrampoline_jll.mpich_mpiexec_path
        end
        const libmpi = MPItrampoline_jll.libmpi
        const _mpiexec = MPItrampoline_jll.mpiexec
        const mpiexec_path = MPItrampoline_jll.mpiexec_path

        __init__deps() = nothing
    end

elseif binary == "OpenMPI_jll"

    @info "using OpenMPI_jll"

    deps = quote
        using OpenMPI_jll
        const libmpi = OpenMPI_jll.libmpi
        const _mpiexec = OpenMPI_jll.mpiexec
        const mpiexec_path = OpenMPI_jll.mpiexec_path

        function __init__deps()
            # Required for OpenMPI relocateable binaries
            # TODO: this should be done in OpenMPI_jll package
            # https://github.com/JuliaPackaging/Yggdrasil/issues/390
            ENV["OPAL_PREFIX"] = OpenMPI_jll.artifact_dir
        end
    end

elseif binary == "MicrosoftMPI_jll"

    @info "using MicrosoftMPI_jll"

    deps = quote
        using MicrosoftMPI_jll
        const libmpi = MicrosoftMPI_jll.libmpi
        const _mpiexec = MicrosoftMPI_jll.mpiexec
        const mpiexec_path = MicrosoftMPI_jll.mpiexec_path

        __init__deps() = nothing
    end

else
    error("Unknown binary $binary")
end

remove_line_numbers(x) = x
function remove_line_numbers(ex::Expr)
    if ex.head == :macrocall
        ex.args[2] = nothing
    else
        ex.args = [remove_line_numbers(arg) for arg in ex.args if !(arg isa LineNumberNode)]
    end
    return ex
end

# Only update deps.jl if it has changed.
# This allows users to call Pkg.build("MPI") without triggering another round of precompilation.
deps_str =
    """
    # This file has been generated automatically.
    # It will be overwritten the next time `Pkg.build("MPI")` is called.
    """ *
    string(remove_line_numbers(deps)) *
    """        
    """        

if !isfile("deps.jl") || deps_str != read("deps.jl", String)
    write("deps.jl", deps_str)
end

include("deps.jl")
include("prepare_mpi_constants.jl")
