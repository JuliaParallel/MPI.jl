# Compile-time constants
# From HPE MPT 2.23's `mpi.h` and `mpio.h` on HLRS Hawk (2022-04-22)

# Implementation limits:
const MPI_MAX_DATAREP_STRING = Cint(128)
const MPI_MAX_ERROR_STRING = Cint(256)
const MPI_MAX_INFO_KEY = Cint(255)
const MPI_MAX_INFO_VAL = Cint(1024)
const MPI_MAX_LIBRARY_VERSION_STRING = Cint(256)
const MPI_MAX_OBJECT_NAME = Cint(128)
const MPI_MAX_PORT_NAME = Cint(256)
const MPI_MAX_PROCESSOR_NAME = Cint(256)

# Types

# Various (signed) integer types:
const MPI_Aint   = Clong
const MPI_Fint   = Cint
const MPI_Count  = Clonglong
const MPI_Offset = Clonglong

# Status:
struct MPI_Status
    MPI_SOURCE::Cint
    MPI_TAG::Cint
    MPI_ERROR::Cint
    _private0::Cint
    _private1::Clong
end

# Opaque handles:
const MPI_Comm       = Cuint
const MPI_Datatype   = Cuint
const MPI_Errhandler = Cuint
const MPI_File       = Ptr{Cvoid}
const MPI_Group      = Cuint
const MPI_Info       = Cuint
const MPI_Message    = Cint
const MPI_Op         = Cuint
const MPI_Request    = Cuint
const MPI_Win        = Cuint

# Function pointers:
const MPI_Comm_copy_attr_function = Ptr{Cvoid}
const MPI_Comm_delete_attr_function = Ptr{Cvoid}
const MPI_Comm_errhandler_function = Ptr{Cvoid}
const MPI_Comm_errhandler_fn = MPI_Comm_errhandler_function
const MPI_Copy_function = Ptr{Cvoid}
const MPI_Datarep_conversion_function = Ptr{Cvoid}
const MPI_Datarep_extent_function = Ptr{Cvoid}
const MPI_Delete_function = Ptr{Cvoid}
const MPI_File_errhandler_function = Ptr{Cvoid}
const MPI_File_errhandler_fn = MPI_File_errhandler_function
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

@const_ref MPI_ANY_SOURCE Cint -2
@const_ref MPI_ANY_TAG    Cint -1
@const_ref MPI_PROC_NULL  Cint -1
@const_ref MPI_ROOT       Cint -4

@const_ref MPI_GRAPH      Cint 1
@const_ref MPI_CART       Cint 2
@const_ref MPI_DIST_GRAPH Cint 3

@const_ref MPI_IDENT      Cint 0
@const_ref MPI_CONGRUENT  Cint 1
@const_ref MPI_SIMILAR    Cint 2
@const_ref MPI_UNEQUAL    Cint 3

@const_ref MPI_KEYVAL_INVALID     Cint  0
@const_ref MPI_UNDEFINED          Cint -3

@const_ref MPI_TAG_UB             Cint  1
@const_ref MPI_HOST               Cint  2
@const_ref MPI_IO                 Cint  3
@const_ref MPI_WTIME_IS_GLOBAL    Cint  4
@const_ref MPI_UNIVERSE_SIZE      Cint  9
@const_ref MPI_LASTUSEDCODE       Cint 13
@const_ref MPI_APPNUM             Cint 11

@const_ref MPI_WIN_BASE           Cint 1
@const_ref MPI_WIN_SIZE           Cint 2
@const_ref MPI_WIN_DISP_UNIT      Cint 3
@const_ref MPI_WIN_CREATE_FLAVOR  Cint 7
@const_ref MPI_WIN_MODEL          Cint 9

@const_ref MPI_COMBINER_NAMED            Cint -1
@const_ref MPI_COMBINER_DUP              Cint  7
@const_ref MPI_COMBINER_CONTIGUOUS       Cint  0
@const_ref MPI_COMBINER_VECTOR           Cint  1
@const_ref MPI_COMBINER_HVECTOR_INTEGER  Cint 12
@const_ref MPI_COMBINER_HVECTOR          Cint  2
@const_ref MPI_COMBINER_INDEXED          Cint  3
@const_ref MPI_COMBINER_HINDEXED_INTEGER Cint 11
@const_ref MPI_COMBINER_HINDEXED         Cint  4
@const_ref MPI_COMBINER_INDEXED_BLOCK    Cint 13
@const_ref MPI_COMBINER_STRUCT_INTEGER   Cint 15
@const_ref MPI_COMBINER_STRUCT           Cint  5
@const_ref MPI_COMBINER_SUBARRAY         Cint 16
@const_ref MPI_COMBINER_DARRAY           Cint  6
@const_ref MPI_COMBINER_F90_REAL         Cint 10
@const_ref MPI_COMBINER_F90_COMPLEX      Cint  8
@const_ref MPI_COMBINER_F90_INTEGER      Cint  9
@const_ref MPI_COMBINER_RESIZED          Cint 14
@const_ref MPI_COMBINER_HINDEXED_BLOCK   Cint 17

