include("common.jl")
using Libdl

MPI.Init()

comm = MPI.COMM_WORLD
rank = MPI.Comm_rank(comm)
nprocs = MPI.Comm_size(comm)

has_symbol(fname) =
    !isnothing(Libdl.dlsym(MPI.API.libmpi_handle, fname; throw_error=false))

# A procedure the MPI library does not provide must raise `FeatureLevelError` from
# `@mpichk`, rather than failing to resolve a symbol at run time. Each entry is a thunk
# that calls the procedure with arguments valid enough to reach the `ccall`; whether the
# call itself would succeed is not what is under test.
absent_must_throw = [
    (:MPI_Isendrecv, () -> begin
         send = [rank]
         recv = [0]
         req = MPI.Request()
         MPI.API.MPI_Isendrecv(send, 1, MPI.Datatype(Int), rank, 0,
                               recv, 1, MPI.Datatype(Int), rank, 0, comm, req)
     end),
    (:MPI_Type_get_value_index, () -> MPI.API.MPI_Type_get_value_index(
         MPI.Datatype(Int), MPI.Datatype(Int), Ref(MPI.DATATYPE_NULL.val))),
    (:MPI_Abi_get_version, () -> MPI.API.MPI_Abi_get_version(Ref{Cint}(), Ref{Cint}())),
]

for (fname, thunk) in absent_must_throw
    isdefined(MPI.API, fname) || continue    # not in this generated_api.jl at all
    has_symbol(fname) && continue            # provided by the library: nothing to assert
    err = try
        thunk()
        nothing
    catch e
        e
    end
    @test err isa MPI.FeatureLevelError
    if err isa MPI.FeatureLevelError
        @test err.function_name === fname
        # Not asserted: that `err.min_version > MPI.MPI_VERSION`. A library is free to
        # advertise a standard version whose procedures it does not all export, and that
        # is its business, not something this test should fail over.
        @test occursin(string(fname), sprint(show, err))
    end
end

# The large-count entry points must work on every library: natively where the library has
# them, and otherwise through the narrow fallback that `@mpichk`'s `fallback=` installs.
# The counts here are small, so both paths must give the same answer.
#
# `MPI.API.Count` and not `MPI.API.MPI_Count`: the fallback is transparent for a count
# passed *by value*, which `ccall` converts, but not for one passed through a pointer.
# A `Ref{MPI_Count}` handed to a wrapper that fell back to a `Ptr{Cint}` argument is a
# `MethodError`, so a caller of the `_c` entry points has to use the alias that follows
# the entry point actually in use.
const Count = MPI.API.Count
const CountDatatype = MPI.Datatype(Count)

let src = 0, dst = nprocs - 1, tag = 42
    send = Count[1, 2, 3, 4]
    if rank == src && rank != dst
        MPI.API.MPI_Send_c(send, length(send), CountDatatype, dst, tag, comm)
    end
    if rank == dst && rank != src
        recv = zeros(Count, length(send))
        stat = Ref{MPI.Status}()
        MPI.API.MPI_Recv_c(recv, length(recv), CountDatatype, src, tag, comm, stat)
        @test recv == send
        count = Ref{Count}()
        MPI.API.MPI_Get_count_c(stat, CountDatatype, count)
        @test count[] == length(send)
    end
end
MPI.Barrier(comm)

let root = 0
    buf = rank == root ? Count[10, 20, 30, 40] : zeros(Count, 4)
    MPI.API.MPI_Bcast_c(buf, length(buf), CountDatatype, root, comm)
    @test buf == Count[10, 20, 30, 40]
end
MPI.Barrier(comm)

let
    sendbuf = Count[rank + 1]
    recvbuf = zeros(Count, 1)
    MPI.API.MPI_Allreduce_c(sendbuf, recvbuf, 1, CountDatatype, MPI.SUM, comm)
    @test recvbuf[1] == div(nprocs * (nprocs + 1), 2)
end
MPI.Barrier(comm)

# `MPI_Op_create_c` deliberately gets no fallback: its callback takes `MPI_Count *len`
# where `MPI_Op_create`'s takes `int *len`, so silently swapping the creators would make
# the callback read the wrong width. On a library without it, it must raise instead.
if isdefined(MPI.API, :MPI_Op_create_c) && !has_symbol(:MPI_Op_create_c)
    @test_throws MPI.FeatureLevelError MPI.API.MPI_Op_create_c(
        C_NULL, Cint(1), Ref(MPI.OP_NULL.val))
end

MPI.Barrier(comm)
GC.gc()
MPI.Finalize()
@test MPI.Finalized()
