#!/bin/sh
# This configuration file was taken originally from the mpi4py project
# <http://mpi4py.scipy.org/>, and then modified for Julia

set -e
set -x

MPI_IMPL="$1"
os=`uname`
OMPIVER=openmpi-3.0.0
MPICHVER=mpich-3.2.1

case "$os" in
    Darwin)
        brew update
        brew upgrade cmake
        brew cask uninstall oclint # Prevent conflict with gcc
        case "$MPI_IMPL" in
            mpich|mpich3)
                brew install mpich
                ;;
            openmpi)
                brew install openmpi
                ;;
            *)
                echo "Unknown MPI implementation: $MPI_IMPL"
                exit 1
                ;;
        esac
    ;;

    Linux)
        sudo apt-get update -q
        case "$MPI_IMPL" in
            mpich1)
                sudo apt-get install -y gfortran mpich-shmem-bin libmpich-shmem1.0-dev
                ;;
            mpich2)
                sudo apt-get install -y gfortran mpich2 libmpich2-3 libmpich2-dev
                ;;
            mpich|mpich3)
                sudo apt-get install -y gfortran hwloc
                wget http://www.mpich.org/static/downloads/3.2.1/$MPICHVER.tar.gz
                tar -zxf $MPICHVER.tar.gz
                cd $MPICHVER
                sh ./configure --prefix=$HOME/MPICH --enable-shared > /dev/null
                make -j > /dev/null
                sudo make install > /dev/null
                ;;
            openmpi)
                sudo apt-get install -y gfortran
                wget --no-check-certificate https://www.open-mpi.org/software/ompi/v3.0/downloads/$OMPIVER.tar.gz
                tar -zxf $OMPIVER.tar.gz
                cd $OMPIVER
                sh ./configure --prefix=$HOME/OpenMPI > /dev/null
                make -j > /dev/null
                sudo make install > /dev/null
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
