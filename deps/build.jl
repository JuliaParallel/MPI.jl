using Libdl

MPI_PATH = get(ENV, "JULIA_MPI_PATH", nothing)
MPI_LIBRARY_PATH = get(ENV, "JULIA_MPI_LIBRARY_PATH") do
    MPI_PATH !== nothing ? joinpath(MPI_PATH,"lib") : nothing
end
MPI_INCLUDE_PATH = get(ENV, "JULIA_MPI_INCLUDE_PATH") do
    MPI_PATH !== nothing ? joinpath(MPI_PATH,"include") : nothing
end
mpicc = get(ENV, "JULIA_MPICC") do
    if MPI_PATH !== nothing
        joinpath(MPI_PATH,"bin","mpicc")
    else
        "mpicc"
    end
end

const mpiexec = get(ENV, "JULIA_MPIEXEC") do
    if MPI_PATH !== nothing && Sys.isexecutable(joinpath(MPI_PATH,"bin","mpiexec"))
        joinpath(MPI_PATH,"bin","mpiexec")
    else
        Sys.which("mpiexec")
    end
end

const libmpi = get(ENV, "JULIA_MPI_LIBRARY") do
    libmpi = find_library(["libmpi", "msmpi", "libmpich"],
                          MPI_LIBRARY_PATH !== nothing ? [MPI_LIBRARY_PATH] : [])
    if libmpi == ""
        error("No MPI library found.\nEnsure an MPI implementation is loaded, or set the `JULIA_MPI_PATH` variable.")
    end
    # expand paths
    dlpath(libmpi)
end


if haskey(ENV, "JULIA_MPI_CFLAGS")
    CFLAGS = split(ENV["JULIA_MPI_CFLAGS"])
else
    lname, = split(basename(libmpi),'.')
    if startswith(lname, "lib")
        lname = lname[4:end]
    end
    CFLAGS = ["-l$lname"]
    if MPI_LIBRARY_PATH !== nothing
        push!(CFLAGS, "-L$(MPI_LIBRARY_PATH)")
    end
    if MPI_INCLUDE_PATH !== nothing
        push!(CFLAGS, "-I$(MPI_INCLUDE_PATH)")
    end
end

libsize = filesize(libmpi)

@info "Using MPI library $libmpi"

function Get_version()
    major = Ref{Cint}()
    minor = Ref{Cint}()
    if Sys.iswindows()
        ccall((:MPI_Get_version, libmpi), stdcall, Cint,
              (Ptr{Cint}, Ptr{Cint}), major, minor)
    else
        ccall((:MPI_Get_version, libmpi), Cint,
              (Ptr{Cint}, Ptr{Cint}), major, minor)
    end
    VersionNumber(major[], minor[])
end

MPI_VERSION = Get_version()


open("deps.jl","w") do f
    println(f, "# This file is automatically generated")
    println(f, "# Do not edit")
    println(f)
    println(f, :(const libmpi = $libmpi))
    println(f, :(const libmpi_size = $libsize))
    println(f, :(const MPI_VERSION = $MPI_VERSION))
    println(f, :(const mpiexec = $mpiexec))

    if Sys.iswindows()
        println(f, :(include("consts_msmpi.jl")))
    else
        include("gen_consts.jl")

        run(`$mpicc gen_consts.c -o gen_consts $CFLAGS`)
        run(`$mpiexec -n 1 ./gen_consts`)

        println(f, :(include("consts.jl")))
    end
end
