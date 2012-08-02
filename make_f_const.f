      PROGRAM MAIN
C     Include the following althoung not standard 77
      IMPLICIT NONE
      INCLUDE 'mpif.h'
C
C
      CHARACTER(LEN=*), PARAMETER  :: FMT1 = "(A, I32, A)"
      CHARACTER(LEN=*), PARAMETER  :: FMT2 = "(A)"
      INTEGER i


      WRITE(*,FMT1) 'const MPI_COMM_SELF  = int32(', MPI_COMM_SELF , ')'
      WRITE(*,FMT1) 'const MPI_COMM_WORLD = int32(', MPI_COMM_WORLD, ')'
      WRITE(*,FMT1) 'const MPI_COMM_NULL  = int32(', MPI_COMM_NULL , ')'

      WRITE(*,FMT1) 'const MPI_SUCCESS    = int32(', MPI_SUCCESS, ')'

      WRITE(*,FMT1) 'const MPI_BYTE      = int32(', MPI_BYTE     , ')'

      WRITE(*,FMT1) 'const MPI_WCHAR     = int32(', MPI_WCHAR    , ')'
      WRITE(*,FMT1) 'const MPI_INT8_T    = int32(', MPI_INT8_T   , ')'
      WRITE(*,FMT1) 'const MPI_UINT8_T   = int32(', MPI_UINT8_T  , ')'
      WRITE(*,FMT1) 'const MPI_INT16_T   = int32(', MPI_INT16_T  , ')'
      WRITE(*,FMT1) 'const MPI_UINT16_T  = int32(', MPI_UINT16_T , ')'
      WRITE(*,FMT1) 'const MPI_INT32_T   = int32(', MPI_INT32_T  , ')'
      WRITE(*,FMT1) 'const MPI_UINT32_T  = int32(', MPI_UINT32_T , ')'
      WRITE(*,FMT1) 'const MPI_INT64_T   = int32(', MPI_INT64_T  , ')'
      WRITE(*,FMT1) 'const MPI_UINT64_T  = int32(', MPI_UINT64_T , ')'
C     The following doesn't not seem to work with my openmpi build.
C      WRITE(*,FMT1) 'const MPI_INTEGER16 = int32(', MPI_INTEGER16, ')'

      WRITE(*,FMT1) 'const MPI_REAL4     = int32(', MPI_REAL4    , ')'
      WRITE(*,FMT1) 'const MPI_REAL8     = int32(', MPI_REAL8    , ')'
C     Unfortunately MPI_COMPLEX[16,32] was not working for me in
C     openmpi.
      WRITE(*,FMT1) 'const MPI_COMPLEX  = int32(', MPI_COMPLEX , ')'
      WRITE(*,FMT1) 'const MPI_DOUBLE_COMPLEX = int32(',
     +              MPI_DOUBLE_COMPLEX, ')'
C     Unfortunately mpich2 doesn't support 8-bits ints
C      WRITE(*,FMT1) 'const MPI_LOGICAL1  = int32(', MPI_LOGICAL1 , ')'

      WRITE(*,FMT1) 'const MPI_OP_NULL  = int32(', MPI_OP_NULL , ')'
      WRITE(*,FMT1) 'const MPI_MAX     = int32(', MPI_MAX    , ')'
      WRITE(*,FMT1) 'const MPI_MIN     = int32(', MPI_MIN    , ')'
      WRITE(*,FMT1) 'const MPI_SUM     = int32(', MPI_SUM    , ')'
      WRITE(*,FMT1) 'const MPI_PROD    = int32(', MPI_PROD   , ')'
      WRITE(*,FMT1) 'const MPI_LAND    = int32(', MPI_LAND   , ')'
      WRITE(*,FMT1) 'const MPI_BAND    = int32(', MPI_BAND   , ')'
      WRITE(*,FMT1) 'const MPI_LOR     = int32(', MPI_LOR    , ')'
      WRITE(*,FMT1) 'const MPI_BOR     = int32(', MPI_BOR    , ')'
      WRITE(*,FMT1) 'const MPI_LXOR    = int32(', MPI_LXOR   , ')'
      WRITE(*,FMT1) 'const MPI_BXOR    = int32(', MPI_BXOR   , ')'
      WRITE(*,FMT1) 'const MPI_MAXLOC  = int32(', MPI_MAXLOC , ')'
      WRITE(*,FMT1) 'const MPI_MINLOC  = int32(', MPI_MINLOC , ')'
      WRITE(*,FMT1) 'const MPI_REPLACE = int32(', MPI_REPLACE, ')'
C
      WRITE(*,FMT1) 'const MPI_ANY_SOURCE = int32(', MPI_ANY_SOURCE, ')'
      WRITE(*,FMT1) 'const MPI_ANY_TAG    = int32(', MPI_ANY_TAG, ')'
      WRITE(*,FMT1) 'const MPI_TAG_UB     = int32(', MPI_TAG_UB, ')'
C
      WRITE(*,FMT1) 'const MPI_STATUS_SIZE   = int32(', MPI_STATUS_SIZE,
     +              ')'
C
      WRITE(*,FMT1) 'const MPI_SOURCE = int32(', MPI_SOURCE, ')'
      WRITE(*,FMT1) 'const MPI_TAG    = int32(', MPI_TAG, ')'
      WRITE(*,FMT1) 'const MPI_ERROR  = int32(', MPI_ERROR, ')'

      WRITE(*,FMT1) 'const MPI_REQUEST_NULL  = int32(', MPI_REQUEST_NULL
     +              , ')'

      STOP
      END
