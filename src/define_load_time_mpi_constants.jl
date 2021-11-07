# This only declares these constants with dummy values. They are
# initialized at run time in the file
# `read_load_time_mpi_constants.jl`.

# These functions are run after reading the values of the constants below
const mpi_load_time_hooks = Any[]
add_load_time_hook!(f) = push!(mpi_load_time_hooks, f)
function run_load_time_hooks()
    for hook in mpi_load_time_hooks
        hook()
    end
    empty!(mpi_load_time_hooks)
    nothing
end
const finished_loading = Ref(false)

# We want to be able to use these values for comparisons while
# precompiling, so they should all be different
_mpi_val_counter = 1

global MPI_ANY_SOURCE = Cint(-(_mpi_val_counter += 1))
global MPI_ANY_TAG = Cint(-(_mpi_val_counter += 1))
global MPI_PROC_NULL = Cint(-(_mpi_val_counter += 1))
global MPI_ROOT = Cint(-(_mpi_val_counter += 1))
global MPI_CART = Cint(-(_mpi_val_counter += 1))
global MPI_DIST_GRAPH = Cint(-(_mpi_val_counter += 1))
global MPI_GRAPH = Cint(-(_mpi_val_counter += 1))
global MPI_CONGRUENT = Cint(-(_mpi_val_counter += 1))
global MPI_IDENT = Cint(-(_mpi_val_counter += 1))
global MPI_SIMILAR = Cint(-(_mpi_val_counter += 1))
global MPI_UNEQUAL = Cint(-(_mpi_val_counter += 1))
global MPI_KEYVAL_INVALID = Cint(-(_mpi_val_counter += 1))
global MPI_UNDEFINED = Cint(-(_mpi_val_counter += 1))
global MPI_APPNUM = Cint(-(_mpi_val_counter += 1))
global MPI_HOST = Cint(-(_mpi_val_counter += 1))
global MPI_IO = Cint(-(_mpi_val_counter += 1))
global MPI_LASTUSEDCODE = Cint(-(_mpi_val_counter += 1))
global MPI_TAG_UB = Cint(-(_mpi_val_counter += 1))
global MPI_UNIVERSE_SIZE = Cint(-(_mpi_val_counter += 1))
global MPI_WIN_BASE = Cint(-(_mpi_val_counter += 1))
global MPI_WIN_CREATE_FLAVOR = Cint(-(_mpi_val_counter += 1))
global MPI_WIN_DISP_UNIT = Cint(-(_mpi_val_counter += 1))
global MPI_WIN_MODEL = Cint(-(_mpi_val_counter += 1))
global MPI_WIN_SIZE = Cint(-(_mpi_val_counter += 1))
global MPI_WTIME_IS_GLOBAL = Cint(-(_mpi_val_counter += 1))
global MPI_COMBINER_CONTIGUOUS = Cint(-(_mpi_val_counter += 1))
global MPI_COMBINER_DARRAY = Cint(-(_mpi_val_counter += 1))
global MPI_COMBINER_DUP = Cint(-(_mpi_val_counter += 1))
global MPI_COMBINER_F90_COMPLEX = Cint(-(_mpi_val_counter += 1))
global MPI_COMBINER_F90_INTEGER = Cint(-(_mpi_val_counter += 1))
global MPI_COMBINER_F90_REAL = Cint(-(_mpi_val_counter += 1))
global MPI_COMBINER_HINDEXED = Cint(-(_mpi_val_counter += 1))
global MPI_COMBINER_HINDEXED_BLOCK = Cint(-(_mpi_val_counter += 1))
global MPI_COMBINER_HVECTOR = Cint(-(_mpi_val_counter += 1))
global MPI_COMBINER_INDEXED = Cint(-(_mpi_val_counter += 1))
global MPI_COMBINER_INDEXED_BLOCK = Cint(-(_mpi_val_counter += 1))
global MPI_COMBINER_NAMED = Cint(-(_mpi_val_counter += 1))
global MPI_COMBINER_RESIZED = Cint(-(_mpi_val_counter += 1))
global MPI_COMBINER_STRUCT = Cint(-(_mpi_val_counter += 1))
global MPI_COMBINER_SUBARRAY = Cint(-(_mpi_val_counter += 1))
global MPI_COMBINER_VECTOR = Cint(-(_mpi_val_counter += 1))
global MPI_COMM_TYPE_SHARED = Cint(-(_mpi_val_counter += 1))
global MPI_DISTRIBUTE_BLOCK = Cint(-(_mpi_val_counter += 1))
global MPI_DISTRIBUTE_CYCLIC = Cint(-(_mpi_val_counter += 1))
global MPI_DISTRIBUTE_NONE = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_ACCESS = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_AMODE = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_ARG = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_ASSERT = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_BAD_FILE = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_BASE = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_BUFFER = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_COMM = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_CONVERSION = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_COUNT = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_DIMS = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_DISP = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_DUP_DATAREP = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_FILE = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_FILE_EXISTS = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_FILE_IN_USE = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_GROUP = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_INFO = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_INFO_KEY = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_INFO_NOKEY = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_INFO_VALUE = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_INTERN = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_IN_STATUS = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_IO = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_KEYVAL = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_LASTCODE = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_LOCKTYPE = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_NAME = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_NOT_SAME = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_NO_MEM = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_NO_SPACE = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_NO_SUCH_FILE = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_OP = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_OTHER = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_PENDING = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_PORT = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_QUOTA = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_RANK = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_READ_ONLY = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_REQUEST = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_RMA_ATTACH = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_RMA_CONFLICT = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_RMA_FLAVOR = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_RMA_RANGE = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_RMA_SHARED = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_RMA_SYNC = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_ROOT = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_SERVICE = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_SIZE = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_SPAWN = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_TAG = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_TOPOLOGY = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_TRUNCATE = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_TYPE = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_UNKNOWN = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_UNSUPPORTED_DATAREP = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_UNSUPPORTED_OPERATION = Cint(-(_mpi_val_counter += 1))
global MPI_ERR_WIN = Cint(-(_mpi_val_counter += 1))
# We special-case MPI_SUCCESS which is required to be 0
# global MPI_SUCCESS = Cint(-(_mpi_val_counter += 1))
const MPI_SUCCESS = Cint(0)
global MPI_LOCK_EXCLUSIVE = Cint(-(_mpi_val_counter += 1))
global MPI_LOCK_SHARED = Cint(-(_mpi_val_counter += 1))
global MPI_MODE_APPEND = Cint(-(_mpi_val_counter += 1))
global MPI_MODE_CREATE = Cint(-(_mpi_val_counter += 1))
global MPI_MODE_DELETE_ON_CLOSE = Cint(-(_mpi_val_counter += 1))
global MPI_MODE_EXCL = Cint(-(_mpi_val_counter += 1))
global MPI_MODE_NOCHECK = Cint(-(_mpi_val_counter += 1))
global MPI_MODE_NOPRECEDE = Cint(-(_mpi_val_counter += 1))
global MPI_MODE_NOPUT = Cint(-(_mpi_val_counter += 1))
global MPI_MODE_NOSTORE = Cint(-(_mpi_val_counter += 1))
global MPI_MODE_NOSUCCEED = Cint(-(_mpi_val_counter += 1))
global MPI_MODE_RDONLY = Cint(-(_mpi_val_counter += 1))
global MPI_MODE_RDWR = Cint(-(_mpi_val_counter += 1))
global MPI_MODE_SEQUENTIAL = Cint(-(_mpi_val_counter += 1))
global MPI_MODE_UNIQUE_OPEN = Cint(-(_mpi_val_counter += 1))
global MPI_MODE_WRONLY = Cint(-(_mpi_val_counter += 1))
global MPI_ORDER_C = Cint(-(_mpi_val_counter += 1))
global MPI_ORDER_FORTRAN = Cint(-(_mpi_val_counter += 1))
global MPI_SEEK_CUR = Cint(-(_mpi_val_counter += 1))
global MPI_SEEK_END = Cint(-(_mpi_val_counter += 1))
global MPI_SEEK_SET = Cint(-(_mpi_val_counter += 1))
global MPI_THREAD_SINGLE = Cint(-(_mpi_val_counter += 1))
global MPI_THREAD_FUNNELED = Cint(-(_mpi_val_counter += 1))
global MPI_THREAD_SERIALIZED = Cint(-(_mpi_val_counter += 1))
global MPI_THREAD_MULTIPLE = Cint(-(_mpi_val_counter += 1))
global MPI_TYPECLASS_COMPLEX = Cint(-(_mpi_val_counter += 1))
global MPI_TYPECLASS_INTEGER = Cint(-(_mpi_val_counter += 1))
global MPI_TYPECLASS_REAL = Cint(-(_mpi_val_counter += 1))

