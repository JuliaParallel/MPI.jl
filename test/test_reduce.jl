using Test
using MPI

if get(ENV,"JULIA_MPI_TEST_ARRAYTYPE","") == "CuArray"
    import CUDA
    ArrayType = CUDA.CuArray
else
    ArrayType = Array
end

# Closures might not be supported by cfunction
#@info :test_reduce 0
const can_do_closures =
    ArrayType === Array &&
    !(MPI.MPI_LIBRARY == MPI.MicrosoftMPI && Sys.WORD_SIZE == 32) &&
    Sys.ARCH !== :powerpc64le &&
    Sys.ARCH !== :ppc64le &&
    Sys.ARCH !== :aarch64 &&
    !startswith(string(Sys.ARCH), "arm")

#@info :test_reduce 1
using DoubleFloats

#@info :test_reduce 2
MPI.Init()

#@info :test_reduce 3
comm = MPI.COMM_WORLD
sz = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

root = sz-1
isroot = rank == root

#@info :test_reduce 4
val = isroot ? sum(0:sz-1) : nothing
@test MPI.Reduce(rank, MPI.SUM, comm; root=root) == val
@test MPI.Reduce(rank, +, comm; root=root) == val

#@info :test_reduce 5
val = isroot ? sz-1 : nothing
@test MPI.Reduce(rank, MPI.MAX, comm; root=root) == val
@test MPI.Reduce(rank, max, comm; root=root) == val

#@info :test_reduce 6
val = isroot ? 0 : nothing
@test MPI.Reduce(rank, MPI.MIN, comm; root=root) == val
@test MPI.Reduce(rank, min, comm; root=root) == val

#@info :test_reduce 7
val = isroot ? sz : nothing
@test MPI.Reduce(1, +, root, comm) == val

#@info :test_reduce 8
mesg = ArrayType(1.0:5.0)
sum_mesg = MPI.Reduce(mesg, +, comm; root=root)
if isroot
    @test sum_mesg isa ArrayType{Float64}
    @test sum_mesg == sz .* mesg
end

#@info :test_reduce 9
if can_do_closures
    operators = [MPI.SUM, +, (x,y) -> 2x+y-x]
else
    operators = [MPI.SUM, +]
end

#@info :test_reduce 10
for T = [Int]
    #@info :test_reduce 11 T
    for dims = [1, 2, 3]
        #@info :test_reduce 12 dims
        send_arr = ArrayType(zeros(T, Tuple(3 for i in 1:dims)))
        send_arr[:] .= 1:length(send_arr)

        for op in operators
            #@info :test_reduce 13 op

            # Non allocating version
            recv_arr = ArrayType{T}(undef, size(send_arr))
            MPI.Reduce!(send_arr, recv_arr, op, MPI.COMM_WORLD; root=root)
            if isroot
                @test recv_arr == sz .* send_arr
            end

            #@info :test_reduce 14
            # Assertions when output buffer too small
            recv_arr = ArrayType{T}(undef, size(send_arr).-1)
            if isroot
                @test_throws AssertionError MPI.Reduce!(send_arr, recv_arr, op, MPI.COMM_WORLD; root=root)
            end

            #@info :test_reduce 15
            # IN_PLACE
            recv_arr = copy(send_arr)
            MPI.Reduce!(recv_arr, op, MPI.COMM_WORLD; root=root)
            if isroot
                @test recv_arr == sz .* send_arr
            end

            #@info :test_reduce 16
            # Allocating version
            r = MPI.Reduce(2, op, MPI.COMM_WORLD; root=root)
            if isroot
                @test r == sz*2
            end

            #@info :test_reduce 17
            recv_arr = MPI.Reduce(send_arr, op, MPI.COMM_WORLD; root=root)
            if isroot
                @test recv_arr isa ArrayType{T}
                @test recv_arr == sz .* send_arr
            end

            #@info :test_reduce 18
            # Allocating, Subarray
            recv_arr = MPI.Reduce(view(send_arr, 2:3), op, MPI.COMM_WORLD; root=root)
            if isroot
                @test recv_arr isa ArrayType{T}
                @test recv_arr == sz .* view(send_arr, 2:3)
            end
            #@info :test_reduce 19
        end
    end
end

#TODO #@info :test_reduce 20
#TODO MPI.Barrier( MPI.COMM_WORLD )
#TODO #@info :test_reduce 21
#TODO 
#TODO if can_do_closures
#TODO     #@info :test_reduce 22
#TODO     send_arr = [Double64(i)/10 for i = 1:10]
#TODO 
#TODO     #@info :test_reduce 23
#TODO     result = MPI.Reduce(send_arr, +, MPI.COMM_WORLD; root=root)
#TODO     #@info :test_reduce 24
#TODO     if rank == root
#TODO         @test result ≈ [Double64(sz*i)/10 for i = 1:10] rtol=sz*eps(Double64)
#TODO     else
#TODO         @test result === nothing
#TODO     end
#TODO 
#TODO     #@info :test_reduce 25
#TODO     MPI.Barrier( MPI.COMM_WORLD )
#TODO     #@info :test_reduce 26
#TODO end

#@info :test_reduce 27
#TODO GC.gc()
#@info :test_reduce 28
MPI.Finalize()
#@info :test_reduce 29
@test MPI.Finalized()
#@info :test_reduce 20
