module CUDAExt

using CUDA: CUDA
using MPI: MPI, Buffer, Datatype, mpi_ptr_type

MPI.mpi_ptr_type(::CUDA.CuArray{T}) where T = CUDA.CuPtr{T}

function MPI.Buffer(arr::CUDA.CuArray)
    Buffer(arr, Cint(length(arr)), Datatype(eltype(arr)))
end

end #CUDAExt
