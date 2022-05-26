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

macro mpichk(expr, min_ver_expr=v"1.0")
    # This macro can currently just handle ccall expressions.
    @assert expr isa Expr && expr.head == :call && expr.args[1] == :ccall
    
    # A ccall can have either a tuple as its first argument or just the symbol, 
    # if the called function does not have input arguments.
    if expr.args[2].head == :tuple
        mpi_method_name_meta = expr.args[2].args[1]
    elseif expr.args[2].head == :symbol
        mpi_method_name_meta = expr.args[2]
    end

    # Adjust MPI api call to platform-specific details.  
    expr = macroexpand(@__MODULE__, :(@mpicall($expr)))
    
    # Generate the check code
    quote
        # Check if MPI library could be found
        mpihandle = Libc.Libdl.dlopen(libmpi, throw_error=false)
        if mpihandle == nothing
            error("Could not open MPI library '$(libmpi)'")
        end

        # Interpolate symbol from macro into code
        mpi_method_symbol = $(esc(mpi_method_name_meta))

        # If the symbol can be found in the library we make the actual call to the MPI function
        if Libc.Libdl.dlsym(mpihandle, mpi_method_symbol, throw_error=false) != nothing
            # MPI_SUCCESS is defined to be 0
            (errcode = $(esc(expr))) == 0 || throw(MPIError(errcode))
        else # Function was not found in MPI library
            # We first check if the MPI backend does have the minimal version to support the function ...
            mpi_method_name = String(mpi_method_symbol)
            min_ver = $(esc(min_ver_expr))
            cur_ver = MPI.Get_version()
            if cur_ver < min_ver
                throw(MPI.FeatureLevelError(mpi_method_name, min_ver)) 
            end
            # ... and give the user some contxt if the version suites, but the function can still not be found.
            error("Could not call method $(mpi_method_name) for unkown reason. Minimum required version: $min_ver | Version of MPI backend: $cur_ver.")
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
