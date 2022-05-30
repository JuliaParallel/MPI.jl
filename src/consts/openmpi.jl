# Compile-time constants
# logic derived from
# https://github.com/open-mpi/ompi/blob/master/ompi/include/mpi.h.in

# Implementation limits:
const MPI_MAX_DATAREP_STRING = Cint(128)
const MPI_MAX_ERROR_STRING = Cint(256)
const MPI_MAX_INFO_KEY = Cint(36)
const MPI_MAX_INFO_VAL = Cint(256)
const MPI_MAX_LIBRARY_VERSION_STRING = Cint(256)
const MPI_MAX_OBJECT_NAME = Cint(64)
const MPI_MAX_PORT_NAME = Cint(1024)
const MPI_MAX_PROCESSOR_NAME = Cint(256)

# Types

# Various (signed) integer types:
const MPI_Aint = Cptrdiff_t
const MPI_Fint = Cint
const MPI_Count = Int  # needs to be Int to match different sizes on 32-bit/64-bit systems
const MPI_Offset = Int # needs to be Int to match different sizes on 32-bit/64-bit systems

# Status:
struct MPI_Status
    MPI_SOURCE::Cint
    MPI_TAG::Cint
    MPI_ERROR::Cint
    _private0::Cint
    _private1::Csize_t
end

# Opaque handles:
const MPI_Comm = Ptr{Cvoid}
const MPI_Datatype = Ptr{Cvoid}
const MPI_Errhandler = Ptr{Cvoid}
const MPI_File = Ptr{Cvoid}
const MPI_Group = Ptr{Cvoid}
const MPI_Info = Ptr{Cvoid}
const MPI_Message = Ptr{Cvoid}
const MPI_Op = Ptr{Cvoid}
const MPI_Request = Ptr{Cvoid}
const MPI_Win = Ptr{Cvoid}

# Function pointers:
const MPI_Comm_copy_attr_function = Ptr{Cvoid}
const MPI_Comm_delete_attr_function = Ptr{Cvoid}
const MPI_Comm_errhandler_function = Ptr{Cvoid}
const MPI_Comm_errhandler_fn = MPI_Comm_errhandler_function
const MPI_Copy_function = MPI_Comm_copy_attr_function
const MPI_Datarep_conversion_function = Ptr{Cvoid}
const MPI_Datarep_extent_function = Ptr{Cvoid}
const MPI_Delete_function = Ptr{Cvoid}
const MPI_File_errhandler_function = Ptr{Cvoid}
const MPI_File_errhandler_fn = Ptr{Cvoid}
const MPI_Grequest_cancel_function = Ptr{Cvoid}
const MPI_Grequest_free_function = Ptr{Cvoid}
const MPI_Grequest_query_function = Ptr{Cvoid}
const MPI_Type_copy_attr_function = Ptr{Cvoid}
const MPI_Type_delete_attr_function = Ptr{Cvoid}
const MPI_User_function = Ptr{Cvoid}
const MPI_Win_copy_attr_function = Ptr{Cvoid}
const MPI_Win_delete_attr_function = Ptr{Cvoid}
const MPI_Win_errhandler_function = Ptr{Cvoid}
const MPI_Win_errhandler_fn = MPI_Win_errhandler_function

# Run-time constants

@const_ref MPI_ANY_SOURCE Cint -1
@const_ref MPI_ANY_TAG    Cint -1
@const_ref MPI_PROC_NULL  Cint -2
@const_ref MPI_ROOT       Cint -4

@const_ref MPI_CART       Cint 1
@const_ref MPI_GRAPH      Cint 2
@const_ref MPI_DIST_GRAPH Cint 3

@const_ref MPI_IDENT      Cint 0
@const_ref MPI_CONGRUENT  Cint 1
@const_ref MPI_SIMILAR    Cint 2
@const_ref MPI_UNEQUAL    Cint 3

@const_ref MPI_KEYVAL_INVALID     Cint -1
@const_ref MPI_UNDEFINED          Cint -32766

@const_ref MPI_TAG_UB             Cint 0
@const_ref MPI_HOST               Cint 1
@const_ref MPI_IO                 Cint 2
@const_ref MPI_WTIME_IS_GLOBAL    Cint 3
@const_ref MPI_APPNUM             Cint 4
@const_ref MPI_LASTUSEDCODE       Cint 5
@const_ref MPI_UNIVERSE_SIZE      Cint 6

