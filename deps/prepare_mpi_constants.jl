@show libdir = dirname(dlpath(libmpi))

@show mpidir = get(ENV, "JULIA_MPI_PATH", joinpath(libdir, ".."))
@show incdir = get(ENV, "JULIA_INCLUDE_PATH", joinpath(mpidir, "include"))
@show mpicc = get(ENV, "JULIA_MPICC", joinpath(mpidir, "bin", "mpicc"))

# `cflags` includes libraries and needs to be listed at the end of the
# compile/link command
if haskey(ENV, "JULIA_MPI_CFLAGS")
    cflags = Base.shell_split(ENV["JULIA_MPI_CFLAGS"])
else
    # We need to point `mpicc` to the right include and library
    # directories. BinaryBuilder moved the install directory into
    # Julia's `artifacts` directory, and `mpicc` doesn't know the
    # correct directory name.
    @show libfilename = basename(libmpi)
    @show libbasename, = splitext(libfilename)
    @show libname = replace(libbasename, r"^lib" => s"")
    @show cflags = `-I$incdir -L$libdir -Wl,-rpath,$libdir -l$libname`
end

@show `$mpicc -o generate_compile_time_mpi_constants generate_compile_time_mpi_constants.c $cflags`
run(`$mpicc -o generate_compile_time_mpi_constants generate_compile_time_mpi_constants.c $cflags`)
@show `$mpiexec_path -n 1 ./generate_compile_time_mpi_constants`
run(`$mpiexec_path -n 1 ./generate_compile_time_mpi_constants`)

run(`$mpicc -fPIC -shared -o load_time_mpi_constants.so load_time_mpi_constants.c $cflags`)
