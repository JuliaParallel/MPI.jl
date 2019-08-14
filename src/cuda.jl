import .CuArrays: CuArray
import .CuArrays.CUDAdrv: CuPtr, synchronize
import .CuArrays.CUDAdrv.Mem: DeviceBuffer

function Base.cconvert(::Type{MPIPtr}, buf::CuArray{T}) where T
    Base.cconvert(CuPtr{T}, buf) # returns DeviceBuffer
end

function Base.unsafe_convert(::Type{MPIPtr}, buf::DeviceBuffer)
    reinterpret(MPIPtr, buf.ptr)
end
