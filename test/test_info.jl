using Test
using MPI

MPI.Init()

info = MPI.Info()
@test typeof(info) == MPI.Info
@test info.cinfo == MPI.CInfo(MPI.MPI_INFO_NULL)

testinfo(;kwargs...) = MPI.Info(kwargs...)

info = testinfo(foo="fast", bar=true, baz=[10, -2])
@test info.cinfo !=  MPI.CInfo(MPI.MPI_INFO_NULL)

@test length(info) == 3
@test info[:foo] == "fast"

@test sort!(collect(keys(info))) == [:bar, :baz, :foo]
@test sort!(collect(info)) == [:bar=>"true", :baz=>"10,-2", :foo=>"fast"]

delete!(info, :bar)
@test_throws KeyError info[:bar]

MPI.free(info)
@test info.cinfo ==  MPI.CInfo(MPI.MPI_INFO_NULL)

MPI.Finalize()
@test MPI.Finalized()
