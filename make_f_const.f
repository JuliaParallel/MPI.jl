      PROGRAM MAIN
      INCLUDE 'mpif.h'
C
      CHARACTER(LEN=*), PARAMETER  :: FMT1 = "(A, I32, A)"
      WRITE(*,FMT1) 'const MPI_COMM_WORLD = int32(', MPI_COMM_WORLD, ')'
      WRITE(*,FMT1) 'const MPI_SUCCESS    = int32(', MPI_SUCCESS, ')'
C
      STOP
      END
