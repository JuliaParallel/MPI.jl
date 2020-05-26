#!/bin/sh
# This configuration file was taken originally from the mpi4py project
# <http://mpi4py.scipy.org/>, and then modified for Julia

set -e
set -x

MPI_IMPL="$1"
os=`uname`
OMPIVER=4.0.3
MPICHVER=3.3.2
IMPIVER=2019.7.217
case "$os" in
    Darwin)
        case "$MPI_IMPL" in
            none)
                ;;
            mpich|mpich3)
                brew update
                brew install mpich
                ;;
            openmpi)
                brew update
                brew install openmpi
                ;;
            *)
                echo "Unknown MPI implementation: $MPI_IMPL"
                exit 1
                ;;
        esac
    ;;

    Linux)
        case "$MPI_IMPL" in
            none)
                ;;
            mpich1)
                sudo apt-get update -q
                sudo apt-get install -y gfortran mpich-shmem-bin libmpich-shmem1.0-dev
                ;;
            mpich2)
                sudo apt-get update -q
                sudo apt-get install -y gfortran mpich2 libmpich2-3 libmpich2-dev
                ;;
            mpich|mpich3)
                sudo apt-get update -q
                sudo apt-get install -y gfortran hwloc ccache
                sudo /usr/sbin/update-ccache-symlinks
                export PATH="/usr/lib/ccache:$PATH"
                wget http://www.mpich.org/static/downloads/$MPICHVER/mpich-$MPICHVER.tar.gz
                tar -zxf mpich-$MPICHVER.tar.gz
                cd mpich-$MPICHVER
                sh ./configure --prefix=$HOME/mpich --enable-shared > /dev/null
                make -j > /dev/null
                sudo make install > /dev/null
                ;;
            openmpi)
                sudo apt-get update -q
                sudo apt-get install -y gfortran ccache
                sudo /usr/sbin/update-ccache-symlinks
                export PATH="/usr/lib/ccache:$PATH"
                wget --no-check-certificate https://www.open-mpi.org/software/ompi/v4.0/downloads/openmpi-$OMPIVER.tar.gz
                tar -zxf openmpi-$OMPIVER.tar.gz
                cd openmpi-$OMPIVER
                sh ./configure --prefix=$HOME/openmpi > /dev/null
                make -j > /dev/null
                sudo make install > /dev/null
                ;;
            intelmpi)
                wget http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/16546/l_mpi_2019.7.217.tgz
                tar -xzf l_mpi_$IMPIVER.tgz
                cd l_mpi_$IMPIVER
                cat << EOF > intel.conf
ACCEPT_EULA=accept
CONTINUE_WITH_OPTIONAL_ERROR=yes
PSET_INSTALL_DIR=${HOME}/intel
CONTINUE_WITH_INSTALLDIR_OVERWRITE=no
PSET_MODE=install
ARCH_SELECTED=ALL
COMPONENTS=;intel-conda-index-tool__x86_64;intel-comp-l-all-vars__noarch;intel-comp-nomcu-vars__noarch;intel-imb__x86_64;intel-mpi-rt__x86_64;intel-mpi-sdk__x86_64;intel-mpi-doc__x86_64;intel-mpi-samples__x86_64;intel-mpi-installer-license__x86_64;intel-conda-impi_rt-linux-64-shadow-package__x86_64;intel-conda-impi-devel-linux-64-shadow-package__x86_64;intel-mpi-psxe__x86_64;intel-psxe-common__noarch;intel-psxe-common-doc__noarch;intel-compxe-pset
EOF
                ./install.sh --silent intel.conf
                ;;

            *)
                echo "Unknown MPI implementation: $MPI_IMPL"
                exit 1
                ;;
        esac
        ;;

    *)
        echo "Unknown operating system: $os"
        exit 1
        ;;
esac
