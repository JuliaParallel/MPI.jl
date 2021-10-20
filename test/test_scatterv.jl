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
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)
root = 0
isroot = rank == root

counts = Cint[mod(i,2) + 1 for i in 0:(size-1)]
ref = collect(Iterators.flatten([fill(r, counts[r+1]) for r = 0:size-1]))

for T in Base.uniontypes(MPI.MPIDatatype)
    A = isroot ? ArrayType{T}(ref) : nothing

    # Non Allocating
    B = ArrayType{T}(undef, counts[rank+1])
    MPI.Scatterv!(isroot ? VBuffer(A, counts) : nothing, B, comm; root=root)
    @test B == ArrayType{T}(fill(rank, counts[rank+1]))

    # IN_PLACE
    B = isroot ? copy(A) : ArrayType{T}(undef, counts[rank+1])
    if root == MPI.Comm_rank(comm)
        MPI.Scatterv!(VBuffer(B, counts), MPI.IN_PLACE, comm; root=root)
    else
        MPI.Scatterv!(nothing, B, comm; root=root)
    end
    if isroot
        @test B == A
    else
        @test B == ArrayType{T}(fill(rank, counts[rank+1]))
    end
end

MPI.Finalize()
@test MPI.Finalized()
