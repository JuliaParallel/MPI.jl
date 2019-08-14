using Test, Pkg
using MPI

if haskey(Pkg.installed(), "CuArrays")
    using CuArrays
    ArrayType = CuArray
else
    ArrayType = Array
end

MPI.Init()

comm_size = MPI.Comm_size(MPI.COMM_WORLD)

if ArrayType != Array || Sys.iswindows() && Sys.WORD_SIZE == 32
    operators = [MPI.SUM, +]
else
    operators = [MPI.SUM, +, (x,y) -> 2x+y-x]
end    

for T = [Int]
    for dims = [1, 2, 3]
        send_arr = ArrayType(zeros(T, Tuple(3 for i in 1:dims)))
        send_arr[:] .= 1:length(send_arr)

        for op in operators

            # Non allocating version
            recv_arr = ArrayType{T}(undef, size(send_arr))
            MPI.Allreduce!(send_arr, recv_arr, op, MPI.COMM_WORLD)
            @test recv_arr == comm_size .* send_arr

            # Assertions when output buffer too small
            recv_arr = ArrayType{T}(undef, size(send_arr).-1)
            @test_throws AssertionError MPI.Allreduce!(send_arr, recv_arr,
                                                       length(send_arr),
                                                        op, MPI.COMM_WORLD)

            recv_arr = copy(send_arr)
            MPI.Allreduce!(MPI.IN_PLACE, recv_arr, op, MPI.COMM_WORLD)
            @test recv_arr == comm_size .* send_arr

            # IN_PLACE
            recv_arr = copy(send_arr)
            MPI.Allreduce!(recv_arr, op, MPI.COMM_WORLD)
            @test recv_arr == comm_size .* send_arr
            
            # Allocating version
            val = MPI.Allreduce(2, op, MPI.COMM_WORLD)
            @test val == comm_size*2

            vals = MPI.Allreduce(send_arr, op, MPI.COMM_WORLD)
            @test vals isa ArrayType{T}
            @test vals == comm_size .* send_arr
        end
    end
end

MPI.Barrier( MPI.COMM_WORLD )

GC.gc()
MPI.Finalize()
@test MPI.Finalized()
