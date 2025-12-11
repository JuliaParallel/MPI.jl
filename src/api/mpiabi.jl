const MPI_VERSION = 5
const MPI_SUBVERSION = 0

const MPI_Aint = Int
const MPI_Offset = Int64
const MPI_Count = Int64

const MPI_Fint = Int32

struct MPI_Status
    MPI_SOURCE::Cint
    MPI_TAG::Cint
    MPI_ERROR::Cint
    MPI_internal::NTuple{5,Cint}
end

const MPI_Op = Ptr{Cvoid}
@const_ref MPI_OP_NULL MPI_Op 0x00000020
@const_ref MPI_SUM MPI_Op 0x00000021
@const_ref MPI_MIN MPI_Op 0x00000022
@const_ref MPI_MAX MPI_Op 0x00000023
@const_ref MPI_PROD MPI_Op 0x00000024
@const_ref MPI_BAND MPI_Op 0x00000028
@const_ref MPI_BOR MPI_Op 0x00000029
@const_ref MPI_BXOR MPI_Op 0x0000002a
@const_ref MPI_LAND MPI_Op 0x00000030
@const_ref MPI_LOR MPI_Op 0x00000031
@const_ref MPI_LXOR MPI_Op 0x00000032
@const_ref MPI_MINLOC MPI_Op 0x00000038
@const_ref MPI_MAXLOC MPI_Op 0x00000039
@const_ref MPI_REPLACE MPI_Op 0x0000003c
@const_ref MPI_NO_OP MPI_Op 0x0000003d

const MPI_Comm = Ptr{Cvoid}
@const_ref MPI_COMM_NULL MPI_Comm 0x00000100
@const_ref MPI_COMM_WORLD MPI_Comm 0x00000101
@const_ref MPI_COMM_SELF MPI_Comm 0x00000102

const MPI_Group = Ptr{Cvoid}
@const_ref MPI_GROUP_NULL MPI_Group 0x00000108
@const_ref MPI_GROUP_EMPTY MPI_Group 0x00000109

const MPI_Win = Ptr{Cvoid}
@const_ref MPI_WIN_NULL MPI_Win 0x00000110

const MPI_File = Ptr{Cvoid}
@const_ref MPI_FILE_NULL MPI_File 0x00000118

const MPI_Session = Ptr{Cvoid}
@const_ref MPI_SESSION_NULL MPI_Session 0x00000120

const MPI_Message = Ptr{Cvoid}
@const_ref MPI_MESSAGE_NULL MPI_Message 0x00000128
@const_ref MPI_MESSAGE_NO_PROC MPI_Message 0x00000129

const MPI_Info = Ptr{Cvoid}
@const_ref MPI_INFO_NULL MPI_Info 0x00000130
@const_ref MPI_INFO_ENV MPI_Info 0x00000131

const MPI_Errhandler = Ptr{Cvoid}
@const_ref MPI_ERRHANDLER_NULL MPI_Errhandler 0x00000140
@const_ref MPI_ERRORS_ARE_FATAL MPI_Errhandler 0x00000141
@const_ref MPI_ERRORS_RETURN MPI_Errhandler 0x00000142
@const_ref MPI_ERRORS_ABORT MPI_Errhandler 0x00000143

const MPI_Request = Ptr{Cvoid}
@const_ref MPI_REQUEST_NULL MPI_Request 0x00000180

