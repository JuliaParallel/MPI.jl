include("common.jl")

MPI.Init(; threadlevel=:single)

@testset "#688" begin
    @test MPI.get_name(MPI.Datatype(Char)) == "MPI_CHAR"

    comm = MPI.COMM_WORLD
    rank = MPI.Comm_rank(comm)
    A = Array{Char}([rank + 1])
    MPI.Allgather(A, comm)
end

MPI.Finalize()
@test MPI.Finalized()