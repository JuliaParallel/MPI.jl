import Base: @deprecate

# to be deprecated
const FINALIZE_ATEXIT = Ref(true)
@deprecate finalize_atexit() true false

@deprecate Info(::Cint) Info() false
@deprecate Info_set(info::Info,key::AbstractString,value::AbstractString) info[Symbol(key)] = value false
@deprecate Info_get(info::Info,key::AbstractString) info[Symbol(key)] false
@deprecate Info_delete(info::Info,key::AbstractString) delete!(info, Symbol(key)) false
@deprecate Info_free(info::Info) free(info) false


# window functions
@deprecate(Win_create(base::Array{T}, info::Info, comm::Comm, win::Win) where {T},
           (win = Win_create(base, comm; info...)), false)
    
@deprecate(Win_create_dynamic(info::Info, comm::Comm, win::Win),
           (win = Win_create_dynamic(comm; info...)), false)

@deprecate(Win_allocate_shared(::Type{T}, len::Int, info::Info, comm::Comm, win::Win) where T,
           ((win, ptr) = Win_allocate_shared(T, len, comm; info...); ptr), false)

@deprecate Win_free(win::Win) free(win) false
