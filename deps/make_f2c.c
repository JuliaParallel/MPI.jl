#include <stdio.h>
#include "jlmpi_f2c.h"
#include "version.h"

#define STRING1(s) #s
#define STRING(s) STRING1(s)

int main (int argc, char *argv[])
{
  printf("const WRAPPER_VERSION        = \"%s\"\n", VERSION);
  printf("const MPI_ABORT              = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_ABORT));
  printf("const MPI_ALLGATHER          = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_ALLGATHER));
  printf("const MPI_ALLGATHERV         = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_ALLGATHERV));
  printf("const MPI_ALLREDUCE          = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_ALLREDUCE));
  printf("const MPI_ALLTOALL           = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_ALLTOALL));
  printf("const MPI_ALLTOALLV          = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_ALLTOALLV));
  printf("const MPI_BARRIER            = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_BARRIER));
  printf("const MPI_BCAST              = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_BCAST));
  printf("const MPI_BSEND              = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_BSEND));
  printf("const MPI_CANCEL             = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_CANCEL));
  printf("const MPI_COMM_DUP           = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_COMM_DUP));
  printf("const MPI_COMM_FREE          = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_COMM_FREE));
  printf("const MPI_COMM_RANK          = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_COMM_RANK));
  printf("const MPI_COMM_SIZE          = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_COMM_SIZE));
  printf("const MPI_COMM_SPLIT         = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_COMM_SPLIT));
  printf("const MPI_EXSCAN             = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_EXSCAN));
  printf("const MPI_FINALIZE           = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_FINALIZE));
  printf("const MPI_FINALIZED          = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_FINALIZED));
  printf("const MPI_GATHER             = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_GATHER));
  printf("const MPI_GATHERV            = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_GATHERV));
  printf("const MPI_GET_COUNT          = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_GET_COUNT));
  printf("const MPI_GET_PROCESSOR_NAME = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_GET_PROCESSOR_NAME));
  printf("const MPI_INIT               = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_INIT));
  printf("const MPI_INITIALIZED        = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_INITIALIZED));
  printf("const MPI_IPROBE             = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_IPROBE));
  printf("const MPI_IRECV              = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_IRECV));
  printf("const MPI_ISEND              = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_ISEND));
  printf("const MPI_OP_CREATE          = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_OP_CREATE));
  printf("const MPI_OP_FREE            = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_OP_FREE));
  printf("const MPI_PACK               = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_PACK));
  printf("const MPI_PACK_SIZE          = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_PACK_SIZE));
  printf("const MPI_PROBE              = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_PROBE));
  printf("const MPI_RECV               = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_RECV));
  printf("const MPI_RECV_INIT          = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_RECV_INIT));
  printf("const MPI_REDUCE             = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_REDUCE));
  printf("const MPI_REQUEST_FREE       = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_REQUEST_FREE));
  printf("const MPI_RSEND              = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_RSEND));
  printf("const MPI_SCAN               = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_SCAN));
  printf("const MPI_SCATTER            = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_SCATTER));
  printf("const MPI_SCATTERV           = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_SCATTERV));
  printf("const MPI_SEND               = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_SEND));
  printf("const MPI_SEND_INIT          = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_SEND_INIT));
  printf("const MPI_SSEND              = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_SSEND));
  printf("const MPI_TEST               = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_TEST));
  printf("const MPI_UNPACK             = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_UNPACK));
  printf("const MPI_WAIT               = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_WAIT));
  printf("const MPI_WAITALL            = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_WAITALL));
  printf("const MPI_WAITANY            = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_WAITANY));
  printf("const MPI_WTIME              = Libdl.dlsym(libmpi, \"%s\")\n", STRING(MPI_WTIME));

  return 0;
}
