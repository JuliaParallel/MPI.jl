# https://github.com/eschnett/MPItrampoline/mpi.h
# https://github.com/eschnett/MPItrampoline/mpi-constants.inc

getsym(T, sym) = unsafe_load(cglobal((sym, libmpi), T))

# Simple types

const MPI_Aint = Clong
const MPI_Count = Clonglong
const MPI_Fint = Cint
const MPI_Offset = Clonglong
@assert sizeof(MPI_Aint) == sizeof(Ptr)
@assert sizeof(MPI_Count) == 8
@assert sizeof(MPI_Fint) == 4
@assert sizeof(MPI_Offset) == 8

# Handles

const MPI_Comm = Culong
const MPI_Datatype = Culong
const MPI_Errhandler = Culong
const MPI_File = Culong
const MPI_Group = Culong
const MPI_Info = Culong
const MPI_Message = Culong
const MPI_Op = Culong
const MPI_Request = Culong
const MPI_Win = Culong
@assert sizeof(MPI_Comm) == sizeof(Ptr)

# Status

const MPI_Status_Source_offset = 4 * (sizeof(Ptr) == 8 ? 6 : 5)
const MPI_Status_Tag_offset = 4 * (sizeof(Ptr) == 8 ? 7 : 6)
const MPI_Status_Error_offset = 4 * (sizeof(Ptr) == 8 ? 8 : 7)
const MPI_Status_size = 4 * (sizeof(Ptr) == 8 ? 10 : 8)

# Constants

const MPI_ANY_SOURCE = getsym(Cint, "MPI_ANY_SOURCE")
const MPI_ANY_TAG    = getsym(Cint, "MPI_ANY_TAG")
const MPI_PROC_NULL  = getsym(Cint, "MPI_PROC_NULL")
const MPI_ROOT       = getsym(Cint, "MPI_ROOT")

const MPI_CART       = getsym(Cint, "MPI_CART")
const MPI_DIST_GRAPH = getsym(Cint, "MPI_DIST_GRAPH")
const MPI_GRAPH      = getsym(Cint, "MPI_GRAPH")

# Results of compare operations
const MPI_CONGRUENT = getsym(Cint, "MPI_CONGRUENT")
const MPI_IDENT     = getsym(Cint, "MPI_IDENT")
const MPI_SIMILAR   = getsym(Cint, "MPI_SIMILAR")
const MPI_UNEQUAL   = getsym(Cint, "MPI_UNEQUAL")

# Predefined constants
const MPI_KEYVAL_INVALID = getsym(Cint, "MPI_KEYVAL_INVALID")
const MPI_UNDEFINED      = getsym(Cint, "MPI_UNDEFINED")

# Key values
const MPI_APPNUM            = getsym(Cint, "MPI_APPNUM")
const MPI_HOST              = getsym(Cint, "MPI_HOST")
const MPI_IO                = getsym(Cint, "MPI_IO")
const MPI_LASTUSEDCODE      = getsym(Cint, "MPI_LASTUSEDCODE")
const MPI_TAG_UB            = getsym(Cint, "MPI_TAG_UB")
const MPI_UNIVERSE_SIZE     = getsym(Cint, "MPI_UNIVERSE_SIZE")
const MPI_WIN_BASE          = getsym(Cint, "MPI_WIN_BASE")
const MPI_WIN_CREATE_FLAVOR = getsym(Cint, "MPI_WIN_CREATE_FLAVOR")
const MPI_WIN_DISP_UNIT     = getsym(Cint, "MPI_WIN_DISP_UNIT")
const MPI_WIN_MODEL         = getsym(Cint, "MPI_WIN_MODEL")
const MPI_WIN_SIZE          = getsym(Cint, "MPI_WIN_SIZE")
const MPI_WTIME_IS_GLOBAL   = getsym(Cint, "MPI_WTIME_IS_GLOBAL")

