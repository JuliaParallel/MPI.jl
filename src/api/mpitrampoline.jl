# Compile-time constants

# Implementation limits:
const MPI_MAX_DATAREP_STRING = Cint(128)
const MPI_MAX_ERROR_STRING = Cint(1024)
const MPI_MAX_INFO_KEY = Cint(256)
const MPI_MAX_INFO_VAL = Cint(1024)
const MPI_MAX_LIBRARY_VERSION_STRING = Cint(8192)
const MPI_MAX_OBJECT_NAME = Cint(128)
const MPI_MAX_PORT_NAME = Cint(1024)
const MPI_MAX_PROCESSOR_NAME = Cint(256)

# Types

# Various (signed) integer types:
const MPI_Aint = Int64
const MPI_Count = Int64
const MPI_Fint = Int32
const MPI_Offset = Int64

# Status:
struct MPI_Status
    _private0::Cint
    _private1::Cint
    _private2::Cint
    _private3::Cint
    _private4::Csize_t
    MPI_SOURCE::Cint
    MPI_TAG::Cint
    MPI_ERROR::Cint
end

# Opaque handles:
const MPI_Comm = UInt
const MPI_Datatype = UInt
const MPI_Errhandler = UInt
const MPI_File = UInt
const MPI_Group = UInt
const MPI_Info = UInt
const MPI_Message = UInt
const MPI_Op = UInt
const MPI_Request = UInt
const MPI_Win = UInt

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


