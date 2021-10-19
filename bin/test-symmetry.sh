#!/bin/bash

# Test MPItrampoline on Symmetry, Perimeter's HPC system

# shellcheck disable=SC2016

set -euxo pipefail

path="$HOME/test-mpitrampoline-julia"
rm -rf "$path"
mkdir "$path"
cd "$path"

# Prepare
module load cmake

# Install MPIwrapper

# Ubuntu OpenMPI 2.1.1
# -DCMAKE_CXX_COMPILER=/usr/bin/mpic++
# -DCMAKE_Fortran_COMPILER=/usr/bin/mpifort

# Intel MPI 2021.1.1
# module load mpi
# -DCMAKE_CXX_COMPILER=/cm/shared/apps/intel/mpi/2021.1.1/bin/mpicxx
# -DCMAKE_Fortran_COMPILER=/cm/shared/apps/intel/mpi/2021.1.1/bin/mpifc

case MPI in

    MPI)
        MPITEST_MODULES='mpi/2021.1.1'
        MPITEST_CMAKE_OPTIONS="                                                         \
            -DMPIEXEC_EXECUTABLE=/cm/shared/apps/intel/mpi/2021.1.1/bin/mpiexec         \
            -DCMAKE_CXX_COMPILER=/cm/shared/apps/intel/mpi/2021.1.1/bin/mpicxx          \
            -DCMAKE_Fortran_COMPILER=/cm/shared/apps/intel/mpi/2021.1.1/bin/mpifc       \
        "

        MPITEST_SET_ENVVARS=''
        MPITEST_MPIEXEC_OPTIONS=''
        ;;

    MPICH)
        # ES: I don't know whether this uses Infiniband or not.
        MPITEST_MODULES='mpich/gcc-9/3.3.2'
        MPITEST_CMAKE_OPTIONS='-DMPIEXEC_EXECUTABLE=/cm/shared/apps/mpich/gcc-9/3.3.2/bin/mpiexec'
        MPITEST_SET_ENVVARS=''
        MPITEST_MPIEXEC_OPTIONS='-verbose -prepend-rank'
        ;;

    MVAPICH2)
        # DOES NOT WORK YET
        # Findings:
        # - MPITRAMPOLINE_DLOPEN_MODE=dlmopen doesn't work with
        #   multiple processes; liblzma.so.2 is not found
        # - MPITRAMPOLINE_DLOPEN_MODE=dlopen leads to a segfault in
        #   MPI_Init
        MPITEST_MODULES='mvapich2/gcc/64/2.3.2'
        MPITEST_CMAKE_OPTIONS='-DMPIEXEC_EXECUTABLE=/cm/shared/apps/mvapich2/gcc/64/2.3.2/bin/mpiexec'
        MPITEST_SET_ENVVARS='
            export MPITRAMPOLINE_DLOPEN_MODE=dlopen
        '
        MPITEST_MPIEXEC_OPTIONS='-verbose -prepend-rank'
        ;;

    OpenMPI)
        # The output states that "send" uses the "openib" BTL. This is good.
        MPITEST_MODULES='openmpi/gcc-9/64/4.1.0'
        MPITEST_CMAKE_OPTIONS="                                                         \
            -DCMAKE_CXX_COMPILER=/cm/shared/apps/openmpi/gcc-9/64/4.1.0/bin/mpic++      \
            -DCMAKE_Fortran_COMPILER=/cm/shared/apps/openmpi/gcc-9/64/4.1.0/bin/mpifort \
            -DMPIEXEC_EXECUTABLE=/cm/shared/apps/openmpi/gcc-9/64/4.1.0/bin/mpiexec     \
        "
        MPITEST_SET_ENVVARS='
            export OMPI_MCA_btl_openib_allow_ib=true
        '
        MPITEST_MPIEXEC_OPTIONS="               \
            -display-allocation                 \
            -display-map                        \
            -report-bindings                    \
            -tag-output                         \
            -mca btl_base_verbose 100           \
        "
        ;;

    *)
        echo 'Unknown MPI variant' 1>&2
        exit 1
        ;;
esac

rm -rf "$path/MPIwrapper"
git clone https://github.com/eschnett/MPIwrapper
cd "$path/MPIwrapper"
module load $MPITEST_MODULES
cmake -S . -B build                                     \
      $MPITEST_CMAKE_OPTIONS                            \
      -DCMAKE_BUILD_TYPE=Debug                          \
      -DCMAKE_INSTALL_PREFIX="$path/mpiwrapper"
cmake --build build
cmake --install build
cd "$path"
rm -rf "$path/MPIwrapper"

module load julia
julia -e '
    using Pkg;
    Pkg.generate("TestMPItrampoline");
