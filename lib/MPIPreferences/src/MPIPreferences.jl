module MPIPreferences

using Preferences, Libdl

"""
    binary :: String

The currently selected binary.
"""
const binary = @load_preference("binary", Sys.iswindows() ? "MicrosoftMPI_jll" : "MPICH_jll")

"""
    abi :: String

The ABI of the currently selected binary.
"""
const abi = if binary == "system"
    @load_preference("abi")
elseif binary == "MicrosoftMPI_jll"
    "MicrosoftMPI"
elseif binary == "MPICH_jll"
    "MPICH"
elseif binary == "OpenMPI_jll"
    "OpenMPI"
elseif binary == "MPItrampoline_jll"
    "MPItrampoline"
else
    error("Unknown binary: $binary")
end

module System
    export libmpi, mpiexec
    using Preferences
    const libmpi = @load_preference("libmpi")
    const mpiexec_path = @load_preference("mpiexec")
    mpiexec(;adjust_PATH=true, adjust_LIBPATH=true) = `$mpiexec_path`
    mpiexec(f;adjust_PATH=true, adjust_LIBPATH=true) = f(`$mpiexec_path`)
end

"""
    use_jll_binary(binary; export_prefs=false, force=true)

Switches the underlying MPI implementation to one provided by JLL packages.
Available options are:
- `MicrosoftMPI_jll` (Only option and default on Winddows)
- `MPICH_jll` (Default on every other platform)
- `OpenMPI_jll`
- `MPItrampoline_jll`

The `export_prefs` option determines whether the preferences being set should be stored
within `LocalPreferences.toml` or `Project.toml`.
"""
function use_jll_binary(binary = Sys.iswindows() ? "MicrosoftMPI_jll" : "MPICH_jll"; export_prefs=false, force=true)
    binary in ["MicrosoftMPI_jll", "MPICH_jll", "OpenMPI_jll", "MPItrampoline_jll"] ||
        error("Unknown jll: $binary")
    set_preferences!(MPIPreferences,
        "binary" => binary,
        "libmpi" => nothing,
        "abi" => nothing,
        "mpiexec" => nothing;
        export_prefs=export_prefs,
        force=force
    )

    @warn "The underlying MPI implementation has changed. You will need to restart Julia for this change to take effect" binary

    if VERSION <= v"1.6.5" || VERSION == v"1.7.0"
        @warn """
        Due to a bug in Julia (until 1.6.5 and 1.7.1), setting preferences in transitive dependencies
        is broken (https://github.com/JuliaPackaging/Preferences.jl/issues/24). To fix this either update
        your version of Julia, or add MPIPreferences as a direct dependency to your project.
        """
    end

    return nothing
end


"""
    use_system_binary(;library_names, mpiexec="mpiexec", abi=nothing, export_prefs=false, force=true)

Switches the underlying MPI implementation to a system provided one. We will
search for a matching library with the given `library_names`. You can provide
a path to `mpiexec` if the system provides a different one, or if it is not in
the system path.

The `abi` of the found library is determined automatically using [`identify_abi`](@ref).

The `export_prefs` option determines whether the preferences being set should be stored
within `LocalPreferences.toml` or `Project.toml`.
"""
function use_system_binary(;
        library_names=["libmpi", "libmpi_ibm", "msmpi", "libmpich", "libmpitrampoline"],
        mpiexec="mpiexec",
        abi=nothing,
        export_prefs=false,
        force=true,
    )

    libmpi = find_library(library_names)
    if libmpi == ""
        error("MPI library could not be found")
    end
    if isnothing(abi)
        abi = identify_abi(libmpi)
    end
    if mpiexec isa Cmd
        mpiexec = collect(mpiexec)
    end
    set_preferences!(MPIPreferences,
        "binary" => "system",
        "libmpi" => libmpi,
        "abi" => abi,
        "mpiexec" => mpiexec,
        export_prefs=export_prefs,
        force=force
    )

    @warn "The underlying MPI implementation has changed. You will need to restart Julia for this change to take effect" libmpi abi mpiexec

    if VERSION <= v"1.6.5" || VERSION == v"1.7.0"
        @warn """
        Due to a bug in Julia (until 1.6.5 and 1.7.1), setting preferences in transitive dependencies
        is broken (https://github.com/JuliaPackaging/Preferences.jl/issues/24). To fix this either update
        your version of Julia, or add MPIPreferences as a direct dependency to your project.
        """
    end

    return nothing
end


