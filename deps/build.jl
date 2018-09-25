using BinDeps

@BinDeps.setup

mpi = library_dependency("juliampi", aliases=["libjuliampi", "libjuliampi.so", "libjuliampi.dylib"], os = :Unix)
builddir = joinpath(BinDeps.depsdir(mpi), "build")
prefix = joinpath(BinDeps.depsdir(mpi), "usr")
src = joinpath(BinDeps.depsdir(mpi), "src")

if isdir(builddir)
    rm(builddir, recursive = true)
end
if isdir(prefix)
    rm(prefix, recursive = true)
end

# Add cmake flags to specify the MPI library location
configure = `cmake`
flags = ["MPI_C_COMPILER",
         "MPI_C_COMPILE_FLAGS",
         "MPI_C_INCLUDE_PATH",
         "MPI_C_LINK_FLAGS",
         "MPI_C_LIBRARIES",
         "MPI_Fortran_COMPILER",
         "MPI_Fortran_COMPILE_FLAGS",
         "MPI_Fortran_INCLUDE_PATH",
         "MPI_Fortran_LINK_FLAGS",
         "MPI_Fortran_LIBRARIES",
         "MPI_INCLUDE_PATH",
         "MPI_LIBRARIES"]
for flag in flags
    try
        val = ENV["JULIA_$flag"]
        global configure = `$configure -D$flag=$val`
    catch
        nothing
    end
end
configure = `$configure -DCMAKE_INSTALL_PREFIX=$src -DCMAKE_LIB_INSTALL_PREFIX=$prefix/lib ..`

provides(SimpleBuild,
    (@build_steps begin
        CreateDirectory(builddir)
        (@build_steps begin
            ChangeDirectory(builddir)
            (@build_steps begin
                configure
                `make`
                `make install`
            end)
        end)
    end), [mpi], os = :Unix)

@BinDeps.install Dict(:mpi => :mpi)