const MPI_Datatype = Ptr{Cvoid}
@const_ref MPI_DATATYPE_NULL MPI_Datatype 0x00000200
@const_ref MPI_AINT MPI_Datatype 0x00000201
@const_ref MPI_COUNT MPI_Datatype 0x00000202
@const_ref MPI_OFFSET MPI_Datatype 0x00000203
@const_ref MPI_PACKED MPI_Datatype 0x00000207
@const_ref MPI_SHORT MPI_Datatype 0x00000208
@const_ref MPI_INT MPI_Datatype 0x00000209
@const_ref MPI_LONG MPI_Datatype 0x0000020a
@const_ref MPI_LONG_LONG MPI_Datatype 0x0000020b
const MPI_LONG_LONG_INT = MPI_LONG_LONG
@const_ref MPI_UNSIGNED_SHORT MPI_Datatype 0x0000020c
@const_ref MPI_UNSIGNED MPI_Datatype 0x0000020d
@const_ref MPI_UNSIGNED_LONG MPI_Datatype 0x0000020e
@const_ref MPI_UNSIGNED_LONG_LONG MPI_Datatype 0x0000020f
@const_ref MPI_FLOAT MPI_Datatype 0x00000210
@const_ref MPI_C_FLOAT_COMPLEX MPI_Datatype 0x00000212
const MPI_C_COMPLEX = MPI_C_FLOAT_COMPLEX
@const_ref MPI_CXX_FLOAT_COMPLEX MPI_Datatype 0x00000213
@const_ref MPI_DOUBLE MPI_Datatype 0x00000214
@const_ref MPI_C_DOUBLE_COMPLEX MPI_Datatype 0x00000216
@const_ref MPI_CXX_DOUBLE_COMPLEX MPI_Datatype 0x00000217
@const_ref MPI_LOGICAL MPI_Datatype 0x00000218
@const_ref MPI_INTEGER MPI_Datatype 0x00000219
@const_ref MPI_REAL MPI_Datatype 0x0000021a
@const_ref MPI_COMPLEX MPI_Datatype 0x0000021b
@const_ref MPI_DOUBLE_PRECISION MPI_Datatype 0x0000021c
@const_ref MPI_DOUBLE_COMPLEX MPI_Datatype 0x0000021d
@const_ref MPI_LONG_DOUBLE MPI_Datatype 0x00000220
@const_ref MPI_C_LONG_DOUBLE_COMPLEX MPI_Datatype 0x00000224
@const_ref MPI_CXX_LONG_DOUBLE_COMPLEX MPI_Datatype 0x00000225
@const_ref MPI_FLOAT_INT MPI_Datatype 0x00000228
@const_ref MPI_DOUBLE_INT MPI_Datatype 0x00000229
@const_ref MPI_LONG_INT MPI_Datatype 0x0000022a
@const_ref MPI_2INT MPI_Datatype 0x0000022b
@const_ref MPI_SHORT_INT MPI_Datatype 0x0000022c
@const_ref MPI_LONG_DOUBLE_INT MPI_Datatype 0x0000022d
@const_ref MPI_2REAL MPI_Datatype 0x00000230
@const_ref MPI_2DOUBLE_PRECISION MPI_Datatype 0x00000231
@const_ref MPI_2INTEGER MPI_Datatype 0x00000232
@const_ref MPI_C_BOOL MPI_Datatype 0x00000238
@const_ref MPI_CXX_BOOL MPI_Datatype 0x00000239
@const_ref MPI_WCHAR MPI_Datatype 0x0000023c
@const_ref MPI_INT8_T MPI_Datatype 0x00000240
@const_ref MPI_UINT8_T MPI_Datatype 0x00000241
@const_ref MPI_CHAR MPI_Datatype 0x00000243
@const_ref MPI_SIGNED_CHAR MPI_Datatype 0x00000244
@const_ref MPI_UNSIGNED_CHAR MPI_Datatype 0x00000245
@const_ref MPI_BYTE MPI_Datatype 0x00000247
@const_ref MPI_INT16_T MPI_Datatype 0x00000248
@const_ref MPI_UINT16_T MPI_Datatype 0x00000249
@const_ref MPI_INT32_T MPI_Datatype 0x00000250
@const_ref MPI_UINT32_T MPI_Datatype 0x00000251
@const_ref MPI_INT64_T MPI_Datatype 0x00000258
@const_ref MPI_UINT64_T MPI_Datatype 0x00000259
@const_ref MPIX_LOGICAL1 MPI_Datatype 0x000002c0
@const_ref MPI_INTEGER1 MPI_Datatype 0x000002c1
@const_ref MPIX_REAL1 MPI_Datatype 0x000002c2
@const_ref MPI_CHARACTER MPI_Datatype 0x000002c3
@const_ref MPIX_LOGICAL2 MPI_Datatype 0x000002c8
@const_ref MPI_INTEGER2 MPI_Datatype 0x000002c9
@const_ref MPI_REAL2 MPI_Datatype 0x000002ca
@const_ref MPIX_LOGICAL4 MPI_Datatype 0x000002d0
@const_ref MPI_INTEGER4 MPI_Datatype 0x000002d1
@const_ref MPI_REAL4 MPI_Datatype 0x000002d2
@const_ref MPI_COMPLEX4 MPI_Datatype 0x000002d3
@const_ref MPIX_LOGICAL8 MPI_Datatype 0x000002d8
@const_ref MPI_INTEGER8 MPI_Datatype 0x000002d9
@const_ref MPI_REAL8 MPI_Datatype 0x000002da
@const_ref MPI_COMPLEX8 MPI_Datatype 0x000002db
@const_ref MPIX_LOGICAL16 MPI_Datatype 0x000002e0
@const_ref MPI_INTEGER16 MPI_Datatype 0x000002e1
@const_ref MPI_REAL16 MPI_Datatype 0x000002e2
@const_ref MPI_COMPLEX16 MPI_Datatype 0x000002e3
@const_ref MPI_COMPLEX32 MPI_Datatype 0x000002eb

