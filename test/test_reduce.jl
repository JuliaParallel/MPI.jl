using Test, Pkg
using MPI

if haskey(Pkg.installed(), "CuArrays")
    using CuArrays
    ArrayType = CuArray
else
    ArrayType = Array
end
using DoubleFloats

MPI.Init()

comm = MPI.COMM_WORLD
sz = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

root = sz-1
isroot = rank == root

val = isroot ? sum(0:sz-1) : nothing
@test MPI.Reduce(rank, MPI.SUM, root, comm) == val

val = isroot ? sz-1 : nothing
@test MPI.Reduce(rank, MPI.MAX, root, comm) == val

val = isroot ? 0 : nothing
@test MPI.Reduce(rank, MPI.MIN, root, comm) == val

val = isroot ? sz : nothing
@test MPI.Reduce(1, +, root, comm) == val

mesg = ArrayType(1.0:5.0)
sum_mesg = MPI.Reduce(mesg, +, root, comm)
if isroot
    @test sum_mesg isa ArrayType{Float64}
    @test sum_mesg == sz .* mesg
end

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
            MPI.Reduce!(send_arr, recv_arr, op, root, MPI.COMM_WORLD)
            if isroot
                @test recv_arr == sz .* send_arr
            end

            # Assertions when output buffer too small
            recv_arr = ArrayType{T}(undef, size(send_arr).-1)
            if isroot
                @test_throws AssertionError MPI.Reduce!(send_arr, recv_arr,
                                                        length(send_arr),
                                                        op, root,
                                                        MPI.COMM_WORLD)
            end
            
            # IN_PLACE
            recv_arr = copy(send_arr)
            MPI.Reduce_in_place!(recv_arr, length(recv_arr), op, root, MPI.COMM_WORLD)
            if isroot
                @test recv_arr == sz .* send_arr
            end

            # Allocating version
            val = MPI.Reduce(2, op, root, MPI.COMM_WORLD)
            if isroot
                @test val == sz*2
            end
            
            recv_arr = MPI.Reduce(send_arr, op, root, MPI.COMM_WORLD)
            if isroot
                @test recv_arr isa ArrayType{T}
                @test recv_arr == sz .* send_arr
            end

            # Allocating, Subarray
            recv_arr = MPI.Reduce(view(send_arr, 2:3), op, root, MPI.COMM_WORLD)
            if isroot
                @test recv_arr isa ArrayType{T}
                @test recv_arr == sz .* view(send_arr, 2:3)
            end                
        end
    end
end

MPI.Barrier( MPI.COMM_WORLD )

if !(Sys.iswindows() && Sys.WORD_SIZE == 32)

    send_arr = [Double64(i)/10 for i = 1:10]

    if rank == root
        @test MPI.Reduce(send_arr, +, root, MPI.COMM_WORLD) ≈ [Double64(sz*i)/10 for i = 1:10] rtol=sz*eps(Double64)
    else
        @test MPI.Reduce(send_arr, +, root, MPI.COMM_WORLD) === nothing
    end

    MPI.Barrier( MPI.COMM_WORLD )
end

GC.gc()
MPI.Finalize()
@test MPI.Finalized()
