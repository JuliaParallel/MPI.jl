const MPI_Aint   = Int
const MPI_Offset = Int64
const MPI_Count  = Int64

const MPI_Comm = Cint
const MPI_COMM_NULL  = reinterpret(Cint, 0x04000000)
const MPI_COMM_SELF  = reinterpret(Cint, 0x44000001)
const MPI_COMM_WORLD = reinterpret(Cint, 0x44000000)

const MPI_Info = Cint
const MPI_INFO_NULL = reinterpret(Cint, 0x1c000000)

const MPI_Win = Cint
const MPI_WIN_NULL = reinterpret(Cint, 0x20000000)

const MPI_Op = Cint
const MPI_OP_NULL = reinterpret(Cint, 0x18000000)
const MPI_MAX     = reinterpret(Cint, 0x58000001)
const MPI_MIN     = reinterpret(Cint, 0x58000002)
const MPI_SUM     = reinterpret(Cint, 0x58000003)
const MPI_PROD    = reinterpret(Cint, 0x58000004)
const MPI_LAND    = reinterpret(Cint, 0x58000005)
const MPI_BAND    = reinterpret(Cint, 0x58000006)
const MPI_LOR     = reinterpret(Cint, 0x58000007)
const MPI_BOR     = reinterpret(Cint, 0x58000008)
const MPI_LXOR    = reinterpret(Cint, 0x58000009)
const MPI_BXOR    = reinterpret(Cint, 0x5800000a)
const MPI_MINLOC  = reinterpret(Cint, 0x5800000b)
const MPI_MAXLOC  = reinterpret(Cint, 0x5800000c)
const MPI_REPLACE = reinterpret(Cint, 0x5800000d)
const MPI_NO_OP   = reinterpret(Cint, 0x5800000e)

const MPI_Request = Cint
const MPI_REQUEST_NULL = reinterpret(Cint, 0x2c000000)

const MPI_Datatype = Cint
const MPI_DATATYPE_NULL         = reinterpret(Cint, 0x0c000000)
const MPI_PACKED                = reinterpret(Cint, 0x4c00010f)
const MPI_CHAR                  = reinterpret(Cint, 0x4c000101)
const MPI_SIGNED_CHAR           = reinterpret(Cint, 0x4c000118)
const MPI_UNSIGNED_CHAR         = reinterpret(Cint, 0x4c000102)
const MPI_WCHAR                 = reinterpret(Cint, 0x4c00020e)
const MPI_BYTE                  = reinterpret(Cint, 0x4c00010d)
const MPI_SHORT                 = reinterpret(Cint, 0x4c000203)
const MPI_UNSIGNED_SHORT        = reinterpret(Cint, 0x4c000204)
const MPI_INT                   = reinterpret(Cint, 0x4c000405)
const MPI_UNSIGNED              = reinterpret(Cint, 0x4c000406)
const MPI_LONG                  = reinterpret(Cint, 0x4c000407)
const MPI_UNSIGNED_LONG         = reinterpret(Cint, 0x4c000408)
const MPI_FLOAT                 = reinterpret(Cint, 0x4c00040a)
const MPI_DOUBLE                = reinterpret(Cint, 0x4c00080b)

const MPI_INT8_T                = reinterpret(Cint, 0x4c000133)
const MPI_INT16_T               = reinterpret(Cint, 0x4c000234)
const MPI_INT32_T               = reinterpret(Cint, 0x4c000435)
const MPI_INT64_T               = reinterpret(Cint, 0x4c000836)
const MPI_UINT8_T               = reinterpret(Cint, 0x4c000137)
const MPI_UINT16_T              = reinterpret(Cint, 0x4c000238)
const MPI_UINT32_T              = reinterpret(Cint, 0x4c000439)
const MPI_UINT64_T              = reinterpret(Cint, 0x4c00083a)
const MPI_C_FLOAT_COMPLEX       = reinterpret(Cint, 0x4c000813)
const MPI_C_DOUBLE_COMPLEX      = reinterpret(Cint, 0x4c001014)

const MPI_File = Cint
const MPI_FILE_NULL = Cint(0)

const MPI_PROC_NULL = Cint(-1)
const MPI_ANY_SOURCE = Cint(-2)
const MPI_ANY_TAG = Cint(-1)
const MPI_SUCCESS = Cint(0)
const MPI_UNDEFINED = Cint(-32766)
const MPI_LOCK_EXCLUSIVE = Cint(234)
const MPI_LOCK_SHARED = Cint(235)
const MPI_MAX_INFO_KEY = Cint(255)
const MPI_MAX_INFO_VAL = Cint(1024)
const MPI_TAG_UB = reinterpret(Cint, 0x64400001)
const MPI_COMM_TYPE_SHARED = Cint(1)
const MPI_ORDER_C = Cint(56)
const MPI_ORDER_FORTRAN = Cint(57)
const MPI_UNIVERSE_SIZE = reinterpret(Cint, 0x64400009)
const MPI_MAX_ERROR_STRING = Cint(512)
const MPI_SUCCESS = Cint(0)
const MPI_MODE_RDONLY = reinterpret(Cint, 0x00000002)
const MPI_MODE_RDWR = reinterpret(Cint, 0x00000008)
const MPI_MODE_WRONLY = reinterpret(Cint, 0x00000004)
const MPI_MODE_CREATE = reinterpret(Cint, 0x00000001)
const MPI_MODE_EXCL = reinterpret(Cint, 0x00000040)
const MPI_MODE_DELETE_ON_CLOSE = reinterpret(Cint, 0x00000010)
const MPI_MODE_UNIQUE_OPEN = reinterpret(Cint, 0x00000020)
const MPI_MODE_SEQUENTIAL = reinterpret(Cint, 0x00000100)
const MPI_MODE_APPEND = reinterpret(Cint, 0x00000080)

const MPI_BOTTOM = reinterpret(SentinelPtr, 0)
const MPI_IN_PLACE = reinterpret(SentinelPtr, -1)

const MPI_STATUS_IGNORE = reinterpret(SentinelPtr, 1)
const MPI_STATUSES_IGNORE = reinterpret(SentinelPtr, 1)

struct Status
    _pad1::Cint
    _pad2::Cint
    source::Cint
    tag::Cint
    error::Cint
end

const STATUS_EMPTY = Status(zero(Cint), zero(Cint), MPI_ANY_SOURCE, MPI_ANY_TAG, MPI_SUCCESS)
