#include <stdio.h>
#include "jlmpi_f2c.h"
#include "mpi.h"
#include "version.h"

#define STRING1(s) #s
#define STRING(s) STRING1(s)

int main(int argc, char *argv[])
{
  printf("const WRAPPER_VERSION        = \"%s\"\n", VERSION);
  printf("const MPI_ABORT              = :%s\n", STRING(MPI_ABORT));
  printf("const MPI_ALLGATHER          = :%s\n", STRING(MPI_ALLGATHER));
  printf("const MPI_ALLGATHERV         = :%s\n", STRING(MPI_ALLGATHERV));
  printf("const MPI_ALLREDUCE          = :%s\n", STRING(MPI_ALLREDUCE));
  printf("const MPI_ALLTOALL           = :%s\n", STRING(MPI_ALLTOALL));
  printf("const MPI_ALLTOALLV          = :%s\n", STRING(MPI_ALLTOALLV));
  printf("const MPI_BARRIER            = :%s\n", STRING(MPI_BARRIER));
  printf("const MPI_BCAST              = :%s\n", STRING(MPI_BCAST));
  printf("const MPI_BSEND              = :%s\n", STRING(MPI_BSEND));
  printf("const MPI_CANCEL             = :%s\n", STRING(MPI_CANCEL));
  printf("const MPI_COMM_DUP           = :%s\n", STRING(MPI_COMM_DUP));
  printf("const MPI_COMM_FREE          = :%s\n", STRING(MPI_COMM_FREE));
  printf("const MPI_COMM_RANK          = :%s\n", STRING(MPI_COMM_RANK));
  printf("const MPI_COMM_SIZE          = :%s\n", STRING(MPI_COMM_SIZE));
  printf("const MPI_COMM_SPLIT         = :%s\n", STRING(MPI_COMM_SPLIT));
  printf("const MPI_EXSCAN             = :%s\n", STRING(MPI_EXSCAN));
  printf("const MPI_FINALIZE           = :%s\n", STRING(MPI_FINALIZE));
  printf("const MPI_FINALIZED          = :%s\n", STRING(MPI_FINALIZED));
  printf("const MPI_GATHER             = :%s\n", STRING(MPI_GATHER));
  printf("const MPI_GATHERV            = :%s\n", STRING(MPI_GATHERV));
  printf("const MPI_GET_COUNT          = :%s\n", STRING(MPI_GET_COUNT));
  printf("const MPI_GET_PROCESSOR_NAME = :%s\n", STRING(MPI_GET_PROCESSOR_NAME));
  printf("const MPI_INIT               = :%s\n", STRING(MPI_INIT));
  printf("const MPI_INITIALIZED        = :%s\n", STRING(MPI_INITIALIZED));
  printf("const MPI_IPROBE             = :%s\n", STRING(MPI_IPROBE));
  printf("const MPI_IRECV              = :%s\n", STRING(MPI_IRECV));
  printf("const MPI_ISEND              = :%s\n", STRING(MPI_ISEND));
  printf("const MPI_OP_CREATE          = :%s\n", STRING(MPI_OP_CREATE));
  printf("const MPI_OP_FREE            = :%s\n", STRING(MPI_OP_FREE));
  printf("const MPI_PACK               = :%s\n", STRING(MPI_PACK));
  printf("const MPI_PACK_SIZE          = :%s\n", STRING(MPI_PACK_SIZE));
  printf("const MPI_PROBE              = :%s\n", STRING(MPI_PROBE));
  printf("const MPI_RECV               = :%s\n", STRING(MPI_RECV));
  printf("const MPI_RECV_INIT          = :%s\n", STRING(MPI_RECV_INIT));
  printf("const MPI_REDUCE             = :%s\n", STRING(MPI_REDUCE));
  printf("const MPI_REQUEST_FREE       = :%s\n", STRING(MPI_REQUEST_FREE));
  printf("const MPI_RSEND              = :%s\n", STRING(MPI_RSEND));
  printf("const MPI_SCAN               = :%s\n", STRING(MPI_SCAN));
  printf("const MPI_SCATTER            = :%s\n", STRING(MPI_SCATTER));
  printf("const MPI_SCATTERV           = :%s\n", STRING(MPI_SCATTERV));
  printf("const MPI_SEND               = :%s\n", STRING(MPI_SEND));
  printf("const MPI_SEND_INIT          = :%s\n", STRING(MPI_SEND_INIT));
  printf("const MPI_SSEND              = :%s\n", STRING(MPI_SSEND));
  printf("const MPI_TEST               = :%s\n", STRING(MPI_TEST));
  printf("const MPI_TESTALL            = :%s\n", STRING(MPI_TESTALL));
  printf("const MPI_TESTANY            = :%s\n", STRING(MPI_TESTANY));
  printf("const MPI_UNPACK             = :%s\n", STRING(MPI_UNPACK));
  printf("const MPI_WAIT               = :%s\n", STRING(MPI_WAIT));
  printf("const MPI_WAITALL            = :%s\n", STRING(MPI_WAITALL));
  printf("const MPI_WAITANY            = :%s\n", STRING(MPI_WAITANY));
  printf("const MPI_WTIME              = :%s\n", STRING(MPI_WTIME));

  printf("bitstype %lu CComm\n", sizeof(MPI_Comm) * 8);
  return 0;
}