@const_ref MPI_ANY_SOURCE Cint unsafe_load(cglobal((:MPICONSTANTS_ANY_SOURCE, libmpiconstants), Cint))
@const_ref MPI_ANY_TAG Cint unsafe_load(cglobal((:MPICONSTANTS_ANY_TAG, libmpiconstants), Cint))
@const_ref MPI_PROC_NULL Cint unsafe_load(cglobal((:MPICONSTANTS_PROC_NULL, libmpiconstants), Cint))
@const_ref MPI_ROOT Cint unsafe_load(cglobal((:MPICONSTANTS_ROOT, libmpiconstants), Cint))
@const_ref MPI_CART Cint unsafe_load(cglobal((:MPICONSTANTS_CART, libmpiconstants), Cint))
@const_ref MPI_DIST_GRAPH Cint unsafe_load(cglobal((:MPICONSTANTS_DIST_GRAPH, libmpiconstants), Cint))
@const_ref MPI_GRAPH Cint unsafe_load(cglobal((:MPICONSTANTS_GRAPH, libmpiconstants), Cint))
@const_ref MPI_CONGRUENT Cint unsafe_load(cglobal((:MPICONSTANTS_CONGRUENT, libmpiconstants), Cint))
@const_ref MPI_IDENT Cint unsafe_load(cglobal((:MPICONSTANTS_IDENT, libmpiconstants), Cint))
@const_ref MPI_SIMILAR Cint unsafe_load(cglobal((:MPICONSTANTS_SIMILAR, libmpiconstants), Cint))
@const_ref MPI_UNEQUAL Cint unsafe_load(cglobal((:MPICONSTANTS_UNEQUAL, libmpiconstants), Cint))
@const_ref MPI_KEYVAL_INVALID Cint unsafe_load(cglobal((:MPICONSTANTS_KEYVAL_INVALID, libmpiconstants), Cint))
@const_ref MPI_UNDEFINED Cint unsafe_load(cglobal((:MPICONSTANTS_UNDEFINED, libmpiconstants), Cint))
@const_ref MPI_APPNUM Cint unsafe_load(cglobal((:MPICONSTANTS_APPNUM, libmpiconstants), Cint))
@const_ref MPI_HOST Cint unsafe_load(cglobal((:MPICONSTANTS_HOST, libmpiconstants), Cint))
@const_ref MPI_IO Cint unsafe_load(cglobal((:MPICONSTANTS_IO, libmpiconstants), Cint))
@const_ref MPI_LASTUSEDCODE Cint unsafe_load(cglobal((:MPICONSTANTS_LASTUSEDCODE, libmpiconstants), Cint))
@const_ref MPI_TAG_UB Cint unsafe_load(cglobal((:MPICONSTANTS_TAG_UB, libmpiconstants), Cint))
@const_ref MPI_UNIVERSE_SIZE Cint unsafe_load(cglobal((:MPICONSTANTS_UNIVERSE_SIZE, libmpiconstants), Cint))
@const_ref MPI_WIN_BASE Cint unsafe_load(cglobal((:MPICONSTANTS_WIN_BASE, libmpiconstants), Cint))
@const_ref MPI_WIN_CREATE_FLAVOR Cint unsafe_load(cglobal((:MPICONSTANTS_WIN_CREATE_FLAVOR, libmpiconstants), Cint))
@const_ref MPI_WIN_DISP_UNIT Cint unsafe_load(cglobal((:MPICONSTANTS_WIN_DISP_UNIT, libmpiconstants), Cint))
@const_ref MPI_WIN_MODEL Cint unsafe_load(cglobal((:MPICONSTANTS_WIN_MODEL, libmpiconstants), Cint))
@const_ref MPI_WIN_SIZE Cint unsafe_load(cglobal((:MPICONSTANTS_WIN_SIZE, libmpiconstants), Cint))
@const_ref MPI_WTIME_IS_GLOBAL Cint unsafe_load(cglobal((:MPICONSTANTS_WTIME_IS_GLOBAL, libmpiconstants), Cint))
@const_ref MPI_COMBINER_CONTIGUOUS Cint unsafe_load(cglobal((:MPICONSTANTS_COMBINER_CONTIGUOUS, libmpiconstants), Cint))
@const_ref MPI_COMBINER_DARRAY Cint unsafe_load(cglobal((:MPICONSTANTS_COMBINER_DARRAY, libmpiconstants), Cint))
@const_ref MPI_COMBINER_DUP Cint unsafe_load(cglobal((:MPICONSTANTS_COMBINER_DUP, libmpiconstants), Cint))
@const_ref MPI_COMBINER_F90_COMPLEX Cint unsafe_load(cglobal((:MPICONSTANTS_COMBINER_F90_COMPLEX, libmpiconstants), Cint))
@const_ref MPI_COMBINER_F90_INTEGER Cint unsafe_load(cglobal((:MPICONSTANTS_COMBINER_F90_INTEGER, libmpiconstants), Cint))
@const_ref MPI_COMBINER_F90_REAL Cint unsafe_load(cglobal((:MPICONSTANTS_COMBINER_F90_REAL, libmpiconstants), Cint))
@const_ref MPI_COMBINER_HINDEXED Cint unsafe_load(cglobal((:MPICONSTANTS_COMBINER_HINDEXED, libmpiconstants), Cint))
@const_ref MPI_COMBINER_HINDEXED_BLOCK Cint unsafe_load(cglobal((:MPICONSTANTS_COMBINER_HINDEXED_BLOCK, libmpiconstants), Cint))
@const_ref MPI_COMBINER_HVECTOR Cint unsafe_load(cglobal((:MPICONSTANTS_COMBINER_HVECTOR, libmpiconstants), Cint))
@const_ref MPI_COMBINER_INDEXED Cint unsafe_load(cglobal((:MPICONSTANTS_COMBINER_INDEXED, libmpiconstants), Cint))
@const_ref MPI_COMBINER_INDEXED_BLOCK Cint unsafe_load(cglobal((:MPICONSTANTS_COMBINER_INDEXED_BLOCK, libmpiconstants), Cint))
@const_ref MPI_COMBINER_NAMED Cint unsafe_load(cglobal((:MPICONSTANTS_COMBINER_NAMED, libmpiconstants), Cint))
@const_ref MPI_COMBINER_RESIZED Cint unsafe_load(cglobal((:MPICONSTANTS_COMBINER_RESIZED, libmpiconstants), Cint))
@const_ref MPI_COMBINER_STRUCT Cint unsafe_load(cglobal((:MPICONSTANTS_COMBINER_STRUCT, libmpiconstants), Cint))
@const_ref MPI_COMBINER_SUBARRAY Cint unsafe_load(cglobal((:MPICONSTANTS_COMBINER_SUBARRAY, libmpiconstants), Cint))
@const_ref MPI_COMBINER_VECTOR Cint unsafe_load(cglobal((:MPICONSTANTS_COMBINER_VECTOR, libmpiconstants), Cint))
@const_ref MPI_COMM_TYPE_SHARED Cint unsafe_load(cglobal((:MPICONSTANTS_COMM_TYPE_SHARED, libmpiconstants), Cint))
@const_ref MPI_DISTRIBUTE_BLOCK Cint unsafe_load(cglobal((:MPICONSTANTS_DISTRIBUTE_BLOCK, libmpiconstants), Cint))
@const_ref MPI_DISTRIBUTE_CYCLIC Cint unsafe_load(cglobal((:MPICONSTANTS_DISTRIBUTE_CYCLIC, libmpiconstants), Cint))
@const_ref MPI_DISTRIBUTE_NONE Cint unsafe_load(cglobal((:MPICONSTANTS_DISTRIBUTE_NONE, libmpiconstants), Cint))
@const_ref MPI_ERR_ACCESS Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_ACCESS, libmpiconstants), Cint))
@const_ref MPI_ERR_AMODE Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_AMODE, libmpiconstants), Cint))
@const_ref MPI_ERR_ARG Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_ARG, libmpiconstants), Cint))
@const_ref MPI_ERR_ASSERT Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_ASSERT, libmpiconstants), Cint))
@const_ref MPI_ERR_BAD_FILE Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_BAD_FILE, libmpiconstants), Cint))
@const_ref MPI_ERR_BASE Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_BASE, libmpiconstants), Cint))
@const_ref MPI_ERR_BUFFER Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_BUFFER, libmpiconstants), Cint))
@const_ref MPI_ERR_COMM Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_COMM, libmpiconstants), Cint))
@const_ref MPI_ERR_CONVERSION Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_CONVERSION, libmpiconstants), Cint))
@const_ref MPI_ERR_COUNT Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_COUNT, libmpiconstants), Cint))
@const_ref MPI_ERR_DIMS Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_DIMS, libmpiconstants), Cint))
@const_ref MPI_ERR_DISP Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_DISP, libmpiconstants), Cint))
@const_ref MPI_ERR_DUP_DATAREP Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_DUP_DATAREP, libmpiconstants), Cint))
@const_ref MPI_ERR_FILE Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_FILE, libmpiconstants), Cint))
@const_ref MPI_ERR_FILE_EXISTS Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_FILE_EXISTS, libmpiconstants), Cint))
@const_ref MPI_ERR_FILE_IN_USE Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_FILE_IN_USE, libmpiconstants), Cint))
@const_ref MPI_ERR_GROUP Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_GROUP, libmpiconstants), Cint))
@const_ref MPI_ERR_INFO Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_INFO, libmpiconstants), Cint))
@const_ref MPI_ERR_INFO_KEY Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_INFO_KEY, libmpiconstants), Cint))
@const_ref MPI_ERR_INFO_NOKEY Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_INFO_NOKEY, libmpiconstants), Cint))
@const_ref MPI_ERR_INFO_VALUE Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_INFO_VALUE, libmpiconstants), Cint))
@const_ref MPI_ERR_INTERN Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_INTERN, libmpiconstants), Cint))
@const_ref MPI_ERR_IN_STATUS Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_IN_STATUS, libmpiconstants), Cint))
@const_ref MPI_ERR_IO Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_IO, libmpiconstants), Cint))
@const_ref MPI_ERR_KEYVAL Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_KEYVAL, libmpiconstants), Cint))
@const_ref MPI_ERR_LASTCODE Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_LASTCODE, libmpiconstants), Cint))
@const_ref MPI_ERR_LOCKTYPE Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_LOCKTYPE, libmpiconstants), Cint))
@const_ref MPI_ERR_NAME Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_NAME, libmpiconstants), Cint))
@const_ref MPI_ERR_NOT_SAME Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_NOT_SAME, libmpiconstants), Cint))
@const_ref MPI_ERR_NO_MEM Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_NO_MEM, libmpiconstants), Cint))
@const_ref MPI_ERR_NO_SPACE Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_NO_SPACE, libmpiconstants), Cint))
@const_ref MPI_ERR_NO_SUCH_FILE Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_NO_SUCH_FILE, libmpiconstants), Cint))
@const_ref MPI_ERR_OP Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_OP, libmpiconstants), Cint))
@const_ref MPI_ERR_OTHER Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_OTHER, libmpiconstants), Cint))
@const_ref MPI_ERR_PENDING Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_PENDING, libmpiconstants), Cint))
@const_ref MPI_ERR_PORT Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_PORT, libmpiconstants), Cint))
@const_ref MPI_ERR_QUOTA Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_QUOTA, libmpiconstants), Cint))
@const_ref MPI_ERR_RANK Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_RANK, libmpiconstants), Cint))
@const_ref MPI_ERR_READ_ONLY Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_READ_ONLY, libmpiconstants), Cint))
@const_ref MPI_ERR_REQUEST Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_REQUEST, libmpiconstants), Cint))
@const_ref MPI_ERR_RMA_ATTACH Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_RMA_ATTACH, libmpiconstants), Cint))
@const_ref MPI_ERR_RMA_CONFLICT Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_RMA_CONFLICT, libmpiconstants), Cint))
@const_ref MPI_ERR_RMA_FLAVOR Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_RMA_FLAVOR, libmpiconstants), Cint))
@const_ref MPI_ERR_RMA_RANGE Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_RMA_RANGE, libmpiconstants), Cint))
@const_ref MPI_ERR_RMA_SHARED Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_RMA_SHARED, libmpiconstants), Cint))
@const_ref MPI_ERR_RMA_SYNC Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_RMA_SYNC, libmpiconstants), Cint))
@const_ref MPI_ERR_ROOT Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_ROOT, libmpiconstants), Cint))
@const_ref MPI_ERR_SERVICE Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_SERVICE, libmpiconstants), Cint))
@const_ref MPI_ERR_SIZE Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_SIZE, libmpiconstants), Cint))
@const_ref MPI_ERR_SPAWN Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_SPAWN, libmpiconstants), Cint))
@const_ref MPI_ERR_TAG Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_TAG, libmpiconstants), Cint))
@const_ref MPI_ERR_TOPOLOGY Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_TOPOLOGY, libmpiconstants), Cint))
@const_ref MPI_ERR_TRUNCATE Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_TRUNCATE, libmpiconstants), Cint))
@const_ref MPI_ERR_TYPE Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_TYPE, libmpiconstants), Cint))
@const_ref MPI_ERR_UNKNOWN Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_UNKNOWN, libmpiconstants), Cint))
@const_ref MPI_ERR_UNSUPPORTED_DATAREP Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_UNSUPPORTED_DATAREP, libmpiconstants), Cint))
@const_ref MPI_ERR_UNSUPPORTED_OPERATION Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_UNSUPPORTED_OPERATION, libmpiconstants), Cint))
@const_ref MPI_ERR_WIN Cint unsafe_load(cglobal((:MPICONSTANTS_ERR_WIN, libmpiconstants), Cint))

