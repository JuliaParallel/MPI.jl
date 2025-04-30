include("common.jl")

MPI.Init()

comm = MPI.COMM_WORLD
root = 0
rank = MPI.Comm_rank(comm)
sz   = MPI.Comm_size(comm)
isroot = MPI.Comm_rank(comm) == root

for T in MPITestTypes

    # Allocating
    A = ArrayType{T}(fill(T(rank+1), 4))
    synchronize()
    C = MPI.Gather(A, comm; root=root)
    if isroot
        @test C isa ArrayType{T}
        @test C == ArrayType{T}(repeat(1:sz, inner=4))
    end

    # Allocating, object
    C = MPI.Gather(T(rank+1), comm; root=root)
    if isroot
        @test C isa Vector{T}
        @test C == Vector{T}(1:sz)
    else
        @test C === nothing
    end

    # Allocating, array
    A = ArrayType{T}([MPI.Comm_rank(comm) + 1])
    synchronize()
    C = MPI.Gather(A, comm; root=root)
    if isroot
        @test C isa ArrayType{T}
        @test C == ArrayType{T}(1:MPI.Comm_size(comm))
    else
        @test C === nothing
    end

    # Allocating, view
    A = ArrayType{T}([MPI.Comm_rank(comm) + 1, 0])
    synchronize()
    C = MPI.Gather(view(A, 1:1), comm; root=root)
    if isroot
        @test C isa ArrayType{T}
        @test C == ArrayType{T}(1:MPI.Comm_size(comm))
    end

    # Non Allocating
    A = ArrayType{T}(fill(T(rank+1), 4))
    synchronize()
    C = ArrayType{T}(undef, 4sz)
    MPI.Gather!(A, C, comm; root=root)
    if isroot
        @test C == ArrayType{T}(repeat(1:sz, inner=4))
    end
    MPI.Gather!(A, UBuffer(C,4), comm; root=root)
    if isroot
        @test C == ArrayType{T}(repeat(1:sz, inner=4))
    end

    # In_place
    A = ArrayType{T}(fill(T(rank+1), 4))
    if isroot
        A = ArrayType{T}(fill(T(rank+1), 4*sz))
    end
    synchronize()
    if root == MPI.Comm_rank(comm)
        MPI.Gather!(MPI.IN_PLACE, UBuffer(A,4), comm; root=root)
    else
        MPI.Gather!(A, nothing, comm; root=root)
    end
    if isroot
        @test A == ArrayType{T}(repeat(1:sz, inner=4))
    end

    # serializing version
    C = MPI.gather(T(rank+1), comm; root=root)
    if isroot
        @test C isa Vector{T}
        @test C == Vector{T}(1:sz)
    else
        @test C === nothing
    end
end


objs = ["test", 1, Array{Int}, [1,"test"]]
obj = objs[mod(rank, length(objs))+1]

C = MPI.gather(obj, comm; root=root)
if isroot
    @test C == [objs[mod1(i, length(objs))] for i = 1:sz]
else
    @test C === nothing
end

# Test that the number of ranks is as expected:
# <https://github.com/JuliaParallel/MPI.jl/issues/905>.
num_processes = get(ENV, "JULIA_MPI_TEST_NUM_PROCESSES", nothing)
if isnothing(num_processes)
    @test_broken false
else
    ranks = MPI.Gather(rank, comm)
    comm_sizes = MPI.Gather(sz, comm)

    if isroot
        n = parse(Int, num_processes)
        # Note: there's a similar test above, but not comparing with the
        # externally set `JULIA_MPI_TEST_NUM_PROCESSES`.
        @test sort(ranks) == 0:(n - 1)
        @test all(==(n), comm_sizes)
    end
end

MPI.Finalize()
@test MPI.Finalized()
