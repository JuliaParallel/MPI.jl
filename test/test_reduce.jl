using Test

using MPI
using LinearAlgebra

MPI.Init()

comm = MPI.COMM_WORLD
sz = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

root = sz-1
val = rank == root ? sum(0:sz-1) : nothing
@test MPI.Reduce(rank, MPI.SUM, root, comm) == val

val = rank == root ? sz-1 : nothing
@test MPI.Reduce(rank, MPI.MAX, root, comm) == val

val = rank == root ? 0 : nothing
@test MPI.Reduce(rank, MPI.MIN, root, comm) == val

val = rank == root ? sz : nothing
@test MPI.Reduce(1, +, root, comm) == val

mesg = collect(1.0:5.0)
sum_mesg = MPI.Reduce(mesg, MPI.SUM, root, comm)
sum_mesg = rank == root ? sum_mesg : sz*mesg
@test isapprox(norm(sum_mesg-sz*mesg), 0.0)


comm_size = MPI.Comm_size(MPI.COMM_WORLD)

send_arr = Int[1, 2, 3]

for typ=[Int]
    for dims = [1, 2, 3]
        send_arr = zeros(typ, Tuple(3 for i in 1:dims))
        send_arr[:] .= 1:length(send_arr)

        for op in (MPI.SUM, +, (x,y) -> 2x+y-x)

            # Non allocating version
            recv_arr = zeros(typ, size(send_arr))
            MPI.Reduce!(send_arr, recv_arr, op, root, MPI.COMM_WORLD)
            for i=1:length(recv_arr)
                @test rank == root ? recv_arr[i] == comm_size*send_arr[i] : true
            end

            # Assertions when output buffer too small
            recv_arr = zeros(typ, size(send_arr).-1)
            rank == root && @test_throws AssertionError MPI.Reduce!(send_arr,
                                                                recv_arr,
                                                                length(send_arr),
                                                                op, root,
                                                                MPI.COMM_WORLD)

            # IN_PLACE
            recv_arr = deepcopy(send_arr)
            MPI.Reduce_in_place!(recv_arr, length(recv_arr), op, root, MPI.COMM_WORLD)
            for i=1:length(recv_arr)
                @test rank == root ? recv_arr[i] == comm_size*send_arr[i] : true
            end

            # Allocating version
            val = MPI.Reduce(2, op, root, MPI.COMM_WORLD)
            @test rank == root ? val == comm_size*2 : true

            # Allocating, Subarray
            A = typ[1,2]
            val = MPI.Reduce(view(A, 2:2), op, root, MPI.COMM_WORLD)
            @test rank == root ? val[1] == comm_size*2 : true

            vals = MPI.Reduce(send_arr, op, root, MPI.COMM_WORLD)
            for i=1:length(recv_arr)
                @test rank == root ? vals[i] == comm_size*send_arr[i] : true
                @test rank == root ? length(vals) == length(send_arr) : true
                @test rank == root ? eltype(vals) == typ : true
            end
        end
    end
end


MPI.Barrier( MPI.COMM_WORLD )
MPI.Finalize()
