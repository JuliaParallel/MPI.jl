# Generates, compiles and runs a C file (gen_consts.c) which prints the necessary type
# declarations and constants in Julia syntax.

# For the "handle" constants (MPI_Info, MPI_Op, etc.) we print the Fortran values, since
# for some implementations (OpenMPI), the C versions are only available at link-time (so
# may not be actually constant).

# It may be possible to work around this by using `cglobal` instead, but we can't know
# what symbols the constants resolve to without a C compiler.

@info "Unknown MPI ABI: building constants file"

MPI_LIBRARY_PATH = dirname(dlpath(libmpi))

MPI_PATH = get(ENV, "JULIA_MPI_PATH", "")
MPI_INCLUDE_PATH = get(ENV, "JULIA_MPI_INCLUDE_PATH", MPI_PATH == "" ? "" : joinpath(MPI_PATH,"include"))
mpicc = get(ENV, "JULIA_MPICC", MPI_PATH == "" ? "mpicc" : joinpath(MPI_PATH, "bin", "mpicc"))

if haskey(ENV, "JULIA_MPI_CFLAGS")
    CFLAGS = Base.shell_split(ENV["JULIA_MPI_CFLAGS"])
else
    lname, = split(basename(libmpi),'.')
    if startswith(lname, "lib")
        lname = lname[4:end]
    end
    CFLAGS = `-l$(lname) -L$(MPI_LIBRARY_PATH)`
    if MPI_INCLUDE_PATH != ""
        CFLAGS = `$CFLAGS -I$(MPI_INCLUDE_PATH)`
    end
end

# build gen_consts.c

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
    :MPI_Errhandler => [
        :MPI_ERRHANDLER_NULL,
        :MPI_ERRORS_ARE_FATAL,
        :MPI_ERRORS_RETURN,
    ],
    :MPI_Request => [
        :MPI_REQUEST_NULL,
    ],
    :MPI_File => [
        :MPI_FILE_NULL,
    ],
    :MPI_Op => MPI_op_consts,
    :MPI_Datatype => MPI_datatype_consts
]