@const_ref MPI_SUCCESS Cint unsafe_load(cglobal((:MPICONSTANTS_SUCCESS, libmpiconstants), Cint))
@const_ref MPI_LOCK_EXCLUSIVE Cint unsafe_load(cglobal((:MPICONSTANTS_LOCK_EXCLUSIVE, libmpiconstants), Cint))
@const_ref MPI_LOCK_SHARED Cint unsafe_load(cglobal((:MPICONSTANTS_LOCK_SHARED, libmpiconstants), Cint))
@const_ref MPI_MODE_APPEND Cint unsafe_load(cglobal((:MPICONSTANTS_MODE_APPEND, libmpiconstants), Cint))
@const_ref MPI_MODE_CREATE Cint unsafe_load(cglobal((:MPICONSTANTS_MODE_CREATE, libmpiconstants), Cint))
@const_ref MPI_MODE_DELETE_ON_CLOSE Cint unsafe_load(cglobal((:MPICONSTANTS_MODE_DELETE_ON_CLOSE, libmpiconstants), Cint))
@const_ref MPI_MODE_EXCL Cint unsafe_load(cglobal((:MPICONSTANTS_MODE_EXCL, libmpiconstants), Cint))
@const_ref MPI_MODE_NOCHECK Cint unsafe_load(cglobal((:MPICONSTANTS_MODE_NOCHECK, libmpiconstants), Cint))
@const_ref MPI_MODE_NOPRECEDE Cint unsafe_load(cglobal((:MPICONSTANTS_MODE_NOPRECEDE, libmpiconstants), Cint))
@const_ref MPI_MODE_NOPUT Cint unsafe_load(cglobal((:MPICONSTANTS_MODE_NOPUT, libmpiconstants), Cint))
@const_ref MPI_MODE_NOSTORE Cint unsafe_load(cglobal((:MPICONSTANTS_MODE_NOSTORE, libmpiconstants), Cint))
@const_ref MPI_MODE_NOSUCCEED Cint unsafe_load(cglobal((:MPICONSTANTS_MODE_NOSUCCEED, libmpiconstants), Cint))
@const_ref MPI_MODE_RDONLY Cint unsafe_load(cglobal((:MPICONSTANTS_MODE_RDONLY, libmpiconstants), Cint))
@const_ref MPI_MODE_RDWR Cint unsafe_load(cglobal((:MPICONSTANTS_MODE_RDWR, libmpiconstants), Cint))
@const_ref MPI_MODE_SEQUENTIAL Cint unsafe_load(cglobal((:MPICONSTANTS_MODE_SEQUENTIAL, libmpiconstants), Cint))
@const_ref MPI_MODE_UNIQUE_OPEN Cint unsafe_load(cglobal((:MPICONSTANTS_MODE_UNIQUE_OPEN, libmpiconstants), Cint))
@const_ref MPI_MODE_WRONLY Cint unsafe_load(cglobal((:MPICONSTANTS_MODE_WRONLY, libmpiconstants), Cint))
@const_ref MPI_ORDER_C Cint unsafe_load(cglobal((:MPICONSTANTS_ORDER_C, libmpiconstants), Cint))
@const_ref MPI_ORDER_FORTRAN Cint unsafe_load(cglobal((:MPICONSTANTS_ORDER_FORTRAN, libmpiconstants), Cint))
@const_ref MPI_SEEK_CUR Cint unsafe_load(cglobal((:MPICONSTANTS_SEEK_CUR, libmpiconstants), Cint))
@const_ref MPI_SEEK_END Cint unsafe_load(cglobal((:MPICONSTANTS_SEEK_END, libmpiconstants), Cint))
@const_ref MPI_SEEK_SET Cint unsafe_load(cglobal((:MPICONSTANTS_SEEK_SET, libmpiconstants), Cint))
@const_ref MPI_THREAD_SINGLE Cint unsafe_load(cglobal((:MPICONSTANTS_THREAD_SINGLE, libmpiconstants), Cint))
@const_ref MPI_THREAD_FUNNELED Cint unsafe_load(cglobal((:MPICONSTANTS_THREAD_FUNNELED, libmpiconstants), Cint))
@const_ref MPI_THREAD_SERIALIZED Cint unsafe_load(cglobal((:MPICONSTANTS_THREAD_SERIALIZED, libmpiconstants), Cint))
@const_ref MPI_THREAD_MULTIPLE Cint unsafe_load(cglobal((:MPICONSTANTS_THREAD_MULTIPLE, libmpiconstants), Cint))
@const_ref MPI_TYPECLASS_COMPLEX Cint unsafe_load(cglobal((:MPICONSTANTS_TYPECLASS_COMPLEX, libmpiconstants), Cint))
@const_ref MPI_TYPECLASS_INTEGER Cint unsafe_load(cglobal((:MPICONSTANTS_TYPECLASS_INTEGER, libmpiconstants), Cint))
@const_ref MPI_TYPECLASS_REAL Cint unsafe_load(cglobal((:MPICONSTANTS_TYPECLASS_REAL, libmpiconstants), Cint))

