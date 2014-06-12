using BinDeps

@BinDeps.setup

libmpi = library_dependency("libmpi", aliases=["libmpi.so", "libmpi.dylib"])

builddir = joinpath(BinDeps.depsdir(libmpi),"build")
srcdir = joinpath(BinDeps.depsdir(libmpi),"..","src")

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
    end), [libmpi], os = :Darwin)

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
    end), [libmpi], os = :Unix)

@BinDeps.install [:libmpi => :libmpi]
