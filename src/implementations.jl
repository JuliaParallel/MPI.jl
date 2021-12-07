using Preferences

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
    if abi == "MicrosoftMPI"
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


function Get_version()
    major = Ref{Cint}()
    minor = Ref{Cint}()
    @mpicall ccall((:MPI_Get_version, libmpi), Cint,
                   (Ptr{Cint}, Ptr{Cint}), major, minor)
    VersionNumber(major[], minor[])
end

