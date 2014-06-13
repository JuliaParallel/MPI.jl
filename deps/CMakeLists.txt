CMAKE_minimum_required(VERSION 2.8.7)
project(Julia-MPI Fortran C)
include(InstallRequiredSystemLibraries)
find_package(Git)
find_package(MPI REQUIRED)

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX "$ENV{HOME}/.julia/v0.3/MPI/src" CACHE PATH
    "Julia-MPI install prefix" FORCE)
ENDIF(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)

set(CMAKE_LIB_INSTALL_PREFIX "$ENV{HOME}/.julia/v0.3/MPI/deps/usr/lib" CACHE PATH
    "Julia-MPI lib install prefix" FORCE)

include(FortranCInterface)

FortranCInterface_HEADER(jlmpi_f2c.h MACRO_NAMESPACE "JLMPI_"
  SYMBOLS MPI_SEND MPI_RECV MPI_GET_COUNT MPI_BSEND MPI_SSEND MPI_RSEND
  MPI_ISEND MPI_IRECV MPI_WAIT MPI_TEST MPI_REQUEST_FREE MPI_WAITANY MPI_IPROBE
  MPI_PROBE MPI_CANCEL MPI_PACK MPI_UNPACK MPI_PACK_SIZE MPI_BARRIER MPI_BCAST
  MPI_GATHER MPI_REDUCE MPI_ALLREDUCE MPI_COMM_SIZE MPI_COMM_RANK MPI_COMM_DUP
  MPI_COMM_SPLIT MPI_COMM_FREE MPI_GET_PROCESSOR_NAME MPI_WTIME MPI_INIT
  MPI_FINALIZE MPI_INITIALIZED MPI_ABORT MPI_ALLTOALL MPI_SEND_INIT
  MPI_RECV_INIT MPI_OP_CREATE MPI_WAITALL MPI_OP_FREE)

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

add_library(juliampi SHARED mpi.f)

if(MPI_Fortran_LINK_FLAGS)
  set_target_properties(juliampi PROPERTIES LINK_FLAGS ${MPI_Fortran_LINK_FLAGS})
endif(MPI_Fortran_LINK_FLAGS)

target_link_libraries(juliampi ${MPI_Fortran_LIBRARIES})

add_executable(make_f2c make_f2c.c)
add_dependencies(make_f2c version)

add_executable(make_f_const make_f_const.f)

file(WRITE ${CMAKE_BINARY_DIR}/mpi.cmake "
execute_process(COMMAND ${CMAKE_BINARY_DIR}/make_f2c     OUTPUT_VARIABLE FTWOC)
execute_process(COMMAND ${CMAKE_BINARY_DIR}/make_f_const OUTPUT_VARIABLE FCONS)
file(READ   \${SRC} MPI)
file(WRITE  \${DST} \"module MPI\n\")
file(APPEND \${DST} \"\n\")
file(APPEND \${DST} \"import Base.*\n\")
file(APPEND \${DST} \"\n\")
file(APPEND \${DST} \"const libmpi = dlopen(\\\"${CMAKE_LIB_INSTALL_PREFIX}/libjuliampi\\\",RTLD_LAZY|RTLD_DEEPBIND|RTLD_GLOBAL)\n\")
file(APPEND \${DST} \"\n\")
file(APPEND \${DST} \${FTWOC})
file(APPEND \${DST} \"\n\")
file(APPEND \${DST} \${FCONS})
file(APPEND \${DST} \"\n\")
file(APPEND \${DST} \${MPI})
file(APPEND \${DST} \"end\n\")
")

add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/MPI.jl
    COMMAND ${CMAKE_COMMAND}
                -DSRC=${CMAKE_SOURCE_DIR}/mpi-base.jl
                -DLIB=${CMAKE_LIB_INSTALL_PREFIX}/libmpi
                -DDST=${CMAKE_BINARY_DIR}/MPI.jl
                -P ${CMAKE_BINARY_DIR}/mpi.cmake
    DEPENDS make_f2c make_f_const ${CMAKE_SOURCE_DIR}/mpi-base.jl ${CMAKE_BINARY_DIR}/mpi.cmake)
add_custom_target(mpijl DEPENDS ${CMAKE_BINARY_DIR}/MPI.jl)
add_dependencies(juliampi mpijl)

add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/mpi-build.jl
    COMMAND ${CMAKE_COMMAND}
                -DSRC=${CMAKE_SOURCE_DIR}/mpi-base.jl
                -DLIB=${CMAKE_LIB_INSTALL_PREFIX}/libmpi
                -DDST=${CMAKE_BINARY_DIR}/mpi-build.jl
                -P ${CMAKE_BINARY_DIR}/mpi.cmake
    DEPENDS make_f2c make_f_const ${CMAKE_SOURCE_DIR}/mpi-base.jl ${CMAKE_BINARY_DIR}/mpi.cmake)
add_custom_target(mpijl-build DEPENDS ${CMAKE_BINARY_DIR}/mpi-build.jl)
add_dependencies(juliampi mpijl-build)

install(FILES ${CMAKE_BINARY_DIR}/MPI.jl DESTINATION .)
install(TARGETS juliampi LIBRARY DESTINATION ${CMAKE_LIB_INSTALL_PREFIX})

enable_testing()

set(NPROCS 2 5)

file(GLOB JTESTS "${CMAKE_SOURCE_DIR}/../test/test_*.jl")

foreach(np ${NPROCS})
  foreach(jtest ${JTESTS})
    get_filename_component(tname ${jtest} NAME)
    add_test(${tname}_np:${np} ${MPIEXEC} ${MPIEXEC_NUMPROC_FLAG} ${np}
      julia "${CMAKE_SOURCE_DIR}/../test/run_test.jl" ${jtest})
  endforeach(jtest ${JTESTS})
endforeach(np ${NPROCS})