@const_ref MPI_ARGV_NULL Ptr{Cchar} unsafe_load(cglobal((:MPICONSTANTS_ARGV_NULL, libmpiconstants), Ptr{Ptr{Cchar}}))
@const_ref MPI_ARGVS_NULL Ptr{Cchar} unsafe_load(cglobal((:MPICONSTANTS_ARGVS_NULL, libmpiconstants), Ptr{Ptr{Ptr{Cchar}}}))
@const_ref MPI_UNWEIGHTED Ptr{Cint} unsafe_load(cglobal((:MPICONSTANTS_UNWEIGHTED, libmpiconstants), Ptr{Cint}))
@const_ref MPI_WEIGHTS_EMPTY Ptr{Cint} unsafe_load(cglobal((:MPICONSTANTS_WEIGHTS_EMPTY, libmpiconstants), Ptr{Cint}))
@const_ref MPI_BOTTOM Ptr{Cvoid} unsafe_load(cglobal((:MPICONSTANTS_BOTTOM, libmpiconstants), Ptr{Cvoid}))
@const_ref MPI_IN_PLACE Ptr{Cvoid} unsafe_load(cglobal((:MPICONSTANTS_IN_PLACE, libmpiconstants), Ptr{Cvoid}))

@const_ref MPI_COMM_NULL MPI_Comm unsafe_load(cglobal((:MPICONSTANTS_COMM_NULL , libmpiconstants), MPI_Comm))
@const_ref MPI_COMM_SELF MPI_Comm unsafe_load(cglobal((:MPICONSTANTS_COMM_SELF , libmpiconstants), MPI_Comm))
@const_ref MPI_COMM_WORLD MPI_Comm unsafe_load(cglobal((:MPICONSTANTS_COMM_WORLD, libmpiconstants), MPI_Comm))

