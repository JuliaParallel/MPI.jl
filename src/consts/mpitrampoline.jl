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


@const_ref MPI_ANY_SOURCE Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ANY_SOURCE)))
@const_ref MPI_ANY_TAG Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ANY_TAG)))
@const_ref MPI_PROC_NULL Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_PROC_NULL)))
@const_ref MPI_ROOT Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ROOT)))
@const_ref MPI_CART Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_CART)))
@const_ref MPI_DIST_GRAPH Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_DIST_GRAPH)))
@const_ref MPI_GRAPH Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_GRAPH)))
@const_ref MPI_CONGRUENT Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_CONGRUENT)))
@const_ref MPI_IDENT Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_IDENT)))
@const_ref MPI_SIMILAR Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_SIMILAR)))
@const_ref MPI_UNEQUAL Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_UNEQUAL)))
@const_ref MPI_KEYVAL_INVALID Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_KEYVAL_INVALID)))
@const_ref MPI_UNDEFINED Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_UNDEFINED)))
@const_ref MPI_APPNUM Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_APPNUM)))
@const_ref MPI_HOST Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_HOST)))
@const_ref MPI_IO Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_IO)))
@const_ref MPI_LASTUSEDCODE Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_LASTUSEDCODE)))
@const_ref MPI_TAG_UB Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_TAG_UB)))
@const_ref MPI_UNIVERSE_SIZE Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_UNIVERSE_SIZE)))
@const_ref MPI_WIN_BASE Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_WIN_BASE)))
@const_ref MPI_WIN_CREATE_FLAVOR Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_WIN_CREATE_FLAVOR)))
@const_ref MPI_WIN_DISP_UNIT Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_WIN_DISP_UNIT)))
@const_ref MPI_WIN_MODEL Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_WIN_MODEL)))
@const_ref MPI_WIN_SIZE Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_WIN_SIZE)))
@const_ref MPI_WTIME_IS_GLOBAL Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_WTIME_IS_GLOBAL)))
@const_ref MPI_COMBINER_CONTIGUOUS Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_COMBINER_CONTIGUOUS)))
@const_ref MPI_COMBINER_DARRAY Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_COMBINER_DARRAY)))
@const_ref MPI_COMBINER_DUP Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_COMBINER_DUP)))
@const_ref MPI_COMBINER_F90_COMPLEX Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_COMBINER_F90_COMPLEX)))
@const_ref MPI_COMBINER_F90_INTEGER Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_COMBINER_F90_INTEGER)))
@const_ref MPI_COMBINER_F90_REAL Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_COMBINER_F90_REAL)))
@const_ref MPI_COMBINER_HINDEXED Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_COMBINER_HINDEXED)))
@const_ref MPI_COMBINER_HINDEXED_BLOCK Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_COMBINER_HINDEXED_BLOCK)))
@const_ref MPI_COMBINER_HVECTOR Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_COMBINER_HVECTOR)))
@const_ref MPI_COMBINER_INDEXED Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_COMBINER_INDEXED)))
@const_ref MPI_COMBINER_INDEXED_BLOCK Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_COMBINER_INDEXED_BLOCK)))
@const_ref MPI_COMBINER_NAMED Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_COMBINER_NAMED)))
@const_ref MPI_COMBINER_RESIZED Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_COMBINER_RESIZED)))
@const_ref MPI_COMBINER_STRUCT Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_COMBINER_STRUCT)))
@const_ref MPI_COMBINER_SUBARRAY Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_COMBINER_SUBARRAY)))
@const_ref MPI_COMBINER_VECTOR Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_COMBINER_VECTOR)))
@const_ref MPI_COMM_TYPE_SHARED Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_COMM_TYPE_SHARED)))
@const_ref MPI_DISTRIBUTE_BLOCK Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_DISTRIBUTE_BLOCK)))
@const_ref MPI_DISTRIBUTE_CYCLIC Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_DISTRIBUTE_CYCLIC)))
@const_ref MPI_DISTRIBUTE_NONE Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_DISTRIBUTE_NONE)))
@const_ref MPI_ERR_ACCESS Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_ACCESS)))
@const_ref MPI_ERR_AMODE Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_AMODE)))
@const_ref MPI_ERR_ARG Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_ARG)))
@const_ref MPI_ERR_ASSERT Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_ASSERT)))
@const_ref MPI_ERR_BAD_FILE Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_BAD_FILE)))
@const_ref MPI_ERR_BASE Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_BASE)))
@const_ref MPI_ERR_BUFFER Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_BUFFER)))
@const_ref MPI_ERR_COMM Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_COMM)))
@const_ref MPI_ERR_CONVERSION Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_CONVERSION)))
@const_ref MPI_ERR_COUNT Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_COUNT)))
@const_ref MPI_ERR_DIMS Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_DIMS)))
@const_ref MPI_ERR_DISP Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_DISP)))
@const_ref MPI_ERR_DUP_DATAREP Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_DUP_DATAREP)))
@const_ref MPI_ERR_FILE Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_FILE)))
@const_ref MPI_ERR_FILE_EXISTS Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_FILE_EXISTS)))
@const_ref MPI_ERR_FILE_IN_USE Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_FILE_IN_USE)))
@const_ref MPI_ERR_GROUP Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_GROUP)))
@const_ref MPI_ERR_INFO Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_INFO)))
@const_ref MPI_ERR_INFO_KEY Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_INFO_KEY)))
@const_ref MPI_ERR_INFO_NOKEY Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_INFO_NOKEY)))
@const_ref MPI_ERR_INFO_VALUE Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_INFO_VALUE)))
@const_ref MPI_ERR_INTERN Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_INTERN)))
@const_ref MPI_ERR_IN_STATUS Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_IN_STATUS)))
@const_ref MPI_ERR_IO Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_IO)))
@const_ref MPI_ERR_KEYVAL Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_KEYVAL)))
@const_ref MPI_ERR_LASTCODE Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_LASTCODE)))
@const_ref MPI_ERR_LOCKTYPE Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_LOCKTYPE)))
@const_ref MPI_ERR_NAME Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_NAME)))
@const_ref MPI_ERR_NOT_SAME Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_NOT_SAME)))
@const_ref MPI_ERR_NO_MEM Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_NO_MEM)))
@const_ref MPI_ERR_NO_SPACE Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_NO_SPACE)))
@const_ref MPI_ERR_NO_SUCH_FILE Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_NO_SUCH_FILE)))
@const_ref MPI_ERR_OP Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_OP)))
@const_ref MPI_ERR_OTHER Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_OTHER)))
@const_ref MPI_ERR_PENDING Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_PENDING)))
@const_ref MPI_ERR_PORT Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_PORT)))
@const_ref MPI_ERR_QUOTA Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_QUOTA)))
@const_ref MPI_ERR_RANK Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_RANK)))
@const_ref MPI_ERR_READ_ONLY Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_READ_ONLY)))
@const_ref MPI_ERR_REQUEST Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_REQUEST)))
@const_ref MPI_ERR_RMA_ATTACH Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_RMA_ATTACH)))
@const_ref MPI_ERR_RMA_CONFLICT Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_RMA_CONFLICT)))
@const_ref MPI_ERR_RMA_FLAVOR Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_RMA_FLAVOR)))
@const_ref MPI_ERR_RMA_RANGE Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_RMA_RANGE)))
@const_ref MPI_ERR_RMA_SHARED Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_RMA_SHARED)))
@const_ref MPI_ERR_RMA_SYNC Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_RMA_SYNC)))
@const_ref MPI_ERR_ROOT Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_ROOT)))
@const_ref MPI_ERR_SERVICE Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_SERVICE)))
@const_ref MPI_ERR_SIZE Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_SIZE)))
@const_ref MPI_ERR_SPAWN Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_SPAWN)))
@const_ref MPI_ERR_TAG Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_TAG)))
@const_ref MPI_ERR_TOPOLOGY Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_TOPOLOGY)))
@const_ref MPI_ERR_TRUNCATE Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_TRUNCATE)))
@const_ref MPI_ERR_TYPE Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_TYPE)))
@const_ref MPI_ERR_UNKNOWN Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_UNKNOWN)))
@const_ref MPI_ERR_UNSUPPORTED_DATAREP Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_UNSUPPORTED_DATAREP)))
@const_ref MPI_ERR_UNSUPPORTED_OPERATION Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_UNSUPPORTED_OPERATION)))
@const_ref MPI_ERR_WIN Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERR_WIN)))

