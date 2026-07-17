include("common.jl")

using MPI.API: @mpicall, @mpichk, libmpi

MPI.Init()

module MPIcallTestExpansion
using MPI.API: @mpicall, @mpichk, libmpi

expansion(expr) = macroexpand(@__MODULE__, expr)

plain = expansion(:(@mpicall ccall((:MPI_Get_version, libmpi), Cint, (Ptr{Cint}, Ptr{Cint}), version, subversion)))
gc_safe_false = expansion(:(@mpicall gc_safe=false ccall((:MPI_Get_version, libmpi), Cint, (Ptr{Cint}, Ptr{Cint}), version, subversion)))
gc_safe_true = expansion(:(@mpicall gc_safe=true ccall((:MPI_Get_version, libmpi), Cint, (Ptr{Cint}, Ptr{Cint}), version, subversion)))
end

@testset "@mpicall expansion" begin
    # `gc_safe=false` is identical to the plain form
    @test MPIcallTestExpansion.gc_safe_false == MPIcallTestExpansion.plain
    if VERSION >= v"1.12"
        # the calling convention slot carries the `gc_safe` flag, matching the
        # lowering of `@ccall gc_safe=true`
        convention = MPI.API.use_stdcall ? :stdcall : :ccall
        @test MPIcallTestExpansion.gc_safe_true.args[3] ==
            Expr(:cconv, (convention, UInt16(0), true), 0)
        @test deleteat!(copy(MPIcallTestExpansion.gc_safe_true.args), 3) ==
            MPIcallTestExpansion.plain.args
    else
        # `gc_safe=true` is a no-op on older Julia versions
        @test MPIcallTestExpansion.gc_safe_true == MPIcallTestExpansion.plain
    end

    # invalid arguments; depending on the Julia version `macroexpand` may wrap
    # the error in one or more `LoadError`s
    function expansion_error(expr)
        try
            macroexpand(@__MODULE__, expr)
            return nothing
        catch e
            while e isa LoadError
                e = e.error
            end
            return e
        end
    end
    @test expansion_error(:(@mpicall foo=true ccall((:MPI_Initialized, libmpi), Cint, (Ptr{Cint},), flag))) isa ArgumentError
    @test expansion_error(:(@mpicall gc_safe=1 ccall((:MPI_Initialized, libmpi), Cint, (Ptr{Cint},), flag))) isa ArgumentError
    @test expansion_error(:(@mpicall ccall((:MPI_Initialized, libmpi), Cint, (Ptr{Cint},), flag) extra)) isa ArgumentError
    @test expansion_error(:(@mpichk gc_safe=true)) isa ArgumentError
end

@testset "@mpicall/@mpichk gc_safe runtime" begin
    version = Ref{Cint}()
    subversion = Ref{Cint}()
    @mpicall ccall((:MPI_Get_version, libmpi), Cint, (Ptr{Cint}, Ptr{Cint}), version, subversion)
    expected = (version[], subversion[])

    version[] = subversion[] = -1
    @mpicall gc_safe=true ccall((:MPI_Get_version, libmpi), Cint, (Ptr{Cint}, Ptr{Cint}), version, subversion)
    @test (version[], subversion[]) == expected

    version[] = subversion[] = -1
    @mpichk gc_safe=true ccall((:MPI_Get_version, libmpi), Cint, (Ptr{Cint}, Ptr{Cint}), version, subversion)
    @test (version[], subversion[]) == expected

    version[] = subversion[] = -1
    @mpichk gc_safe=true ccall((:MPI_Get_version, libmpi), Cint, (Ptr{Cint}, Ptr{Cint}), version, subversion) v"1.0.0"
    @test (version[], subversion[]) == expected
end

MPI.Finalize()
@test MPI.Finalized()