@const_ref MPI_COMM_DUP_FN MPI_Comm_copy_attr_function unsafe_load(cglobal((:MPICONSTANTS_COMM_DUP_FN, libmpiconstants), MPI_Comm_copy_attr_function))
@const_ref MPI_COMM_NULL_COPY_FN MPI_Comm_copy_attr_function unsafe_load(cglobal((:MPICONSTANTS_COMM_NULL_COPY_FN, libmpiconstants), MPI_Comm_copy_attr_function))
@const_ref MPI_COMM_NULL_DELETE_FN MPI_Comm_delete_attr_function unsafe_load(cglobal((:MPICONSTANTS_COMM_NULL_DELETE_FN, libmpiconstants), MPI_Comm_delete_attr_function))

@const_ref MPI_NULL_COPY_FN MPI_Copy_function unsafe_load(cglobal((:MPICONSTANTS_NULL_COPY_FN, libmpiconstants), MPI_Copy_function))

@const_ref MPI_2DOUBLE_PRECISION MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_2DOUBLE_PRECISION, libmpiconstants), MPI_Datatype))
@const_ref MPI_2INT MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_2INT, libmpiconstants), MPI_Datatype))
@const_ref MPI_2INTEGER MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_2INTEGER, libmpiconstants), MPI_Datatype))
@const_ref MPI_2REAL MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_2REAL, libmpiconstants), MPI_Datatype))
@const_ref MPI_AINT MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_AINT, libmpiconstants), MPI_Datatype))
@const_ref MPI_BYTE MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_BYTE, libmpiconstants), MPI_Datatype))
@const_ref MPI_CHAR MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_CHAR, libmpiconstants), MPI_Datatype))
@const_ref MPI_CHARACTER MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_CHARACTER, libmpiconstants), MPI_Datatype))
@const_ref MPI_COMPLEX MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_COMPLEX, libmpiconstants), MPI_Datatype))
@const_ref MPI_COMPLEX16 MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_COMPLEX16, libmpiconstants), MPI_Datatype))
# MPI_COMPLEX32 MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_COMPLEX32, libmpiconstants), MPI_Datatype))
@const_ref MPI_COMPLEX8 MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_COMPLEX8, libmpiconstants), MPI_Datatype))
@const_ref MPI_COUNT MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_COUNT, libmpiconstants), MPI_Datatype))
@const_ref MPI_CXX_BOOL MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_CXX_BOOL, libmpiconstants), MPI_Datatype))
@const_ref MPI_CXX_DOUBLE_COMPLEX MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_CXX_DOUBLE_COMPLEX, libmpiconstants), MPI_Datatype))
@const_ref MPI_CXX_FLOAT_COMPLEX MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_CXX_FLOAT_COMPLEX, libmpiconstants), MPI_Datatype))
@const_ref MPI_CXX_LONG_DOUBLE_COMPLEX MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_CXX_LONG_DOUBLE_COMPLEX, libmpiconstants), MPI_Datatype))
@const_ref MPI_C_BOOL MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_C_BOOL, libmpiconstants), MPI_Datatype))
@const_ref MPI_C_COMPLEX MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_C_COMPLEX, libmpiconstants), MPI_Datatype))
@const_ref MPI_C_DOUBLE_COMPLEX MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_C_DOUBLE_COMPLEX, libmpiconstants), MPI_Datatype))
@const_ref MPI_C_FLOAT_COMPLEX MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_C_FLOAT_COMPLEX, libmpiconstants), MPI_Datatype))
@const_ref MPI_C_LONG_DOUBLE_COMPLEX MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_C_LONG_DOUBLE_COMPLEX, libmpiconstants), MPI_Datatype))
@const_ref MPI_DATATYPE_NULL MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_DATATYPE_NULL, libmpiconstants), MPI_Datatype))
@const_ref MPI_DOUBLE MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_DOUBLE, libmpiconstants), MPI_Datatype))
@const_ref MPI_DOUBLE_COMPLEX MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_DOUBLE_COMPLEX, libmpiconstants), MPI_Datatype))
@const_ref MPI_DOUBLE_INT MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_DOUBLE_INT, libmpiconstants), MPI_Datatype))
@const_ref MPI_DOUBLE_PRECISION MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_DOUBLE_PRECISION, libmpiconstants), MPI_Datatype))
@const_ref MPI_FLOAT MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_FLOAT, libmpiconstants), MPI_Datatype))
@const_ref MPI_FLOAT_INT MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_FLOAT_INT, libmpiconstants), MPI_Datatype))
@const_ref MPI_INT MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_INT, libmpiconstants), MPI_Datatype))
@const_ref MPI_INT16_T MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_INT16_T, libmpiconstants), MPI_Datatype))
@const_ref MPI_INT32_T MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_INT32_T, libmpiconstants), MPI_Datatype))
@const_ref MPI_INT64_T MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_INT64_T, libmpiconstants), MPI_Datatype))
@const_ref MPI_INT8_T MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_INT8_T, libmpiconstants), MPI_Datatype))
@const_ref MPI_INTEGER MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_INTEGER, libmpiconstants), MPI_Datatype))
@const_ref MPI_INTEGER1 MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_INTEGER1, libmpiconstants), MPI_Datatype))
@const_ref MPI_INTEGER2 MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_INTEGER2, libmpiconstants), MPI_Datatype))
@const_ref MPI_INTEGER4 MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_INTEGER4, libmpiconstants), MPI_Datatype))
@const_ref MPI_INTEGER8 MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_INTEGER8, libmpiconstants), MPI_Datatype))
@const_ref MPI_LOGICAL MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_LOGICAL, libmpiconstants), MPI_Datatype))
@const_ref MPI_LONG MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_LONG, libmpiconstants), MPI_Datatype))
@const_ref MPI_LONG_DOUBLE MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_LONG_DOUBLE, libmpiconstants), MPI_Datatype))
@const_ref MPI_LONG_DOUBLE_INT MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_LONG_DOUBLE_INT, libmpiconstants), MPI_Datatype))
@const_ref MPI_LONG_INT MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_LONG_INT, libmpiconstants), MPI_Datatype))
@const_ref MPI_LONG_LONG MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_LONG_LONG, libmpiconstants), MPI_Datatype))
@const_ref MPI_LONG_LONG_INT MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_LONG_LONG_INT, libmpiconstants), MPI_Datatype))
@const_ref MPI_OFFSET MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_OFFSET, libmpiconstants), MPI_Datatype))
@const_ref MPI_PACKED MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_PACKED, libmpiconstants), MPI_Datatype))
@const_ref MPI_REAL MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_REAL, libmpiconstants), MPI_Datatype))
# MPI_REAL16 MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_REAL16, libmpiconstants), MPI_Datatype))
@const_ref MPI_REAL4 MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_REAL4, libmpiconstants), MPI_Datatype))
@const_ref MPI_REAL8 MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_REAL8, libmpiconstants), MPI_Datatype))
@const_ref MPI_SHORT MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_SHORT, libmpiconstants), MPI_Datatype))
@const_ref MPI_SHORT_INT MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_SHORT_INT, libmpiconstants), MPI_Datatype))
@const_ref MPI_SIGNED_CHAR MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_SIGNED_CHAR, libmpiconstants), MPI_Datatype))
@const_ref MPI_UINT16_T MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_UINT16_T, libmpiconstants), MPI_Datatype))
@const_ref MPI_UINT32_T MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_UINT32_T, libmpiconstants), MPI_Datatype))
@const_ref MPI_UINT64_T MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_UINT64_T, libmpiconstants), MPI_Datatype))
@const_ref MPI_UINT8_T MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_UINT8_T, libmpiconstants), MPI_Datatype))
@const_ref MPI_UNSIGNED MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_UNSIGNED, libmpiconstants), MPI_Datatype))
@const_ref MPI_UNSIGNED_CHAR MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_UNSIGNED_CHAR, libmpiconstants), MPI_Datatype))
@const_ref MPI_UNSIGNED_LONG MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_UNSIGNED_LONG, libmpiconstants), MPI_Datatype))
@const_ref MPI_UNSIGNED_LONG_LONG MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_UNSIGNED_LONG_LONG, libmpiconstants), MPI_Datatype))
@const_ref MPI_UNSIGNED_SHORT MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_UNSIGNED_SHORT, libmpiconstants), MPI_Datatype))
@const_ref MPI_WCHAR MPI_Datatype unsafe_load(cglobal((:MPICONSTANTS_WCHAR, libmpiconstants), MPI_Datatype))

