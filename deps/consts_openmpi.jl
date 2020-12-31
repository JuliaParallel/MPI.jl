# https://github.com/open-mpi/ompi/blob/master/ompi/include/mpi.h.in

const MPI_Aint = Int
const MPI_Count = Int64
const MPI_Offset = Int64

const MPI_Status_size = 24
const MPI_Status_Source_offset = 0
const MPI_Status_Tag_offset = 4
const MPI_Status_Error_offset = 8

const MPI_Info = Ptr{Cvoid}
MPI_Info_f2c(c::Cint) = ccall(:MPI_Info_f2c,MPI_Info,(Cint,),c)
const MPI_INFO_NULL = Cint(0)

const MPI_Win = Ptr{Cvoid}
MPI_Win_f2c(c::Cint) = ccall(:MPI_Win_f2c,MPI_Win,(Cint,),c)
const MPI_WIN_NULL = Cint(0)

const MPI_Comm = Ptr{Cvoid}
MPI_Comm_f2c(c::Cint) = ccall(:MPI_Comm_f2c,MPI_Comm,(Cint,),c)
const MPI_COMM_NULL = Cint(2)
const MPI_COMM_SELF = Cint(1)
const MPI_COMM_WORLD = Cint(0)

const MPI_Request = Ptr{Cvoid}
MPI_Request_f2c(c::Cint) = ccall(:MPI_Request_f2c,MPI_Request,(Cint,),c)
const MPI_REQUEST_NULL = Cint(0)

const MPI_File = Ptr{Cvoid}
MPI_File_f2c(c::Cint) = ccall(:MPI_File_f2c,MPI_File,(Cint,),c)
const MPI_FILE_NULL = Cint(0)

const MPI_Op = Ptr{Cvoid}
MPI_Op_f2c(c::Cint) = ccall(:MPI_Op_f2c,MPI_Op,(Cint,),c)
const MPI_OP_NULL = Cint(0)
const MPI_BAND = Cint(6)
const MPI_BOR = Cint(8)
const MPI_BXOR = Cint(10)
const MPI_LAND = Cint(5)
const MPI_LOR = Cint(7)
const MPI_LXOR = Cint(9)
const MPI_MAX = Cint(1)
const MPI_MIN = Cint(2)
const MPI_SUM = Cint(3)
const MPI_PROD = Cint(4)
const MPI_MAXLOC = Cint(11)
const MPI_MINLOC = Cint(12)
const MPI_REPLACE = Cint(13)
const MPI_NO_OP = Cint(14)

const MPI_Datatype = Ptr{Cvoid}
MPI_Datatype_f2c(c::Cint) = ccall(:MPI_Type_f2c,MPI_Datatype,(Cint,),c)
const MPI_DATATYPE_NULL = Cint(0)
const MPI_PACKED = Cint(2)
const MPI_CHAR = Cint(34)
const MPI_SIGNED_CHAR = Cint(36)
const MPI_UNSIGNED_CHAR = Cint(35)
const MPI_WCHAR = Cint(33)
const MPI_BYTE = Cint(1)
const MPI_SHORT = Cint(37)
const MPI_UNSIGNED_SHORT = Cint(38)
const MPI_INT = Cint(39)
const MPI_UNSIGNED = Cint(40)
const MPI_LONG = Cint(41)
const MPI_UNSIGNED_LONG = Cint(42)
const MPI_FLOAT = Cint(45)
const MPI_DOUBLE = Cint(46)
const MPI_INT8_T = Cint(58)
const MPI_INT16_T = Cint(60)
const MPI_INT32_T = Cint(62)
const MPI_INT64_T = Cint(64)
const MPI_UINT8_T = Cint(59)
const MPI_UINT16_T = Cint(61)
const MPI_UINT32_T = Cint(63)
const MPI_UINT64_T = Cint(65)
const MPI_C_FLOAT_COMPLEX = Cint(69)
const MPI_C_DOUBLE_COMPLEX = Cint(70)

const MPI_THREAD_SINGLE = Cint(0)
const MPI_THREAD_FUNNELED = Cint(1)
const MPI_THREAD_SERIALIZED = Cint(2)
const MPI_THREAD_MULTIPLE = Cint(3)
const MPI_PROC_NULL = Cint(-2)
const MPI_ANY_SOURCE = Cint(-1)
const MPI_ANY_TAG = Cint(-1)
const MPI_SUCCESS = Cint(0)
const MPI_UNDEFINED = Cint(-32766)
const MPI_LOCK_EXCLUSIVE = Cint(1)
const MPI_LOCK_SHARED = Cint(2)
const MPI_MAX_INFO_KEY = Cint(36)
const MPI_MAX_INFO_VAL = Cint(256)
const MPI_TAG_UB = Cint(0)
const MPI_COMM_TYPE_SHARED = Cint(0)
const MPI_ORDER_C = Cint(0)
const MPI_ORDER_FORTRAN = Cint(1)
const MPI_UNIVERSE_SIZE = Cint(6)
const MPI_MAX_ERROR_STRING = Cint(256)
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
const MPI_IN_PLACE = reinterpret(SentinelPtr, 1)
const MPI_STATUS_IGNORE = reinterpret(SentinelPtr, 0)
const MPI_STATUSES_IGNORE = reinterpret(SentinelPtr, 0)