const MPI_COMBINER_CONTIGUOUS     = getsym(Cint, "MPI_COMBINER_CONTIGUOUS")
const MPI_COMBINER_DARRAY         = getsym(Cint, "MPI_COMBINER_DARRAY")
const MPI_COMBINER_DUP            = getsym(Cint, "MPI_COMBINER_DUP")
const MPI_COMBINER_F90_COMPLEX    = getsym(Cint, "MPI_COMBINER_F90_COMPLEX")
const MPI_COMBINER_F90_INTEGER    = getsym(Cint, "MPI_COMBINER_F90_INTEGER")
const MPI_COMBINER_F90_REAL       = getsym(Cint, "MPI_COMBINER_F90_REAL")
const MPI_COMBINER_HINDEXED       = getsym(Cint, "MPI_COMBINER_HINDEXED")
const MPI_COMBINER_HINDEXED_BLOCK = getsym(Cint, "MPI_COMBINER_HINDEXED_BLOCK")
const MPI_COMBINER_HVECTOR        = getsym(Cint, "MPI_COMBINER_HVECTOR")
const MPI_COMBINER_INDEXED        = getsym(Cint, "MPI_COMBINER_INDEXED")
const MPI_COMBINER_INDEXED_BLOCK  = getsym(Cint, "MPI_COMBINER_INDEXED_BLOCK")
const MPI_COMBINER_NAMED          = getsym(Cint, "MPI_COMBINER_NAMED")
const MPI_COMBINER_RESIZED        = getsym(Cint, "MPI_COMBINER_RESIZED")
const MPI_COMBINER_STRUCT         = getsym(Cint, "MPI_COMBINER_STRUCT")
const MPI_COMBINER_SUBARRAY       = getsym(Cint, "MPI_COMBINER_SUBARRAY")
const MPI_COMBINER_VECTOR         = getsym(Cint, "MPI_COMBINER_VECTOR")

const MPI_COMM_TYPE_SHARED = getsym(Cint, "MPI_COMM_TYPE_SHARED")

# File operation constants
const MPI_DISTRIBUTE_BLOCK  = getsym(Cint, "MPI_DISTRIBUTE_BLOCK")
const MPI_DISTRIBUTE_CYCLIC = getsym(Cint, "MPI_DISTRIBUTE_CYCLIC")
const MPI_DISTRIBUTE_NONE   = getsym(Cint, "MPI_DISTRIBUTE_NONE")

