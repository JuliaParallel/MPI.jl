import .CuArrays: CuArray
import .CuArrays.CUDAdrv: CuPtr

function Isend(buf::CuArray{T}, dest::Integer, tag::Integer, comm::MPI.Comm) where T
    GC.@preserve buf begin
        _buf = Base.cconvert(CuPtr{T}, buf)
        cuptr = Base.unsafe_convert(CuPtr{T}, _buf)
        ptr = reinterpret(Ptr{T}, cuptr)
        MPI.Isend(ptr, length(buf), dest, tag, comm)
    end
end

function Irecv!(buf::CuArray{T}, src::Integer, tag::Integer, comm::MPI.Comm) where T
    GC.@preserve buf begin
        _buf = Base.cconvert(CuPtr{T}, buf)
        cuptr = Base.unsafe_convert(CuPtr{T}, _buf)
        ptr = reinterpret(Ptr{T}, cuptr)
        MPI.Irecv!(ptr, length(buf), src, tag, comm)
    end
end