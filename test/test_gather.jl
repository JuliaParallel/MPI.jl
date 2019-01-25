using Test
using MPI

MPI.Init()

comm = MPI.COMM_WORLD
root = 0
rank = MPI.Comm_rank(comm)
sz   = MPI.Comm_size(comm)
isroot = MPI.Comm_rank(comm) == root

for typ in Base.uniontypes(MPI.MPIDatatype)

    # Allocating
    A = typ[MPI.Comm_rank(comm) + 1]
    C = MPI.Gather(A, root, comm)
    if MPI.Comm_rank(comm) == root
        @test typeof(C) === Vector{typ}
        @test C == map(typ, collect(1:MPI.Comm_size(comm)))
    end

    # Allocating, object
    A = convert(typ,MPI.Comm_rank(comm) + 1)
    C = MPI.Gather(A, root, comm)
    if MPI.Comm_rank(comm) == root
        @test typeof(C) === Vector{typ}
        @test C == map(typ, collect(1:MPI.Comm_size(comm)))
    end

    # Allocating, explicit length
    A = typ[MPI.Comm_rank(comm) + 1, 0]
    C = MPI.Gather(A, 1, root, comm)
    if MPI.Comm_rank(comm) == root
        @test typeof(C) === Vector{typ}
        @test C == map(typ, collect(1:MPI.Comm_size(comm)))
    end

    # Allocating, view
    A = typ[MPI.Comm_rank(comm) + 1, 0]
    C = MPI.Gather(view(A, 1:1), root, comm)
    if MPI.Comm_rank(comm) == root
        @test typeof(C) === Vector{typ}
        @test C == map(typ, collect(1:MPI.Comm_size(comm)))
    end

    # Non Allocating
    A = typ[MPI.Comm_rank(comm) + 1]
    C = Array{typ}(undef, sz)
    MPI.Gather!(A, C, length(A), root, comm)
    if MPI.Comm_rank(comm) == root
        @test C == map(typ, collect(1:MPI.Comm_size(comm)))
    end

    # In_place
    A = typ[rank + 1]
    B = Array{typ}(undef, sz);
    B[rank+1] = rank+1
    C = isroot ? B : A
    MPI.Gather_in_place!(C, 1, root, comm)
    if MPI.Comm_rank(comm) == root
        @test C == map(typ, collect(1:MPI.Comm_size(comm)))
    end

end

MPI.Finalize()
