"""
    Datatype

A `Datatype` represents the layout of the data in memory.

# Usage

    Datatype(T; commit=true)

Either return the predefined `Datatype` or create a new `Datatype` for the Julia type
`T`. If `commit=true`, then the [`Types.commit!`](@ref) operation will also be applied so
that it can be used for communication operations.

Note that this can only be called on types for which `isbitstype(T)` is `true`.
"""
@mpi_handle Datatype MPI_Datatype

const DATATYPE_NULL = _Datatype(MPI_DATATYPE_NULL)
Datatype() = Datatype(DATATYPE_NULL.val)

function free(dt::Datatype)
    if dt.val != DATATYPE_NULL.val && !Finalized()
        @mpichk ccall((:MPI_Type_free, libmpi), Cint, (Ptr{MPI_Datatype},), dt)
    end
    return nothing
end

for (mpiname, T) in [
    :INT8_T            => Int8
    :UINT8_T           => UInt8
    :INT16_T           => Int16
    :UINT16_T          => UInt16
    :INT32_T           => Int32
    :UINT32_T          => UInt32
    :INT64_T           => Int64
    :UINT64_T          => UInt64
    :BYTE              => UInt8
    :SHORT             => Cshort
    :UNSIGNED_SHORT    => Cushort
    :INT               => Cint
    :UNSIGNED          => Cuint
    :LONG              => Clong
    :UNSIGNED_LONG     => Culong
    :CHAR              => Cchar
    :SIGNED_CHAR       => Cchar
    :UNSIGNED_CHAR     => Cuchar
    :WCHAR             => Cwchar_t
    :FLOAT             => Float32
    :DOUBLE            => Float64
    :C_FLOAT_COMPLEX   => ComplexF32
    :C_DOUBLE_COMPLEX  => ComplexF64]

    @eval if @isdefined($(Symbol(:MPI_,mpiname)))
        const $mpiname = _Datatype($(Symbol(:MPI_,mpiname)))
        if !hasmethod(Datatype, Tuple{Type{$T}})
            Datatype(::Type{$T}; commit=true) = $mpiname
        end
    end
end
    
module Types

import MPI
import MPI: @mpichk, libmpi, _doc_external,
    Datatype, MPI_Datatype, MPI_Aint,
    free

"""
    lb, extent = MPI.Types.extent(dt::MPI.Datatype)

Gets the lowerbound `lb` and the extent `extent` in bytes.

# External links
$(_doc_external("MPI_Type_get_extent"))
"""
function extent(dt::Datatype)
    lb = Ref{MPI_Aint}()
    extent = Ref{MPI_Aint}()
    # int MPI_Type_get_extent(MPI_Datatype datatype, MPI_Aint *lb,
    #          MPI_Aint *extent)
    @mpichk ccall((:MPI_Type_get_extent, libmpi), Cint,
                  (MPI_Datatype, Ptr{MPI_Aint}, Ptr{MPI_Aint}),
                  dt, lb, extent)
    return lb[], extent[]
end

"""
    MPI.Types.create_contiguous(count::Integer, oldtype::MPI.Datatype)

Create a derived [`Datatype`](@ref) that replicates `oldtype` into `count` contiguous locations.

Note that [`MPI.Types.commit!`](@ref) must be used before the datatype can be used for
communication.

# External links
$(_doc_external("MPI_Type_contiguous"))
"""
function create_contiguous(count::Integer, oldtype::Datatype)
    newtype = Datatype()
    @mpichk ccall((:MPI_Type_contiguous, libmpi), Cint,
                  (Cint, MPI_Datatype, Ptr{MPI_Datatype}),
                  count, oldtype, newtype)
    finalizer(free, newtype)
    return newtype
end


"""
    MPI.Types.create_vector(count::Integer, blocklength::Integer, stride::Integer, oldtype::MPI.Datatype)

Create a derived [`Datatype`](@ref) that replicates `oldtype` into locations that
consist of equally spaced blocks. 

Note that [`MPI.Types.commit!`](@ref) must be used before the datatype can be used for
communication.

# Example

```julia
datatype = MPI.Types.create_vector(3, 2, 5, MPI.Datatype(Int64))
MPI.Types.commit!(datatype)
```
will create a datatype with the following layout
```
|<----->|  block length

+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| X | X |   |   |   | X | X |   |   |   | X | X |   |   |   |
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+

|<---- stride ----->|
```
where each segment represents an `Int64`.

(image by Jonathan Dursi, <https://stackoverflow.com/a/10788351/392585>)

# External links
$(_doc_external("MPI_Type_vector"))
"""
function create_vector(count::Integer, blocklength::Integer, stride::Integer, oldtype::Datatype)
    newtype = Datatype()
    # int MPI_Type_vector(int count, int blocklength, int stride,
    #          MPI_Datatype oldtype, MPI_Datatype *newtype)
    @mpichk ccall((:MPI_Type_vector, libmpi), Cint,
                  (Cint, Cint, Cint, MPI_Datatype, Ptr{MPI_Datatype}),
                  count, blocklength, stride, oldtype, newtype)
    finalizer(free, newtype)
    return newtype
end

