include("common.jl")
using Libdl

MPI.Init()

comm = MPI.COMM_WORLD
rank = MPI.Comm_rank(comm)
nprocs = MPI.Comm_size(comm)

const BIG = Int64(typemax(Cint)) + 1    # one past what the narrow interface can express

# Our CI declares whether large counts are supported in the tested MPI library.
# This allows us to test whether our auto-detection is working.
if haskey(ENV, "JULIA_MPI_TEST_LARGE_COUNT")
    @test MPI.API.HAS_LARGE_COUNT == (ENV["JULIA_MPI_TEST_LARGE_COUNT"] == "true")
end

# Large-count support has to be all-or-nothing. Intel MPI 2021.11 provides `MPI_Send_c`
# but not `MPI_Type_size_c`, and since the count types are one choice for the whole
# package, deciding per function let a `Ref{MPI_Count}` reach a `Ptr{Cint}`.
@testset "large-count support is all-or-nothing" begin
    absent = filter(collect(MPI.API.LARGE_COUNT_SYMBOLS)) do sym
        isnothing(Libdl.dlsym(MPI.API.libmpi_handle, sym; throw_error=false))
    end
    @test MPI.API.HAS_LARGE_COUNT == isempty(absent)
end

@testset "count types" begin
    @test MPI.API.Count <: Integer
    @test MPI.API.Displ <: Integer
    @test MPI.API.TypeDispl <: Integer
    if MPI.API.HAS_LARGE_COUNT
        @test typemax(MPI.API.Count) > typemax(Cint)
        # `Displ` and `TypeDispl` need to hold byte offsets, so at least a pointer's worth
        @test sizeof(MPI.API.Displ) >= sizeof(Ptr{Cvoid})
        @test sizeof(MPI.API.TypeDispl) >= sizeof(Ptr{Cvoid})
    else
        @test MPI.API.Count === Cint
    end
    # the buffer types must follow
    @test fieldtype(MPI.Buffer{Vector{Int}}, :count) === MPI.API.Count
    @test fieldtype(MPI.RBuffer{Vector{Int},Vector{Int}}, :count) === MPI.API.Count
    @test fieldtype(MPI.VBuffer{Vector{Int}}, :counts) === Vector{MPI.API.Count}
    @test fieldtype(MPI.VBuffer{Vector{Int}}, :displs) === Vector{MPI.API.Displ}
end

# Derived datatypes let us exercise a count larger than `typemax(Cint)` without allocating
# anything: only the type's description is large, not a buffer.
@testset "large-count datatypes" begin
    if MPI.API.HAS_LARGE_COUNT
        dt = MPI.Types.create_contiguous(BIG, MPI.BYTE)
        MPI.Types.commit!(dt)
        @test MPI.Types.size(dt) == BIG
        @test MPI.Types.extent(dt) == (0, BIG)
        MPI.free(dt)
    else
        # The narrow entry point cannot express this, and must throw an exception.
        @test_throws InexactError MPI.Types.create_contiguous(BIG, MPI.BYTE)
    end
end

@testset "large counts in Buffer" begin
    if MPI.API.HAS_LARGE_COUNT
        buf = MPI.Buffer(Ptr{UInt8}(0), BIG, MPI.BYTE)
        @test buf.count == BIG
        vbuf = MPI.VBuffer(Ptr{UInt8}(0), [BIG, BIG], [0, BIG], MPI.BYTE)
        @test vbuf.counts == [BIG, BIG]
        @test vbuf.displs == [0, BIG]
    else
        @test_throws InexactError MPI.Buffer(Ptr{UInt8}(0), BIG, MPI.BYTE)
    end
end

# Counts and displacements are allowed to be different widths (they are, under 32-bit
# MPICH), so make sure a VBuffer built the usual way still lines up.
@testset "VBuffer count/displ widths" begin
    counts = [1, 2, 3]
    vbuf = MPI.VBuffer(zeros(Int, sum(counts)), counts)
    @test eltype(vbuf.counts) === MPI.API.Count
    @test eltype(vbuf.displs) === MPI.API.Displ
    @test vbuf.displs == [0, 1, 3]
    # a Vector{Cint} argument must still be accepted
    vbuf = MPI.VBuffer(zeros(Int, 6), Cint[1, 2, 3], Cint[0, 1, 3])
    @test vbuf.counts == [1, 2, 3]
end

# Actually running a test that handles more than 2 GiB is opt-in:
# This needs a couple of GiB of RAM per rank, which is more than a shared CI runner can handle.
if get(ENV, "JULIA_MPI_TEST_LARGECOUNT", "") == "1"
    if !MPI.API.HAS_LARGE_COUNT
        @info "JULIA_MPI_TEST_LARGECOUNT set but this MPI has no large-count support; skipping"
    else
        @testset "2 GiB point-to-point" begin
            n = BIG + 1
            if rank == 0
                data = fill(Int8(7), n)
                MPI.Send(data, 1, 0, comm)
                data = nothing
            elseif rank == 1
                data = zeros(Int8, n)
                stat = MPI.Recv!(data, 0, 0, comm)
                @test MPI.Get_count(stat, Int8) == n
                @test all(==(Int8(7)), data)
                data = nothing
            end
            GC.gc()
        end
        MPI.Barrier(comm)

        @testset "2 GiB Bcast!" begin
            n = BIG + 1
            data = rank == 0 ? fill(Int8(3), n) : zeros(Int8, n)
            MPI.Bcast!(data, 0, comm)
            @test all(==(Int8(3)), data)
            data = nothing
            GC.gc()
        end
        MPI.Barrier(comm)

        # A user-defined `Op` is created with the narrow `MPI_Op_create`, whose callback
        # takes `int *len`. This checks the assumption that an MPI library chunks a
        # large-count reduction into calls which the narrow callback can express, rather than
        # handing it a length it cannot represent.
        @testset "2 GiB Allreduce! with a custom Op" begin
            n = BIG + 1
            data = fill(Int8(1), n)
            MPI.Allreduce!(data, (a, b) -> max(a, b), comm)
            @test all(==(Int8(1)), data)
            data = nothing
            GC.gc()
        end
        MPI.Barrier(comm)
    end
end

MPI.Barrier(comm)
GC.gc()
MPI.Finalize()
@test MPI.Finalized()
