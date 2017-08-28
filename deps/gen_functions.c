#include <stdio.h>
#include <stddef.h>
#include "jlmpi_f2c.h"
#include "mpi.h"
#include "version.h"

// check that the size of MPI_Aint is consistent
typedef int check_sizeof_MPI_Aint[sizeof(MPI_Aint) == sizeof(ptrdiff_t) ? 1 : -1];

#define STRING1(s) #s
#define STRING(s) STRING1(s)

int main(int argc, char *argv[]) {
  printf("using Compat\n");
  printf("import Compat.String\n");
  printf("\n");
  printf("const WRAPPER_VERSION = \"%s\"\n", VERSION);
  printf("\n");
  printf("const _mpi_functions = Dict{Symbol, String}(\n");
  printf("    :MPI_ABORT              => \"%s\",\n", STRING(MPI_ABORT));
  printf("    :MPI_ALLGATHER          => \"%s\",\n", STRING(MPI_ALLGATHER));
  printf("    :MPI_ALLGATHERV         => \"%s\",\n", STRING(MPI_ALLGATHERV));
  printf("    :MPI_ALLREDUCE          => \"%s\",\n", STRING(MPI_ALLREDUCE));
  printf("    :MPI_ALLTOALL           => \"%s\",\n", STRING(MPI_ALLTOALL));
  printf("    :MPI_ALLTOALLV          => \"%s\",\n", STRING(MPI_ALLTOALLV));
  printf("    :MPI_BARRIER            => \"%s\",\n", STRING(MPI_BARRIER));
  printf("    :MPI_BCAST              => \"%s\",\n", STRING(MPI_BCAST));
  printf("    :MPI_BSEND              => \"%s\",\n", STRING(MPI_BSEND));
  printf("    :MPI_CANCEL             => \"%s\",\n", STRING(MPI_CANCEL));
  printf("    :MPI_COMM_DUP           => \"%s\",\n", STRING(MPI_COMM_DUP));
  printf("    :MPI_COMM_FREE          => \"%s\",\n", STRING(MPI_COMM_FREE));
  printf("    :MPI_COMM_RANK          => \"%s\",\n", STRING(MPI_COMM_RANK));
  printf("    :MPI_COMM_SIZE          => \"%s\",\n", STRING(MPI_COMM_SIZE));
  printf("    :MPI_COMM_SPLIT         => \"%s\",\n", STRING(MPI_COMM_SPLIT));
  printf("    :MPI_EXSCAN             => \"%s\",\n", STRING(MPI_EXSCAN));
  printf("    :MPI_FINALIZE           => \"%s\",\n", STRING(MPI_FINALIZE));
  printf("    :MPI_FINALIZED          => \"%s\",\n", STRING(MPI_FINALIZED));
  printf("    :MPI_GATHER             => \"%s\",\n", STRING(MPI_GATHER));
  printf("    :MPI_GATHERV            => \"%s\",\n", STRING(MPI_GATHERV));
  printf("    :MPI_GET_COUNT          => \"%s\",\n", STRING(MPI_GET_COUNT));
  printf("    :MPI_GET_PROCESSOR_NAME => \"%s\",\n",
         STRING(MPI_GET_PROCESSOR_NAME));
  printf("    :MPI_INIT               => \"%s\",\n", STRING(MPI_INIT));
  printf("    :MPI_INITIALIZED        => \"%s\",\n", STRING(MPI_INITIALIZED));
  printf("    :MPI_IPROBE             => \"%s\",\n", STRING(MPI_IPROBE));
  printf("    :MPI_IRECV              => \"%s\",\n", STRING(MPI_IRECV));
  printf("    :MPI_ISEND              => \"%s\",\n", STRING(MPI_ISEND));
  printf("    :MPI_OP_CREATE          => \"%s\",\n", STRING(MPI_OP_CREATE));
  printf("    :MPI_OP_FREE            => \"%s\",\n", STRING(MPI_OP_FREE));
  printf("    :MPI_PACK               => \"%s\",\n", STRING(MPI_PACK));
  printf("    :MPI_PACK_SIZE          => \"%s\",\n", STRING(MPI_PACK_SIZE));
  printf("    :MPI_PROBE              => \"%s\",\n", STRING(MPI_PROBE));
  printf("    :MPI_RECV               => \"%s\",\n", STRING(MPI_RECV));
  printf("    :MPI_RECV_INIT          => \"%s\",\n", STRING(MPI_RECV_INIT));
  printf("    :MPI_REDUCE             => \"%s\",\n", STRING(MPI_REDUCE));
  printf("    :MPI_REQUEST_FREE       => \"%s\",\n", STRING(MPI_REQUEST_FREE));
  printf("    :MPI_RSEND              => \"%s\",\n", STRING(MPI_RSEND));
  printf("    :MPI_SCAN               => \"%s\",\n", STRING(MPI_SCAN));
  printf("    :MPI_SCATTER            => \"%s\",\n", STRING(MPI_SCATTER));
  printf("    :MPI_SCATTERV           => \"%s\",\n", STRING(MPI_SCATTERV));
  printf("    :MPI_SEND               => \"%s\",\n", STRING(MPI_SEND));
  printf("    :MPI_SEND_INIT          => \"%s\",\n", STRING(MPI_SEND_INIT));
  printf("    :MPI_SSEND              => \"%s\",\n", STRING(MPI_SSEND));
  printf("    :MPI_TEST               => \"%s\",\n", STRING(MPI_TEST));
  printf("    :MPI_TESTALL            => \"%s\",\n", STRING(MPI_TESTALL));
  printf("    :MPI_TESTANY            => \"%s\",\n", STRING(MPI_TESTANY));
  printf("    :MPI_TESTSOME           => \"%s\",\n", STRING(MPI_TESTSOME));
  printf("    :MPI_UNPACK             => \"%s\",\n", STRING(MPI_UNPACK));
  printf("    :MPI_WAIT               => \"%s\",\n", STRING(MPI_WAIT));
  printf("    :MPI_WAITALL            => \"%s\",\n", STRING(MPI_WAITALL));
  printf("    :MPI_WAITANY            => \"%s\",\n", STRING(MPI_WAITANY));
  printf("    :MPI_WAITSOME           => \"%s\",\n", STRING(MPI_WAITSOME));
  printf("    :MPI_WTIME              => \"%s\",\n", STRING(MPI_WTIME));
  printf("    :MPI_WTICK              => \"%s\",\n", STRING(MPI_WTICK));
  printf("    :MPI_TYPE_CREATE_STRUCT => \"%s\",\n", 
         STRING(MPI_TYPE_CREATE_STRUCT));
  printf("    :MPI_TYPE_COMMIT        => \"%s\",\n", 
         STRING(MPI_TYPE_COMMIT));
  printf(")\n");
  printf("\n");
  printf("bitstype %d CComm\n", (int)(sizeof(MPI_Comm) * 8));

  return 0;
}
