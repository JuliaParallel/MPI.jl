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
prodrank = prod(1:rank)

# Not possible to PROD a Char (and neither Int8 with OpenMPI)
for T in setdiff([Base.uniontypes(MPI.MPIDatatype)...], [Char, Int8, UInt8])
    A = ArrayType{T}(fill(T(rank+1), 4))
    B = similar(A)
    MPI.Exscan!(A, B, *, comm)
    if rank > 0
        @test B == ArrayType{T}(fill(T(prodrank), 4))
    end
    
    B = MPI.Exscan(A, *, comm)
    @test B isa ArrayType{T}

    MPI.Exscan!(A, *, comm)
    if rank > 0
        @test A == ArrayType{T}(fill(T(prodrank), 4))
    end

    A = ArrayType{T}(fill(T(rank+1), 4))
    MPI.Exscan!(A, *, comm)
    if rank > 0
        @test A == ArrayType{T}(fill(T(prodrank), 4))
    end
    
    B = MPI.Exscan(T(rank+1), *, comm)
    if rank > 0
        @test B[1] == prodrank
    end
end

MPI.Finalize()
@test MPI.Finalized()
