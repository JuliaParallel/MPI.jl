const mpi_init_hooks = Any[]

macro mpi_handle(def, mpiname=nothing, extrafields...)
    name = def isa Expr ? def.args[1] : def
    _name = Symbol(:_, name)
    if mpiname == nothing
        mpiname = Symbol(:MPI_, name)
    end
    mpiname_f2c = Symbol(mpiname,:_f2c)
    quote
        Base.@__doc__ mutable struct $(esc(def))
            val::$mpiname
            $(extrafields...)
            
            $(esc(name))(val::$mpiname, $(extrafields...)) = new(val, $(extrafields...))
        end

        # const initializer
        function $(esc(_name))(ival::Cint, extraargs...)
            # We check the type used for handles, as a proxy for
            # detecting which MPI implementation is used. This lets us
            # decide whether we need to convert handles from Fortran
            # to C. (This mechanism should be improved.)
            if $mpiname == Cint || $mpiname == Culong
                # MPICH, MPItrampoline, and Microsoft MPI use the C handles
                return $name(ival, extraargs...)
            else
                # OpenMPI uses Fortran handles which need to be translated
                x = $name(C_NULL, extraargs...)
                push!(mpi_init_hooks, () -> x.val = $mpiname_f2c(ival))
                return x
            end
        end

        function Base.:(==)(a::$name, b::$name)
            a.val == b.val
        end

        # allows us to pass XX objects directly into MPI_XX ccall signatures
        function Base.cconvert(::Type{$mpiname}, obj::$name)
            obj
        end
        function Base.unsafe_convert(::Type{$mpiname}, obj::$name)
            obj.val
        end
        # allows us to pass XX objects directly into Ptr{MPI_XX} ccall signatures
        function Base.unsafe_convert(::Type{Ptr{$mpiname}}, obj::$name)
            convert(Ptr{$mpiname}, pointer_from_objref(obj))
        end
    end
end


"""
    MPI.free(obj)

Free the MPI object handle `obj`. This is typically used as the finalizer, and so need not be called directly unless otherwise noted.
"""
function free
end
