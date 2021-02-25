#include <mpi.h>
#include <stdlib.h>
#include <stdio.h>

srand((unsigned) time(&t));


double pingpong(int bufsize, int iters) {
  double *buffer = (double *)malloc(bufsize * sizeof(double));
  for (int i=0; i<bufsize; i++) {
    buffer[i] = rand();
  }
  
  int tag = 0;
  int rank;
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);  

  MPI_Barrier(MPI_COMM_WORLD);
  double tic = MPI_Wtime();

  for (int i=0; i<iters; i++) {    
    if (rank == 0) {
      MPI_Send(buffer, bufsize, MPI_DOUBLE, 1, tag, MPI_COMM_WORLD);
      MPI_Recv(buffer, bufsize, MPI_DOUBLE, 1, tag, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    } else {
      MPI_Recv(buffer, bufsize, MPI_DOUBLE, 0, tag, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
      MPI_Send(buffer, bufsize, MPI_DOUBLE, 0, tag, MPI_COMM_WORLD);
    }
  }
  double toc = MPI_Wtime();
  return (toc-tic)/iters;
}


int main(int argc, char** argv) {
  // Initialize the MPI environment
  MPI_Init(NULL, NULL);

  int rank, size;
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  MPI_Comm_size(MPI_COMM_WORLD, &size);
  if (size != 2) {
    return 1;
  }
  
  for (int k=0; k<21; k++) {
    int bufsize = 1 << k;
    int iters = 1 << (k < 10 ? 20 : 30-k);
    double avgtime = pingpong(bufsize, iters);
    if (rank == 0) {
      printf("%i, %.15e\n", bufsize, avgtime);
    }
  }

  MPI_Finalize();
  return 0;
}