# Status indexing - must match MPI_Status definition
@const_ref MPI_F_SOURCE Cint 0
@const_ref MPI_F_TAG Cint 1
@const_ref MPI_F_ERROR Cint 2
# Fortran status array size and reserved index values (in C)
@const_ref MPI_F_STATUS_SIZE Cint 8

# Error classes
@const_ref MPI_SUCCESS Cint 0
@const_ref MPI_ERR_BUFFER Cint 1
@const_ref MPI_ERR_COUNT Cint 2
@const_ref MPI_ERR_TYPE Cint 3
@const_ref MPI_ERR_TAG Cint 4
@const_ref MPI_ERR_COMM Cint 5
@const_ref MPI_ERR_RANK Cint 6
@const_ref MPI_ERR_REQUEST Cint 7
@const_ref MPI_ERR_ROOT Cint 8
@const_ref MPI_ERR_GROUP Cint 9
@const_ref MPI_ERR_OP Cint 10
@const_ref MPI_ERR_TOPOLOGY Cint 11
@const_ref MPI_ERR_DIMS Cint 12
@const_ref MPI_ERR_ARG Cint 13
@const_ref MPI_ERR_UNKNOWN Cint 14
@const_ref MPI_ERR_TRUNCATE Cint 15
@const_ref MPI_ERR_OTHER Cint 16
@const_ref MPI_ERR_INTERN Cint 17
@const_ref MPI_ERR_PENDING Cint 18
@const_ref MPI_ERR_IN_STATUS Cint 19
@const_ref MPI_ERR_ACCESS Cint 20
@const_ref MPI_ERR_AMODE Cint 21
@const_ref MPI_ERR_ASSERT Cint 22
@const_ref MPI_ERR_BAD_FILE Cint 23
@const_ref MPI_ERR_BASE Cint 24
@const_ref MPI_ERR_CONVERSION Cint 25
@const_ref MPI_ERR_DISP Cint 26
@const_ref MPI_ERR_DUP_DATAREP Cint 27
@const_ref MPI_ERR_FILE_EXISTS Cint 28
@const_ref MPI_ERR_FILE_IN_USE Cint 29
@const_ref MPI_ERR_FILE Cint 30
@const_ref MPI_ERR_INFO_KEY Cint 31
@const_ref MPI_ERR_INFO_NOKEY Cint 32
@const_ref MPI_ERR_INFO_VALUE Cint 33
@const_ref MPI_ERR_INFO Cint 34
@const_ref MPI_ERR_IO Cint 35
@const_ref MPI_ERR_KEYVAL Cint 36
@const_ref MPI_ERR_LOCKTYPE Cint 37
@const_ref MPI_ERR_NAME Cint 38
@const_ref MPI_ERR_NO_MEM Cint 39
@const_ref MPI_ERR_NOT_SAME Cint 40
@const_ref MPI_ERR_NO_SPACE Cint 41
@const_ref MPI_ERR_NO_SUCH_FILE Cint 42
@const_ref MPI_ERR_PORT Cint 43
@const_ref MPI_ERR_PROC_ABORTED Cint 44
@const_ref MPI_ERR_QUOTA Cint 45
@const_ref MPI_ERR_READ_ONLY Cint 46
@const_ref MPI_ERR_RMA_ATTACH Cint 47
@const_ref MPI_ERR_RMA_CONFLICT Cint 48
@const_ref MPI_ERR_RMA_RANGE Cint 49
@const_ref MPI_ERR_RMA_SHARED Cint 50
@const_ref MPI_ERR_RMA_SYNC Cint 51
@const_ref MPI_ERR_RMA_FLAVOR Cint 52
@const_ref MPI_ERR_SERVICE Cint 53
@const_ref MPI_ERR_SESSION Cint 54
@const_ref MPI_ERR_SIZE Cint 55
@const_ref MPI_ERR_SPAWN Cint 56
@const_ref MPI_ERR_UNSUPPORTED_DATAREP Cint 57
@const_ref MPI_ERR_UNSUPPORTED_OPERATION Cint 58
@const_ref MPI_ERR_VALUE_TOO_LARGE Cint 59
@const_ref MPI_ERR_WIN Cint 60
@const_ref MPI_ERR_ERRHANDLER Cint 61
@const_ref MPI_T_ERR_CANNOT_INIT Cint 1000
@const_ref MPI_T_ERR_NOT_ACCESSIBLE Cint 1001
@const_ref MPI_T_ERR_NOT_INITIALIZED Cint 1002
@const_ref MPI_T_ERR_NOT_SUPPORTED Cint 1003
@const_ref MPI_T_ERR_MEMORY Cint 1004
@const_ref MPI_T_ERR_INVALID Cint 1005
@const_ref MPI_T_ERR_INVALID_INDEX Cint 1006
@const_ref MPI_T_ERR_INVALID_ITEM Cint 1007
@const_ref MPI_T_ERR_INVALID_SESSION Cint 1008
@const_ref MPI_T_ERR_INVALID_HANDLE Cint 1009
@const_ref MPI_T_ERR_INVALID_NAME Cint 1010
@const_ref MPI_T_ERR_OUT_OF_HANDLES Cint 1011
@const_ref MPI_T_ERR_OUT_OF_SESSIONS Cint 1012
@const_ref MPI_T_ERR_CVAR_SET_NOT_NOW Cint 1013
@const_ref MPI_T_ERR_CVAR_SET_NEVER Cint 1014
@const_ref MPI_T_ERR_PVAR_NO_WRITE Cint 1015
@const_ref MPI_T_ERR_PVAR_NO_STARTSTOP Cint 1016
@const_ref MPI_T_ERR_PVAR_NO_ATOMIC Cint 1017
@const_ref MPI_ERR_LASTCODE Cint 0x3fff