MPI_Cints = [
    :MPI_THREAD_SINGLE,
    :MPI_THREAD_FUNNELED,
    :MPI_THREAD_SERIALIZED,
    :MPI_THREAD_MULTIPLE,
    :MPI_PROC_NULL,
    :MPI_ANY_SOURCE,
    :MPI_ANY_TAG,
    :MPI_SUCCESS,
    :MPI_UNDEFINED,
    :MPI_LOCK_EXCLUSIVE,
    :MPI_LOCK_SHARED,
    :MPI_MAX_INFO_KEY,
    :MPI_MAX_INFO_VAL,
    :MPI_MAX_OBJECT_NAME,
    :MPI_TAG_UB,
    :MPI_COMM_TYPE_SHARED,
    :MPI_ORDER_C,
    :MPI_ORDER_FORTRAN,
    :MPI_UNIVERSE_SIZE,
    :MPI_MAX_ERROR_STRING,
    :MPI_SUCCESS,
    :MPI_MODE_RDONLY,
    :MPI_MODE_RDWR,
    :MPI_MODE_WRONLY,
    :MPI_MODE_CREATE,
    :MPI_MODE_EXCL,
    :MPI_MODE_DELETE_ON_CLOSE,
    :MPI_MODE_UNIQUE_OPEN,
    :MPI_MODE_SEQUENTIAL,
    :MPI_MODE_APPEND,
    :MPI_MODE_NOCHECK,
    :MPI_MODE_NOSTORE,
    :MPI_MODE_NOPUT,
    :MPI_MODE_NOPRECEDE,
    :MPI_MODE_NOSUCCEED,
    :MPI_SEEK_SET,
    :MPI_SEEK_CUR,
    :MPI_SEEK_END,
    :MPI_IDENT,
    :MPI_CONGRUENT,
    :MPI_SIMILAR,
    :MPI_UNEQUAL,
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
#include <mpi.h>

#include <inttypes.h>
#include <stddef.h>
#include <stdio.h>

int main(int argc, char *argv[]) {
    MPI_Init(&argc, &argv);

    FILE *fptr = fopen("consts.jl", "r+");
    fseek(fptr, 0, SEEK_END);

""")

    println(f,"  fprintf(fptr, \"const MPI_Aint = Int%d\\n\", 8*(int)sizeof(MPI_Aint));")
    println(f,"  fprintf(fptr, \"const MPI_Offset = Int%d\\n\", 8*(int)sizeof(MPI_Offset));")
    println(f,"  fprintf(fptr, \"const MPI_Count = Int%d\\n\", 8*(int)sizeof(MPI_Count));")

    println(f,"  fprintf(fptr, \"const MPI_Status_size = %d\\n\", (int)sizeof(MPI_Status));")
    println(f,"  fprintf(fptr, \"const MPI_Status_Source_offset = %d\\n\", (int)offsetof(MPI_Status, MPI_SOURCE));")
    println(f,"  fprintf(fptr, \"const MPI_Status_Tag_offset = %d\\n\", (int)offsetof(MPI_Status, MPI_TAG));")
    println(f,"  fprintf(fptr, \"const MPI_Status_Error_offset = %d\\n\", (int)offsetof(MPI_Status, MPI_ERROR));")

    for (T,constants) in MPI_handle
        T_f2c = T == :MPI_Datatype ? :MPI_Type_f2c : Symbol(T, :_f2c)
        T_c2f = T == :MPI_Datatype ? :MPI_Type_c2f : Symbol(T, :_c2f)
        if Libdl.dlsym_e(libptr, T_f2c) == C_NULL
            println(f,"  fprintf(fptr, \"const $T = Cint\\n\");")
            for constant in constants
                println(f,"  fprintf(fptr, \"const $constant = Cint(%i)\\n\", $constant);")
            end
        else
            println(f,"  fprintf(fptr, \"const $T = Ptr{Cvoid}\\n\");")
            println(f,"  fprintf(fptr, \"$(Symbol(T,:_f2c))(c::Cint) = ccall((:$T_f2c,libmpi),$T,(Cint,),c)\\n\");")
            for constant in constants
                println(f,"  fprintf(fptr, \"const $constant = Cint(%i)\\n\", $T_c2f($constant));")
            end
        end
    end

    for constant in MPI_Cints
        println(f,"  fprintf(fptr, \"const $constant = Cint(%i)\\n\", (int)($constant));")
    end

    for constant in MPI_pointers
        if Sys.WORD_SIZE == 32
            println(f,"  fprintf(fptr, \"const $constant = reinterpret(SentinelPtr, 0x%08\" PRIx32 \")\\n\", (uint32_t)($constant));")
        else
            println(f,"  fprintf(fptr, \"const $constant = reinterpret(SentinelPtr, 0x%016\" PRIx64 \")\\n\", (uint64_t)($constant));")
        end
    end

    print(f,"""
  fclose(fptr);
  MPI_Finalize();
  return 0;
}
""")
end


# compile gen_consts.c
run(`$mpicc gen_consts.c -o gen_consts $CFLAGS`)

open("consts.jl", write=true) do f
    println(f, "# This file is automatically generated")
    println(f, "# Do not edit")
    println(f)
    println(f, "global MPI_TYPE_NULL_COPY_FN = nothing")
    println(f, "global MPI_TYPE_NULL_DELETE_FN = nothing")
    println(f)
    println(f, "function init_system_constants()")
    # These symbols are functions in OpenMPI (and we need their
    # address). These symbols are preprocessor constants in MPICH. If
    # they exist, we use their address; if they don't exist, we assume
    # MPICH and use `C_NULL`.
    println(f, "global MPI_TYPE_NULL_COPY_FN =")
    println(f, "    try")
    println(f, "        cglobal((:MPI_TYPE_NULL_COPY_FN, libmpi))")
    println(f, "    catch")
    println(f, "        C_NULL")
    println(f, "    end")
    println(f, "global MPI_TYPE_NULL_DELETE_FN =")
    println(f, "    try")
    println(f, "        cglobal((:MPI_TYPE_NULL_DELETE_FN, libmpi))")
    println(f, "    catch")
    println(f, "        C_NULL")
    println(f, "    end")
    println(f, "end")
    println(f)
end

# execute gen_consts
run(`$mpiexec_cmd -n 1 ./gen_consts`)
