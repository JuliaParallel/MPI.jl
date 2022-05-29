module System
    export libmpi, mpiexec
    using Preferences, Libdl
    const libmpi = @load_preference("libmpi")
    const mpiexec_path = @load_preference("mpiexec")
    mpiexec(;adjust_PATH=true, adjust_LIBPATH=true) = `$mpiexec_path`
    mpiexec(f;adjust_PATH=true, adjust_LIBPATH=true) = f(`$mpiexec_path`)

    libmpi_handle = C_NULL
    function __init__()
        global libmpi_handle = Libdl.dlopen(libmpi, Libdl.RTLD_LAZY | Libdl.RTLD_GLOBAL)
    end
end