@const_ref MPI_WIN_BASE           Cint 7
@const_ref MPI_WIN_SIZE           Cint 8
@const_ref MPI_WIN_DISP_UNIT      Cint 9
@const_ref MPI_WIN_CREATE_FLAVOR  Cint 10
@const_ref MPI_WIN_MODEL          Cint 11

@const_ref MPI_COMBINER_NAMED            Cint 0
@const_ref MPI_COMBINER_DUP              Cint 1
@const_ref MPI_COMBINER_CONTIGUOUS       Cint 2
@const_ref MPI_COMBINER_VECTOR           Cint 3
@const_ref MPI_COMBINER_HVECTOR_INTEGER  Cint 4
@const_ref MPI_COMBINER_HVECTOR          Cint 5
@const_ref MPI_COMBINER_INDEXED          Cint 6
@const_ref MPI_COMBINER_HINDEXED_INTEGER Cint 7
@const_ref MPI_COMBINER_HINDEXED         Cint 8
@const_ref MPI_COMBINER_INDEXED_BLOCK    Cint 9
@const_ref MPI_COMBINER_STRUCT_INTEGER   Cint 10
@const_ref MPI_COMBINER_STRUCT           Cint 11
@const_ref MPI_COMBINER_SUBARRAY         Cint 12
@const_ref MPI_COMBINER_DARRAY           Cint 13
@const_ref MPI_COMBINER_F90_REAL         Cint 14
@const_ref MPI_COMBINER_F90_COMPLEX      Cint 15
@const_ref MPI_COMBINER_F90_INTEGER      Cint 16
@const_ref MPI_COMBINER_RESIZED          Cint 17
@const_ref MPI_COMBINER_HINDEXED_BLOCK   Cint 18

@const_ref MPI_COMM_TYPE_SHARED Cint 0

@const_ref MPI_DISTRIBUTE_BLOCK  Cint 0
@const_ref MPI_DISTRIBUTE_CYCLIC Cint 1
@const_ref MPI_DISTRIBUTE_NONE   Cint 2

