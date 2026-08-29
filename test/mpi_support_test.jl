include("common.jl")

MPI.Init()

# Those MPI calls may be unsupported features (e.g. for GPU backends), and will raise SIGSEGV
# (or a similar signal) when called, which cannot be handled in Julia in a portable way.

op = ARGS[1]
if op == "Allreduce"
    # Allreduce is unsupported for AMDGPU with UCX
    send_arr = ArrayType(zeros(Int, 1))
    recv_arr = ArrayType{Int}(undef, 1)
    synchronize()
    MPI.Allreduce!(send_arr, recv_arr, +, MPI.COMM_WORLD)

elseif op == "Iallreduce"
    # Iallreduce is unsupported for CUDA with OpenMPI 5 + UCX
    send_arr = ArrayType(zeros(Int, 1))
    recv_arr = ArrayType{Int}(undef, 1)
    synchronize()
    req = MPI.Iallreduce!(send_arr, recv_arr, +, MPI.COMM_WORLD)
    MPI.Wait(req)

elseif op == "Reduce"
    # Reduce is unsupported for AMDGPU with UCX
    send_arr = ArrayType(zeros(Int, 1))
    recv_arr = ArrayType{Int}(undef, 1)
    synchronize()
    MPI.Reduce!(send_arr, recv_arr, +, MPI.COMM_WORLD; root=0)

elseif op == "Ireduce"
    # Ireduce is unsupported for CUDA with OpenMPI 5 + UCX
    send_arr = ArrayType(zeros(Int, 1))
    recv_arr = ArrayType{Int}(undef, 1)
    synchronize()
    req = MPI.Ireduce!(send_arr, recv_arr, +, MPI.COMM_WORLD; root=0)
    MPI.Wait(req)

else
    error("unknown test: $op")
end
