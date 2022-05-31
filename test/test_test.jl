include("common.jl")

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

dst = mod(rank+1, size)
src = mod(rank-1, size)

N = 32

send_mesg = ArrayType{Float64}(undef,N)
recv_mesg = ArrayType{Float64}(undef,N)
recv_mesg_expected = ArrayType{Float64}(undef,N)
fill!(send_mesg, Float64(rank))
fill!(recv_mesg_expected, Float64(src))
synchronize()

rreq = MPI.Irecv!(recv_mesg, comm; source=src, tag=src+32)
sreq = MPI.Isend(send_mesg, comm; dest=dst, tag=rank+32, )

reqs = [sreq,rreq]

inds = MPI.Waitsome(reqs)
@test !isempty(inds)
for ind in inds
    (onedone,stat) = MPI.Test(reqs[ind], MPI.Status)
    @test onedone
    @test MPI.Get_tag(stat) == MPI.Consts.MPI_ANY_TAG[]
    @test MPI.Get_source(stat) == MPI.Consts.MPI_ANY_SOURCE[]
    @test MPI.Get_error(stat) == MPI.Consts.MPI_SUCCESS[]
    @test MPI.Get_count(stat, Float64) == 0
end

done, ind = MPI.Testany(reqs)
if done && !isnothing(ind)
    (onedone,stat) = MPI.Test(reqs[ind], MPI.Status)
    @test onedone
    @test MPI.Get_tag(stat) == MPI.Consts.MPI_ANY_TAG[]
    @test MPI.Get_source(stat) == MPI.Consts.MPI_ANY_SOURCE[]
    @test MPI.Get_error(stat) == MPI.Consts.MPI_SUCCESS[]
    @test MPI.Get_count(stat, Float64) == 0
end

MPI.Waitall(reqs)

(inds, stats) = MPI.Waitsome(reqs, MPI.Status)
@test isnothing(inds)
@test isempty(stats)
(inds, stats) = MPI.Testsome(reqs, MPI.Status)
@test isnothing(inds)
@test isempty(stats)

MPI.Finalize()
@test MPI.Finalized()