# Buffer Address Constants
@const_ref MPI_BOTTOM Ptr{Cvoid} 0
@const_ref MPI_IN_PLACE Ptr{Cvoid} 1
@const_ref MPI_BUFFER_AUTOMATIC Ptr{Cvoid} 2

# Constants Specifying Empty or Ignored Input
@const_ref MPI_ARGV_NULL Ptr{Cvoid} 0
@const_ref MPI_ARGVS_NULL Ptr{Cvoid} 0
@const_ref MPI_ERRCODES_IGNORE Ptr{Cint} 0
@const_ref MPI_STATUS_IGNORE Ptr{MPI_Status} 0
@const_ref MPI_STATUSES_IGNORE Ptr{MPI_Status} 0
@const_ref MPI_UNWEIGHTED Ptr{Cint} 4
@const_ref MPI_WEIGHTS_EMPTY Ptr{Cint} 5

# Other constants
const MPI_BSEND_OVERHEAD = Cint(512) # MPICH=96, OMPI=128

# String size constants                             
const MPI_MAX_DATAREP_STRING = Cint(128) # MPICH=OMPI=128 (MPICH has it in `mpio.h`)
const MPI_MAX_ERROR_STRING = Cint(512)   # MPICH was bigger
const MPI_MAX_INFO_KEY = Cint(256)       # MPICH was bigger
const MPI_MAX_INFO_VAL = Cint(1024)      # MPICH was bigger
const MPI_MAX_LIBRARY_VERSION_STRING = Cint(8192) # MPICH was bigger
const MPI_MAX_OBJECT_NAME = Cint(128)             # MPICH was bigger
const MPI_MAX_PORT_NAME = Cint(1024)              # OMPI was bigger
const MPI_MAX_PROCESSOR_NAME = Cint(256)          # OMPI was bigger
const MPI_MAX_STRINGTAG_LEN = Cint(1024) # OMPI was bigger (v5.0+)
const MPI_MAX_PSET_NAME_LEN = Cint(512)  # OMPI was bigger (v5.0+)

# Mode Constants
# must be powers-of-2 to support OR-ing
# Files
@const_ref MPI_MODE_APPEND Cint 1
@const_ref MPI_MODE_CREATE Cint 2
@const_ref MPI_MODE_DELETE_ON_CLOSE Cint 4
@const_ref MPI_MODE_EXCL Cint 8
@const_ref MPI_MODE_RDONLY Cint 16
@const_ref MPI_MODE_RDWR Cint 32
@const_ref MPI_MODE_SEQUENTIAL Cint 64
@const_ref MPI_MODE_UNIQUE_OPEN Cint 128
@const_ref MPI_MODE_WRONLY Cint 256
# Windows                            
@const_ref MPI_MODE_NOCHECK Cint 1024
@const_ref MPI_MODE_NOPRECEDE Cint 2048
@const_ref MPI_MODE_NOPUT Cint 4096
@const_ref MPI_MODE_NOSTORE Cint 8192
@const_ref MPI_MODE_NOSUCCEED Cint 16384