@const_ref MPI_COMM_TYPE_SHARED Cint 1

@const_ref MPI_DISTRIBUTE_BLOCK  Cint 121
@const_ref MPI_DISTRIBUTE_CYCLIC Cint 122
@const_ref MPI_DISTRIBUTE_NONE   Cint 123

@const_ref MPI_SUCCESS                   Cint  0
@const_ref MPI_ERR_BUFFER                Cint  1
@const_ref MPI_ERR_COUNT                 Cint  2
@const_ref MPI_ERR_TYPE                  Cint  3
@const_ref MPI_ERR_TAG                   Cint  4
@const_ref MPI_ERR_COMM                  Cint  5
@const_ref MPI_ERR_RANK                  Cint  6
@const_ref MPI_ERR_ROOT                  Cint  8
@const_ref MPI_ERR_TRUNCATE              Cint 15
@const_ref MPI_ERR_GROUP                 Cint  9
@const_ref MPI_ERR_OP                    Cint 10
@const_ref MPI_ERR_REQUEST               Cint  7
@const_ref MPI_ERR_TOPOLOGY              Cint 11
@const_ref MPI_ERR_DIMS                  Cint 12
@const_ref MPI_ERR_ARG                   Cint 13
@const_ref MPI_ERR_OTHER                 Cint 16
@const_ref MPI_ERR_UNKNOWN               Cint 14
@const_ref MPI_ERR_INTERN                Cint 17
@const_ref MPI_ERR_IN_STATUS             Cint 18
@const_ref MPI_ERR_PENDING               Cint 19
@const_ref MPI_ERR_ACCESS                Cint 28
@const_ref MPI_ERR_AMODE                 Cint 29
@const_ref MPI_ERR_BAD_FILE              Cint 31
@const_ref MPI_ERR_CONVERSION            Cint 33
@const_ref MPI_ERR_DUP_DATAREP           Cint 35
@const_ref MPI_ERR_FILE_EXISTS           Cint 36
@const_ref MPI_ERR_FILE_IN_USE           Cint 37
@const_ref MPI_ERR_FILE                  Cint 38
@const_ref MPI_ERR_IO                    Cint 43
@const_ref MPI_ERR_NO_SPACE              Cint 49
@const_ref MPI_ERR_NO_SUCH_FILE          Cint 50
@const_ref MPI_ERR_READ_ONLY             Cint 53
@const_ref MPI_ERR_UNSUPPORTED_DATAREP   Cint 59
@const_ref MPI_ERR_INFO                  Cint 42
@const_ref MPI_ERR_INFO_KEY              Cint 39
@const_ref MPI_ERR_INFO_VALUE            Cint 41
@const_ref MPI_ERR_INFO_NOKEY            Cint 40
@const_ref MPI_ERR_NAME                  Cint 46
@const_ref MPI_ERR_NO_MEM                Cint 47
@const_ref MPI_ERR_NOT_SAME              Cint 48
@const_ref MPI_ERR_PORT                  Cint 51
@const_ref MPI_ERR_QUOTA                 Cint 52
@const_ref MPI_ERR_SERVICE               Cint 56
@const_ref MPI_ERR_SPAWN                 Cint 58
@const_ref MPI_ERR_UNSUPPORTED_OPERATION Cint 60
@const_ref MPI_ERR_WIN                   Cint 61
@const_ref MPI_ERR_BASE                  Cint 32
@const_ref MPI_ERR_LOCKTYPE              Cint 45
@const_ref MPI_ERR_KEYVAL                Cint 44
@const_ref MPI_ERR_RMA_CONFLICT          Cint 54
@const_ref MPI_ERR_RMA_SYNC              Cint 55
@const_ref MPI_ERR_SIZE                  Cint 57
@const_ref MPI_ERR_DISP                  Cint 34
@const_ref MPI_ERR_ASSERT                Cint 30
@const_ref MPI_ERR_RMA_RANGE             Cint 62
@const_ref MPI_ERR_RMA_ATTACH            Cint 63
@const_ref MPI_ERR_RMA_SHARED            Cint 64
@const_ref MPI_ERR_RMA_FLAVOR            Cint 65


@const_ref MPI_LOCK_EXCLUSIVE Cint 2
@const_ref MPI_LOCK_SHARED    Cint 1


