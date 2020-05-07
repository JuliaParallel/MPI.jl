const use_stdcall = startswith(basename(libmpi), "msmpi")

macro mpicall(expr)
    @assert expr isa Expr && expr.head == :call && expr.args[1] == :ccall
    # Microsoft MPI uses stdcall calling convention
    # this only affects 32-bit Windows
    # unfortunately we need to use ccall to call Get_library_version
    # so check using library name instead
    if use_stdcall
        insert!(expr.args, 3, :stdcall)
    end
    return esc(expr)
end

function Get_library_version()
    # There is no way to query at runtime what the length of the buffer should be.
    # https://github.com/mpi-forum/mpi-issues/issues/159
    # 8192 is the maximum value of MPI_MAX_LIBRARY_VERSION_STRING across known
    # implementations.
    buf = Array{UInt8}(undef, 8192)
    buflen = Ref{Cint}()

    libfilename, = split(basename(libmpi),'.')
    @mpicall ccall((:MPI_Get_library_version, libmpi), Cint, (Ptr{UInt8}, Ref{Cint}), buf, buflen)
    resize!(buf, buflen[])
    return String(buf)
end

"""
    MPI_LIBRARY_VERSION_STRING :: String

The full version string provided by the library

# External links
$(_doc_external("MPI_Get_library_version"))
"""
const MPI_LIBRARY_VERSION_STRING = Get_library_version()

"""
    MPIImpl

An enum corresponding to known MPI implementations

- `UnknownMPI`: unable to determine MPI implementation
- `MPICH`: [MPICH](https://www.mpich.org/)
- `OpenMPI`: [Open MPI](https://www.open-mpi.org/)
- `MicrosoftMPI`: [Microsoft MPI](https://docs.microsoft.com/en-us/message-passing-interface/microsoft-mpi)
- `IntelMPI`: [Intel MPI](https://software.intel.com/en-us/mpi-library)
- `SpectrimMPI`: [IBM Spectrum MPI](https://www.ibm.com/us-en/marketplace/spectrum-mpi)
- `MVAPICH`: [MVAPICH](http://mvapich.cse.ohio-state.edu/)

# See also

- [`MPI_LIBRARY`](@ref)
"""
@enum MPIImpl begin
    UnknownMPI
    MPICH
    OpenMPI
    MicrosoftMPI
    IntelMPI
    IBMSpectrumMPI
    MVAPICH
    CRAYMPICH
end

"""
    impl, version = identify_implementation()

Attempt to identify the MPI implementation based on
[`MPI_LIBRARY_VERSION_STRING`](@ref). Returns a triple of values:

- `impl`: a value of type [`MPIImpl`](@ref)
- `version`: a `VersionNumber` of the library, or `nothing` if it cannot be determined.

This function is only intended for internal use. Users should use [`MPI_LIBRARY`](@ref),
[`MPI_LIBRARY_VERSION`](@ref).
"""
function identify_implementation()
    impl = UnknownMPI
    version = v"0"

    if startswith(MPI_LIBRARY_VERSION_STRING, "MPICH")
        impl = MPICH
        # "MPICH Version:\t%s\n" /  "MPICH2 Version:\t%s\n"
        if (m = match(r"^MPICH2? Version:\t(\d+.\d+.\d+\w*)\n", MPI_LIBRARY_VERSION_STRING)) !== nothing
            version = VersionNumber(m.captures[1])
        end

    elseif startswith(MPI_LIBRARY_VERSION_STRING, "Open MPI")
        # Open MPI / Spectrum MPI
        impl = occursin("IBM Spectrum MPI", MPI_LIBRARY_VERSION_STRING) ? IBMSpectrumMPI : OpenMPI

        if (m = match(r"^Open MPI v(\d+.\d+.\d+\w*)", MPI_LIBRARY_VERSION_STRING)) !== nothing
            version = VersionNumber(m.captures[1])
        end

    elseif startswith(MPI_LIBRARY_VERSION_STRING, "Microsoft MPI")
        impl = MicrosoftMPI
        # "Microsoft MPI %u.%u.%u.%u%S"
        # ignore last 2 (build numbers)
        if (m = match(r"^Microsoft MPI v(\d+.\d+)", MPI_LIBRARY_VERSION_STRING)) !== nothing
            version = VersionNumber(m.captures[1])
        end

    elseif startswith(MPI_LIBRARY_VERSION_STRING, "Intel")
        impl = IntelMPI

        # TODO: figure out how to parse
        # "Intel(R) MPI Library 2019 Update 4 for Linux* OS"
        if (m = match(r"^Intel\(R\) MPI Library (\d+)", MPI_LIBRARY_VERSION_STRING)) !== nothing
            version = VersionNumber(m.captures[1])
        end

    elseif startswith(MPI_LIBRARY_VERSION_STRING, "MVAPICH2")
        impl = MVAPICH
        # "MVAPICH2 Version      :\t%s\n")
        if (m = match(r"^MVAPICH2? Version\s*:\t(\S*)\n", MPI_LIBRARY_VERSION_STRING)) !== nothing
            version = VersionNumber(m.captures[1])
        end

    elseif occursin("CRAY MPICH", MPI_LIBRARY_VERSION_STRING) 
        impl = CRAYMPICH
        # "MPI VERSION    : CRAY MPICH version 7.7.10 (ANL base 3.2)\n"
        if (m = match(r"CRAY MPICH version (\d+.\d+.\d+) \(ANL base (\d+.\d+)\)\n", MPI_LIBRARY_VERSION_STRING)) !== nothing
            version = VersionNumber(m.captures[1])
            abiversion = VersionNumber(m.captures[2])
            if abiversion >= v"3.1"
                abi = MPICHABI
            end
        end
    end

    return impl, version
end

const MPI_LIBRARY, MPI_LIBRARY_VERSION = identify_implementation()

"""
    MPI_LIBRARY :: MPIImpl

The current MPI implementation: this is determined by

# See also
- [`MPIImpl`](@ref)
"""
MPI_LIBRARY

"""
    MPI_LIBRARY_VERSION :: VersionNumber

The version of the MPI library
"""
MPI_LIBRARY_VERSION


function Get_version()
    major = Ref{Cint}()
    minor = Ref{Cint}()
    @mpicall ccall((:MPI_Get_version, libmpi), Cint,
                   (Ptr{Cint}, Ptr{Cint}), major, minor)
    VersionNumber(major[], minor[])
end

"""
    MPI_VERSION :: VersionNumber

The supported version of the MPI standard.

# External links
$(_doc_external("MPI_Get_version"))
"""
const MPI_VERSION = Get_version()
