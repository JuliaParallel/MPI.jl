# Copyright (C) 2023 Guilherme Bodin
# License is MIT "Expat"
#
# Commentary:
#
# Command line utility to call the `mpiexec` binary used by the `MPI.jl` version
# in the given Julia project. It has the same syntax as the `mpiexec` binary
# that would be called, with the additional `--project=...` flag to select a
# different Julia project.
#
# Examples of usage (the MPI flags available depend on the MPI implementation
# called):
#
#   $ mpiexecjl -n 40 julia mpi-script.jl
#   $ mpiexecjl --project=my_experiment -n 80 --oversubscribe julia mpi-script.jl

function usage {
    Write-Host "Usage: $([System.IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name)) [--project=...] MPIEXEC_ARGUMENTS..."
    Write-Host "Call the mpiexec binary in the Julia environment specified by the --project option."
    Write-Host "If no project is specified, the MPI associated with the global Julia environment will be used."
    Write-Host "All other arguments are forwarded to mpiexec."
}

$julia_args = @()
$PROJECT_ARG = ""

foreach ($arg in $args) {
    if ($arg -match "^--project(=.*)?$") {
        $PROJECT_ARG = $arg
    }
    elseif ($arg -eq "-h" -or $arg -eq "--help") {
        $helpRequested = $true
        usage
        Write-Host "Below is the help of the current mpiexec."
        Write-Host
        exit 0
    }
    else {
        $julia_args += $arg
    }
}

if (-not $julia_args) {
    Write-Error "ERROR: no arguments specified."
    usage
    exit 1
}

if ($env:JULIA_BINDIR) {
    $JULIA_CMD = Join-Path $env:JULIA_BINDIR "julia"
} else {
    $JULIA_CMD = "julia"
}

$SCRIPT = @'
using MPI
ENV[\"JULIA_PROJECT\"] = dirname(Base.active_project())
mpiexec(exe -> run(`$exe $ARGS`))
'@

$PRECOMPILATION_SCRIPT = @'
println(\"precompiling current project before running MPI\")

import Pkg
Pkg.activate(dirname(Base.active_project()))
Pkg.instantiate()

println(\"precompilation finished\")
'@

& $JULIA_CMD $PROJECT_ARG -e $PRECOMPILATION_SCRIPT

if ($PROJECT_ARG) {
    & $JULIA_CMD $PROJECT_ARG --color=yes --startup-file=no --compile=min -O0 -e $SCRIPT -- $julia_args
} else {
    & $JULIA_CMD --color=yes --startup-file=no --compile=min -O0 -e $SCRIPT -- $julia_args
}