include("common.jl")

MPI.Init()

# Finalizers of MPI handle objects must not call MPI functions directly: they enqueue
# the freeing of the underlying handle, and the queue is drained before the next MPI
# call.  See `MPI.deferred_free`.

# create unreferenced MPI handle objects to be garbage-collected
function make_garbage()
    comm = MPI.Comm_dup(MPI.COMM_WORLD)
    group = MPI.Comm_group(MPI.COMM_WORLD)
    dt = MPI.Types.create_contiguous(2, MPI.Datatype(Int))
    info = MPI.Info(:mpi_jl_test_key => "true")
    return nothing
end

@testset "deferred free" begin
    # null handles have nothing to free
    @test MPI.deferred_free_fn(MPI.COMM_NULL) === nothing
    @test MPI.deferred_free_fn(MPI.GROUP_NULL) === nothing
    @test MPI.deferred_free_fn(MPI.DATATYPE_NULL) === nothing
    @test MPI.deferred_free_fn(MPI.INFO_NULL) === nothing
    @test MPI.deferred_free_fn(MPI.Request()) === nothing
    # non-null handles produce a closure
    let comm = MPI.Comm_dup(MPI.COMM_WORLD)
        @test MPI.deferred_free_fn(comm) isa Function
        MPI.free(comm)  # explicit free is immediate
        @test comm == MPI.COMM_NULL
        # after an explicit free the finalizer has nothing to enqueue
        @test MPI.deferred_free_fn(comm) === nothing
    end

    # garbage-collecting MPI handle objects enqueues the frees without calling MPI
    count_before = MPI.API.deferred_frees_count[]
    make_garbage()
    GC.gc()
    count_after = MPI.API.deferred_frees_count[]
    @test count_after > count_before
    # the queue is drained by the next MPI call
    MPI.Barrier(MPI.COMM_WORLD)
    @test MPI.API.deferred_frees_count[] == 0
    @test isempty(MPI.API.deferred_frees)

    # completed requests are finalized without enqueueing anything: their handle is
    # already null after the wait
    let sbuf = Float64[1.0], rbuf = Float64[0.0]
        rank = MPI.Comm_rank(MPI.COMM_WORLD)
        size = MPI.Comm_size(MPI.COMM_WORLD)
        dst = mod(rank + 1, size)
        src = mod(rank - 1, size)
        rreq = MPI.Irecv!(rbuf, MPI.COMM_WORLD; source=src, tag=0)
        sreq = MPI.Isend(sbuf, MPI.COMM_WORLD; dest=dst, tag=0)
        MPI.Waitall([sreq, rreq])
        @test MPI.deferred_free_fn(sreq) === nothing
        @test MPI.deferred_free_fn(rreq) === nothing
    end
end

MPI.Finalize()
@test MPI.Finalized()
