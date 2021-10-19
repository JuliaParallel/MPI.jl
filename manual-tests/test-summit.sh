#!/bin/bash

# Test MPItrampoline on Summit, an HPC system at ORNL

set -euxo pipefail

path="$HOME/test-mpitrampoline-julia"
rm -rf "$path"
mkdir "$path"
cd "$path"

# Prepare
# module load gcc/11.1.0
module load cmake

# Install MPIwrapper
case spectrum-mpi/10.4.0.3-20210112 in

    spectrum-mpi/10.4.0.3-20210112)
        MPITEST_MODULES='spectrum-mpi/10.4.0.3-20210112'
        MPITEST_CMAKE_OPTIONS='-DMPIEXEC_EXECUTABLE=/sw/summit/spack-envs/base/opt/linux-rhel8-ppc64le/xl-16.1.1-10/spectrum-mpi-10.4.0.3-20210112-v7qymniwgi6mtxqsjd7p5jxinxzdkhn3/bin/mpiexec'
        MPITEST_SET_ENVVARS='
            export MPITRAMPOLINE_DLOPEN_MODE=dlopen
        '
        MPITEST_MPIEXEC_OPTIONS=''
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
rm -rf "$path/MPIwrapper" || true
sleep 1
rm -rf "$path/MPIwrapper"

module load julia/1.6.1
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
export MPITRAMPOLINE_DLOPEN_MODE=dlopen
export MPITRAMPOLINE_PRELOAD=
export MPITRAMPOLINE_LIB="$path/mpiwrapper/lib/libmpiwrapper.so"

echo 'binary = "MPItrampoline_jll"' >"${HOME}/.julia/prefs/MPI.toml"
julia --project=@. -e '
    using Pkg;
    Pkg.add(url="https://github.com/eschnett/MPItrampoline_jll.jl", rev="main");
    '
julia --project=@. -e '
    using Pkg;
    Pkg.add(url="https://github.com/eschnett/MPI.jl", rev="eschnett/mpitrampoline");
    '
julia --project=@. -e '
    using Pkg;
    Pkg.status();
    '
julia --project=@. -e '
    using Pkg;
    Pkg.build("MPI");
    '
julia --project=@. -e '
    using MPI;
    MPI.install_mpiexecjl(force=true);
    '

julia --project=@. -e '
    using Pkg;
    Pkg.add(url="https://github.com/eschnett/ADIOS2_jll.jl", rev="main");
    '
julia --project=@. -e '
    using Pkg;
    Pkg.add("ADIOS2");
    '

julia --project=@. -e '
    using Pkg;
    Pkg.add(url="https://github.com/eschnett/openPMD_api_jll.jl", rev="main");
    '
julia --project=@. -e '
    using Pkg;
    Pkg.add("openPMD");
    '

julia --project=@. -e '
    using Pkg;
    Pkg.add("DoubleFloats");
    '
cd "$path"

git clone -b eschnett/mpitrampoline https://github.com/eschnett/MPI.jl

# Test MPI.jl
cat >runtests.sh <<EOF
#!/bin/bash

echo "Starting batch script"

set -euxo pipefail
cd "$path/TestMPItrampoline"
module load $MPITEST_MODULES
env | grep '^LSB\?_' | sort

$MPITEST_SET_ENVVARS

export MPITRAMPOLINE_VERBOSE=1
export MPITRAMPOLINE_MPIEXEC="$path/mpiwrapper/bin/mpiwrapperexec"
export MPITRAMPOLINE_DLOPEN_MODE=dlopen
export MPITRAMPOLINE_PRELOAD=
export MPITRAMPOLINE_LIB="$path/mpiwrapper/lib/libmpiwrapper.so"

# test_error.jl
# test_sendrecv.jl
# test_spawn.jl
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
    test_io.jl                                  \
    test_io_shared.jl                           \
    test_io_subarray.jl                         \
    test_onesided.jl                            \
    test_reduce.jl                              \
    test_scan.jl                                \
    test_scatter.jl                             \
    test_scatterv.jl                            \
    test_shared_win.jl                          \
    test_subarray.jl                            \
    test_threads.jl                             \
    test_universe_size.jl                       \
    test_wait.jl;
do
    echo "Starting \$test..."
    jsrun -n4 -a1 -c1                                   \
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
bsub                                            \
    -K                                          \
    -P ast154                                   \
    -W 1:00                                     \
    -alloc_flags smt1                           \
    -eo runtests.out                            \
    -nnodes 2                                   \
    -q batch                                    \
    runtests.sh
sleep 3
kill $tail_pid
cd "$path"

echo "All tests completed successfully."
