#!/bin/bash

# Test MPItrampoline on Graham, a Compute Canada HPC system

# shellcheck disable=SC2016

set -euxo pipefail

path="$HOME/test-mpitrampoline-julia"
rm -rf "$path"
mkdir "$path"
cd "$path"

# Prepare
# module unload intel
# module load gcc/10.3.0
# module unload openmpi

# Install MPIwrapper
case intel/2020.1.217 in

    intel/2020.1.217)
        MPITEST_MODULES=''
        MPITEST_CMAKE_OPTIONS='-DMPIEXEC_EXECUTABLE=/cvmfs/soft.computecanada.ca/easybuild/software/2020/avx2/Compiler/intel2020/openmpi/4.0.3/bin/mpiexec'
        MPITEST_SET_ENVVARS='
            export MPITRAMPOLINE_DLOPEN_MODE=dlopen
            export OMPI_MCA_btl_base_verbose=100
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
rm -rf "$path/MPIwrapper"

module load julia/1.6.2
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

# export OMPI_MCA_btl=^openib
# export OMPI_MCA_coll=^hcoll
# export OMPI_MCA_plm_slurm_args=--whole
# export OMPI_MCA_pml=^yalla

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
export MPITRAMPOLINE_DLOPEN_MODE=dlopen
export MPITRAMPOLINE_PRELOAD=
export MPITRAMPOLINE_LIB="$path/mpiwrapper/lib/libmpiwrapper.so"

# export OMPI_MCA_btl=^openib
# export OMPI_MCA_coll=^hcoll
# export OMPI_MCA_plm_slurm_args=--whole
# export OMPI_MCA_pml=^yalla

which julia
julia --project=@. -e 'using InteractiveUtils; versioninfo()'
srun julia --project=@. -e 'using InteractiveUtils; versioninfo()'
srun julia --project=@. -e 'using MPItrampoline_jll'
srun julia --project=@. -e 'using MPI'
srun julia --project=@. -e 'using MPI; MPI.Init()'

# test_error.jl
# test_spawn.jl
# test_io.jl
# test_io_shared.jl
# test_io_subarray.jl
# test_shared_win.jl
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
    test_subarray.jl                            \
    test_test.jl                                \
    test_threads.jl                             \
    test_universe_size.jl                       \
    test_wait.jl;
do
    echo "Starting \$test..."
    srun                                                \
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
    --account=def-eschnett                      \
    --mem=128000MB                              \
    --nodes=2                                   \
    --open-mode=append                          \
    --output=runtests.out                       \
    --tasks-per-node=2                          \
    --time=0:30:0                               \
    --wait                                      \
    runtests.sh
sleep 3
kill $tail_pid
cd "$path"

echo "All tests completed successfully."
