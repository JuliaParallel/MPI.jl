# These constants were manually copied from the file mpi.h in the Microsoft
# MPI SDK v7

const MPI_BYTE = Int32(0x4c00010d)
const MPI_WCHAR = Int32(0x4c00020e)
const MPI_INT8_T = Int32(0x4c000133)
const MPI_UINT8_T = Int32(0x4c000137)
const MPI_INT16_T = Int32(0x4c000234)
const MPI_UINT16_T = Int32(0x4c000238)
const MPI_INT32_T = Int32(0x4c000435)
const MPI_UINT32_T = Int32(0x4c000439)
const MPI_INT64_T = Int32(0x4c000836)
const MPI_UINT64_T = Int32(0x4c00083a)
const MPI_REAL4 = Int32(0x4c000427)
const MPI_REAL8 = Int32(0x4c000829)
const MPI_COMPLEX8 = Int32(0x4c000828)
const MPI_COMPLEX16 = Int32(0x4c00102a)
const MPI_INTEGER1 = Int32(0x4c00012d)
const MPI_INTEGER2 = Int32(0x4c00022f)
const MPI_INTEGER4 = Int32(0x4c000430)
const MPI_INTEGER8 = Int32(0x4c000831)
const MPI_COMM_NULL = Int32(67108864)
const MPI_COMM_SELF = Int32(1140850689)
const MPI_COMM_WORLD = Int32(1140850688)
const MPI_COMM_TYPE_SHARED = Int32(1)
const MPI_OP_NULL = Int32(402653184)
const MPI_BAND = Int32(1476395014)
const MPI_BOR = Int32(1476395016)
const MPI_BXOR = Int32(1476395018)
const MPI_LAND = Int32(1476395013)
const MPI_LOCK_EXCLUSIVE = Int32(234)
const MPI_LOCK_SHARED = Int32(235)
const MPI_LOR = Int32(1476395015)
const MPI_LXOR = Int32(1476395017)
const MPI_MAX = Int32(1476395009)
const MPI_MAXLOC = Int32(1476395020)
const MPI_MIN = Int32(1476395010)
const MPI_MINLOC = Int32(1476395019)
const MPI_NO_OP = Int32(0x5800000e)
const MPI_PROD = Int32(1476395012)
const MPI_REPLACE = Int32(1476395021)
const MPI_SUM = Int32(1476395011)
const MPI_REQUEST_NULL = Int32(738197504)
const MPI_INFO_NULL = Int32(469762048)
const MPI_STATUS_SIZE = Int32(5)
const MPI_ERROR = Int32(5)
const MPI_SOURCE = Int32(3)
const MPI_TAG = Int32(4)
const MPI_ANY_SOURCE = Int32(-2)
const MPI_ANY_TAG = Int32(-1)
const MPI_TAG_UB = Int32(1681915906)
const MPI_UNDEFINED = Int32(-32766)
const HAVE_MPI_COMM_C2F = false

const libmpi = "msmpi.dll"