@const_ref MPI_SUCCESS                   Cint 0
@const_ref MPI_ERR_BUFFER                Cint 1
@const_ref MPI_ERR_COUNT                 Cint 2
@const_ref MPI_ERR_TYPE                  Cint 3
@const_ref MPI_ERR_TAG                   Cint 4
@const_ref MPI_ERR_COMM                  Cint 5
@const_ref MPI_ERR_RANK                  Cint 6
@const_ref MPI_ERR_REQUEST               Cint 7
@const_ref MPI_ERR_ROOT                  Cint 8
@const_ref MPI_ERR_GROUP                 Cint 9
@const_ref MPI_ERR_OP                    Cint 10
@const_ref MPI_ERR_TOPOLOGY              Cint 11
@const_ref MPI_ERR_DIMS                  Cint 12
@const_ref MPI_ERR_ARG                   Cint 13
@const_ref MPI_ERR_UNKNOWN               Cint 14
@const_ref MPI_ERR_TRUNCATE              Cint 15
@const_ref MPI_ERR_OTHER                 Cint 16
@const_ref MPI_ERR_INTERN                Cint 17
@const_ref MPI_ERR_IN_STATUS             Cint 18
@const_ref MPI_ERR_PENDING               Cint 19
@const_ref MPI_ERR_ACCESS                Cint 20
@const_ref MPI_ERR_AMODE                 Cint 21
@const_ref MPI_ERR_ASSERT                Cint 22
@const_ref MPI_ERR_BAD_FILE              Cint 23
@const_ref MPI_ERR_BASE                  Cint 24
@const_ref MPI_ERR_CONVERSION            Cint 25
@const_ref MPI_ERR_DISP                  Cint 26
@const_ref MPI_ERR_DUP_DATAREP           Cint 27
@const_ref MPI_ERR_FILE_EXISTS           Cint 28
@const_ref MPI_ERR_FILE_IN_USE           Cint 29
@const_ref MPI_ERR_FILE                  Cint 30
@const_ref MPI_ERR_INFO_KEY              Cint 31
@const_ref MPI_ERR_INFO_NOKEY            Cint 32
@const_ref MPI_ERR_INFO_VALUE            Cint 33
@const_ref MPI_ERR_INFO                  Cint 34
@const_ref MPI_ERR_IO                    Cint 35
@const_ref MPI_ERR_KEYVAL                Cint 36
@const_ref MPI_ERR_LOCKTYPE              Cint 37
@const_ref MPI_ERR_NAME                  Cint 38
@const_ref MPI_ERR_NO_MEM                Cint 39
@const_ref MPI_ERR_NOT_SAME              Cint 40
@const_ref MPI_ERR_NO_SPACE              Cint 41
@const_ref MPI_ERR_NO_SUCH_FILE          Cint 42
@const_ref MPI_ERR_PORT                  Cint 43
@const_ref MPI_ERR_QUOTA                 Cint 44
@const_ref MPI_ERR_READ_ONLY             Cint 45
@const_ref MPI_ERR_RMA_CONFLICT          Cint 46
@const_ref MPI_ERR_RMA_SYNC              Cint 47
@const_ref MPI_ERR_SERVICE               Cint 48
@const_ref MPI_ERR_SIZE                  Cint 49
@const_ref MPI_ERR_SPAWN                 Cint 50
@const_ref MPI_ERR_UNSUPPORTED_DATAREP   Cint 51
@const_ref MPI_ERR_UNSUPPORTED_OPERATION Cint 52
@const_ref MPI_ERR_WIN                   Cint 53
@const_ref MPI_T_ERR_MEMORY              Cint 54
@const_ref MPI_T_ERR_NOT_INITIALIZED     Cint 55
@const_ref MPI_T_ERR_CANNOT_INIT         Cint 56
@const_ref MPI_T_ERR_INVALID_INDEX       Cint 57
@const_ref MPI_T_ERR_INVALID_ITEM        Cint 58
@const_ref MPI_T_ERR_INVALID_HANDLE      Cint 59
@const_ref MPI_T_ERR_OUT_OF_HANDLES      Cint 60
@const_ref MPI_T_ERR_OUT_OF_SESSIONS     Cint 61
@const_ref MPI_T_ERR_INVALID_SESSION     Cint 62
@const_ref MPI_T_ERR_CVAR_SET_NOT_NOW    Cint 63
@const_ref MPI_T_ERR_CVAR_SET_NEVER      Cint 64
@const_ref MPI_T_ERR_PVAR_NO_STARTSTOP   Cint 65
@const_ref MPI_T_ERR_PVAR_NO_WRITE       Cint 66
@const_ref MPI_T_ERR_PVAR_NO_ATOMIC      Cint 67
@const_ref MPI_ERR_RMA_RANGE             Cint 68
@const_ref MPI_ERR_RMA_ATTACH            Cint 69
@const_ref MPI_ERR_RMA_FLAVOR            Cint 70
@const_ref MPI_ERR_RMA_SHARED            Cint 71
@const_ref MPI_T_ERR_INVALID             Cint 72
@const_ref MPI_T_ERR_INVALID_NAME        Cint 73
@const_ref MPI_ERR_PROC_ABORTED          Cint 74
@const_ref MPI_ERR_PROC_FAILED           Cint 75
@const_ref MPI_ERR_PROC_FAILED_PENDING   Cint 76
@const_ref MPI_ERR_REVOKED               Cint 77


@const_ref MPI_LOCK_EXCLUSIVE  Cint 1
@const_ref MPI_LOCK_SHARED     Cint 2


@const_ref MPI_MODE_CREATE           Cint   1
@const_ref MPI_MODE_RDONLY           Cint   2
@const_ref MPI_MODE_WRONLY           Cint   4
@const_ref MPI_MODE_RDWR             Cint   8
@const_ref MPI_MODE_DELETE_ON_CLOSE  Cint  16
@const_ref MPI_MODE_UNIQUE_OPEN      Cint  32
@const_ref MPI_MODE_EXCL             Cint  64
@const_ref MPI_MODE_APPEND           Cint 128
@const_ref MPI_MODE_SEQUENTIAL       Cint 256

@const_ref MPI_MODE_NOCHECK          Cint  1
@const_ref MPI_MODE_NOPRECEDE        Cint  2
@const_ref MPI_MODE_NOPUT            Cint  4
@const_ref MPI_MODE_NOSTORE          Cint  8
@const_ref MPI_MODE_NOSUCCEED        Cint 16

