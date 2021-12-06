"""
    impl, version = identify_implementation(version_string)

Attempt to identify the MPI implementation based on
[`MPI_LIBRARY_VERSION_STRING`](@ref). Returns a tuple of values:

- `impl`: a value of type [`MPIImpl`](@ref)
- `version`: a `VersionNumber` of the library, or `nothing` if it cannot be determined.

This function is only intended for internal use. Users should use [`MPI_LIBRARY`](@ref),
[`MPI_LIBRARY_VERSION`](@ref).
"""
function identify_implementation(version_string::String)
    impl = "UnknownMPI"
    version = v"0"

    if startswith(version_string, "MPICH")
        impl = "MPICH"
        # "MPICH Version:\t%s\n" /  "MPICH2 Version:\t%s\n"
        if (m = match(r"^MPICH2? Version:\t(\d+.\d+.\d+\w*)\n", version_string)) !== nothing
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

    return impl, version
end
identify_implementation() = identify_implementation(Get_library_version())

function identify_abi(impl::String, version::VersionNumber)
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
end

identify_abi() = identify_abi(identify_implementation()...)