const MPI_ERR_ACCESS                 = getsym(Cint, "MPI_ERR_ACCESS")
const MPI_ERR_AMODE                  = getsym(Cint, "MPI_ERR_AMODE")
const MPI_ERR_ARG                    = getsym(Cint, "MPI_ERR_ARG")
const MPI_ERR_ASSERT                 = getsym(Cint, "MPI_ERR_ASSERT")
const MPI_ERR_BAD_FILE               = getsym(Cint, "MPI_ERR_BAD_FILE")
const MPI_ERR_BASE                   = getsym(Cint, "MPI_ERR_BASE")
const MPI_ERR_BUFFER                 = getsym(Cint, "MPI_ERR_BUFFER")
const MPI_ERR_COMM                   = getsym(Cint, "MPI_ERR_COMM")
const MPI_ERR_CONVERSION             = getsym(Cint, "MPI_ERR_CONVERSION")
const MPI_ERR_COUNT                  = getsym(Cint, "MPI_ERR_COUNT")
const MPI_ERR_DIMS                   = getsym(Cint, "MPI_ERR_DIMS")
const MPI_ERR_DISP                   = getsym(Cint, "MPI_ERR_DISP")
const MPI_ERR_DUP_DATAREP            = getsym(Cint, "MPI_ERR_DUP_DATAREP")
const MPI_ERR_FILE                   = getsym(Cint, "MPI_ERR_FILE")
const MPI_ERR_FILE_EXISTS            = getsym(Cint, "MPI_ERR_FILE_EXISTS")
const MPI_ERR_FILE_IN_USE            = getsym(Cint, "MPI_ERR_FILE_IN_USE")
const MPI_ERR_GROUP                  = getsym(Cint, "MPI_ERR_GROUP")
const MPI_ERR_INFO                   = getsym(Cint, "MPI_ERR_INFO")
const MPI_ERR_INFO_KEY               = getsym(Cint, "MPI_ERR_INFO_KEY")
const MPI_ERR_INFO_NOKEY             = getsym(Cint, "MPI_ERR_INFO_NOKEY")
const MPI_ERR_INFO_VALUE             = getsym(Cint, "MPI_ERR_INFO_VALUE")
const MPI_ERR_INTERN                 = getsym(Cint, "MPI_ERR_INTERN")
const MPI_ERR_IN_STATUS              = getsym(Cint, "MPI_ERR_IN_STATUS")
const MPI_ERR_IO                     = getsym(Cint, "MPI_ERR_IO")
const MPI_ERR_KEYVAL                 = getsym(Cint, "MPI_ERR_KEYVAL")
const MPI_ERR_LASTCODE               = getsym(Cint, "MPI_ERR_LASTCODE")
const MPI_ERR_LOCKTYPE               = getsym(Cint, "MPI_ERR_LOCKTYPE")
const MPI_ERR_NAME                   = getsym(Cint, "MPI_ERR_NAME")
const MPI_ERR_NOT_SAME               = getsym(Cint, "MPI_ERR_NOT_SAME")
const MPI_ERR_NO_MEM                 = getsym(Cint, "MPI_ERR_NO_MEM")
const MPI_ERR_NO_SPACE               = getsym(Cint, "MPI_ERR_NO_SPACE")
const MPI_ERR_NO_SUCH_FILE           = getsym(Cint, "MPI_ERR_NO_SUCH_FILE")
const MPI_ERR_OP                     = getsym(Cint, "MPI_ERR_OP")
const MPI_ERR_OTHER                  = getsym(Cint, "MPI_ERR_OTHER")
const MPI_ERR_PENDING                = getsym(Cint, "MPI_ERR_PENDING")
const MPI_ERR_PORT                   = getsym(Cint, "MPI_ERR_PORT")
const MPI_ERR_QUOTA                  = getsym(Cint, "MPI_ERR_QUOTA")
const MPI_ERR_RANK                   = getsym(Cint, "MPI_ERR_RANK")
const MPI_ERR_READ_ONLY              = getsym(Cint, "MPI_ERR_READ_ONLY")
const MPI_ERR_REQUEST                = getsym(Cint, "MPI_ERR_REQUEST")
const MPI_ERR_RMA_ATTACH             = getsym(Cint, "MPI_ERR_RMA_ATTACH")
const MPI_ERR_RMA_CONFLICT           = getsym(Cint, "MPI_ERR_RMA_CONFLICT")
const MPI_ERR_RMA_FLAVOR             = getsym(Cint, "MPI_ERR_RMA_FLAVOR")
const MPI_ERR_RMA_RANGE              = getsym(Cint, "MPI_ERR_RMA_RANGE")
const MPI_ERR_RMA_SHARED             = getsym(Cint, "MPI_ERR_RMA_SHARED")
const MPI_ERR_RMA_SYNC               = getsym(Cint, "MPI_ERR_RMA_SYNC")
const MPI_ERR_ROOT                   = getsym(Cint, "MPI_ERR_ROOT")
const MPI_ERR_SERVICE                = getsym(Cint, "MPI_ERR_SERVICE")
const MPI_ERR_SIZE                   = getsym(Cint, "MPI_ERR_SIZE")
const MPI_ERR_SPAWN                  = getsym(Cint, "MPI_ERR_SPAWN")
const MPI_ERR_TAG                    = getsym(Cint, "MPI_ERR_TAG")
const MPI_ERR_TOPOLOGY               = getsym(Cint, "MPI_ERR_TOPOLOGY")
const MPI_ERR_TRUNCATE               = getsym(Cint, "MPI_ERR_TRUNCATE")
const MPI_ERR_TYPE                   = getsym(Cint, "MPI_ERR_TYPE")
const MPI_ERR_UNKNOWN                = getsym(Cint, "MPI_ERR_UNKNOWN")
const MPI_ERR_UNSUPPORTED_DATAREP    = getsym(Cint, "MPI_ERR_UNSUPPORTED_DATAREP")
const MPI_ERR_UNSUPPORTED_OPERATION  = getsym(Cint, "MPI_ERR_UNSUPPORTED_OPERATION")
const MPI_ERR_WIN                    = getsym(Cint, "MPI_ERR_WIN")
const MPI_SUCCESS                    = getsym(Cint, "MPI_SUCCESS")

const MPI_LOCK_EXCLUSIVE = getsym(Cint, "MPI_LOCK_EXCLUSIVE")
const MPI_LOCK_SHARED    = getsym(Cint, "MPI_LOCK_SHARED")

