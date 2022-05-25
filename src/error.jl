struct MPIError <: Exception
    code::Cint
end


"""
    FeatureLevelError

This error is thrown if a feature is not implemented in the current MPI backend.
"""
struct FeatureLevelError <: Exception
    function_name::String
    min_feature_level::VersionNumber # minimal MPI version required for this feature to be available
end

function Base.show(io::IO, err::FeatureLevelError)
    print(io, "FeatureLevelError($(err.function_name)): Minimum version is $(err.min_feature_level)")
end

macro mpichk(expr, min_ver=v"1.0")
    expr = macroexpand(@__MODULE__, :(@mpicall($expr)))
    quote 
        try
            # MPI_SUCCESS is defined to be 0
            (errcode = $(esc(expr))) == 0 || throw(MPIError(errcode))
        catch e
            typeof(e) != ErrorException && rethrow()
            mpi_method_name = String($(esc(expr.args[2])))
            if contains(e.msg, "could not load symbol") && contains(e.msg, mpi_method_name) && MPI.Get_version() < $(esc(min_ver))
                throw(MPI.FeatureLevelError(mpi_method_name, $(esc(min_ver))))
            end
            rethrow()
        end
    end
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
