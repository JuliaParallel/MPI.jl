module MPIPreferences

using Preferences, Libdl

"""
    MPIPreferences.binary :: String

The currently selected binary. The possible values are

- `"MPICH_jll"`: use the binary provided by [MPICH_jll](https://github.com/JuliaBinaryWrappers/MPICH_jll.jl)
- `"OpenMPI_jll"`: use the binary provided by [OpenMPI_jll](https://github.com/JuliaBinaryWrappers/OpenMPI_jll.jl)
- `"MicrosoftMPI_jll"`: use binary provided by [MicrosoftMPI_jll](https://github.com/JuliaBinaryWrappers/MicrosoftMPI_jll.jl/)
- `"MPItrampoline_jll"`: use the binary provided by [MPItrampoline_jll](https://github.com/JuliaBinaryWrappers/MPItrampoline_jll.jl/)
- `"system"`: use a system-provided binary.

"""
const binary = @load_preference("binary", Sys.iswindows() ? "MicrosoftMPI_jll" : "MPICH_jll")

"""
    MPIPreferences.abi :: String

The ABI of the currently selected binary. Supported values are:

- `"MPICH"`: MPICH-compatible ABI (https://www.mpich.org/abi/)
- `"OpenMPI"`: Open MPI compatible ABI (Open MPI, IBM Spectrum MPI, Fujitsu MPI)
- `"MicrosoftMPI"`: Microsoft MPI
- `"MPItrampoline"`: MPItrampoline
- `"HPE MPT"`: HPE MPT
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

@static if binary == "system"
    include("system.jl")
end

"""
    MPIPreferences.use_jll_binary(binary; export_prefs=false, force=true)

Switches the underlying MPI implementation to one provided by JLL packages.
Available options are:
- `"MicrosoftMPI_jll"` (Only option and default on Winddows)
- `"MPICH_jll"` (Default on all other platform)
- `"OpenMPI_jll"`
- `"MPItrampoline_jll"`

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
    MPIPreferences.use_system_binary(;
        library_names = ["libmpi", "libmpi_ibm", "msmpi", "libmpich", "libmpi_cray", "libmpitrampoline"],
        mpiexec = "mpiexec",
        abi = nothing,
        export_prefs = false,
        force = true)

Switches the underlying MPI implementation to a system provided one.

Options:

- `library_names`: a name or collection of names of the MPI library, passed to
  [`Libdl.find_library`](https://docs.julialang.org/en/v1/stdlib/Libdl/#Base.Libc.Libdl.find_library).
  If the library isn't in the library search path, you can specify the full path
  to the library.

- `mpiexec`: the MPI launcher executable. The default is `mpiexec`, but some
  clusters require using the scheduler launcher interface (e.g. `srun` on Slurm,
  `aprun` on PBS). It is also possible to pass a [`Cmd`
  object](https://docs.julialang.org/en/v1/manual/running-external-programs/#Cmd-Objects)
  to include specific command line options.

- `abi`: the ABI of the MPI library. By default this is determined automatically
  using [`identify_abi`](@ref). See [`abi`](@ref) for currently supported values.

- `export_prefs`: if `true`, the preferences into the `Project.toml` instead of `LocalPreferences.toml`.

- `force`: if `true`, the preferences are set even if they are already set.
"""
function use_system_binary(;
        library_names=["libmpi", "libmpi_ibm", "msmpi", "libmpich", "libmpi_cray", "libmpitrampoline"],
        mpiexec="mpiexec",
        abi=nothing,
        export_prefs=false,
        force=true,
    )
    binary = "system"
    # Set `ZES_ENABLE_SYSMAN` to work around https://github.com/open-mpi/ompi/issues/10142
    libmpi = withenv("ZES_ENABLE_SYSMAN" => "1") do
        find_library(library_names)
    end
    if libmpi == ""
        error("""
            MPI library could not be found with the following name(s):
                $(library_names)
            If you want to try different name(s) for the MPI library, use
                MPIPreferences.use_system_binary(; library_names=[...])""")
    end
    if isnothing(abi)
        abi = identify_abi(libmpi)
    end
    if mpiexec isa Cmd
        mpiexec = collect(mpiexec)
    end
    set_preferences!(MPIPreferences,
        "binary" => binary,
        "libmpi" => libmpi,
        "abi" => abi,
        "mpiexec" => mpiexec,
        export_prefs=export_prefs,
        force=force
    )

    @warn "The underlying MPI implementation has changed. You will need to restart Julia for this change to take effect" binary libmpi abi mpiexec

    if VERSION <= v"1.6.5" || VERSION == v"1.7.0"
        @warn """
        Due to a bug in Julia (until 1.6.5 and 1.7.1), setting preferences in transitive dependencies
        is broken (https://github.com/JuliaPackaging/Preferences.jl/issues/24). To fix this either update
        your version of Julia, or add MPIPreferences as a direct dependency to your project.
        """
    end

    return nothing
end

function identify_implementation_version_abi(version_string::AbstractString)
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

    elseif startswith(version_string, "HPE MPT")
        impl = "HPE MPT"
        # HPE MPT 2.23  08/26/20 02:54:49-root
        if (m = match(r"^HPE MPT (\d+.\d+)", version_string)) !== nothing
            version = VersionNumber(m.captures[1])
        end

    elseif startswith(version_string, "HPE HMPT")
        impl = "HPE HMPT"
        # HPE HMPT 2.23  08/26/20 02:59:48-root
        if (m = match(r"^HPE HMPT (\d+.\d+)", version_string)) !== nothing
            version = VersionNumber(m.captures[1])
        end
    end

    # 3) determine the abi from the implementation + version
    if (impl == "MPICH" && version >= v"3.1" ||
        impl == "IntelMPI" && version > v"2014" ||
        impl == "MVAPICH" && version >= v"2" ||
        impl == "CrayMPICH" && version >= v"7" ||
        # https://www.mpich.org/abi/
        impl == "HPE HMPT")
        abi = "MPICH"
    elseif impl == "OpenMPI" || impl == "IBMSpectrumMPI" || impl == "FujitsuMPI"
        abi = "OpenMPI"
    elseif impl == "MicrosoftMPI"
        abi = "MicrosoftMPI"
    elseif impl == "MPIwrapper"
        abi = "MPItrampoline"
    elseif impl == "HPE MPT"
        abi = "HPE MPT"
    else
        abi = "unknown"
    end

    return (impl, version, abi)
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

    hndl = @static if Sys.isunix()
        # Again, work around https://github.com/open-mpi/ompi/issues/10142
        withenv("ZES_ENABLE_SYSMAN" => "1") do
            # need to open libmpi with RTLD_GLOBAL flag for Linux, before
            # any ccall cannot use RTLD_DEEPBIND; this leads to segfaults
            # at least on Ubuntu 15.10
            Libdl.dlopen(libmpi, Libdl.RTLD_LAZY | Libdl.RTLD_GLOBAL)
        end
    else
        Libdl.dlopen(libmpi)
    end

    try
        ptr = dlsym(hndl, :MPI_Get_library_version)
        ccall(ptr, Cint, (Ptr{UInt8}, Ref{Cint}), buf, buflen)
    finally
        Libdl.dlclose(hndl)
    end

    @assert buflen[] < 8192
    resize!(buf, buflen[])
    version_string = String(buf)

    # 2) try to identify the MPI implementation
    impl, version, abi = identify_implementation_version_abi(version_string)

    @info "MPI implementation" libmpi version_string impl version abi

    return abi
end

end # module
