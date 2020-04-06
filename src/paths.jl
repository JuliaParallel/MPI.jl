using Libdl


struct SystemBinary
    libmpi::String
    mpiexec_path::String
end

struct JLLBinary
    jllname::String
end

function find_binary()

    # 1. check if JULIA_MPI_BINARY is defined
    MPI_LIBRARY = ""
    MPI_BINARY = get(ENV, "JULIA_MPI_BINARY", "")

    # 2. attempt to find MPI implementation
    if MPI_BINARY == "" || MPI_BINARY == "System"

        MPI_PATH = get(ENV, "JULIA_MPI_PATH", nothing)

        MPI_LIBRARY_PATH = get(ENV, "JULIA_MPI_LIBRARY_PATH") do
            if MPI_PATH !== nothing
                joinpath(MPI_PATH,"lib")
            else
                nothing
            end
        end

        MPI_LIBRARY = get(ENV, "JULIA_MPI_LIBRARY") do
            find_library(["libmpi", "libmpi_ibm", "msmpi", "libmpich"],
                         MPI_LIBRARY_PATH !== nothing ? [MPI_LIBRARY_PATH] : [])
        end

        if MPI_LIBRARY != ""
            MPIEXEC = get(ENV, "JULIA_MPIEXEC") do
                MPI_PATH = get(ENV, "JULIA_MPI_PATH", nothing)
                if MPI_PATH !== nothing && Sys.isexecutable(joinpath(MPI_PATH,"bin","mpiexec"))
                    joinpath(MPI_PATH,"bin","mpiexec")
                else
                    "mpiexec"
                end
            end
            return SystemBinary(MPI_LIBRARY, MPIEXEC)
        end
    end

    # 3. if not found, use BinaryBuilder-provided MPI where available
    if MPI_BINARY == "System"
        error("Cannot find system MPI implementation")
    elseif MPI_BINARY == ""
        if Sys.iswindows()
            MPI_BINARY = "MicrosoftMPI_jll"
        else
            MPI_BINARY = "MPICH_jll"
        end
    end
    if MPI_BINARY in ["MPICH_jll", "OpenMPI_jll", "MicrosoftMPI_jll"]
        return JLLBinary(MPI_BINARY)
    else
        error("Unknown MPI_BINARY=$MPI_BINARY")
    end
end

const BINARY = find_binary()

if BINARY isa JLLBinary
    if BINARY.jllname == "MPICH_jll"
        import MPICH_jll
        const MPI_jll = MPICH_jll
    elseif BINARY.jllname == "OpenMPI_jll"
        import OpenMPI_jll
        const MPI_jll = OpenMPI_jll
    elseif BINARY.jllname == "MicrosoftMPI_jll"
        import MicrosoftMPI_jll
        const MPI_jll = MicrosoftMPI_jll
    else
        error("Unknown binary $(BINARY.jllname)")
    end

    const libmpi = MPI_jll.libmpi
    const mpiexec_path = MPI_jll.mpiexec_path

    function mpiexec(fn)
        mpiexec_args = Base.shell_split(get(ENV, "JULIA_MPIEXEC_ARGS", ""))
        MPI_jll.mpiexec(mpiexec_path -> fn(`$mpiexec_path $mpiexec_args`))
    end
else
    const libmpi = BINARY.libmpi
    const mpiexec_path = BINARY.mpiexec_path

    function mpiexec(fn)
        mpiexec_args = Base.shell_split(get(ENV, "JULIA_MPIEXEC_ARGS", ""))
        fn(`$mpiexec_path $mpiexec_args`)
    end
end

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
mpiexec


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
