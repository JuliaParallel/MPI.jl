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

# Keep these function names sorted alphabetically
FortranCInterface_HEADER(jlmpi_f2c.h MACRO_NAMESPACE "JLMPI_")

Include_directories(${MPI_C_INCLUDE_PATH})
include_directories(${MPI_Fortran_INCLUDE_PATH})
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${MPI_C_COMPILE_FLAG}")
set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} ${MPI_Fortran_COMPILE_FLAG}")

include_directories(${CMAKE_BINARY_DIR})
set(WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}")
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

add_library(juliampi SHARED test_mpi.f90)

if(MPI_Fortran_LINK_FLAGS)
  set_target_properties(juliampi PROPERTIES LINK_FLAGS ${MPI_Fortran_LINK_FLAGS})
endif(MPI_Fortran_LINK_FLAGS)

target_link_libraries(juliampi ${MPI_C_LIBRARIES} ${MPI_Fortran_LIBRARIES})

include(CheckFunctionExists)
set(CMAKE_REQUIRED_LIBRARIES ${MPI_C_LIBRARIES})
check_function_exists(MPI_Comm_c2f HAVE_MPI_COMM_C2F)
unset(CMAKE_REQUIRED_LIBRARIES)
if(${HAVE_MPI_COMM_C2F})
  set(HAVE_MPI_COMM_C2F_BOOL "true")
else()
  set(HAVE_MPI_COMM_C2F_BOOL "false")
endif()

add_executable(gen_functions src/gen_functions.c)

add_executable(gen_constants src/gen_constants.f90)

file(WRITE ${CMAKE_BINARY_DIR}/mpi.cmake "
execute_process(COMMAND ${CMAKE_BINARY_DIR}/gen_functions OUTPUT_VARIABLE FTWOC)
execute_process(COMMAND ${CMAKE_BINARY_DIR}/gen_constants OUTPUT_VARIABLE FCONS)
file(READ   \${SRC} MPI)
file(WRITE  \${DST} \"const libmpi = \\\"${CMAKE_LIB_INSTALL_PREFIX}/libjuliampi\\\"\n\")
file(APPEND \${DST} \"\n\")
file(APPEND \${DST} \${FTWOC})
file(APPEND \${DST} \"\n\")
file(APPEND \${DST} \${FCONS})
file(APPEND \${DST} \"\n\")
file(APPEND \${DST} \"const HAVE_MPI_COMM_C2F = ${HAVE_MPI_COMM_C2F_BOOL}\n\")
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

install(FILES ${CMAKE_BINARY_DIR}/compile-time.jl DESTINATION .)
install(TARGETS juliampi LIBRARY DESTINATION ${CMAKE_LIB_INSTALL_PREFIX})
set_property(TARGET juliampi PROPERTY INSTALL_RPATH_USE_LINK_PATH TRUE)
