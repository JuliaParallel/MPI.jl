program gen_constants
  implicit none
  include 'mpif.h'

  call output("MPI_BYTE        ", MPI_BYTE)
  ! Older versions of OpenMPI (such as those used by default by
  ! Travis) do not define MPI_WCHAR and the MPI_*INT*_T types for
  ! Fortran. We thus don't require them (yet).
  ! call output("MPI_WCHAR       ", MPI_WCHAR)
  ! call output("MPI_INT8_T      ", MPI_INT8_T)
  ! call output("MPI_UINT8_T     ", MPI_UINT8_T)
  ! call output("MPI_INT16_T     ", MPI_INT16_T)
  ! call output("MPI_UINT16_T    ", MPI_UINT16_T)
  ! call output("MPI_INT32_T     ", MPI_INT32_T)
  ! call output("MPI_UINT32_T    ", MPI_UINT32_T)
  ! call output("MPI_INT64_T     ", MPI_INT64_T)
  ! call output("MPI_UINT64_T    ", MPI_UINT64_T)
  call output("MPI_INTEGER1    ", MPI_INTEGER1)
  call output("MPI_INTEGER2    ", MPI_INTEGER2)
  call output("MPI_INTEGER4    ", MPI_INTEGER4)
  call output("MPI_INTEGER8    ", MPI_INTEGER8)
  call output("MPI_REAL4       ", MPI_REAL4)
  call output("MPI_REAL8       ", MPI_REAL8)
  call output("MPI_COMPLEX8    ", MPI_COMPLEX8)
  call output("MPI_COMPLEX16   ", MPI_COMPLEX16)

  call output("MPI_COMM_NULL   ", MPI_COMM_NULL)
  call output("MPI_COMM_SELF   ", MPI_COMM_SELF)
  call output("MPI_COMM_WORLD  ", MPI_COMM_WORLD)

  call output("MPI_COMM_TYPE_SHARED", MPI_COMM_TYPE_SHARED)

  call output("MPI_OP_NULL     ", MPI_OP_NULL)
  call output("MPI_BAND        ", MPI_BAND)
  call output("MPI_BOR         ", MPI_BOR)
  call output("MPI_BXOR        ", MPI_BXOR)
  call output("MPI_LAND        ", MPI_LAND)
  call output("MPI_LOR         ", MPI_LOR)
  call output("MPI_LXOR        ", MPI_LXOR)
  call output("MPI_MAX         ", MPI_MAX)
  call output("MPI_MAXLOC      ", MPI_MAXLOC)
  call output("MPI_MIN         ", MPI_MIN)
  call output("MPI_NO_OP       ", MPI_NO_OP)
  call output("MPI_MINLOC      ", MPI_MINLOC)
  call output("MPI_PROD        ", MPI_PROD)
  call output("MPI_REPLACE     ", MPI_REPLACE)
  call output("MPI_SUM         ", MPI_SUM)

  call output("MPI_REQUEST_NULL", MPI_REQUEST_NULL)

  call output("MPI_INFO_NULL   ", MPI_INFO_NULL)

  call output("MPI_STATUS_SIZE ", MPI_STATUS_SIZE)
  call output("MPI_ERROR       ", MPI_ERROR)
  call output("MPI_SOURCE      ", MPI_SOURCE)
  call output("MPI_TAG         ", MPI_TAG)

  call output("MPI_ANY_SOURCE  ", MPI_ANY_SOURCE)
  call output("MPI_ANY_TAG     ", MPI_ANY_TAG)
  call output("MPI_TAG_UB      ", MPI_TAG_UB)
  call output("MPI_UNDEFINED   ", MPI_UNDEFINED)

  call output("MPI_INFO_NULL   ", MPI_INFO_NULL)
  call output("MPI_LOCK_EXCLUSIVE", MPI_LOCK_EXCLUSIVE)
  call output("MPI_LOCK_SHARED ", MPI_LOCK_SHARED)
contains

  subroutine output(name, value)
    character*(*) name
    integer value
    print '("const ",a," = Cint(",i0,")")', name, value
  end subroutine output

end program gen_constants
