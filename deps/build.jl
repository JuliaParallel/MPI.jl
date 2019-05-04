using BinDeps

@BinDeps.setup

mpi = library_dependency("juliampi", aliases=["libjuliampi", "libjuliampi.so", "libjuliampi.dylib"], os = :Unix)
builddir = joinpath(BinDeps.depsdir(mpi), "build")
prefix = joinpath(BinDeps.depsdir(mpi), "usr")
src = joinpath(BinDeps.depsdir(mpi), "src")

if isdir(builddir)
    rm(builddir, recursive = true)
end
if isdir(prefix)
    rm(prefix, recursive = true)
end
if !isdir(src)
    mkdir(src)
end


# Currently these are all MPI 2.1, but we should version them
MPI_constants = [
    # types
    "MPI_BYTE",
    "MPI_INTEGER1",
    "MPI_INTEGER2",
    "MPI_INTEGER4",
    "MPI_INTEGER8",
    "MPI_REAL4",
    "MPI_REAL8",
    "MPI_COMPLEX8",
    "MPI_COMPLEX16",

    # comms
    "MPI_COMM_NULL",
    "MPI_COMM_SELF",
    "MPI_COMM_WORLD",

    # comm type
    "MPI_COMM_TYPE_SHARED",

    # reductions operations
    "MPI_OP_NULL",
    "MPI_BAND",
    "MPI_BOR", 
    "MPI_BXOR",
    "MPI_LAND",
    "MPI_LOR",
    "MPI_LXOR",
    "MPI_MAX",
    "MPI_MAXLOC",
    "MPI_MIN",
    "MPI_NO_OP",
    "MPI_MINLOC",
    "MPI_PROD",
    "MPI_REPLACE",
    "MPI_SUM",

    # request
    "MPI_REQUEST_NULL",

    # info
    "MPI_INFO_NULL",

    # proc
    "MPI_PROC_NULL",

    # memory layout
    "MPI_ORDER_C",
    "MPI_ORDER_FORTRAN",

    # status
    "MPI_STATUS_SIZE", # size of Status array
    "MPI_SOURCE", # index in Status array
    "MPI_TAG",    # index in Status array
    "MPI_ERROR",  # index in Status array

    # lock_type
    "MPI_LOCK_EXCLUSIVE",
    "MPI_LOCK_SHARED",

    # misc constants
    "MPI_ANY_SOURCE",
    "MPI_ANY_TAG",
    "MPI_TAG_UB", # upper bound for tag value
    "MPI_UNDEFINED",
]

MPI_functions = [
    "MPI_ABORT",
    "MPI_ACCUMULATE",
    "MPI_ALLGATHER",
    "MPI_ALLGATHERV",
    "MPI_ALLREDUCE",
    "MPI_ALLTOALL",
    "MPI_ALLTOALLV",
    "MPI_BARRIER",
    "MPI_BCAST",
    "MPI_BSEND",
    "MPI_CANCEL",
    "MPI_CART_CREATE",
    "MPI_CART_COORDS",
    "MPI_CART_SHIFT",
    "MPI_COMM_DUP",
    "MPI_COMM_FREE",
    "MPI_COMM_GET_PARENT",
    "MPI_COMM_RANK",
    "MPI_COMM_SIZE",
    "MPI_COMM_SPLIT",
    "MPI_COMM_SPLIT_TYPE",
    "MPI_DIMS_CREATE",
    "MPI_EXSCAN",
    "MPI_FETCH_AND_OP",
    "MPI_FINALIZE",
    "MPI_FINALIZED",
    "MPI_GATHER",
    "MPI_GATHERV",
    "MPI_GET",
    "MPI_GET_ACCUMULATE",
    "MPI_GET_ADDRESS",
    "MPI_GET_COUNT",
    "MPI_GET_PROCESSOR_NAME",
    "MPI_INFO_CREATE",
    "MPI_INFO_DELETE",
    "MPI_INFO_FREE",
    "MPI_INFO_GET",
    "MPI_INFO_GET_VALUELEN",
    "MPI_INFO_SET",
    "MPI_INIT",
    "MPI_INITIALIZED",
    "MPI_INTERCOMM_MERGE",
    "MPI_IPROBE",
    "MPI_IRECV",
    "MPI_ISEND",
    "MPI_OP_CREATE",
    "MPI_OP_FREE",
    "MPI_PACK",
    "MPI_PACK_SIZE",
    "MPI_PROBE",
    "MPI_PUT",
    "MPI_RECV",
    "MPI_RECV_INIT",
    "MPI_REDUCE",
    "MPI_REQUEST_FREE",
    "MPI_RSEND",
    "MPI_SCAN",
    "MPI_SCATTER",
    "MPI_SCATTERV",
    "MPI_SEND",
    "MPI_SEND_INIT",
    "MPI_SSEND",
    "MPI_TEST",
    "MPI_TESTALL",
    "MPI_TESTANY",
    "MPI_TESTSOME",
    "MPI_TYPE_CONTIGUOUS",
    "MPI_TYPE_CREATE_STRUCT",
    "MPI_TYPE_CREATE_SUBARRAY",
    "MPI_TYPE_COMMIT",
    "MPI_UNPACK",
    "MPI_WAIT",
    "MPI_WAITALL",
    "MPI_WAITANY",
    "MPI_WAITSOME",
    "MPI_WIN_ATTACH",
    "MPI_WIN_ALLOCATE_SHARED",
    "MPI_WIN_CREATE",
    "MPI_WIN_CREATE_DYNAMIC",
    "MPI_WIN_DETACH",
    "MPI_WIN_FENCE",
    "MPI_WIN_FLUSH",
    "MPI_WIN_FREE",
    "MPI_WIN_LOCK",
    "MPI_WIN_SHARED_QUERY",
    "MPI_WIN_SYNC",
    "MPI_WIN_UNLOCK",
    "MPI_WTICK",
    "MPI_WTIME",
    ]