@const_ref MPI_SUCCESS Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_SUCCESS)))
@const_ref MPI_LOCK_EXCLUSIVE Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_LOCK_EXCLUSIVE)))
@const_ref MPI_LOCK_SHARED Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_LOCK_SHARED)))
@const_ref MPI_MODE_APPEND Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_MODE_APPEND)))
@const_ref MPI_MODE_CREATE Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_MODE_CREATE)))
@const_ref MPI_MODE_DELETE_ON_CLOSE Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_MODE_DELETE_ON_CLOSE)))
@const_ref MPI_MODE_EXCL Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_MODE_EXCL)))
@const_ref MPI_MODE_NOCHECK Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_MODE_NOCHECK)))
@const_ref MPI_MODE_NOPRECEDE Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_MODE_NOPRECEDE)))
@const_ref MPI_MODE_NOPUT Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_MODE_NOPUT)))
@const_ref MPI_MODE_NOSTORE Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_MODE_NOSTORE)))
@const_ref MPI_MODE_NOSUCCEED Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_MODE_NOSUCCEED)))
@const_ref MPI_MODE_RDONLY Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_MODE_RDONLY)))
@const_ref MPI_MODE_RDWR Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_MODE_RDWR)))
@const_ref MPI_MODE_SEQUENTIAL Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_MODE_SEQUENTIAL)))
@const_ref MPI_MODE_UNIQUE_OPEN Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_MODE_UNIQUE_OPEN)))
@const_ref MPI_MODE_WRONLY Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_MODE_WRONLY)))
@const_ref MPI_ORDER_C Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ORDER_C)))
@const_ref MPI_ORDER_FORTRAN Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ORDER_FORTRAN)))
@const_ref MPI_SEEK_CUR Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_SEEK_CUR)))
@const_ref MPI_SEEK_END Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_SEEK_END)))
@const_ref MPI_SEEK_SET Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_SEEK_SET)))
@const_ref MPI_THREAD_SINGLE Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_THREAD_SINGLE)))
@const_ref MPI_THREAD_FUNNELED Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_THREAD_FUNNELED)))
@const_ref MPI_THREAD_SERIALIZED Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_THREAD_SERIALIZED)))
@const_ref MPI_THREAD_MULTIPLE Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_THREAD_MULTIPLE)))
@const_ref MPI_TYPECLASS_COMPLEX Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_TYPECLASS_COMPLEX)))
@const_ref MPI_TYPECLASS_INTEGER Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_TYPECLASS_INTEGER)))
@const_ref MPI_TYPECLASS_REAL Cint unsafe_load(reinterpret(Ptr{Cint}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_TYPECLASS_REAL)))