@const_ref MPI_NULL_DELETE_FN MPI_Delete_function unsafe_load(cglobal((:MPICONSTANTS_NULL_DELETE_FN, libmpiconstants), MPI_Delete_function))

@const_ref MPI_ERRHANDLER_NULL MPI_Errhandler unsafe_load(cglobal((:MPICONSTANTS_ERRHANDLER_NULL, libmpiconstants), MPI_Errhandler))
@const_ref MPI_ERRORS_ARE_FATAL MPI_Errhandler unsafe_load(cglobal((:MPICONSTANTS_ERRORS_ARE_FATAL, libmpiconstants), MPI_Errhandler))
@const_ref MPI_ERRORS_RETURN MPI_Errhandler unsafe_load(cglobal((:MPICONSTANTS_ERRORS_RETURN, libmpiconstants), MPI_Errhandler))

@const_ref MPI_FILE_NULL MPI_File unsafe_load(cglobal((:MPICONSTANTS_FILE_NULL, libmpiconstants), MPI_File))

@const_ref MPI_GROUP_EMPTY MPI_Group unsafe_load(cglobal((:MPICONSTANTS_GROUP_EMPTY, libmpiconstants), MPI_Group))
@const_ref MPI_GROUP_NULL MPI_Group unsafe_load(cglobal((:MPICONSTANTS_GROUP_NULL, libmpiconstants), MPI_Group))