const MPI_MODE_APPEND          = getsym(Cint, "MPI_MODE_APPEND")
const MPI_MODE_CREATE          = getsym(Cint, "MPI_MODE_CREATE")
const MPI_MODE_DELETE_ON_CLOSE = getsym(Cint, "MPI_MODE_DELETE_ON_CLOSE")
const MPI_MODE_EXCL            = getsym(Cint, "MPI_MODE_EXCL")
const MPI_MODE_NOCHECK         = getsym(Cint, "MPI_MODE_NOCHECK")
const MPI_MODE_NOPRECEDE       = getsym(Cint, "MPI_MODE_NOPRECEDE")
const MPI_MODE_NOPUT           = getsym(Cint, "MPI_MODE_NOPUT")
const MPI_MODE_NOSTORE         = getsym(Cint, "MPI_MODE_NOSTORE")
const MPI_MODE_NOSUCCEED       = getsym(Cint, "MPI_MODE_NOSUCCEED")
const MPI_MODE_RDONLY          = getsym(Cint, "MPI_MODE_RDONLY")
const MPI_MODE_RDWR            = getsym(Cint, "MPI_MODE_RDWR")
const MPI_MODE_SEQUENTIAL      = getsym(Cint, "MPI_MODE_SEQUENTIAL")
const MPI_MODE_UNIQUE_OPEN     = getsym(Cint, "MPI_MODE_UNIQUE_OPEN")
const MPI_MODE_WRONLY          = getsym(Cint, "MPI_MODE_WRONLY")

# File operation constants
const MPI_ORDER_C       = getsym(Cint, "MPI_ORDER_C")
const MPI_ORDER_FORTRAN = getsym(Cint, "MPI_ORDER_FORTRAN")

# File operation constants
const MPI_SEEK_CUR = getsym(Cint, "MPI_SEEK_CUR")
const MPI_SEEK_END = getsym(Cint, "MPI_SEEK_END")
const MPI_SEEK_SET = getsym(Cint, "MPI_SEEK_SET")

const MPI_THREAD_SINGLE     = getsym(Cint, "MPI_THREAD_SINGLE")
const MPI_THREAD_FUNNELED   = getsym(Cint, "MPI_THREAD_FUNNELED")
const MPI_THREAD_SERIALIZED = getsym(Cint, "MPI_THREAD_SERIALIZED")
const MPI_THREAD_MULTIPLE   = getsym(Cint, "MPI_THREAD_MULTIPLE")

const MPI_UNWEIGHTED    = getsym(Ptr{Cint}, "MPI_UNWEIGHTED")
const MPI_WEIGHTS_EMPTY = getsym(Ptr{Cint}, "MPI_WEIGHTS_EMPTY")

# const MPI_BOTTOM = getsym(Ptr{Cvoid}, "MPI_BOTTOM")
const MPI_BOTTOM = reinterpret(SentinelPtr, 0)

# const MPI_IN_PLACE = getsym(Ptr{Cvoid}, "MPI_IN_PLACE")
const MPI_IN_PLACE = reinterpret(SentinelPtr, 1)

const MPI_COMM_NULL  = getsym(MPI_Comm, "MPI_COMM_NULL")
const MPI_COMM_SELF  = getsym(MPI_Comm, "MPI_COMM_SELF")
const MPI_COMM_WORLD = getsym(MPI_Comm, "MPI_COMM_WORLD")

