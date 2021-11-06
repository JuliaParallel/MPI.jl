if !Sys.iswindows()

    libdir = dirname(dlpath(libmpi))

    mpidir = get(ENV, "JULIA_MPI_PATH", joinpath(libdir, ".."))
    incdir = get(ENV, "JULIA_INCLUDE_PATH", joinpath(mpidir, "include"))
    mpicc = get(ENV, "JULIA_MPICC", joinpath(mpidir, "bin", "mpicc"))

    # `cflags` includes libraries and needs to be listed at the end of the
    # compile/link command
    if haskey(ENV, "JULIA_MPI_CFLAGS")
        cflags = Base.shell_split(ENV["JULIA_MPI_CFLAGS"])
    else
        libfilename = basename(libmpi)
        libbasename, = splitext(libfilename)
        libname = replace(libbasename, r"^lib" => s"")
        cflags = `-I$incdir -L$libdir -Wl,-rpath,$libdir -l$libname`
    end

    # We expect the subdirectory `MPIconstants-1.3.2` to contain a copy of
    # <https://github.com/eschnett/MPIconstants>
    srcdir = "MPIconstants-1.3.2"

    run(`$mpicc -o generate_compile_time_mpi_constants $(joinpath(srcdir, "generate_compile_time_mpi_constants.c")) $cflags`)
    const _generate_constants = () -> `./generate_compile_time_mpi_constants`

    run(`$mpicc -fPIC -shared -o libload_time_mpi_constants.so $(joinpath(srcdir, "load_time_mpi_constants.c")) $cflags`)

else

    cp("compile_time_mpi_constants_win64_$(Sys.ARCH).jl", "compile_time_mpi_constants.jl"; force=true)

end