global MPI_ARGV_NULL = C_NULL
global MPI_ARGVS_NULL = C_NULL
global MPI_UNWEIGHTED = C_NULL
global MPI_WEIGHTS_EMPTY = C_NULL
global MPI_BOTTOM = C_NULL
global MPI_IN_PLACE = C_NULL

global MPI_COMM_NULL = MPI_Comm(_mpi_val_counter += 1)
global MPI_COMM_SELF = MPI_Comm(_mpi_val_counter += 1)
global MPI_COMM_WORLD = MPI_Comm(_mpi_val_counter += 1)

global MPI_COMM_DUP_FN = C_NULL

global MPI_COMM_NULL_COPY_FN = C_NULL

global MPI_COMM_NULL_DELETE_FN = C_NULL

global MPI_NULL_COPY_FN = C_NULL

global MPI_2DOUBLE_PRECISION = MPI_Datatype(_mpi_val_counter += 1)
global MPI_2INT = MPI_Datatype(_mpi_val_counter += 1)
global MPI_2INTEGER = MPI_Datatype(_mpi_val_counter += 1)
global MPI_2REAL = MPI_Datatype(_mpi_val_counter += 1)
global MPI_AINT = MPI_Datatype(_mpi_val_counter += 1)
global MPI_BYTE = MPI_Datatype(_mpi_val_counter += 1)
global MPI_CHAR = MPI_Datatype(_mpi_val_counter += 1)
global MPI_CHARACTER = MPI_Datatype(_mpi_val_counter += 1)
global MPI_COMPLEX = MPI_Datatype(_mpi_val_counter += 1)
global MPI_COMPLEX16 = MPI_Datatype(_mpi_val_counter += 1)
# global MPI_COMPLEX32 = MPI_Datatype(_mpi_val_counter += 1)
global MPI_COMPLEX8 = MPI_Datatype(_mpi_val_counter += 1)
global MPI_COUNT = MPI_Datatype(_mpi_val_counter += 1)
global MPI_CXX_BOOL = MPI_Datatype(_mpi_val_counter += 1)
global MPI_CXX_DOUBLE_COMPLEX = MPI_Datatype(_mpi_val_counter += 1)
global MPI_CXX_FLOAT_COMPLEX = MPI_Datatype(_mpi_val_counter += 1)
global MPI_CXX_LONG_DOUBLE_COMPLEX = MPI_Datatype(_mpi_val_counter += 1)
global MPI_C_BOOL = MPI_Datatype(_mpi_val_counter += 1)
global MPI_C_COMPLEX = MPI_Datatype(_mpi_val_counter += 1)
global MPI_C_DOUBLE_COMPLEX = MPI_Datatype(_mpi_val_counter += 1)
global MPI_C_FLOAT_COMPLEX = MPI_Datatype(_mpi_val_counter += 1)
global MPI_C_LONG_DOUBLE_COMPLEX = MPI_Datatype(_mpi_val_counter += 1)
global MPI_DATATYPE_NULL = MPI_Datatype(_mpi_val_counter += 1)
global MPI_DOUBLE = MPI_Datatype(_mpi_val_counter += 1)
global MPI_DOUBLE_COMPLEX = MPI_Datatype(_mpi_val_counter += 1)
global MPI_DOUBLE_INT = MPI_Datatype(_mpi_val_counter += 1)
global MPI_DOUBLE_PRECISION = MPI_Datatype(_mpi_val_counter += 1)
global MPI_FLOAT = MPI_Datatype(_mpi_val_counter += 1)
global MPI_FLOAT_INT = MPI_Datatype(_mpi_val_counter += 1)
global MPI_INT = MPI_Datatype(_mpi_val_counter += 1)
global MPI_INT16_T = MPI_Datatype(_mpi_val_counter += 1)
global MPI_INT32_T = MPI_Datatype(_mpi_val_counter += 1)
global MPI_INT64_T = MPI_Datatype(_mpi_val_counter += 1)
global MPI_INT8_T = MPI_Datatype(_mpi_val_counter += 1)
global MPI_INTEGER = MPI_Datatype(_mpi_val_counter += 1)
global MPI_INTEGER1 = MPI_Datatype(_mpi_val_counter += 1)
global MPI_INTEGER2 = MPI_Datatype(_mpi_val_counter += 1)
global MPI_INTEGER4 = MPI_Datatype(_mpi_val_counter += 1)
global MPI_INTEGER8 = MPI_Datatype(_mpi_val_counter += 1)
global MPI_LOGICAL = MPI_Datatype(_mpi_val_counter += 1)
global MPI_LONG = MPI_Datatype(_mpi_val_counter += 1)
global MPI_LONG_DOUBLE = MPI_Datatype(_mpi_val_counter += 1)
global MPI_LONG_DOUBLE_INT = MPI_Datatype(_mpi_val_counter += 1)
global MPI_LONG_INT = MPI_Datatype(_mpi_val_counter += 1)
global MPI_LONG_LONG = MPI_Datatype(_mpi_val_counter += 1)
global MPI_LONG_LONG_INT = MPI_Datatype(_mpi_val_counter += 1)
global MPI_OFFSET = MPI_Datatype(_mpi_val_counter += 1)
global MPI_PACKED = MPI_Datatype(_mpi_val_counter += 1)
global MPI_REAL = MPI_Datatype(_mpi_val_counter += 1)
# global MPI_REAL16 = MPI_Datatype(_mpi_val_counter += 1)
global MPI_REAL4 = MPI_Datatype(_mpi_val_counter += 1)
global MPI_REAL8 = MPI_Datatype(_mpi_val_counter += 1)
global MPI_SHORT = MPI_Datatype(_mpi_val_counter += 1)
global MPI_SHORT_INT = MPI_Datatype(_mpi_val_counter += 1)
global MPI_SIGNED_CHAR = MPI_Datatype(_mpi_val_counter += 1)
global MPI_UINT16_T = MPI_Datatype(_mpi_val_counter += 1)
global MPI_UINT32_T = MPI_Datatype(_mpi_val_counter += 1)
global MPI_UINT64_T = MPI_Datatype(_mpi_val_counter += 1)
global MPI_UINT8_T = MPI_Datatype(_mpi_val_counter += 1)
global MPI_UNSIGNED = MPI_Datatype(_mpi_val_counter += 1)
global MPI_UNSIGNED_CHAR = MPI_Datatype(_mpi_val_counter += 1)
global MPI_UNSIGNED_LONG = MPI_Datatype(_mpi_val_counter += 1)
global MPI_UNSIGNED_LONG_LONG = MPI_Datatype(_mpi_val_counter += 1)
global MPI_UNSIGNED_SHORT = MPI_Datatype(_mpi_val_counter += 1)
global MPI_WCHAR = MPI_Datatype(_mpi_val_counter += 1)

