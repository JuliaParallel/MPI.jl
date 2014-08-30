
#include <stdio.h>
#include "jlmpi_f2c.h"
#include "version.h"

#define STRING1(s) #s
#define STRING(s) STRING1(s)

int main (int argc, char *argv[])
{
  printf("const WRAPPER_VERSION        = \"%s\"\n", VERSION);
  printf("const MPI_ABORT              = dlsym(libmpi, \"%s\")\n", STRING(MPI_ABORT));
  printf("const MPI_ALLREDUCE          = dlsym(libmpi, \"%s\")\n", STRING(MPI_ALLREDUCE));
  printf("const MPI_ALLTOALL           = dlsym(libmpi, \"%s\")\n", STRING(MPI_ALLTOALL));
  printf("const MPI_BARRIER            = dlsym(libmpi, \"%s\")\n", STRING(MPI_BARRIER));
  printf("const MPI_BCAST              = dlsym(libmpi, \"%s\")\n", STRING(MPI_BCAST));
  printf("const MPI_BSEND              = dlsym(libmpi, \"%s\")\n", STRING(MPI_BSEND));
  printf("const MPI_CANCEL             = dlsym(libmpi, \"%s\")\n", STRING(MPI_CANCEL));
  printf("const MPI_COMM_DUP           = dlsym(libmpi, \"%s\")\n", STRING(MPI_COMM_DUP));
  printf("const MPI_COMM_FREE          = dlsym(libmpi, \"%s\")\n", STRING(MPI_COMM_FREE));
  printf("const MPI_COMM_RANK          = dlsym(libmpi, \"%s\")\n", STRING(MPI_COMM_RANK));
  printf("const MPI_COMM_SIZE          = dlsym(libmpi, \"%s\")\n", STRING(MPI_COMM_SIZE));
  printf("const MPI_COMM_SPLIT         = dlsym(libmpi, \"%s\")\n", STRING(MPI_COMM_SPLIT));
  printf("const MPI_FINALIZE           = dlsym(libmpi, \"%s\")\n", STRING(MPI_FINALIZE));
  printf("const MPI_FINALIZED          = dlsym(libmpi, \"%s\")\n", STRING(MPI_FINALIZED));
  printf("const MPI_GATHER             = dlsym(libmpi, \"%s\")\n", STRING(MPI_GATHER));
  printf("const MPI_GET_COUNT          = dlsym(libmpi, \"%s\")\n", STRING(MPI_GET_COUNT));
  printf("const MPI_GET_PROCESSOR_NAME = dlsym(libmpi, \"%s\")\n", STRING(MPI_GET_PROCESSOR_NAME));
  printf("const MPI_INIT               = dlsym(libmpi, \"%s\")\n", STRING(MPI_INIT));
  printf("const MPI_INITIALIZED        = dlsym(libmpi, \"%s\")\n", STRING(MPI_INITIALIZED));
  printf("const MPI_IPROBE             = dlsym(libmpi, \"%s\")\n", STRING(MPI_IPROBE));
  printf("const MPI_IRECV              = dlsym(libmpi, \"%s\")\n", STRING(MPI_IRECV));
  printf("const MPI_ISEND              = dlsym(libmpi, \"%s\")\n", STRING(MPI_ISEND));
  printf("const MPI_OP_CREATE          = dlsym(libmpi, \"%s\")\n", STRING(MPI_OP_CREATE));
  printf("const MPI_OP_FREE            = dlsym(libmpi, \"%s\")\n", STRING(MPI_OP_FREE));
  printf("const MPI_PACK               = dlsym(libmpi, \"%s\")\n", STRING(MPI_PACK));
  printf("const MPI_PACK_SIZE          = dlsym(libmpi, \"%s\")\n", STRING(MPI_PACK_SIZE));
  printf("const MPI_PROBE              = dlsym(libmpi, \"%s\")\n", STRING(MPI_PROBE));
  printf("const MPI_RECV               = dlsym(libmpi, \"%s\")\n", STRING(MPI_RECV));
  printf("const MPI_RECV_INIT          = dlsym(libmpi, \"%s\")\n", STRING(MPI_RECV_INIT));
  printf("const MPI_REDUCE             = dlsym(libmpi, \"%s\")\n", STRING(MPI_REDUCE));
  printf("const MPI_REQUEST_FREE       = dlsym(libmpi, \"%s\")\n", STRING(MPI_REQUEST_FREE));
  printf("const MPI_RSEND              = dlsym(libmpi, \"%s\")\n", STRING(MPI_RSEND));
  printf("const MPI_SEND               = dlsym(libmpi, \"%s\")\n", STRING(MPI_SEND));
  printf("const MPI_SEND_INIT          = dlsym(libmpi, \"%s\")\n", STRING(MPI_SEND_INIT));
  printf("const MPI_SSEND              = dlsym(libmpi, \"%s\")\n", STRING(MPI_SSEND));
  printf("const MPI_TEST               = dlsym(libmpi, \"%s\")\n", STRING(MPI_TEST));
  printf("const MPI_UNPACK             = dlsym(libmpi, \"%s\")\n", STRING(MPI_UNPACK));
  printf("const MPI_WAIT               = dlsym(libmpi, \"%s\")\n", STRING(MPI_WAIT));
  printf("const MPI_WAITALL            = dlsym(libmpi, \"%s\")\n", STRING(MPI_WAITALL));
  printf("const MPI_WAITANY            = dlsym(libmpi, \"%s\")\n", STRING(MPI_WAITANY));
  printf("const MPI_WTIME              = dlsym(libmpi, \"%s\")\n", STRING(MPI_WTIME));

  return 0;
}
