using Libdl


let
    global libmpi, mpiexec, mpiexec_path, _check_hpc

    # 1. attempt to find MPI implementation
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

    # 2. if not found, use BinaryBuilder-provided MPI where available
    if MPI_LIBRARY == ""
        if !Sys.iswindows()
            MPI_LIBRARY = "MPICH_jll"
        else
            error("No MPI library found.\nEnsure an MPI implementation is loaded, or set the `JULIA_MPI_PATH` variable.")
        end
        function _check_hpc()
            if haskey(ENV, "SLURM_JOBID") || haskey(ENV, "PBS_JOBID") || haskey(ENV, "LSB_JOBID")
                @warn "You appear to be using MPI.jl on a cluster with the default MPI binary.\nFor maximum performance you should use the cluster provided version.\nThis warning message can be disabled by setting the `JULIA_MPI_LIBRARY=$MPI_LIBRARY`."
            end
        end
    else
        _check_hpc() = nothing
    end

    # 3. load dependency and define mpiexec
    if endswith(MPI_LIBRARY, "_jll")
        if MPI_LIBRARY == "MPICH_jll"
            import MPICH_jll, MPICH_jll.libmpi, MPICH_jll.mpiexec_path

            function mpiexec(fn)
                mpiexec_args = Base.shell_split(get(ENV, "JULIA_MPIEXEC_ARGS", ""))
                MPICH_jll.mpiexec(mpiexec_path -> fn(`$mpiexec_path $mpiexec_args`))
            end
        elseif MPI_LIBRARY == "OpenMPI_jll"
            import OpenMPI_jll, OpenMPI_jll.libmpi, OpenMPI_jll.mpiexec_path

            function mpiexec(fn)
                mpiexec_args = Base.shell_split(get(ENV, "JULIA_MPIEXEC_ARGS", ""))
                OpenMPI_jll.mpiexec(mpiexec_path -> fn(`$mpiexec_path $mpiexec_args`))
            end

        else
            error("Unsupported MPI library $MPI_LIBRARY")
        end
    else
        const libmpi = MPI_LIBRARY

        const mpiexec_path = get(ENV, "JULIA_MPIEXEC") do
            MPI_PATH = get(ENV, "JULIA_MPI_PATH", nothing)
            if MPI_PATH !== nothing && Sys.isexecutable(joinpath(MPI_PATH,"bin","mpiexec"))
                joinpath(MPI_PATH,"bin","mpiexec")
            else
                "mpiexec"
            end
        end

        function mpiexec(fn)
            mpiexec_args = Base.shell_split(get(ENV, "JULIA_MPIEXEC_ARGS", ""))
            fn(`$mpiexec_path $mpiexec_args`)
        end
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
