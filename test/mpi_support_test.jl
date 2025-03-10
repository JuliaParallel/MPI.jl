include("common.jl")

MPI.Init()

# Those MPI calls may be unsupported features (e.g. for GPU backends), and will raise SIGSEGV
# (or a similar signal) when called, which cannot be handled in Julia in a portable way.

op = ARGS[1]
if op == "IAllreduce"
    # IAllreduce is unsupported for CUDA with OpenMPI + UCX
    # See https://docs.open-mpi.org/en/main/tuning-apps/networking/cuda.html#which-mpi-apis-do-not-work-with-cuda-aware-ucx
    send_arr = ArrayType(zeros(Int, 1))
    recv_arr = ArrayType{Int}(undef, 1)
    synchronize()
    req = MPI.IAllreduce!(send_arr, recv_arr, +, MPI.COMM_WORLD)
    MPI.Wait(req)

elseif op == "IReduce"
    # IAllreduce is unsupported for CUDA with OpenMPI + UCX
    send_arr = ArrayType(zeros(Int, 1))
    recv_arr = ArrayType{Int}(undef, 1)
    synchronize()
    req = MPI.IReduce!(send_arr, recv_arr, +, MPI.COMM_WORLD; root=0)
    MPI.Wait(req)

else
    error("unknown test: $op")
end
