using Libdl

function find_lib()
    MPI_LIBRARY_PATH = get(ENV, "JULIA_MPI_LIBRARY_PATH") do
        MPI_PATH = get(ENV, "JULIA_MPI_PATH", nothing)
        if MPI_PATH !== nothing
            joinpath(MPI_PATH,"lib")
        else
            nothing
        end
    end

    libmpi = get(ENV, "JULIA_MPI_LIBRARY") do
        find_library(["libmpi", "libmpi_ibm", "msmpi", "libmpich"],
                     MPI_LIBRARY_PATH !== nothing ? [MPI_LIBRARY_PATH] : [])
    end

    if libmpi == ""
        error("No MPI library found.\nEnsure an MPI implementation is loaded, or set the `JULIA_MPI_PATH` variable.")
    end

    return libmpi
end

const libmpi = find_lib()


function find_mpiexec()
    get(ENV, "JULIA_MPIEXEC") do
        MPI_PATH = get(ENV, "JULIA_MPI_PATH", nothing)
        if MPI_PATH !== nothing && Sys.isexecutable(joinpath(MPI_PATH,"bin","mpiexec"))
            joinpath(MPI_PATH,"bin","mpiexec")
        else
            "mpiexec"
        end
    end
end

const mpiexec_path = find_mpiexec()


"""
    mpiexec(fn)

A wrapper for the MPI launcher executable (typically `mpiexec`).

This will call `fn(cmd)`, where `cmd` is a `Cmd` object of the MPI launcher (typically
called `mpiexec`), along with any additional arguments specified in the
`JULIA_MPIEXEC_ARGS` environment variable.

# Usage

```jldoctest
julia> mpiexec(cmd -> run(`\$cmd -n 3 echo hello world`));
hello world
hello world
hello world
```
"""
function mpiexec(fn)
    mpiexec_args = Base.shell_split(get(ENV, "JULIA_MPIEXEC_ARGS", ""))
    fn(`$mpiexec_path $mpiexec_args`)
end
