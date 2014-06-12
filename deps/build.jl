using BinDeps

@BinDeps.setup

libmpi = library_dependency("libjuliampi", aliases=["libjuliampi.so", "libjuliampi.dylib"])

builddir = joinpath(BinDeps.depsdir(libmpi),"build")
srcdir   = BinDeps.srcdir(libmpi)

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
