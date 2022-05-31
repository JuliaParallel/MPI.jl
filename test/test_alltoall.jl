include("common.jl")

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

for T in Base.uniontypes(MPI.MPIDatatype)

    # Allocating version
    a = ArrayType(fill(T(rank), size))
    synchronize()
    b = MPI.Alltoall(UBuffer(a, 1), comm)
    @test b isa ArrayType{T}
    @test b == ArrayType{T}(0:size-1)

    # Non Allocating version
    a = ArrayType(fill(T(rank),size))
    synchronize()
    b = ArrayType{T}(undef, size*1)
    MPI.Alltoall!(UBuffer(a,1), UBuffer(b,1), comm)
    @test b == ArrayType{T}(0:size-1)

    # IN_PLACE version
    a = ArrayType{T}(fill(T(rank),size))
    synchronize()
    MPI.Alltoall!(MPI.IN_PLACE, UBuffer(a,1), comm)
    @test a == ArrayType{T}(0:size-1)

    # One-argument IN_PLACE version
    a = ArrayType{T}(fill(T(rank),size))
    synchronize()
    MPI.Alltoall!(UBuffer(a,1), comm)
    @test a == ArrayType{T}(0:size-1)
end

MPI.Finalize()
@test MPI.Finalized()
