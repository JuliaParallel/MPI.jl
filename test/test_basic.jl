include("common.jl")

@test !MPI.Initialized()
MPI.Init()
@test MPI.Initialized()

@test 0 <= MPI.Comm_rank(MPI.COMM_WORLD) < MPI.Comm_size(MPI.COMM_WORLD)

@test MPI.has_cuda() isa Bool

if ArrayType != Array
    @test MPI.has_cuda()
end

@test !MPI.Finalized()
MPI.Finalize()
@test MPI.Finalized()