const MPI_2DOUBLE_PRECISION       = getsym(MPI_Datatype, "MPI_2DOUBLE_PRECISION")
const MPI_2INT                    = getsym(MPI_Datatype, "MPI_2INT")
const MPI_2INTEGER                = getsym(MPI_Datatype, "MPI_2INTEGER")
const MPI_2REAL                   = getsym(MPI_Datatype, "MPI_2REAL")
const MPI_AINT                    = getsym(MPI_Datatype, "MPI_AINT")
const MPI_BYTE                    = getsym(MPI_Datatype, "MPI_BYTE")
const MPI_CHAR                    = getsym(MPI_Datatype, "MPI_CHAR")
const MPI_CHARACTER               = getsym(MPI_Datatype, "MPI_CHARACTER")
const MPI_COMPLEX                 = getsym(MPI_Datatype, "MPI_COMPLEX")
const MPI_COMPLEX16               = getsym(MPI_Datatype, "MPI_COMPLEX16")
const MPI_COMPLEX32               = getsym(MPI_Datatype, "MPI_COMPLEX32")
const MPI_COMPLEX8                = getsym(MPI_Datatype, "MPI_COMPLEX8")
const MPI_COUNT                   = getsym(MPI_Datatype, "MPI_COUNT")
const MPI_CXX_BOOL                = getsym(MPI_Datatype, "MPI_CXX_BOOL")
const MPI_CXX_DOUBLE_COMPLEX      = getsym(MPI_Datatype, "MPI_CXX_DOUBLE_COMPLEX")
const MPI_CXX_FLOAT_COMPLEX       = getsym(MPI_Datatype, "MPI_CXX_FLOAT_COMPLEX")
const MPI_CXX_LONG_DOUBLE_COMPLEX = getsym(MPI_Datatype, "MPI_CXX_LONG_DOUBLE_COMPLEX")
const MPI_C_BOOL                  = getsym(MPI_Datatype, "MPI_C_BOOL")
const MPI_C_COMPLEX               = getsym(MPI_Datatype, "MPI_C_COMPLEX")
const MPI_C_DOUBLE_COMPLEX        = getsym(MPI_Datatype, "MPI_C_DOUBLE_COMPLEX")
const MPI_C_FLOAT_COMPLEX         = getsym(MPI_Datatype, "MPI_C_FLOAT_COMPLEX")
const MPI_C_LONG_DOUBLE_COMPLEX   = getsym(MPI_Datatype, "MPI_C_LONG_DOUBLE_COMPLEX")
const MPI_DATATYPE_NULL           = getsym(MPI_Datatype, "MPI_DATATYPE_NULL")
const MPI_DOUBLE                  = getsym(MPI_Datatype, "MPI_DOUBLE")
const MPI_DOUBLE_COMPLEX          = getsym(MPI_Datatype, "MPI_DOUBLE_COMPLEX")
const MPI_DOUBLE_INT              = getsym(MPI_Datatype, "MPI_DOUBLE_INT")
const MPI_DOUBLE_PRECISION        = getsym(MPI_Datatype, "MPI_DOUBLE_PRECISION")
const MPI_FLOAT                   = getsym(MPI_Datatype, "MPI_FLOAT")
const MPI_FLOAT_INT               = getsym(MPI_Datatype, "MPI_FLOAT_INT")
const MPI_INT                     = getsym(MPI_Datatype, "MPI_INT")
const MPI_INT16_T                 = getsym(MPI_Datatype, "MPI_INT16_T")
const MPI_INT32_T                 = getsym(MPI_Datatype, "MPI_INT32_T")
const MPI_INT64_T                 = getsym(MPI_Datatype, "MPI_INT64_T")
const MPI_INT8_T                  = getsym(MPI_Datatype, "MPI_INT8_T")
const MPI_INTEGER                 = getsym(MPI_Datatype, "MPI_INTEGER")
const MPI_INTEGER1                = getsym(MPI_Datatype, "MPI_INTEGER1")
const MPI_INTEGER2                = getsym(MPI_Datatype, "MPI_INTEGER2")
const MPI_INTEGER4                = getsym(MPI_Datatype, "MPI_INTEGER4")
const MPI_INTEGER8                = getsym(MPI_Datatype, "MPI_INTEGER8")
const MPI_LOGICAL                 = getsym(MPI_Datatype, "MPI_LOGICAL")
const MPI_LONG                    = getsym(MPI_Datatype, "MPI_LONG")
const MPI_LONG_DOUBLE             = getsym(MPI_Datatype, "MPI_LONG_DOUBLE")
const MPI_LONG_DOUBLE_INT         = getsym(MPI_Datatype, "MPI_LONG_DOUBLE_INT")
const MPI_LONG_INT                = getsym(MPI_Datatype, "MPI_LONG_INT")
const MPI_LONG_LONG               = getsym(MPI_Datatype, "MPI_LONG_LONG")
const MPI_LONG_LONG_INT           = getsym(MPI_Datatype, "MPI_LONG_LONG_INT")
const MPI_OFFSET                  = getsym(MPI_Datatype, "MPI_OFFSET")
const MPI_PACKED                  = getsym(MPI_Datatype, "MPI_PACKED")
const MPI_REAL                    = getsym(MPI_Datatype, "MPI_REAL")
const MPI_REAL16                  = getsym(MPI_Datatype, "MPI_REAL16")
const MPI_REAL4                   = getsym(MPI_Datatype, "MPI_REAL4")
const MPI_REAL8                   = getsym(MPI_Datatype, "MPI_REAL8")
const MPI_SHORT                   = getsym(MPI_Datatype, "MPI_SHORT")
const MPI_SHORT_INT               = getsym(MPI_Datatype, "MPI_SHORT_INT")
const MPI_SIGNED_CHAR             = getsym(MPI_Datatype, "MPI_SIGNED_CHAR")
const MPI_UINT16_T                = getsym(MPI_Datatype, "MPI_UINT16_T")
const MPI_UINT32_T                = getsym(MPI_Datatype, "MPI_UINT32_T")
const MPI_UINT64_T                = getsym(MPI_Datatype, "MPI_UINT64_T")
const MPI_UINT8_T                 = getsym(MPI_Datatype, "MPI_UINT8_T")
const MPI_UNSIGNED                = getsym(MPI_Datatype, "MPI_UNSIGNED")
const MPI_UNSIGNED_CHAR           = getsym(MPI_Datatype, "MPI_UNSIGNED_CHAR")
const MPI_UNSIGNED_LONG           = getsym(MPI_Datatype, "MPI_UNSIGNED_LONG")
const MPI_UNSIGNED_LONG_LONG      = getsym(MPI_Datatype, "MPI_UNSIGNED_LONG_LONG")
const MPI_UNSIGNED_SHORT          = getsym(MPI_Datatype, "MPI_UNSIGNED_SHORT")
const MPI_WCHAR                   = getsym(MPI_Datatype, "MPI_WCHAR")

