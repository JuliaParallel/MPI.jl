@mpi_handle Datatype

const DATATYPE_NULL = _Datatype(MPI_DATATYPE_NULL)
Datatype() = Datatype(DATATYPE_NULL.val)

const MPIInteger = Union{Int8, UInt8, Int16, UInt16, Int32, UInt32, Int64, UInt64}
const MPIFloatingPoint = Union{Float32, Float64}
const MPIComplex = Union{ComplexF32, ComplexF64}

const MPIDatatype = Union{Char,
                            Int8, UInt8, Int16, UInt16, Int32, UInt32, Int64,
                            UInt64,
                            Float32, Float64, ComplexF32, ComplexF64}
MPIBuffertype{T} = Union{Ptr{T}, Array{T}, SubArray{T}, Ref{T}}

MPIBuffertypeOrConst{T} = Union{MPIBuffertype{T}, SentinelPtr}

Base.cconvert(::Type{MPIPtr}, x::Union{Ptr{T}, Array{T}, Ref{T}}) where T = Base.cconvert(Ptr{T}, x)
function Base.cconvert(::Type{MPIPtr}, x::SubArray{T}) where T
    @assert Base.iscontiguous(x)
    Base.cconvert(Ptr{T}, x)
end
function Base.unsafe_convert(::Type{MPIPtr}, x::MPIBuffertype{T}) where T
    ptr = Base.unsafe_convert(Ptr{T}, x)
    reinterpret(MPIPtr, ptr)
end

fieldoffsets(::Type{T}) where {T} = Int[fieldoffset(T, i) for i in 1:length(fieldnames(T))]

# Define a function mpitype(T) that returns the MPI datatype code for
# a given type T. In the case the the type does not exist, it is created and
# then returned. The dictonary is defined in __init__ so the module can be
# precompiled

# accessor and creation function for getting MPI datatypes
function mpitype(::Type{T}) where T
    get!(mpitype_dict, T) do
        if !isbitstype(T)
            throw(ArgumentError("Type must be isbitstype()"))
        end

        # get the data from the type
        fieldtypes = T.types
        offsets = fieldoffsets(T)
        nfields = Cint(length(fieldtypes))

        if nfields == 0  # primitive type
            if sizeof(T) == 0
                error("Can't convert 0-size type to MPI")
            end
            nfields, blocklengths, displacements, types = factorPrimitiveType(T)
        else  # struct
            # put data in MPI format
            blocklengths = ones(Cint, nfields)
            displacements = zeros(Cptrdiff_t, nfields)  # size_t == MPI_Aint ?
            types = Array{MPI_Datatype}(undef, nfields)
            for i=1:nfields
                displacements[i] = offsets[i]
                # create an MPI_Datatype for the current field if it does not exist yet
                types[i] = mpitype(fieldtypes[i])
            end

        end
        newtype = Type_Create_Struct(nfields, blocklengths, displacements, types)

        # commit the datatatype
        Type_Commit!(newtype)
        return newtype.val
    end
end


function factorPrimitiveType(::Type{T}) where {T}

  tsize = sizeof(T)  # size in bytes
  displacements = zeros(Cptrdiff_t, 0)  # size_t == MPI_Aint ?
  types = MPI_Datatype[]

  # put largest sizes first
  mpi_types = [mpitype(Int64), mpitype(Int32), mpitype(Int16), mpitype(Int8)]
  mpi_sizes = [8, 4, 2, 1]
  curr_disp = 0

  while curr_disp != tsize
    remsize = tsize - curr_disp
    for i=1:length(mpi_types)
      size_i = mpi_sizes[i]
      # because each size is a multiple of the smaller sizes, taking the largest
      # size always results in the smallest number of types and doesn't result
      # in avoidable small remainders
      if remsize >= size_i
        push!(types, mpi_types[i])
        push!(displacements, curr_disp)
        curr_disp += size_i
        break
      end
    end
  end

  nfields = length(types)
  blocklengths = ones(Cint, nfields)

  return nfields, blocklengths, displacements, types
end


function Type_Create_Struct(nfields::Integer, blocklengths::MPIBuffertype{Cint},
                            displacements::MPIBuffertype{Cptrdiff_t},
                            types::MPIBuffertype{MPI_Datatype})

    newtype = Datatype()

    # int MPI_Type_create_struct(int count, const int array_of_blocklengths[],
    #                            const MPI_Aint array_of_displacements[],
    #                            const MPI_Datatype array_of_types[], MPI_Datatype *newtype)
    @mpichk ccall((:MPI_Type_create_struct, libmpi), Cint,
                  (Cint, Ptr{Cint}, Ptr{Cptrdiff_t}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}),
                  nfields, blocklengths, displacements, types, newtype)
    return newtype
