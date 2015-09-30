using BinDeps

@BinDeps.setup

mpi = library_dependency("juliampi", aliases=["libjuliampi", "libjuliampi.so", "libjuliampi.dylib"])
builddir = joinpath(BinDeps.depsdir(mpi), "build")
prefix = joinpath(BinDeps.depsdir(mpi), "usr")
src = joinpath(BinDeps.depsdir(mpi), "src")

if isdir(builddir)
    rm(builddir, recursive = true)
end
if isdir(prefix)
    rm(prefix, recursive = true)
end

provides(SimpleBuild,
    (@build_steps begin
        CreateDirectory(builddir)
        (@build_steps begin
            ChangeDirectory(builddir)
            (@build_steps begin
                try
                    # Add cmake flags to specify the MPI library location if set
                    incs, libs = ENV["JULIA_MPI_INCLUDE_PATH"], ENV["JULIA_MPI_LIBRARIES"]
                    `cmake -DMPI_Fortran_INCLUDE_PATH=$incs -DMPI_Fortran_LIBRARIES=$libs -DCMAKE_INSTALL_PREFIX=$src -DCMAKE_LIB_INSTALL_PREFIX=$prefix/lib ..`
                catch
                    `cmake -DCMAKE_INSTALL_PREFIX=$src -DCMAKE_LIB_INSTALL_PREFIX=$prefix/lib ..`
                end
                `make`
                `make install`
            end)
        end)
    end), [mpi], os = :Unix)

@BinDeps.install Dict(:mpi => :mpi)
