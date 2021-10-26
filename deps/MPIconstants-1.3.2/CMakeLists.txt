cmake_minimum_required(VERSION 3.12...3.20)
project(
  MPIwrapper
  VERSION 1.3.2
  DESCRIPTION "MPI constants"
  LANGUAGES C
  )

set(CMAKE_C_STANDARD 11)

find_package(MPI REQUIRED)

add_library(load_time_mpi_constants SHARED
  load_time_mpi_constants.c
  )
target_link_libraries(load_time_mpi_constants PRIVATE MPI::MPI_C)
install(
  TARGETS load_time_mpi_constants
  LIBRARY
  DESTINATION lib
  )

add_executable(generate_compile_time_mpi_constants
  generate_compile_time_mpi_constants.c
  )
target_link_libraries(generate_compile_time_mpi_constants PRIVATE MPI::MPI_C)
install(
  TARGETS generate_compile_time_mpi_constants
  RUNTIME
  DESTINATION bin
  )