@const_ref MPI_ARGV_NULL Ptr{Cchar} unsafe_load(reinterpret(Ptr{Ptr{Ptr{Cchar}}}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ARGV_NULL)))
@const_ref MPI_ARGVS_NULL Ptr{Cchar} unsafe_load(reinterpret(Ptr{Ptr{Ptr{Ptr{Cchar}}}}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ARGVS_NULL)))
# MPI_UNWEIGHTED Ptr{Cvoid} unsafe_load(reinterpret(Ptr{Ptr{Cint}}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_UNWEIGHTED)))
# MPI_WEIGHTS_EMPTY Ptr{Cvoid} unsafe_load(reinterpret(Ptr{Ptr{Cint}}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_WEIGHTS_EMPTY)))
@const_ref MPI_BOTTOM Ptr{Cvoid} unsafe_load(reinterpret(Ptr{Ptr{Cvoid}}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_BOTTOM)))
@const_ref MPI_IN_PLACE Ptr{Cvoid} unsafe_load(reinterpret(Ptr{Ptr{Cvoid}}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_IN_PLACE)))

@const_ref MPI_COMM_NULL MPI_Comm unsafe_load(reinterpret(Ptr{MPI_Comm}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_COMM_NULL )))
@const_ref MPI_COMM_SELF MPI_Comm unsafe_load(reinterpret(Ptr{MPI_Comm}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_COMM_SELF )))
@const_ref MPI_COMM_WORLD MPI_Comm unsafe_load(reinterpret(Ptr{MPI_Comm}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_COMM_WORLD)))

