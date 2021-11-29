
function use_jll_binary(name=nothing)
    # TODO: switch to macro once https://github.com/JuliaPackaging/Preferences.jl/pull/23 is merged
    set_preferences!(@__MODULE__,
        "binary" => name,
        "libmpi" => nothing,
        "abi" => nothing,
        "mpiexec" => nothing,
    )
end

function use_system_binary(;
                           libmpi=find_library(["libmpi", "libmpi_ibm", "msmpi", "libmpich"]),
                           abi=nothing,
                           mpiexec="mpiexec",
                           )

    if abi === nothing
        # There is no way to query at runtime what the length of the buffer should be.
        # https://github.com/mpi-forum/mpi-issues/issues/159
        # 8192 is the maximum value of MPI_MAX_LIBRARY_VERSION_STRING across known
        # implementations.
        buf = Array{UInt8}(undef, 8192)
        buflen = Ref{Cint}()
        dlopen(libmpi) do lib
            fn = dlsym(lib, :MPI_Get_library_version)
            ccall(fn, Cint, (Ptr{UInt8}, Ref{Cint}), buf, buflen)
        end
        resize!(buf, buflen[])
        version_string = String(buf)

        impl, version = identify_implementation(version_string)
        abi = identify_abi(impl, version)
        if abi == "unknown"
            error("Could not automatically identify MPI ABI")
        end
    end
    if abi ∉ ["MPICH", "OpenMPI", "MicrosoftMPI"]
        error("invalid abi argument $abi; must be one of MPICH, OpenMPI or MicrosoftMPI")
    end
    set_preferences!(@__MODULE__,
        "binary" => "system",
        "libmpi" => libmpi,
        "abi" => abi,
        "mpiexec" => mpiexec,
    )
end