@const_ref MPI_INFO_ENV MPI_Info unsafe_load(cglobal((:MPICONSTANTS_INFO_ENV, libmpiconstants), MPI_Info))
@const_ref MPI_INFO_NULL MPI_Info unsafe_load(cglobal((:MPICONSTANTS_INFO_NULL, libmpiconstants), MPI_Info))

@const_ref MPI_MESSAGE_NO_PROC MPI_Message unsafe_load(cglobal((:MPICONSTANTS_MESSAGE_NO_PROC, libmpiconstants), MPI_Message))
@const_ref MPI_MESSAGE_NULL MPI_Message unsafe_load(cglobal((:MPICONSTANTS_MESSAGE_NULL, libmpiconstants), MPI_Message))

@const_ref MPI_DISPLACEMENT_CURRENT MPI_Offset unsafe_load(cglobal((:MPICONSTANTS_DISPLACEMENT_CURRENT, libmpiconstants), MPI_Offset))

@const_ref MPI_BAND MPI_Op unsafe_load(cglobal((:MPICONSTANTS_BAND, libmpiconstants), MPI_Op))
@const_ref MPI_BOR MPI_Op unsafe_load(cglobal((:MPICONSTANTS_BOR, libmpiconstants), MPI_Op))
@const_ref MPI_BXOR MPI_Op unsafe_load(cglobal((:MPICONSTANTS_BXOR, libmpiconstants), MPI_Op))
@const_ref MPI_LAND MPI_Op unsafe_load(cglobal((:MPICONSTANTS_LAND, libmpiconstants), MPI_Op))
@const_ref MPI_LOR MPI_Op unsafe_load(cglobal((:MPICONSTANTS_LOR, libmpiconstants), MPI_Op))
@const_ref MPI_LXOR MPI_Op unsafe_load(cglobal((:MPICONSTANTS_LXOR, libmpiconstants), MPI_Op))
@const_ref MPI_MAX MPI_Op unsafe_load(cglobal((:MPICONSTANTS_MAX, libmpiconstants), MPI_Op))
@const_ref MPI_MAXLOC MPI_Op unsafe_load(cglobal((:MPICONSTANTS_MAXLOC, libmpiconstants), MPI_Op))
@const_ref MPI_MIN MPI_Op unsafe_load(cglobal((:MPICONSTANTS_MIN, libmpiconstants), MPI_Op))
@const_ref MPI_MINLOC MPI_Op unsafe_load(cglobal((:MPICONSTANTS_MINLOC, libmpiconstants), MPI_Op))
@const_ref MPI_NO_OP MPI_Op unsafe_load(cglobal((:MPICONSTANTS_NO_OP, libmpiconstants), MPI_Op))
@const_ref MPI_OP_NULL MPI_Op unsafe_load(cglobal((:MPICONSTANTS_OP_NULL, libmpiconstants), MPI_Op))
@const_ref MPI_PROD MPI_Op unsafe_load(cglobal((:MPICONSTANTS_PROD, libmpiconstants), MPI_Op))
@const_ref MPI_REPLACE MPI_Op unsafe_load(cglobal((:MPICONSTANTS_REPLACE, libmpiconstants), MPI_Op))
@const_ref MPI_SUM MPI_Op unsafe_load(cglobal((:MPICONSTANTS_SUM, libmpiconstants), MPI_Op))