@const_ref MPI_COMM_DUP_FN MPI_Comm_copy_attr_function unsafe_load(reinterpret(Ptr{MPI_Comm_copy_attr_function}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_COMM_DUP_FN)))
@const_ref MPI_COMM_NULL_COPY_FN MPI_Comm_copy_attr_function unsafe_load(reinterpret(Ptr{MPI_Comm_copy_attr_function}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_COMM_NULL_COPY_FN)))
@const_ref MPI_COMM_NULL_DELETE_FN MPI_Comm_delete_attr_function unsafe_load(reinterpret(Ptr{MPI_Comm_delete_attr_function}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_COMM_NULL_DELETE_FN)))

@const_ref MPI_NULL_COPY_FN MPI_Copy_function unsafe_load(reinterpret(Ptr{MPI_Copy_function}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_NULL_COPY_FN)))

@const_ref MPI_2DOUBLE_PRECISION MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_2DOUBLE_PRECISION)))
@const_ref MPI_2INT MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_2INT)))
@const_ref MPI_2INTEGER MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_2INTEGER)))
@const_ref MPI_2REAL MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_2REAL)))
@const_ref MPI_AINT MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_AINT)))
@const_ref MPI_BYTE MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_BYTE)))
@const_ref MPI_CHAR MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_CHAR)))
@const_ref MPI_CHARACTER MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_CHARACTER)))
@const_ref MPI_COMPLEX MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_COMPLEX)))
@const_ref MPI_COMPLEX16 MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_COMPLEX16)))
# MPI_COMPLEX32 MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_COMPLEX32)))
@const_ref MPI_COMPLEX8 MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_COMPLEX8)))
@const_ref MPI_COUNT MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_COUNT)))
@const_ref MPI_CXX_BOOL MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_CXX_BOOL)))
@const_ref MPI_CXX_DOUBLE_COMPLEX MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_CXX_DOUBLE_COMPLEX)))
@const_ref MPI_CXX_FLOAT_COMPLEX MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_CXX_FLOAT_COMPLEX)))
@const_ref MPI_CXX_LONG_DOUBLE_COMPLEX MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_CXX_LONG_DOUBLE_COMPLEX)))
@const_ref MPI_C_BOOL MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_C_BOOL)))
@const_ref MPI_C_COMPLEX MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_C_COMPLEX)))
@const_ref MPI_C_DOUBLE_COMPLEX MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_C_DOUBLE_COMPLEX)))
@const_ref MPI_C_FLOAT_COMPLEX MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_C_FLOAT_COMPLEX)))
@const_ref MPI_C_LONG_DOUBLE_COMPLEX MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_C_LONG_DOUBLE_COMPLEX)))
@const_ref MPI_DATATYPE_NULL MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_DATATYPE_NULL)))
@const_ref MPI_DOUBLE MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_DOUBLE)))
@const_ref MPI_DOUBLE_COMPLEX MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_DOUBLE_COMPLEX)))
@const_ref MPI_DOUBLE_INT MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_DOUBLE_INT)))
@const_ref MPI_DOUBLE_PRECISION MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_DOUBLE_PRECISION)))
@const_ref MPI_FLOAT MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_FLOAT)))
@const_ref MPI_FLOAT_INT MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_FLOAT_INT)))
@const_ref MPI_INT MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_INT)))
@const_ref MPI_INT16_T MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_INT16_T)))
@const_ref MPI_INT32_T MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_INT32_T)))
@const_ref MPI_INT64_T MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_INT64_T)))
@const_ref MPI_INT8_T MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_INT8_T)))
@const_ref MPI_INTEGER MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_INTEGER)))
@const_ref MPI_INTEGER1 MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_INTEGER1)))
@const_ref MPI_INTEGER2 MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_INTEGER2)))
@const_ref MPI_INTEGER4 MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_INTEGER4)))
@const_ref MPI_INTEGER8 MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_INTEGER8)))
@const_ref MPI_LOGICAL MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_LOGICAL)))
@const_ref MPI_LONG MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_LONG)))
@const_ref MPI_LONG_DOUBLE MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_LONG_DOUBLE)))
@const_ref MPI_LONG_DOUBLE_INT MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_LONG_DOUBLE_INT)))
@const_ref MPI_LONG_INT MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_LONG_INT)))
@const_ref MPI_LONG_LONG MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_LONG_LONG)))
@const_ref MPI_LONG_LONG_INT MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_LONG_LONG_INT)))
@const_ref MPI_OFFSET MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_OFFSET)))
@const_ref MPI_PACKED MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_PACKED)))
@const_ref MPI_REAL MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_REAL)))
# MPI_REAL16 MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_REAL16)))
@const_ref MPI_REAL4 MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_REAL4)))
@const_ref MPI_REAL8 MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_REAL8)))
@const_ref MPI_SHORT MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_SHORT)))
@const_ref MPI_SHORT_INT MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_SHORT_INT)))
@const_ref MPI_SIGNED_CHAR MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_SIGNED_CHAR)))
@const_ref MPI_UINT16_T MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_UINT16_T)))
@const_ref MPI_UINT32_T MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_UINT32_T)))
@const_ref MPI_UINT64_T MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_UINT64_T)))
@const_ref MPI_UINT8_T MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_UINT8_T)))
@const_ref MPI_UNSIGNED MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_UNSIGNED)))
@const_ref MPI_UNSIGNED_CHAR MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_UNSIGNED_CHAR)))
@const_ref MPI_UNSIGNED_LONG MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_UNSIGNED_LONG)))
@const_ref MPI_UNSIGNED_LONG_LONG MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_UNSIGNED_LONG_LONG)))
@const_ref MPI_UNSIGNED_SHORT MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_UNSIGNED_SHORT)))
@const_ref MPI_WCHAR MPI_Datatype unsafe_load(reinterpret(Ptr{MPI_Datatype}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_WCHAR)))

