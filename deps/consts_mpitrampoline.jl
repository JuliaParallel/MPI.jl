# https://github.com/eschnett/MPItrampoline/mpi.h
# https://github.com/eschnett/MPItrampoline/mpi-constants.inc

# Compile-time constants

const MPI_MAX_ERROR_STRING = 1024
const MPI_MAX_INFO_KEY = 256
const MPI_MAX_INFO_VAL = 1024
const MPI_MAX_LIBRARY_VERSION_STRING = 8192
const MPI_MAX_OBJECT_NAME = 128
const MPI_MAX_PORT_NAME = 256
const MPI_MAX_PROCESSOR_NAME = 128

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

struct MPI_Status
    _pad1::Cint
    _pad2::Cint
    _pad3::Cint
    _pad4::Cint
    _pad5::Culong
    source::Cint
    tag::Cint
    error::Cint
end
if sizeof(Ptr) == 8
    @assert sizeof(MPI_Status) == 10 * sizeof(Cint)
else
    @assert sizeof(MPI_Status) == 8 * sizeof(Cint)
end
const Status = MPI_Status

################################################################################

# Constants
const _constants = Tuple{Type,String}[

    (Cint, "MPI_ANY_SOURCE"),
    (Cint, "MPI_ANY_TAG"),
    (Cint, "MPI_PROC_NULL"),
    (Cint, "MPI_ROOT"),

    (Cint, "MPI_CART"),
    (Cint, "MPI_DIST_GRAPH"),
    (Cint, "MPI_GRAPH"),

    # Results of compare operations
    (Cint, "MPI_CONGRUENT"),
    (Cint, "MPI_IDENT"),
    (Cint, "MPI_SIMILAR"),
    (Cint, "MPI_UNEQUAL"),

    # Predefined constants
    (Cint, "MPI_KEYVAL_INVALID"),
    (Cint, "MPI_UNDEFINED"),

    # Key values
    (Cint, "MPI_APPNUM"),
    (Cint, "MPI_HOST"),
    (Cint, "MPI_IO"),
    (Cint, "MPI_LASTUSEDCODE"),
    (Cint, "MPI_TAG_UB"),
    (Cint, "MPI_UNIVERSE_SIZE"),
    (Cint, "MPI_WIN_BASE"),
    (Cint, "MPI_WIN_CREATE_FLAVOR"),
    (Cint, "MPI_WIN_DISP_UNIT"),
    (Cint, "MPI_WIN_MODEL"),
    (Cint, "MPI_WIN_SIZE"),
    (Cint, "MPI_WTIME_IS_GLOBAL"),

    (Cint, "MPI_COMBINER_CONTIGUOUS"),
    (Cint, "MPI_COMBINER_DARRAY"),
    (Cint, "MPI_COMBINER_DUP"),
    (Cint, "MPI_COMBINER_F90_COMPLEX"),
    (Cint, "MPI_COMBINER_F90_INTEGER"),
    (Cint, "MPI_COMBINER_F90_REAL"),
    (Cint, "MPI_COMBINER_HINDEXED"),
    (Cint, "MPI_COMBINER_HINDEXED_BLOCK"),
    (Cint, "MPI_COMBINER_HVECTOR"),
    (Cint, "MPI_COMBINER_INDEXED"),
    (Cint, "MPI_COMBINER_INDEXED_BLOCK"),
    (Cint, "MPI_COMBINER_NAMED"),
    (Cint, "MPI_COMBINER_RESIZED"),
    (Cint, "MPI_COMBINER_STRUCT"),
    (Cint, "MPI_COMBINER_SUBARRAY"),
    (Cint, "MPI_COMBINER_VECTOR"),

    (Cint, "MPI_COMM_TYPE_SHARED"),

    # File operation constants
    (Cint, "MPI_DISTRIBUTE_BLOCK"),
    (Cint, "MPI_DISTRIBUTE_CYCLIC"),
    (Cint, "MPI_DISTRIBUTE_NONE"),

    (Cint, "MPI_ERR_ACCESS"),
    (Cint, "MPI_ERR_AMODE"),
    (Cint, "MPI_ERR_ARG"),
    (Cint, "MPI_ERR_ASSERT"),
    (Cint, "MPI_ERR_BAD_FILE"),
    (Cint, "MPI_ERR_BASE"),
    (Cint, "MPI_ERR_BUFFER"),
    (Cint, "MPI_ERR_COMM"),
    (Cint, "MPI_ERR_CONVERSION"),
    (Cint, "MPI_ERR_COUNT"),
    (Cint, "MPI_ERR_DIMS"),
    (Cint, "MPI_ERR_DISP"),
    (Cint, "MPI_ERR_DUP_DATAREP"),
    (Cint, "MPI_ERR_FILE"),
    (Cint, "MPI_ERR_FILE_EXISTS"),
    (Cint, "MPI_ERR_FILE_IN_USE"),
    (Cint, "MPI_ERR_GROUP"),
    (Cint, "MPI_ERR_INFO"),
    (Cint, "MPI_ERR_INFO_KEY"),
    (Cint, "MPI_ERR_INFO_NOKEY"),
    (Cint, "MPI_ERR_INFO_VALUE"),
    (Cint, "MPI_ERR_INTERN"),
    (Cint, "MPI_ERR_IN_STATUS"),
    (Cint, "MPI_ERR_IO"),
    (Cint, "MPI_ERR_KEYVAL"),
    (Cint, "MPI_ERR_LASTCODE"),
    (Cint, "MPI_ERR_LOCKTYPE"),
    (Cint, "MPI_ERR_NAME"),
    (Cint, "MPI_ERR_NOT_SAME"),
    (Cint, "MPI_ERR_NO_MEM"),
    (Cint, "MPI_ERR_NO_SPACE"),
    (Cint, "MPI_ERR_NO_SUCH_FILE"),
    (Cint, "MPI_ERR_OP"),
    (Cint, "MPI_ERR_OTHER"),
    (Cint, "MPI_ERR_PENDING"),
    (Cint, "MPI_ERR_PORT"),
    (Cint, "MPI_ERR_QUOTA"),
    (Cint, "MPI_ERR_RANK"),
    (Cint, "MPI_ERR_READ_ONLY"),
    (Cint, "MPI_ERR_REQUEST"),
    (Cint, "MPI_ERR_RMA_ATTACH"),
    (Cint, "MPI_ERR_RMA_CONFLICT"),
    (Cint, "MPI_ERR_RMA_FLAVOR"),
    (Cint, "MPI_ERR_RMA_RANGE"),
    (Cint, "MPI_ERR_RMA_SHARED"),
    (Cint, "MPI_ERR_RMA_SYNC"),
    (Cint, "MPI_ERR_ROOT"),
    (Cint, "MPI_ERR_SERVICE"),
    (Cint, "MPI_ERR_SIZE"),
    (Cint, "MPI_ERR_SPAWN"),
    (Cint, "MPI_ERR_TAG"),
    (Cint, "MPI_ERR_TOPOLOGY"),
    (Cint, "MPI_ERR_TRUNCATE"),
    (Cint, "MPI_ERR_TYPE"),
    (Cint, "MPI_ERR_UNKNOWN"),
    (Cint, "MPI_ERR_UNSUPPORTED_DATAREP"),
    (Cint, "MPI_ERR_UNSUPPORTED_OPERATION"),
    (Cint, "MPI_ERR_WIN"),
    (Cint, "MPI_SUCCESS"),

    (Cint, "MPI_LOCK_EXCLUSIVE"),
    (Cint, "MPI_LOCK_SHARED"),

    (Cint, "MPI_MODE_APPEND"),
    (Cint, "MPI_MODE_CREATE"),
    (Cint, "MPI_MODE_DELETE_ON_CLOSE"),
    (Cint, "MPI_MODE_EXCL"),
    (Cint, "MPI_MODE_NOCHECK"),
    (Cint, "MPI_MODE_NOPRECEDE"),
    (Cint, "MPI_MODE_NOPUT"),
    (Cint, "MPI_MODE_NOSTORE"),
    (Cint, "MPI_MODE_NOSUCCEED"),
    (Cint, "MPI_MODE_RDONLY"),
    (Cint, "MPI_MODE_RDWR"),
    (Cint, "MPI_MODE_SEQUENTIAL"),
    (Cint, "MPI_MODE_UNIQUE_OPEN"),
    (Cint, "MPI_MODE_WRONLY"),

    # File operation constants
    (Cint, "MPI_ORDER_C"),
    (Cint, "MPI_ORDER_FORTRAN"),

    # File operation constants
    (Cint, "MPI_SEEK_CUR"),
    (Cint, "MPI_SEEK_END"),
    (Cint, "MPI_SEEK_SET"),

    (Cint, "MPI_THREAD_SINGLE"),
    (Cint, "MPI_THREAD_FUNNELED"),
    (Cint, "MPI_THREAD_SERIALIZED"),
    (Cint, "MPI_THREAD_MULTIPLE"),

    (Ptr{Cint}, "MPI_UNWEIGHTED"),
    (Ptr{Cint}, "MPI_WEIGHTS_EMPTY"),

    (Ptr{Cvoid}, "MPI_BOTTOM"),

    (Ptr{Cvoid}, "MPI_IN_PLACE"),

    (MPI_Comm, "MPI_COMM_NULL"),
    (MPI_Comm, "MPI_COMM_SELF"),
    (MPI_Comm, "MPI_COMM_WORLD"),

    # MPI_Comm_copy_attr_function*
    (Ptr{Cvoid}, "MPI_COMM_DUP_FN"),
    (Ptr{Cvoid}, "MPI_COMM_NULL_COPY_FN"),

    # MPI_Comm_delete_attr_function*
    (Ptr{Cvoid}, "MPI_COMM_NULL_DELETE_FN"),

    # MPI_Copy_function*
    (Ptr{Cvoid}, "MPI_NULL_COPY_FN"),

    (MPI_Datatype, "MPI_2DOUBLE_PRECISION"),
    (MPI_Datatype, "MPI_2INT"),
    (MPI_Datatype, "MPI_2INTEGER"),
    (MPI_Datatype, "MPI_2REAL"),
    (MPI_Datatype, "MPI_AINT"),
    (MPI_Datatype, "MPI_BYTE"),
    (MPI_Datatype, "MPI_CHAR"),
    (MPI_Datatype, "MPI_CHARACTER"),
    (MPI_Datatype, "MPI_COMPLEX"),
    (MPI_Datatype, "MPI_COMPLEX16"),
    (MPI_Datatype, "MPI_COMPLEX32"),
    (MPI_Datatype, "MPI_COMPLEX8"),
    (MPI_Datatype, "MPI_COUNT"),
    (MPI_Datatype, "MPI_CXX_BOOL"),
    (MPI_Datatype, "MPI_CXX_DOUBLE_COMPLEX"),
    (MPI_Datatype, "MPI_CXX_FLOAT_COMPLEX"),
    (MPI_Datatype, "MPI_CXX_LONG_DOUBLE_COMPLEX"),
    (MPI_Datatype, "MPI_C_BOOL"),
    (MPI_Datatype, "MPI_C_COMPLEX"),
    (MPI_Datatype, "MPI_C_DOUBLE_COMPLEX"),
    (MPI_Datatype, "MPI_C_FLOAT_COMPLEX"),
    (MPI_Datatype, "MPI_C_LONG_DOUBLE_COMPLEX"),
    (MPI_Datatype, "MPI_DATATYPE_NULL"),
    (MPI_Datatype, "MPI_DOUBLE"),
    (MPI_Datatype, "MPI_DOUBLE_COMPLEX"),
    (MPI_Datatype, "MPI_DOUBLE_INT"),
    (MPI_Datatype, "MPI_DOUBLE_PRECISION"),
    (MPI_Datatype, "MPI_FLOAT"),
    (MPI_Datatype, "MPI_FLOAT_INT"),
    (MPI_Datatype, "MPI_INT"),
    (MPI_Datatype, "MPI_INT16_T"),
    (MPI_Datatype, "MPI_INT32_T"),
    (MPI_Datatype, "MPI_INT64_T"),
    (MPI_Datatype, "MPI_INT8_T"),
    (MPI_Datatype, "MPI_INTEGER"),
    (MPI_Datatype, "MPI_INTEGER1"),
    (MPI_Datatype, "MPI_INTEGER2"),
    (MPI_Datatype, "MPI_INTEGER4"),
    (MPI_Datatype, "MPI_INTEGER8"),
    (MPI_Datatype, "MPI_LOGICAL"),
    (MPI_Datatype, "MPI_LONG"),
    (MPI_Datatype, "MPI_LONG_DOUBLE"),
    (MPI_Datatype, "MPI_LONG_DOUBLE_INT"),
    (MPI_Datatype, "MPI_LONG_INT"),
    (MPI_Datatype, "MPI_LONG_LONG"),
    (MPI_Datatype, "MPI_LONG_LONG_INT"),
    (MPI_Datatype, "MPI_OFFSET"),
    (MPI_Datatype, "MPI_PACKED"),
    (MPI_Datatype, "MPI_REAL"),
    (MPI_Datatype, "MPI_REAL16"),
    (MPI_Datatype, "MPI_REAL4"),
    (MPI_Datatype, "MPI_REAL8"),
    (MPI_Datatype, "MPI_SHORT"),
    (MPI_Datatype, "MPI_SHORT_INT"),
    (MPI_Datatype, "MPI_SIGNED_CHAR"),
    (MPI_Datatype, "MPI_UINT16_T"),
    (MPI_Datatype, "MPI_UINT32_T"),
    (MPI_Datatype, "MPI_UINT64_T"),
    (MPI_Datatype, "MPI_UINT8_T"),
    (MPI_Datatype, "MPI_UNSIGNED"),
    (MPI_Datatype, "MPI_UNSIGNED_CHAR"),
    (MPI_Datatype, "MPI_UNSIGNED_LONG"),
    (MPI_Datatype, "MPI_UNSIGNED_LONG_LONG"),
    (MPI_Datatype, "MPI_UNSIGNED_SHORT"),
    (MPI_Datatype, "MPI_WCHAR"),

    # MPI_Delete_function*
    (Ptr{Cvoid}, "MPI_NULL_DELETE_FN"),

    (MPI_Errhandler, "MPI_ERRHANDLER_NULL"),
    (MPI_Errhandler, "MPI_ERRORS_ARE_FATAL"),
    (MPI_Errhandler, "MPI_ERRORS_RETURN"),

    (MPI_File, "MPI_FILE_NULL"),
 
    (MPI_Group, "MPI_GROUP_EMPTY"),
    (MPI_Group, "MPI_GROUP_NULL"),

    (MPI_Info, "MPI_INFO_ENV"),
    (MPI_Info, "MPI_INFO_NULL"),

    (MPI_Message, "MPI_MESSAGE_NO_PROC"),
    (MPI_Message, "MPI_MESSAGE_NULL"),

    (MPI_Op, "MPI_BAND"),
    (MPI_Op, "MPI_BOR"),
    (MPI_Op, "MPI_BXOR"),
    (MPI_Op, "MPI_LAND"),
    (MPI_Op, "MPI_LOR"),
    (MPI_Op, "MPI_LXOR"),
    (MPI_Op, "MPI_MAX"),
    (MPI_Op, "MPI_MAXLOC"),
    (MPI_Op, "MPI_MIN"),
    (MPI_Op, "MPI_MINLOC"),
    (MPI_Op, "MPI_NO_OP"),
    (MPI_Op, "MPI_OP_NULL"),
    (MPI_Op, "MPI_PROD"),
    (MPI_Op, "MPI_REPLACE"),
    (MPI_Op, "MPI_SUM"),

    (MPI_Request, "MPI_REQUEST_NULL"),

    (Ptr{MPI_Status}, "MPI_STATUS_IGNORE"),
    (Ptr{MPI_Status}, "MPI_STATUSES_IGNORE"),

    # MPI_Type_copy_attr_function*
    (Ptr{Cvoid}, "MPI_TYPE_DUP_FN"),
    (Ptr{Cvoid}, "MPI_TYPE_NULL_COPY_FN"),

    # MPI_Type_delete_attr_function*
    (Ptr{Cvoid}, "MPI_TYPE_NULL_DELETE_FN"),

    (MPI_Win, "MPI_WIN_NULL"),

    # MPI_Win_copy_attr_function*
    (Ptr{Cvoid}, "MPI_WIN_DUP_FN"),
    (Ptr{Cvoid}, "MPI_WIN_NULL_COPY_FN"),

    # MPI_Win_delete_attr_function*
    (Ptr{Cvoid}, "MPI_WIN_NULL_DELETE_FN"),
]

@show "loading module"
for (tp,nm) in _constants
    @eval $nm = $tp(0)
end
@show MPI_COMM_WORLD

################################################################################

_getsym(T, sym) = unsafe_load(cglobal((sym, libmpi), T))

function init_mpitrampoline_constants()
    # Idea: Store MPI constants in `const` global variables with a `mutable` type

    @show "initializing module"
    @show MPI_COMM_WORLD
    for (tp,nm) in _constants
        @eval global $nm = _getsym($tp, $nm)
    end
    @show MPI_COMM_WORLD

    @show COMM_WORLD
    COMM_NULL.val  = MPI_COMM_NULL
    COMM_SELF.val  = MPI_COMM_SELF
    COMM_WORLD.val = MPI_COMM_WORLD
    @show COMM_WORLD
end
