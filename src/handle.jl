const mpi_init_hooks = Any[]

macro mpi_handle(def, extrafields...)
    name = def isa Expr ? def.args[1] : def
    _name = Symbol(:_, name)
    mpiname = Symbol(:MPI_, name)
    quote
        Base.@__doc__ mutable struct $(esc(def))
            val::$mpiname
            $(extrafields...)
            
            $(esc(name))(val::$mpiname, $(extrafields...)) = new(val, $(extrafields...))
        end

        # const initializer
        function $(esc(_name))(ival::Cint, extraargs...)
            x = $name(reinterpret($mpiname, sizeof($mpiname) == 4 ?  Int32(-1) : Int64(-1)), extraargs...)
            push!(mpi_init_hooks, () -> x.val = $mpiname(ival))
            return x
        end

        function Base.:(==)(a::$name, b::$name)
            a.val == b.val
        end

        # allows us to pass XX objects directly into MPI_XX ccall signatures
        function Base.cconvert(::Type{$mpiname}, obj::$name)
            obj.val
        end
        # allows us to pass XX objects directly into Ptr{MPI_XX} ccall signatures
        function Base.unsafe_convert(::Type{Ptr{$mpiname}}, obj::$name)
            convert(Ptr{$mpiname}, pointer_from_objref(obj))
        end
    end
end
