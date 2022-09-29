"""
    Datatype

A `Datatype` represents the layout of the data in memory.

# Usage

    Datatype(T)

Either return the predefined `Datatype` corresponding to `T`, or create a new `Datatype`
for the Julia type `T`, calling [`Types.commit!`](@ref) so that it can be used for
communication operations.

Note that this can only be called on types for which `isbitstype(T)` is `true`.
"""
mutable struct Datatype
    val::MPI_Datatype
end
Base.:(==)(a::Datatype, b::Datatype) = a.val == b.val
Base.cconvert(::Type{MPI_Datatype}, datatype::Datatype) = datatype
Base.unsafe_convert(::Type{MPI_Datatype}, datatype::Datatype) = datatype.val
Base.unsafe_convert(::Type{Ptr{MPI_Datatype}}, datatype::Datatype) = convert(Ptr{MPI_Datatype}, pointer_from_objref(datatype))

const DATATYPE_NULL = Datatype(Consts.MPI_DATATYPE_NULL[])
add_load_time_hook!(() -> DATATYPE_NULL.val = Consts.MPI_DATATYPE_NULL[])

Datatype() = Datatype(DATATYPE_NULL.val)

function free(dt::Datatype)
    if dt != DATATYPE_NULL && !Finalized()
        # int MPI_Type_free(MPI_Type *type)
        API.MPI_Type_free(dt)
    end
    return nothing
end

# attributes
function create_keyval(::Type{Datatype})
    ref = Ref(Cint(0))
    API.MPI_Type_create_keyval(Consts.MPI_TYPE_NULL_COPY_FN[], Consts.MPI_TYPE_NULL_DELETE_FN[], ref, C_NULL)
    return ref[]
end
function set_attr!(datatype::Datatype, keyval::Cint, attrval::Ptr{Cvoid})
    API.MPI_Type_set_attr(datatype, keyval, attrval)
    return nothing
end
function get_attr(datatype::Datatype, keyval::Cint)
    flagref = Ref(Cint(0))
    attrref = Ref{Ptr{Cvoid}}(C_NULL)
    API.MPI_Type_get_attr(datatype, keyval, attrref, flagref)
    flagref[] == 0 && return nothing
    return attrref[]
end
function del_attr!(datatype::Datatype, keyval::Cint)
    API.MPI_Type_delete_attr(datatype, keyval)
    return nothing
end

# names
function get_name(datatype::Datatype)
    buffer = Array{UInt8}(undef, Consts.MPI_MAX_OBJECT_NAME)
    lenref = Ref{Cint}()
    API.MPI_Type_get_name(datatype, buffer, lenref)
    return String(resize!(buffer, lenref[]))
end

# datatype attribute to store Julia type
const JULIA_TYPE_PTR_ATTR = Ref(Cint(0))
add_init_hook!(() -> JULIA_TYPE_PTR_ATTR[] = create_keyval(Datatype))

"""
    to_type(datatype::Datatype)

Return the Julia type corresponding to the MPI [`Datatype`](@ref) `datatype`, or `nothing`
if it doesn't correspond directly.
"""
function to_type(datatype::Datatype)
    if MPI.Initialized() && !MPI.Finalized()
        ptr = get_attr(datatype, JULIA_TYPE_PTR_ATTR[])
        isnothing(ptr) || return unsafe_pointer_to_objref(ptr)
    end
    return nothing
end


# predefined
_defined_datatype_methods = Set{Type}()
for (mpiname, T) in [
    :INT8_T             => Int8
    :UINT8_T            => UInt8
    :INT16_T            => Int16
    :UINT16_T           => UInt16
    :INT32_T            => Int32
    :UINT32_T           => UInt32
    :INT64_T            => Int64
    :UINT64_T           => UInt64
    :BYTE               => UInt8
    :SHORT              => Cshort
    :UNSIGNED_SHORT     => Cushort
    :INT                => Cint
    :UNSIGNED           => Cuint
    :LONG               => Clong
    :UNSIGNED_LONG      => Culong
    :LONG_LONG_INT      => Clonglong
    :UNSIGNED_LONG_LONG => Culonglong
    :CHAR               => Cchar
    :SIGNED_CHAR        => Cchar
    :UNSIGNED_CHAR      => Cuchar
    :WCHAR              => Cwchar_t
    :FLOAT              => Float32
    :DOUBLE             => Float64
    :C_FLOAT_COMPLEX    => ComplexF32
    :C_DOUBLE_COMPLEX   => ComplexF64
    :C_BOOL             => Bool
]

    @eval begin
        const $mpiname = Datatype(Consts.$(Symbol(:MPI_,mpiname))[])
        add_load_time_hook!(() -> $mpiname.val = Consts.$(Symbol(:MPI_,mpiname))[])
        if $T ∉ _defined_datatype_methods
            push!(_defined_datatype_methods, $T)
            Datatype(::Type{$T}) = $mpiname
            add_init_hook!(function()
                @assert Types.size($mpiname) == sizeof($T)
                set_attr!($mpiname, JULIA_TYPE_PTR_ATTR[], pointer_from_objref($T))
                end)
        end
    end
end
_defined_datatype_methods = nothing


function Datatype(::Type{T}) where {T}
    datatype = Datatype()
    # lazily initialize so that it can be safely precompiled
    function init()
        Types.create!(datatype, T)
        Types.commit!(datatype)
        set_attr!(datatype, JULIA_TYPE_PTR_ATTR[], pointer_from_objref(T))
    end
    # Initialized() ? init() : add_init_hook!(init)
    @assert Initialized()
    init()
    return datatype
end