const MPI_ERRHANDLER_NULL  = getsym(MPI_Errhandler, "MPI_ERRHANDLER_NULL")
const MPI_ERRORS_ARE_FATAL = getsym(MPI_Errhandler, "MPI_ERRORS_ARE_FATAL")
const MPI_ERRORS_RETURN    = getsym(MPI_Errhandler, "MPI_ERRORS_RETURN")

const MPI_FILE_NULL = getsym(MPI_File, "MPI_FILE_NULL")
 
const MPI_GROUP_EMPTY = getsym(MPI_Group, "MPI_GROUP_EMPTY")
const MPI_GROUP_NULL  = getsym(MPI_Group, "MPI_GROUP_NULL")

const MPI_INFO_ENV  = getsym(MPI_Info, "MPI_INFO_ENV")
const MPI_INFO_NULL = getsym(MPI_Info, "MPI_INFO_NULL")

const MPI_MESSAGE_NO_PROC = getsym(MPI_Message, "MPI_MESSAGE_NO_PROC")
const MPI_MESSAGE_NULL    = getsym(MPI_Message, "MPI_MESSAGE_NULL")

const MPI_BAND    = getsym(MPI_Op, "MPI_BAND")
const MPI_BOR     = getsym(MPI_Op, "MPI_BOR")
const MPI_BXOR    = getsym(MPI_Op, "MPI_BXOR")
const MPI_LAND    = getsym(MPI_Op, "MPI_LAND")
const MPI_LOR     = getsym(MPI_Op, "MPI_LOR")
const MPI_LXOR    = getsym(MPI_Op, "MPI_LXOR")
const MPI_MAX     = getsym(MPI_Op, "MPI_MAX")
const MPI_MAXLOC  = getsym(MPI_Op, "MPI_MAXLOC")
const MPI_MIN     = getsym(MPI_Op, "MPI_MIN")
const MPI_MINLOC  = getsym(MPI_Op, "MPI_MINLOC")
const MPI_NO_OP   = getsym(MPI_Op, "MPI_NO_OP")
const MPI_OP_NULL = getsym(MPI_Op, "MPI_OP_NULL")
const MPI_PROD    = getsym(MPI_Op, "MPI_PROD")
const MPI_REPLACE = getsym(MPI_Op, "MPI_REPLACE")
const MPI_SUM     = getsym(MPI_Op, "MPI_SUM")

const MPI_REQUEST_NULL = getsym(MPI_Request, "MPI_REQUEST_NULL")

# const MPI_STATUS_IGNORE   = getsym(Ptr{MPI_Status}, "MPI_STATUS_IGNORE")
# const MPI_STATUSES_IGNORE = getsym(Ptr{MPI_Status}, "MPI_STATUSES_IGNORE")
const MPI_STATUS_IGNORE = reinterpret(SentinelPtr, 0)
const MPI_STATUSES_IGNORE = reinterpret(SentinelPtr, 0)

const MPI_WIN_NULL = getsym(MPI_Win, "MPI_WIN_NULL")
