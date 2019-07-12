import .CuArrays: CuArray
import .CuArrays.CUDAdrv: CuPtr, synchronize
import .CuArrays.CUDAdrv.Mem: DeviceBuffer

MPIPtr(x::CuArray{T}) where T = reinterpret(MPIPtr, Base.unsafe_convert(x))

function Base.cconvert(::Type{MPIPtr}, buf::CuArray{T}) where T
    Base.cconvert(CuPtr{T}, buf) # returns DeviceBuffer
end

function Base.unsafe_convert(::Type{MPIPtr}, buf::DeviceBuffer)
    reinterpret(MPIPtr, buf.ptr)
end


#=
function Send(buf::CuArray{T}, dest::Integer, tag::Integer, 
                comm::MPI.Comm) where T
    GC.@preserve buf begin
        ptr = get_ptr(buf)
        MPI.Send(ptr, length(buf), src, tag, comm)
    end
end

function Recv!(buf::CuArray{T}, src::Integer, tag::Integer, 
                comm::MPI.Comm) where T
    GC.@preserve buf begin
        ptr = get_ptr(buf)
        MPI.Recv!(ptr, length(buf), src, tag, comm)
    end
end
function Reduce(sendbuf::CuArray{T,N}, op::Union{Op, Function}, 
                    root::Integer, comm::Comm) where {T,N}
    GC.@preserve sendbuf begin
        recvbuf = CuArray{T,N}(undef, isroot ? size(sendbuf) : Tuple(zeros(Int, ndims(sendbuf))))
        MPI.Reduce!(sendbuf, recvbuf, op, root, comm)
    end
end

function Allreduce!(sendbuf::CuArray{T,N}, recvbuf::CuArray{T,N},
                    op::Union{Op, Function}, comm::Comm) where {T, N}
    GC.@preserve sendbuf recvbuf begin
        sendptr = get_ptr(sendbuf)
        recvptr = get_ptr(recvbuf)
        MPI.Allreduce!(sendptr, recvptr, length(recvbuf), op, comm)
    end
end

function Allreduce(sendbuf::CuArray{T,N}, op::Union{Op, Function}, 
                    comm::Comm) where {T, N}
    GC.@preserve sendbuf begin
        recvbuf = CuArray{T, N}(undef, size(sendbuf))
        MPI.Allreduce!(sendbuf, recvbuf, length(sendbuf), op, comm)
    end
end

function Scatter!(sendbuf::CuArray{T}, recvbuf::CuArray{T}, count::Integer,
                    root::Integer, comm::Comm) where T
    GC.@preserve sendbuf recvbuf begin
        sendptr = get_ptr(sendbuf)
        recvptr = get_ptr(recvbuf)
        Scatter!(sendptr, recvptr, count, root, comm)
    end
end

function Scatter(sendbuf::CuArray{T}, count::Integer, root::Integer,
                    comm::Comm) where T
    GC.@preserve sendbuf begin
        recvbuf = CuArray{T}(undef, count)
        Scatter!(sendbuf, recvbuf, count, root, comm)
    end
end

function Scatterv!(sendbuf::CuArray{T}, recvbuf::CuArray{T},
                    counts::Vector{Cint}, root::Integer, comm::Comm) where T
    GC.@preserve sendbuf recvbuf begin
        sendptr = get_ptr(sendbuf)
        recvptr = get_ptr(recvbuf)
        Scatterv!(sendptr, recvptr, counts, root, comm)
    end
end

function Scatterv(sendbuf::CuArray{T}, counts::Vector{Cint}, root::Integer,
                    comm::Comm) where T
    GC.@preserve sendbuf begin
        recvbuf = CuArray{T}(undef, counts[Comm_rank(comm) + 1])
        Scatterv!(sendbuf, recvbuf, counts, root, comm)
    end
end

function Gather!(sendbuf::CuArray{T}, recvbuf::CuArray{T}, count::Integer,
                    root::Integer, comm::Comm) where T
    GC.@preserve sendbuf recvbuf begin
        sendptr = get_ptr(sendbuf)
        recvptr = get_ptr(recvbuf)
        Gather!(sendptr, recvptr, count, root, comm)
    end
end

function Gather!(sendbuf::CuArray{T}, recvbuf::CuArray{T}, 
                    root::Integer, comm::Comm) where T
    GC.@preserve sendbuf recvbuf begin
        Gather!(sendbuf, recvbuf, length(sendbuf), root, comm)
    end
end

function Gather(sendbuf::CuArray{T}, count::Integer, root::Integer,
                comm::Comm) where T
    GC.@preserve sendbuf begin
        isroot = Comm_rank(comm) == root
        recvbuf = CuArray{T}(undef, isroot ? Comm_size(comm) * count : 0)
        Gather!(sendbuf, recvbuf, count, root, comm)
    end
end

function Gather(sendbuf::CuArray{T}, root::Integer, comm::Comm) where T
    Gather(sendbuf, length(sendbuf), root, comm)
end

function Gatherv!(sendbuf::CuArray{T}, recvbuf::CuArray{T}, 
                    counts::Vector{Cint}, root::Integer, comm::Comm) where T
    GC.@preserve sendbuf recvbuf begin
        sendptr = get_ptr(sendbuf)
        recvptr = get_ptr(recvbuf)
        Gather!(sendptr, recvptr, counts, root, comm)
    end
end

function Allgather!(sendbuf::CuArray{T}, recvbuf::CuArray{T},
                    count::Integer, comm::Comm) where T
    GC.@preserve sendbuf recvbuf begin
        sendptr = get_ptr(sendbuf)
        recvptr = get_ptr(recvbuf)
        Allgather!(sendptr, recvptr, count, comm)
    end
end

function Allgatherv!(sendbuf::CuArray{T}, recvbuf::CuArray{T},
                        counts::Vector{Cint}, comm::Comm) where T
    GC.@preserve sendbuf recvbuf begin
        sendptr = get_ptr(sendbuf)
        recvptr = get_ptr(recvbuf)
        Allgatherv!(sendptr, recvptr, counts, comm)
    end
end
=#