'
cd "$path/TestMPItrampoline"
julia --project=@. -e '
    using Pkg;
    Pkg.update();
'

export MPITRAMPOLINE_VERBOSE=1
export MPITRAMPOLINE_MPIEXEC="$path/mpiwrapper/bin/mpiwrapperexec"
# export MPITRAMPOLINE_DLOPEN_BINDING=now
# export MPITRAMPOLINE_DLOPEN_MODE=dlmopen
# export MPITRAMPOLINE_PRELOAD=/cm/shared/apps/openmpi/gcc-9/64/4.1.0/lib/openmpi/mca_pmix_pmix3x.so:/cm/shared/apps/openmpi/gcc-9/64/4.1.0/lib/libmpi.so:/cm/shared/apps/openmpi/gcc-9/64/4.1.0/lib/openmpi/mca_op_avx.so
export MPITRAMPOLINE_DLOPEN_BINDING=lazy
export MPITRAMPOLINE_DLOPEN_MODE=dlopen
export MPITRAMPOLINE_PRELOAD=
export MPITRAMPOLINE_LIB="$path/mpiwrapper/lib/libmpiwrapper.so"
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
cd "$path"

git clone -b eschnett/mpitrampoline https://github.com/eschnett/MPI.jl

# Test MPI.jl
module load slurm
cat >runtests.sh <<EOF
#!/bin/bash

echo "Starting batch script"

set -euxo pipefail
cd "$path/TestMPItrampoline"
module load $MPITEST_MODULES
env | grep ^SLURM_ | sort

$MPITEST_SET_ENVVARS

export MPITRAMPOLINE_VERBOSE=1
export MPITRAMPOLINE_MPIEXEC="$path/mpiwrapper/bin/mpiwrapperexec"
# export MPITRAMPOLINE_DLOPEN_BINDING=now
# export MPITRAMPOLINE_DLOPEN_MODE=dlmopen
# export MPITRAMPOLINE_PRELOAD=/cm/shared/apps/openmpi/gcc-9/64/4.1.0/lib/openmpi/mca_pmix_pmix3x.so:/cm/shared/apps/openmpi/gcc-9/64/4.1.0/lib/libmpi.so:/cm/shared/apps/openmpi/gcc-9/64/4.1.0/lib/openmpi/mca_op_avx.so
export MPITRAMPOLINE_DLOPEN_BINDING=lazy
export MPITRAMPOLINE_DLOPEN_MODE=dlopen
export MPITRAMPOLINE_PRELOAD=
export MPITRAMPOLINE_LIB="$path/mpiwrapper/lib/libmpiwrapper.so"

# test_error.jl
# test_io.jl
# test_io_shared.jl
# test_io_subarray.jl
# test_shared_win.jl
# test_test.jl
for test in                                     \
    test_allgather.jl                           \
    test_allgatherv.jl                          \
    test_allreduce.jl                           \
    test_alltoall.jl                            \
    test_alltoallv.jl                           \
    test_basic.jl                               \
    test_bcast.jl                               \
    test_cart_coords.jl                         \
    test_cart_create.jl                         \
    test_cart_get.jl                            \
    test_cart_rank.jl                           \
    test_cart_shift.jl                          \
    test_comm.jl                                \
    test_datatype.jl                            \
    test_dims_create.jl                         \
    test_errorhandler.jl                        \
    test_exscan.jl                              \
    test_gather.jl                              \
    test_gatherv.jl                             \
    test_info.jl                                \
    test_onesided.jl                            \
    test_reduce.jl                              \
    test_scan.jl                                \
    test_scatter.jl                             \
    test_scatterv.jl                            \
    test_sendrecv.jl                            \
    test_spawn.jl                               \
    test_subarray.jl                            \
    test_threads.jl                             \
    test_universe_size.jl                       \
    test_wait.jl;
do
    echo "Starting \$test..."
    "$HOME/.julia/bin/mpiexecjl"                        \
        -n "\$SLURM_NTASKS"                             \
        $MPITEST_MPIEXEC_OPTIONS                        \
        julia --project=@. "$path/MPI.jl/test/\$test"
    echo "Finished \$test."
done

echo "Batch script done."
EOF
chmod a+x runtests.sh
: >runtests.out
tail -f runtests.out &
tail_pid=$!
sbatch                                          \
    --nodes=2                                   \
    --open-mode=append                          \
    --output=runtests.out                       \
    --partition=debugq                          \
    --tasks-per-node=2                          \
    --time=1:0:0                                \
    --wait                                      \
    runtests.sh
sleep 3
kill $tail_pid
cd "$path"

echo "All tests completed successfully."
