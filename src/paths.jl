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

A wrapper function for the MPI launcher executable. Calls `fn(cmd)`, where `cmd` is a `Cmd` object of the MPI launcher.

# Environment Variables

The behaviour of `mpiexec` can be controlled by the following environment variables:

- `JULIA_MPIEXEC`: the name or path of the launcher executable (set at compile time).
- `JULIA_MPIEXEC_ARGS`: additional arguments that are passed to the launcher. These are space seperated, supporting the same quoting rules as
  Julia `Cmd` objects. These can be modified at run time.

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


const use_stdcall = startswith(basename(libmpi), "msmpi")

macro mpicall(expr)
    @assert expr isa Expr && expr.head == :call && expr.args[1] == :ccall
    # Microsoft MPI uses stdcall calling convention
    # this only affects 32-bit Windows
    # unfortunately we need to use ccall to call Get_library_version
    # so check using library name instead
    if use_stdcall
        insert!(expr.args, 3, :stdcall)
    end
    return esc(expr)
end
