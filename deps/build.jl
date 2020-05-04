using Pkg.TOML, Libdl

config_toml = joinpath(first(DEPOT_PATH), "prefs", "MPI.toml")
mkpath(dirname(config_toml))

if !isfile(config_toml)
    touch(config_toml)
end

config = TOML.parsefile(config_toml)
update_config = false


# MPI.toml has 4 keys
#  binary   = "system" | "default" | "MPICH_jll" | "OpenMPI_jll" | "MicrosoftMPI_jll"
#  library  = library name/path | list of library names/paths
#  abi      = "MPICH" | "OpenMPI" | "MicrosoftMPI" | "unknown"
#  mpiexec  = executable name/path | [executable name/path, extra args...]


# 1. check if environment variables have changed
if haskey(ENV, "JULIA_MPI_BINARY")
    config["binary"] = ENV["JULIA_MPI_BINARY"]
    update_config = true
elseif haskey(ENV, "JULIA_MPI_LIBRARY")
    config["binary"] = "system"
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
    config["mpiexec"] = [ENV["JULIA_MPIEXEC"], Base.shell_split(get(ENV, "JULIA_MPIEXEC_ARGS", ""))...]
    update_config = true
end

if update_config
    open(config_toml, write=true) do f
        TOML.print(f, config)
    end
end

binary = get(config, "binary", "default")

# 2. generate deps.jl
if binary == "system"
    @info "using system MPI"
    library = get(config, "library", ["libmpi", "libmpi_ibm", "msmpi", "libmpich"])
    mpiexec = get(config, "mpiexec", ["mpiexec"])
    abi     = get(config, "abi", nothing)

    const libmpi = find_library(library)
    if libmpi == ""
        error("libmpi could not be found")
    end
    
    const mpiexec_cmd = Cmd(mpiexec isa String ? [mpiexec] : mpiexec)
    @info "Using implementation" libmpi mpiexec_cmd
    
    _doc_external(fname) = ""
    include(joinpath("..","src","implementations.jl"))
    
    if abi === nothing
        # 3. check ABI
        impl, version = identify_implementation()
        if (impl == MPICH && version >= v"3.1" ||
            impl == IntelMPI && version > v"2014" ||
            impl == MVAPICH && version >= v"2")
            abi = "MPICH"
        elseif impl == OpenMPI || impl == IBMSpectrumMPI
            abi = "OpenMPI"
        elseif impl == MicrosoftMPI
            abi = "MicrosoftMPI"
        else
            abi = "unknown"
        end
    end
    if abi == "MPICH"
        abi_incl = :(include("consts_mpich.jl"))
    elseif abi == "OpenMPI"
        abi_incl = :(include("consts_openmpi.jl"))
    elseif abi == "MicrosoftMPI"
        abi_incl = :(include("consts_microsoftmpi.jl"))
    else
        include("gen_consts.jl")
        abi_incl = :(include("consts.jl"))
    end


    deps = quote
        const libmpi = $libmpi
        const mpiexec_cmd = $mpiexec_cmd
        const mpiexec_path = mpiexec_cmd[1]
        mpiexec(fn) = fn(mpiexec_cmd)
        $abi_incl

        using Requires

        function __init__deps()
            if Get_library_version() != $MPI_LIBRARY_VERSION_STRING
                error("MPI library has changed, please re-run `Pkg.build(\"MPI\")`.")
            end

            # error if a jll is loaded.
            @require(MPICH_jll        = "7cb0a576-ebde-5e09-9194-50597f1243b4",
                     error("MPICH_jll cannot be loaded: MPI.jl is configured to use the system MPI library"))
            @require(MicrosoftMPI_jll = "9237b28f-5490-5468-be7b-bb81f5f5e6cf",
                     error("MicrosoftMPI_jll cannot be loaded: MPI.jl is configured to use the system MPI library"))
            @require(OpenMPI_jll      = "fe0851c0-eecd-5654-98d4-656369965a5c",
                     error("OpenMPI_jll cannot be loaded: MPI.jl is configured to use the system MPI library"))
        end
    end
elseif binary == "default"
    @info "using default MPI jll"
    deps = quote
        if Sys.iswindows()
            using MicrosoftMPI_jll
            include("consts_microsoftmpi.jl")
        else
            using MPICH_jll
            include("consts_mpich.jl")
        end

        function __init__deps()
            if haskey(ENV, "SLURM_JOBID") || haskey(ENV, "PBS_JOBID") || haskey(ENV, "LSB_JOBID")
                @warn """
                    You appear to be using MPI.jl with the default MPI binary on a cluster.
                    For maximum performance you should use the cluster provided version.
                    """
            end
        end
    end
elseif binary ==  "MPICH_jll"
    @info "using MPICH_jll"
    deps = quote
        using MPICH_jll
        include("consts_mpich.jl")
        __init__deps() = nothing
    end
elseif binary ==  "OpenMPI_jll"
    @info "using OpenMPI_jll"
    deps = quote
        using OpenMPI_jll
        include("consts_openmpi.jl")

        function __init__deps()
            # Required for OpenMPI relocateable binaries
            # TODO: this should be done in OpenMPI_jll package
            # https://github.com/JuliaPackaging/Yggdrasil/issues/390
            ENV["OPAL_PREFIX"] = OpenMPI_jll.artifact_dir
        end
    end
elseif binary ==  "MicrosoftMPI_jll"
    @info "using MicrosoftMPI_jll"
    deps = quote
        using MicrosoftMPI_jll
        include("consts_microsoftmpi.jl")
        __init__deps() = nothing
    end
else
    error("Unknown binary $binary")
end

open("deps.jl", write=true) do f
    print(f, deps)
end
