#!/bin/sh
# This configuration file was taken originally from the mpi4py project
# <http://mpi4py.scipy.org/>, and then modified for Julia

set -e
set -x

impl="$1"
os=`uname`

case "$os" in
    Darwin)
        # TODO: Don't build -- but how? Use Homebrew? Macport seems to
        # want to build a compiler first, which takes too long.
        case "$impl" in
            mpich|mpich3)
                wget http://www.mpich.org/static/downloads/3.1.4/mpich-3.1.4.tar.gz
                tar xzf mpich-3.1.4.tar.gz
                cd mpich-3.1.4
                ./configure
                # Need to limit output to avoid Travis's $ MByte log file limit
                make -j2 | pv -bl >/dev/null
                sudo make install
                ;; 
            openmpi)
                wget http://www.open-mpi.org/software/ompi/v1.10/downloads/openmpi-1.10.0.tar.bz2
                tar xjf openmpi-1.10.0.tar.bz2
                cd openmpi-1.10.0
                ./configure
                # Need to limit output to avoid Travis's $ MByte log file limit
                make -j2 | pv -bl >/dev/null
                sudo make install
                ;;
            *)
                echo "Unknown MPI implementation: $impl"
                exit 1
                ;;
        esac
    ;;

    Linux)
        sudo apt-get update -q
        case "$impl" in
            mpich1)
                sudo apt-get install -q gfortran mpich-shmem-bin libmpich-shmem1.0-dev
                ;;
            mpich2)
                sudo apt-get install -q gfortran mpich2 libmpich2-3 libmpich2-dev
                ;;
            mpich|mpich3)
                sudo apt-get install -q gfortran libcr0 default-jdk
                wget -q http://www.cebacad.net/files/mpich/ubuntu/mpich-3.1/mpich_3.1-1ubuntu_amd64.deb
                sudo dpkg -i ./mpich_3.1-1ubuntu_amd64.deb
                rm -f ./mpich_3.1-1ubuntu_amd64.deb
                ;;
            openmpi)
                sudo apt-get install -q gfortran openmpi-bin openmpi-common libopenmpi-dev
                ;;
            *)
                echo "Unknown MPI implementation: $impl"
                exit 1
                ;;
        esac
        ;;

    *)
        echo "Unknown operating system: $os"
        exit 1
        ;;
esac