@const_ref MPI_ORDER_C       Cint 0
@const_ref MPI_ORDER_FORTRAN Cint 1


@const_ref MPI_SEEK_SET Cint 600
@const_ref MPI_SEEK_CUR Cint 602
@const_ref MPI_SEEK_END Cint 604

@const_ref MPI_THREAD_SINGLE Cint 0
@const_ref MPI_THREAD_FUNNELED Cint 1
@const_ref MPI_THREAD_SERIALIZED Cint 2
@const_ref MPI_THREAD_MULTIPLE Cint 3

@const_ref MPI_TYPECLASS_INTEGER Cint 1
@const_ref MPI_TYPECLASS_REAL    Cint 2
@const_ref MPI_TYPECLASS_COMPLEX Cint 3

@const_ref MPI_ARGV_NULL      Ptr{Cvoid} C_NULL
@const_ref MPI_ARGVS_NULL     Ptr{Cvoid} C_NULL

@const_ref MPI_UNWEIGHTED     Ptr{Cint} 2
@const_ref MPI_WEIGHTS_EMPTY  Ptr{Cint} 3
@const_ref MPI_BOTTOM         Ptr{Cvoid} 0
@const_ref MPI_IN_PLACE       Ptr{Cvoid} 1

@const_ref MPI_COMM_NULL  MPI_Comm cglobal((:ompi_mpi_comm_null, libmpi))
@const_ref MPI_COMM_SELF  MPI_Comm cglobal((:ompi_mpi_comm_self, libmpi))
@const_ref MPI_COMM_WORLD MPI_Comm cglobal((:ompi_mpi_comm_world, libmpi))

@const_ref MPI_COMM_DUP_FN           MPI_Comm_copy_attr_function   cglobal((:OMPI_C_MPI_COMM_DUP_FN, libmpi))
@const_ref MPI_COMM_NULL_COPY_FN     MPI_Comm_copy_attr_function   cglobal((:OMPI_C_MPI_COMM_NULL_COPY_FN, libmpi))
@const_ref MPI_COMM_NULL_DELETE_FN   MPI_Comm_delete_attr_function cglobal((:OMPI_C_MPI_COMM_NULL_DELETE_FN, libmpi))

@const_ref MPI_DATATYPE_NULL MPI_Datatype cglobal((:ompi_mpi_datatype_null, libmpi))

@const_ref MPI_BYTE MPI_Datatype cglobal((:ompi_mpi_byte, libmpi))
@const_ref MPI_PACKED MPI_Datatype cglobal((:ompi_mpi_packed, libmpi))
@const_ref MPI_CHAR MPI_Datatype cglobal((:ompi_mpi_char, libmpi))
@const_ref MPI_SHORT MPI_Datatype cglobal((:ompi_mpi_short, libmpi))
@const_ref MPI_INT MPI_Datatype cglobal((:ompi_mpi_int, libmpi))
@const_ref MPI_LONG MPI_Datatype cglobal((:ompi_mpi_long, libmpi))
@const_ref MPI_FLOAT MPI_Datatype cglobal((:ompi_mpi_float, libmpi))
@const_ref MPI_DOUBLE MPI_Datatype cglobal((:ompi_mpi_double, libmpi))
# @const_ref MPI_LONG_DOUBLE MPI_Datatype cglobal((:ompi_mpi_long_double, libmpi))
@const_ref MPI_UNSIGNED_CHAR MPI_Datatype cglobal((:ompi_mpi_unsigned_char, libmpi))
@const_ref MPI_SIGNED_CHAR MPI_Datatype cglobal((:ompi_mpi_signed_char, libmpi))
@const_ref MPI_UNSIGNED_SHORT MPI_Datatype cglobal((:ompi_mpi_unsigned_short, libmpi))
@const_ref MPI_UNSIGNED_LONG MPI_Datatype cglobal((:ompi_mpi_unsigned_long, libmpi))
@const_ref MPI_UNSIGNED MPI_Datatype cglobal((:ompi_mpi_unsigned, libmpi))
@const_ref MPI_FLOAT_INT MPI_Datatype cglobal((:ompi_mpi_float_int, libmpi))
@const_ref MPI_DOUBLE_INT MPI_Datatype cglobal((:ompi_mpi_double_int, libmpi))
@const_ref MPI_LONG_DOUBLE_INT MPI_Datatype cglobal((:ompi_mpi_longdbl_int, libmpi))
@const_ref MPI_LONG_INT MPI_Datatype cglobal((:ompi_mpi_long_int, libmpi))
@const_ref MPI_SHORT_INT MPI_Datatype cglobal((:ompi_mpi_short_int, libmpi))
@const_ref MPI_2INT MPI_Datatype cglobal((:ompi_mpi_2int, libmpi))
@const_ref MPI_UB MPI_Datatype cglobal((:ompi_mpi_ub, libmpi))
@const_ref MPI_LB MPI_Datatype cglobal((:ompi_mpi_lb, libmpi))
@const_ref MPI_WCHAR MPI_Datatype cglobal((:ompi_mpi_wchar, libmpi))
@const_ref MPI_LONG_LONG_INT MPI_Datatype cglobal((:ompi_mpi_long_long_int, libmpi))
const MPI_LONG_LONG = MPI_LONG_LONG_INT
@const_ref MPI_UNSIGNED_LONG_LONG MPI_Datatype cglobal((:ompi_mpi_unsigned_long_long, libmpi))
@const_ref MPI_2COMPLEX MPI_Datatype cglobal((:ompi_mpi_2cplex, libmpi))
@const_ref MPI_2DOUBLE_COMPLEX MPI_Datatype cglobal((:ompi_mpi_2dblcplex, libmpi))

