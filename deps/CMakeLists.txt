CMAKE_minimum_required(VERSION 2.8.7)
project(Julia-MPI Fortran C)
include(InstallRequiredSystemLibraries)
find_package(Git)
find_package(MPI REQUIRED)

cmake_policy(VERSION 2.8.7)
if(POLICY CMP0042)
  # MACOSX_RPATH
  cmake_policy(SET CMP0042 OLD)
endif()
if(POLICY CMP0052)
  # variable reference and escape sequence evaluation
  cmake_policy(SET CMP0053 OLD)
endif()

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX "$ENV{HOME}/.julia/v0.4/MPI/deps/src" CACHE PATH
    "Julia-MPI install prefix" FORCE)
  set(CMAKE_LIB_INSTALL_PREFIX "$ENV{HOME}/.julia/v0.4/MPI/deps/usr/lib" CACHE PATH
    "Julia-MPI lib install prefix" FORCE)
ENDIF(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)


include(FortranCInterface)

FortranCInterface_HEADER(jlmpi_f2c.h MACRO_NAMESPACE "JLMPI_"
  SYMBOLS MPI_SEND MPI_RECV MPI_GET_COUNT MPI_BSEND MPI_SSEND MPI_RSEND
  MPI_ISEND MPI_IRECV MPI_WAIT MPI_TEST MPI_REQUEST_FREE MPI_WAITANY MPI_IPROBE
  MPI_PROBE MPI_CANCEL MPI_PACK MPI_UNPACK MPI_PACK_SIZE MPI_BARRIER MPI_BCAST
  MPI_GATHER MPI_REDUCE MPI_ALLREDUCE MPI_COMM_SIZE MPI_COMM_RANK MPI_COMM_DUP
  MPI_COMM_SPLIT MPI_COMM_FREE MPI_GET_PROCESSOR_NAME MPI_WTIME MPI_INIT
  MPI_FINALIZE MPI_INITIALIZED MPI_FINALIZED MPI_ABORT MPI_ALLTOALL MPI_SEND_INIT
  MPI_RECV_INIT MPI_OP_CREATE MPI_WAITALL MPI_OP_FREE MPI_SCAN MPI_SCATTER
  MPI_GATHER MPI_EXSCAN MPI_SCATTERV MPI_GATHERV MPI_ALLGATHER MPI_ALLGATHERV
  MPI_ALLTOALLV)

Include_directories(${MPI_C_INCLUDE_PATH})
include_directories(${MPI_Fortran_INCLUDE_PATH})
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${MPI_C_COMPILE_FLAG}")
set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} ${MPI_Fortran_COMPILE_FLAG}")

file(WRITE ${CMAKE_BINARY_DIR}/version.h.in
"\#define VERSION \"@VERSION@\"\n"
"\#define INSTALL \"@CMAKE_INSTALL_PREFIX@\"\n"
)

if(GIT_FOUND)
  set(USE_GIT 1)
else(GIT_FOUND)
  set(USE_GIT 0)
