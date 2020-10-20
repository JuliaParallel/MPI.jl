using Test
using MPI

if get(ENV,"JULIA_MPI_TEST_ARRAYTYPE","") == "CuArray"
    import CUDA
    ArrayType = CUDA.CuArray
else
    ArrayType = Array
end

MPI.Init()

comm = MPI.COMM_WORLD
root = 0
rank = MPI.Comm_rank(comm)
sz   = MPI.Comm_size(comm)
isroot = MPI.Comm_rank(comm) == root

for T in Base.uniontypes(MPI.MPIDatatype)

    # Allocating
    A = ArrayType{T}(fill(T(rank+1), 4))
    C = MPI.Gather(A, root, comm)
    if isroot
        @test C isa ArrayType{T}
        @test C == ArrayType{T}(repeat(1:sz, inner=4))
    end

    # Allocating, object
    C = MPI.Gather(T(rank+1), root, comm)
    if isroot
        @test C isa Vector{T}
        @test C == Vector{T}(1:sz)
    end

    # Allocating, explicit length
    A = ArrayType{T}([MPI.Comm_rank(comm) + 1, 0])
    C = MPI.Gather(A, 1, root, comm)
    if isroot
        @test C isa ArrayType{T}
        @test C == ArrayType{T}(1:MPI.Comm_size(comm))
    end

    # Allocating, view
    A = ArrayType{T}([MPI.Comm_rank(comm) + 1, 0])
    C = MPI.Gather(view(A, 1:1), root, comm)
    if isroot
        @test C isa ArrayType{T}
        @test C == ArrayType{T}(1:MPI.Comm_size(comm))
    end

    # Non Allocating
    A = ArrayType{T}(fill(T(rank+1), 4))
    C = ArrayType{T}(undef, 4sz)
    MPI.Gather!(A, C, length(A), root, comm)
    if isroot
        @test C == ArrayType{T}(repeat(1:sz, inner=4))
    end

    # In_place
    A = ArrayType{T}(fill(T(rank+1), 4))
    if isroot
        A = ArrayType{T}(fill(T(rank+1), 4*sz))
    end
    if root == MPI.Comm_rank(comm)
        MPI.Gather!(MPI.IN_PLACE, A, 4, root, comm)
    else
        MPI.Gather!(A, nothing, 4, root, comm)
    end
    if isroot
        @test A == ArrayType{T}(repeat(1:sz, inner=4))
    end

end

MPI.Finalize()
@test MPI.Finalized()