@const_ref MPI_INT8_T MPI_Datatype cglobal((:ompi_mpi_int8_t, libmpi))
@const_ref MPI_UINT8_T MPI_Datatype cglobal((:ompi_mpi_uint8_t, libmpi))
@const_ref MPI_INT16_T MPI_Datatype cglobal((:ompi_mpi_int16_t, libmpi))
@const_ref MPI_UINT16_T MPI_Datatype cglobal((:ompi_mpi_uint16_t, libmpi))
@const_ref MPI_INT32_T MPI_Datatype cglobal((:ompi_mpi_int32_t, libmpi))
@const_ref MPI_UINT32_T MPI_Datatype cglobal((:ompi_mpi_uint32_t, libmpi))
@const_ref MPI_INT64_T MPI_Datatype cglobal((:ompi_mpi_int64_t, libmpi))
@const_ref MPI_UINT64_T MPI_Datatype cglobal((:ompi_mpi_uint64_t, libmpi))
@const_ref MPI_AINT MPI_Datatype cglobal((:ompi_mpi_aint, libmpi))
@const_ref MPI_OFFSET MPI_Datatype cglobal((:ompi_mpi_offset, libmpi))
@const_ref MPI_C_BOOL MPI_Datatype cglobal((:ompi_mpi_c_bool, libmpi))
@const_ref MPI_C_FLOAT_COMPLEX MPI_Datatype cglobal((:ompi_mpi_c_float_complex, libmpi))
const MPI_C_COMPLEX = MPI_C_FLOAT_COMPLEX
@const_ref MPI_C_DOUBLE_COMPLEX MPI_Datatype cglobal((:ompi_mpi_c_double_complex, libmpi))
# @const_ref MPI_C_LONG_DOUBLE_COMPLEX MPI_Datatype cglobal((:ompi_mpi_c_long_double_complex, libmpi))
@const_ref MPI_COUNT MPI_Datatype cglobal((:ompi_mpi_count, libmpi))


@const_ref MPI_ERRHANDLER_NULL MPI_Errhandler  cglobal((:ompi_mpi_errhandler_null, libmpi))
@const_ref MPI_ERRORS_ARE_FATAL MPI_Errhandler cglobal((:ompi_mpi_errors_are_fatal, libmpi))
@const_ref MPI_ERRORS_RETURN MPI_Errhandler    cglobal((:ompi_mpi_errors_return, libmpi))
# @const_ref MPI_ERRORS_ABORT MPI_Errhandler     cglobal((:ompi_mpi_errors_abort, libmpi))

@const_ref MPI_FILE_NULL MPI_File cglobal((:ompi_mpi_file_null, libmpi))

