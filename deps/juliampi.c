#include <stdlib.h>
#include <mpi.h>

void finalize_atexit()
{
    int iflag, fflag;
    MPI_Initialized(&iflag);
    MPI_Finalized(&fflag);
    if (iflag && !fflag)
    {
        MPI_Finalize();
    }
}

int install_finalize_atexit_hook()
{
    return atexit(finalize_atexit);
}
