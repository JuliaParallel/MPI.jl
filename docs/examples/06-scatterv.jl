# This example shows how to use MPI.Scatterv! and MPI.Gatherv!
# roughly based on the example from
# https://stackoverflow.com/a/36082684/392585

using MPI

"""
    split_count(N::Integer, n::Integer)

Return a vector of `n` integers which are approximately equally sized and sum to `N`.
"""
function split_count(N::Integer, n::Integer)
    q,r = divrem(N, n)
    return [i <= r ? q+1 : q for i = 1:n]
end


MPI.Init()

comm = MPI.COMM_WORLD
rank = MPI.Comm_rank(comm)
comm_size = MPI.Comm_size(comm)

root = 0

if rank == root
    M, N = 4, 7

    test = Float64[i for i = 1:M, j = 1:N]
    output = similar(test)
    
    # Julia arrays are stored in column-major order, so we need to split along the last dimension
    # dimension
    M_counts = [M for i = 1:comm_size]
    N_counts = split_count(N, comm_size)

    # store sizes in 2 * comm_size Array
    sizes = vcat(M_counts', N_counts')
    size_ubuf = UBuffer(sizes, 2)

    # store number of values to send to each rank in comm_size length Vector
    counts = vec(prod(sizes, dims=1))

    test_vbuf = VBuffer(test, counts) # VBuffer for scatter
    output_vbuf = VBuffer(output, counts) # VBuffer for gather
else
    # these variables can be set to `nothing` on non-root processes
    size_ubuf = UBuffer(nothing)
    output_vbuf = test_vbuf = VBuffer(nothing)
end

if rank == root
    println("Original matrix")
    println("================")
    @show test sizes counts
    println()
    println("Each rank")
    println("================")
end 
MPI.Barrier(comm)

local_size = MPI.Scatter(size_ubuf, NTuple{2,Int}, root, comm)
local_test = MPI.Scatterv!(test_vbuf, zeros(Float64, local_size), root, comm)

for i = 0:comm_size-1
    if rank == i
        @show rank local_test
    end
    MPI.Barrier(comm)
end

MPI.Gatherv!(local_test, output_vbuf, root, comm)

if rank == root
    println()
    println("Final matrix")
    println("================")
    @show output
end 
