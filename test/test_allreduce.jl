include("common.jl")

MPI.Init()

comm_size = MPI.Comm_size(MPI.COMM_WORLD)

if ArrayType != Array ||
   MPI.MPI_LIBRARY == "MicrosoftMPI" && Sys.WORD_SIZE == 32 ||
   Sys.ARCH === :powerpc64le || Sys.ARCH === :ppc64le ||
   Sys.ARCH === :aarch64 || startswith(string(Sys.ARCH), "arm")
    operators = [MPI.SUM, +]
else
    operators = [MPI.SUM, +, (x,y) -> 2x+y-x]
end

for T = [Int]
    for dims = [1, 2, 3]
        send_arr = ArrayType(zeros(T, Tuple(3 for i in 1:dims)))
        send_arr[:] .= 1:length(send_arr)
        synchronize()

        for op in operators

            # Non allocating version
            recv_arr = ArrayType{T}(undef, size(send_arr))
            MPI.Allreduce!(send_arr, recv_arr, op, MPI.COMM_WORLD)
            @test recv_arr == comm_size .* send_arr

            # Assertions when output buffer too small
            recv_arr = ArrayType{T}(undef, size(send_arr).-1)
            @test_throws AssertionError MPI.Allreduce!(send_arr, recv_arr,
                                                       op, MPI.COMM_WORLD)
            # IN_PLACE
            recv_arr = copy(send_arr)
            synchronize()
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
