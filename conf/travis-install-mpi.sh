#!/bin/sh
# This configuration file was taken originally from the mpi4py project
# <http://mpi4py.scipy.org/>, and then modified for Julia

set -e
set -x

MPI_IMPL="$1"
os=`uname`

case "$os" in
    Darwin)
        brew update
        brew upgrade cmake
	    brew upgrade gcc
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
                sudo apt-get install -y gfortran libcr0 default-jdk hwloc libmpich10 libmpich-dev
                wget -q http://de.archive.ubuntu.com/ubuntu/pool/universe/m/mpich/mpich_3.0.4-6ubuntu1_amd64.deb
                sudo dpkg -i ./mpich_3.0.4-6ubuntu1_amd64.deb
                # rm -f ./mpich_3.1-1ubuntu_amd64.deb
                ;;
            openmpi)
                sudo apt-get install -y gfortran
                wget --no-check-certificate https://www.open-mpi.org/software/ompi/v1.10/downloads/openmpi-1.10.2.tar.gz
                tar -zxf openmpi-1.10.2.tar.gz
                cd openmpi-1.10.2
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