endif(GIT_FOUND)
file(WRITE ${CMAKE_BINARY_DIR}/Version.cmake
"if(${USE_GIT} EQUAL 1)
  execute_process(
       COMMAND ${GIT_EXECUTABLE} describe --tags --dirty
       WORKING_DIRECTORY \${WORKING_DIRECTORY}
       OUTPUT_VARIABLE GIT_DESCRIBE_VERSION
       RESULT_VARIABLE GIT_DESCRIBE_RESULT
       ERROR_VARIABLE GIT_DESCRIBE_ERROR
       OUTPUT_STRIP_TRAILING_WHITESPACE
   )
else(${USE_GIT} EQUAL 1)
  set(GIT_DESCRIBE_RESULT -1)
endif(${USE_GIT} EQUAL 1)

if(GIT_DESCRIBE_RESULT EQUAL 0)
  file(WRITE ${CMAKE_SOURCE_DIR}/VERSION \"\${GIT_DESCRIBE_VERSION}\")
else(GIT_DESCRIBE_RESULT EQUAL 0)
  FILE(READ  ${CMAKE_SOURCE_DIR}/VERSION GIT_DESCRIBE_VERSION)
endif(GIT_DESCRIBE_RESULT EQUAL 0)

string(REGEX REPLACE \"v([0-9]*)\\\\.([0-9]*)\\\\.(.*)\"
       \"\\\\1.\\\\2.\\\\3\" VERSION \"\${GIT_DESCRIBE_VERSION}\" )

string(REGEX REPLACE \"v([0-9]*)\\\\.([0-9]*)\\\\.(.*)\"
       \"\\\\1\" VERSION_MAJOR \"\${GIT_DESCRIBE_VERSION}\")
string(REGEX REPLACE \"v([0-9]*)\\\\.([0-9]*)\\\\.(.*)\"
       \"\\\\2\" VERSION_MINOR \"\${GIT_DESCRIBE_VERSION}\")
string(REGEX REPLACE \"v([0-9]*)\\\\.([0-9]*)\\\\.(.*)\"
       \"\\\\3\" VERSION_PATCH \"\${GIT_DESCRIBE_VERSION}\")
")

file(WRITE ${CMAKE_BINARY_DIR}/FillVersion.cmake
"include(Version.cmake)
configure_file(\${SRC} \${DST} @ONLY)
")
include_directories(${CMAKE_BINARY_DIR})
add_custom_target(
    version
    ${CMAKE_COMMAND} -D SRC=${CMAKE_BINARY_DIR}/version.h.in
                     -D DST=${CMAKE_BINARY_DIR}/version.h
                     -D WORKING_DIRECTORY=${CMAKE_SOURCE_DIR}
                     -P ${CMAKE_BINARY_DIR}/FillVersion.cmake
)
set(WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}")
include(${CMAKE_BINARY_DIR}/Version.cmake)
set(CPACK_PACKAGE_VERSION "${VERSION}")
set(CPACK_PACKAGE_VERSION_MAJOR "${VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${VERSION_MINOR}")
set(CPACK_PACKAGE_VERSION_PATCH "${VERSION_PATCH}")
set(CPACK_SOURCE_IGNORE_FILES
"~$"
".sw[a-z]$"
".DS_Store"
"^${PROJECT_SOURCE_DIR}/.git.*"
"^${PROJECT_SOURCE_DIR}/build.*"
)
include(CPack)

if(UNIX)
  file(WRITE ${CMAKE_BINARY_DIR}/Dist.cmake
"MESSAGE(STATUS \"Package Dist running...\")
INCLUDE(CPackSourceConfig.cmake)
EXECUTE_PROCESS(COMMAND cpack -G TGZ --config CPackSourceConfig.cmake
  TIMEOUT 3600
  WORKING_DIRECTORY \${CMAKE_BINARY_DIR})
")
  #
  # Add custom target
  #
  add_custom_target(dist
    COMMAND ${CMAKE_COMMAND} .
    COMMAND ${CMAKE_COMMAND} -P ${CMAKE_BINARY_DIR}/Dist.cmake
    )
endif(UNIX)

add_dependencies(dist version)

add_library(juliampi SHARED test_mpi.f90)

if(MPI_Fortran_LINK_FLAGS)
  set_target_properties(juliampi PROPERTIES LINK_FLAGS ${MPI_Fortran_LINK_FLAGS})
endif(MPI_Fortran_LINK_FLAGS)

target_link_libraries(juliampi ${MPI_Fortran_LIBRARIES})

add_executable(gen_functions gen_functions.c)
add_dependencies(gen_functions version)

add_executable(gen_constants gen_constants.f90)

file(WRITE ${CMAKE_BINARY_DIR}/mpi.cmake "
execute_process(COMMAND ${CMAKE_BINARY_DIR}/gen_functions OUTPUT_VARIABLE FTWOC)
execute_process(COMMAND ${CMAKE_BINARY_DIR}/gen_constants OUTPUT_VARIABLE FCONS)
file(READ   \${SRC} MPI)
file(WRITE  \${DST} \"const libmpi = Libdl.dlopen(\\\"${CMAKE_LIB_INSTALL_PREFIX}/libjuliampi\\\", Libdl.RTLD_LAZY|Libdl.RTLD_DEEPBIND|Libdl.RTLD_GLOBAL)\n\")
file(APPEND \${DST} \"\n\")
file(APPEND \${DST} \${FTWOC})
file(APPEND \${DST} \"\n\")
file(APPEND \${DST} \${FCONS})
file(APPEND \${DST} \"\n\")
")

add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/compile-time.jl
    COMMAND ${CMAKE_COMMAND}
                -DSRC=${CMAKE_SOURCE_DIR}/../src/mpi-base.jl
                -DLIB=${CMAKE_LIB_INSTALL_PREFIX}/libmpi
                -DDST=${CMAKE_BINARY_DIR}/compile-time.jl
                -P ${CMAKE_BINARY_DIR}/mpi.cmake
    DEPENDS gen_functions gen_constants ${CMAKE_SOURCE_DIR}/../src/mpi-base.jl ${CMAKE_BINARY_DIR}/mpi.cmake)
add_custom_target(mpijl DEPENDS ${CMAKE_BINARY_DIR}/compile-time.jl)
add_dependencies(juliampi mpijl)

add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/mpi-build.jl
    COMMAND ${CMAKE_COMMAND}
                -DSRC=${CMAKE_SOURCE_DIR}/../src/mpi-base.jl
                -DLIB=${CMAKE_LIB_INSTALL_PREFIX}/libmpi
                -DDST=${CMAKE_BINARY_DIR}/mpi-build.jl
                -P ${CMAKE_BINARY_DIR}/mpi.cmake
    DEPENDS gen_functions gen_constants ${CMAKE_SOURCE_DIR}/../src/mpi-base.jl ${CMAKE_BINARY_DIR}/mpi.cmake)
add_custom_target(mpijl-build DEPENDS ${CMAKE_BINARY_DIR}/mpi-build.jl)
add_dependencies(juliampi mpijl-build)

install(FILES ${CMAKE_BINARY_DIR}/compile-time.jl DESTINATION .)
install(TARGETS juliampi LIBRARY DESTINATION ${CMAKE_LIB_INSTALL_PREFIX})
set_property(TARGET juliampi PROPERTY INSTALL_RPATH_USE_LINK_PATH TRUE)
