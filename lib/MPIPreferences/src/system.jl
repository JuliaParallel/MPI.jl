module System
    export libmpi, mpiexec
    using Preferences, Libdl
    const libmpi = @load_preference("libmpi")
    const mpiexec_path = @load_preference("mpiexec")
    mpiexec(;adjust_PATH=true, adjust_LIBPATH=true) = `$mpiexec_path`
    mpiexec(f;adjust_PATH=true, adjust_LIBPATH=true) = f(`$mpiexec_path`)

    libmpi_handle = C_NULL
    function __init__()
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
