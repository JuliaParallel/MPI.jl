using MPI, Test

MPI.Init()

rank = MPI.Comm_rank(MPI.COMM_WORLD)


X = zeros(10)
if rank == 1
    MPI.Recv!(X,0,2,MPI.COMM_WORLD)
    MPI.Send(rand(10),0,0,MPI.COMM_WORLD)
elseif rank == 0
    X = zeros(10)
    req = MPI.Irecv!(X,1,0,MPI.COMM_WORLD)
    task = @async begin
        wait(req)
        # success!
    end
    yield()
    
    # trigger rank 1
    MPI.Send(zeros(10),1,2,MPI.COMM_WORLD)
    wait(task)
    
    flag,_ = MPI.Test!(req)
    @test flag
end

