      subroutine juliampi_empty
      implicit none
      integer ierr
      call mpi_init(ierr)
      call mpi_finalize(ierr)
      end
