typealias MpiDatatype Union(Float32, Float64, Complex64, Complex128, Char,
                         Int8, Uint8, Int16, Uint16, Int32, Uint32, Int64,
                         Uint64)

_mpi_datatype_map = {
  Float32 => MPI_REAL4,
  Float64 => MPI_REAL8,
  Complex64 => MPI_COMPLEX,
  Complex128 => MPI_DOUBLE_COMPLEX,
  Char => MPI_WCHAR,
  Int8 => MPI_INT8_T,
  Uint8 => MPI_UINT8_T,
  Int16 => MPI_INT16_T,
  Uint16 => MPI_UINT16_T,
  Int32 => MPI_INT32_T,
  Uint32 => MPI_UINT32_T,
  Int64 => MPI_INT64_T,
  Uint64 => MPI_UINT64_T,
# The following doesn't not seem to work with my openmpi build
#  Int128 => MPI_INTEGER16,
# Unfortunately mpich2 doesn't support 8-bits ints
#  Bool => MPI_LOGICAL1,
}

takebuf_array(s::IOStream) =
    ccall(:jl_takebuf_array, Vector{Uint8}, (Ptr{Void},), s.ios)

for (elty, elfn, elnl) in ((:Comm,      :MPI_COMM_FREE,    :MPI_COMM_NULL),
                           (:Request,   :MPI_REQUEST_FREE, :MPI_REQUEST_NULL),
                           (:Operation, :MPI_OP_FREE,      :MPI_OP_NULL))
    @eval begin
        type ($elty)
            fval::Int32

            function ($elty)(b::Int32)
                a = new(b)
                finalizer(a, free)
                a
            end
        end

        convert(::Type{$elty}, x::Int32) = ($elty)(x)
        convert(::Type{Int32}, x::($elty)) = Int32(x.fval)

        function free(el::($elty))
            ierr = Array(Int32, 1)

            if el.fval != $elnl
                ccall($elfn, Void, (Ptr{Int32},Ptr{Int32},), &el.fval, ierr)

                if ierr[1] != MPI_SUCCESS
                    elfn_str = $string(elfn)
                    prinln("$elfn_str: error $(ierr[1])")
                end
            end
        end
    end
end


function init()
    ierr = Array(Int32, 1)
    ccall(MPI_INIT, Void, (Ptr{Int32},), ierr)
    if ierr[1] != MPI_SUCCESS error("MPI_INIT: error $(ierr[1])") end
end

function rank(c::Comm)
    ierr = Array(Int32, 1)
    r = Array(Int32, 1)
    ccall(MPI_COMM_RANK, Void, (Ptr{Int32}, Ptr{Int32}, Ptr{Int32},),
        &c.fval, r, ierr)
    if ierr[1] != MPI_SUCCESS error("MPI_COMM_RANK: error $(ierr[1])") end
    r[1]
end

function size(c::Comm)
    ierr = Array(Int32, 1)
    s = Array(Int32, 1)
    ccall(MPI_COMM_SIZE, Void, (Ptr{Int32}, Ptr{Int32}, Ptr{Int32},),
        &c.fval, s, ierr)
    if ierr[1] != MPI_SUCCESS error("MPI_COMM_SIZE: error $(ierr[1])") end
    s[1]
end

function barrier(c::Comm)
    ierr = Array(Int32, 1)
    ccall(MPI_BARRIER, Void, (Ptr{Int32},Ptr{Int32},), &c.fval, ierr)
    if ierr[1] != MPI_SUCCESS error("MPI_BARRIER: error $(ierr[1])") end
end

function bcast!{T<:MpiDatatype}(A::Union(Ptr{T},Array{T}), count::Integer,
                             root::Integer, c::Comm)
    ierr = Array(Int32, 1)

    ccall(MPI_BCAST, Void,
          (Ptr{T}, Ptr{Int32}, Ptr{Int32},  Ptr{Int32}, Ptr{Int32},
          Ptr{Int32},),
          A, &count, &_mpi_datatype_map[T], &root, &c.fval, ierr)

    if ierr[1] != MPI_SUCCESS error("MPI_BCAST: error $(ierr[1])") end
    A
end

function bcast!{T<:MpiDatatype}(A::Array{T}, root::Integer, c::Comm)
    bcast!(A, numel(A), root, c)
end

