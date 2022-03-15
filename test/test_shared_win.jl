using MPI: MPI, Comm, Win
using Test

"""
Create a shared array, allocated by process with rank `owner_rank` on the
node_comm provided (i.e. when `MPI.Comm_rank(node_comm) == owner_rank`). Assumes all
processes on the node_comm are on the same node, or, more precisely that they
can create/access a shared mem block between them.

usage:
nrows, ncols = 100, 11
const arr = mpi_shared_array(MPI.COMM_WORLD, Int, (nrows, nworkers_node), owner_rank=0)
"""
function mpi_shared_array(node_comm::Comm, ::Type{T}, sz::Tuple{Vararg{Int}}; owner_rank=0) where T
    node_rank = MPI.Comm_rank(node_comm)
    len_to_alloc = MPI.Comm_rank(node_comm) == owner_rank ? prod(sz) : 0
    if node_rank == owner_rank
        win, array = MPI.Win_allocate_shared(Array{T}, sz, node_comm)
    else
        win, array = MPI.Win_allocate_shared(Array{T}, 0, node_comm)
    end
    if node_rank != owner_rank
        array = MPI.Win_shared_query(Array{T}, sz, win, owner_rank)
    end
    win, array
end

function main()
    MPI.Init()

    global_comm = MPI.COMM_WORLD

    if MPI.Comm_size(global_comm) > 1

        group_comm_id = 1
        node_rank = MPI.Comm_rank(global_comm) # do this differently in real code
        node_comm = MPI.Comm_split(global_comm, group_comm_id, node_rank)
        owner_rank = 1

        win, shared_arr =
            mpi_shared_array(node_comm, Float32, (100, 2); owner_rank=owner_rank)

        if node_rank == 0
            shared_arr[:, 1] .= 1:100
        elseif node_rank == 1
            shared_arr[:, 2] .= 901:1000
        end

        MPI.Barrier(node_comm) # finish writing before reading
        # check you can see those values on all processes
        @test all(shared_arr[:, 1] .== 1:100)
        @test all(shared_arr[:, 2] .== 901:1000)
        if node_rank <= 1
            len, elsize_bytes, baseptr = MPI.Win_shared_query(Ptr{Float32}, win, owner_rank)
            @test elsize_bytes == sizeof(Float32)
            @test len == sizeof(shared_arr)
            @test baseptr == pointer(shared_arr)
        end
        MPI.free(win)

    end

    MPI.Finalize()
end

# run with `mpirun -np 3 julia --project test_shared_win.jl`
main()
GC.gc()

@test MPI.Finalized()
