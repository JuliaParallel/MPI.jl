include("common.jl")

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)
prodrank = prod(1:rank+1)

# Not possible to PROD a Char (and neither Int8 with OpenMPI)
for T in setdiff(MPITestTypes, [Char, Int8, UInt8])
    A = ArrayType{T}(fill(T(rank+1), 4))
    B = similar(A)
    MPI.Scan!(A, B, *, comm)
    @test B == ArrayType{T}(fill(T(prodrank), 4))

    B = MPI.Scan(A, *, comm)
    @test B isa ArrayType{T}
    @test B == ArrayType{T}(fill(T(prodrank), 4))

    B = MPI.Scan(T(rank+1), *, comm)
    @test B[1] == prodrank

    # in-place
    C = copy(A)
    C = MPI.Scan!(C, *, comm)
    @test C isa ArrayType{T}
    @test C == ArrayType{T}(fill(T(prodrank), 4))
end

MPI.Finalize()
@test MPI.Finalized()
