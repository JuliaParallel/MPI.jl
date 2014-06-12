      subroutine juliampi_empty()
        INTEGER   IERROR
        CALL MPI_INIT(IERROR)
        CALL MPI_FINALIZE(IERROR)
      end