@const_ref MPI_MODE_RDONLY           Cint   2
@const_ref MPI_MODE_RDWR             Cint   8
@const_ref MPI_MODE_WRONLY           Cint   4
@const_ref MPI_MODE_CREATE           Cint   1
@const_ref MPI_MODE_EXCL             Cint  64
@const_ref MPI_MODE_DELETE_ON_CLOSE  Cint  16
@const_ref MPI_MODE_UNIQUE_OPEN      Cint  32
@const_ref MPI_MODE_APPEND           Cint 128
@const_ref MPI_MODE_SEQUENTIAL       Cint 256

@const_ref MPI_MODE_NOCHECK          Cint  1
@const_ref MPI_MODE_NOSTORE          Cint  2
@const_ref MPI_MODE_NOPUT            Cint  4
@const_ref MPI_MODE_NOPRECEDE        Cint  8
@const_ref MPI_MODE_NOSUCCEED        Cint 16

@const_ref MPI_ORDER_C       Cint 56
@const_ref MPI_ORDER_FORTRAN Cint 57


@const_ref MPI_SEEK_SET Cint 600
@const_ref MPI_SEEK_CUR Cint 602
@const_ref MPI_SEEK_END Cint 604

@const_ref MPI_THREAD_SINGLE     Cint 0
@const_ref MPI_THREAD_FUNNELED   Cint 1
@const_ref MPI_THREAD_SERIALIZED Cint 2
@const_ref MPI_THREAD_MULTIPLE   Cint 3

@const_ref MPI_TYPECLASS_REAL    Cint 2
@const_ref MPI_TYPECLASS_INTEGER Cint 1
@const_ref MPI_TYPECLASS_COMPLEX Cint 3

@const_ref MPI_ARGV_NULL      Ptr{Cvoid} C_NULL
@const_ref MPI_ARGVS_NULL     Ptr{Cvoid} C_NULL

@const_ref MPI_UNWEIGHTED     Ptr{Cint} cglobal((:MPI_UNWEIGHTED, libmpi), Ptr{Cint})
@const_ref MPI_WEIGHTS_EMPTY  Ptr{Cint} cglobal((:MPI_WEIGHTS_EMPTY, libmpi), Ptr{Cint})
@const_ref MPI_BOTTOM         Ptr{Cvoid} C_NULL
@const_ref MPI_IN_PLACE       Ptr{Cvoid} cglobal((:mpi_sgi_inplace, libmpi))

@const_ref MPI_COMM_NULL  MPI_Comm 0
@const_ref MPI_COMM_SELF  MPI_Comm 2
@const_ref MPI_COMM_WORLD MPI_Comm 1

@const_ref MPI_COMM_DUP_FN           MPI_Comm_copy_attr_function   cglobal((:MPI_COMM_DUP_FN, libmpi))
@const_ref MPI_COMM_NULL_COPY_FN     MPI_Comm_copy_attr_function   cglobal((:MPI_COMM_NULL_COPY_FN, libmpi))
@const_ref MPI_COMM_NULL_DELETE_FN   MPI_Comm_delete_attr_function cglobal((:MPI_COMM_NULL_DELETE_FN, libmpi))

@const_ref MPI_DATATYPE_NULL MPI_Datatype 0

# Only define C constants, as we don't need the Fortran or C++ ones (and Fortran ones are compiler-dependent).
@const_ref MPI_CHAR                MPI_Datatype  1
@const_ref MPI_UNSIGNED_CHAR       MPI_Datatype  5
@const_ref MPI_SHORT               MPI_Datatype  2
@const_ref MPI_UNSIGNED_SHORT      MPI_Datatype  6
@const_ref MPI_INT                 MPI_Datatype  3
@const_ref MPI_UNSIGNED            MPI_Datatype  7
@const_ref MPI_LONG                MPI_Datatype  4
@const_ref MPI_UNSIGNED_LONG       MPI_Datatype  8
# @const_ref MPI_LONG_LONG_INT       MPI_Datatype 
@const_ref MPI_FLOAT               MPI_Datatype  9
@const_ref MPI_DOUBLE              MPI_Datatype 10
@const_ref MPI_LONG_DOUBLE         MPI_Datatype 11
@const_ref MPI_LONG_LONG           MPI_Datatype 12
@const_ref MPI_BYTE                MPI_Datatype 27
@const_ref MPI_WCHAR               MPI_Datatype 40
@const_ref MPI_PACKED              MPI_Datatype 28

@const_ref MPI_LB                  MPI_Datatype 30
@const_ref MPI_UB                  MPI_Datatype 29

@const_ref MPI_FLOAT_INT           MPI_Datatype 31
@const_ref MPI_DOUBLE_INT          MPI_Datatype 32
@const_ref MPI_LONG_INT            MPI_Datatype 33
@const_ref MPI_SHORT_INT           MPI_Datatype 35
@const_ref MPI_LONG_DOUBLE_INT     MPI_Datatype 36

