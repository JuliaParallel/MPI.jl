struct MPIError <: Exception
    code::Cint
end

macro mpichk(expr)
    @assert expr isa Expr && expr.head == :call && expr.args[1] == :ccall
    if Sys.iswindows()
        insert!(expr.args, 3, :stdcall)
    end
    :((errcode = $(esc(expr))) == MPI_SUCCESS || throw(MPIError(errcode)))
end


function error_string(err::MPIError)
    len_ref = Ref{Cint}()
    str_buf = Vector{UInt8}(undef, MPI_MAX_ERROR_STRING)
    # int MPI_Error_string(int errorcode, char *string, int *resultlen)
    @mpichk ccall((:MPI_Error_string, libmpi), Cint,
                  (Cint, Ptr{UInt8}, Ref{Cint}), err.code, str_buf, len_ref)
    resize!(str_buf, len_ref[])
    return String(str_buf)
end

function Base.show(io::IO, err::MPIError)
    print(io, "MPIError(", err.code, "): ", error_string(err))
end
