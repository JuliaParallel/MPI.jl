include("common.jl")

MPI.Init()

comm = MPI.COMM_WORLD
sz = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

# Build a closure capturing `arr`. Written as a function so that the closures it returns
# all share one type and differ only in the array they capture.
mkop(arr) = (x, y) -> x + y + arr[1]

# Reduction operators that are genuinely associative and commutative, so that the result
# does not depend on the order in which MPI applies them, but that are still distinct
# Julia objects.
mkadd(k) = (x, y) -> x + y + k - k

named_add(x, y) = x + y

struct PoolStat
    n::Float64
    s::Float64
end

if can_do_closures

    # A runtime closure capturing a local. Before MPI.jl grew the trampoline pool this
    # threw on aarch64/ppc64le, and the underlying `@cfunction($w, ...)` aborted the
    # process.
    let zero = [0]
        add = mkop(zero)

        send = fill(rank + 1, 3)
        recv = similar(send)
        MPI.Allreduce!(send, recv, add, comm)
        @test recv == fill(sum(1:sz), 3)

        @test MPI.Allreduce(rank + 1, add, comm) == sum(1:sz)

        root = sz - 1
        red = MPI.Reduce(rank + 1, add, comm; root=root)
        if rank == root
            @test red == sum(1:sz)
        else
            @test red === nothing
        end
    end

    # A closure over a user-defined isbits struct
    let pool = (a::PoolStat, b::PoolStat) -> PoolStat(a.n + b.n, a.s + b.s)
        tot = MPI.Allreduce(PoolStat(1.0, rank + 1.0), pool, comm)
        @test tot.n == sz
        @test tot.s == sum(1:sz)

        # `T = Any` takes the runtime-dispatch branch of `OpWrapper`, which recovers the
        # element type from the datatype MPI passes to the callback.
        op = MPI.Op(pool, Any)
        tot = MPI.Allreduce(PoolStat(1.0, rank + 1.0), op, comm)
        @test tot.n == sz
        @test tot.s == sum(1:sz)
        MPI.free(op)
    end

end

# The remaining tests are about the trampoline pool itself, which only exists on
# architectures without closure cfunctions.
if can_do_closures && !MPI.HAVE_CLOSURE_CFUNCTION

    @test length(MPI.OP_POOL) >= MPI.OP_POOL_SIZE
    @test length(unique(slot.fptr for slot in MPI.OP_POOL)) == length(MPI.OP_POOL)
    @test all(slot -> slot.fptr != C_NULL, MPI.OP_POOL)

    # An `Op` built by the pool carries the trampoline's pointer
    let op = MPI.Op(mkadd(1), Int)
        @test op.fptr isa Ptr{Cvoid}
        @test op.fptr != C_NULL
        MPI.free(op)
    end

    # Identical wrappers share a slot: `Reduce!` and friends build an `Op` on every call,
    # so a loop reducing with the same operator must not consume a slot per iteration.
    let arr = [0], send = fill(rank + 1, 3), recv = fill(0, 3)
        used = MPI.OP_POOL_USED[]
        for _ in 1:100
            MPI.Allreduce!(send, recv, mkop(arr), comm)   # closure rebuilt each iteration
        end
        @test MPI.OP_POOL_USED[] == used + 1
        @test recv == fill(sum(1:sz), 3)

        # ... and likewise for a named function
        used = MPI.OP_POOL_USED[]
        for _ in 1:10
            MPI.Allreduce!(send, recv, named_add, comm)
        end
        @test MPI.OP_POOL_USED[] == used + 1
        @test recv == fill(sum(1:sz), 3)
    end

    # Wrappers over different arrays must NOT share a slot, even when the arrays are
    # `==`-equal: the pool is keyed by identity precisely so the wrong array can never be
    # installed in a trampoline.
    let a1 = [0], a2 = [0]
        @test a1 == a2 && a1 !== a2
        w1 = MPI.OpWrapper{typeof(mkop(a1)),Int}(mkop(a1))
        w2 = MPI.OpWrapper{typeof(mkop(a2)),Int}(mkop(a2))
        p1 = MPI.op_fptr(w1)
        p2 = MPI.op_fptr(w2)
        @test p1 != p2
        # rebuilding an identical wrapper reuses the slot
        @test MPI.op_fptr(MPI.OpWrapper{typeof(mkop(a1)),Int}(mkop(a1))) == p1
        # each slot holds its own wrapper
        slot1 = MPI.OP_POOL[findfirst(s -> s.fptr == p1, MPI.OP_POOL)]
        slot2 = MPI.OP_POOL[findfirst(s -> s.fptr == p2, MPI.OP_POOL)]
        @test slot1.wrapper === w1
        @test slot2.wrapper === w2
        @test slot1.wrapper.f.arr === a1
        @test slot2.wrapper.f.arr === a2
    end

    # Exhausting the static pool grows it at run time
    let n = MPI.OP_POOL_SIZE + 2
        ops = [MPI.Op(mkadd(k), Int) for k in 1:n]
        @test length(unique(op.fptr for op in ops)) == n
        @test MPI.OP_POOL_USED[] > MPI.OP_POOL_SIZE
        @test length(MPI.OP_POOL) > MPI.OP_POOL_SIZE
        # a grown trampoline works like any other
        @test MPI.Allreduce(rank + 1, ops[end], comm) == sum(1:sz)
        foreach(MPI.free, ops)
    end

end

MPI.Barrier(MPI.COMM_WORLD)

GC.gc()
MPI.Finalize()
@test MPI.Finalized()