const MPI_ABORT = (:MPI_ABORT, libmpi)
const MPI_ACCUMULATE = (:MPI_ACCUMULATE, libmpi)
const MPI_ALLREDUCE = (:MPI_ALLREDUCE, libmpi)
const MPI_INIT = (:MPI_INIT, libmpi)
const MPI_CANCEL = (:MPI_CANCEL, libmpi)
const MPI_COMM_FREE = (:MPI_COMM_FREE, libmpi)
const MPI_COMM_GET_PARENT = (:MPI_COMM_GET_PARENT, libmpi)
const MPI_COMM_RANK = (:MPI_COMM_RANK, libmpi)
const MPI_COMM_SIZE = (:MPI_COMM_SIZE, libmpi)
const MPI_COMM_SPLIT = (:MPI_COMM_SPLIT, libmpi)
const MPI_COMM_SPLIT_TYPE = (:MPI_COMM_SPLIT_TYPE, libmpi)
const MPI_BARRIER = (:MPI_BARRIER, libmpi)
const MPI_FINALIZE = (:MPI_FINALIZE, libmpi)
const MPI_BCAST = (:MPI_BCAST, libmpi)
const MPI_REDUCE = (:MPI_REDUCE, libmpi)
const MPI_IRECV = (:MPI_IRECV, libmpi)
const MPI_RECV = (:MPI_RECV, libmpi)
const MPI_ISEND = (:MPI_ISEND, libmpi)
const MPI_WAITALL = (:MPI_WAITALL, libmpi)
const MPI_ALLGATHER = (:MPI_ALLGATHER, libmpi)
const MPI_ALLGATHERV = (:MPI_ALLGATHERV, libmpi)
const MPI_ALLTOALL = (:MPI_ALLTOALL, libmpi)
const MPI_ALLTOALLV = (:MPI_ALLTOALLV, libmpi)
const MPI_INFO_CREATE = (:MPI_INFO_CREATE, libmpi)
const MPI_INFO_DELETE = (:MPI_INFO_DELETE, libmpi)
const MPI_INFO_FREE = (:MPI_INFO_FREE, libmpi)
const MPI_INFO_GET = (:MPI_INFO_GET, libmpi)
const MPI_INFO_GET_VALUELEN = (:MPI_INFO_GET_VALUELEN, libmpi)
const MPI_INFO_SET = (:MPI_INFO_SET, libmpi)
const MPI_INITIALIZED = (:MPI_INITIALIZED, libmpi)
const MPI_FINALIZED = (:MPI_FINALIZED, libmpi)
const MPI_FETCH_AND_OP = (:MPI_FETCH_AND_OP, libmpi)
const MPI_OP_CREATE = (:MPI_OP_CREATE, libmpi)
const MPI_OP_FREE = (:MPI_OP_FREE, libmpi)
const MPI_SCATTER = (:MPI_SCATTER, libmpi)
const MPI_SCATTERV = (:MPI_SCATTERV, libmpi)
const MPI_SEND = (:MPI_SEND, libmpi)
const MPI_SCAN = (:MPI_SCAN, libmpi)
const MPI_EXSCAN = (:MPI_EXSCAN, libmpi)
const MPI_GET = (:MPI_GET, libmpi)
const MPI_GET_ACCUMULATE = (:MPI_GET_ACCUMULATE, libmpi)
const MPI_GET_ADDRESS = (:MPI_GET_ADDRESS, libmpi)
const MPI_GET_COUNT = (:MPI_GET_COUNT, libmpi)
const MPI_GATHER = (:MPI_GATHER, libmpi)
const MPI_GATHERV = (:MPI_GATHERV, libmpi)
const MPI_COMM_DUP = (:MPI_COMM_DUP, libmpi)
const MPI_INTERCOMM_MERGE = (:MPI_INTERCOMM_MERGE, libmpi)
const MPI_IPROBE = (:MPI_IPROBE, libmpi)
const MPI_PROBE = (:MPI_PROBE, libmpi)
const MPI_PUT = (:MPI_PUT, libmpi)
const MPI_TEST = (:MPI_TEST, libmpi)
const MPI_TESTSOME = (:MPI_TESTSOME, libmpi)
const MPI_TESTANY = (:MPI_TESTANY, libmpi)
const MPI_TESTALL = (:MPI_TESTALL, libmpi)
const MPI_TYPE_CREATE_STRUCT = (:MPI_TYPE_CREATE_STRUCT, libmpi)
const MPI_TYPE_COMMIT = (:MPI_TYPE_COMMIT, libmpi)
const MPI_WAIT = (:MPI_WAIT, libmpi)
const MPI_WAITANY = (:MPI_WAITANY, libmpi)
const MPI_WAITSOME = (:MPI_WAITSOME, libmpi)
const MPI_WIN_ATTACH = (:MPI_WIN_ATTACH, libmpi)
const MPI_WIN_CREATE = (:MPI_WIN_CREATE, libmpi)
const MPI_WIN_CREATE_DYNAMIC = (:MPI_WIN_CREATE, libmpi)
const MPI_WIN_DETACH = (:MPI_WIN_DETACH, libmpi)
const MPI_WIN_FENCE = (:MPI_WIN_FENCE, libmpi)
const MPI_WIN_FLUSH = (:MPI_WIN_FLUSH, libmpi)
const MPI_WIN_FREE = (:MPI_WIN_FREE, libmpi)
const MPI_WIN_LOCK = (:MPI_WIN_LOCK, libmpi)
const MPI_WIN_SYNC = (:MPI_WIN_SYNC, libmpi)
const MPI_WIN_UNLOCK = (:MPI_WIN_UNLOCK, libmpi)
const MPI_WTICK = (:MPI_WTICK, libmpi)
const MPI_WTIME = (:MPI_WTIME, libmpi)

primitive type CComm 32 end
primitive type CInfo 32 end
primitive type CWin 32 end
