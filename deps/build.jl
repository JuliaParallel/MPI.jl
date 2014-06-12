using BinDeps

@BinDeps.setup

mpi = library_dependency("mpi", aliases=["libmpi", "libmpi.so", "libmpi.dylib"])

builddir = joinpath(BinDeps.depsdir(mpi),"build")
srcdir = joinpath(BinDeps.depsdir(mpi),"..","src")

provides(SimpleBuild,
    (@build_steps begin
        CreateDirectory(builddir)
        CreateDirectory(srcdir)
        (@build_steps begin
            ChangeDirectory(builddir)
            (@build_steps begin
                `cmake ..`
                `make`
                `make install`
                `make test`
            end)
        end)
    end), [mpi], os = :Darwin)

provides(SimpleBuild,
    (@build_steps begin
        CreateDirectory(builddir)
        CreateDirectory(srcdir)
        (@build_steps begin
            ChangeDirectory(builddir)
            (@build_steps begin
                `cmake ..`
                `make`
                `make install`
                `make test`
            end)
        end)
    end), [mpi], os = :Unix)

@BinDeps.install [:mpi => :mpi]
