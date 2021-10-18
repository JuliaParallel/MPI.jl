# Test MPItrampoline on various CPU architectures
# Run `docker build --file test-i686-debian.dockerfile .`

FROM i386/debian:11.1

# Install packages
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get --yes --no-install-recommends install \
        build-essential \
        ca-certificates \
        cmake \
        g++ \
        gdb \
        gfortran \
        git \
        python3 \
        wget

# Switch to user
RUN groupadd -r cactus && useradd -r -g cactus cactus
USER cactus
WORKDIR /home/cactus

# Install Julia
RUN wget https://julialang-s3.julialang.org/bin/linux/x86/1.6/julia-1.6.3-linux-i686.tar.gz
RUN tar xzf julia-1.6.3-linux-i686.tar.gz
ENV PATH="/home/cactus/julia-1.6.3/bin:${PATH}"

RUN julia -e ' \
    using Pkg; \
    Pkg.update(); \
'

ENV MPITRAMPOLINE_VERBOSE=1
ENV MPITRAMPOLINE_DLOPEN_MODE=dlopen
RUN mkdir -p "${HOME}/.julia/prefs"
RUN echo 'binary = "MPItrampoline_jll"' >"${HOME}/.julia/prefs/MPI.toml"
RUN julia -e ' \
    using Pkg; \
    Pkg.add(url="https://github.com/eschnett/MPItrampoline_jll.jl", rev="main"); \
    '
RUN julia -e ' \
    using Pkg; \
    Pkg.add(url="https://github.com/eschnett/MPI.jl", rev="eschnett/mpitrampoline"); \
    '
RUN julia -e ' \
    using Pkg; \
    Pkg.status(); \
    '
RUN julia -e ' \
    using Pkg; \
    Pkg.build("MPI"); \
    '
RUN julia -e ' \
    using MPI; \
    MPI.install_mpiexecjl(); \
    '

RUN julia -e ' \
    using Pkg; \
    Pkg.add(url="https://github.com/eschnett/ADIOS2_jll.jl", rev="main"); \
    '
RUN julia -e ' \
    using Pkg; \
    Pkg.add("ADIOS2"); \
    '

RUN julia -e ' \
    using Pkg; \
    Pkg.add(url="https://github.com/eschnett/openPMD_api_jll.jl", rev="main"); \
    '
RUN julia -e ' \
    using Pkg; \
    Pkg.add("openPMD"); \
    '

RUN julia -e ' \
    using Pkg; \
    Pkg.add("DoubleFloats"); \
    '
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_allgather.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_allgatherv.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_allreduce.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_alltoall.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_alltoallv.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_basic.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_bcast.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_cart_coords.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_cart_create.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_cart_get.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_cart_rank.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_cart_shift.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_comm.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_datatype.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_dims_create.jl"
# RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_error.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_errorhandler.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_exscan.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_gather.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_gatherv.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_info.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_io.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_io_shared.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_io_subarray.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_onesided.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_reduce.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_scan.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_scatter.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_scatterv.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_sendrecv.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_shared_win.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_spawn.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_subarray.jl"
# RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_test.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_threads.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_universe_size.jl"
RUN "${HOME}/.julia/bin/mpiexecjl" -n 3 julia "${HOME}/.julia/packages/MPI/"*"/test/test_wait.jl"