"""
    MPI.Types.create_subarray(sizes, subsizes, offset, oldtype::Datatype;
                              rowmajor=false)
    
Creates a derived [`Datatype`](@ref) describing an `N`-dimensional subarray of size
`subsizes` of an `N`-dimensional array of size `sizes` and element type `oldtype`, with
the first element offset by `offset` (i.e. the 0-based index of the first element).

Column-major indexing (used by Julia and Fortran) is assumed; use the keyword
`rowmajor=true` to specify row-major layout (used by C and numpy).

Note that [`MPI.Types.commit!`](@ref) must be used before the datatype can be used for
communication.

# External links
$(_doc_external("MPI_Type_create_subarray"))
"""
function create_subarray(sizes,
                         subsizes,
                         offset,
                         oldtype::Datatype;
                         rowmajor=false)
    @assert (N = length(sizes)) == length(subsizes) == length(offset)
    sizes = sizes isa Vector{Cint} ? sizes : Cint[s for s in sizes]
    subsizes = subsizes isa Vector{Cint} ? subsizes : Cint[s for s in subsizes]
    offset = offset isa Vector{Cint} ? offset : Cint[s for s in offset]
    
    newtype = Datatype()
    @mpichk ccall((:MPI_Type_create_subarray, libmpi), Cint,
                  (Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint, MPI_Datatype, Ptr{MPI_Datatype}),
                  N, sizes, subsizes, offset,
                  rowmajor ? MPI.MPI_ORDER_C : MPI.MPI_ORDER_FORTRAN,
                  oldtype, newtype)
    finalizer(free, newtype)
    return newtype
end

"""
    MPI.Types.create_struct(blocklengths, displacements, types)

Creates a derived [`Datatype`](@ref) describing a struct layout.

Note that [`MPI.Types.commit!`](@ref) must be used before the datatype can be used for
communication.

# External links
$(_doc_external("MPI_Type_create_struct"))
"""
function create_struct(blocklengths, displacements, types)
    @assert (N = length(blocklengths)) == length(displacements) == length(types)
    blocklengths = blocklengths isa Vector{Cint} ? blocklengths : Cint[s for s in blocklengths]
    displacements = displacements isa Vector{MPI_Aint} ? displacements : MPI_Aint[s for s in displacements]

    newtype = Datatype()
    # int MPI_Type_create_struct(int count,
    #                            const int array_of_blocklengths[],
    #                            const MPI_Aint array_of_displacements[],
    #                            const MPI_Datatype array_of_types[],
    #                            MPI_Datatype *newtype)
    GC.@preserve types begin
        mpi_types = [t.val for t in types]
        @mpichk ccall((:MPI_Type_create_struct, libmpi), Cint,
                      (Cint, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}),
                      N, blocklengths, displacements, mpi_types, newtype)
    end
    return newtype
end



"""
    MPI.Types.create_resized(oldtype::Datatype, lb::Integer, extent::Integer)

Creates a new [`Datatype`](@ref) that is identical to `oldtype`, except that the lower
bound of this new datatype is set to be `lb`, and its upper bound is set to be `lb +
extent`.

Note that [`MPI.Types.commit!`](@ref) must be used before the datatype can be used for
communication.

# See also
- [`MPI.Types.extent`](@ref)

# External links
$(_doc_external("MPI_Type_create_resized"))
"""
function create_resized(oldtype::Datatype, lb::Integer, extent::Integer)
    newtype = Datatype()
    # int MPI_Type_create_resized(MPI_Datatype oldtype, MPI_Aint lb,
    #              MPI_Aint extent, MPI_Datatype *newtype)
    @mpichk ccall((:MPI_Type_create_resized, libmpi), Cint,
                  (MPI_Datatype, Cptrdiff_t, Cptrdiff_t, Ptr{MPI_Datatype}),
                  oldtype, lb, extent, newtype)
    finalizer(free, newtype)
    return newtype
end


"""
    MPI.Types.commit!(newtype::Datatype)

Commits a [`Datatype`](@ref) so that it can be used for communication.

# External links
$(_doc_external("MPI_Type_commit"))
"""
function commit!(newtype::Datatype)
    # int MPI_Type_commit(MPI_Datatype *datatype)
    @mpichk ccall((:MPI_Type_commit, libmpi), Cint,
                  (Ptr{MPI_Datatype},), newtype)
end


function Datatype(::Type{T}; commit=true) where T
    if !isbitstype(T)
        throw(ArgumentError("Type must be isbitstype"))
    end
    blocklengths = Cint[]
    displacements = MPI_Aint[]
    types = Datatype[]

    if isprimitivetype(T)
        # primitive type
        szrem = sz = sizeof(T)
        disp = 0
        for (i,basetype) in (8 => Datatype(UInt64), 4 => Datatype(UInt32), 2 => Datatype(UInt16), 1 => Datatype(UInt8))
            if sz == i
                return basetype
            end
            blk, szrem = divrem(szrem, i)
            if blk != 0
                push!(blocklengths, blk)
                push!(displacements, disp)
                push!(types, basetype)
                disp += i * blk
            end
        end
    else
        # struct
        Fprev = nothing
        for i in 1:fieldcount(T)
            F = fieldtype(T,i)
            offset = fieldoffset(T,i)
            if sizeof(F) == 0
                continue
            elseif F == Fprev
                blocklengths[end] += 1
            else
                push!(blocklengths, 1)
                push!(displacements, offset)
                push!(types, Datatype(F; commit=false))
                Fprev = F
            end
        end
    end
    dt = create_struct(blocklengths, displacements, types)
    if commit
        commit!(dt)
    end
    return dt
end

end # module


function Get_address(location)
    addr = Ref{Cptrdiff_t}(0)
    @mpichk ccall((:MPI_Get_address, libmpi), Cint, (Ptr{Cvoid}, Ref{MPI_Aint}), location, addr)
    return addr[]
end
