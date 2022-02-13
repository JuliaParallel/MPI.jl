module MPIPreferences

using Preferences, Libdl

const binary = @load_preference("binary", Sys.iswindows() ? "MicrosoftMPI_jll" : "MPICH_jll")

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
    using Preferences
    const libmpi = @load_preference("libmpi")
    const mpiexec_path = @load_preference("mpiexec")
    mpiexec() = `$mpiexec_path`
    mpiexec(f) = f(`$mpiexec_path`)
end

function use_jll_binary(binary = Sys.iswindows() ? "MicrosoftMPI_jll" : "MPICH_jll")
    binary in ["MicrosoftMPI_jll", "MPICH_jll", "OpenMPI_jll", "MPItrampoline_jll"] ||
        error("Unknown jll: $binary")
    @set_preferences!(
        "binary" => binary,
        "libmpi" => nothing,
        "abi" => nothing,
        "mpiexec" => nothing
    )
end

function use_system_binary(;
        library=["libmpi", "libmpi_ibm", "msmpi", "libmpich", "libmpitrampoline"],
        mpiexec="mpiexec",
        abi=nothing,
    )

    libmpi = find_library(library)
    if libmpi == ""
        error("MPI library could not be found")
    end
    if isnothing(abi)
        versionstring = Get_library_version(libmpi)
        impl, version = identify_implementation(versionstring)
        abi = identify_abi(impl, version)
    end
    if mpiexec isa Cmd
        mpiexec = collect(mpiexec)
    end
    @set_preferences!(
        "binary" => "system",
        "libmpi" => libmpi,
        "abi" => abi,
        "mpiexec" => mpiexec,
    )
end


function Get_library_version(libmpi)
    # There is no way to query at runtime what the length of the buffer should be.
    # https://github.com/mpi-forum/mpi-issues/issues/159
    # 8192 is the maximum value of MPI_MAX_LIBRARY_VERSION_STRING across known
    # implementations.
    buf = Array{UInt8}(undef, 8192)
    buflen = Ref{Cint}()
    dlopen(libmpi) do hdl
        ptr = dlsym(hdl, :MPI_Get_library_version)
        ccall(ptr, Cint, (Ptr{UInt8}, Ref{Cint}), buf, buflen)
    end

    @assert buflen[] < 8192
    resize!(buf, buflen[])
    return String(buf)
end


"""
    identify_abi(version_string)

Identify the MPI implementation from the library version string
"""
function identify_abi(version_string::String)
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
    end

    # determine the abi from the implementation + version
    if (impl == "MPICH" && version >= v"3.1" ||
        impl == "IntelMPI" && version > v"2014" ||
        impl == "MVAPICH" && version >= v"2" ||
        impl == "CrayMPICH" && version >= v"7")
        # https://www.mpich.org/abi/
        abi = "MPICH"
    elseif impl == "OpenMPI" || impl == "IBMSpectrumMPI"
        abi = "OpenMPI"
    elseif impl == "MicrosoftMPI"
        abi = "MicrosoftMPI"
    else
        abi = "unknown"
    end
    return abi
end

end # module
