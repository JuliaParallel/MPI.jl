using Test
using MPI

MPI.Init()

function allgather(A)
    comm = MPI.COMM_WORLD
    C = MPI.Allgather(A, comm)
end

comm = MPI.COMM_WORLD

for typ in Base.uniontypes(MPI.MPIDatatype)
    A = typ[MPI.Comm_rank(comm) + 1]
    C = allgather(A)
    @test typeof(C) === Vector{typ}
    @test C == map(typ, collect(1:MPI.Comm_size(comm)))
    A = convert(typ,MPI.Comm_rank(comm) + 1)
    C = allgather(A)
    @test typeof(C) === Vector{typ}
    @test C == map(typ, collect(1:MPI.Comm_size(comm)))

    val = typ(MPI.Comm_rank(comm) + 1)

	# Test passing output buffer with set size
	A = typ[val]
	C = fill(val, MPI.Comm_size(comm))
	MPI.Allgather!(A, C, length(A), comm)
	@test C == map(typ, collect(1:MPI.Comm_size(comm)))

	# Test assertion error
	C = fill(val, MPI.Comm_size(comm)-1)
	@test_throws AssertionError MPI.Allgather!(A, C, length(A), comm)

	# Test explicit IN_PLACE
	A = typ[val]
	C = fill(val, MPI.Comm_size(comm))
	C[MPI.Comm_rank(comm)+1] = MPI.Comm_rank(comm) + 1
	MPI.Allgather!(MPI.IN_PLACE, C, 1, comm)
	@test typeof(C) === Vector{typ}
	@test C == map(typ, collect(1:MPI.Comm_size(comm)))

	# Test IN_PLACE
	A = typ[val]
	C = fill(val, MPI.Comm_size(comm))
	C[MPI.Comm_rank(comm)+1] = MPI.Comm_rank(comm) + 1
	MPI.Allgather!(C, 1, comm)
	@test typeof(C) === Vector{typ}
	@test C == map(typ, collect(1:MPI.Comm_size(comm)))

end

MPI.Finalize()
@test MPI.Finalized()
