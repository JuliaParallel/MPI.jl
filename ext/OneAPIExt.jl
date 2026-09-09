module OneAPIExt

using oneAPI: oneAPI
using MPI: MPI, Buffer, Datatype, mpi_ptr_type

MPI.mpi_ptr_type(::oneAPI.oneArray{T}) where T = oneAPI.ZePtr{T}

function MPI.Buffer(arr::oneAPI.oneArray)
    Buffer(arr, Cint(length(arr)), Datatype(eltype(arr)))
end

end # OneAPIExt
