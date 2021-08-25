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

dst = mod(rank+1, size)
src = mod(rank-1, size)

N = 32

send_mesg = ArrayType{Float64}(undef,N)
recv_mesg = ArrayType{Float64}(undef,N)
recv_mesg_expected = ArrayType{Float64}(undef,N)
fill!(send_mesg, Float64(rank))
fill!(recv_mesg_expected, Float64(src))

rreq = MPI.Irecv!(recv_mesg, src, src+32, comm)
sreq = MPI.Isend(send_mesg, dst, rank+32, comm)

reqs = [sreq,rreq]

# Note: This Waitsome! sets the respective requests to REQUEST_NULL.
# The calls to Test! etc. further below will not do anything. This
# test case needs to be redesigned.
(inds,stats) = MPI.Waitsome!(reqs)
@test !isempty(inds)
for ind in inds
    (onedone,stat) = MPI.Test!(reqs[ind])
    @test onedone
end

(done, ind, stats) = MPI.Testany!(reqs)
if done && ind != MPI.UNDEFINED
    (onedone,stat) = MPI.Test!(reqs[ind])
    @test onedone
end

MPI.Waitall!(reqs)

(inds, stats) = MPI.Waitsome!(reqs)
@test isempty(inds)
@test isempty(stats)
(inds, stats) = MPI.Testsome!(reqs)
@test isempty(inds)
@test isempty(stats)

MPI.Finalize()
@test MPI.Finalized()