global MPI_NULL_DELETE_FN = C_NULL

global MPI_ERRHANDLER_NULL = MPI_Errhandler(_mpi_val_counter += 1)
global MPI_ERRORS_ARE_FATAL = MPI_Errhandler(_mpi_val_counter += 1)
global MPI_ERRORS_RETURN = MPI_Errhandler(_mpi_val_counter += 1)

global MPI_FILE_NULL = MPI_File(_mpi_val_counter += 1)

global MPI_GROUP_EMPTY = MPI_Group(_mpi_val_counter += 1)
global MPI_GROUP_NULL = MPI_Group(_mpi_val_counter += 1)

global MPI_INFO_ENV = MPI_Info(_mpi_val_counter += 1)
global MPI_INFO_NULL = MPI_Info(_mpi_val_counter += 1)

global MPI_MESSAGE_NO_PROC = MPI_Message(_mpi_val_counter += 1)
global MPI_MESSAGE_NULL = MPI_Message(_mpi_val_counter += 1)

global MPI_DISPLACEMENT_CURRENT = MPI_Offset(_mpi_val_counter += 1)

global MPI_BAND = MPI_Op(_mpi_val_counter += 1)
global MPI_BOR = MPI_Op(_mpi_val_counter += 1)
global MPI_BXOR = MPI_Op(_mpi_val_counter += 1)
global MPI_LAND = MPI_Op(_mpi_val_counter += 1)
global MPI_LOR = MPI_Op(_mpi_val_counter += 1)
global MPI_LXOR = MPI_Op(_mpi_val_counter += 1)
global MPI_MAX = MPI_Op(_mpi_val_counter += 1)
global MPI_MAXLOC = MPI_Op(_mpi_val_counter += 1)
global MPI_MIN = MPI_Op(_mpi_val_counter += 1)
global MPI_MINLOC = MPI_Op(_mpi_val_counter += 1)
global MPI_NO_OP = MPI_Op(_mpi_val_counter += 1)
global MPI_OP_NULL = MPI_Op(_mpi_val_counter += 1)
global MPI_PROD = MPI_Op(_mpi_val_counter += 1)
global MPI_REPLACE = MPI_Op(_mpi_val_counter += 1)
global MPI_SUM = MPI_Op(_mpi_val_counter += 1)

global MPI_REQUEST_NULL = MPI_Request(_mpi_val_counter += 1)

global MPI_STATUS_IGNORE = C_NULL
global MPI_STATUSES_IGNORE = C_NULL

global MPI_TYPE_DUP_FN = C_NULL

global MPI_TYPE_NULL_COPY_FN = C_NULL

global MPI_TYPE_NULL_DELETE_FN = C_NULL

global MPI_WIN_NULL = MPI_Win(_mpi_val_counter += 1)

global MPI_WIN_DUP_FN = C_NULL
global MPI_WIN_NULL_COPY_FN = C_NULL

global MPI_WIN_NULL_DELETE_FN = C_NULL
