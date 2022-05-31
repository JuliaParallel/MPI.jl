include("common.jl")

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)
root = 0
isroot = rank == root

for T in Base.uniontypes(MPI.MPIDatatype)

    A = isroot ? ArrayType{T}(1:size) : ArrayType{T}(undef, 1)

    # Non Allocating version
    B = ArrayType{T}(undef, 1)
    MPI.Scatter!(A, B, comm; root=root)
    @test Array(B)[1] == T(rank+1)

    # In place version
    B = isroot ? copy(A) : ArrayType{T}(undef, 1)
    if root == MPI.Comm_rank(comm)
        MPI.Scatter!(UBuffer(B,1), MPI.IN_PLACE, comm; root=root)
    else
        MPI.Scatter!(nothing, B, comm; root=root)
    end
    @test Array(B)[1] == T(rank+1)

    # Test throwing
    if isroot
        B = ArrayType{T}(undef, 0)
        @test_throws DivideError MPI.Scatter!(A, B, comm; root=root)
        B = ArrayType{T}(undef, 8)
        @test_throws AssertionError MPI.Scatter!(A, B, comm; root=root)
    end
end

MPI.Finalize()
@test MPI.Finalized()
