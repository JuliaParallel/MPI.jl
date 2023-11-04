using MPI
function main()
    MPI.Init()
    comm = MPI.COMM_WORLD
    rank = MPI.Comm_rank(comm)
    if rank == 1
        error("This is an expected error, ignore it")
    end
    MPI.Barrier(comm)
    # FeatureLevelError showing
    v_num = VersionNumber(1,2,3)
    err = MPI.FeatureLevelError(:my_fake_function, v_num)
    @test sprintf(show, err) == "FeatureLevelError(:my_fake_function): Minimum MPI version is $v_num"
end
main()
