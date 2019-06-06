using Libdl

@static if Sys.iswindows()
    const libmpi = "msmpi.dll"
else
    const libmpi = "libmpi"
end

libptr = dlopen_e(libmpi)
if libptr == C_NULL
    error("No MPI library found")
end

libpath = dlpath(libptr)
libsize = filesize(libpath)

function Get_version()
    major = Ref{Cint}()
    minor = Ref{Cint}()
    ccall((:MPI_Get_version, libmpi), Cint,
          (Ptr{Cint}, Ptr{Cint}), major, minor)
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
end

if Sys.iswindows()
    open("deps.jl","a") do f
        println(f, :(include("consts_msmpi.jl")))
    end
else
    include("gen_consts.jl")
end
