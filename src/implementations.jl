
# This is required in addition to __init__() so that we can call library at precompilation time.
if Sys.isunix()
    Libdl.dlopen(libmpi, Libdl.RTLD_LAZY | Libdl.RTLD_GLOBAL)
end


function Get_library_version()
    # There is no way to query at runtime what the length of the buffer should be.
    # https://github.com/mpi-forum/mpi-issues/issues/159
    # 8192 is the maximum value of MPI_MAX_LIBRARY_VERSION_STRING across known
    # implementations.
    buf = Array{UInt8}(undef, 8192)
    buflen = Ref{Cint}()

    API.MPI_Get_library_version(buf, buflen)
    @assert buflen[] < 8192
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
    impl, version = identify_implementation()

Attempt to identify the MPI implementation based on
[`MPI_LIBRARY_VERSION_STRING`](@ref). Returns a triple of values:

- `impl`: a `String` with the name of the MPI implementation, or `"unknown"` if it cannot be determined,
- `version`: a `VersionNumber` of the library, or `nothing` if it cannot be determined.

This function is only intended for internal use. Users should use [`MPI_LIBRARY`](@ref),
[`MPI_LIBRARY_VERSION`](@ref).
"""
function identify_implementation()
    impl, version, abi = MPIPreferences.identify_implementation_version_abi(MPI_LIBRARY_VERSION_STRING)
    return impl, version
end

const MPI_LIBRARY, MPI_LIBRARY_VERSION = identify_implementation()

"""
    MPI_LIBRARY :: String

The current MPI implementation: this is determined by
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
    API.MPI_Get_version(major, minor)
    VersionNumber(major[], minor[])
end

function Abi_get_version()
    major = Ref{Cint}()
    minor = Ref{Cint}()
    API.MPI_Abi_get_version(major, minor)
    VersionNumber(major[], minor[])
end

"""
    MPI_VERSION :: VersionNumber

The supported version of the MPI standard.

# External links
$(_doc_external("MPI_Get_version"))
"""
const MPI_VERSION = Get_version()

using PkgVersion
"""
    MPI.versioninfo(io::IO=stdout)

Print a summary of the current MPI configuration.
"""
function versioninfo(io::IO=stdout)
    println(io, "MPIPreferences:")
    println(io, "  binary:  ", MPIPreferences.binary)
    println(io, "  abi:     ", MPIPreferences.abi)
    if MPIPreferences.binary == "system"
        println(io, "  libmpi:  ", MPIPreferences.System.libmpi)
        println(io, "  mpiexec: ", MPIPreferences.System.mpiexec_path)
    end
    println(io)
    println(io, "Package versions")
    println(io, "  MPI.jl:             ", PkgVersion.@Version)
    println(io, "  MPIPreferences.jl:  ", PkgVersion.Version(MPIPreferences))
    if MPIPreferences.binary == "MPIABI_jll"
        println(io, "  MPIABI_jll:          ", PkgVersion.Version(API.MPICH_jll))
    elseif MPIPreferences.binary == "MPICH_jll"
        println(io, "  MPICH_jll:          ", PkgVersion.Version(API.MPICH_jll))
    elseif MPIPreferences.binary == "MPItrampoline_jll"
        println(io, "  MPItrampoline_jll   ", PkgVersion.Version(API.MPItrampoline_jll))
    elseif MPIPreferences.binary == "MicrosoftMPI_jll"
        println(io, "  MicrosoftMPI_jll:   ", PkgVersion.Version(API.MicrosoftMPI_jll))
    elseif MPIPreferences.binary == "OpenMPI_jll"
        println(io, "  OpenMPI_jll:        ", PkgVersion.Version(API.OpenMPI_jll))
    end

    println(io)
    println(io, "Library information:")
    println(io, "  libmpi:  ", API.libmpi)
    println(io, "  libmpi dlpath:  ", Libdl.dlpath(API.libmpi))
    println(io, "  MPI version:  ", Get_version())
    println(io, "  Library version:  ")
    for line in split(Get_library_version(), '\n')
        println(io, "    ", line)
    end
    println(io, "  MPI launcher: ", mpiexec()[1])
    mpiexec_path = Sys.which(mpiexec()[1])
    if !isnothing(mpiexec_path)
        println(io, "  MPI launcher path: ", mpiexec_path)
    end
end
