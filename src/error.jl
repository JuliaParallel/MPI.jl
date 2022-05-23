struct MPIError <: Exception
    code::Cint
end


"""
    FeatureLevelError

This error is thrown if a feature is not implemented in the current MPI backend.
"""
struct FeatureLevelError <: Exception
    min_feature_level::VersionNumber # minimal MPI version required for this feature to be available
end


macro mpichk(expr)
    expr = macroexpand(@__MODULE__, :(@mpicall($expr)))
    # MPI_SUCCESS is defined to be 0
    :((errcode = $(esc(expr))) == 0 || throw(MPIError(errcode)))
end


function error_string(err::MPIError)
    len_ref = Ref{Cint}()
    str_buf = Vector{UInt8}(undef, Consts.MPI_MAX_ERROR_STRING)
    # int MPI_Error_string(int errorcode, char *string, int *resultlen)
    @mpichk ccall((:MPI_Error_string, libmpi), Cint,
                  (Cint, Ptr{UInt8}, Ref{Cint}), err.code, str_buf, len_ref)
    resize!(str_buf, len_ref[])
    return String(str_buf)
end

function Base.show(io::IO, err::MPIError)
    print(io, "MPIError(", err.code, "): ", error_string(err))
end
