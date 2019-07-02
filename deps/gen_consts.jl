# Generates, compiles and runs a C file (gen_consts.c) which prints the necessary type
# declarations and constants in Julia syntax.

# For the "handle" constants (MPI_Info, MPI_Op, etc.) we print the Fortran values, since
# for some implementations (OpenMPI), the C versions are only available at link-time (so
# may not be actually constant).

# It may be possible to work around this by using `cglobal` instead, but we can't know
# what symbols the constants resolve to without a C compiler.

MPI_op_consts = [
    :MPI_OP_NULL,
    :MPI_BAND,
    :MPI_BOR,
    :MPI_BXOR,
    :MPI_LAND,
    :MPI_LOR,
    :MPI_LXOR,
    :MPI_MAX,
    :MPI_MIN,
    :MPI_SUM,
    :MPI_PROD,
    :MPI_MAXLOC,
    :MPI_MINLOC,
    :MPI_REPLACE,
]

if MPI_VERSION >= v"3.0"
    push!(MPI_op_consts, :MPI_NO_OP)
end


MPI_datatype_consts = [
    :MPI_DATATYPE_NULL,
    :MPI_PACKED,
    :MPI_CHAR,
    :MPI_SIGNED_CHAR,
    :MPI_UNSIGNED_CHAR,
    :MPI_WCHAR,
    :MPI_BYTE,
    :MPI_SHORT,
    :MPI_UNSIGNED_SHORT,
    :MPI_INT,
    :MPI_UNSIGNED,
    :MPI_LONG,
    :MPI_UNSIGNED_LONG,
    :MPI_FLOAT,
    :MPI_DOUBLE,
]

if MPI_VERSION >= v"2.2"
    append!(MPI_datatype_consts, [
        :MPI_INT8_T,
        :MPI_INT16_T,
        :MPI_INT32_T,
        :MPI_INT64_T,
        :MPI_UINT8_T,
        :MPI_UINT16_T,
        :MPI_UINT32_T,
        :MPI_UINT64_T,
        :MPI_C_FLOAT_COMPLEX,
        :MPI_C_DOUBLE_COMPLEX,
    ])
end

MPI_handle = [
    :MPI_Info => [
        :MPI_INFO_NULL,
    ],
    :MPI_Win => [
        :MPI_WIN_NULL,
    ],
    :MPI_Comm => [
        :MPI_COMM_NULL,
        :MPI_COMM_SELF,
        :MPI_COMM_WORLD,
    ],
    :MPI_Request => [
        :MPI_REQUEST_NULL,
    ],
    :MPI_Op => MPI_op_consts,
    :MPI_Datatype => MPI_datatype_consts
]

MPI_Cints = [
    :MPI_PROC_NULL,
    :MPI_ANY_SOURCE,
    :MPI_ANY_TAG,
    :MPI_UNDEFINED,
    :MPI_LOCK_EXCLUSIVE,
    :MPI_LOCK_SHARED,
    :MPI_MAX_INFO_KEY,
    :MPI_MAX_INFO_VAL,
    :MPI_TAG_UB,
    :MPI_COMM_TYPE_SHARED,
    :MPI_ORDER_C,
    :MPI_ORDER_FORTRAN,
    :MPI_UNIVERSE_SIZE
]

MPI_pointers = [
    :MPI_BOTTOM,
    :MPI_IN_PLACE,
    :MPI_STATUS_IGNORE,
    :MPI_STATUSES_IGNORE,
    ]

const libptr = dlopen_e(libmpi)

open("gen_consts.c","w") do f
    print(f,"""
#include <stdio.h>
#include <stddef.h>
#include <inttypes.h>
#include "mpi.h"

int main(int argc, char *argv[]) {
    MPI_Init(&argc, &argv);

""")

    println(f,"  printf(\"const MPI_Status_size = %d\\n\", (int)sizeof(MPI_Status));")
    println(f,"  printf(\"const MPI_Status_Source_offset = %d\\n\", (int)offsetof(MPI_Status, MPI_SOURCE));")
    println(f,"  printf(\"const MPI_Status_Tag_offset = %d\\n\", (int)offsetof(MPI_Status, MPI_TAG));")
    println(f,"  printf(\"const MPI_Status_Error_offset = %d\\n\", (int)offsetof(MPI_Status, MPI_ERROR));")

    for (T,constants) in MPI_handle
        println(f,"  printf(\"primitive type $T %d end\\n\", (int)(sizeof($T) * 8));")

        T_f2c = T == :MPI_Datatype ? :MPI_Type_f2c : Symbol(T, :_f2c)
        T_c2f = T == :MPI_Datatype ? :MPI_Type_c2f : Symbol(T, :_c2f)
        if Libdl.dlsym_e(libptr, T_f2c) == C_NULL
            println(f,"  printf(\"$T(c::Cint) = reinterpret($T,c)\\n\");")
            for constant in constants
                println(f,"  printf(\"const $constant = Cint(%i)\\n\", $constant);")
            end
        else
            println(f,"  printf(\"$T(c::Cint) = ccall((:$T_f2c,libmpi),$T,(Cint,),c)\\n\");")
            for constant in constants
                println(f,"  printf(\"const $constant = Cint(%i)\\n\", $T_c2f($constant));")
            end
        end
    end

    for constant in MPI_Cints
        println(f,"  printf(\"const $constant = Cint(%i)\\n\", (int)($constant));")
    end

    for constant in MPI_pointers
        if Sys.WORD_SIZE == 32
            println(f,"  printf(\"const $constant = reinterpret(SentinelPtr, 0x%08\" PRIx32 \")\\n\", (uint32_t)($constant));")
        else
            println(f,"  printf(\"const $constant = reinterpret(SentinelPtr, 0x%016\" PRIx64 \")\\n\", (uint64_t)($constant));")
        end
    end

    print(f,"""
  MPI_Finalize();
  return 0;
}
""")
end