@const_ref MPI_GROUP_EMPTY MPI_Group cglobal((:ompi_mpi_group_empty, libmpi))
@const_ref MPI_GROUP_NULL MPI_Group cglobal((:ompi_mpi_group_null, libmpi))

@const_ref MPI_INFO_ENV MPI_Info cglobal((:ompi_mpi_info_env, libmpi))
@const_ref MPI_INFO_NULL MPI_Info cglobal((:ompi_mpi_info_null, libmpi))

@const_ref MPI_MESSAGE_NO_PROC MPI_Message cglobal((:ompi_message_no_proc, libmpi))
@const_ref MPI_MESSAGE_NULL MPI_Message cglobal((:ompi_message_null, libmpi))

@const_ref MPI_DISPLACEMENT_CURRENT MPI_Offset -54278278

@const_ref MPI_OP_NULL MPI_Op cglobal((:ompi_mpi_op_null, libmpi))
@const_ref MPI_MAX     MPI_Op cglobal((:ompi_mpi_op_max, libmpi))
@const_ref MPI_MIN     MPI_Op cglobal((:ompi_mpi_op_min, libmpi))
@const_ref MPI_SUM     MPI_Op cglobal((:ompi_mpi_op_sum, libmpi))
@const_ref MPI_PROD    MPI_Op cglobal((:ompi_mpi_op_prod, libmpi))
@const_ref MPI_LAND    MPI_Op cglobal((:ompi_mpi_op_land, libmpi))
@const_ref MPI_BAND    MPI_Op cglobal((:ompi_mpi_op_band, libmpi))
@const_ref MPI_LOR     MPI_Op cglobal((:ompi_mpi_op_lor, libmpi))
@const_ref MPI_BOR     MPI_Op cglobal((:ompi_mpi_op_bor, libmpi))
@const_ref MPI_LXOR    MPI_Op cglobal((:ompi_mpi_op_lxor, libmpi))
@const_ref MPI_BXOR    MPI_Op cglobal((:ompi_mpi_op_bxor, libmpi))
@const_ref MPI_MINLOC  MPI_Op cglobal((:ompi_mpi_op_minloc, libmpi))
@const_ref MPI_MAXLOC  MPI_Op cglobal((:ompi_mpi_op_maxloc, libmpi))
@const_ref MPI_REPLACE MPI_Op cglobal((:ompi_mpi_op_replace, libmpi))
@const_ref MPI_NO_OP   MPI_Op cglobal((:ompi_mpi_op_no_op, libmpi))

@const_ref MPI_REQUEST_NULL MPI_Request cglobal((:ompi_request_null, libmpi))

@const_ref MPI_STATUS_IGNORE    Ptr{MPI_Status} C_NULL
@const_ref MPI_STATUSES_IGNORE  Ptr{MPI_Status} C_NULL

@const_ref MPI_TYPE_DUP_FN          MPI_Comm_copy_attr_function   cglobal((:OMPI_C_MPI_TYPE_DUP_FN, libmpi), MPI_Comm_copy_attr_function)
@const_ref MPI_TYPE_NULL_COPY_FN    MPI_Type_copy_attr_function   cglobal((:OMPI_C_MPI_TYPE_NULL_COPY_FN, libmpi), MPI_Comm_copy_attr_function)
@const_ref MPI_TYPE_NULL_DELETE_FN  MPI_Type_delete_attr_function cglobal((:OMPI_C_MPI_TYPE_NULL_DELETE_FN, libmpi), MPI_Type_delete_attr_function)

@const_ref MPI_WIN_NULL MPI_Win cglobal((:ompi_mpi_win_null, libmpi))

@const_ref MPI_WIN_DUP_FN           MPI_Win_copy_attr_function   cglobal((:OMPI_C_MPI_WIN_DUP_FN, libmpi), MPI_Win_copy_attr_function)
@const_ref MPI_WIN_NULL_COPY_FN     MPI_Win_copy_attr_function   cglobal((:OMPI_C_MPI_WIN_NULL_COPY_FN, libmpi), MPI_Win_copy_attr_function)
@const_ref MPI_WIN_NULL_DELETE_FN   MPI_Win_delete_attr_function cglobal((:OMPI_C_MPI_WIN_NULL_DELETE_FN, libmpi), MPI_Win_delete_attr_function)