# rank sentinels - must be negative
@const_ref MPI_ANY_SOURCE Cint -1
@const_ref MPI_PROC_NULL Cint -2
@const_ref MPI_ROOT Cint -3

# tag sentinels - should be negative
@const_ref MPI_ANY_TAG Cint -31

# attribute constant - should be negative
@const_ref MPI_KEYVAL_INVALID Cint -127

# special displacement for sequential access file - should be negative
@const_ref MPI_DISPLACEMENT_CURRENT Cint -255

# multi-purpose sentinel - must be negative
@const_ref MPI_UNDEFINED Cint -32766 # make it match OMPI and MPICH

# Environmental inquiry keys and Predefined Attribute Keys
# Threads Constants
# These values are monotonic; i.e., SINGLE < FUNNELED < SERIALIZED < MULTIPLE.
@const_ref MPI_THREAD_SINGLE Cint 0
@const_ref MPI_THREAD_FUNNELED Cint 1
@const_ref MPI_THREAD_SERIALIZED Cint 2
@const_ref MPI_THREAD_MULTIPLE Cint 7 # in case we need other threading levels below MULTIPLE

# Array Datatype Order
@const_ref MPI_ORDER_C Cint 0xC # 12
@const_ref MPI_ORDER_FORTRAN Cint 0xF # 15

# Array Datatype Distribution
@const_ref MPI_DISTRIBUTE_NONE Cint 16
@const_ref MPI_DISTRIBUTE_BLOCK Cint 17
@const_ref MPI_DISTRIBUTE_CYCLIC Cint 18
@const_ref MPI_DISTRIBUTE_DFLT_DARG Cint 19

# RMA Lock Constants - arbitrary values
@const_ref MPI_LOCK_SHARED Cint 21
@const_ref MPI_LOCK_EXCLUSIVE Cint 22

# MPI Window Models
@const_ref MPI_WIN_UNIFIED Cint 31
@const_ref MPI_WIN_SEPARATE Cint 32

# MPI Window Create Flavors
@const_ref MPI_WIN_FLAVOR_ALLOCATE Cint 41
@const_ref MPI_WIN_FLAVOR_CREATE Cint 42
@const_ref MPI_WIN_FLAVOR_DYNAMIC Cint 43
@const_ref MPI_WIN_FLAVOR_SHARED Cint 44

# Results of communicator and group comparisons
@const_ref MPI_IDENT Cint 101
@const_ref MPI_CONGRUENT Cint 102
@const_ref MPI_SIMILAR Cint 103
@const_ref MPI_UNEQUAL Cint 104

# MPI_Topo_test
@const_ref MPI_GRAPH Cint 201
@const_ref MPI_DIST_GRAPH Cint 202
@const_ref MPI_CART Cint 203

# Datatype Decoding Constants
@const_ref MPI_COMBINER_NAMED Cint 301
@const_ref MPI_COMBINER_DUP Cint 302
@const_ref MPI_COMBINER_CONTIGUOUS Cint 303
@const_ref MPI_COMBINER_VECTOR Cint 304
@const_ref MPI_COMBINER_HVECTOR Cint 305
@const_ref MPI_COMBINER_INDEXED Cint 306
@const_ref MPI_COMBINER_HINDEXED Cint 307
@const_ref MPI_COMBINER_INDEXED_BLOCK Cint 308
@const_ref MPI_COMBINER_HINDEXED_BLOCK Cint 309
@const_ref MPI_COMBINER_STRUCT Cint 310
@const_ref MPI_COMBINER_SUBARRAY Cint 311
@const_ref MPI_COMBINER_DARRAY Cint 312
@const_ref MPI_COMBINER_F90_REAL Cint 313
@const_ref MPI_COMBINER_F90_COMPLEX Cint 314
@const_ref MPI_COMBINER_F90_INTEGER Cint 315
@const_ref MPI_COMBINER_RESIZED Cint 316
@const_ref MPI_COMBINER_VALUE_INDEX Cint 317

# File Position Constants
@const_ref MPI_SEEK_CUR Cint 601
@const_ref MPI_SEEK_END Cint 602
@const_ref MPI_SEEK_SET Cint 603

