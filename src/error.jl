
function error_string(err::MPIError)
    len_ref = Ref{Cint}()
    str_buf = Vector{UInt8}(undef, API.MPI_MAX_ERROR_STRING)
    # int MPI_Error_string(int errorcode, char *string, int *resultlen)
    API.MPI_Error_string(err.code, str_buf, len_ref)
    resize!(str_buf, len_ref[])
    return String(str_buf)
end
