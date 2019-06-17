"""
    Info <: AbstractDict{Symbol,String}

`MPI.Info` objects store key-value pairs, and are typically used for passing optional
arguments to MPI functions.

# Usage

These will typically be hidden from user-facing APIs by splatting keywords, e.g.
```julia
function f(args...; kwargs...)
    info = Info(kwargs...)
    # pass `info` object to `ccall`
end
```

For manual usage, `Info` objects act like Julia `Dict` objects:
```julia
info = Info(init=true) # keyword argument is required
info[key] = value
x = info[key]
delete!(info, key)
```

If `init=false` is used in the costructor (the default), a "null" `Info` object will be
returned: no keys can be added to such an object.
"""
mutable struct Info <: AbstractDict{Symbol,String}
    cinfo::CInfo

    function Info(cinfo::CInfo)
        new(cinfo)
    end
    function Info(;init=false)
        info = Info(INFO_NULL.cinfo)
        if init
            @mpichk ccall((:MPI_Info_create, libmpi), Cint, (Ptr{CInfo},), info)
            refcount_inc()
            finalizer(free, info)
        end
        return info
    end
end

# allows us to pass Info objects directly into CInfo ccall signatures
function Base.cconvert(::Type{CInfo}, info::Info)
    info.cinfo
end
# allows us to pass Info objects directly into Ptr{CInfo} ccall signatures
function Base.unsafe_convert(::Type{Ptr{CInfo}}, info::Info)
    convert(Ptr{CInfo}, pointer_from_objref(info))
end

if HAVE_MPI_COMM_C2F
    # Assume info is treated the same way
    function CInfo(finfo::Cint)
        ccall((:MPI_Info_f2c, libmpi), CInfo, (Cint,), finfo)
    end

    # only used for use with Fortran API
    # can be removed once we have switched to C API
    function Base.cconvert(::Type{Ptr{Cint}}, info::Info)
        Ref(ccall((:MPI_Info_c2f, libmpi), Cint, (CInfo,), info.cinfo))
    end
else
    function CInfo(finfo::Cint)
        reinterpret(CInfo, finfo)
    end
    function Base.cconvert(::Type{Ptr{Cint}}, info::Info)
        Ref(reinterpret(Cint, info.cinfo))
    end
end

const INFO_NULL = Info(Ref{CInfo}()[]) # get an arbitrary bit-pattern: this will be set correctly at Init time

function free(info::Info)
    if info.cinfo != INFO_NULL.cinfo
        @mpichk ccall((:MPI_Info_free, libmpi), Cint, (Ptr{CInfo},), info)
        refcount_dec()
    end
    return nothing
end

function Base.setindex!(info::Info, value::AbstractString, key::Symbol)
    skey = String(key)
    @assert isascii(skey) && isascii(value) &&
        length(skey) <= MPI_MAX_INFO_KEY && length(value) <= MPI_MAX_INFO_VAL
    @mpichk ccall((:MPI_Info_set, libmpi), Cint,
          (CInfo, Cstring, Cstring), info, skey, value)
end

Base.setindex!(info::Info, value::Any, key::Symbol) = info[key] = infoval(value)

"""
    infoval(x)

Convert Julia object `x` to a string representation for storing in an [`Info`](@ref) object.

The MPI specification allows passing strings, Boolean values, integers, and lists.
"""
infoval(x::String) = x
infoval(x::Bool) = string(x) # "true"/"false"
infoval(x::Integer) = string(x) # decimal values
infoval(xs::AbstractVector) = join(map(infoval, xs), ',') # separated by commas
infoval(xs::Tuple) = join(map(infoval, xs), ',') # separated by commas

function Info(kvs::Pair...)
    info = Info(;init=true)
    for (k,v) in kvs
        info[k] = v
    end
    return info
end


function Base.getindex(info::Info, key::Symbol)
    skey = String(key)
    @assert isascii(skey) && length(skey) <= MPI_MAX_INFO_KEY
    valuelen = Ref{Cint}()
    flag = Ref{Cint}()
    @mpichk ccall((:MPI_Info_get_valuelen, libmpi), Cint,
          (CInfo, Cstring, Ptr{Cint}, Ptr{Cint}),
          info, skey, valuelen, flag)

    if flag[] == 0
        throw(KeyError(key))
    end

    n = valuelen[]
    buffer = Vector{UInt8}(undef, n)
    @mpichk ccall((:MPI_Info_get, libmpi), Cint,
          (CInfo, Cstring, Cint, Ptr{UInt8}, Ptr{Cint}),
          info, skey, n, buffer, flag)
    return String(buffer)
end

function Base.delete!(info::Info,key::Symbol)
    skey = String(key)
    @assert isascii(skey) && length(skey) <= MPI_MAX_INFO_KEY
    @mpichk ccall((:MPI_Info_delete, libmpi), Cint,
          (CInfo, Cstring), info, skey)
end

function Base.length(info::Info)
    if info.cinfo == INFO_NULL.cinfo
        return 0
    end
    nkeys = Ref{Cint}()
    @mpichk ccall((:MPI_Info_get_nkeys, libmpi), Cint,
                   (CInfo, Ptr{Cint}), info, nkeys)
    return Int(nkeys[])
end

function nthkey(info::Info, n::Integer)
    buffer = Vector{UInt8}(undef, MPI_MAX_INFO_KEY)
    @mpichk ccall((:MPI_Info_get_nthkey, libmpi), Cint,
                  (CInfo, Cint, Ptr{UInt8}), info, n, buffer)
    i = findfirst(isequal(UInt8(0)), buffer)
    if i !== nothing
        resize!(buffer, i-1)
    end
    Symbol(buffer)
end

function Base.iterate(infokeys::Base.KeySet{Symbol,Info}, i=0)
    info = infokeys.dict
    if i < length(info)
        key = nthkey(info, i)
        return key, i+1
    else
        return nothing
    end
end

function Base.iterate(info::Info, i=0)
    if i < length(info)
        key = nthkey(info, i)
        val = info[key]
        return key=>val, i+1
    else
        return nothing
    end
end