# Fortran Datatype Matching Constants
@const_ref MPIX_TYPECLASS_LOGICAL Cint 801
@const_ref MPI_TYPECLASS_INTEGER Cint 802
@const_ref MPI_TYPECLASS_REAL Cint 803
@const_ref MPI_TYPECLASS_COMPLEX Cint 804

# Communicator split type constants - arbitrary values
@const_ref MPI_COMM_TYPE_SHARED Cint 1001
@const_ref MPI_COMM_TYPE_HW_UNGUIDED Cint 1002
@const_ref MPI_COMM_TYPE_HW_GUIDED Cint 1003
@const_ref MPI_COMM_TYPE_RESOURCE_GUIDED Cint 1004

# These apply to MPI_COMM_WORLD
@const_ref MPI_TAG_UB Cint 10001
@const_ref MPI_IO Cint 10002
@const_ref MPI_HOST Cint 10003
@const_ref MPI_WTIME_IS_GLOBAL Cint 10004
@const_ref MPI_APPNUM Cint 10005
@const_ref MPI_LASTUSEDCODE Cint 10006
@const_ref MPI_UNIVERSE_SIZE Cint 10007

# Predefined Attribute Keys
# These apply to Windows
@const_ref MPI_WIN_BASE Cint 20001
@const_ref MPI_WIN_DISP_UNIT Cint 20002
@const_ref MPI_WIN_SIZE Cint 20003
@const_ref MPI_WIN_CREATE_FLAVOR Cint 20004
@const_ref MPI_WIN_MODEL Cint 20005

const MPI_Copy_function = Cvoid
const MPI_Delete_function = Cvoid

const MPI_User_function = Cvoid
const MPI_User_function_c = Cvoid

const MPI_Grequest_cancel_function = Cvoid
const MPI_Grequest_free_function = Cvoid
const MPI_Grequest_query_function = Cvoid

const MPI_Datarep_conversion_function = Cvoid
const MPI_Datarep_extent_function = Cvoid
const MPI_Datarep_conversion_function_c = Cvoid

const MPI_Comm_copy_attr_function = Cvoid
const MPI_Comm_delete_attr_function = Cvoid
const MPI_Type_copy_attr_function = Cvoid
const MPI_Type_delete_attr_function = Cvoid
const MPI_Win_copy_attr_function = Cvoid
const MPI_Win_delete_attr_function = Cvoid

const MPI_Comm_errhandler_function = Cvoid
const MPI_File_errhandler_function = Cvoid
const MPI_Win_errhandler_function = Cvoid
const MPI_Session_errhandler_function = Cvoid

const MPI_Comm_errhandler_fn = MPI_Comm_errhandler_function
const MPI_File_errhandler_fn = MPI_File_errhandler_function
const MPI_Win_errhandler_fn = MPI_Win_errhandler_function
const MPI_Session_errhandler_fn = MPI_Session_errhandler_function

@const_ref MPI_NULL_COPY_FN Ptr{MPI_Copy_function} 0x0
@const_ref MPI_DUP_FN Ptr{MPI_Copy_function} 0x1
@const_ref MPI_NULL_DELETE_FN Ptr{MPI_Delete_function} 0x0
@const_ref MPI_COMM_NULL_COPY_FN Ptr{MPI_Comm_copy_attr_function} 0x0
@const_ref MPI_COMM_DUP_FN Ptr{MPI_Comm_copy_attr_function} 0x1
@const_ref MPI_COMM_NULL_DELETE_FN Ptr{MPI_Comm_delete_attr_function} 0x0
@const_ref MPI_TYPE_NULL_COPY_FN Ptr{MPI_Type_copy_attr_function} 0x0
@const_ref MPI_TYPE_DUP_FN Ptr{MPI_Type_copy_attr_function} 0x1
@const_ref MPI_TYPE_NULL_DELETE_FN Ptr{MPI_Type_delete_attr_function} 0x0
@const_ref MPI_WIN_NULL_COPY_FN Ptr{MPI_Win_copy_attr_function} 0x0
@const_ref MPI_WIN_DUP_FN Ptr{MPI_Win_copy_attr_function} 0x1
@const_ref MPI_WIN_NULL_DELETE_FN Ptr{MPI_Win_delete_attr_function} 0x0
@const_ref MPI_CONVERSION_FN_NULL Ptr{MPI_Datarep_conversion_function} 0x0
@const_ref MPI_CONVERSION_FN_NULL_C Ptr{MPI_Datarep_conversion_function_c} 0x0
