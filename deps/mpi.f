      subroutine juliampi_empty
      integer ierr
      call mpi_init(ierr)
      call mpi_finalize(ierr)
      end
