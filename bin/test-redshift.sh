#!/bin/bash

# Test MPItrampoline on Redshift, a macOS laptop

# shellcheck disable=all

set -euxo pipefail

path="$HOME/test-mpitrampoline-julia"
rm -rf "$path"
mkdir "$path"
cd "$path"

# Install MPIwrapper
case OpenMPI in

    MPICH)
        MPITEST_CMAKE_OPTIONS="                                                 \
            -DMPIEXEC_EXECUTABLE=/Users/eschnett/mpich-3.4.2/bin/mpiexec        \
        "
        MPITEST_SET_ENVVARS=''
        MPITEST_MPIEXEC_OPTIONS='-prepend-rank'
        ;;

    MPICH-macports)
        # Avoid the flag `-flat_namespace` in MPICH's mpicxx.
        # This makes C/C++ work, but some Fortran tests still fail.
        MPITEST_CMAKE_OPTIONS="                                                         \
            -DCMAKE_CXX_COMPILER=g++-mp-10                                              \
            -DCMAKE_Fortran_COMPILER=gfortran-mp-10                                     \
            -DMPI_CXX_ADDITIONAL_INCLUDE_DIRS=/opt/local/include/mpich-gcc10            \
            -DMPI_CXX_LIB_NAMES='mpicxx;mpi;pmpi'                                       \
            -DMPI_Fortran_ADDITIONAL_INCLUDE_DIRS=/opt/local/include/mpich-gcc10        \
            -DMPI_Fortran_LIB_NAMES='mpifort;mpi;pmpi'                                  \
            -DMPI_mpi_LIBRARY=/opt/local/lib/mpich-gcc10/libmpi.dylib                   \
            -DMPI_mpicxx_LIBRARY=/opt/local/lib/mpich-gcc10/libmpicxx.dylib             \
            -DMPI_mpifort_LIBRARY=/opt/local/lib/mpich-gcc10/libmpifort.dylib           \
            -DMPI_pmpi_LIBRARY=/opt/local/lib/mpich-gcc10/libpmpi.dylib                 \
            -DMPIEXEC_EXECUTABLE=/opt/local/bin/mpiexec-mpich-gcc10                     \
        "
        MPITEST_SET_ENVVARS=''
        MPITEST_MPIEXEC_OPTIONS='-prepend-rank'
        ;;

    OpenMPI)
        MPITEST_CMAKE_OPTIONS="                                         \
            -DMPIEXEC_EXECUTABLE=/opt/local/bin/mpiexec-openmpi-gcc11   \
            -DCMAKE_CXX_COMPILER=mpicxx-openmpi-gcc11                   \
            -DCMAKE_Fortran_COMPILER=mpifort-openmpi-gcc11              \
        "
        MPITEST_SET_ENVVARS=''
        MPITEST_MPIEXEC_OPTIONS='-tag-output'
        ;;

    *)
        echo 'Unknown MPI variant' 1>&2
        exit 1
        ;;
esac

rm -rf "$path/MPIwrapper"
git clone https://github.com/eschnett/MPIwrapper
cd "$path/MPIwrapper"
cmake -S . -B build                                     \
      $MPITEST_CMAKE_OPTIONS                            \
      -DCMAKE_BUILD_TYPE=Debug                          \
      -DCMAKE_INSTALL_PREFIX="$path/local/mpiwrapper"
cmake --build build
cmake --install build
cd "$path"

julia -e '
    using Pkg;
    Pkg.generate("TestMPItrampoline");
'
cd TestMPItrampoline
julia --project=@. -e '
    using Pkg;
    Pkg.update();
'

# export MPITRAMPOLINE_VERBOSE=1
export MPITRAMPOLINE_MPIEXEC="$path/local/mpiwrapper/bin/mpiwrapperexec"
export MPITRAMPOLINE_PRELOAD=
export MPITRAMPOLINE_LIB="$path/local/mpiwrapper/lib/libmpiwrapper.so"
echo 'binary = "MPItrampoline_jll"' >"${HOME}/.julia/prefs/MPI.toml"
julia --project=@. -e ' \
    using Pkg; \
    Pkg.add(url="https://github.com/eschnett/MPItrampoline_jll.jl", rev="main"); \
    '
julia --project=@. -e ' \
    using Pkg; \
    Pkg.add(url="https://github.com/eschnett/MPI.jl", rev="eschnett/mpitrampoline"); \
    '
julia --project=@. -e ' \
    using Pkg; \
    Pkg.status(); \
    '
julia --project=@. -e ' \
    using Pkg; \
    Pkg.build("MPI"); \
    '
julia --project=@. -e ' \
    using MPI; \
    MPI.install_mpiexecjl(force=true); \
    '

julia --project=@. -e ' \
    using Pkg; \
    Pkg.add(url="https://github.com/eschnett/ADIOS2_jll.jl", rev="main"); \
    '
julia --project=@. -e ' \
    using Pkg; \
    Pkg.add("ADIOS2"); \
    '

julia --project=@. -e ' \
    using Pkg; \
    Pkg.add(url="https://github.com/eschnett/openPMD_api_jll.jl", rev="main"); \
    '
julia --project=@. -e ' \
    using Pkg; \
    Pkg.add("openPMD"); \
    '

julia --project=@. -e ' \
    using Pkg; \
    Pkg.add("DoubleFloats"); \
    '

git clone -b eschnett/mpitrampoline https://github.com/eschnett/MPI.jl

"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_allgather.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_allgatherv.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_allreduce.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_alltoall.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_alltoallv.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_basic.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_bcast.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_cart_coords.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_cart_create.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_cart_get.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_cart_rank.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_cart_shift.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_comm.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_datatype.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_dims_create.jl"
# "${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_error.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_errorhandler.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_exscan.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_gather.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_gatherv.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_info.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_io.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_io_shared.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_io_subarray.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_onesided.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_reduce.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_scan.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_scatter.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_scatterv.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_sendrecv.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_shared_win.jl"
# "${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_spawn.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_subarray.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_test.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_threads.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_universe_size.jl"
"${HOME}/.julia/bin/mpiexecjl" -n 3 julia --project=@. "MPI.jl/test/test_wait.jl"
