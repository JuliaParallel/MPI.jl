
function Get_library_version()
    # There is no way to query at runtime what the length of the buffer should be.  
    # https://github.com/mpi-forum/mpi-issues/issues/159    
    # 8192 is the maximum value of MPI_MAX_LIBRARY_VERSION_STRING across known
    # implementations.
    buf = Array{UInt8}(undef, 8192)
    buflen = Ref{Cint}()

    # Microsoft MPI uses stdcall calling convention    
    libfilename, = split(basename(libmpi),'.')    
    if libfilename == "msmpi"
        ccall((:MPI_Get_library_version, libmpi), stdcall, Cint, (Ptr{UInt8}, Ref{Cint}), buf, buflen)
    else
        ccall((:MPI_Get_library_version, libmpi), Cint, (Ptr{UInt8}, Ref{Cint}), buf, buflen)
    end        
    resize!(buf, buflen[])
    return String(buf)
end

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
"""
@enum MPIImpl begin
    UnknownMPI
    MPICH
    OpenMPI
    MicrosoftMPI
    IntelMPI
    IBMSpectrumMPI
    MVAPICH
end

"""
    MPIABI

An enum corresponding to known MPI Application Binary Interfaces (ABI)

- `UnknownABI`: unable to determine MPI ABI
- `MPICHABI`: Compatible with [MPICH ABI Compatibility Initiative](https://www.mpich.org/abi/).
- `OpenMPIABI`: Compatible with Open MPI
- `MicrosftMPIABI`: Compatible with Microsoft MPI
"""
@enum MPIABI begin
    UnknownABI
    MPICHABI
    OpenMPIABI
    MicrosoftMPIABI
end

"""
    impl, version, abi = identify_implementation()

Attempt to identify the MPI implementation based on `MPI_LIBRARY_VERSION_STRING`. Returns
a triple of values:

- `impl`: a value of type [`MPIImpl`](@ref)
- `version`: a `VersionNumber` of the library, or `nothing` if it cannot be determined.
- `abi`: a value of [`MPIABI`](@ref).
"""
function identify_implementation()
    impl = UnknownMPI
    version = nothing
    abi = UnknownABI

    if startswith(MPI_LIBRARY_VERSION_STRING, "MPICH")
        impl = MPICH
        # "MPICH Version:\t%s\n" /  "MPICH2 Version:\t%s\n"
        if (m = match(r"^MPICH2? Version:\t(\d+.\d+.\d+\w*)\n", MPI_LIBRARY_VERSION_STRING)) !== nothing
            version = VersionNumber(m.captures[1])
            if version >= v"3.1"
                abi = MPICHABI
            end
        end        

    elseif startswith(MPI_LIBRARY_VERSION_STRING, "Open MPI")
        # Open MPI / Spectrum MPI
        impl = occursin("IBM Spectrum MPI", MPI_LIBRARY_VERSION_STRING) ? IBMSpectrumMPI : OpenMPI

        if (m = match(r"^Open MPI v(\d+.\d+.\d+\w*)", MPI_LIBRARY_VERSION_STRING)) !== nothing
            version = VersionNumber(m.captures[1])
        end
        abi = OpenMPIABI

    elseif startswith(MPI_LIBRARY_VERSION_STRING, "Microsoft MPI")
        impl = MicrosoftMPI        
        # "Microsoft MPI %u.%u.%u.%u%S"
        # ignore last 2 (build numbers)
        if (m = match(r"^Microsoft MPI v(\d+.\d+)", MPI_LIBRARY_VERSION_STRING)) !== nothing
            version = VersionNumber(m.captures[1])
        end
        abi = MicrosoftMPIABI

    elseif startswith(MPI_LIBRARY_VERSION_STRING, "Intel")
        impl = IntelMPI

        # TODO: figure out how to parse        
        # "Intel(R) MPI Library 2019 Update 4 for Linux* OS"
        if (m = match(r"^Intel\(R\) MPI Library (\d+)", MPI_LIBRARY_VERSION_STRING)) !== nothing
            version = VersionNumber(m.captures[1])
            if version > v"2014"
                abi = MPICHABI
            end
        end

    elseif startswith(MPI_LIBRARY_VERSION_STRING, "MVAPICH2")
        impl = MVAPICH
        # "MVAPICH2 Version      :\t%s\n")
        if (m = match(r"^MVAPICH2? Version\s*:\t(\S*)\n", MPI_LIBRARY_VERSION_STRING)) !== nothing
            version = VersionNumber(m.captures[1])
            if version > v"2"
                abi = MPICHABI
            end
        end
    end

    if (abienv = get(ENV, "JULIA_MPI_ABI", nothing)) !== nothing
        for inst in instances(MPIABI)
            if String(Symbol(inst)) == abienv
                abi = inst                
            end
        end
    end
        
    return impl, version, abi
end

    
const MPI_LIBRARY, MPI_LIBRARY_VERSION, MPI_LIBRARY_ABI = identify_implementation()


function Get_version()
    major = Ref{Cint}()
    minor = Ref{Cint}()
    if MPI_LIBRARY == MicrosoftMPI
        ccall((:MPI_Get_version, libmpi), stdcall, Cint,
              (Ptr{Cint}, Ptr{Cint}), major, minor)
    else
        ccall((:MPI_Get_version, libmpi), Cint,
              (Ptr{Cint}, Ptr{Cint}), major, minor)
    end
    VersionNumber(major[], minor[])
end

const MPI_VERSION = Get_version()