function Base.show(io::IO, datatype::Datatype)
    show(io, Datatype)
    print(io, '(')
    juliatype = to_type(datatype)
    if isnothing(juliatype)
        show(io, datatype.val)
    else
        show(io, juliatype)
    end
    print(io, ')')
    if MPI.Initialized() && !MPI.Finalized()
        name = get_name(datatype)
        print(io, ": ")
        print(io, name)
    end
end

module Types

import MPI
import MPI: API, _doc_external, Datatype, MPI_Datatype, MPI_Aint, free

function size(dt::Datatype)
    dtsize = Ref{Cint}()
    API.MPI_Type_size(dt, dtsize)
    return Int(dtsize[])
end

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
    API.MPI_Type_get_extent(dt, lb, extent)
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
    finalizer(free, create_contiguous!(Datatype(), count, oldtype))
end

function create_contiguous!(newtype::Datatype, count::Integer, oldtype::Datatype)
    API.MPI_Type_contiguous(count, oldtype, newtype)
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
    finalizer(free, create_vector!(Datatype(), count, blocklength, stride, oldtype))
end
function create_vector!(newtype::Datatype, count::Integer, blocklength::Integer, stride::Integer, oldtype::Datatype)
    # int MPI_Type_vector(int count, int blocklength, int stride,
    #          MPI_Datatype oldtype, MPI_Datatype *newtype)
    API.MPI_Type_vector(count, blocklength, stride, oldtype, newtype)
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
function create_subarray(sizes, subsizes, offset, oldtype::Datatype;
                         rowmajor=false)
    finalizer(free, create_subarray!(Datatype(), sizes, subsizes, offset, oldtype; rowmajor=rowmajor))
end
function create_subarray!(newtype::Datatype, sizes, subsizes, offset, oldtype::Datatype;
                          rowmajor=false)
    @assert (N = length(sizes)) == length(subsizes) == length(offset)
    sizes = sizes isa Vector{Cint} ? sizes : Cint[s for s in sizes]
    subsizes = subsizes isa Vector{Cint} ? subsizes : Cint[s for s in subsizes]
    offset = offset isa Vector{Cint} ? offset : Cint[s for s in offset]
    # int MPI_Type_create_subarray(int ndims,
    #                              const int array_of_sizes[],
    #                              const int array_of_subsizes[],
    #                              const int array_of_starts[],
    #                              int order,
    #                              MPI_Datatype oldtype,
    #                              MPI_Datatype *newtype)
    API.MPI_Type_create_subarray(N, sizes, subsizes, offset,
                                 rowmajor ? MPI.Consts.MPI_ORDER_C[] : MPI.Consts.MPI_ORDER_FORTRAN[],
                                 oldtype, newtype)
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
    finalizer(free, create_struct!(Datatype(), blocklengths, displacements, types))
end
function create_struct!(newtype::Datatype, blocklengths, displacements, types)
    @assert (N = length(blocklengths)) == length(displacements) == length(types)
    blocklengths = blocklengths isa Vector{Cint} ? blocklengths : Cint[s for s in blocklengths]
    displacements = displacements isa Vector{MPI_Aint} ? displacements : MPI_Aint[s for s in displacements]
    # int MPI_Type_create_struct(int count,
    #                            const int array_of_blocklengths[],
    #                            const MPI_Aint array_of_displacements[],
    #                            const MPI_Datatype array_of_types[],
    #                            MPI_Datatype *newtype)
    GC.@preserve types begin
        mpi_types = [t.val for t in types]
        API.MPI_Type_create_struct(N, blocklengths, displacements, mpi_types, newtype)
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
    finalizer(free, create_resized!(Datatype(), oldtype, lb, extent))
end
function create_resized!(newtype::Datatype, oldtype::Datatype, lb::Integer, extent::Integer)
    # int MPI_Type_create_resized(MPI_Datatype oldtype, MPI_Aint lb,
    #              MPI_Aint extent, MPI_Datatype *newtype)
    API.MPI_Type_create_resized(oldtype, lb, extent, newtype)
    return newtype
end

function duplicate!(newtype::Datatype, oldtype::Datatype)
    # int MPI_Type_dup(MPI_Datatype oldtype, MPI_Datatype * newtype)
    API.MPI_Type_dup(oldtype, newtype)
    return newtype
end
"""
    MPI.Types.duplicate(oldtype::Datatype)

Duplicates the datatype `oldtype`.

# External links
$(_doc_external("MPI_Type_dup"))
"""
duplicate(oldtype::Datatype) = duplicate!(Datatype(), oldtype::Datatype)

"""
    MPI.Types.commit!(newtype::Datatype)

Commits the [`Datatype`](@ref) `newtype` so that it can be used for communication.
Returns `newtype`.

# External links
$(_doc_external("MPI_Type_commit"))
"""
function commit!(newtype::Datatype)
    # int MPI_Type_commit(MPI_Datatype *datatype)
    API.MPI_Type_commit(newtype)
    return newtype
end

function create!(newtype::Datatype, ::Type{T}) where {T}
    isbitstype(T) || throw(ArgumentError("Type must be isbitstype"))
    blocklengths = Cint[]
    displacements = MPI_Aint[]
    types = Datatype[]

    if isprimitivetype(T)
        # primitive type
        szrem = sz = sizeof(T)
        disp = 0
        for (i,basetype) in (8 => Datatype(UInt64), 4 => Datatype(UInt32), 2 => Datatype(UInt16), 1 => Datatype(UInt8))
            if sz == i
                return MPI.Types.duplicate!(newtype, basetype)
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
                push!(types, Datatype(F))
                Fprev = F
            end
        end
    end
    create_struct!(newtype, blocklengths, displacements, types)
end

end # module

function Get_address(location)
    addr = Ref{Cptrdiff_t}(0)
    API.MPI_Get_address(location, addr)
    return addr[]
end
