using Test
using MPI

MPI.Init()

comm_size = MPI.Comm_size(MPI.COMM_WORLD)
comm_rank = MPI.Comm_rank(MPI.COMM_WORLD)

# send to next higher process, with wraparound
dest = mod(comm_rank+1, comm_size)
src  = mod(comm_rank-1, comm_size)

# test simple type
mutable struct NotABits
    a::Any
end

@testset "Non bitstype" begin
    @test_throws ArgumentError MPI.Datatype(NotABits)
end

struct Boundary
    c::UInt16  # force some padding to be inserted
    a::Int
    b::UInt8
end
@testset "Compound type" begin
    sz = sizeof(Boundary)
    al = Base.datatype_alignment(Boundary)
    @test MPI.Types.extent(MPI.Datatype(Boundary)) == (0, cld(sz,al)*al)

    arr = [Boundary( (comm_rank + i) % 127, i + comm_rank, i % 64) for i = 1:3]
    req_send = MPI.Isend(arr, dest, 1, MPI.COMM_WORLD)

    # receive the message
    arr_recv = Array{Boundary}(undef, 3)
    req_recv = MPI.Irecv!(arr_recv, src, 1, MPI.COMM_WORLD)

    MPI.Wait!(req_send)
    MPI.Wait!(req_recv)

    # check received array
    for i=1:3
        bndry_i = arr_recv[i]
        @test bndry_i.a == (src + i)
        @test bndry_i.b == i % 64
        @test bndry_i.c == (src + i) % 127
    end
end

struct Boundary2
    a::UInt32
    b::Tuple{Int, UInt8}
    c::Nothing
end
@testset "nested types" begin
    sz = sizeof(Boundary2)
    al = Base.datatype_alignment(Boundary2)
    @test MPI.Types.extent(MPI.Datatype(Boundary2)) == (0, cld(sz,al)*al)

    arr = [Boundary2( (comm_rank + i) % 127, ( Int(i + comm_rank), UInt8(i % 64)), nothing) for i = 1:3]
    arr_recv = Array{Boundary2}(undef,3)

    req_send = MPI.Isend(arr, dest, 1, MPI.COMM_WORLD)
    req_recv = MPI.Irecv!(arr_recv, src, 1, MPI.COMM_WORLD)

    MPI.Wait!(req_send)
    MPI.Wait!(req_recv)

    # check received array
    for i=1:3
        bndry_i = arr_recv[i]
        @test bndry_i.a == (src + i) % 127
        @test bndry_i.b[1] == (src + i)
        @test bndry_i.b[2] == (i % 64)
        @test bndry_i.c === nothing
    end
end

primitive type Primitive16 16 end
primitive type Primitive24 24 end
primitive type Primitive80 80 end

@testset for PrimitiveType in (Primitive16, Primitive24, Primitive80)        
    sz = sizeof(PrimitiveType)
    al = Base.datatype_alignment(PrimitiveType)
    @test MPI.Types.extent(MPI.Datatype(PrimitiveType)) == (0, cld(sz,al)*al)

    if VERSION < v"1.3" && PrimitiveType == Primitive80
        # alignment is broken on earlier Julia versions
        continue
    end
    
    arr = [Core.Intrinsics.trunc_int(PrimitiveType, UInt128(comm_rank + i)) for i = 1:4]
    arr_recv = Array{PrimitiveType}(undef,4)    
    
    recv_req = MPI.Irecv!(arr_recv, src, 2, MPI.COMM_WORLD)
    send_req = MPI.Isend(arr, dest, 2, MPI.COMM_WORLD)

    MPI.Wait!(recv_req)
    MPI.Wait!(send_req)

    @test arr_recv == [Core.Intrinsics.trunc_int(PrimitiveType, UInt128(src + i)) for i = 1:4]
end

@testset "packed non-aligned tuples" begin
    T = NTuple{3,UInt8}

    sz = sizeof(T)
    al = Base.datatype_alignment(T)
    @test MPI.Types.extent(MPI.Datatype(T)) == (0, cld(sz,al)*al)

    arr = [(UInt8(comm_rank),UInt8(i),UInt8(0)) for i = 1:8]
    arr_recv = Array{T}(undef,8)

    req_send = MPI.Isend(arr, dest, 1, MPI.COMM_WORLD)
    req_recv = MPI.Irecv!(arr_recv, src, 1, MPI.COMM_WORLD)

    MPI.Wait!(req_send)
    MPI.Wait!(req_recv)

    # check received array
    @test arr_recv == [(UInt8(src),UInt8(i),UInt8(0)) for i = 1:8]
end

@testset "0-sized type" begin
    sz = sizeof(Nothing)
    al = Base.datatype_alignment(Nothing)

    # OpenMPI gives incorrect values
    # see https://github.com/open-mpi/ompi/issues/7266
    # @test MPI.Types.extent(MPI.Datatype(Nothing)) == (0, cld(sz,al)*al)

    arr = [nothing for i = 1:100]
    arr_recv = Array{Nothing}(undef,100)

    req_send = MPI.Isend(arr, dest, 1, MPI.COMM_WORLD)
    req_recv = MPI.Irecv!(arr_recv, src, 1, MPI.COMM_WORLD)

    MPI.Wait!(req_send)
    MPI.Wait!(req_recv)

    # check received array
    @test arr_recv == [nothing for i = 1:100]
end


MPI.Barrier(MPI.COMM_WORLD)
MPI.Finalize()
@test MPI.Finalized()