@const_ref MPI_2INT                MPI_Datatype 34

@const_ref MPI_SIGNED_CHAR         MPI_Datatype 41
@const_ref MPI_UNSIGNED_LONG_LONG  MPI_Datatype 42

@const_ref MPI_INT8_T                   MPI_Datatype 47
@const_ref MPI_INT16_T                  MPI_Datatype 48
@const_ref MPI_INT32_T                  MPI_Datatype 49
@const_ref MPI_INT64_T                  MPI_Datatype 50
@const_ref MPI_UINT8_T                  MPI_Datatype 51
@const_ref MPI_UINT16_T                 MPI_Datatype 52
@const_ref MPI_UINT32_T                 MPI_Datatype 53
@const_ref MPI_UINT64_T                 MPI_Datatype 54
@const_ref MPI_C_BOOL                   MPI_Datatype 57
@const_ref MPI_C_FLOAT_COMPLEX          MPI_Datatype 58
@const_ref MPI_C_DOUBLE_COMPLEX         MPI_Datatype 59
@const_ref MPI_C_LONG_DOUBLE_COMPLEX    MPI_Datatype 60
@const_ref MPI_AINT                     MPI_Datatype 55
@const_ref MPI_OFFSET                   MPI_Datatype 56
@const_ref MPI_COUNT                    MPI_Datatype 61
# @const_ref MPIX_C_FLOAT16               MPI_Datatype 

# aliases
const MPI_LONG_LONG_INT = MPI_LONG_LONG
const MPI_C_COMPLEX = MPI_C_FLOAT_COMPLEX

@const_ref MPI_ERRHANDLER_NULL  MPI_Errhandler 0
@const_ref MPI_ERRORS_ARE_FATAL MPI_Errhandler 1
@const_ref MPI_ERRORS_RETURN    MPI_Errhandler 2
# @const_ref MPI_ERRORS_ABORT MPI_Errhandler

@const_ref MPI_FILE_NULL MPI_File C_NULL

@const_ref MPI_GROUP_EMPTY MPI_Group 1
@const_ref MPI_GROUP_NULL  MPI_Group 0

@const_ref MPI_INFO_ENV  MPI_Info 1
@const_ref MPI_INFO_NULL MPI_Info 0

@const_ref MPI_MESSAGE_NO_PROC MPI_Message -1
@const_ref MPI_MESSAGE_NULL    MPI_Message  0

@const_ref MPI_DISPLACEMENT_CURRENT MPI_Offset -54278278

@const_ref MPI_OP_NULL MPI_Op  0
@const_ref MPI_MAX     MPI_Op  1
@const_ref MPI_MIN     MPI_Op  2
@const_ref MPI_SUM     MPI_Op  3
@const_ref MPI_PROD    MPI_Op  4
@const_ref MPI_LAND    MPI_Op  5
@const_ref MPI_BAND    MPI_Op  6
@const_ref MPI_LOR     MPI_Op  7
@const_ref MPI_BOR     MPI_Op  8
@const_ref MPI_LXOR    MPI_Op  9
@const_ref MPI_BXOR    MPI_Op 10
@const_ref MPI_MINLOC  MPI_Op 12
@const_ref MPI_MAXLOC  MPI_Op 11
@const_ref MPI_REPLACE MPI_Op 13
@const_ref MPI_NO_OP   MPI_Op 14

@const_ref MPI_REQUEST_NULL MPI_Request 0

@const_ref MPI_STATUS_IGNORE    Ptr{Cvoid} cglobal((:mpi_sgi_status_ignore, libmpi))
@const_ref MPI_STATUSES_IGNORE  Ptr{Cvoid} cglobal((:mpi_sgi_status_ignore, libmpi))

@const_ref MPI_TYPE_DUP_FN          MPI_Type_copy_attr_function   cglobal((:MPI_TYPE_DUP_FN, libmpi))
@const_ref MPI_TYPE_NULL_COPY_FN    MPI_Type_copy_attr_function   cglobal((:MPI_TYPE_NULL_COPY_FN, libmpi))
@const_ref MPI_TYPE_NULL_DELETE_FN  MPI_Type_delete_attr_function cglobal((:MPI_TYPE_NULL_DELETE_FN, libmpi))

@const_ref MPI_WIN_NULL MPI_Win 0

@const_ref MPI_WIN_DUP_FN           MPI_Win_copy_attr_function   cglobal((:MPI_WIN_DUP_FN, libmpi))
@const_ref MPI_WIN_NULL_COPY_FN     MPI_Win_copy_attr_function   cglobal((:MPI_WIN_NULL_COPY_FN, libmpi))
@const_ref MPI_WIN_NULL_DELETE_FN   MPI_Win_delete_attr_function cglobal((:MPI_WIN_NULL_DELETE_FN, libmpi))
