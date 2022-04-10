using Test
using MPI

if get(ENV,"JULIA_MPI_TEST_ARRAYTYPE","") == "CuArray"
    import CUDA
    ArrayType = CUDA.CuArray
elseif get(ENV,"JULIA_MPI_TEST_ARRAYTYPE","") == "ROCArray"
    import AMDGPU
    ArrayType = AMDGPU.ROCArray
else
    ArrayType = Array
end

provided = MPI.Init(threadlevel=:multiple)

@test MPI.THREAD_SINGLE <= provided <= MPI.THREAD_MULTIPLE
@test MPI.Query_thread() == provided
@test MPI.Is_thread_main()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

const N = 10

dst = mod(rank+1, size)
src = mod(rank-1, size)

if provided == MPI.THREAD_MULTIPLE
    send_arr = collect(1.0:N)
    recv_arr = zeros(N)

    reqs = Array{MPI.Request}(undef, 2N)

    Threads.@threads for i = 1:N
        reqs[N+i] = MPI.Irecv!(@view(recv_arr[i:i]), src, i, comm)
        reqs[i] = MPI.Isend(@view(send_arr[i:i]), dst, i, comm)
    end

    MPI.Waitall!(reqs)

    @test recv_arr == send_arr
end

MPI.Finalize()
