"""
    MPI.install_mpiexecjl(; command::String = "mpiexecjl",
                          destdir::String = joinpath(DEPOT_PATH[1], "bin"),
                          force::Bool = false, verbose::Bool = true)

Install the `mpiexec` wrapper to `destdir` directory, with filename `command`.
Set `force` to `true` to overwrite an existing destination file with the same
path.  If `verbose` is `true`, the installation prints information about the
progress of the process.
"""
function install_mpiexecjl(; command::String = "mpiexecjl",
                           destdir::String = joinpath(DEPOT_PATH[1], "bin"),
                           force::Bool = false, verbose::Bool = true)
    # Adapted from https://github.com/fredrikekre/jlpkg.
    destdir = abspath(expanduser(destdir))
    exec = joinpath(destdir, command)
    if ispath(exec) && !force
        error("file `$(exec)` already exists; use `MPI.install_mpiexecjl(force=true)` to overwrite.")
    end
    mkpath(destdir)
    verbose && @info "Installing `$(command)` to `$(destdir)`..."
    cp(joinpath(@__DIR__, "..", "bin", "mpiexecjl"), exec; force = force)
    verbose && @info "Done!"
end
