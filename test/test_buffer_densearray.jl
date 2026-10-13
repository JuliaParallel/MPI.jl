include("common.jl")

# `MPI.Buffer` accepts any `DenseArray` that can be converted to an `MPIPtr`,
# not only `Array`s.

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

dst = mod(rank+1, size)
src = mod(rank-1, size)

N = 8

# A minimal dense array type wrapping a `Vector`, as e.g. `FixedSizeArray` from
# FixedSizeArrays.jl.
struct WrappedDenseArray{T,N} <: DenseArray{T,N}
    data::Vector{T}
    dims::NTuple{N,Int}
end
Base.size(a::WrappedDenseArray) = a.dims
Base.IndexStyle(::Type{<:WrappedDenseArray}) = IndexLinear()
Base.getindex(a::WrappedDenseArray, i::Int) = a.data[i]
Base.setindex!(a::WrappedDenseArray, x, i::Int) = (a.data[i] = x; a)
Base.cconvert(::Type{Ptr{T}}, a::WrappedDenseArray{T}) where {T} = a.data

if ArrayType == Array
    arraytypes = Any[(T, n) -> WrappedDenseArray(zeros(T, 2n), (2, n))]
    if isdefined(Base, :Memory)
        push!(arraytypes, (T, n) -> fill!(Memory{T}(undef, n), zero(T)))
    end

    for make in arraytypes
        send_mesg = make(Float64, N)
        recv_mesg = make(Float64, N)
        fill!(send_mesg, Float64(rank))

        buf = MPI.Buffer(send_mesg)
        @test buf.data === send_mesg
        @test buf.count == length(send_mesg)
        @test buf.datatype == MPI.Datatype(Float64)

        rreq = MPI.Irecv!(recv_mesg, comm; source=src, tag=src+32)
        sreq = MPI.Isend(send_mesg, comm; dest=dst, tag=rank+32)
        MPI.Waitall([sreq, rreq])
        @test all(==(Float64(src)), recv_mesg)

        # collective operations
        a = make(Int, N)
        fill!(a, rank + 1)
        MPI.Allreduce!(a, +, comm)
        @test all(==(div(size * (size + 1), 2)), a)

        b = make(Int, N)
        if rank == 0
            fill!(b, 42)
        end
        MPI.Bcast!(b, comm; root=0)
        @test all(==(42), b)
    end

    @test_throws ArgumentError MPI.Buffer(falses(N))
end

MPI.Finalize()
# @test MPI.Finalized()
