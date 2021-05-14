# https://github.com/pmodels/mpich/blob/master/src/include/mpi.h.in

const MPI_Aint = Int
const MPI_Count = Int64
const MPI_Offset = Int64

const MPI_Status_size = 20
const MPI_Status_Source_offset = 8
const MPI_Status_Tag_offset = 12
const MPI_Status_Error_offset = 16

const MPI_Info = Cint
const MPI_INFO_NULL = Cint(469762048)

const MPI_Win = Cint
const MPI_WIN_NULL = Cint(536870912)

const MPI_Comm = Cint
const MPI_COMM_NULL = Cint(67108864)
const MPI_COMM_SELF = Cint(1140850689)
const MPI_COMM_WORLD = Cint(1140850688)

const MPI_Errhandler = Cint
const MPI_ERRORS_ARE_FATAL = Cint(0x54000000)
const MPI_ERRORS_RETURN = Cint(0x54000001)

const MPI_Request = Cint
const MPI_REQUEST_NULL = Cint(738197504)

const MPI_File = Ptr{Cvoid}
MPI_File_f2c(c::Cint) = ccall((:MPI_File_f2c,libmpi),MPI_File,(Cint,),c)
const MPI_FILE_NULL = Cint(0)

const MPI_Op = Cint
const MPI_OP_NULL = Cint(402653184)
const MPI_BAND = Cint(1476395014)
const MPI_BOR = Cint(1476395016)
const MPI_BXOR = Cint(1476395018)
const MPI_LAND = Cint(1476395013)
const MPI_LOR = Cint(1476395015)
const MPI_LXOR = Cint(1476395017)
const MPI_MAX = Cint(1476395009)
const MPI_MIN = Cint(1476395010)
const MPI_SUM = Cint(1476395011)
const MPI_PROD = Cint(1476395012)
const MPI_MAXLOC = Cint(1476395020)
const MPI_MINLOC = Cint(1476395019)
const MPI_REPLACE = Cint(1476395021)
const MPI_NO_OP = Cint(1476395022)

const MPI_Datatype = Cint
const MPI_DATATYPE_NULL = Cint(201326592)
const MPI_PACKED = Cint(1275068687)
const MPI_CHAR = Cint(1275068673)
const MPI_SIGNED_CHAR = Cint(1275068696)
const MPI_UNSIGNED_CHAR = Cint(1275068674)
const MPI_WCHAR = Cint(1275069454)
const MPI_BYTE = Cint(1275068685)
const MPI_SHORT = Cint(1275068931)
const MPI_UNSIGNED_SHORT = Cint(1275068932)
const MPI_INT = Cint(1275069445)
const MPI_UNSIGNED = Cint(1275069446)
const MPI_LONG = Cint(1275070471)
const MPI_UNSIGNED_LONG = Cint(1275070472)
const MPI_FLOAT = Cint(1275069450)
const MPI_DOUBLE = Cint(1275070475)
const MPI_INT8_T = Cint(1275068727)
const MPI_INT16_T = Cint(1275068984)
const MPI_INT32_T = Cint(1275069497)
const MPI_INT64_T = Cint(1275070522)
const MPI_UINT8_T = Cint(1275068731)
const MPI_UINT16_T = Cint(1275068988)
const MPI_UINT32_T = Cint(1275069501)
const MPI_UINT64_T = Cint(1275070526)
const MPI_C_FLOAT_COMPLEX = Cint(1275070528)
const MPI_C_DOUBLE_COMPLEX = Cint(1275072577)

const MPI_THREAD_SINGLE = Cint(0)
const MPI_THREAD_FUNNELED = Cint(1)
const MPI_THREAD_SERIALIZED = Cint(2)
const MPI_THREAD_MULTIPLE = Cint(3)
const MPI_PROC_NULL = Cint(-1)
const MPI_ANY_SOURCE = Cint(-2)
const MPI_ANY_TAG = Cint(-1)
const MPI_SUCCESS = Cint(0)
const MPI_UNDEFINED = Cint(-32766)
const MPI_LOCK_EXCLUSIVE = Cint(234)
const MPI_LOCK_SHARED = Cint(235)
const MPI_MAX_INFO_KEY = Cint(255)
const MPI_MAX_INFO_VAL = Cint(1024)
const MPI_MAX_OBJECT_NAME = Cint(128)
const MPI_TAG_UB = Cint(1681915905)
const MPI_COMM_TYPE_SHARED = Cint(1)
const MPI_ORDER_C = Cint(56)
const MPI_ORDER_FORTRAN = Cint(57)
const MPI_UNIVERSE_SIZE = Cint(1681915913)
const MPI_MAX_ERROR_STRING = Cint(512)
const MPI_SUCCESS = Cint(0)
const MPI_MODE_RDONLY = Cint(2)
const MPI_MODE_RDWR = Cint(8)
const MPI_MODE_WRONLY = Cint(4)
const MPI_MODE_CREATE = Cint(1)
const MPI_MODE_EXCL = Cint(64)
const MPI_MODE_DELETE_ON_CLOSE = Cint(16)
const MPI_MODE_UNIQUE_OPEN = Cint(32)
const MPI_MODE_SEQUENTIAL = Cint(256)
const MPI_MODE_APPEND = Cint(128)

const MPI_SEEK_SET = Cint(600)
const MPI_SEEK_CUR = Cint(602)
const MPI_SEEK_END = Cint(604)

const MPI_IDENT = Cint(0)
const MPI_CONGRUENT = Cint(1)
const MPI_SIMILAR = Cint(2)
const MPI_UNEQUAL = Cint(3)

const MPI_BOTTOM = reinterpret(SentinelPtr, 0)
const MPI_IN_PLACE = reinterpret(SentinelPtr, -1)
const MPI_STATUS_IGNORE = reinterpret(SentinelPtr, 1)
const MPI_STATUSES_IGNORE = reinterpret(SentinelPtr, 1)
