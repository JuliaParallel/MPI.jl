
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

"""
    MPI_VERSION :: VersionNumber

The supported version of the MPI standard.

# External links
$(_doc_external("MPI_Get_version"))
"""
const MPI_VERSION = Get_version()

using PkgVersion
"""
    MPI.versioninfo()

Print a summary of the curent MPI configuration.
"""
function versioninfo()
    println("MPIPreferences:")
    println("  binary:  ", MPIPreferences.binary)
    println("  abi:     ", MPIPreferences.abi)
    if MPIPreferences.binary == "system"
        println("  libmpi:  ", MPIPreferences.System.libmpi)
        println("  mpiexec: ", MPIPreferences.System.mpiexec_path)
    end
    println()
    println("Package versions")
    println("  MPI.jl:             ", PkgVersion.@Version)
    println("  MPIPreferences.jl:  ", PkgVersion.Version(MPIPreferences))
    if MPIPreferences.binary == "MPICH_jll"
        println("  MPICH_jll:          ", PkgVersion.Version(API.MPICH_jll))
    elseif MPIPreferences.binary == "OpenMPI_jll"
        println("  OpenMPI_jll:        ", PkgVersion.Version(API.OpenMPI_jll))
    elseif MPIPreferences.binary == "OpenMPI_jll"
        println("  OpenMPI_jll:        ", PkgVersion.Version(API.OpenMPI_jll))
    elseif MPIPreferences.binary == "MicrosoftMPI_jll"
        println("  MicrosoftMPI_jll:   ", PkgVersion.Version(API.MicrosoftMPI_jll))
    elseif MPIPreferences.binary == "MPItrampoline_jll"
        println("  MPItrampoline_jll   ", PkgVersion.Version(API.MPItrampoline_jll))
    end
        
    println()
    println("Library information:")
    println("  libmpi:  ", API.libmpi)
    println("  MPI version:  ", Get_version())
    println("  Library version:  ")
    for line in split(Get_library_version(), '\n')
        println("    ", line)
    end
end