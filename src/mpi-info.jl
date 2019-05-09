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
    val::Cint
    function Info(;init=false)
        info = new(MPI_INFO_NULL)
        if init
            ccall(MPI_INFO_CREATE, Nothing, (Ptr{Cint}, Ref{Cint}), info, 0)
            refcount_inc()
            finalizer(free, info)
        end
        return info
    end
end

# allows us to pass Info objects directly into Ptr{Cint} ccall signatures
function Base.unsafe_convert(::Type{Ptr{Cint}}, info::Info)
    convert(Ptr{Cint}, pointer_from_objref(info))
end

function free(info::Info)
    if info.val != MPI_INFO_NULL
        ccall(MPI_INFO_FREE, Nothing, (Ptr{Cint}, Ref{Cint}), info, 0)
        refcount_dec()
    end
    return nothing
end

const INFO_NULL = Info(init=false)

# the info functions assume that Fortran hidden arguments are placed at the end of the argument list
function Base.setindex!(info::Info, value::AbstractString, key::Symbol)
    skey = String(key)
    @assert isascii(skey) && isascii(value) &&
        length(skey) <= MPI_MAX_INFO_KEY && length(value) <= MPI_MAX_INFO_VAL
    ccall(MPI_INFO_SET, Nothing,
          (Ptr{Cint}, Ptr{UInt8}, Ptr{UInt8}, Ref{Cint}, Csize_t, Csize_t),
          info, skey, value, 0, sizeof(skey), sizeof(value))
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
    keyexists = Ref{Cint}()
    len       = Ref{Cint}()
    ccall(MPI_INFO_GET_VALUELEN, Nothing,
          (Ptr{Cint}, Ptr{UInt8}, Ptr{Cint}, Ptr{Cint}, Ref{Cint}, Csize_t),
          info, skey, len, keyexists, 0, sizeof(skey))
    
    if keyexists[] == 0
        throw(KeyError(key))
    end
    
    buffer = Vector{UInt8}(undef, len[])
    ccall(MPI_INFO_GET, Nothing,
          (Ptr{Cint}, Ptr{UInt8}, Ptr{Cint}, Ptr{UInt8}, Ptr{Cint}, Ref{Cint}, Csize_t, Csize_t),
          info, skey, len, buffer, keyexists, 0, sizeof(skey), sizeof(buffer))
    return String(buffer)
end

function Base.delete!(info::Info,key::Symbol)
    skey = String(key)
    @assert isascii(skey) && length(skey) <= MPI_MAX_INFO_KEY
    ccall(MPI_INFO_DELETE, Nothing,
          (Ptr{Cint}, Ptr{UInt8}, Ref{Cint}, Csize_t),
          info, skey, 0, sizeof(skey))
end

function Base.length(info::Info)
    if info.val == MPI_INFO_NULL
        return 0
    end
    nkeys = Ref{Cint}()
    ccall(MPI_INFO_GET_NKEYS, Nothing,
          (Ptr{Cint}, Ptr{Cint}, Ref{Cint}),
          info, nkeys, 0)
    return Int(nkeys[])
end
    
function nthkey(info::Info, n::Integer)
    buffer = Vector{UInt8}(undef, MPI_MAX_INFO_KEY)
    ccall(MPI_INFO_GET_NTHKEY, Nothing,
          (Ptr{Cint}, Ref{Cint}, Ptr{UInt8}, Ref{Cint}, Csize_t),
          info, n, buffer, 0, length(buffer))
    i = findlast(!isequal(UInt8(' ')), buffer)
    resize!(buffer, i)
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

