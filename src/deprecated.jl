import Base: @deprecate

# to be deprecated
const FINALIZE_ATEXIT = Ref(true)
@deprecate finalize_atexit() true false

@deprecate Info(::Cint) Info() false
@deprecate Info_set(info::Info,key::AbstractString,value::AbstractString) info[Symbol(key)] = value false
@deprecate Info_get(info::Info,key::AbstractString) info[Symbol(key)] false
@deprecate Info_delete(info::Info,key::AbstractString) delete!(info, Symbol(key)) false
@deprecate Info_free(info::Info) free(info) false