end

"""
    Type_Create_Subarray(ndims::Integer, array_of_sizes::MPIBuffertype{Cint},
                         array_of_subsizes::MPIBuffertype{Cint},
                         array_of_starts::MPIBuffertype{Cint}, order::Integer, oldtype)

Creates a data type describing an `ndims`-dimensional subarray of size `array_of_subsizes`
of an `ndims-dimensional` array of size `array_of_sizes` and element type `oldtype`,
starting at the top-left location `array_of_starts`. The parameter `order` refers to
the memory layout of the parent array, and can be either `MPI_ORDER_C` or
`MPI_ORDER_FORTRAN`. Note that, like other MPI data types, the type returned by this
function should be committed with `MPI_Type_commit`.
"""
function Type_Create_Subarray(ndims::Integer,
                              array_of_sizes::MPIBuffertype{Cint},
                              array_of_subsizes::MPIBuffertype{Cint},
                              array_of_starts::MPIBuffertype{Cint},
                              order::Integer,
                              oldtype)

    newtype = Datatype()
    @mpichk ccall((:MPI_Type_create_subarray, libmpi), Cint,
        (Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint, MPI_Datatype, Ptr{MPI_Datatype}),
        ndims, array_of_sizes, array_of_subsizes, array_of_starts,
        order, mpitype(oldtype), newtype)
    return newtype
end

function Type_Contiguous(count::Integer, oldtype)
    newtype = Datatype()
    @mpichk ccall((:MPI_Type_contiguous, libmpi), Cint,
                  (Cint, MPI_Datatype, Ptr{MPI_Datatype}),
                  count, oldtype, newtype)
    return newtype
end

function Type_Commit!(newtype::Datatype)
    # int MPI_Type_commit(MPI_Datatype *datatype)
    @mpichk ccall((:MPI_Type_commit, libmpi), Cint,
                  (Ptr{MPI_Datatype},), newtype)
end


"""
  Setter function for mpitype_dict and mpitype_dict_inverse
"""
function recordDataType(T::DataType, mpiT::MPI_Datatype)

  if !haskey(mpitype_dict, T)
      mpitype_dict[T] = mpiT
  end

  if !haskey(mpitype_dict_inverse, mpiT)
      mpitype_dict_inverse[mpiT] = T
  end

  return nothing
end
recordDataType(T::DataType, dtyp::Datatype) = recordDataType(T, dtyp.val)


const mpitype_dict = Dict{DataType, MPI_Datatype}()
const mpitype_dict_inverse = Dict{MPI_Datatype, DataType}()

function init_datatypes()
    if Sys.iswindows() || MPI_VERSION >= v"2.2"
        # use specific-width types if available
        for (T, c) in [
            Int8 => MPI_INT8_T,
            UInt8 => MPI_UINT8_T,
            Int16 => MPI_INT16_T,
            UInt16 => MPI_UINT16_T,
            Int32 => MPI_INT32_T,
            UInt32 => MPI_UINT32_T,
            Int64 => MPI_INT64_T,
            UInt64 => MPI_UINT64_T,
            ComplexF32 => MPI_C_FLOAT_COMPLEX,
            ComplexF64 => MPI_C_DOUBLE_COMPLEX,
        ]
            recordDataType(T, MPI_Datatype(c))
        end
    end

    for (T, c) in [
        UInt8 => MPI_BYTE,
        Cshort => MPI_SHORT,
        Cushort => MPI_UNSIGNED_SHORT,
        Cint => MPI_INT,
        Cuint => MPI_UNSIGNED,
        Clong => MPI_LONG,
        Culong => MPI_UNSIGNED_LONG,
        Cchar => MPI_CHAR,
        Cchar => MPI_SIGNED_CHAR,
        Cuchar => MPI_UNSIGNED_CHAR,
        Cwchar_t => MPI_WCHAR,
        Float32 => MPI_FLOAT,
        Float64 => MPI_DOUBLE,

        Char => MPI_UNSIGNED,
    ]
        recordDataType(T, MPI_Datatype(c))
    end
end

push!(mpi_init_hooks, init_datatypes)

function Get_address(location::MPIBuffertype{T}) where T
    addr = Ref{Cptrdiff_t}(0)
    @mpichk ccall((:MPI_Get_address, libmpi), Cint, (Ptr{T}, Ref{Cptrdiff_t}), location, addr)
    return addr[]
end
