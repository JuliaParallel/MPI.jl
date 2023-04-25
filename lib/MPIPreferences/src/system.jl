module System
    export libmpi, mpiexec
    using Preferences, Libdl
    const libmpi = @load_preference("libmpi")
    # const libgtl = @load_preference("libgtl")
    const preloads = @load_preference("preloads")
    const preloads_env_switch = @load_preference("preloads_env_switch")
    const mpiexec_path = @load_preference("mpiexec")
    mpiexec(;adjust_PATH=true, adjust_LIBPATH=true) = `$mpiexec_path`
    mpiexec(f;adjust_PATH=true, adjust_LIBPATH=true) = f(`$mpiexec_path`)

    # libgtl_handle = C_NULL
    libmpi_handle = C_NULL
    function __init__()
        # # dlopen GTL library (if needed) before dlopen'ing the MPI library:
        # # https://github.com/JuliaParallel/MPI.jl/pull/716
        # if ! isnothing(libgtl)
        #     global libgtl_handle = try
        #         Libdl.dlopen(libgtl, Libdl.RTLD_LAZY | Libdl.RTLD_GLOBAL)
        #     catch error
        #         @error """
        #                $(libgtl) could not be loaded, see error message below.
        #                Use `MPIPreferences.use_system_binary` or `MPIPreferences.use_jll_binary` to reconfigure the package and then restart Julia.
        #                """ error
        #     end
        # end
        preload_enabled = false
        if isnothing(preloads_env_switch)
            preload_enabled = true
        elseif get(ENV, preloads_env_switch, "0") == "1"
            preload_enabled = true
        end

        if preload_enabled
            for preload in preloads
                try
                    Libdl.dlopen(preload, Libdl.RTLD_LAZY | Libdl.RTLD_GLOBAL)
                catch error
                    @error """
                        $(preload) could not be loaded, see error message below.
                        Use `MPIPreferences.use_system_binary` or `MPIPreferences.use_jll_binary` to reconfigure the package and then restart Julia.
                        """ error
                end
            end
        end

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