@const_ref MPI_NULL_DELETE_FN MPI_Delete_function unsafe_load(reinterpret(Ptr{MPI_Delete_function}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_NULL_DELETE_FN)))

@const_ref MPI_ERRHANDLER_NULL MPI_Errhandler unsafe_load(reinterpret(Ptr{MPI_Errhandler}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERRHANDLER_NULL)))
@const_ref MPI_ERRORS_ARE_FATAL MPI_Errhandler unsafe_load(reinterpret(Ptr{MPI_Errhandler}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERRORS_ARE_FATAL)))
@const_ref MPI_ERRORS_RETURN MPI_Errhandler unsafe_load(reinterpret(Ptr{MPI_Errhandler}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_ERRORS_RETURN)))

@const_ref MPI_FILE_NULL MPI_File unsafe_load(reinterpret(Ptr{MPI_File}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_FILE_NULL)))

@const_ref MPI_GROUP_EMPTY MPI_Group unsafe_load(reinterpret(Ptr{MPI_Group}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_GROUP_EMPTY)))
@const_ref MPI_GROUP_NULL MPI_Group unsafe_load(reinterpret(Ptr{MPI_Group}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_GROUP_NULL)))

@const_ref MPI_INFO_ENV MPI_Info unsafe_load(reinterpret(Ptr{MPI_Info}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_INFO_ENV)))
@const_ref MPI_INFO_NULL MPI_Info unsafe_load(reinterpret(Ptr{MPI_Info}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_INFO_NULL)))

@const_ref MPI_MESSAGE_NO_PROC MPI_Message unsafe_load(reinterpret(Ptr{MPI_Message}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_MESSAGE_NO_PROC)))
@const_ref MPI_MESSAGE_NULL MPI_Message unsafe_load(reinterpret(Ptr{MPI_Message}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_MESSAGE_NULL)))

@const_ref MPI_DISPLACEMENT_CURRENT MPI_Offset unsafe_load(reinterpret(Ptr{MPI_Offset}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_DISPLACEMENT_CURRENT)))