"""
    identify_abi(libmpi)

Identify the MPI implementation from the library version string
"""
function identify_abi(libmpi)
    # 1) query MPI_Get_version
    # There is no way to query at runtime what the length of the buffer should be.
    # https://github.com/mpi-forum/mpi-issues/issues/159
    # 8192 is the maximum value of MPI_MAX_LIBRARY_VERSION_STRING across known
    # implementations.
    buf = Array{UInt8}(undef, 8192)
    buflen = Ref{Cint}()

    @static if Sys.isunix()
        # need to open libmpi with RTLD_GLOBAL flag for Linux, before
        # any ccall cannot use RTLD_DEEPBIND; this leads to segfaults
        # at least on Ubuntu 15.10
        hndl = Libdl.dlopen(libmpi, Libdl.RTLD_LAZY | Libdl.RTLD_GLOBAL)
    else
        hndl = Libdl.dlopen(libmpi)
    end

    try
        ptr = dlsym(hndl, :MPI_Get_library_version)
        ccall(ptr, Cint, (Ptr{UInt8}, Ref{Cint}), buf, buflen)
    finally
        @assert buflen[] < 8192
        resize!(buf, buflen[])
        version_string = String(buf)

        # 2) try to identify the MPI implementation
        impl = "unknown"
        version = v"0"

        if startswith(version_string, "MPICH")
            impl = "MPICH"
            # "MPICH Version:\t%s\n" /  "MPICH2 Version:\t%s\n"
            if (m = match(r"^MPICH2? Version:\t(\d+.\d+(?:.\d+)?\w*)\n", version_string)) !== nothing
                version = VersionNumber(m.captures[1])
            end

        elseif startswith(version_string, "Open MPI")
            # Open MPI / Spectrum MPI
            impl = occursin("IBM Spectrum MPI", version_string) ? "IBMSpectrumMPI" : "OpenMPI"

            if (m = match(r"^Open MPI v(\d+.\d+.\d+\w*)", version_string)) !== nothing
                version = VersionNumber(m.captures[1])
            end

        elseif startswith(version_string, "Microsoft MPI")
            impl = "MicrosoftMPI"
            # "Microsoft MPI %u.%u.%u.%u%S"
            # ignore last 2 (build numbers)
            if (m = match(r"^Microsoft MPI (\d+.\d+)", version_string)) !== nothing
                version = VersionNumber(m.captures[1])
            end

        elseif startswith(version_string, "Intel")
            impl = "IntelMPI"

            # "Intel(R) MPI Library 2019 Update 4 for Linux* OS"
            if (m = match(r"^Intel\(R\) MPI Library (\d+)(?: Update (\d+))?", version_string)) !== nothing
                if m.captures[2] === nothing
                    version = VersionNumber(m.captures[1])
                else
                    version = VersionNumber(m.captures[1]*"."*m.captures[2])
                end
            end

        elseif startswith(version_string, "MVAPICH2")
            impl = "MVAPICH"
            # "MVAPICH2 Version      :\t%s\n")
            if (m = match(r"^MVAPICH2? Version\s*:\t(\S*)\n", version_string)) !== nothing
                version = VersionNumber(m.captures[1])
            end

        elseif occursin("CRAY MPICH", version_string)
            impl = "CrayMPICH"
            # "MPI VERSION    : CRAY MPICH version 7.7.10 (ANL base 3.2)\n"
            if (m = match(r"CRAY MPICH version (\d+.\d+.\d+)", version_string)) !== nothing
                version = VersionNumber(m.captures[1])
            end
        elseif startswith(version_string, "FUJITSU MPI")
            impl = "FujitsuMPI"
            # "FUJITSU MPI Library 4.0.0 (4.0.1fj4.0.0)\0"
            if (m = match(r"^FUJITSU MPI Library (\d+.\d+.\d+)", version_string)) !== nothing
                version = VersionNumber(m.captures[1])
            end
        elseif startswith(version_string, "MPIwrapper")
            impl = "MPIwrapper"
            # MPIwrapper 2.2.2
            if (m = match(r"^MPIwrapper Version:\t(\d+.\d+.\d+\w*)", version_string)) !== nothing
                version = VersionNumber(m.captures[1])
            end
        end
        # 3) determine the abi from the implementation + version
        if (impl == "MPICH" && version >= v"3.1" ||
            impl == "IntelMPI" && version > v"2014" ||
            impl == "MVAPICH" && version >= v"2" ||
            impl == "CrayMPICH" && version >= v"7")
            # https://www.mpich.org/abi/
            abi = "MPICH"
        elseif impl == "OpenMPI" || impl == "IBMSpectrumMPI" || impl == "FujitsuMPI"
            abi = "OpenMPI"
        elseif impl == "MicrosoftMPI"
            abi = "MicrosoftMPI"
        elseif impl == "MPIwrapper"
            abi = "MPItrampoline"
        else
            abi = "unknown"
        end

        @info "MPI implementation" libmpi version_string impl version abi

        if impl == "OpenMPI" && v"4.1.2" ≤ version < v"5"
            # The issue should be fixed in v5: https://github.com/open-mpi/ompi/pull/10185
            @warn """
                It appears you are using OpenMPI v$(version) which is known to be affected by an issue
                which causes segmentation faults when dlclosing libmpi.  If this happens,  export
                the environment variable `ZES_ENABLE_SYSMAN=1` before restarting Julia and trying again.
                See <https://github.com/open-mpi/ompi/issues/10142> for more information.
                """
        end
        Libdl.dlclose(hndl)
    end

    return abi
end

end # module