function bcast(A, root::Integer, c::Comm)
    ierr = Array(Int32, 1)
    len  = Array(Int32, 1)

    if rank(c) == root
        s = memio()
        serialize(s, A)
        buf = takebuf_array(s)
        len[1] = numel(buf)
    end

    ccall(MPI_BCAST, Void,
          (Ptr{Int32}, Ptr{Int32}, Ptr{Int32},  Ptr{Int32}, Ptr{Int32},
          Ptr{Int32},),
          len, &sizeof(Int32), &MPI_BYTE, &root, &c.fval, ierr)

    if ierr[1] != MPI_SUCCESS error("MPI_BCAST: error $(ierr[1])") end

    if rank(c) != root
        buf = Array(Uint8, len[1])
    end

    ccall(MPI_BCAST, Void,
          (Ptr{Uint8}, Ptr{Int32}, Ptr{Int32},  Ptr{Int32}, Ptr{Int32},
          Ptr{Int32},),
          buf, len, &MPI_BYTE, &root, &c.fval, ierr)

    if ierr[1] != MPI_SUCCESS error("MPI_BCAST: error $(ierr[1])") end

    if rank(c) != root
        s = memio()
        write(s, buf)
        seek(s, 0)
        Af = deserialize(s)
        if isa(Af, Function)
            Af()
        else
            Af
        end
    else
        A
    end
end

function reduce{T<:MpiDatatype}(A::Union(Ptr{T},Array{T}), count::Integer,
                                op::Operation, root::Integer, c::Comm)
    ierr = Array(Int32, 1)

    if MPI.rank(c) == root
        B = Array(T, count)
    else
        B = Array(T, 0)
    end

    ccall(MPI_REDUCE, Void,
          (Ptr{T}, Ptr{T}, Ptr{Int32},  Ptr{Int32}, Ptr{Int32},
          Ptr{Int32}, Ptr{Int32}, Ptr{Int32},),
          A, B, &count, &_mpi_datatype_map[T], &op.fval, &root, &c.fval, ierr)

    if ierr[1] != MPI_SUCCESS error("MPI_REDUCE: error $(ierr[1])") end

    if MPI.rank(c) != root
        B = Nothing
    end
    B
end

function reduce{T<:MpiDatatype}(A::Array{T}, op::Operation, root::Integer,
                                c::Comm)
    reduce(A, numel(A), op, root, c)
end

function reduce{T<:MpiDatatype}(A::T, op::Operation, root::Integer, c::Comm)
    A1 = Array(T, 1)
    A1[1] = A
    B1 = reduce(A1, op, root, c)
    if MPI.rank(c) == root
        B1[1]
    else
        Nothing
    end
end

function finalize()
    ierr = Array(Int32, 1)
    ccall(MPI_FINALIZE, Void, (Ptr{Int32},), ierr)
    if ierr[1] != MPI_SUCCESS error("MPI_FINALIZE: error $(ierr[1])") end
end

const COMM_SELF  = Comm(MPI_COMM_SELF)
const COMM_WORLD = Comm(MPI_COMM_WORLD)
const COMM_NULL  = Comm(MPI_COMM_NULL)

const OP_NULL = Operation(MPI_OP_NULL)
const MAX     = Operation(MPI_MAX    )
const MIN     = Operation(MPI_MIN    )
const SUM     = Operation(MPI_SUM    )
const PROD    = Operation(MPI_PROD   )
const LAND    = Operation(MPI_LAND   )
const BAND    = Operation(MPI_BAND   )
const LOR     = Operation(MPI_LOR    )
const BOR     = Operation(MPI_BOR    )
const LXOR    = Operation(MPI_LXOR   )
const BXOR    = Operation(MPI_BXOR   )
##The following are not supported yet
#const MAXLOC  = Operation(MPI_MAXLOC )
#const MINLOC  = Operation(MPI_MINLOC )
#const REPLACE = Operation(MPI_REPLACE)

const ANY_SOURCE = MPI_ANY_SOURCE
const ANY_TAG    = MPI_ANY_TAG
const TAG_UB     = MPI_TAG_UB

const STATUS_SIZE   = MPI_STATUS_SIZE

const SOURCE      = MPI_SOURCE
const TAG         = MPI_TAG
const ERROR       = MPI_ERROR

const REQUEST_NULL = Request(MPI_REQUEST_NULL)