@const_ref MPI_BAND MPI_Op unsafe_load(reinterpret(Ptr{MPI_Op}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_BAND)))
@const_ref MPI_BOR MPI_Op unsafe_load(reinterpret(Ptr{MPI_Op}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_BOR)))
@const_ref MPI_BXOR MPI_Op unsafe_load(reinterpret(Ptr{MPI_Op}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_BXOR)))
@const_ref MPI_LAND MPI_Op unsafe_load(reinterpret(Ptr{MPI_Op}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_LAND)))
@const_ref MPI_LOR MPI_Op unsafe_load(reinterpret(Ptr{MPI_Op}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_LOR)))
@const_ref MPI_LXOR MPI_Op unsafe_load(reinterpret(Ptr{MPI_Op}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_LXOR)))
@const_ref MPI_MAX MPI_Op unsafe_load(reinterpret(Ptr{MPI_Op}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_MAX)))
@const_ref MPI_MAXLOC MPI_Op unsafe_load(reinterpret(Ptr{MPI_Op}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_MAXLOC)))
@const_ref MPI_MIN MPI_Op unsafe_load(reinterpret(Ptr{MPI_Op}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_MIN)))
@const_ref MPI_MINLOC MPI_Op unsafe_load(reinterpret(Ptr{MPI_Op}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_MINLOC)))
@const_ref MPI_NO_OP MPI_Op unsafe_load(reinterpret(Ptr{MPI_Op}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_NO_OP)))
@const_ref MPI_OP_NULL MPI_Op unsafe_load(reinterpret(Ptr{MPI_Op}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_OP_NULL)))
@const_ref MPI_PROD MPI_Op unsafe_load(reinterpret(Ptr{MPI_Op}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_PROD)))
@const_ref MPI_REPLACE MPI_Op unsafe_load(reinterpret(Ptr{MPI_Op}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_REPLACE)))
@const_ref MPI_SUM MPI_Op unsafe_load(reinterpret(Ptr{MPI_Op}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_SUM)))

@const_ref MPI_REQUEST_NULL MPI_Request unsafe_load(reinterpret(Ptr{MPI_Request}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_REQUEST_NULL)))

@const_ref MPI_STATUS_IGNORE Ptr{MPI_Status} unsafe_load(reinterpret(Ptr{Ptr{MPI_Status}}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_STATUS_IGNORE)))
@const_ref MPI_STATUSES_IGNORE Ptr{MPI_Status} unsafe_load(reinterpret(Ptr{Ptr{MPI_Status}}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_STATUSES_IGNORE)))

@const_ref MPI_TYPE_DUP_FN MPI_Type_copy_attr_function unsafe_load(reinterpret(Ptr{MPI_Type_copy_attr_function}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_TYPE_DUP_FN)))
@const_ref MPI_TYPE_NULL_COPY_FN MPI_Type_copy_attr_function unsafe_load(reinterpret(Ptr{MPI_Type_copy_attr_function}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_TYPE_NULL_COPY_FN)))
@const_ref MPI_TYPE_NULL_DELETE_FN MPI_Type_delete_attr_function unsafe_load(reinterpret(Ptr{MPI_Type_delete_attr_function}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_TYPE_NULL_DELETE_FN)))

@const_ref MPI_WIN_NULL MPI_Win unsafe_load(reinterpret(Ptr{MPI_Win}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_WIN_NULL)))

@const_ref MPI_WIN_DUP_FN MPI_Win_copy_attr_function unsafe_load(reinterpret(Ptr{MPI_Win_copy_attr_function}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_WIN_DUP_FN)))
@const_ref MPI_WIN_NULL_COPY_FN MPI_Win_copy_attr_function unsafe_load(reinterpret(Ptr{MPI_Win_copy_attr_function}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_WIN_NULL_COPY_FN)))

@const_ref MPI_WIN_NULL_DELETE_FN MPI_Win_delete_attr_function unsafe_load(reinterpret(Ptr{MPI_Win_delete_attr_function}, Libdl.dlsym(libmpiconstants, :MPICONSTANTS_WIN_NULL_DELETE_FN)))
