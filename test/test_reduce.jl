include("common.jl")

# Closures might not be supported by cfunction
const can_do_closures =
    ArrayType === Array &&
    !(MPI.MPI_LIBRARY == "MicrosoftMPI" && Sys.WORD_SIZE == 32) &&
    Sys.ARCH !== :powerpc64le &&
    Sys.ARCH !== :ppc64le &&
    Sys.ARCH !== :aarch64 &&
    !startswith(string(Sys.ARCH), "arm")

using DoubleFloats

MPI.Init()

comm = MPI.COMM_WORLD
sz = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

root = sz-1
isroot = rank == root

val = isroot ? sum(0:sz-1) : nothing
@test MPI.Reduce(rank, MPI.SUM, comm; root=root) == val
@test MPI.Reduce(rank, +, comm; root=root) == val

val = isroot ? sz-1 : nothing
@test MPI.Reduce(rank, MPI.MAX, comm; root=root) == val
@test MPI.Reduce(rank, max, comm; root=root) == val

val = isroot ? 0 : nothing
@test MPI.Reduce(rank, MPI.MIN, comm; root=root) == val
@test MPI.Reduce(rank, min, comm; root=root) == val

val = isroot ? sz : nothing
@test MPI.Reduce(1, +, root, comm) == val

mesg = ArrayType(1.0:5.0)
synchronize()
sum_mesg = MPI.Reduce(mesg, +, comm; root=root)
if isroot
    @test sum_mesg isa ArrayType{Float64}
    @test sum_mesg == sz .* mesg
end

if can_do_closures
    operators = [MPI.SUM, +, (x,y) -> 2x+y-x]
else
    operators = [MPI.SUM, +]
end

for T = [Int]
    for dims = [1, 2, 3]
        send_arr = ArrayType(zeros(T, Tuple(3 for i in 1:dims)))
        send_arr[:] .= 1:length(send_arr)
        synchronize()

        for op in operators

            # Non allocating version
            recv_arr = ArrayType{T}(undef, size(send_arr))
            MPI.Reduce!(send_arr, recv_arr, op, MPI.COMM_WORLD; root=root)
            if isroot
                @test recv_arr == sz .* send_arr
            end

            # Assertions when output buffer too small
            recv_arr = ArrayType{T}(undef, size(send_arr).-1)
            if isroot
                @test_throws AssertionError MPI.Reduce!(send_arr, recv_arr, op, MPI.COMM_WORLD; root=root)
            end

            # IN_PLACE
            recv_arr = copy(send_arr)
            MPI.Reduce!(recv_arr, op, MPI.COMM_WORLD; root=root)
            if isroot
                @test recv_arr == sz .* send_arr
            end

            # Allocating version
            r = MPI.Reduce(2, op, MPI.COMM_WORLD; root=root)
            if isroot
                @test r == sz*2
            end

            recv_arr = MPI.Reduce(send_arr, op, MPI.COMM_WORLD; root=root)
            if isroot
                @test recv_arr isa ArrayType{T}
                @test recv_arr == sz .* send_arr
            end

            # Allocating, Subarray
            recv_arr = MPI.Reduce(view(send_arr, 2:3), op, MPI.COMM_WORLD; root=root)
            if isroot
                @test recv_arr isa ArrayType{T}
                @test recv_arr == sz .* view(send_arr, 2:3)
            end
        end
    end
end

MPI.Barrier( MPI.COMM_WORLD )

if can_do_closures
    send_arr = [Double64(i)/10 for i = 1:10]

    result = MPI.Reduce(send_arr, +, MPI.COMM_WORLD; root=root)
    if rank == root
        @test result ≈ [Double64(sz*i)/10 for i = 1:10] rtol=sz*eps(Double64)
    else
        @test result === nothing
    end

    MPI.Barrier( MPI.COMM_WORLD )
end

GC.gc()
MPI.Finalize()
@test MPI.Finalized()
