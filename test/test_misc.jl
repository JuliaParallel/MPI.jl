include("common.jl")

MPI.Init()

@test MPI.Get_processor_name() isa String

MPI.Finalize()
@test MPI.Finalized()