@const_ref MPI_REQUEST_NULL MPI_Request unsafe_load(cglobal((:MPICONSTANTS_REQUEST_NULL, libmpiconstants), MPI_Request))

@const_ref MPI_STATUS_IGNORE Ptr{MPI_Status} unsafe_load(cglobal((:MPICONSTANTS_STATUS_IGNORE, libmpiconstants), Ptr{MPI_Status}))
@const_ref MPI_STATUSES_IGNORE Ptr{MPI_Status} unsafe_load(cglobal((:MPICONSTANTS_STATUSES_IGNORE, libmpiconstants), Ptr{MPI_Status}))

@const_ref MPI_TYPE_DUP_FN MPI_Type_copy_attr_function unsafe_load(cglobal((:MPICONSTANTS_TYPE_DUP_FN, libmpiconstants), MPI_Type_copy_attr_function))
@const_ref MPI_TYPE_NULL_COPY_FN MPI_Type_copy_attr_function unsafe_load(cglobal((:MPICONSTANTS_TYPE_NULL_COPY_FN, libmpiconstants), MPI_Type_copy_attr_function))
@const_ref MPI_TYPE_NULL_DELETE_FN MPI_Type_delete_attr_function unsafe_load(cglobal((:MPICONSTANTS_TYPE_NULL_DELETE_FN, libmpiconstants), MPI_Type_delete_attr_function))

@const_ref MPI_WIN_NULL MPI_Win unsafe_load(cglobal((:MPICONSTANTS_WIN_NULL, libmpiconstants), MPI_Win))

@const_ref MPI_WIN_DUP_FN MPI_Win_copy_attr_function unsafe_load(cglobal((:MPICONSTANTS_WIN_DUP_FN, libmpiconstants), MPI_Win_copy_attr_function))
@const_ref MPI_WIN_NULL_COPY_FN MPI_Win_copy_attr_function unsafe_load(cglobal((:MPICONSTANTS_WIN_NULL_COPY_FN, libmpiconstants), MPI_Win_copy_attr_function))

@const_ref MPI_WIN_NULL_DELETE_FN MPI_Win_delete_attr_function unsafe_load(cglobal((:MPICONSTANTS_WIN_NULL_DELETE_FN, libmpiconstants), MPI_Win_delete_attr_function))
