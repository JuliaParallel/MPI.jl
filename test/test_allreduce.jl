using Test
using MPI

MPI.Init()

comm_size = MPI.Comm_size(MPI.COMM_WORLD)

for typ=[Int]
    for dims = [1, 2, 3]
        send_arr = zeros(typ, Tuple(3 for i in 1:dims))
        send_arr[:] .= 1:length(send_arr)

        for op in (MPI.SUM, +, (x,y) -> 2x+y-x)

            # Non allocating version
            recv_arr = zeros(typ, size(send_arr))
            MPI.Allreduce!(send_arr, recv_arr, op, MPI.COMM_WORLD)
            for i=1:length(recv_arr)
                @test recv_arr[i] == comm_size*send_arr[i]
            end

            # Assertions when output buffer too small
            recv_arr = zeros(typ, size(send_arr).-1)
            @test_throws AssertionError MPI.Allreduce!(send_arr, recv_arr,
                                                       length(send_arr),
                                                        op, MPI.COMM_WORLD)

            recv_arr = deepcopy(send_arr)
            MPI.Allreduce!(MPI.IN_PLACE, recv_arr, op, MPI.COMM_WORLD)
            for i=1:length(recv_arr)
                @test recv_arr[i] == comm_size*send_arr[i]
            end

            # IN_PLACE
            recv_arr = deepcopy(send_arr)
            MPI.Allreduce!(recv_arr, op, MPI.COMM_WORLD)
            for i=1:length(recv_arr)
                @test recv_arr[i] == comm_size*send_arr[i]
            end

            # Allocating version
            val = MPI.Allreduce(2, op, MPI.COMM_WORLD)
            @test val == comm_size*2

            vals = MPI.Allreduce(send_arr, op, MPI.COMM_WORLD)
            for i=1:length(recv_arr)
                @test vals[i] == comm_size*send_arr[i]
                @test length(vals) == length(send_arr)
                @test eltype(vals) == typ
            end
        end
    end
end

MPI.Barrier( MPI.COMM_WORLD )
MPI.Finalize()
