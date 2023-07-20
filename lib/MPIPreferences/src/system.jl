module System
    include("preloads.jl")

    export libmpi, mpiexec
    using Preferences, Libdl
    const libmpi = @load_preference("libmpi")
    const preloads = @load_preference("preloads")
    const preloads_env_switch = @load_preference("preloads_env_switch")
    const mpiexec_path = @load_preference("mpiexec")
    mpiexec(;adjust_PATH=true, adjust_LIBPATH=true) = `$mpiexec_path`
    mpiexec(f;adjust_PATH=true, adjust_LIBPATH=true) = f(`$mpiexec_path`)

    libmpi_handle = C_NULL
    function __init__()
        # preload any dependencies of libmpi (if needed, eg. GTL on cray) before
        # dlopen'ing the MPI library: https://github.com/JuliaParallel/MPI.jl/pull/716
        Preloads.dlopen_preloads()

        global libmpi_handle = try
            Libdl.dlopen(libmpi, Libdl.RTLD_LAZY | Libdl.RTLD_GLOBAL)
        catch error
            @error """
                   $(libmpi) could not be loaded, see error message below.
                   Use `MPIPreferences.use_system_binary` or `MPIPreferences.use_jll_binary` to reconfigure the package and then restart Julia.
                   """ error
            C_NULL
        end
    end
end
