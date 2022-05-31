const use_stdcall = startswith(basename(libmpi), "msmpi")

# This is required in addition to __init__() so that we can call library at precompilation time.
if Sys.isunix()
    Libdl.dlopen(libmpi, Libdl.RTLD_LAZY | Libdl.RTLD_GLOBAL)
end

macro mpicall(expr)
    @assert expr isa Expr && expr.head == :call && expr.args[1] == :ccall

    # On unix systems we call the global symbols to allow for LD_PRELOAD interception
    # It can be emulated in Windows (via Libdl.dllist), but this is not fast.
    if Sys.isunix() && expr.args[2].head == :tuple &&
            (VERSION ≥ v"1.5-" || expr.args[2].args[1] ≠ :(:MPI_Get_library_version))
        expr.args[2] = expr.args[2].args[1]
    end

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

    @mpicall ccall((:MPI_Get_library_version, libmpi), Cint, (Ptr{UInt8}, Ref{Cint}), buf, buflen)
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
