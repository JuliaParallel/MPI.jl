using BinDeps

@BinDeps.setup

mpi = library_dependency("juliampi", aliases=["libjuliampi", "libjuliampi.so", "libjuliampi.dylib"])
builddir = joinpath(BinDeps.depsdir(mpi), "build")
prefix = joinpath(BinDeps.depsdir(mpi), "usr")
src = joinpath(BinDeps.depsdir(mpi), "src")

provides(SimpleBuild,
    (@build_steps begin
        CreateDirectory(builddir)
        (@build_steps begin
            ChangeDirectory(builddir)
            (@build_steps begin
                `cmake -DCMAKE_INSTALL_PREFIX=$src -DCMAKE_LIB_INSTALL_PREFIX=$prefix/lib ..`
                `make`
                `make install`
                `make test`
            end)
        end)
    end), [mpi], os = :Unix)

@BinDeps.install [:mpi => :mpi]