MPI_C_constants = [
    "MPI_IN_PLACE",
]
MPI_C_types = ["Comm", "Info", "Win"]



open(joinpath(src,"gen_constants.f90"),"w") do f
    print(f,"""
program gen_constants
  implicit none
  include 'mpif.h'
""")
    for name in MPI_constants
        println(f,"  print '(\"const $name = Cint(\",i0,\")\")', $name")
    end
    print(f,"""
end program gen_constants
""")
end

open(joinpath(src,"gen_functions.c"),"w") do f
    print(f,"""
#include <stdio.h>
#include <stddef.h>
#include "jlmpi_f2c.h"
#include "mpi.h"

// check that the size of MPI_Aint is consistent
typedef int check_sizeof_MPI_Aint[sizeof(MPI_Aint) == sizeof(ptrdiff_t) ? 1 : -1];

#define STRING1(s) #s
#define STRING(s) STRING1(s)

int main(int argc, char *argv[]) {
""")
    for name in MPI_functions
        println(f,"  printf(\"const $name = (\\\"%s\\\",libmpi)\\n\", STRING(JLMPI_GLOBAL_($(lowercase(name)),$name)));")
    end

    for name in MPI_C_constants
        println(f,"  printf(\"const $name = %d\\n\", ((int)$name));")
    end

    for name in MPI_C_types
        println(f,"  printf(\"primitive type C$name %d end\\n\", (int)(sizeof(MPI_$name) * 8));")
    end
    print(f,"""
  return 0;
}
""")
end


# Add cmake flags to specify the MPI library location
configure = `cmake`
flags = ["MPI_C_COMPILER",
         "MPI_C_COMPILE_FLAGS",
         "MPI_C_INCLUDE_PATH",
         "MPI_C_LINK_FLAGS",
         "MPI_C_LIBRARIES",
         "MPI_Fortran_COMPILER",
         "MPI_Fortran_COMPILE_FLAGS",
         "MPI_Fortran_INCLUDE_PATH",
         "MPI_Fortran_LINK_FLAGS",
         "MPI_Fortran_LIBRARIES",
         "MPI_INCLUDE_PATH",
         "MPI_LIBRARIES"]
for flag in flags
    try
        val = ENV["JULIA_$flag"]
        global configure = `$configure -D$flag=$val`
    catch
        nothing
    end
end
configure = `$configure -DCMAKE_INSTALL_PREFIX=$src -DCMAKE_LIB_INSTALL_PREFIX=$prefix/lib ..`

provides(SimpleBuild,
    (@build_steps begin
        CreateDirectory(builddir)
        (@build_steps begin
            ChangeDirectory(builddir)
            (@build_steps begin
                configure
                `make`
                `make install`
            end)
        end)
    end), [mpi], os = :Unix)

@BinDeps.install Dict(:mpi => :mpi)
