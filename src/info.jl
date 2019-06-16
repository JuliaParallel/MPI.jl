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
@mpi_handle Info <: AbstractDict{Symbol,String}

const INFO_NULL = _Info(MPI_INFO_NULL)

function Info(;init=false)
    info = Info(INFO_NULL.val)
    if init
        @mpichk ccall((:MPI_Info_create, libmpi), Cint, (Ptr{MPI_Info},), info)
        refcount_inc()
        finalizer(free, info)
    end
    return info
end

function free(info::Info)
    if info.val != INFO_NULL.val
        @mpichk ccall((:MPI_Info_free, libmpi), Cint, (Ptr{MPI_Info},), info)
        refcount_dec()
    end
    return nothing
end

function Base.setindex!(info::Info, value::AbstractString, key::Symbol)
    skey = String(key)
    @assert isascii(skey) && isascii(value) &&
        length(skey) <= MPI_MAX_INFO_KEY && length(value) <= MPI_MAX_INFO_VAL
    @mpichk ccall((:MPI_Info_set, libmpi), Cint,
          (MPI_Info, Cstring, Cstring), info, skey, value)
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
          (MPI_Info, Cstring, Ptr{Cint}, Ptr{Cint}),
          info, skey, valuelen, flag)

    if flag[] == 0
        throw(KeyError(key))
    end

    n = valuelen[]
    buffer = Vector{UInt8}(undef, n)
    @mpichk ccall((:MPI_Info_get, libmpi), Cint,
          (MPI_Info, Cstring, Cint, Ptr{UInt8}, Ptr{Cint}),
          info, skey, n, buffer, flag)
    return String(buffer)
end

function Base.delete!(info::Info,key::Symbol)
    skey = String(key)
    @assert isascii(skey) && length(skey) <= MPI_MAX_INFO_KEY
    @mpichk ccall((:MPI_Info_delete, libmpi), Cint,
          (MPI_Info, Cstring), info, skey)
end

function Base.length(info::Info)
    if info.val == INFO_NULL.val
        return 0
    end
    nkeys = Ref{Cint}()
    @mpichk ccall((:MPI_Info_get_nkeys, libmpi), Cint,
                   (MPI_Info, Ptr{Cint}), info, nkeys)
    return Int(nkeys[])
end

function nthkey(info::Info, n::Integer)
    buffer = Vector{UInt8}(undef, MPI_MAX_INFO_KEY)
    @mpichk ccall((:MPI_Info_get_nthkey, libmpi), Cint,
                  (MPI_Info, Cint, Ptr{UInt8}), info, n, buffer)
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
