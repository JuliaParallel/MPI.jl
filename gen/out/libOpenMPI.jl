module libOpenMPI

using OpenMPI_jll
export OpenMPI_jll

using CEnum

mutable struct ompi_datatype_t end

const MPI_Datatype = Ptr{ompi_datatype_t}

mutable struct ompi_request_t end

const MPI_Request = Ptr{ompi_request_t}

struct ompi_status_public_t
    MPI_SOURCE::Cint
    MPI_TAG::Cint
    MPI_ERROR::Cint
    _cancelled::Cint
    _ucount::Csize_t
end

const MPI_Status = ompi_status_public_t

function MPI_Test(request, flag, status)
    ccall((:MPI_Test, libmpi), Cint, (Ptr{MPI_Request}, Ptr{Cint}, Ptr{MPI_Status}), request, flag, status)
end

function MPI_Wait(request, status)
    ccall((:MPI_Wait, libmpi), Cint, (Ptr{MPI_Request}, Ptr{MPI_Status}), request, status)
end

mutable struct ompi_group_t end

const MPI_Group = Ptr{ompi_group_t}

mutable struct ompi_communicator_t end

const MPI_Comm = Ptr{ompi_communicator_t}

mutable struct ompi_message_t end

const MPI_Message = Ptr{ompi_message_t}

mutable struct ompi_op_t end

const MPI_Op = Ptr{ompi_op_t}

mutable struct ompi_errhandler_t end

const MPI_Errhandler = Ptr{ompi_errhandler_t}

mutable struct ompi_info_t end

const MPI_Info = Ptr{ompi_info_t}

mutable struct ompi_win_t end

const MPI_Win = Ptr{ompi_win_t}

mutable struct ompi_file_t end

const MPI_File = Ptr{ompi_file_t}

mutable struct mca_base_var_enum_t end

const MPI_T_enum = Ptr{mca_base_var_enum_t}

mutable struct mca_base_pvar_handle_t end

const MPI_T_pvar_handle = Ptr{mca_base_pvar_handle_t}

mutable struct mca_base_pvar_session_t end

const MPI_T_pvar_session = Ptr{mca_base_pvar_session_t}

mutable struct ompi_mpit_cvar_handle_t end

const MPI_T_cvar_handle = Ptr{ompi_mpit_cvar_handle_t}

function OMPI_C_MPI_TYPE_NULL_DELETE_FN(datatype, type_keyval, attribute_val_out, extra_state)
    ccall((:OMPI_C_MPI_TYPE_NULL_DELETE_FN, libmpi), Cint, (MPI_Datatype, Cint, Ptr{Cvoid}, Ptr{Cvoid}), datatype, type_keyval, attribute_val_out, extra_state)
end

function OMPI_C_MPI_TYPE_NULL_COPY_FN(datatype, type_keyval, extra_state, attribute_val_in, attribute_val_out, flag)
    ccall((:OMPI_C_MPI_TYPE_NULL_COPY_FN, libmpi), Cint, (MPI_Datatype, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}), datatype, type_keyval, extra_state, attribute_val_in, attribute_val_out, flag)
end

function OMPI_C_MPI_TYPE_DUP_FN(datatype, type_keyval, extra_state, attribute_val_in, attribute_val_out, flag)
    ccall((:OMPI_C_MPI_TYPE_DUP_FN, libmpi), Cint, (MPI_Datatype, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}), datatype, type_keyval, extra_state, attribute_val_in, attribute_val_out, flag)
end

function OMPI_C_MPI_COMM_NULL_DELETE_FN(comm, comm_keyval, attribute_val_out, extra_state)
    ccall((:OMPI_C_MPI_COMM_NULL_DELETE_FN, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cvoid}, Ptr{Cvoid}), comm, comm_keyval, attribute_val_out, extra_state)
end

function OMPI_C_MPI_COMM_NULL_COPY_FN(comm, comm_keyval, extra_state, attribute_val_in, attribute_val_out, flag)
    ccall((:OMPI_C_MPI_COMM_NULL_COPY_FN, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}), comm, comm_keyval, extra_state, attribute_val_in, attribute_val_out, flag)
end

function OMPI_C_MPI_COMM_DUP_FN(comm, comm_keyval, extra_state, attribute_val_in, attribute_val_out, flag)
    ccall((:OMPI_C_MPI_COMM_DUP_FN, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}), comm, comm_keyval, extra_state, attribute_val_in, attribute_val_out, flag)
end

function OMPI_C_MPI_WIN_NULL_DELETE_FN(window, win_keyval, attribute_val_out, extra_state)
    ccall((:OMPI_C_MPI_WIN_NULL_DELETE_FN, libmpi), Cint, (MPI_Win, Cint, Ptr{Cvoid}, Ptr{Cvoid}), window, win_keyval, attribute_val_out, extra_state)
end

function OMPI_C_MPI_WIN_NULL_COPY_FN(window, win_keyval, extra_state, attribute_val_in, attribute_val_out, flag)
    ccall((:OMPI_C_MPI_WIN_NULL_COPY_FN, libmpi), Cint, (MPI_Win, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}), window, win_keyval, extra_state, attribute_val_in, attribute_val_out, flag)
end

function OMPI_C_MPI_WIN_DUP_FN(window, win_keyval, extra_state, attribute_val_in, attribute_val_out, flag)
    ccall((:OMPI_C_MPI_WIN_DUP_FN, libmpi), Cint, (MPI_Win, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}), window, win_keyval, extra_state, attribute_val_in, attribute_val_out, flag)
end

# typedef int ( MPI_Datarep_conversion_function ) ( void * , MPI_Datatype , int , void * , MPI_Offset , void * )
const MPI_Datarep_conversion_function = Cvoid

const MPI_Aint = Cptrdiff_t

function OMPI_C_MPI_DUP_FN(comm, comm_keyval, extra_state, attribute_val_in, attribute_val_out, flag)
    ccall((:OMPI_C_MPI_DUP_FN, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}), comm, comm_keyval, extra_state, attribute_val_in, attribute_val_out, flag)
end

function OMPI_C_MPI_NULL_COPY_FN(comm, comm_keyval, extra_state, attribute_val_in, attribute_val_out, flag)
    ccall((:OMPI_C_MPI_NULL_COPY_FN, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}), comm, comm_keyval, extra_state, attribute_val_in, attribute_val_out, flag)
end

function OMPI_C_MPI_NULL_DELETE_FN(comm, comm_keyval, attribute_val_out, extra_state)
    ccall((:OMPI_C_MPI_NULL_DELETE_FN, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cvoid}, Ptr{Cvoid}), comm, comm_keyval, attribute_val_out, extra_state)
end

const MPI_Offset = Clonglong

const MPI_Count = Clonglong

# typedef int ( MPI_Datarep_extent_function ) ( MPI_Datatype , MPI_Aint * , void * )
const MPI_Datarep_extent_function = Cvoid

# typedef void ( MPI_Comm_errhandler_function ) ( MPI_Comm * , int * , ... )
const MPI_Comm_errhandler_function = Cvoid

# typedef void ( ompi_file_errhandler_fn ) ( MPI_File * , int * , ... )
const ompi_file_errhandler_fn = Cvoid

# typedef void ( MPI_Win_errhandler_function ) ( MPI_Win * , int * , ... )
const MPI_Win_errhandler_function = Cvoid

# typedef void ( MPI_User_function ) ( void * , void * , int * , MPI_Datatype * )
const MPI_User_function = Cvoid

# typedef int ( MPI_Comm_copy_attr_function ) ( MPI_Comm , int , void * , void * , void * , int * )
const MPI_Comm_copy_attr_function = Cvoid

# typedef int ( MPI_Comm_delete_attr_function ) ( MPI_Comm , int , void * , void * )
const MPI_Comm_delete_attr_function = Cvoid

# typedef int ( MPI_Type_copy_attr_function ) ( MPI_Datatype , int , void * , void * , void * , int * )
const MPI_Type_copy_attr_function = Cvoid

# typedef int ( MPI_Type_delete_attr_function ) ( MPI_Datatype , int , void * , void * )
const MPI_Type_delete_attr_function = Cvoid

# typedef int ( MPI_Win_copy_attr_function ) ( MPI_Win , int , void * , void * , void * , int * )
const MPI_Win_copy_attr_function = Cvoid

# typedef int ( MPI_Win_delete_attr_function ) ( MPI_Win , int , void * , void * )
const MPI_Win_delete_attr_function = Cvoid

# typedef int ( MPI_Grequest_query_function ) ( void * , MPI_Status * )
const MPI_Grequest_query_function = Cvoid

# typedef int ( MPI_Grequest_free_function ) ( void * )
const MPI_Grequest_free_function = Cvoid

# typedef int ( MPI_Grequest_cancel_function ) ( void * , int )
const MPI_Grequest_cancel_function = Cvoid

# typedef MPI_Comm_errhandler_function MPI_Comm_errhandler_fn
const MPI_Comm_errhandler_fn = MPI_Comm_errhandler_function

# typedef ompi_file_errhandler_fn MPI_File_errhandler_fn
const MPI_File_errhandler_fn = ompi_file_errhandler_fn

# typedef ompi_file_errhandler_fn MPI_File_errhandler_function
const MPI_File_errhandler_function = ompi_file_errhandler_fn

# typedef MPI_Win_errhandler_function MPI_Win_errhandler_fn
const MPI_Win_errhandler_fn = MPI_Win_errhandler_function

@cenum var"##Ctag#313"::UInt32 begin
    MPI_TAG_UB = 0
    MPI_HOST = 1
    MPI_IO = 2
    MPI_WTIME_IS_GLOBAL = 3
    MPI_APPNUM = 4
    MPI_LASTUSEDCODE = 5
    MPI_UNIVERSE_SIZE = 6
    MPI_WIN_BASE = 7
    MPI_WIN_SIZE = 8
    MPI_WIN_DISP_UNIT = 9
    MPI_WIN_CREATE_FLAVOR = 10
    MPI_WIN_MODEL = 11
    IMPI_CLIENT_SIZE = 12
    IMPI_CLIENT_COLOR = 13
    IMPI_HOST_SIZE = 14
    IMPI_HOST_COLOR = 15
end

@cenum var"##Ctag#314"::UInt32 begin
    MPI_IDENT = 0
    MPI_CONGRUENT = 1
    MPI_SIMILAR = 2
    MPI_UNEQUAL = 3
end

@cenum var"##Ctag#315"::UInt32 begin
    MPI_THREAD_SINGLE = 0
    MPI_THREAD_FUNNELED = 1
    MPI_THREAD_SERIALIZED = 2
    MPI_THREAD_MULTIPLE = 3
end

@cenum var"##Ctag#316"::UInt32 begin
    MPI_COMBINER_NAMED = 0
    MPI_COMBINER_DUP = 1
    MPI_COMBINER_CONTIGUOUS = 2
    MPI_COMBINER_VECTOR = 3
    OMPI_WAS_MPI_COMBINER_HVECTOR_INTEGER = 4
    MPI_COMBINER_HVECTOR = 5
    MPI_COMBINER_INDEXED = 6
    OMPI_WAS_MPI_COMBINER_HINDEXED_INTEGER = 7
    MPI_COMBINER_HINDEXED = 8
    MPI_COMBINER_INDEXED_BLOCK = 9
    OMPI_WAS_MPI_COMBINER_STRUCT_INTEGER = 10
    MPI_COMBINER_STRUCT = 11
    MPI_COMBINER_SUBARRAY = 12
    MPI_COMBINER_DARRAY = 13
    MPI_COMBINER_F90_REAL = 14
    MPI_COMBINER_F90_COMPLEX = 15
    MPI_COMBINER_F90_INTEGER = 16
    MPI_COMBINER_RESIZED = 17
    MPI_COMBINER_HINDEXED_BLOCK = 18
end

@cenum var"##Ctag#317"::UInt32 begin
    MPI_COMM_TYPE_SHARED = 0
    OMPI_COMM_TYPE_HWTHREAD = 1
    OMPI_COMM_TYPE_CORE = 2
    OMPI_COMM_TYPE_L1CACHE = 3
    OMPI_COMM_TYPE_L2CACHE = 4
    OMPI_COMM_TYPE_L3CACHE = 5
    OMPI_COMM_TYPE_SOCKET = 6
    OMPI_COMM_TYPE_NUMA = 7
    OMPI_COMM_TYPE_BOARD = 8
    OMPI_COMM_TYPE_HOST = 9
    OMPI_COMM_TYPE_CU = 10
    OMPI_COMM_TYPE_CLUSTER = 11
end

@cenum var"##Ctag#318"::UInt32 begin
    MPI_T_VERBOSITY_USER_BASIC = 0
    MPI_T_VERBOSITY_USER_DETAIL = 1
    MPI_T_VERBOSITY_USER_ALL = 2
    MPI_T_VERBOSITY_TUNER_BASIC = 3
    MPI_T_VERBOSITY_TUNER_DETAIL = 4
    MPI_T_VERBOSITY_TUNER_ALL = 5
    MPI_T_VERBOSITY_MPIDEV_BASIC = 6
    MPI_T_VERBOSITY_MPIDEV_DETAIL = 7
    MPI_T_VERBOSITY_MPIDEV_ALL = 8
end

@cenum var"##Ctag#319"::UInt32 begin
    MPI_T_SCOPE_CONSTANT = 0
    MPI_T_SCOPE_READONLY = 1
    MPI_T_SCOPE_LOCAL = 2
    MPI_T_SCOPE_GROUP = 3
    MPI_T_SCOPE_GROUP_EQ = 4
    MPI_T_SCOPE_ALL = 5
    MPI_T_SCOPE_ALL_EQ = 6
end

@cenum var"##Ctag#320"::UInt32 begin
    MPI_T_BIND_NO_OBJECT = 0
    MPI_T_BIND_MPI_COMM = 1
    MPI_T_BIND_MPI_DATATYPE = 2
    MPI_T_BIND_MPI_ERRHANDLER = 3
    MPI_T_BIND_MPI_FILE = 4
    MPI_T_BIND_MPI_GROUP = 5
    MPI_T_BIND_MPI_OP = 6
    MPI_T_BIND_MPI_REQUEST = 7
    MPI_T_BIND_MPI_WIN = 8
    MPI_T_BIND_MPI_MESSAGE = 9
    MPI_T_BIND_MPI_INFO = 10
end

@cenum var"##Ctag#321"::UInt32 begin
    MPI_T_PVAR_CLASS_STATE = 0
    MPI_T_PVAR_CLASS_LEVEL = 1
    MPI_T_PVAR_CLASS_SIZE = 2
    MPI_T_PVAR_CLASS_PERCENTAGE = 3
    MPI_T_PVAR_CLASS_HIGHWATERMARK = 4
    MPI_T_PVAR_CLASS_LOWWATERMARK = 5
    MPI_T_PVAR_CLASS_COUNTER = 6
    MPI_T_PVAR_CLASS_AGGREGATE = 7
    MPI_T_PVAR_CLASS_TIMER = 8
    MPI_T_PVAR_CLASS_GENERIC = 9
end

mutable struct ompi_predefined_communicator_t end

mutable struct ompi_predefined_group_t end

mutable struct ompi_predefined_request_t end

mutable struct ompi_predefined_message_t end

mutable struct ompi_predefined_op_t end

mutable struct ompi_predefined_datatype_t end

mutable struct ompi_predefined_errhandler_t end

mutable struct ompi_predefined_win_t end

mutable struct ompi_predefined_file_t end

mutable struct ompi_predefined_info_t end

function MPI_Abort(comm, errorcode)
    ccall((:MPI_Abort, libmpi), Cint, (MPI_Comm, Cint), comm, errorcode)
end

function MPI_Accumulate(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    ccall((:MPI_Accumulate, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

function MPI_Add_error_class(errorclass)
    ccall((:MPI_Add_error_class, libmpi), Cint, (Ptr{Cint},), errorclass)
end

function MPI_Add_error_code(errorclass, errorcode)
    ccall((:MPI_Add_error_code, libmpi), Cint, (Cint, Ptr{Cint}), errorclass, errorcode)
end

function MPI_Add_error_string(errorcode, string)
    ccall((:MPI_Add_error_string, libmpi), Cint, (Cint, Ptr{Cchar}), errorcode, string)
end

function MPI_Allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:MPI_Allgather, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function MPI_Iallgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:MPI_Iallgather, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function MPI_Allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    ccall((:MPI_Allgatherv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

function MPI_Iallgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    ccall((:MPI_Iallgatherv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

function MPI_Alloc_mem(size, info, baseptr)
    ccall((:MPI_Alloc_mem, libmpi), Cint, (MPI_Aint, MPI_Info, Ptr{Cvoid}), size, info, baseptr)
end

function MPI_Allreduce(sendbuf, recvbuf, count, datatype, op, comm)
    ccall((:MPI_Allreduce, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

function MPI_Iallreduce(sendbuf, recvbuf, count, datatype, op, comm, request)
    ccall((:MPI_Iallreduce, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

function MPI_Alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:MPI_Alltoall, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function MPI_Ialltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:MPI_Ialltoall, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function MPI_Alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    ccall((:MPI_Alltoallv, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

function MPI_Ialltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    ccall((:MPI_Ialltoallv, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

function MPI_Alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    ccall((:MPI_Alltoallw, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPI_Comm), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

function MPI_Ialltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    ccall((:MPI_Ialltoallw, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

function MPI_Barrier(comm)
    ccall((:MPI_Barrier, libmpi), Cint, (MPI_Comm,), comm)
end

function MPI_Ibarrier(comm, request)
    ccall((:MPI_Ibarrier, libmpi), Cint, (MPI_Comm, Ptr{MPI_Request}), comm, request)
end

function MPI_Bcast(buffer, count, datatype, root, comm)
    ccall((:MPI_Bcast, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm), buffer, count, datatype, root, comm)
end

function MPI_Bsend(buf, count, datatype, dest, tag, comm)
    ccall((:MPI_Bsend, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

function MPI_Ibcast(buffer, count, datatype, root, comm, request)
    ccall((:MPI_Ibcast, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), buffer, count, datatype, root, comm, request)
end

function MPI_Bsend_init(buf, count, datatype, dest, tag, comm, request)
    ccall((:MPI_Bsend_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function MPI_Buffer_attach(buffer, size)
    ccall((:MPI_Buffer_attach, libmpi), Cint, (Ptr{Cvoid}, Cint), buffer, size)
end

function MPI_Buffer_detach(buffer, size)
    ccall((:MPI_Buffer_detach, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}), buffer, size)
end

function MPI_Cancel(request)
    ccall((:MPI_Cancel, libmpi), Cint, (Ptr{MPI_Request},), request)
end

function MPI_Cart_coords(comm, rank, maxdims, coords)
    ccall((:MPI_Cart_coords, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{Cint}), comm, rank, maxdims, coords)
end

function MPI_Cart_create(old_comm, ndims, dims, periods, reorder, comm_cart)
    ccall((:MPI_Cart_create, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{MPI_Comm}), old_comm, ndims, dims, periods, reorder, comm_cart)
end

function MPI_Cart_get(comm, maxdims, dims, periods, coords)
    ccall((:MPI_Cart_get, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), comm, maxdims, dims, periods, coords)
end

function MPI_Cart_map(comm, ndims, dims, periods, newrank)
    ccall((:MPI_Cart_map, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), comm, ndims, dims, periods, newrank)
end

function MPI_Cart_rank(comm, coords, rank)
    ccall((:MPI_Cart_rank, libmpi), Cint, (MPI_Comm, Ptr{Cint}, Ptr{Cint}), comm, coords, rank)
end

function MPI_Cart_shift(comm, direction, disp, rank_source, rank_dest)
    ccall((:MPI_Cart_shift, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{Cint}, Ptr{Cint}), comm, direction, disp, rank_source, rank_dest)
end

function MPI_Cart_sub(comm, remain_dims, new_comm)
    ccall((:MPI_Cart_sub, libmpi), Cint, (MPI_Comm, Ptr{Cint}, Ptr{MPI_Comm}), comm, remain_dims, new_comm)
end

function MPI_Cartdim_get(comm, ndims)
    ccall((:MPI_Cartdim_get, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, ndims)
end

function MPI_Close_port(port_name)
    ccall((:MPI_Close_port, libmpi), Cint, (Ptr{Cchar},), port_name)
end

function MPI_Comm_accept(port_name, info, root, comm, newcomm)
    ccall((:MPI_Comm_accept, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Cint, MPI_Comm, Ptr{MPI_Comm}), port_name, info, root, comm, newcomm)
end

function MPI_Comm_c2f(comm)
    ccall((:MPI_Comm_c2f, libmpi), Cint, (MPI_Comm,), comm)
end

function MPI_Comm_call_errhandler(comm, errorcode)
    ccall((:MPI_Comm_call_errhandler, libmpi), Cint, (MPI_Comm, Cint), comm, errorcode)
end

function MPI_Comm_compare(comm1, comm2, result)
    ccall((:MPI_Comm_compare, libmpi), Cint, (MPI_Comm, MPI_Comm, Ptr{Cint}), comm1, comm2, result)
end

function MPI_Comm_connect(port_name, info, root, comm, newcomm)
    ccall((:MPI_Comm_connect, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Cint, MPI_Comm, Ptr{MPI_Comm}), port_name, info, root, comm, newcomm)
end

function MPI_Comm_create_errhandler(_function, errhandler)
    ccall((:MPI_Comm_create_errhandler, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Errhandler}), _function, errhandler)
end

function MPI_Comm_create_keyval(comm_copy_attr_fn, comm_delete_attr_fn, comm_keyval, extra_state)
    ccall((:MPI_Comm_create_keyval, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cvoid}), comm_copy_attr_fn, comm_delete_attr_fn, comm_keyval, extra_state)
end

function MPI_Comm_create_group(comm, group, tag, newcomm)
    ccall((:MPI_Comm_create_group, libmpi), Cint, (MPI_Comm, MPI_Group, Cint, Ptr{MPI_Comm}), comm, group, tag, newcomm)
end

function MPI_Comm_create(comm, group, newcomm)
    ccall((:MPI_Comm_create, libmpi), Cint, (MPI_Comm, MPI_Group, Ptr{MPI_Comm}), comm, group, newcomm)
end

function MPI_Comm_delete_attr(comm, comm_keyval)
    ccall((:MPI_Comm_delete_attr, libmpi), Cint, (MPI_Comm, Cint), comm, comm_keyval)
end

function MPI_Comm_disconnect(comm)
    ccall((:MPI_Comm_disconnect, libmpi), Cint, (Ptr{MPI_Comm},), comm)
end

function MPI_Comm_dup(comm, newcomm)
    ccall((:MPI_Comm_dup, libmpi), Cint, (MPI_Comm, Ptr{MPI_Comm}), comm, newcomm)
end

function MPI_Comm_idup(comm, newcomm, request)
    ccall((:MPI_Comm_idup, libmpi), Cint, (MPI_Comm, Ptr{MPI_Comm}, Ptr{MPI_Request}), comm, newcomm, request)
end

function MPI_Comm_dup_with_info(comm, info, newcomm)
    ccall((:MPI_Comm_dup_with_info, libmpi), Cint, (MPI_Comm, MPI_Info, Ptr{MPI_Comm}), comm, info, newcomm)
end

function MPI_Comm_f2c(comm)
    ccall((:MPI_Comm_f2c, libmpi), MPI_Comm, (Cint,), comm)
end

function MPI_Comm_free_keyval(comm_keyval)
    ccall((:MPI_Comm_free_keyval, libmpi), Cint, (Ptr{Cint},), comm_keyval)
end

function MPI_Comm_free(comm)
    ccall((:MPI_Comm_free, libmpi), Cint, (Ptr{MPI_Comm},), comm)
end

function MPI_Comm_get_attr(comm, comm_keyval, attribute_val, flag)
    ccall((:MPI_Comm_get_attr, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cvoid}, Ptr{Cint}), comm, comm_keyval, attribute_val, flag)
end

function MPI_Dist_graph_create(comm_old, n, nodes, degrees, targets, weights, info, reorder, newcomm)
    ccall((:MPI_Dist_graph_create, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, MPI_Info, Cint, Ptr{MPI_Comm}), comm_old, n, nodes, degrees, targets, weights, info, reorder, newcomm)
end

function MPI_Dist_graph_create_adjacent(comm_old, indegree, sources, sourceweights, outdegree, destinations, destweights, info, reorder, comm_dist_graph)
    ccall((:MPI_Dist_graph_create_adjacent, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{Cint}, Ptr{Cint}, MPI_Info, Cint, Ptr{MPI_Comm}), comm_old, indegree, sources, sourceweights, outdegree, destinations, destweights, info, reorder, comm_dist_graph)
end

function MPI_Dist_graph_neighbors(comm, maxindegree, sources, sourceweights, maxoutdegree, destinations, destweights)
    ccall((:MPI_Dist_graph_neighbors, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{Cint}, Ptr{Cint}), comm, maxindegree, sources, sourceweights, maxoutdegree, destinations, destweights)
end

function MPI_Dist_graph_neighbors_count(comm, inneighbors, outneighbors, weighted)
    ccall((:MPI_Dist_graph_neighbors_count, libmpi), Cint, (MPI_Comm, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), comm, inneighbors, outneighbors, weighted)
end

function MPI_Comm_get_errhandler(comm, erhandler)
    ccall((:MPI_Comm_get_errhandler, libmpi), Cint, (MPI_Comm, Ptr{MPI_Errhandler}), comm, erhandler)
end

function MPI_Comm_get_info(comm, info_used)
    ccall((:MPI_Comm_get_info, libmpi), Cint, (MPI_Comm, Ptr{MPI_Info}), comm, info_used)
end

function MPI_Comm_get_name(comm, comm_name, resultlen)
    ccall((:MPI_Comm_get_name, libmpi), Cint, (MPI_Comm, Ptr{Cchar}, Ptr{Cint}), comm, comm_name, resultlen)
end

function MPI_Comm_get_parent(parent)
    ccall((:MPI_Comm_get_parent, libmpi), Cint, (Ptr{MPI_Comm},), parent)
end

function MPI_Comm_group(comm, group)
    ccall((:MPI_Comm_group, libmpi), Cint, (MPI_Comm, Ptr{MPI_Group}), comm, group)
end

function MPI_Comm_join(fd, intercomm)
    ccall((:MPI_Comm_join, libmpi), Cint, (Cint, Ptr{MPI_Comm}), fd, intercomm)
end

function MPI_Comm_rank(comm, rank)
    ccall((:MPI_Comm_rank, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, rank)
end

function MPI_Comm_remote_group(comm, group)
    ccall((:MPI_Comm_remote_group, libmpi), Cint, (MPI_Comm, Ptr{MPI_Group}), comm, group)
end

function MPI_Comm_remote_size(comm, size)
    ccall((:MPI_Comm_remote_size, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, size)
end

function MPI_Comm_set_attr(comm, comm_keyval, attribute_val)
    ccall((:MPI_Comm_set_attr, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cvoid}), comm, comm_keyval, attribute_val)
end

function MPI_Comm_set_errhandler(comm, errhandler)
    ccall((:MPI_Comm_set_errhandler, libmpi), Cint, (MPI_Comm, MPI_Errhandler), comm, errhandler)
end

function MPI_Comm_set_info(comm, info)
    ccall((:MPI_Comm_set_info, libmpi), Cint, (MPI_Comm, MPI_Info), comm, info)
end

function MPI_Comm_set_name(comm, comm_name)
    ccall((:MPI_Comm_set_name, libmpi), Cint, (MPI_Comm, Ptr{Cchar}), comm, comm_name)
end

function MPI_Comm_size(comm, size)
    ccall((:MPI_Comm_size, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, size)
end

function MPI_Comm_spawn(command, argv, maxprocs, info, root, comm, intercomm, array_of_errcodes)
    ccall((:MPI_Comm_spawn, libmpi), Cint, (Ptr{Cchar}, Ptr{Ptr{Cchar}}, Cint, MPI_Info, Cint, MPI_Comm, Ptr{MPI_Comm}, Ptr{Cint}), command, argv, maxprocs, info, root, comm, intercomm, array_of_errcodes)
end

function MPI_Comm_spawn_multiple(count, array_of_commands, array_of_argv, array_of_maxprocs, array_of_info, root, comm, intercomm, array_of_errcodes)
    ccall((:MPI_Comm_spawn_multiple, libmpi), Cint, (Cint, Ptr{Ptr{Cchar}}, Ptr{Ptr{Ptr{Cchar}}}, Ptr{Cint}, Ptr{MPI_Info}, Cint, MPI_Comm, Ptr{MPI_Comm}, Ptr{Cint}), count, array_of_commands, array_of_argv, array_of_maxprocs, array_of_info, root, comm, intercomm, array_of_errcodes)
end

function MPI_Comm_split(comm, color, key, newcomm)
    ccall((:MPI_Comm_split, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{MPI_Comm}), comm, color, key, newcomm)
end

function MPI_Comm_split_type(comm, split_type, key, info, newcomm)
    ccall((:MPI_Comm_split_type, libmpi), Cint, (MPI_Comm, Cint, Cint, MPI_Info, Ptr{MPI_Comm}), comm, split_type, key, info, newcomm)
end

function MPI_Comm_test_inter(comm, flag)
    ccall((:MPI_Comm_test_inter, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, flag)
end

function MPI_Compare_and_swap(origin_addr, compare_addr, result_addr, datatype, target_rank, target_disp, win)
    ccall((:MPI_Compare_and_swap, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, MPI_Datatype, Cint, MPI_Aint, MPI_Win), origin_addr, compare_addr, result_addr, datatype, target_rank, target_disp, win)
end

function MPI_Dims_create(nnodes, ndims, dims)
    ccall((:MPI_Dims_create, libmpi), Cint, (Cint, Cint, Ptr{Cint}), nnodes, ndims, dims)
end

function MPI_Errhandler_c2f(errhandler)
    ccall((:MPI_Errhandler_c2f, libmpi), Cint, (MPI_Errhandler,), errhandler)
end

function MPI_Errhandler_f2c(errhandler)
    ccall((:MPI_Errhandler_f2c, libmpi), MPI_Errhandler, (Cint,), errhandler)
end

function MPI_Errhandler_free(errhandler)
    ccall((:MPI_Errhandler_free, libmpi), Cint, (Ptr{MPI_Errhandler},), errhandler)
end

function MPI_Error_class(errorcode, errorclass)
    ccall((:MPI_Error_class, libmpi), Cint, (Cint, Ptr{Cint}), errorcode, errorclass)
end

function MPI_Error_string(errorcode, string, resultlen)
    ccall((:MPI_Error_string, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}), errorcode, string, resultlen)
end

function MPI_Exscan(sendbuf, recvbuf, count, datatype, op, comm)
    ccall((:MPI_Exscan, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

function MPI_Fetch_and_op(origin_addr, result_addr, datatype, target_rank, target_disp, op, win)
    ccall((:MPI_Fetch_and_op, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Datatype, Cint, MPI_Aint, MPI_Op, MPI_Win), origin_addr, result_addr, datatype, target_rank, target_disp, op, win)
end

function MPI_Iexscan(sendbuf, recvbuf, count, datatype, op, comm, request)
    ccall((:MPI_Iexscan, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

function MPI_File_c2f(file)
    ccall((:MPI_File_c2f, libmpi), Cint, (MPI_File,), file)
end

function MPI_File_f2c(file)
    ccall((:MPI_File_f2c, libmpi), MPI_File, (Cint,), file)
end

function MPI_File_call_errhandler(fh, errorcode)
    ccall((:MPI_File_call_errhandler, libmpi), Cint, (MPI_File, Cint), fh, errorcode)
end

function MPI_File_create_errhandler(_function, errhandler)
    ccall((:MPI_File_create_errhandler, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Errhandler}), _function, errhandler)
end

function MPI_File_set_errhandler(file, errhandler)
    ccall((:MPI_File_set_errhandler, libmpi), Cint, (MPI_File, MPI_Errhandler), file, errhandler)
end

function MPI_File_get_errhandler(file, errhandler)
    ccall((:MPI_File_get_errhandler, libmpi), Cint, (MPI_File, Ptr{MPI_Errhandler}), file, errhandler)
end

function MPI_File_open(comm, filename, amode, info, fh)
    ccall((:MPI_File_open, libmpi), Cint, (MPI_Comm, Ptr{Cchar}, Cint, MPI_Info, Ptr{MPI_File}), comm, filename, amode, info, fh)
end

function MPI_File_close(fh)
    ccall((:MPI_File_close, libmpi), Cint, (Ptr{MPI_File},), fh)
end

function MPI_File_delete(filename, info)
    ccall((:MPI_File_delete, libmpi), Cint, (Ptr{Cchar}, MPI_Info), filename, info)
end

function MPI_File_set_size(fh, size)
    ccall((:MPI_File_set_size, libmpi), Cint, (MPI_File, MPI_Offset), fh, size)
end

function MPI_File_preallocate(fh, size)
    ccall((:MPI_File_preallocate, libmpi), Cint, (MPI_File, MPI_Offset), fh, size)
end

function MPI_File_get_size(fh, size)
    ccall((:MPI_File_get_size, libmpi), Cint, (MPI_File, Ptr{MPI_Offset}), fh, size)
end

function MPI_File_get_group(fh, group)
    ccall((:MPI_File_get_group, libmpi), Cint, (MPI_File, Ptr{MPI_Group}), fh, group)
end

function MPI_File_get_amode(fh, amode)
    ccall((:MPI_File_get_amode, libmpi), Cint, (MPI_File, Ptr{Cint}), fh, amode)
end

function MPI_File_set_info(fh, info)
    ccall((:MPI_File_set_info, libmpi), Cint, (MPI_File, MPI_Info), fh, info)
end

function MPI_File_get_info(fh, info_used)
    ccall((:MPI_File_get_info, libmpi), Cint, (MPI_File, Ptr{MPI_Info}), fh, info_used)
end

function MPI_File_set_view(fh, disp, etype, filetype, datarep, info)
    ccall((:MPI_File_set_view, libmpi), Cint, (MPI_File, MPI_Offset, MPI_Datatype, MPI_Datatype, Ptr{Cchar}, MPI_Info), fh, disp, etype, filetype, datarep, info)
end

function MPI_File_get_view(fh, disp, etype, filetype, datarep)
    ccall((:MPI_File_get_view, libmpi), Cint, (MPI_File, Ptr{MPI_Offset}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}, Ptr{Cchar}), fh, disp, etype, filetype, datarep)
end

function MPI_File_read_at(fh, offset, buf, count, datatype, status)
    ccall((:MPI_File_read_at, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

function MPI_File_read_at_all(fh, offset, buf, count, datatype, status)
    ccall((:MPI_File_read_at_all, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

function MPI_File_write_at(fh, offset, buf, count, datatype, status)
    ccall((:MPI_File_write_at, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

function MPI_File_write_at_all(fh, offset, buf, count, datatype, status)
    ccall((:MPI_File_write_at_all, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

function MPI_File_iread_at(fh, offset, buf, count, datatype, request)
    ccall((:MPI_File_iread_at, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

function MPI_File_iwrite_at(fh, offset, buf, count, datatype, request)
    ccall((:MPI_File_iwrite_at, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

function MPI_File_iread_at_all(fh, offset, buf, count, datatype, request)
    ccall((:MPI_File_iread_at_all, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

function MPI_File_iwrite_at_all(fh, offset, buf, count, datatype, request)
    ccall((:MPI_File_iwrite_at_all, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

function MPI_File_read(fh, buf, count, datatype, status)
    ccall((:MPI_File_read, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function MPI_File_read_all(fh, buf, count, datatype, status)
    ccall((:MPI_File_read_all, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function MPI_File_write(fh, buf, count, datatype, status)
    ccall((:MPI_File_write, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function MPI_File_write_all(fh, buf, count, datatype, status)
    ccall((:MPI_File_write_all, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function MPI_File_iread(fh, buf, count, datatype, request)
    ccall((:MPI_File_iread, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

function MPI_File_iwrite(fh, buf, count, datatype, request)
    ccall((:MPI_File_iwrite, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

function MPI_File_iread_all(fh, buf, count, datatype, request)
    ccall((:MPI_File_iread_all, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

function MPI_File_iwrite_all(fh, buf, count, datatype, request)
    ccall((:MPI_File_iwrite_all, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

function MPI_File_seek(fh, offset, whence)
    ccall((:MPI_File_seek, libmpi), Cint, (MPI_File, MPI_Offset, Cint), fh, offset, whence)
end

function MPI_File_get_position(fh, offset)
    ccall((:MPI_File_get_position, libmpi), Cint, (MPI_File, Ptr{MPI_Offset}), fh, offset)
end

function MPI_File_get_byte_offset(fh, offset, disp)
    ccall((:MPI_File_get_byte_offset, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{MPI_Offset}), fh, offset, disp)
end

function MPI_File_read_shared(fh, buf, count, datatype, status)
    ccall((:MPI_File_read_shared, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function MPI_File_write_shared(fh, buf, count, datatype, status)
    ccall((:MPI_File_write_shared, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function MPI_File_iread_shared(fh, buf, count, datatype, request)
    ccall((:MPI_File_iread_shared, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

function MPI_File_iwrite_shared(fh, buf, count, datatype, request)
    ccall((:MPI_File_iwrite_shared, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

function MPI_File_read_ordered(fh, buf, count, datatype, status)
    ccall((:MPI_File_read_ordered, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function MPI_File_write_ordered(fh, buf, count, datatype, status)
    ccall((:MPI_File_write_ordered, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function MPI_File_seek_shared(fh, offset, whence)
    ccall((:MPI_File_seek_shared, libmpi), Cint, (MPI_File, MPI_Offset, Cint), fh, offset, whence)
end

function MPI_File_get_position_shared(fh, offset)
    ccall((:MPI_File_get_position_shared, libmpi), Cint, (MPI_File, Ptr{MPI_Offset}), fh, offset)
end

function MPI_File_read_at_all_begin(fh, offset, buf, count, datatype)
    ccall((:MPI_File_read_at_all_begin, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype), fh, offset, buf, count, datatype)
end

function MPI_File_read_at_all_end(fh, buf, status)
    ccall((:MPI_File_read_at_all_end, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Ptr{MPI_Status}), fh, buf, status)
end

function MPI_File_write_at_all_begin(fh, offset, buf, count, datatype)
    ccall((:MPI_File_write_at_all_begin, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype), fh, offset, buf, count, datatype)
end

function MPI_File_write_at_all_end(fh, buf, status)
    ccall((:MPI_File_write_at_all_end, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Ptr{MPI_Status}), fh, buf, status)
end

function MPI_File_read_all_begin(fh, buf, count, datatype)
    ccall((:MPI_File_read_all_begin, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype), fh, buf, count, datatype)
end

function MPI_File_read_all_end(fh, buf, status)
    ccall((:MPI_File_read_all_end, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Ptr{MPI_Status}), fh, buf, status)
end

function MPI_File_write_all_begin(fh, buf, count, datatype)
    ccall((:MPI_File_write_all_begin, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype), fh, buf, count, datatype)
end

function MPI_File_write_all_end(fh, buf, status)
    ccall((:MPI_File_write_all_end, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Ptr{MPI_Status}), fh, buf, status)
end

function MPI_File_read_ordered_begin(fh, buf, count, datatype)
    ccall((:MPI_File_read_ordered_begin, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype), fh, buf, count, datatype)
end

function MPI_File_read_ordered_end(fh, buf, status)
    ccall((:MPI_File_read_ordered_end, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Ptr{MPI_Status}), fh, buf, status)
end

function MPI_File_write_ordered_begin(fh, buf, count, datatype)
    ccall((:MPI_File_write_ordered_begin, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype), fh, buf, count, datatype)
end

function MPI_File_write_ordered_end(fh, buf, status)
    ccall((:MPI_File_write_ordered_end, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Ptr{MPI_Status}), fh, buf, status)
end

function MPI_File_get_type_extent(fh, datatype, extent)
    ccall((:MPI_File_get_type_extent, libmpi), Cint, (MPI_File, MPI_Datatype, Ptr{MPI_Aint}), fh, datatype, extent)
end

function MPI_File_set_atomicity(fh, flag)
    ccall((:MPI_File_set_atomicity, libmpi), Cint, (MPI_File, Cint), fh, flag)
end

function MPI_File_get_atomicity(fh, flag)
    ccall((:MPI_File_get_atomicity, libmpi), Cint, (MPI_File, Ptr{Cint}), fh, flag)
end

function MPI_File_sync(fh)
    ccall((:MPI_File_sync, libmpi), Cint, (MPI_File,), fh)
end

function MPI_Finalize()
    ccall((:MPI_Finalize, libmpi), Cint, ())
end

function MPI_Finalized(flag)
    ccall((:MPI_Finalized, libmpi), Cint, (Ptr{Cint},), flag)
end

function MPI_Free_mem(base)
    ccall((:MPI_Free_mem, libmpi), Cint, (Ptr{Cvoid},), base)
end

function MPI_Gather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    ccall((:MPI_Gather, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

function MPI_Igather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    ccall((:MPI_Igather, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

function MPI_Gatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
    ccall((:MPI_Gatherv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
end

function MPI_Igatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
    ccall((:MPI_Igatherv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
end

function MPI_Get_address(location, address)
    ccall((:MPI_Get_address, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Aint}), location, address)
end

function MPI_Get_count(status, datatype, count)
    ccall((:MPI_Get_count, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Ptr{Cint}), status, datatype, count)
end

function MPI_Get_elements(status, datatype, count)
    ccall((:MPI_Get_elements, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Ptr{Cint}), status, datatype, count)
end

function MPI_Get_elements_x(status, datatype, count)
    ccall((:MPI_Get_elements_x, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Ptr{MPI_Count}), status, datatype, count)
end

function MPI_Get(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    ccall((:MPI_Get, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

function MPI_Get_accumulate(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    ccall((:MPI_Get_accumulate, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win), origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

function MPI_Get_library_version(version, resultlen)
    ccall((:MPI_Get_library_version, libmpi), Cint, (Ptr{Cchar}, Ptr{Cint}), version, resultlen)
end

function MPI_Get_processor_name(name, resultlen)
    ccall((:MPI_Get_processor_name, libmpi), Cint, (Ptr{Cchar}, Ptr{Cint}), name, resultlen)
end

function MPI_Get_version(version, subversion)
    ccall((:MPI_Get_version, libmpi), Cint, (Ptr{Cint}, Ptr{Cint}), version, subversion)
end

function MPI_Graph_create(comm_old, nnodes, index, edges, reorder, comm_graph)
    ccall((:MPI_Graph_create, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{MPI_Comm}), comm_old, nnodes, index, edges, reorder, comm_graph)
end

function MPI_Graph_get(comm, maxindex, maxedges, index, edges)
    ccall((:MPI_Graph_get, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{Cint}, Ptr{Cint}), comm, maxindex, maxedges, index, edges)
end

function MPI_Graph_map(comm, nnodes, index, edges, newrank)
    ccall((:MPI_Graph_map, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), comm, nnodes, index, edges, newrank)
end

function MPI_Graph_neighbors_count(comm, rank, nneighbors)
    ccall((:MPI_Graph_neighbors_count, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}), comm, rank, nneighbors)
end

function MPI_Graph_neighbors(comm, rank, maxneighbors, neighbors)
    ccall((:MPI_Graph_neighbors, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{Cint}), comm, rank, maxneighbors, neighbors)
end

function MPI_Graphdims_get(comm, nnodes, nedges)
    ccall((:MPI_Graphdims_get, libmpi), Cint, (MPI_Comm, Ptr{Cint}, Ptr{Cint}), comm, nnodes, nedges)
end

function MPI_Grequest_complete(request)
    ccall((:MPI_Grequest_complete, libmpi), Cint, (MPI_Request,), request)
end

function MPI_Grequest_start(query_fn, free_fn, cancel_fn, extra_state, request)
    ccall((:MPI_Grequest_start, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{MPI_Request}), query_fn, free_fn, cancel_fn, extra_state, request)
end

function MPI_Group_c2f(group)
    ccall((:MPI_Group_c2f, libmpi), Cint, (MPI_Group,), group)
end

function MPI_Group_compare(group1, group2, result)
    ccall((:MPI_Group_compare, libmpi), Cint, (MPI_Group, MPI_Group, Ptr{Cint}), group1, group2, result)
end

function MPI_Group_difference(group1, group2, newgroup)
    ccall((:MPI_Group_difference, libmpi), Cint, (MPI_Group, MPI_Group, Ptr{MPI_Group}), group1, group2, newgroup)
end

function MPI_Group_excl(group, n, ranks, newgroup)
    ccall((:MPI_Group_excl, libmpi), Cint, (MPI_Group, Cint, Ptr{Cint}, Ptr{MPI_Group}), group, n, ranks, newgroup)
end

function MPI_Group_f2c(group)
    ccall((:MPI_Group_f2c, libmpi), MPI_Group, (Cint,), group)
end

function MPI_Group_free(group)
    ccall((:MPI_Group_free, libmpi), Cint, (Ptr{MPI_Group},), group)
end

function MPI_Group_incl(group, n, ranks, newgroup)
    ccall((:MPI_Group_incl, libmpi), Cint, (MPI_Group, Cint, Ptr{Cint}, Ptr{MPI_Group}), group, n, ranks, newgroup)
end

function MPI_Group_intersection(group1, group2, newgroup)
    ccall((:MPI_Group_intersection, libmpi), Cint, (MPI_Group, MPI_Group, Ptr{MPI_Group}), group1, group2, newgroup)
end

function MPI_Group_range_excl(group, n, ranges, newgroup)
    ccall((:MPI_Group_range_excl, libmpi), Cint, (MPI_Group, Cint, Ptr{NTuple{3, Cint}}, Ptr{MPI_Group}), group, n, ranges, newgroup)
end

function MPI_Group_range_incl(group, n, ranges, newgroup)
    ccall((:MPI_Group_range_incl, libmpi), Cint, (MPI_Group, Cint, Ptr{NTuple{3, Cint}}, Ptr{MPI_Group}), group, n, ranges, newgroup)
end

function MPI_Group_rank(group, rank)
    ccall((:MPI_Group_rank, libmpi), Cint, (MPI_Group, Ptr{Cint}), group, rank)
end

function MPI_Group_size(group, size)
    ccall((:MPI_Group_size, libmpi), Cint, (MPI_Group, Ptr{Cint}), group, size)
end

function MPI_Group_translate_ranks(group1, n, ranks1, group2, ranks2)
    ccall((:MPI_Group_translate_ranks, libmpi), Cint, (MPI_Group, Cint, Ptr{Cint}, MPI_Group, Ptr{Cint}), group1, n, ranks1, group2, ranks2)
end

function MPI_Group_union(group1, group2, newgroup)
    ccall((:MPI_Group_union, libmpi), Cint, (MPI_Group, MPI_Group, Ptr{MPI_Group}), group1, group2, newgroup)
end

function MPI_Ibsend(buf, count, datatype, dest, tag, comm, request)
    ccall((:MPI_Ibsend, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function MPI_Improbe(source, tag, comm, flag, message, status)
    ccall((:MPI_Improbe, libmpi), Cint, (Cint, Cint, MPI_Comm, Ptr{Cint}, Ptr{MPI_Message}, Ptr{MPI_Status}), source, tag, comm, flag, message, status)
end

function MPI_Imrecv(buf, count, type, message, request)
    ccall((:MPI_Imrecv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Request}), buf, count, type, message, request)
end

function MPI_Info_c2f(info)
    ccall((:MPI_Info_c2f, libmpi), Cint, (MPI_Info,), info)
end

function MPI_Info_create(info)
    ccall((:MPI_Info_create, libmpi), Cint, (Ptr{MPI_Info},), info)
end

function MPI_Info_delete(info, key)
    ccall((:MPI_Info_delete, libmpi), Cint, (MPI_Info, Ptr{Cchar}), info, key)
end

function MPI_Info_dup(info, newinfo)
    ccall((:MPI_Info_dup, libmpi), Cint, (MPI_Info, Ptr{MPI_Info}), info, newinfo)
end

function MPI_Info_f2c(info)
    ccall((:MPI_Info_f2c, libmpi), MPI_Info, (Cint,), info)
end

function MPI_Info_free(info)
    ccall((:MPI_Info_free, libmpi), Cint, (Ptr{MPI_Info},), info)
end

function MPI_Info_get(info, key, valuelen, value, flag)
    ccall((:MPI_Info_get, libmpi), Cint, (MPI_Info, Ptr{Cchar}, Cint, Ptr{Cchar}, Ptr{Cint}), info, key, valuelen, value, flag)
end

function MPI_Info_get_nkeys(info, nkeys)
    ccall((:MPI_Info_get_nkeys, libmpi), Cint, (MPI_Info, Ptr{Cint}), info, nkeys)
end

function MPI_Info_get_nthkey(info, n, key)
    ccall((:MPI_Info_get_nthkey, libmpi), Cint, (MPI_Info, Cint, Ptr{Cchar}), info, n, key)
end

function MPI_Info_get_valuelen(info, key, valuelen, flag)
    ccall((:MPI_Info_get_valuelen, libmpi), Cint, (MPI_Info, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}), info, key, valuelen, flag)
end

function MPI_Info_set(info, key, value)
    ccall((:MPI_Info_set, libmpi), Cint, (MPI_Info, Ptr{Cchar}, Ptr{Cchar}), info, key, value)
end

function MPI_Init(argc, argv)
    ccall((:MPI_Init, libmpi), Cint, (Ptr{Cint}, Ptr{Ptr{Ptr{Cchar}}}), argc, argv)
end

function MPI_Initialized(flag)
    ccall((:MPI_Initialized, libmpi), Cint, (Ptr{Cint},), flag)
end

function MPI_Init_thread(argc, argv, required, provided)
    ccall((:MPI_Init_thread, libmpi), Cint, (Ptr{Cint}, Ptr{Ptr{Ptr{Cchar}}}, Cint, Ptr{Cint}), argc, argv, required, provided)
end

function MPI_Intercomm_create(local_comm, local_leader, bridge_comm, remote_leader, tag, newintercomm)
    ccall((:MPI_Intercomm_create, libmpi), Cint, (MPI_Comm, Cint, MPI_Comm, Cint, Cint, Ptr{MPI_Comm}), local_comm, local_leader, bridge_comm, remote_leader, tag, newintercomm)
end

function MPI_Intercomm_merge(intercomm, high, newintercomm)
    ccall((:MPI_Intercomm_merge, libmpi), Cint, (MPI_Comm, Cint, Ptr{MPI_Comm}), intercomm, high, newintercomm)
end

function MPI_Iprobe(source, tag, comm, flag, status)
    ccall((:MPI_Iprobe, libmpi), Cint, (Cint, Cint, MPI_Comm, Ptr{Cint}, Ptr{MPI_Status}), source, tag, comm, flag, status)
end

function MPI_Irecv(buf, count, datatype, source, tag, comm, request)
    ccall((:MPI_Irecv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, source, tag, comm, request)
end

function MPI_Irsend(buf, count, datatype, dest, tag, comm, request)
    ccall((:MPI_Irsend, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function MPI_Isend(buf, count, datatype, dest, tag, comm, request)
    ccall((:MPI_Isend, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function MPI_Issend(buf, count, datatype, dest, tag, comm, request)
    ccall((:MPI_Issend, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function MPI_Is_thread_main(flag)
    ccall((:MPI_Is_thread_main, libmpi), Cint, (Ptr{Cint},), flag)
end

function MPI_Lookup_name(service_name, info, port_name)
    ccall((:MPI_Lookup_name, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Ptr{Cchar}), service_name, info, port_name)
end

function MPI_Message_c2f(message)
    ccall((:MPI_Message_c2f, libmpi), Cint, (MPI_Message,), message)
end

function MPI_Message_f2c(message)
    ccall((:MPI_Message_f2c, libmpi), MPI_Message, (Cint,), message)
end

function MPI_Mprobe(source, tag, comm, message, status)
    ccall((:MPI_Mprobe, libmpi), Cint, (Cint, Cint, MPI_Comm, Ptr{MPI_Message}, Ptr{MPI_Status}), source, tag, comm, message, status)
end

function MPI_Mrecv(buf, count, type, message, status)
    ccall((:MPI_Mrecv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Status}), buf, count, type, message, status)
end

function MPI_Neighbor_allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:MPI_Neighbor_allgather, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function MPI_Ineighbor_allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:MPI_Ineighbor_allgather, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function MPI_Neighbor_allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    ccall((:MPI_Neighbor_allgatherv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

function MPI_Ineighbor_allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    ccall((:MPI_Ineighbor_allgatherv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

function MPI_Neighbor_alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:MPI_Neighbor_alltoall, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function MPI_Ineighbor_alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:MPI_Ineighbor_alltoall, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function MPI_Neighbor_alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    ccall((:MPI_Neighbor_alltoallv, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

function MPI_Ineighbor_alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    ccall((:MPI_Ineighbor_alltoallv, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

function MPI_Neighbor_alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    ccall((:MPI_Neighbor_alltoallw, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

function MPI_Ineighbor_alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    ccall((:MPI_Ineighbor_alltoallw, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

function MPI_Op_c2f(op)
    ccall((:MPI_Op_c2f, libmpi), Cint, (MPI_Op,), op)
end

function MPI_Op_commutative(op, commute)
    ccall((:MPI_Op_commutative, libmpi), Cint, (MPI_Op, Ptr{Cint}), op, commute)
end

function MPI_Op_create(_function, commute, op)
    ccall((:MPI_Op_create, libmpi), Cint, (Ptr{Cvoid}, Cint, Ptr{MPI_Op}), _function, commute, op)
end

function MPI_Open_port(info, port_name)
    ccall((:MPI_Open_port, libmpi), Cint, (MPI_Info, Ptr{Cchar}), info, port_name)
end

function MPI_Op_f2c(op)
    ccall((:MPI_Op_f2c, libmpi), MPI_Op, (Cint,), op)
end

function MPI_Op_free(op)
    ccall((:MPI_Op_free, libmpi), Cint, (Ptr{MPI_Op},), op)
end

function MPI_Pack_external(datarep, inbuf, incount, datatype, outbuf, outsize, position)
    ccall((:MPI_Pack_external, libmpi), Cint, (Ptr{Cchar}, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, MPI_Aint, Ptr{MPI_Aint}), datarep, inbuf, incount, datatype, outbuf, outsize, position)
end

function MPI_Pack_external_size(datarep, incount, datatype, size)
    ccall((:MPI_Pack_external_size, libmpi), Cint, (Ptr{Cchar}, Cint, MPI_Datatype, Ptr{MPI_Aint}), datarep, incount, datatype, size)
end

function MPI_Pack(inbuf, incount, datatype, outbuf, outsize, position, comm)
    ccall((:MPI_Pack, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, Ptr{Cint}, MPI_Comm), inbuf, incount, datatype, outbuf, outsize, position, comm)
end

function MPI_Pack_size(incount, datatype, comm, size)
    ccall((:MPI_Pack_size, libmpi), Cint, (Cint, MPI_Datatype, MPI_Comm, Ptr{Cint}), incount, datatype, comm, size)
end

function MPI_Probe(source, tag, comm, status)
    ccall((:MPI_Probe, libmpi), Cint, (Cint, Cint, MPI_Comm, Ptr{MPI_Status}), source, tag, comm, status)
end

function MPI_Publish_name(service_name, info, port_name)
    ccall((:MPI_Publish_name, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Ptr{Cchar}), service_name, info, port_name)
end

function MPI_Put(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    ccall((:MPI_Put, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

function MPI_Query_thread(provided)
    ccall((:MPI_Query_thread, libmpi), Cint, (Ptr{Cint},), provided)
end

function MPI_Raccumulate(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    ccall((:MPI_Raccumulate, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

function MPI_Recv_init(buf, count, datatype, source, tag, comm, request)
    ccall((:MPI_Recv_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, source, tag, comm, request)
end

function MPI_Recv(buf, count, datatype, source, tag, comm, status)
    ccall((:MPI_Recv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), buf, count, datatype, source, tag, comm, status)
end

function MPI_Reduce(sendbuf, recvbuf, count, datatype, op, root, comm)
    ccall((:MPI_Reduce, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm), sendbuf, recvbuf, count, datatype, op, root, comm)
end

function MPI_Ireduce(sendbuf, recvbuf, count, datatype, op, root, comm, request)
    ccall((:MPI_Ireduce, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, root, comm, request)
end

function MPI_Reduce_local(inbuf, inoutbuf, count, datatype, op)
    ccall((:MPI_Reduce_local, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op), inbuf, inoutbuf, count, datatype, op)
end

function MPI_Reduce_scatter(sendbuf, recvbuf, recvcounts, datatype, op, comm)
    ccall((:MPI_Reduce_scatter, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, recvcounts, datatype, op, comm)
end

function MPI_Ireduce_scatter(sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
    ccall((:MPI_Ireduce_scatter, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
end

function MPI_Reduce_scatter_block(sendbuf, recvbuf, recvcount, datatype, op, comm)
    ccall((:MPI_Reduce_scatter_block, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, recvcount, datatype, op, comm)
end

function MPI_Ireduce_scatter_block(sendbuf, recvbuf, recvcount, datatype, op, comm, request)
    ccall((:MPI_Ireduce_scatter_block, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, recvcount, datatype, op, comm, request)
end

function MPI_Register_datarep(datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)
    ccall((:MPI_Register_datarep, libmpi), Cint, (Ptr{Cchar}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}), datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)
end

function MPI_Request_c2f(request)
    ccall((:MPI_Request_c2f, libmpi), Cint, (MPI_Request,), request)
end

function MPI_Request_f2c(request)
    ccall((:MPI_Request_f2c, libmpi), MPI_Request, (Cint,), request)
end

function MPI_Request_free(request)
    ccall((:MPI_Request_free, libmpi), Cint, (Ptr{MPI_Request},), request)
end

function MPI_Request_get_status(request, flag, status)
    ccall((:MPI_Request_get_status, libmpi), Cint, (MPI_Request, Ptr{Cint}, Ptr{MPI_Status}), request, flag, status)
end

function MPI_Rget(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    ccall((:MPI_Rget, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

function MPI_Rget_accumulate(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    ccall((:MPI_Rget_accumulate, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

function MPI_Rput(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_cout, target_datatype, win, request)
    ccall((:MPI_Rput, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_cout, target_datatype, win, request)
end

function MPI_Rsend(ibuf, count, datatype, dest, tag, comm)
    ccall((:MPI_Rsend, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), ibuf, count, datatype, dest, tag, comm)
end

function MPI_Rsend_init(buf, count, datatype, dest, tag, comm, request)
    ccall((:MPI_Rsend_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function MPI_Scan(sendbuf, recvbuf, count, datatype, op, comm)
    ccall((:MPI_Scan, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

function MPI_Iscan(sendbuf, recvbuf, count, datatype, op, comm, request)
    ccall((:MPI_Iscan, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

function MPI_Scatter(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    ccall((:MPI_Scatter, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

function MPI_Iscatter(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    ccall((:MPI_Iscatter, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

function MPI_Scatterv(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
    ccall((:MPI_Scatterv, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

function MPI_Iscatterv(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    ccall((:MPI_Iscatterv, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

function MPI_Send_init(buf, count, datatype, dest, tag, comm, request)
    ccall((:MPI_Send_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function MPI_Send(buf, count, datatype, dest, tag, comm)
    ccall((:MPI_Send, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

function MPI_Sendrecv(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
    ccall((:MPI_Sendrecv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
end

function MPI_Sendrecv_replace(buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
    ccall((:MPI_Sendrecv_replace, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
end

function MPI_Ssend_init(buf, count, datatype, dest, tag, comm, request)
    ccall((:MPI_Ssend_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function MPI_Ssend(buf, count, datatype, dest, tag, comm)
    ccall((:MPI_Ssend, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

function MPI_Start(request)
    ccall((:MPI_Start, libmpi), Cint, (Ptr{MPI_Request},), request)
end

function MPI_Startall(count, array_of_requests)
    ccall((:MPI_Startall, libmpi), Cint, (Cint, Ptr{MPI_Request}), count, array_of_requests)
end

function MPI_Status_c2f(c_status, f_status)
    ccall((:MPI_Status_c2f, libmpi), Cint, (Ptr{MPI_Status}, Ptr{Cint}), c_status, f_status)
end

function MPI_Status_f2c(f_status, c_status)
    ccall((:MPI_Status_f2c, libmpi), Cint, (Ptr{Cint}, Ptr{MPI_Status}), f_status, c_status)
end

function MPI_Status_set_cancelled(status, flag)
    ccall((:MPI_Status_set_cancelled, libmpi), Cint, (Ptr{MPI_Status}, Cint), status, flag)
end

function MPI_Status_set_elements(status, datatype, count)
    ccall((:MPI_Status_set_elements, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Cint), status, datatype, count)
end

function MPI_Status_set_elements_x(status, datatype, count)
    ccall((:MPI_Status_set_elements_x, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, MPI_Count), status, datatype, count)
end

function MPI_Testall(count, array_of_requests, flag, array_of_statuses)
    ccall((:MPI_Testall, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{MPI_Status}), count, array_of_requests, flag, array_of_statuses)
end

function MPI_Testany(count, array_of_requests, index, flag, status)
    ccall((:MPI_Testany, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Status}), count, array_of_requests, index, flag, status)
end

function MPI_Test_cancelled(status, flag)
    ccall((:MPI_Test_cancelled, libmpi), Cint, (Ptr{MPI_Status}, Ptr{Cint}), status, flag)
end

function MPI_Testsome(incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
    ccall((:MPI_Testsome, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Status}), incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
end

function MPI_Topo_test(comm, status)
    ccall((:MPI_Topo_test, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, status)
end

function MPI_Type_c2f(datatype)
    ccall((:MPI_Type_c2f, libmpi), Cint, (MPI_Datatype,), datatype)
end

function MPI_Type_commit(type)
    ccall((:MPI_Type_commit, libmpi), Cint, (Ptr{MPI_Datatype},), type)
end

function MPI_Type_contiguous(count, oldtype, newtype)
    ccall((:MPI_Type_contiguous, libmpi), Cint, (Cint, MPI_Datatype, Ptr{MPI_Datatype}), count, oldtype, newtype)
end

function MPI_Type_create_darray(size, rank, ndims, gsize_array, distrib_array, darg_array, psize_array, order, oldtype, newtype)
    ccall((:MPI_Type_create_darray, libmpi), Cint, (Cint, Cint, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), size, rank, ndims, gsize_array, distrib_array, darg_array, psize_array, order, oldtype, newtype)
end

function MPI_Type_create_f90_complex(p, r, newtype)
    ccall((:MPI_Type_create_f90_complex, libmpi), Cint, (Cint, Cint, Ptr{MPI_Datatype}), p, r, newtype)
end

function MPI_Type_create_f90_integer(r, newtype)
    ccall((:MPI_Type_create_f90_integer, libmpi), Cint, (Cint, Ptr{MPI_Datatype}), r, newtype)
end

function MPI_Type_create_f90_real(p, r, newtype)
    ccall((:MPI_Type_create_f90_real, libmpi), Cint, (Cint, Cint, Ptr{MPI_Datatype}), p, r, newtype)
end

function MPI_Type_create_hindexed_block(count, blocklength, array_of_displacements, oldtype, newtype)
    ccall((:MPI_Type_create_hindexed_block, libmpi), Cint, (Cint, Cint, Ptr{MPI_Aint}, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, array_of_displacements, oldtype, newtype)
end

function MPI_Type_create_hindexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    ccall((:MPI_Type_create_hindexed, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

function MPI_Type_create_hvector(count, blocklength, stride, oldtype, newtype)
    ccall((:MPI_Type_create_hvector, libmpi), Cint, (Cint, Cint, MPI_Aint, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

function MPI_Type_create_keyval(type_copy_attr_fn, type_delete_attr_fn, type_keyval, extra_state)
    ccall((:MPI_Type_create_keyval, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cvoid}), type_copy_attr_fn, type_delete_attr_fn, type_keyval, extra_state)
end

function MPI_Type_create_indexed_block(count, blocklength, array_of_displacements, oldtype, newtype)
    ccall((:MPI_Type_create_indexed_block, libmpi), Cint, (Cint, Cint, Ptr{Cint}, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, array_of_displacements, oldtype, newtype)
end

function MPI_Type_create_struct(count, array_of_block_lengths, array_of_displacements, array_of_types, newtype)
    ccall((:MPI_Type_create_struct, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}), count, array_of_block_lengths, array_of_displacements, array_of_types, newtype)
end

function MPI_Type_create_subarray(ndims, size_array, subsize_array, start_array, order, oldtype, newtype)
    ccall((:MPI_Type_create_subarray, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), ndims, size_array, subsize_array, start_array, order, oldtype, newtype)
end

function MPI_Type_create_resized(oldtype, lb, extent, newtype)
    ccall((:MPI_Type_create_resized, libmpi), Cint, (MPI_Datatype, MPI_Aint, MPI_Aint, Ptr{MPI_Datatype}), oldtype, lb, extent, newtype)
end

function MPI_Type_delete_attr(type, type_keyval)
    ccall((:MPI_Type_delete_attr, libmpi), Cint, (MPI_Datatype, Cint), type, type_keyval)
end

function MPI_Type_dup(type, newtype)
    ccall((:MPI_Type_dup, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Datatype}), type, newtype)
end

function MPI_Type_free(type)
    ccall((:MPI_Type_free, libmpi), Cint, (Ptr{MPI_Datatype},), type)
end

function MPI_Type_free_keyval(type_keyval)
    ccall((:MPI_Type_free_keyval, libmpi), Cint, (Ptr{Cint},), type_keyval)
end

function MPI_Type_f2c(datatype)
    ccall((:MPI_Type_f2c, libmpi), MPI_Datatype, (Cint,), datatype)
end

function MPI_Type_get_attr(type, type_keyval, attribute_val, flag)
    ccall((:MPI_Type_get_attr, libmpi), Cint, (MPI_Datatype, Cint, Ptr{Cvoid}, Ptr{Cint}), type, type_keyval, attribute_val, flag)
end

function MPI_Type_get_contents(mtype, max_integers, max_addresses, max_datatypes, array_of_integers, array_of_addresses, array_of_datatypes)
    ccall((:MPI_Type_get_contents, libmpi), Cint, (MPI_Datatype, Cint, Cint, Cint, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}), mtype, max_integers, max_addresses, max_datatypes, array_of_integers, array_of_addresses, array_of_datatypes)
end

function MPI_Type_get_envelope(type, num_integers, num_addresses, num_datatypes, combiner)
    ccall((:MPI_Type_get_envelope, libmpi), Cint, (MPI_Datatype, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), type, num_integers, num_addresses, num_datatypes, combiner)
end

function MPI_Type_get_extent(type, lb, extent)
    ccall((:MPI_Type_get_extent, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Aint}, Ptr{MPI_Aint}), type, lb, extent)
end

function MPI_Type_get_extent_x(type, lb, extent)
    ccall((:MPI_Type_get_extent_x, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), type, lb, extent)
end

function MPI_Type_get_name(type, type_name, resultlen)
    ccall((:MPI_Type_get_name, libmpi), Cint, (MPI_Datatype, Ptr{Cchar}, Ptr{Cint}), type, type_name, resultlen)
end

function MPI_Type_get_true_extent(datatype, true_lb, true_extent)
    ccall((:MPI_Type_get_true_extent, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Aint}, Ptr{MPI_Aint}), datatype, true_lb, true_extent)
end

function MPI_Type_get_true_extent_x(datatype, true_lb, true_extent)
    ccall((:MPI_Type_get_true_extent_x, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), datatype, true_lb, true_extent)
end

function MPI_Type_indexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    ccall((:MPI_Type_indexed, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

function MPI_Type_match_size(typeclass, size, type)
    ccall((:MPI_Type_match_size, libmpi), Cint, (Cint, Cint, Ptr{MPI_Datatype}), typeclass, size, type)
end

function MPI_Type_set_attr(type, type_keyval, attr_val)
    ccall((:MPI_Type_set_attr, libmpi), Cint, (MPI_Datatype, Cint, Ptr{Cvoid}), type, type_keyval, attr_val)
end

function MPI_Type_set_name(type, type_name)
    ccall((:MPI_Type_set_name, libmpi), Cint, (MPI_Datatype, Ptr{Cchar}), type, type_name)
end

function MPI_Type_size(type, size)
    ccall((:MPI_Type_size, libmpi), Cint, (MPI_Datatype, Ptr{Cint}), type, size)
end

function MPI_Type_size_x(type, size)
    ccall((:MPI_Type_size_x, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}), type, size)
end

function MPI_Type_vector(count, blocklength, stride, oldtype, newtype)
    ccall((:MPI_Type_vector, libmpi), Cint, (Cint, Cint, Cint, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

function MPI_Unpack(inbuf, insize, position, outbuf, outcount, datatype, comm)
    ccall((:MPI_Unpack, libmpi), Cint, (Ptr{Cvoid}, Cint, Ptr{Cint}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm), inbuf, insize, position, outbuf, outcount, datatype, comm)
end

function MPI_Unpublish_name(service_name, info, port_name)
    ccall((:MPI_Unpublish_name, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Ptr{Cchar}), service_name, info, port_name)
end

function MPI_Unpack_external(datarep, inbuf, insize, position, outbuf, outcount, datatype)
    ccall((:MPI_Unpack_external, libmpi), Cint, (Ptr{Cchar}, Ptr{Cvoid}, MPI_Aint, Ptr{MPI_Aint}, Ptr{Cvoid}, Cint, MPI_Datatype), datarep, inbuf, insize, position, outbuf, outcount, datatype)
end

function MPI_Waitall(count, array_of_requests, array_of_statuses)
    ccall((:MPI_Waitall, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{MPI_Status}), count, array_of_requests, array_of_statuses)
end

function MPI_Waitany(count, array_of_requests, index, status)
    ccall((:MPI_Waitany, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{MPI_Status}), count, array_of_requests, index, status)
end

function MPI_Waitsome(incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
    ccall((:MPI_Waitsome, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Status}), incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
end

function MPI_Win_allocate(size, disp_unit, info, comm, baseptr, win)
    ccall((:MPI_Win_allocate, libmpi), Cint, (MPI_Aint, Cint, MPI_Info, MPI_Comm, Ptr{Cvoid}, Ptr{MPI_Win}), size, disp_unit, info, comm, baseptr, win)
end

function MPI_Win_allocate_shared(size, disp_unit, info, comm, baseptr, win)
    ccall((:MPI_Win_allocate_shared, libmpi), Cint, (MPI_Aint, Cint, MPI_Info, MPI_Comm, Ptr{Cvoid}, Ptr{MPI_Win}), size, disp_unit, info, comm, baseptr, win)
end

function MPI_Win_attach(win, base, size)
    ccall((:MPI_Win_attach, libmpi), Cint, (MPI_Win, Ptr{Cvoid}, MPI_Aint), win, base, size)
end

function MPI_Win_c2f(win)
    ccall((:MPI_Win_c2f, libmpi), Cint, (MPI_Win,), win)
end

function MPI_Win_call_errhandler(win, errorcode)
    ccall((:MPI_Win_call_errhandler, libmpi), Cint, (MPI_Win, Cint), win, errorcode)
end

function MPI_Win_complete(win)
    ccall((:MPI_Win_complete, libmpi), Cint, (MPI_Win,), win)
end

function MPI_Win_create(base, size, disp_unit, info, comm, win)
    ccall((:MPI_Win_create, libmpi), Cint, (Ptr{Cvoid}, MPI_Aint, Cint, MPI_Info, MPI_Comm, Ptr{MPI_Win}), base, size, disp_unit, info, comm, win)
end

function MPI_Win_create_dynamic(info, comm, win)
    ccall((:MPI_Win_create_dynamic, libmpi), Cint, (MPI_Info, MPI_Comm, Ptr{MPI_Win}), info, comm, win)
end

function MPI_Win_create_errhandler(_function, errhandler)
    ccall((:MPI_Win_create_errhandler, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Errhandler}), _function, errhandler)
end

function MPI_Win_create_keyval(win_copy_attr_fn, win_delete_attr_fn, win_keyval, extra_state)
    ccall((:MPI_Win_create_keyval, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cvoid}), win_copy_attr_fn, win_delete_attr_fn, win_keyval, extra_state)
end

function MPI_Win_delete_attr(win, win_keyval)
    ccall((:MPI_Win_delete_attr, libmpi), Cint, (MPI_Win, Cint), win, win_keyval)
end

function MPI_Win_detach(win, base)
    ccall((:MPI_Win_detach, libmpi), Cint, (MPI_Win, Ptr{Cvoid}), win, base)
end

function MPI_Win_f2c(win)
    ccall((:MPI_Win_f2c, libmpi), MPI_Win, (Cint,), win)
end

function MPI_Win_fence(assert, win)
    ccall((:MPI_Win_fence, libmpi), Cint, (Cint, MPI_Win), assert, win)
end

function MPI_Win_flush(rank, win)
    ccall((:MPI_Win_flush, libmpi), Cint, (Cint, MPI_Win), rank, win)
end

function MPI_Win_flush_all(win)
    ccall((:MPI_Win_flush_all, libmpi), Cint, (MPI_Win,), win)
end

function MPI_Win_flush_local(rank, win)
    ccall((:MPI_Win_flush_local, libmpi), Cint, (Cint, MPI_Win), rank, win)
end

function MPI_Win_flush_local_all(win)
    ccall((:MPI_Win_flush_local_all, libmpi), Cint, (MPI_Win,), win)
end

function MPI_Win_free(win)
    ccall((:MPI_Win_free, libmpi), Cint, (Ptr{MPI_Win},), win)
end

function MPI_Win_free_keyval(win_keyval)
    ccall((:MPI_Win_free_keyval, libmpi), Cint, (Ptr{Cint},), win_keyval)
end

function MPI_Win_get_attr(win, win_keyval, attribute_val, flag)
    ccall((:MPI_Win_get_attr, libmpi), Cint, (MPI_Win, Cint, Ptr{Cvoid}, Ptr{Cint}), win, win_keyval, attribute_val, flag)
end

function MPI_Win_get_errhandler(win, errhandler)
    ccall((:MPI_Win_get_errhandler, libmpi), Cint, (MPI_Win, Ptr{MPI_Errhandler}), win, errhandler)
end

function MPI_Win_get_group(win, group)
    ccall((:MPI_Win_get_group, libmpi), Cint, (MPI_Win, Ptr{MPI_Group}), win, group)
end

function MPI_Win_get_info(win, info_used)
    ccall((:MPI_Win_get_info, libmpi), Cint, (MPI_Win, Ptr{MPI_Info}), win, info_used)
end

function MPI_Win_get_name(win, win_name, resultlen)
    ccall((:MPI_Win_get_name, libmpi), Cint, (MPI_Win, Ptr{Cchar}, Ptr{Cint}), win, win_name, resultlen)
end

function MPI_Win_lock(lock_type, rank, assert, win)
    ccall((:MPI_Win_lock, libmpi), Cint, (Cint, Cint, Cint, MPI_Win), lock_type, rank, assert, win)
end

function MPI_Win_lock_all(assert, win)
    ccall((:MPI_Win_lock_all, libmpi), Cint, (Cint, MPI_Win), assert, win)
end

function MPI_Win_post(group, assert, win)
    ccall((:MPI_Win_post, libmpi), Cint, (MPI_Group, Cint, MPI_Win), group, assert, win)
end

function MPI_Win_set_attr(win, win_keyval, attribute_val)
    ccall((:MPI_Win_set_attr, libmpi), Cint, (MPI_Win, Cint, Ptr{Cvoid}), win, win_keyval, attribute_val)
end

function MPI_Win_set_errhandler(win, errhandler)
    ccall((:MPI_Win_set_errhandler, libmpi), Cint, (MPI_Win, MPI_Errhandler), win, errhandler)
end

function MPI_Win_set_info(win, info)
    ccall((:MPI_Win_set_info, libmpi), Cint, (MPI_Win, MPI_Info), win, info)
end

function MPI_Win_set_name(win, win_name)
    ccall((:MPI_Win_set_name, libmpi), Cint, (MPI_Win, Ptr{Cchar}), win, win_name)
end

function MPI_Win_shared_query(win, rank, size, disp_unit, baseptr)
    ccall((:MPI_Win_shared_query, libmpi), Cint, (MPI_Win, Cint, Ptr{MPI_Aint}, Ptr{Cint}, Ptr{Cvoid}), win, rank, size, disp_unit, baseptr)
end

function MPI_Win_start(group, assert, win)
    ccall((:MPI_Win_start, libmpi), Cint, (MPI_Group, Cint, MPI_Win), group, assert, win)
end

function MPI_Win_sync(win)
    ccall((:MPI_Win_sync, libmpi), Cint, (MPI_Win,), win)
end

function MPI_Win_test(win, flag)
    ccall((:MPI_Win_test, libmpi), Cint, (MPI_Win, Ptr{Cint}), win, flag)
end

function MPI_Win_unlock(rank, win)
    ccall((:MPI_Win_unlock, libmpi), Cint, (Cint, MPI_Win), rank, win)
end

function MPI_Win_unlock_all(win)
    ccall((:MPI_Win_unlock_all, libmpi), Cint, (MPI_Win,), win)
end

function MPI_Win_wait(win)
    ccall((:MPI_Win_wait, libmpi), Cint, (MPI_Win,), win)
end

function MPI_Wtick()
    ccall((:MPI_Wtick, libmpi), Cdouble, ())
end

function MPI_Wtime()
    ccall((:MPI_Wtime, libmpi), Cdouble, ())
end

function PMPI_Abort(comm, errorcode)
    ccall((:PMPI_Abort, libmpi), Cint, (MPI_Comm, Cint), comm, errorcode)
end

function PMPI_Accumulate(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    ccall((:PMPI_Accumulate, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

function PMPI_Add_error_class(errorclass)
    ccall((:PMPI_Add_error_class, libmpi), Cint, (Ptr{Cint},), errorclass)
end

function PMPI_Add_error_code(errorclass, errorcode)
    ccall((:PMPI_Add_error_code, libmpi), Cint, (Cint, Ptr{Cint}), errorclass, errorcode)
end

function PMPI_Add_error_string(errorcode, string)
    ccall((:PMPI_Add_error_string, libmpi), Cint, (Cint, Ptr{Cchar}), errorcode, string)
end

function PMPI_Allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:PMPI_Allgather, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function PMPI_Iallgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:PMPI_Iallgather, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function PMPI_Allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    ccall((:PMPI_Allgatherv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

function PMPI_Iallgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    ccall((:PMPI_Iallgatherv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

function PMPI_Alloc_mem(size, info, baseptr)
    ccall((:PMPI_Alloc_mem, libmpi), Cint, (MPI_Aint, MPI_Info, Ptr{Cvoid}), size, info, baseptr)
end

function PMPI_Allreduce(sendbuf, recvbuf, count, datatype, op, comm)
    ccall((:PMPI_Allreduce, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

function PMPI_Iallreduce(sendbuf, recvbuf, count, datatype, op, comm, request)
    ccall((:PMPI_Iallreduce, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

function PMPI_Alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:PMPI_Alltoall, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function PMPI_Ialltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:PMPI_Ialltoall, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function PMPI_Alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    ccall((:PMPI_Alltoallv, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

function PMPI_Ialltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    ccall((:PMPI_Ialltoallv, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

function PMPI_Alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    ccall((:PMPI_Alltoallw, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPI_Comm), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

function PMPI_Ialltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    ccall((:PMPI_Ialltoallw, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

function PMPI_Dist_graph_create(comm_old, n, nodes, degrees, targets, weights, info, reorder, newcomm)
    ccall((:PMPI_Dist_graph_create, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, MPI_Info, Cint, Ptr{MPI_Comm}), comm_old, n, nodes, degrees, targets, weights, info, reorder, newcomm)
end

function PMPI_Dist_graph_create_adjacent(comm_old, indegree, sources, sourceweights, outdegree, destinations, destweights, info, reorder, comm_dist_graph)
    ccall((:PMPI_Dist_graph_create_adjacent, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{Cint}, Ptr{Cint}, MPI_Info, Cint, Ptr{MPI_Comm}), comm_old, indegree, sources, sourceweights, outdegree, destinations, destweights, info, reorder, comm_dist_graph)
end

function PMPI_Dist_graph_neighbors(comm, maxindegree, sources, sourceweights, maxoutdegree, destinations, destweights)
    ccall((:PMPI_Dist_graph_neighbors, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{Cint}, Ptr{Cint}), comm, maxindegree, sources, sourceweights, maxoutdegree, destinations, destweights)
end

function PMPI_Dist_graph_neighbors_count(comm, inneighbors, outneighbors, weighted)
    ccall((:PMPI_Dist_graph_neighbors_count, libmpi), Cint, (MPI_Comm, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), comm, inneighbors, outneighbors, weighted)
end

function PMPI_Barrier(comm)
    ccall((:PMPI_Barrier, libmpi), Cint, (MPI_Comm,), comm)
end

function PMPI_Ibarrier(comm, request)
    ccall((:PMPI_Ibarrier, libmpi), Cint, (MPI_Comm, Ptr{MPI_Request}), comm, request)
end

function PMPI_Bcast(buffer, count, datatype, root, comm)
    ccall((:PMPI_Bcast, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm), buffer, count, datatype, root, comm)
end

function PMPI_Ibcast(buffer, count, datatype, root, comm, request)
    ccall((:PMPI_Ibcast, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), buffer, count, datatype, root, comm, request)
end

function PMPI_Bsend(buf, count, datatype, dest, tag, comm)
    ccall((:PMPI_Bsend, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

function PMPI_Bsend_init(buf, count, datatype, dest, tag, comm, request)
    ccall((:PMPI_Bsend_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function PMPI_Buffer_attach(buffer, size)
    ccall((:PMPI_Buffer_attach, libmpi), Cint, (Ptr{Cvoid}, Cint), buffer, size)
end

function PMPI_Buffer_detach(buffer, size)
    ccall((:PMPI_Buffer_detach, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}), buffer, size)
end

function PMPI_Cancel(request)
    ccall((:PMPI_Cancel, libmpi), Cint, (Ptr{MPI_Request},), request)
end

function PMPI_Cart_coords(comm, rank, maxdims, coords)
    ccall((:PMPI_Cart_coords, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{Cint}), comm, rank, maxdims, coords)
end

function PMPI_Cart_create(old_comm, ndims, dims, periods, reorder, comm_cart)
    ccall((:PMPI_Cart_create, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{MPI_Comm}), old_comm, ndims, dims, periods, reorder, comm_cart)
end

function PMPI_Cart_get(comm, maxdims, dims, periods, coords)
    ccall((:PMPI_Cart_get, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), comm, maxdims, dims, periods, coords)
end

function PMPI_Cart_map(comm, ndims, dims, periods, newrank)
    ccall((:PMPI_Cart_map, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), comm, ndims, dims, periods, newrank)
end

function PMPI_Cart_rank(comm, coords, rank)
    ccall((:PMPI_Cart_rank, libmpi), Cint, (MPI_Comm, Ptr{Cint}, Ptr{Cint}), comm, coords, rank)
end

function PMPI_Cart_shift(comm, direction, disp, rank_source, rank_dest)
    ccall((:PMPI_Cart_shift, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{Cint}, Ptr{Cint}), comm, direction, disp, rank_source, rank_dest)
end

function PMPI_Cart_sub(comm, remain_dims, new_comm)
    ccall((:PMPI_Cart_sub, libmpi), Cint, (MPI_Comm, Ptr{Cint}, Ptr{MPI_Comm}), comm, remain_dims, new_comm)
end

function PMPI_Cartdim_get(comm, ndims)
    ccall((:PMPI_Cartdim_get, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, ndims)
end

function PMPI_Close_port(port_name)
    ccall((:PMPI_Close_port, libmpi), Cint, (Ptr{Cchar},), port_name)
end

function PMPI_Comm_accept(port_name, info, root, comm, newcomm)
    ccall((:PMPI_Comm_accept, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Cint, MPI_Comm, Ptr{MPI_Comm}), port_name, info, root, comm, newcomm)
end

function PMPI_Comm_c2f(comm)
    ccall((:PMPI_Comm_c2f, libmpi), Cint, (MPI_Comm,), comm)
end

function PMPI_Comm_call_errhandler(comm, errorcode)
    ccall((:PMPI_Comm_call_errhandler, libmpi), Cint, (MPI_Comm, Cint), comm, errorcode)
end

function PMPI_Comm_compare(comm1, comm2, result)
    ccall((:PMPI_Comm_compare, libmpi), Cint, (MPI_Comm, MPI_Comm, Ptr{Cint}), comm1, comm2, result)
end

function PMPI_Comm_connect(port_name, info, root, comm, newcomm)
    ccall((:PMPI_Comm_connect, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Cint, MPI_Comm, Ptr{MPI_Comm}), port_name, info, root, comm, newcomm)
end

function PMPI_Comm_create_errhandler(_function, errhandler)
    ccall((:PMPI_Comm_create_errhandler, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Errhandler}), _function, errhandler)
end

function PMPI_Comm_create_keyval(comm_copy_attr_fn, comm_delete_attr_fn, comm_keyval, extra_state)
    ccall((:PMPI_Comm_create_keyval, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cvoid}), comm_copy_attr_fn, comm_delete_attr_fn, comm_keyval, extra_state)
end

function PMPI_Comm_create_group(comm, group, tag, newcomm)
    ccall((:PMPI_Comm_create_group, libmpi), Cint, (MPI_Comm, MPI_Group, Cint, Ptr{MPI_Comm}), comm, group, tag, newcomm)
end

function PMPI_Comm_create(comm, group, newcomm)
    ccall((:PMPI_Comm_create, libmpi), Cint, (MPI_Comm, MPI_Group, Ptr{MPI_Comm}), comm, group, newcomm)
end

function PMPI_Comm_delete_attr(comm, comm_keyval)
    ccall((:PMPI_Comm_delete_attr, libmpi), Cint, (MPI_Comm, Cint), comm, comm_keyval)
end

function PMPI_Comm_disconnect(comm)
    ccall((:PMPI_Comm_disconnect, libmpi), Cint, (Ptr{MPI_Comm},), comm)
end

function PMPI_Comm_dup(comm, newcomm)
    ccall((:PMPI_Comm_dup, libmpi), Cint, (MPI_Comm, Ptr{MPI_Comm}), comm, newcomm)
end

function PMPI_Comm_idup(comm, newcomm, request)
    ccall((:PMPI_Comm_idup, libmpi), Cint, (MPI_Comm, Ptr{MPI_Comm}, Ptr{MPI_Request}), comm, newcomm, request)
end

function PMPI_Comm_dup_with_info(comm, info, newcomm)
    ccall((:PMPI_Comm_dup_with_info, libmpi), Cint, (MPI_Comm, MPI_Info, Ptr{MPI_Comm}), comm, info, newcomm)
end

function PMPI_Comm_f2c(comm)
    ccall((:PMPI_Comm_f2c, libmpi), MPI_Comm, (Cint,), comm)
end

function PMPI_Comm_free_keyval(comm_keyval)
    ccall((:PMPI_Comm_free_keyval, libmpi), Cint, (Ptr{Cint},), comm_keyval)
end

function PMPI_Comm_free(comm)
    ccall((:PMPI_Comm_free, libmpi), Cint, (Ptr{MPI_Comm},), comm)
end

function PMPI_Comm_get_attr(comm, comm_keyval, attribute_val, flag)
    ccall((:PMPI_Comm_get_attr, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cvoid}, Ptr{Cint}), comm, comm_keyval, attribute_val, flag)
end

function PMPI_Comm_get_errhandler(comm, erhandler)
    ccall((:PMPI_Comm_get_errhandler, libmpi), Cint, (MPI_Comm, Ptr{MPI_Errhandler}), comm, erhandler)
end

function PMPI_Comm_get_info(comm, info_used)
    ccall((:PMPI_Comm_get_info, libmpi), Cint, (MPI_Comm, Ptr{MPI_Info}), comm, info_used)
end

function PMPI_Comm_get_name(comm, comm_name, resultlen)
    ccall((:PMPI_Comm_get_name, libmpi), Cint, (MPI_Comm, Ptr{Cchar}, Ptr{Cint}), comm, comm_name, resultlen)
end

function PMPI_Comm_get_parent(parent)
    ccall((:PMPI_Comm_get_parent, libmpi), Cint, (Ptr{MPI_Comm},), parent)
end

function PMPI_Comm_group(comm, group)
    ccall((:PMPI_Comm_group, libmpi), Cint, (MPI_Comm, Ptr{MPI_Group}), comm, group)
end

function PMPI_Comm_join(fd, intercomm)
    ccall((:PMPI_Comm_join, libmpi), Cint, (Cint, Ptr{MPI_Comm}), fd, intercomm)
end

function PMPI_Comm_rank(comm, rank)
    ccall((:PMPI_Comm_rank, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, rank)
end

function PMPI_Comm_remote_group(comm, group)
    ccall((:PMPI_Comm_remote_group, libmpi), Cint, (MPI_Comm, Ptr{MPI_Group}), comm, group)
end

function PMPI_Comm_remote_size(comm, size)
    ccall((:PMPI_Comm_remote_size, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, size)
end

function PMPI_Comm_set_attr(comm, comm_keyval, attribute_val)
    ccall((:PMPI_Comm_set_attr, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cvoid}), comm, comm_keyval, attribute_val)
end

function PMPI_Comm_set_errhandler(comm, errhandler)
    ccall((:PMPI_Comm_set_errhandler, libmpi), Cint, (MPI_Comm, MPI_Errhandler), comm, errhandler)
end

function PMPI_Comm_set_info(comm, info)
    ccall((:PMPI_Comm_set_info, libmpi), Cint, (MPI_Comm, MPI_Info), comm, info)
end

function PMPI_Comm_set_name(comm, comm_name)
    ccall((:PMPI_Comm_set_name, libmpi), Cint, (MPI_Comm, Ptr{Cchar}), comm, comm_name)
end

function PMPI_Comm_size(comm, size)
    ccall((:PMPI_Comm_size, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, size)
end

function PMPI_Comm_spawn(command, argv, maxprocs, info, root, comm, intercomm, array_of_errcodes)
    ccall((:PMPI_Comm_spawn, libmpi), Cint, (Ptr{Cchar}, Ptr{Ptr{Cchar}}, Cint, MPI_Info, Cint, MPI_Comm, Ptr{MPI_Comm}, Ptr{Cint}), command, argv, maxprocs, info, root, comm, intercomm, array_of_errcodes)
end

function PMPI_Comm_spawn_multiple(count, array_of_commands, array_of_argv, array_of_maxprocs, array_of_info, root, comm, intercomm, array_of_errcodes)
    ccall((:PMPI_Comm_spawn_multiple, libmpi), Cint, (Cint, Ptr{Ptr{Cchar}}, Ptr{Ptr{Ptr{Cchar}}}, Ptr{Cint}, Ptr{MPI_Info}, Cint, MPI_Comm, Ptr{MPI_Comm}, Ptr{Cint}), count, array_of_commands, array_of_argv, array_of_maxprocs, array_of_info, root, comm, intercomm, array_of_errcodes)
end

function PMPI_Comm_split(comm, color, key, newcomm)
    ccall((:PMPI_Comm_split, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{MPI_Comm}), comm, color, key, newcomm)
end

function PMPI_Comm_split_type(comm, split_type, key, info, newcomm)
    ccall((:PMPI_Comm_split_type, libmpi), Cint, (MPI_Comm, Cint, Cint, MPI_Info, Ptr{MPI_Comm}), comm, split_type, key, info, newcomm)
end

function PMPI_Comm_test_inter(comm, flag)
    ccall((:PMPI_Comm_test_inter, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, flag)
end

function PMPI_Compare_and_swap(origin_addr, compare_addr, result_addr, datatype, target_rank, target_disp, win)
    ccall((:PMPI_Compare_and_swap, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, MPI_Datatype, Cint, MPI_Aint, MPI_Win), origin_addr, compare_addr, result_addr, datatype, target_rank, target_disp, win)
end

function PMPI_Dims_create(nnodes, ndims, dims)
    ccall((:PMPI_Dims_create, libmpi), Cint, (Cint, Cint, Ptr{Cint}), nnodes, ndims, dims)
end

function PMPI_Errhandler_c2f(errhandler)
    ccall((:PMPI_Errhandler_c2f, libmpi), Cint, (MPI_Errhandler,), errhandler)
end

function PMPI_Errhandler_f2c(errhandler)
    ccall((:PMPI_Errhandler_f2c, libmpi), MPI_Errhandler, (Cint,), errhandler)
end

function PMPI_Errhandler_free(errhandler)
    ccall((:PMPI_Errhandler_free, libmpi), Cint, (Ptr{MPI_Errhandler},), errhandler)
end

function PMPI_Error_class(errorcode, errorclass)
    ccall((:PMPI_Error_class, libmpi), Cint, (Cint, Ptr{Cint}), errorcode, errorclass)
end

function PMPI_Error_string(errorcode, string, resultlen)
    ccall((:PMPI_Error_string, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}), errorcode, string, resultlen)
end

function PMPI_Exscan(sendbuf, recvbuf, count, datatype, op, comm)
    ccall((:PMPI_Exscan, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

function PMPI_Fetch_and_op(origin_addr, result_addr, datatype, target_rank, target_disp, op, win)
    ccall((:PMPI_Fetch_and_op, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Datatype, Cint, MPI_Aint, MPI_Op, MPI_Win), origin_addr, result_addr, datatype, target_rank, target_disp, op, win)
end

function PMPI_Iexscan(sendbuf, recvbuf, count, datatype, op, comm, request)
    ccall((:PMPI_Iexscan, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

function PMPI_File_c2f(file)
    ccall((:PMPI_File_c2f, libmpi), Cint, (MPI_File,), file)
end

function PMPI_File_f2c(file)
    ccall((:PMPI_File_f2c, libmpi), MPI_File, (Cint,), file)
end

function PMPI_File_call_errhandler(fh, errorcode)
    ccall((:PMPI_File_call_errhandler, libmpi), Cint, (MPI_File, Cint), fh, errorcode)
end

function PMPI_File_create_errhandler(_function, errhandler)
    ccall((:PMPI_File_create_errhandler, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Errhandler}), _function, errhandler)
end

function PMPI_File_set_errhandler(file, errhandler)
    ccall((:PMPI_File_set_errhandler, libmpi), Cint, (MPI_File, MPI_Errhandler), file, errhandler)
end

function PMPI_File_get_errhandler(file, errhandler)
    ccall((:PMPI_File_get_errhandler, libmpi), Cint, (MPI_File, Ptr{MPI_Errhandler}), file, errhandler)
end

function PMPI_File_open(comm, filename, amode, info, fh)
    ccall((:PMPI_File_open, libmpi), Cint, (MPI_Comm, Ptr{Cchar}, Cint, MPI_Info, Ptr{MPI_File}), comm, filename, amode, info, fh)
end

function PMPI_File_close(fh)
    ccall((:PMPI_File_close, libmpi), Cint, (Ptr{MPI_File},), fh)
end

function PMPI_File_delete(filename, info)
    ccall((:PMPI_File_delete, libmpi), Cint, (Ptr{Cchar}, MPI_Info), filename, info)
end

function PMPI_File_set_size(fh, size)
    ccall((:PMPI_File_set_size, libmpi), Cint, (MPI_File, MPI_Offset), fh, size)
end

function PMPI_File_preallocate(fh, size)
    ccall((:PMPI_File_preallocate, libmpi), Cint, (MPI_File, MPI_Offset), fh, size)
end

function PMPI_File_get_size(fh, size)
    ccall((:PMPI_File_get_size, libmpi), Cint, (MPI_File, Ptr{MPI_Offset}), fh, size)
end

function PMPI_File_get_group(fh, group)
    ccall((:PMPI_File_get_group, libmpi), Cint, (MPI_File, Ptr{MPI_Group}), fh, group)
end

function PMPI_File_get_amode(fh, amode)
    ccall((:PMPI_File_get_amode, libmpi), Cint, (MPI_File, Ptr{Cint}), fh, amode)
end

function PMPI_File_set_info(fh, info)
    ccall((:PMPI_File_set_info, libmpi), Cint, (MPI_File, MPI_Info), fh, info)
end

function PMPI_File_get_info(fh, info_used)
    ccall((:PMPI_File_get_info, libmpi), Cint, (MPI_File, Ptr{MPI_Info}), fh, info_used)
end

function PMPI_File_set_view(fh, disp, etype, filetype, datarep, info)
    ccall((:PMPI_File_set_view, libmpi), Cint, (MPI_File, MPI_Offset, MPI_Datatype, MPI_Datatype, Ptr{Cchar}, MPI_Info), fh, disp, etype, filetype, datarep, info)
end

function PMPI_File_get_view(fh, disp, etype, filetype, datarep)
    ccall((:PMPI_File_get_view, libmpi), Cint, (MPI_File, Ptr{MPI_Offset}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}, Ptr{Cchar}), fh, disp, etype, filetype, datarep)
end

function PMPI_File_read_at(fh, offset, buf, count, datatype, status)
    ccall((:PMPI_File_read_at, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

function PMPI_File_read_at_all(fh, offset, buf, count, datatype, status)
    ccall((:PMPI_File_read_at_all, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

function PMPI_File_write_at(fh, offset, buf, count, datatype, status)
    ccall((:PMPI_File_write_at, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

function PMPI_File_write_at_all(fh, offset, buf, count, datatype, status)
    ccall((:PMPI_File_write_at_all, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

function PMPI_File_iread_at(fh, offset, buf, count, datatype, request)
    ccall((:PMPI_File_iread_at, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

function PMPI_File_iwrite_at(fh, offset, buf, count, datatype, request)
    ccall((:PMPI_File_iwrite_at, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

function PMPI_File_iread_at_all(fh, offset, buf, count, datatype, request)
    ccall((:PMPI_File_iread_at_all, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

function PMPI_File_iwrite_at_all(fh, offset, buf, count, datatype, request)
    ccall((:PMPI_File_iwrite_at_all, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

function PMPI_File_read(fh, buf, count, datatype, status)
    ccall((:PMPI_File_read, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function PMPI_File_read_all(fh, buf, count, datatype, status)
    ccall((:PMPI_File_read_all, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function PMPI_File_write(fh, buf, count, datatype, status)
    ccall((:PMPI_File_write, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function PMPI_File_write_all(fh, buf, count, datatype, status)
    ccall((:PMPI_File_write_all, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function PMPI_File_iread(fh, buf, count, datatype, request)
    ccall((:PMPI_File_iread, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

function PMPI_File_iwrite(fh, buf, count, datatype, request)
    ccall((:PMPI_File_iwrite, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

function PMPI_File_iread_all(fh, buf, count, datatype, request)
    ccall((:PMPI_File_iread_all, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

function PMPI_File_iwrite_all(fh, buf, count, datatype, request)
    ccall((:PMPI_File_iwrite_all, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

function PMPI_File_seek(fh, offset, whence)
    ccall((:PMPI_File_seek, libmpi), Cint, (MPI_File, MPI_Offset, Cint), fh, offset, whence)
end

function PMPI_File_get_position(fh, offset)
    ccall((:PMPI_File_get_position, libmpi), Cint, (MPI_File, Ptr{MPI_Offset}), fh, offset)
end

function PMPI_File_get_byte_offset(fh, offset, disp)
    ccall((:PMPI_File_get_byte_offset, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{MPI_Offset}), fh, offset, disp)
end

function PMPI_File_read_shared(fh, buf, count, datatype, status)
    ccall((:PMPI_File_read_shared, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function PMPI_File_write_shared(fh, buf, count, datatype, status)
    ccall((:PMPI_File_write_shared, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function PMPI_File_iread_shared(fh, buf, count, datatype, request)
    ccall((:PMPI_File_iread_shared, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

function PMPI_File_iwrite_shared(fh, buf, count, datatype, request)
    ccall((:PMPI_File_iwrite_shared, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

function PMPI_File_read_ordered(fh, buf, count, datatype, status)
    ccall((:PMPI_File_read_ordered, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function PMPI_File_write_ordered(fh, buf, count, datatype, status)
    ccall((:PMPI_File_write_ordered, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function PMPI_File_seek_shared(fh, offset, whence)
    ccall((:PMPI_File_seek_shared, libmpi), Cint, (MPI_File, MPI_Offset, Cint), fh, offset, whence)
end

function PMPI_File_get_position_shared(fh, offset)
    ccall((:PMPI_File_get_position_shared, libmpi), Cint, (MPI_File, Ptr{MPI_Offset}), fh, offset)
end

function PMPI_File_read_at_all_begin(fh, offset, buf, count, datatype)
    ccall((:PMPI_File_read_at_all_begin, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype), fh, offset, buf, count, datatype)
end

function PMPI_File_read_at_all_end(fh, buf, status)
    ccall((:PMPI_File_read_at_all_end, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Ptr{MPI_Status}), fh, buf, status)
end

function PMPI_File_write_at_all_begin(fh, offset, buf, count, datatype)
    ccall((:PMPI_File_write_at_all_begin, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype), fh, offset, buf, count, datatype)
end

function PMPI_File_write_at_all_end(fh, buf, status)
    ccall((:PMPI_File_write_at_all_end, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Ptr{MPI_Status}), fh, buf, status)
end

function PMPI_File_read_all_begin(fh, buf, count, datatype)
    ccall((:PMPI_File_read_all_begin, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype), fh, buf, count, datatype)
end

function PMPI_File_read_all_end(fh, buf, status)
    ccall((:PMPI_File_read_all_end, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Ptr{MPI_Status}), fh, buf, status)
end

function PMPI_File_write_all_begin(fh, buf, count, datatype)
    ccall((:PMPI_File_write_all_begin, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype), fh, buf, count, datatype)
end

function PMPI_File_write_all_end(fh, buf, status)
    ccall((:PMPI_File_write_all_end, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Ptr{MPI_Status}), fh, buf, status)
end

function PMPI_File_read_ordered_begin(fh, buf, count, datatype)
    ccall((:PMPI_File_read_ordered_begin, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype), fh, buf, count, datatype)
end

function PMPI_File_read_ordered_end(fh, buf, status)
    ccall((:PMPI_File_read_ordered_end, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Ptr{MPI_Status}), fh, buf, status)
end

function PMPI_File_write_ordered_begin(fh, buf, count, datatype)
    ccall((:PMPI_File_write_ordered_begin, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype), fh, buf, count, datatype)
end

function PMPI_File_write_ordered_end(fh, buf, status)
    ccall((:PMPI_File_write_ordered_end, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Ptr{MPI_Status}), fh, buf, status)
end

function PMPI_File_get_type_extent(fh, datatype, extent)
    ccall((:PMPI_File_get_type_extent, libmpi), Cint, (MPI_File, MPI_Datatype, Ptr{MPI_Aint}), fh, datatype, extent)
end

function PMPI_File_set_atomicity(fh, flag)
    ccall((:PMPI_File_set_atomicity, libmpi), Cint, (MPI_File, Cint), fh, flag)
end

function PMPI_File_get_atomicity(fh, flag)
    ccall((:PMPI_File_get_atomicity, libmpi), Cint, (MPI_File, Ptr{Cint}), fh, flag)
end

function PMPI_File_sync(fh)
    ccall((:PMPI_File_sync, libmpi), Cint, (MPI_File,), fh)
end

function PMPI_Finalize()
    ccall((:PMPI_Finalize, libmpi), Cint, ())
end

function PMPI_Finalized(flag)
    ccall((:PMPI_Finalized, libmpi), Cint, (Ptr{Cint},), flag)
end

function PMPI_Free_mem(base)
    ccall((:PMPI_Free_mem, libmpi), Cint, (Ptr{Cvoid},), base)
end

function PMPI_Gather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    ccall((:PMPI_Gather, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

function PMPI_Igather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    ccall((:PMPI_Igather, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

function PMPI_Gatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
    ccall((:PMPI_Gatherv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
end

function PMPI_Igatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
    ccall((:PMPI_Igatherv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
end

function PMPI_Get_address(location, address)
    ccall((:PMPI_Get_address, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Aint}), location, address)
end

function PMPI_Get_count(status, datatype, count)
    ccall((:PMPI_Get_count, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Ptr{Cint}), status, datatype, count)
end

function PMPI_Get_elements(status, datatype, count)
    ccall((:PMPI_Get_elements, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Ptr{Cint}), status, datatype, count)
end

function PMPI_Get_elements_x(status, datatype, count)
    ccall((:PMPI_Get_elements_x, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Ptr{MPI_Count}), status, datatype, count)
end

function PMPI_Get(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    ccall((:PMPI_Get, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

function PMPI_Get_accumulate(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    ccall((:PMPI_Get_accumulate, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win), origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

function PMPI_Get_library_version(version, resultlen)
    ccall((:PMPI_Get_library_version, libmpi), Cint, (Ptr{Cchar}, Ptr{Cint}), version, resultlen)
end

function PMPI_Get_processor_name(name, resultlen)
    ccall((:PMPI_Get_processor_name, libmpi), Cint, (Ptr{Cchar}, Ptr{Cint}), name, resultlen)
end

function PMPI_Get_version(version, subversion)
    ccall((:PMPI_Get_version, libmpi), Cint, (Ptr{Cint}, Ptr{Cint}), version, subversion)
end

function PMPI_Graph_create(comm_old, nnodes, index, edges, reorder, comm_graph)
    ccall((:PMPI_Graph_create, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{MPI_Comm}), comm_old, nnodes, index, edges, reorder, comm_graph)
end

function PMPI_Graph_get(comm, maxindex, maxedges, index, edges)
    ccall((:PMPI_Graph_get, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{Cint}, Ptr{Cint}), comm, maxindex, maxedges, index, edges)
end

function PMPI_Graph_map(comm, nnodes, index, edges, newrank)
    ccall((:PMPI_Graph_map, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), comm, nnodes, index, edges, newrank)
end

function PMPI_Graph_neighbors_count(comm, rank, nneighbors)
    ccall((:PMPI_Graph_neighbors_count, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}), comm, rank, nneighbors)
end

function PMPI_Graph_neighbors(comm, rank, maxneighbors, neighbors)
    ccall((:PMPI_Graph_neighbors, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{Cint}), comm, rank, maxneighbors, neighbors)
end

function PMPI_Graphdims_get(comm, nnodes, nedges)
    ccall((:PMPI_Graphdims_get, libmpi), Cint, (MPI_Comm, Ptr{Cint}, Ptr{Cint}), comm, nnodes, nedges)
end

function PMPI_Grequest_complete(request)
    ccall((:PMPI_Grequest_complete, libmpi), Cint, (MPI_Request,), request)
end

function PMPI_Grequest_start(query_fn, free_fn, cancel_fn, extra_state, request)
    ccall((:PMPI_Grequest_start, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{MPI_Request}), query_fn, free_fn, cancel_fn, extra_state, request)
end

function PMPI_Group_c2f(group)
    ccall((:PMPI_Group_c2f, libmpi), Cint, (MPI_Group,), group)
end

function PMPI_Group_compare(group1, group2, result)
    ccall((:PMPI_Group_compare, libmpi), Cint, (MPI_Group, MPI_Group, Ptr{Cint}), group1, group2, result)
end

function PMPI_Group_difference(group1, group2, newgroup)
    ccall((:PMPI_Group_difference, libmpi), Cint, (MPI_Group, MPI_Group, Ptr{MPI_Group}), group1, group2, newgroup)
end

function PMPI_Group_excl(group, n, ranks, newgroup)
    ccall((:PMPI_Group_excl, libmpi), Cint, (MPI_Group, Cint, Ptr{Cint}, Ptr{MPI_Group}), group, n, ranks, newgroup)
end

function PMPI_Group_f2c(group)
    ccall((:PMPI_Group_f2c, libmpi), MPI_Group, (Cint,), group)
end

function PMPI_Group_free(group)
    ccall((:PMPI_Group_free, libmpi), Cint, (Ptr{MPI_Group},), group)
end

function PMPI_Group_incl(group, n, ranks, newgroup)
    ccall((:PMPI_Group_incl, libmpi), Cint, (MPI_Group, Cint, Ptr{Cint}, Ptr{MPI_Group}), group, n, ranks, newgroup)
end

function PMPI_Group_intersection(group1, group2, newgroup)
    ccall((:PMPI_Group_intersection, libmpi), Cint, (MPI_Group, MPI_Group, Ptr{MPI_Group}), group1, group2, newgroup)
end

function PMPI_Group_range_excl(group, n, ranges, newgroup)
    ccall((:PMPI_Group_range_excl, libmpi), Cint, (MPI_Group, Cint, Ptr{NTuple{3, Cint}}, Ptr{MPI_Group}), group, n, ranges, newgroup)
end

function PMPI_Group_range_incl(group, n, ranges, newgroup)
    ccall((:PMPI_Group_range_incl, libmpi), Cint, (MPI_Group, Cint, Ptr{NTuple{3, Cint}}, Ptr{MPI_Group}), group, n, ranges, newgroup)
end

function PMPI_Group_rank(group, rank)
    ccall((:PMPI_Group_rank, libmpi), Cint, (MPI_Group, Ptr{Cint}), group, rank)
end

function PMPI_Group_size(group, size)
    ccall((:PMPI_Group_size, libmpi), Cint, (MPI_Group, Ptr{Cint}), group, size)
end

function PMPI_Group_translate_ranks(group1, n, ranks1, group2, ranks2)
    ccall((:PMPI_Group_translate_ranks, libmpi), Cint, (MPI_Group, Cint, Ptr{Cint}, MPI_Group, Ptr{Cint}), group1, n, ranks1, group2, ranks2)
end

function PMPI_Group_union(group1, group2, newgroup)
    ccall((:PMPI_Group_union, libmpi), Cint, (MPI_Group, MPI_Group, Ptr{MPI_Group}), group1, group2, newgroup)
end

function PMPI_Ibsend(buf, count, datatype, dest, tag, comm, request)
    ccall((:PMPI_Ibsend, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function PMPI_Improbe(source, tag, comm, flag, message, status)
    ccall((:PMPI_Improbe, libmpi), Cint, (Cint, Cint, MPI_Comm, Ptr{Cint}, Ptr{MPI_Message}, Ptr{MPI_Status}), source, tag, comm, flag, message, status)
end

function PMPI_Imrecv(buf, count, type, message, request)
    ccall((:PMPI_Imrecv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Request}), buf, count, type, message, request)
end

function PMPI_Info_c2f(info)
    ccall((:PMPI_Info_c2f, libmpi), Cint, (MPI_Info,), info)
end

function PMPI_Info_create(info)
    ccall((:PMPI_Info_create, libmpi), Cint, (Ptr{MPI_Info},), info)
end

function PMPI_Info_delete(info, key)
    ccall((:PMPI_Info_delete, libmpi), Cint, (MPI_Info, Ptr{Cchar}), info, key)
end

function PMPI_Info_dup(info, newinfo)
    ccall((:PMPI_Info_dup, libmpi), Cint, (MPI_Info, Ptr{MPI_Info}), info, newinfo)
end

function PMPI_Info_f2c(info)
    ccall((:PMPI_Info_f2c, libmpi), MPI_Info, (Cint,), info)
end

function PMPI_Info_free(info)
    ccall((:PMPI_Info_free, libmpi), Cint, (Ptr{MPI_Info},), info)
end

function PMPI_Info_get(info, key, valuelen, value, flag)
    ccall((:PMPI_Info_get, libmpi), Cint, (MPI_Info, Ptr{Cchar}, Cint, Ptr{Cchar}, Ptr{Cint}), info, key, valuelen, value, flag)
end

function PMPI_Info_get_nkeys(info, nkeys)
    ccall((:PMPI_Info_get_nkeys, libmpi), Cint, (MPI_Info, Ptr{Cint}), info, nkeys)
end

function PMPI_Info_get_nthkey(info, n, key)
    ccall((:PMPI_Info_get_nthkey, libmpi), Cint, (MPI_Info, Cint, Ptr{Cchar}), info, n, key)
end

function PMPI_Info_get_valuelen(info, key, valuelen, flag)
    ccall((:PMPI_Info_get_valuelen, libmpi), Cint, (MPI_Info, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}), info, key, valuelen, flag)
end

function PMPI_Info_set(info, key, value)
    ccall((:PMPI_Info_set, libmpi), Cint, (MPI_Info, Ptr{Cchar}, Ptr{Cchar}), info, key, value)
end

function PMPI_Init(argc, argv)
    ccall((:PMPI_Init, libmpi), Cint, (Ptr{Cint}, Ptr{Ptr{Ptr{Cchar}}}), argc, argv)
end

function PMPI_Initialized(flag)
    ccall((:PMPI_Initialized, libmpi), Cint, (Ptr{Cint},), flag)
end

function PMPI_Init_thread(argc, argv, required, provided)
    ccall((:PMPI_Init_thread, libmpi), Cint, (Ptr{Cint}, Ptr{Ptr{Ptr{Cchar}}}, Cint, Ptr{Cint}), argc, argv, required, provided)
end

function PMPI_Intercomm_create(local_comm, local_leader, bridge_comm, remote_leader, tag, newintercomm)
    ccall((:PMPI_Intercomm_create, libmpi), Cint, (MPI_Comm, Cint, MPI_Comm, Cint, Cint, Ptr{MPI_Comm}), local_comm, local_leader, bridge_comm, remote_leader, tag, newintercomm)
end

function PMPI_Intercomm_merge(intercomm, high, newintercomm)
    ccall((:PMPI_Intercomm_merge, libmpi), Cint, (MPI_Comm, Cint, Ptr{MPI_Comm}), intercomm, high, newintercomm)
end

function PMPI_Iprobe(source, tag, comm, flag, status)
    ccall((:PMPI_Iprobe, libmpi), Cint, (Cint, Cint, MPI_Comm, Ptr{Cint}, Ptr{MPI_Status}), source, tag, comm, flag, status)
end

function PMPI_Irecv(buf, count, datatype, source, tag, comm, request)
    ccall((:PMPI_Irecv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, source, tag, comm, request)
end

function PMPI_Irsend(buf, count, datatype, dest, tag, comm, request)
    ccall((:PMPI_Irsend, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function PMPI_Isend(buf, count, datatype, dest, tag, comm, request)
    ccall((:PMPI_Isend, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function PMPI_Issend(buf, count, datatype, dest, tag, comm, request)
    ccall((:PMPI_Issend, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function PMPI_Is_thread_main(flag)
    ccall((:PMPI_Is_thread_main, libmpi), Cint, (Ptr{Cint},), flag)
end

function PMPI_Lookup_name(service_name, info, port_name)
    ccall((:PMPI_Lookup_name, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Ptr{Cchar}), service_name, info, port_name)
end

function PMPI_Message_c2f(message)
    ccall((:PMPI_Message_c2f, libmpi), Cint, (MPI_Message,), message)
end

function PMPI_Message_f2c(message)
    ccall((:PMPI_Message_f2c, libmpi), MPI_Message, (Cint,), message)
end

function PMPI_Mprobe(source, tag, comm, message, status)
    ccall((:PMPI_Mprobe, libmpi), Cint, (Cint, Cint, MPI_Comm, Ptr{MPI_Message}, Ptr{MPI_Status}), source, tag, comm, message, status)
end

function PMPI_Mrecv(buf, count, type, message, status)
    ccall((:PMPI_Mrecv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Status}), buf, count, type, message, status)
end

function PMPI_Neighbor_allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:PMPI_Neighbor_allgather, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function PMPI_Ineighbor_allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:PMPI_Ineighbor_allgather, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function PMPI_Neighbor_allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    ccall((:PMPI_Neighbor_allgatherv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

function PMPI_Ineighbor_allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    ccall((:PMPI_Ineighbor_allgatherv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

function PMPI_Neighbor_alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:PMPI_Neighbor_alltoall, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function PMPI_Ineighbor_alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:PMPI_Ineighbor_alltoall, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function PMPI_Neighbor_alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    ccall((:PMPI_Neighbor_alltoallv, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

function PMPI_Ineighbor_alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    ccall((:PMPI_Ineighbor_alltoallv, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

function PMPI_Neighbor_alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    ccall((:PMPI_Neighbor_alltoallw, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

function PMPI_Ineighbor_alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    ccall((:PMPI_Ineighbor_alltoallw, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

function PMPI_Op_c2f(op)
    ccall((:PMPI_Op_c2f, libmpi), Cint, (MPI_Op,), op)
end

function PMPI_Op_commutative(op, commute)
    ccall((:PMPI_Op_commutative, libmpi), Cint, (MPI_Op, Ptr{Cint}), op, commute)
end

function PMPI_Op_create(_function, commute, op)
    ccall((:PMPI_Op_create, libmpi), Cint, (Ptr{Cvoid}, Cint, Ptr{MPI_Op}), _function, commute, op)
end

function PMPI_Open_port(info, port_name)
    ccall((:PMPI_Open_port, libmpi), Cint, (MPI_Info, Ptr{Cchar}), info, port_name)
end

function PMPI_Op_f2c(op)
    ccall((:PMPI_Op_f2c, libmpi), MPI_Op, (Cint,), op)
end

function PMPI_Op_free(op)
    ccall((:PMPI_Op_free, libmpi), Cint, (Ptr{MPI_Op},), op)
end

function PMPI_Pack_external(datarep, inbuf, incount, datatype, outbuf, outsize, position)
    ccall((:PMPI_Pack_external, libmpi), Cint, (Ptr{Cchar}, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, MPI_Aint, Ptr{MPI_Aint}), datarep, inbuf, incount, datatype, outbuf, outsize, position)
end

function PMPI_Pack_external_size(datarep, incount, datatype, size)
    ccall((:PMPI_Pack_external_size, libmpi), Cint, (Ptr{Cchar}, Cint, MPI_Datatype, Ptr{MPI_Aint}), datarep, incount, datatype, size)
end

function PMPI_Pack(inbuf, incount, datatype, outbuf, outsize, position, comm)
    ccall((:PMPI_Pack, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, Ptr{Cint}, MPI_Comm), inbuf, incount, datatype, outbuf, outsize, position, comm)
end

function PMPI_Pack_size(incount, datatype, comm, size)
    ccall((:PMPI_Pack_size, libmpi), Cint, (Cint, MPI_Datatype, MPI_Comm, Ptr{Cint}), incount, datatype, comm, size)
end

function PMPI_Probe(source, tag, comm, status)
    ccall((:PMPI_Probe, libmpi), Cint, (Cint, Cint, MPI_Comm, Ptr{MPI_Status}), source, tag, comm, status)
end

function PMPI_Publish_name(service_name, info, port_name)
    ccall((:PMPI_Publish_name, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Ptr{Cchar}), service_name, info, port_name)
end

function PMPI_Put(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    ccall((:PMPI_Put, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

function PMPI_Query_thread(provided)
    ccall((:PMPI_Query_thread, libmpi), Cint, (Ptr{Cint},), provided)
end

function PMPI_Raccumulate(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    ccall((:PMPI_Raccumulate, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

function PMPI_Recv_init(buf, count, datatype, source, tag, comm, request)
    ccall((:PMPI_Recv_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, source, tag, comm, request)
end

function PMPI_Recv(buf, count, datatype, source, tag, comm, status)
    ccall((:PMPI_Recv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), buf, count, datatype, source, tag, comm, status)
end

function PMPI_Reduce(sendbuf, recvbuf, count, datatype, op, root, comm)
    ccall((:PMPI_Reduce, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm), sendbuf, recvbuf, count, datatype, op, root, comm)
end

function PMPI_Ireduce(sendbuf, recvbuf, count, datatype, op, root, comm, request)
    ccall((:PMPI_Ireduce, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, root, comm, request)
end

function PMPI_Reduce_local(inbuf, inoutbuf, count, datatype, arg5)
    ccall((:PMPI_Reduce_local, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op), inbuf, inoutbuf, count, datatype, arg5)
end

function PMPI_Reduce_scatter(sendbuf, recvbuf, recvcounts, datatype, op, comm)
    ccall((:PMPI_Reduce_scatter, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, recvcounts, datatype, op, comm)
end

function PMPI_Ireduce_scatter(sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
    ccall((:PMPI_Ireduce_scatter, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
end

function PMPI_Reduce_scatter_block(sendbuf, recvbuf, recvcount, datatype, op, comm)
    ccall((:PMPI_Reduce_scatter_block, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, recvcount, datatype, op, comm)
end

function PMPI_Ireduce_scatter_block(sendbuf, recvbuf, recvcount, datatype, op, comm, request)
    ccall((:PMPI_Ireduce_scatter_block, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, recvcount, datatype, op, comm, request)
end

function PMPI_Register_datarep(datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)
    ccall((:PMPI_Register_datarep, libmpi), Cint, (Ptr{Cchar}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}), datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)
end

function PMPI_Request_c2f(request)
    ccall((:PMPI_Request_c2f, libmpi), Cint, (MPI_Request,), request)
end

function PMPI_Request_f2c(request)
    ccall((:PMPI_Request_f2c, libmpi), MPI_Request, (Cint,), request)
end

function PMPI_Request_free(request)
    ccall((:PMPI_Request_free, libmpi), Cint, (Ptr{MPI_Request},), request)
end

function PMPI_Request_get_status(request, flag, status)
    ccall((:PMPI_Request_get_status, libmpi), Cint, (MPI_Request, Ptr{Cint}, Ptr{MPI_Status}), request, flag, status)
end

function PMPI_Rget(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    ccall((:PMPI_Rget, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

function PMPI_Rget_accumulate(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    ccall((:PMPI_Rget_accumulate, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

function PMPI_Rput(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_cout, target_datatype, win, request)
    ccall((:PMPI_Rput, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_cout, target_datatype, win, request)
end

function PMPI_Rsend(ibuf, count, datatype, dest, tag, comm)
    ccall((:PMPI_Rsend, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), ibuf, count, datatype, dest, tag, comm)
end

function PMPI_Rsend_init(buf, count, datatype, dest, tag, comm, request)
    ccall((:PMPI_Rsend_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function PMPI_Scan(sendbuf, recvbuf, count, datatype, op, comm)
    ccall((:PMPI_Scan, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

function PMPI_Iscan(sendbuf, recvbuf, count, datatype, op, comm, request)
    ccall((:PMPI_Iscan, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

function PMPI_Scatter(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    ccall((:PMPI_Scatter, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

function PMPI_Iscatter(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    ccall((:PMPI_Iscatter, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

function PMPI_Scatterv(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
    ccall((:PMPI_Scatterv, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

function PMPI_Iscatterv(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    ccall((:PMPI_Iscatterv, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

function PMPI_Send_init(buf, count, datatype, dest, tag, comm, request)
    ccall((:PMPI_Send_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function PMPI_Send(buf, count, datatype, dest, tag, comm)
    ccall((:PMPI_Send, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

function PMPI_Sendrecv(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
    ccall((:PMPI_Sendrecv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
end

function PMPI_Sendrecv_replace(buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
    ccall((:PMPI_Sendrecv_replace, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
end

function PMPI_Ssend_init(buf, count, datatype, dest, tag, comm, request)
    ccall((:PMPI_Ssend_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function PMPI_Ssend(buf, count, datatype, dest, tag, comm)
    ccall((:PMPI_Ssend, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

function PMPI_Start(request)
    ccall((:PMPI_Start, libmpi), Cint, (Ptr{MPI_Request},), request)
end

function PMPI_Startall(count, array_of_requests)
    ccall((:PMPI_Startall, libmpi), Cint, (Cint, Ptr{MPI_Request}), count, array_of_requests)
end

function PMPI_Status_c2f(c_status, f_status)
    ccall((:PMPI_Status_c2f, libmpi), Cint, (Ptr{MPI_Status}, Ptr{Cint}), c_status, f_status)
end

function PMPI_Status_f2c(f_status, c_status)
    ccall((:PMPI_Status_f2c, libmpi), Cint, (Ptr{Cint}, Ptr{MPI_Status}), f_status, c_status)
end

function PMPI_Status_set_cancelled(status, flag)
    ccall((:PMPI_Status_set_cancelled, libmpi), Cint, (Ptr{MPI_Status}, Cint), status, flag)
end

function PMPI_Status_set_elements(status, datatype, count)
    ccall((:PMPI_Status_set_elements, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Cint), status, datatype, count)
end

function PMPI_Status_set_elements_x(status, datatype, count)
    ccall((:PMPI_Status_set_elements_x, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, MPI_Count), status, datatype, count)
end

function PMPI_Testall(count, array_of_requests, flag, array_of_statuses)
    ccall((:PMPI_Testall, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{MPI_Status}), count, array_of_requests, flag, array_of_statuses)
end

function PMPI_Testany(count, array_of_requests, index, flag, status)
    ccall((:PMPI_Testany, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Status}), count, array_of_requests, index, flag, status)
end

function PMPI_Test(request, flag, status)
    ccall((:PMPI_Test, libmpi), Cint, (Ptr{MPI_Request}, Ptr{Cint}, Ptr{MPI_Status}), request, flag, status)
end

function PMPI_Test_cancelled(status, flag)
    ccall((:PMPI_Test_cancelled, libmpi), Cint, (Ptr{MPI_Status}, Ptr{Cint}), status, flag)
end

function PMPI_Testsome(incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
    ccall((:PMPI_Testsome, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Status}), incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
end

function PMPI_Topo_test(comm, status)
    ccall((:PMPI_Topo_test, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, status)
end

function PMPI_Type_c2f(datatype)
    ccall((:PMPI_Type_c2f, libmpi), Cint, (MPI_Datatype,), datatype)
end

function PMPI_Type_commit(type)
    ccall((:PMPI_Type_commit, libmpi), Cint, (Ptr{MPI_Datatype},), type)
end

function PMPI_Type_contiguous(count, oldtype, newtype)
    ccall((:PMPI_Type_contiguous, libmpi), Cint, (Cint, MPI_Datatype, Ptr{MPI_Datatype}), count, oldtype, newtype)
end

function PMPI_Type_create_darray(size, rank, ndims, gsize_array, distrib_array, darg_array, psize_array, order, oldtype, newtype)
    ccall((:PMPI_Type_create_darray, libmpi), Cint, (Cint, Cint, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), size, rank, ndims, gsize_array, distrib_array, darg_array, psize_array, order, oldtype, newtype)
end

function PMPI_Type_create_f90_complex(p, r, newtype)
    ccall((:PMPI_Type_create_f90_complex, libmpi), Cint, (Cint, Cint, Ptr{MPI_Datatype}), p, r, newtype)
end

function PMPI_Type_create_f90_integer(r, newtype)
    ccall((:PMPI_Type_create_f90_integer, libmpi), Cint, (Cint, Ptr{MPI_Datatype}), r, newtype)
end

function PMPI_Type_create_f90_real(p, r, newtype)
    ccall((:PMPI_Type_create_f90_real, libmpi), Cint, (Cint, Cint, Ptr{MPI_Datatype}), p, r, newtype)
end

function PMPI_Type_create_hindexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    ccall((:PMPI_Type_create_hindexed, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

function PMPI_Type_create_hvector(count, blocklength, stride, oldtype, newtype)
    ccall((:PMPI_Type_create_hvector, libmpi), Cint, (Cint, Cint, MPI_Aint, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

function PMPI_Type_create_keyval(type_copy_attr_fn, type_delete_attr_fn, type_keyval, extra_state)
    ccall((:PMPI_Type_create_keyval, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cvoid}), type_copy_attr_fn, type_delete_attr_fn, type_keyval, extra_state)
end

function PMPI_Type_create_hindexed_block(count, blocklength, array_of_displacements, oldtype, newtype)
    ccall((:PMPI_Type_create_hindexed_block, libmpi), Cint, (Cint, Cint, Ptr{MPI_Aint}, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, array_of_displacements, oldtype, newtype)
end

function PMPI_Type_create_indexed_block(count, blocklength, array_of_displacements, oldtype, newtype)
    ccall((:PMPI_Type_create_indexed_block, libmpi), Cint, (Cint, Cint, Ptr{Cint}, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, array_of_displacements, oldtype, newtype)
end

function PMPI_Type_create_struct(count, array_of_block_lengths, array_of_displacements, array_of_types, newtype)
    ccall((:PMPI_Type_create_struct, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}), count, array_of_block_lengths, array_of_displacements, array_of_types, newtype)
end

function PMPI_Type_create_subarray(ndims, size_array, subsize_array, start_array, order, oldtype, newtype)
    ccall((:PMPI_Type_create_subarray, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), ndims, size_array, subsize_array, start_array, order, oldtype, newtype)
end

function PMPI_Type_create_resized(oldtype, lb, extent, newtype)
    ccall((:PMPI_Type_create_resized, libmpi), Cint, (MPI_Datatype, MPI_Aint, MPI_Aint, Ptr{MPI_Datatype}), oldtype, lb, extent, newtype)
end

function PMPI_Type_delete_attr(type, type_keyval)
    ccall((:PMPI_Type_delete_attr, libmpi), Cint, (MPI_Datatype, Cint), type, type_keyval)
end

function PMPI_Type_dup(type, newtype)
    ccall((:PMPI_Type_dup, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Datatype}), type, newtype)
end

function PMPI_Type_free(type)
    ccall((:PMPI_Type_free, libmpi), Cint, (Ptr{MPI_Datatype},), type)
end

function PMPI_Type_free_keyval(type_keyval)
    ccall((:PMPI_Type_free_keyval, libmpi), Cint, (Ptr{Cint},), type_keyval)
end

function PMPI_Type_f2c(datatype)
    ccall((:PMPI_Type_f2c, libmpi), MPI_Datatype, (Cint,), datatype)
end

function PMPI_Type_get_attr(type, type_keyval, attribute_val, flag)
    ccall((:PMPI_Type_get_attr, libmpi), Cint, (MPI_Datatype, Cint, Ptr{Cvoid}, Ptr{Cint}), type, type_keyval, attribute_val, flag)
end

function PMPI_Type_get_contents(mtype, max_integers, max_addresses, max_datatypes, array_of_integers, array_of_addresses, array_of_datatypes)
    ccall((:PMPI_Type_get_contents, libmpi), Cint, (MPI_Datatype, Cint, Cint, Cint, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}), mtype, max_integers, max_addresses, max_datatypes, array_of_integers, array_of_addresses, array_of_datatypes)
end

function PMPI_Type_get_envelope(type, num_integers, num_addresses, num_datatypes, combiner)
    ccall((:PMPI_Type_get_envelope, libmpi), Cint, (MPI_Datatype, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), type, num_integers, num_addresses, num_datatypes, combiner)
end

function PMPI_Type_get_extent(type, lb, extent)
    ccall((:PMPI_Type_get_extent, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Aint}, Ptr{MPI_Aint}), type, lb, extent)
end

function PMPI_Type_get_extent_x(type, lb, extent)
    ccall((:PMPI_Type_get_extent_x, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), type, lb, extent)
end

function PMPI_Type_get_name(type, type_name, resultlen)
    ccall((:PMPI_Type_get_name, libmpi), Cint, (MPI_Datatype, Ptr{Cchar}, Ptr{Cint}), type, type_name, resultlen)
end

function PMPI_Type_get_true_extent(datatype, true_lb, true_extent)
    ccall((:PMPI_Type_get_true_extent, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Aint}, Ptr{MPI_Aint}), datatype, true_lb, true_extent)
end

function PMPI_Type_get_true_extent_x(datatype, true_lb, true_extent)
    ccall((:PMPI_Type_get_true_extent_x, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), datatype, true_lb, true_extent)
end

function PMPI_Type_indexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    ccall((:PMPI_Type_indexed, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

function PMPI_Type_match_size(typeclass, size, type)
    ccall((:PMPI_Type_match_size, libmpi), Cint, (Cint, Cint, Ptr{MPI_Datatype}), typeclass, size, type)
end

function PMPI_Type_set_attr(type, type_keyval, attr_val)
    ccall((:PMPI_Type_set_attr, libmpi), Cint, (MPI_Datatype, Cint, Ptr{Cvoid}), type, type_keyval, attr_val)
end

function PMPI_Type_set_name(type, type_name)
    ccall((:PMPI_Type_set_name, libmpi), Cint, (MPI_Datatype, Ptr{Cchar}), type, type_name)
end

function PMPI_Type_size(type, size)
    ccall((:PMPI_Type_size, libmpi), Cint, (MPI_Datatype, Ptr{Cint}), type, size)
end

function PMPI_Type_size_x(type, size)
    ccall((:PMPI_Type_size_x, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}), type, size)
end

function PMPI_Type_vector(count, blocklength, stride, oldtype, newtype)
    ccall((:PMPI_Type_vector, libmpi), Cint, (Cint, Cint, Cint, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

function PMPI_Unpack(inbuf, insize, position, outbuf, outcount, datatype, comm)
    ccall((:PMPI_Unpack, libmpi), Cint, (Ptr{Cvoid}, Cint, Ptr{Cint}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm), inbuf, insize, position, outbuf, outcount, datatype, comm)
end

function PMPI_Unpublish_name(service_name, info, port_name)
    ccall((:PMPI_Unpublish_name, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Ptr{Cchar}), service_name, info, port_name)
end

function PMPI_Unpack_external(datarep, inbuf, insize, position, outbuf, outcount, datatype)
    ccall((:PMPI_Unpack_external, libmpi), Cint, (Ptr{Cchar}, Ptr{Cvoid}, MPI_Aint, Ptr{MPI_Aint}, Ptr{Cvoid}, Cint, MPI_Datatype), datarep, inbuf, insize, position, outbuf, outcount, datatype)
end

function PMPI_Waitall(count, array_of_requests, array_of_statuses)
    ccall((:PMPI_Waitall, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{MPI_Status}), count, array_of_requests, array_of_statuses)
end

function PMPI_Waitany(count, array_of_requests, index, status)
    ccall((:PMPI_Waitany, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{MPI_Status}), count, array_of_requests, index, status)
end

function PMPI_Wait(request, status)
    ccall((:PMPI_Wait, libmpi), Cint, (Ptr{MPI_Request}, Ptr{MPI_Status}), request, status)
end

function PMPI_Waitsome(incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
    ccall((:PMPI_Waitsome, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Status}), incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
end

function PMPI_Win_allocate(size, disp_unit, info, comm, baseptr, win)
    ccall((:PMPI_Win_allocate, libmpi), Cint, (MPI_Aint, Cint, MPI_Info, MPI_Comm, Ptr{Cvoid}, Ptr{MPI_Win}), size, disp_unit, info, comm, baseptr, win)
end

function PMPI_Win_allocate_shared(size, disp_unit, info, comm, baseptr, win)
    ccall((:PMPI_Win_allocate_shared, libmpi), Cint, (MPI_Aint, Cint, MPI_Info, MPI_Comm, Ptr{Cvoid}, Ptr{MPI_Win}), size, disp_unit, info, comm, baseptr, win)
end

function PMPI_Win_attach(win, base, size)
    ccall((:PMPI_Win_attach, libmpi), Cint, (MPI_Win, Ptr{Cvoid}, MPI_Aint), win, base, size)
end

function PMPI_Win_c2f(win)
    ccall((:PMPI_Win_c2f, libmpi), Cint, (MPI_Win,), win)
end

function PMPI_Win_call_errhandler(win, errorcode)
    ccall((:PMPI_Win_call_errhandler, libmpi), Cint, (MPI_Win, Cint), win, errorcode)
end

function PMPI_Win_complete(win)
    ccall((:PMPI_Win_complete, libmpi), Cint, (MPI_Win,), win)
end

function PMPI_Win_create(base, size, disp_unit, info, comm, win)
    ccall((:PMPI_Win_create, libmpi), Cint, (Ptr{Cvoid}, MPI_Aint, Cint, MPI_Info, MPI_Comm, Ptr{MPI_Win}), base, size, disp_unit, info, comm, win)
end

function PMPI_Win_create_dynamic(info, comm, win)
    ccall((:PMPI_Win_create_dynamic, libmpi), Cint, (MPI_Info, MPI_Comm, Ptr{MPI_Win}), info, comm, win)
end

function PMPI_Win_create_errhandler(_function, errhandler)
    ccall((:PMPI_Win_create_errhandler, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Errhandler}), _function, errhandler)
end

function PMPI_Win_create_keyval(win_copy_attr_fn, win_delete_attr_fn, win_keyval, extra_state)
    ccall((:PMPI_Win_create_keyval, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cvoid}), win_copy_attr_fn, win_delete_attr_fn, win_keyval, extra_state)
end

function PMPI_Win_delete_attr(win, win_keyval)
    ccall((:PMPI_Win_delete_attr, libmpi), Cint, (MPI_Win, Cint), win, win_keyval)
end

function PMPI_Win_detach(win, base)
    ccall((:PMPI_Win_detach, libmpi), Cint, (MPI_Win, Ptr{Cvoid}), win, base)
end

function PMPI_Win_f2c(win)
    ccall((:PMPI_Win_f2c, libmpi), MPI_Win, (Cint,), win)
end

function PMPI_Win_fence(assert, win)
    ccall((:PMPI_Win_fence, libmpi), Cint, (Cint, MPI_Win), assert, win)
end

function PMPI_Win_flush(rank, win)
    ccall((:PMPI_Win_flush, libmpi), Cint, (Cint, MPI_Win), rank, win)
end

function PMPI_Win_flush_all(win)
    ccall((:PMPI_Win_flush_all, libmpi), Cint, (MPI_Win,), win)
end

function PMPI_Win_flush_local(rank, win)
    ccall((:PMPI_Win_flush_local, libmpi), Cint, (Cint, MPI_Win), rank, win)
end

function PMPI_Win_flush_local_all(win)
    ccall((:PMPI_Win_flush_local_all, libmpi), Cint, (MPI_Win,), win)
end

function PMPI_Win_free(win)
    ccall((:PMPI_Win_free, libmpi), Cint, (Ptr{MPI_Win},), win)
end

function PMPI_Win_free_keyval(win_keyval)
    ccall((:PMPI_Win_free_keyval, libmpi), Cint, (Ptr{Cint},), win_keyval)
end

function PMPI_Win_get_attr(win, win_keyval, attribute_val, flag)
    ccall((:PMPI_Win_get_attr, libmpi), Cint, (MPI_Win, Cint, Ptr{Cvoid}, Ptr{Cint}), win, win_keyval, attribute_val, flag)
end

function PMPI_Win_get_errhandler(win, errhandler)
    ccall((:PMPI_Win_get_errhandler, libmpi), Cint, (MPI_Win, Ptr{MPI_Errhandler}), win, errhandler)
end

function PMPI_Win_get_group(win, group)
    ccall((:PMPI_Win_get_group, libmpi), Cint, (MPI_Win, Ptr{MPI_Group}), win, group)
end

function PMPI_Win_get_info(win, info_used)
    ccall((:PMPI_Win_get_info, libmpi), Cint, (MPI_Win, Ptr{MPI_Info}), win, info_used)
end

function PMPI_Win_get_name(win, win_name, resultlen)
    ccall((:PMPI_Win_get_name, libmpi), Cint, (MPI_Win, Ptr{Cchar}, Ptr{Cint}), win, win_name, resultlen)
end

function PMPI_Win_lock(lock_type, rank, assert, win)
    ccall((:PMPI_Win_lock, libmpi), Cint, (Cint, Cint, Cint, MPI_Win), lock_type, rank, assert, win)
end

function PMPI_Win_lock_all(assert, win)
    ccall((:PMPI_Win_lock_all, libmpi), Cint, (Cint, MPI_Win), assert, win)
end

function PMPI_Win_post(group, assert, win)
    ccall((:PMPI_Win_post, libmpi), Cint, (MPI_Group, Cint, MPI_Win), group, assert, win)
end

function PMPI_Win_set_attr(win, win_keyval, attribute_val)
    ccall((:PMPI_Win_set_attr, libmpi), Cint, (MPI_Win, Cint, Ptr{Cvoid}), win, win_keyval, attribute_val)
end

function PMPI_Win_set_errhandler(win, errhandler)
    ccall((:PMPI_Win_set_errhandler, libmpi), Cint, (MPI_Win, MPI_Errhandler), win, errhandler)
end

function PMPI_Win_set_info(win, info)
    ccall((:PMPI_Win_set_info, libmpi), Cint, (MPI_Win, MPI_Info), win, info)
end

function PMPI_Win_set_name(win, win_name)
    ccall((:PMPI_Win_set_name, libmpi), Cint, (MPI_Win, Ptr{Cchar}), win, win_name)
end

function PMPI_Win_shared_query(win, rank, size, disp_unit, baseptr)
    ccall((:PMPI_Win_shared_query, libmpi), Cint, (MPI_Win, Cint, Ptr{MPI_Aint}, Ptr{Cint}, Ptr{Cvoid}), win, rank, size, disp_unit, baseptr)
end

function PMPI_Win_start(group, assert, win)
    ccall((:PMPI_Win_start, libmpi), Cint, (MPI_Group, Cint, MPI_Win), group, assert, win)
end

function PMPI_Win_sync(win)
    ccall((:PMPI_Win_sync, libmpi), Cint, (MPI_Win,), win)
end

function PMPI_Win_test(win, flag)
    ccall((:PMPI_Win_test, libmpi), Cint, (MPI_Win, Ptr{Cint}), win, flag)
end

function PMPI_Win_unlock(rank, win)
    ccall((:PMPI_Win_unlock, libmpi), Cint, (Cint, MPI_Win), rank, win)
end

function PMPI_Win_unlock_all(win)
    ccall((:PMPI_Win_unlock_all, libmpi), Cint, (MPI_Win,), win)
end

function PMPI_Win_wait(win)
    ccall((:PMPI_Win_wait, libmpi), Cint, (MPI_Win,), win)
end

function PMPI_Wtick()
    ccall((:PMPI_Wtick, libmpi), Cdouble, ())
end

function PMPI_Wtime()
    ccall((:PMPI_Wtime, libmpi), Cdouble, ())
end

function PMPI_T_init_thread(required, provided)
    ccall((:PMPI_T_init_thread, libmpi), Cint, (Cint, Ptr{Cint}), required, provided)
end

function PMPI_T_finalize()
    ccall((:PMPI_T_finalize, libmpi), Cint, ())
end

function PMPI_T_cvar_get_num(num_cvar)
    ccall((:PMPI_T_cvar_get_num, libmpi), Cint, (Ptr{Cint},), num_cvar)
end

function PMPI_T_cvar_get_info(cvar_index, name, name_len, verbosity, datatype, enumtype, desc, desc_len, bind, scope)
    ccall((:PMPI_T_cvar_get_info, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{MPI_T_enum}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), cvar_index, name, name_len, verbosity, datatype, enumtype, desc, desc_len, bind, scope)
end

function PMPI_T_cvar_get_index(name, cvar_index)
    ccall((:PMPI_T_cvar_get_index, libmpi), Cint, (Ptr{Cchar}, Ptr{Cint}), name, cvar_index)
end

function PMPI_T_cvar_handle_alloc(cvar_index, obj_handle, handle, count)
    ccall((:PMPI_T_cvar_handle_alloc, libmpi), Cint, (Cint, Ptr{Cvoid}, Ptr{MPI_T_cvar_handle}, Ptr{Cint}), cvar_index, obj_handle, handle, count)
end

function PMPI_T_cvar_handle_free(handle)
    ccall((:PMPI_T_cvar_handle_free, libmpi), Cint, (Ptr{MPI_T_cvar_handle},), handle)
end

function PMPI_T_cvar_read(handle, buf)
    ccall((:PMPI_T_cvar_read, libmpi), Cint, (MPI_T_cvar_handle, Ptr{Cvoid}), handle, buf)
end

function PMPI_T_cvar_write(handle, buf)
    ccall((:PMPI_T_cvar_write, libmpi), Cint, (MPI_T_cvar_handle, Ptr{Cvoid}), handle, buf)
end

function PMPI_T_category_get_num(num_cat)
    ccall((:PMPI_T_category_get_num, libmpi), Cint, (Ptr{Cint},), num_cat)
end

function PMPI_T_category_get_info(cat_index, name, name_len, desc, desc_len, num_cvars, num_pvars, num_categories)
    ccall((:PMPI_T_category_get_info, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), cat_index, name, name_len, desc, desc_len, num_cvars, num_pvars, num_categories)
end

function PMPI_T_category_get_index(name, category_index)
    ccall((:PMPI_T_category_get_index, libmpi), Cint, (Ptr{Cchar}, Ptr{Cint}), name, category_index)
end

function PMPI_T_category_get_cvars(cat_index, len, indices)
    ccall((:PMPI_T_category_get_cvars, libmpi), Cint, (Cint, Cint, Ptr{Cint}), cat_index, len, indices)
end

function PMPI_T_category_get_pvars(cat_index, len, indices)
    ccall((:PMPI_T_category_get_pvars, libmpi), Cint, (Cint, Cint, Ptr{Cint}), cat_index, len, indices)
end

function PMPI_T_category_get_categories(cat_index, len, indices)
    ccall((:PMPI_T_category_get_categories, libmpi), Cint, (Cint, Cint, Ptr{Cint}), cat_index, len, indices)
end

function PMPI_T_category_changed(stamp)
    ccall((:PMPI_T_category_changed, libmpi), Cint, (Ptr{Cint},), stamp)
end

function PMPI_T_pvar_get_num(num_pvar)
    ccall((:PMPI_T_pvar_get_num, libmpi), Cint, (Ptr{Cint},), num_pvar)
end

function PMPI_T_pvar_get_info(pvar_index, name, name_len, verbosity, var_class, datatype, enumtype, desc, desc_len, bind, readonly, continuous, atomic)
    ccall((:PMPI_T_pvar_get_info, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{MPI_T_enum}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), pvar_index, name, name_len, verbosity, var_class, datatype, enumtype, desc, desc_len, bind, readonly, continuous, atomic)
end

function PMPI_T_pvar_get_index(name, var_class, pvar_index)
    ccall((:PMPI_T_pvar_get_index, libmpi), Cint, (Ptr{Cchar}, Cint, Ptr{Cint}), name, var_class, pvar_index)
end

function PMPI_T_pvar_session_create(session)
    ccall((:PMPI_T_pvar_session_create, libmpi), Cint, (Ptr{MPI_T_pvar_session},), session)
end

function PMPI_T_pvar_session_free(session)
    ccall((:PMPI_T_pvar_session_free, libmpi), Cint, (Ptr{MPI_T_pvar_session},), session)
end

function PMPI_T_pvar_handle_alloc(session, pvar_index, obj_handle, handle, count)
    ccall((:PMPI_T_pvar_handle_alloc, libmpi), Cint, (MPI_T_pvar_session, Cint, Ptr{Cvoid}, Ptr{MPI_T_pvar_handle}, Ptr{Cint}), session, pvar_index, obj_handle, handle, count)
end

function PMPI_T_pvar_handle_free(session, handle)
    ccall((:PMPI_T_pvar_handle_free, libmpi), Cint, (MPI_T_pvar_session, Ptr{MPI_T_pvar_handle}), session, handle)
end

function PMPI_T_pvar_start(session, handle)
    ccall((:PMPI_T_pvar_start, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle), session, handle)
end

function PMPI_T_pvar_stop(session, handle)
    ccall((:PMPI_T_pvar_stop, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle), session, handle)
end

function PMPI_T_pvar_read(session, handle, buf)
    ccall((:PMPI_T_pvar_read, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle, Ptr{Cvoid}), session, handle, buf)
end

function PMPI_T_pvar_write(session, handle, buf)
    ccall((:PMPI_T_pvar_write, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle, Ptr{Cvoid}), session, handle, buf)
end

function PMPI_T_pvar_reset(session, handle)
    ccall((:PMPI_T_pvar_reset, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle), session, handle)
end

function PMPI_T_pvar_readreset(session, handle, buf)
    ccall((:PMPI_T_pvar_readreset, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle, Ptr{Cvoid}), session, handle, buf)
end

function PMPI_T_enum_get_info(enumtype, num, name, name_len)
    ccall((:PMPI_T_enum_get_info, libmpi), Cint, (MPI_T_enum, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}), enumtype, num, name, name_len)
end

function PMPI_T_enum_get_item(enumtype, index, value, name, name_len)
    ccall((:PMPI_T_enum_get_item, libmpi), Cint, (MPI_T_enum, Cint, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}), enumtype, index, value, name, name_len)
end

function MPI_T_init_thread(required, provided)
    ccall((:MPI_T_init_thread, libmpi), Cint, (Cint, Ptr{Cint}), required, provided)
end

function MPI_T_finalize()
    ccall((:MPI_T_finalize, libmpi), Cint, ())
end

function MPI_T_cvar_get_num(num_cvar)
    ccall((:MPI_T_cvar_get_num, libmpi), Cint, (Ptr{Cint},), num_cvar)
end

function MPI_T_cvar_get_info(cvar_index, name, name_len, verbosity, datatype, enumtype, desc, desc_len, bind, scope)
    ccall((:MPI_T_cvar_get_info, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{MPI_T_enum}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), cvar_index, name, name_len, verbosity, datatype, enumtype, desc, desc_len, bind, scope)
end

function MPI_T_cvar_get_index(name, cvar_index)
    ccall((:MPI_T_cvar_get_index, libmpi), Cint, (Ptr{Cchar}, Ptr{Cint}), name, cvar_index)
end

function MPI_T_cvar_handle_alloc(cvar_index, obj_handle, handle, count)
    ccall((:MPI_T_cvar_handle_alloc, libmpi), Cint, (Cint, Ptr{Cvoid}, Ptr{MPI_T_cvar_handle}, Ptr{Cint}), cvar_index, obj_handle, handle, count)
end

function MPI_T_cvar_handle_free(handle)
    ccall((:MPI_T_cvar_handle_free, libmpi), Cint, (Ptr{MPI_T_cvar_handle},), handle)
end

function MPI_T_cvar_read(handle, buf)
    ccall((:MPI_T_cvar_read, libmpi), Cint, (MPI_T_cvar_handle, Ptr{Cvoid}), handle, buf)
end

function MPI_T_cvar_write(handle, buf)
    ccall((:MPI_T_cvar_write, libmpi), Cint, (MPI_T_cvar_handle, Ptr{Cvoid}), handle, buf)
end

function MPI_T_category_get_num(num_cat)
    ccall((:MPI_T_category_get_num, libmpi), Cint, (Ptr{Cint},), num_cat)
end

function MPI_T_category_get_info(cat_index, name, name_len, desc, desc_len, num_cvars, num_pvars, num_categories)
    ccall((:MPI_T_category_get_info, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), cat_index, name, name_len, desc, desc_len, num_cvars, num_pvars, num_categories)
end

function MPI_T_category_get_index(name, category_index)
    ccall((:MPI_T_category_get_index, libmpi), Cint, (Ptr{Cchar}, Ptr{Cint}), name, category_index)
end

function MPI_T_category_get_cvars(cat_index, len, indices)
    ccall((:MPI_T_category_get_cvars, libmpi), Cint, (Cint, Cint, Ptr{Cint}), cat_index, len, indices)
end

function MPI_T_category_get_pvars(cat_index, len, indices)
    ccall((:MPI_T_category_get_pvars, libmpi), Cint, (Cint, Cint, Ptr{Cint}), cat_index, len, indices)
end

function MPI_T_category_get_categories(cat_index, len, indices)
    ccall((:MPI_T_category_get_categories, libmpi), Cint, (Cint, Cint, Ptr{Cint}), cat_index, len, indices)
end

function MPI_T_category_changed(stamp)
    ccall((:MPI_T_category_changed, libmpi), Cint, (Ptr{Cint},), stamp)
end

function MPI_T_pvar_get_num(num_pvar)
    ccall((:MPI_T_pvar_get_num, libmpi), Cint, (Ptr{Cint},), num_pvar)
end

function MPI_T_pvar_get_info(pvar_index, name, name_len, verbosity, var_class, datatype, enumtype, desc, desc_len, bind, readonly, continuous, atomic)
    ccall((:MPI_T_pvar_get_info, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{MPI_T_enum}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), pvar_index, name, name_len, verbosity, var_class, datatype, enumtype, desc, desc_len, bind, readonly, continuous, atomic)
end

function MPI_T_pvar_get_index(name, var_class, pvar_index)
    ccall((:MPI_T_pvar_get_index, libmpi), Cint, (Ptr{Cchar}, Cint, Ptr{Cint}), name, var_class, pvar_index)
end

function MPI_T_pvar_session_create(session)
    ccall((:MPI_T_pvar_session_create, libmpi), Cint, (Ptr{MPI_T_pvar_session},), session)
end

function MPI_T_pvar_session_free(session)
    ccall((:MPI_T_pvar_session_free, libmpi), Cint, (Ptr{MPI_T_pvar_session},), session)
end

function MPI_T_pvar_handle_alloc(session, pvar_index, obj_handle, handle, count)
    ccall((:MPI_T_pvar_handle_alloc, libmpi), Cint, (MPI_T_pvar_session, Cint, Ptr{Cvoid}, Ptr{MPI_T_pvar_handle}, Ptr{Cint}), session, pvar_index, obj_handle, handle, count)
end

function MPI_T_pvar_handle_free(session, handle)
    ccall((:MPI_T_pvar_handle_free, libmpi), Cint, (MPI_T_pvar_session, Ptr{MPI_T_pvar_handle}), session, handle)
end

function MPI_T_pvar_start(session, handle)
    ccall((:MPI_T_pvar_start, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle), session, handle)
end

function MPI_T_pvar_stop(session, handle)
    ccall((:MPI_T_pvar_stop, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle), session, handle)
end

function MPI_T_pvar_read(session, handle, buf)
    ccall((:MPI_T_pvar_read, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle, Ptr{Cvoid}), session, handle, buf)
end

function MPI_T_pvar_write(session, handle, buf)
    ccall((:MPI_T_pvar_write, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle, Ptr{Cvoid}), session, handle, buf)
end

function MPI_T_pvar_reset(session, handle)
    ccall((:MPI_T_pvar_reset, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle), session, handle)
end

function MPI_T_pvar_readreset(session, handle, buf)
    ccall((:MPI_T_pvar_readreset, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle, Ptr{Cvoid}), session, handle, buf)
end

function MPI_T_enum_get_info(enumtype, num, name, name_len)
    ccall((:MPI_T_enum_get_info, libmpi), Cint, (MPI_T_enum, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}), enumtype, num, name, name_len)
end

function MPI_T_enum_get_item(enumtype, index, value, name, name_len)
    ccall((:MPI_T_enum_get_item, libmpi), Cint, (MPI_T_enum, Cint, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}), enumtype, index, value, name, name_len)
end

function MPI_Attr_delete(comm, keyval)
    ccall((:MPI_Attr_delete, libmpi), Cint, (MPI_Comm, Cint), comm, keyval)
end

function PMPI_Attr_delete(comm, keyval)
    ccall((:PMPI_Attr_delete, libmpi), Cint, (MPI_Comm, Cint), comm, keyval)
end

function MPI_Attr_get(comm, keyval, attribute_val, flag)
    ccall((:MPI_Attr_get, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cvoid}, Ptr{Cint}), comm, keyval, attribute_val, flag)
end

function PMPI_Attr_get(comm, keyval, attribute_val, flag)
    ccall((:PMPI_Attr_get, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cvoid}, Ptr{Cint}), comm, keyval, attribute_val, flag)
end

function MPI_Attr_put(comm, keyval, attribute_val)
    ccall((:MPI_Attr_put, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cvoid}), comm, keyval, attribute_val)
end

function PMPI_Attr_put(comm, keyval, attribute_val)
    ccall((:PMPI_Attr_put, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cvoid}), comm, keyval, attribute_val)
end

# typedef int ( MPI_Copy_function ) ( MPI_Comm , int , void * , void * , void * , int * )
const MPI_Copy_function = Cvoid

# typedef int ( MPI_Delete_function ) ( MPI_Comm , int , void * , void * )
const MPI_Delete_function = Cvoid

function MPI_Keyval_create(copy_fn, delete_fn, keyval, extra_state)
    ccall((:MPI_Keyval_create, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cvoid}), copy_fn, delete_fn, keyval, extra_state)
end

function PMPI_Keyval_create(copy_fn, delete_fn, keyval, extra_state)
    ccall((:PMPI_Keyval_create, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cvoid}), copy_fn, delete_fn, keyval, extra_state)
end

function MPI_Keyval_free(keyval)
    ccall((:MPI_Keyval_free, libmpi), Cint, (Ptr{Cint},), keyval)
end

function PMPI_Keyval_free(keyval)
    ccall((:PMPI_Keyval_free, libmpi), Cint, (Ptr{Cint},), keyval)
end

const OPAL_BUILD_PLATFORM_COMPILER_FAMILYID = 0

const OPAL_BUILD_PLATFORM_COMPILER_VERSION = 0

const OPAL_STDC_HEADERS = 1

const OPAL_HAVE_ATTRIBUTE_DEPRECATED = 1

const OPAL_HAVE_ATTRIBUTE_DEPRECATED_ARGUMENT = 1

const OPAL_HAVE_ATTRIBUTE_ERROR = 1

const OPAL_HAVE_LONG_LONG = 1

const OPAL_MAX_DATAREP_STRING = 128

const OPAL_MAX_ERROR_STRING = 256

const OPAL_MAX_INFO_KEY = 36

const OPAL_MAX_INFO_VAL = 256

const OPAL_MAX_OBJECT_NAME = 64

const OPAL_MAX_PORT_NAME = 1024

const OPAL_MAX_PROCESSOR_NAME = 256

const OMPI_HAVE_FORTRAN_LOGICAL1 = 1

const OMPI_HAVE_FORTRAN_LOGICAL2 = 1

const OMPI_HAVE_FORTRAN_LOGICAL4 = 1

const OMPI_HAVE_FORTRAN_LOGICAL8 = 1

const OMPI_HAVE_FORTRAN_INTEGER1 = 1

const OMPI_HAVE_FORTRAN_INTEGER16 = 0

const OMPI_HAVE_FORTRAN_INTEGER2 = 1

const OMPI_HAVE_FORTRAN_INTEGER4 = 1

const OMPI_HAVE_FORTRAN_INTEGER8 = 1

const OMPI_HAVE_FORTRAN_REAL16 = 1

const OMPI_HAVE_FORTRAN_REAL2 = 0

const OMPI_HAVE_FORTRAN_REAL4 = 1

const OMPI_HAVE_FORTRAN_REAL8 = 1

const OMPI_ENABLE_MPI1_COMPAT = 0

const HAVE_FLOAT__COMPLEX = 1

const HAVE_DOUBLE__COMPLEX = 1

const HAVE_LONG_DOUBLE__COMPLEX = 1

const OMPI_MPI_AINT_TYPE = ptrdiff_t

const OMPI_MPI_OFFSET_TYPE = Clonglong

const MPI_LONG_LONG = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_long_long_int)

const OMPI_OFFSET_DATATYPE = MPI_LONG_LONG

const OMPI_MPI_OFFSET_SIZE = 8

const OMPI_MPI_COUNT_TYPE = Clonglong

const OMPI_BUILD_CXX_BINDINGS = 0

const OMPI_WANT_MPI_CXX_SEEK = 1

const OMPI_CXX_SUPPORTS_2D_CONST_CAST = 0

const OMPI_PARAM_CHECK = 1

const OMPI_WANT_MPI_INTERFACE_WARNING = 1

const OMPI_HAVE_CXX_EXCEPTION_SUPPORT = 0

const OMPI_MAJOR_VERSION = 4

const OMPI_MINOR_VERSION = 1

const OMPI_RELEASE_VERSION = 3

const ompi_fortran_bogus_type_t = Cint

const ompi_fortran_integer_t = Cint

const OPAL_C_HAVE_VISIBILITY = 1

# Skipping MacroDefinition: OMPI_DECLSPEC __attribute__ ( ( visibility ( "default" ) ) )

const MPI_Fint = ompi_fortran_integer_t

const OMPI_BUILDING = 0

const OPEN_MPI = 1

const MPI_VERSION = 3

const MPI_SUBVERSION = 1

const PLATFORM_COMPILER_UNKNOWN = 1

const PLATFORM_COMPILER_GNU = 1

const PLATFORM_COMPILER_FAMILYNAME = GNU

const PLATFORM_COMPILER_FAMILYID = 1

const PLATFORM_COMPILER_GNU_C = 1

const PLATFORM_COMPILER_VERSION = PLATFORM_COMPILER_VERSION_INT(__GNUC__, __GNUC_MINOR__, __GNUC_PATCHLEVEL__)

const __PLATFORM_COMPILER_GNU_VERSION_STR = ((((((_STRINGIFY(__GNUC__))("."))(_STRINGIFY))(__GNUC_MINOR__))("."))(_STRINGIFY))(__GNUC_PATCHLEVEL__)

const PLATFORM_COMPILER_VERSION_STR = __PLATFORM_COMPILER_GNU_VERSION_STR

const OMPI_REMOVED_USE_STATIC_ASSERT = 0

const OMPI_OMIT_MPI1_COMPAT_DECLS = !OMPI_ENABLE_MPI1_COMPAT

const MPIO_Request = MPI_Request

const MPIO_Test = MPI_Test

const MPIO_Wait = MPI_Wait

const MPI_ANY_SOURCE = -1

const MPI_PROC_NULL = -2

const MPI_ROOT = -4

const MPI_ANY_TAG = -1

const MPI_MAX_PROCESSOR_NAME = OPAL_MAX_PROCESSOR_NAME

const MPI_MAX_ERROR_STRING = OPAL_MAX_ERROR_STRING

const MPI_MAX_OBJECT_NAME = OPAL_MAX_OBJECT_NAME

const MPI_MAX_LIBRARY_VERSION_STRING = 256

const MPI_UNDEFINED = -32766

const MPI_DIST_GRAPH = 3

const MPI_CART = 1

const MPI_GRAPH = 2

const MPI_KEYVAL_INVALID = -1

# Skipping MacroDefinition: MPI_UNWEIGHTED ( ( int * ) 2 )

# Skipping MacroDefinition: MPI_WEIGHTS_EMPTY ( ( int * ) 3 )

# Skipping MacroDefinition: MPI_BOTTOM ( ( void * ) 0 )

# Skipping MacroDefinition: MPI_IN_PLACE ( ( void * ) 1 )

const MPI_BSEND_OVERHEAD = 128

const MPI_MAX_INFO_KEY = OPAL_MAX_INFO_KEY

const MPI_MAX_INFO_VAL = OPAL_MAX_INFO_VAL

const MPI_ARGV_NULL = (Cchar * (*))(0)

# Skipping MacroDefinition: MPI_ARGVS_NULL ( ( char * * * ) 0 )

# Skipping MacroDefinition: MPI_ERRCODES_IGNORE ( ( int * ) 0 )

const MPI_MAX_PORT_NAME = OPAL_MAX_PORT_NAME

const MPI_ORDER_C = 0

const MPI_ORDER_FORTRAN = 1

const MPI_DISTRIBUTE_BLOCK = 0

const MPI_DISTRIBUTE_CYCLIC = 1

const MPI_DISTRIBUTE_NONE = 2

const MPI_DISTRIBUTE_DFLT_DARG = -1

const MPI_MODE_CREATE = 1

const MPI_MODE_RDONLY = 2

const MPI_MODE_WRONLY = 4

const MPI_MODE_RDWR = 8

const MPI_MODE_DELETE_ON_CLOSE = 16

const MPI_MODE_UNIQUE_OPEN = 32

const MPI_MODE_EXCL = 64

const MPI_MODE_APPEND = 128

const MPI_MODE_SEQUENTIAL = 256

const MPI_DISPLACEMENT_CURRENT = -54278278

const MPI_SEEK_SET = 600

const MPI_SEEK_CUR = 602

const MPI_SEEK_END = 604

const MPI_MAX_DATAREP_STRING = OPAL_MAX_DATAREP_STRING

const MPI_MODE_NOCHECK = 1

const MPI_MODE_NOPRECEDE = 2

const MPI_MODE_NOPUT = 4

const MPI_MODE_NOSTORE = 8

const MPI_MODE_NOSUCCEED = 16

const MPI_LOCK_EXCLUSIVE = 1

const MPI_LOCK_SHARED = 2

const MPI_WIN_FLAVOR_CREATE = 1

const MPI_WIN_FLAVOR_ALLOCATE = 2

const MPI_WIN_FLAVOR_DYNAMIC = 3

const MPI_WIN_FLAVOR_SHARED = 4

const MPI_WIN_UNIFIED = 0

const MPI_WIN_SEPARATE = 1

const MPI_SUCCESS = 0

const MPI_ERR_BUFFER = 1

const MPI_ERR_COUNT = 2

const MPI_ERR_TYPE = 3

const MPI_ERR_TAG = 4

const MPI_ERR_COMM = 5

const MPI_ERR_RANK = 6

const MPI_ERR_REQUEST = 7

const MPI_ERR_ROOT = 8

const MPI_ERR_GROUP = 9

const MPI_ERR_OP = 10

const MPI_ERR_TOPOLOGY = 11

const MPI_ERR_DIMS = 12

const MPI_ERR_ARG = 13

const MPI_ERR_UNKNOWN = 14

const MPI_ERR_TRUNCATE = 15

const MPI_ERR_OTHER = 16

const MPI_ERR_INTERN = 17

const MPI_ERR_IN_STATUS = 18

const MPI_ERR_PENDING = 19

const MPI_ERR_ACCESS = 20

const MPI_ERR_AMODE = 21

const MPI_ERR_ASSERT = 22

const MPI_ERR_BAD_FILE = 23

const MPI_ERR_BASE = 24

const MPI_ERR_CONVERSION = 25

const MPI_ERR_DISP = 26

const MPI_ERR_DUP_DATAREP = 27

const MPI_ERR_FILE_EXISTS = 28

const MPI_ERR_FILE_IN_USE = 29

const MPI_ERR_FILE = 30

const MPI_ERR_INFO_KEY = 31

const MPI_ERR_INFO_NOKEY = 32

const MPI_ERR_INFO_VALUE = 33

const MPI_ERR_INFO = 34

const MPI_ERR_IO = 35

const MPI_ERR_KEYVAL = 36

const MPI_ERR_LOCKTYPE = 37

const MPI_ERR_NAME = 38

const MPI_ERR_NO_MEM = 39

const MPI_ERR_NOT_SAME = 40

const MPI_ERR_NO_SPACE = 41

const MPI_ERR_NO_SUCH_FILE = 42

const MPI_ERR_PORT = 43

const MPI_ERR_QUOTA = 44

const MPI_ERR_READ_ONLY = 45

const MPI_ERR_RMA_CONFLICT = 46

const MPI_ERR_RMA_SYNC = 47

const MPI_ERR_SERVICE = 48

const MPI_ERR_SIZE = 49

const MPI_ERR_SPAWN = 50

const MPI_ERR_UNSUPPORTED_DATAREP = 51

const MPI_ERR_UNSUPPORTED_OPERATION = 52

const MPI_ERR_WIN = 53

const MPI_T_ERR_MEMORY = 54

const MPI_T_ERR_NOT_INITIALIZED = 55

const MPI_T_ERR_CANNOT_INIT = 56

const MPI_T_ERR_INVALID_INDEX = 57

const MPI_T_ERR_INVALID_ITEM = 58

const MPI_T_ERR_INVALID_HANDLE = 59

const MPI_T_ERR_OUT_OF_HANDLES = 60

const MPI_T_ERR_OUT_OF_SESSIONS = 61

const MPI_T_ERR_INVALID_SESSION = 62

const MPI_T_ERR_CVAR_SET_NOT_NOW = 63

const MPI_T_ERR_CVAR_SET_NEVER = 64

const MPI_T_ERR_PVAR_NO_STARTSTOP = 65

const MPI_T_ERR_PVAR_NO_WRITE = 66

const MPI_T_ERR_PVAR_NO_ATOMIC = 67

const MPI_ERR_RMA_RANGE = 68

const MPI_ERR_RMA_ATTACH = 69

const MPI_ERR_RMA_FLAVOR = 70

const MPI_ERR_RMA_SHARED = 71

const MPI_T_ERR_INVALID = 72

const MPI_T_ERR_INVALID_NAME = 73

const MPI_ERR_LASTCODE = 92

const OMPI_COMM_TYPE_NODE = MPI_COMM_TYPE_SHARED

const MPI_GROUP_NULL = OMPI_PREDEFINED_GLOBAL(MPI_Group, ompi_mpi_group_null)

const MPI_COMM_NULL = OMPI_PREDEFINED_GLOBAL(MPI_Comm, ompi_mpi_comm_null)

const MPI_REQUEST_NULL = OMPI_PREDEFINED_GLOBAL(MPI_Request, ompi_request_null)

const MPI_MESSAGE_NULL = OMPI_PREDEFINED_GLOBAL(MPI_Message, ompi_message_null)

const MPI_OP_NULL = OMPI_PREDEFINED_GLOBAL(MPI_Op, ompi_mpi_op_null)

const MPI_ERRHANDLER_NULL = OMPI_PREDEFINED_GLOBAL(MPI_Errhandler, ompi_mpi_errhandler_null)

const MPI_INFO_NULL = OMPI_PREDEFINED_GLOBAL(MPI_Info, ompi_mpi_info_null)

const MPI_WIN_NULL = OMPI_PREDEFINED_GLOBAL(MPI_Win, ompi_mpi_win_null)

const MPI_FILE_NULL = OMPI_PREDEFINED_GLOBAL(MPI_File, ompi_mpi_file_null)

const MPI_T_ENUM_NULL = MPI_T_enum(NULL)

const MPI_INFO_ENV = OMPI_PREDEFINED_GLOBAL(MPI_Info, ompi_mpi_info_env)

# Skipping MacroDefinition: MPI_STATUS_IGNORE ( ( MPI_Status * ) 0 )

# Skipping MacroDefinition: MPI_STATUSES_IGNORE ( ( MPI_Status * ) 0 )

const MPI_T_PVAR_ALL_HANDLES = MPI_T_pvar_handle(-1)

const MPI_T_PVAR_HANDLE_NULL = MPI_T_pvar_handle(0)

const MPI_T_PVAR_SESSION_NULL = MPI_T_pvar_session(0)

const MPI_T_CVAR_HANDLE_NULL = MPI_T_cvar_handle(0)

const MPI_TYPE_NULL_DELETE_FN = OMPI_C_MPI_TYPE_NULL_DELETE_FN

const MPI_TYPE_NULL_COPY_FN = OMPI_C_MPI_TYPE_NULL_COPY_FN

const MPI_TYPE_DUP_FN = OMPI_C_MPI_TYPE_DUP_FN

const MPI_COMM_NULL_DELETE_FN = OMPI_C_MPI_COMM_NULL_DELETE_FN

const MPI_COMM_NULL_COPY_FN = OMPI_C_MPI_COMM_NULL_COPY_FN

const MPI_COMM_DUP_FN = OMPI_C_MPI_COMM_DUP_FN

const MPI_WIN_NULL_DELETE_FN = OMPI_C_MPI_WIN_NULL_DELETE_FN

const MPI_WIN_NULL_COPY_FN = OMPI_C_MPI_WIN_NULL_COPY_FN

const MPI_WIN_DUP_FN = OMPI_C_MPI_WIN_DUP_FN

# Skipping MacroDefinition: MPI_CONVERSION_FN_NULL ( ( MPI_Datarep_conversion_function * ) 0 )

const MPI_COMM_WORLD = OMPI_PREDEFINED_GLOBAL(MPI_Comm, ompi_mpi_comm_world)

const MPI_COMM_SELF = OMPI_PREDEFINED_GLOBAL(MPI_Comm, ompi_mpi_comm_self)

const MPI_GROUP_EMPTY = OMPI_PREDEFINED_GLOBAL(MPI_Group, ompi_mpi_group_empty)

const MPI_MESSAGE_NO_PROC = OMPI_PREDEFINED_GLOBAL(MPI_Message, ompi_message_no_proc)

const MPI_MAX = OMPI_PREDEFINED_GLOBAL(MPI_Op, ompi_mpi_op_max)

const MPI_MIN = OMPI_PREDEFINED_GLOBAL(MPI_Op, ompi_mpi_op_min)

const MPI_SUM = OMPI_PREDEFINED_GLOBAL(MPI_Op, ompi_mpi_op_sum)

const MPI_PROD = OMPI_PREDEFINED_GLOBAL(MPI_Op, ompi_mpi_op_prod)

const MPI_LAND = OMPI_PREDEFINED_GLOBAL(MPI_Op, ompi_mpi_op_land)

const MPI_BAND = OMPI_PREDEFINED_GLOBAL(MPI_Op, ompi_mpi_op_band)

const MPI_LOR = OMPI_PREDEFINED_GLOBAL(MPI_Op, ompi_mpi_op_lor)

const MPI_BOR = OMPI_PREDEFINED_GLOBAL(MPI_Op, ompi_mpi_op_bor)

const MPI_LXOR = OMPI_PREDEFINED_GLOBAL(MPI_Op, ompi_mpi_op_lxor)

const MPI_BXOR = OMPI_PREDEFINED_GLOBAL(MPI_Op, ompi_mpi_op_bxor)

const MPI_MAXLOC = OMPI_PREDEFINED_GLOBAL(MPI_Op, ompi_mpi_op_maxloc)

const MPI_MINLOC = OMPI_PREDEFINED_GLOBAL(MPI_Op, ompi_mpi_op_minloc)

const MPI_REPLACE = OMPI_PREDEFINED_GLOBAL(MPI_Op, ompi_mpi_op_replace)

const MPI_NO_OP = OMPI_PREDEFINED_GLOBAL(MPI_Op, ompi_mpi_op_no_op)

const MPI_DATATYPE_NULL = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_datatype_null)

const MPI_BYTE = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_byte)

const MPI_PACKED = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_packed)

const MPI_CHAR = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_char)

const MPI_SHORT = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_short)

const MPI_INT = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_int)

const MPI_LONG = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_long)

const MPI_FLOAT = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_float)

const MPI_DOUBLE = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_double)

const MPI_LONG_DOUBLE = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_long_double)

const MPI_UNSIGNED_CHAR = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_unsigned_char)

const MPI_SIGNED_CHAR = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_signed_char)

const MPI_UNSIGNED_SHORT = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_unsigned_short)

const MPI_UNSIGNED_LONG = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_unsigned_long)

const MPI_UNSIGNED = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_unsigned)

const MPI_FLOAT_INT = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_float_int)

const MPI_DOUBLE_INT = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_double_int)

const MPI_LONG_DOUBLE_INT = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_longdbl_int)

const MPI_LONG_INT = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_long_int)

const MPI_SHORT_INT = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_short_int)

const MPI_2INT = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_2int)

const MPI_WCHAR = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_wchar)

const MPI_LONG_LONG_INT = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_long_long_int)

const MPI_UNSIGNED_LONG_LONG = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_unsigned_long_long)

const MPI_2COMPLEX = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_2cplex)

const MPI_2DOUBLE_COMPLEX = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_2dblcplex)

const MPI_CHARACTER = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_character)

const MPI_LOGICAL = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_logical)

const MPI_LOGICAL1 = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_logical1)

const MPI_LOGICAL2 = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_logical2)

const MPI_LOGICAL4 = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_logical4)

const MPI_LOGICAL8 = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_logical8)

const MPI_INTEGER = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_integer)

const MPI_INTEGER1 = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_integer1)

const MPI_INTEGER2 = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_integer2)

const MPI_INTEGER4 = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_integer4)

const MPI_INTEGER8 = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_integer8)

const MPI_REAL = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_real)

const MPI_REAL4 = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_real4)

const MPI_REAL8 = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_real8)

const MPI_REAL16 = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_real16)

const MPI_DOUBLE_PRECISION = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_dblprec)

const MPI_COMPLEX = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_cplex)

const MPI_COMPLEX8 = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_complex8)

const MPI_COMPLEX16 = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_complex16)

const MPI_COMPLEX32 = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_complex32)

const MPI_DOUBLE_COMPLEX = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_dblcplex)

const MPI_2REAL = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_2real)

const MPI_2DOUBLE_PRECISION = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_2dblprec)

const MPI_2INTEGER = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_2integer)

const MPI_INT8_T = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_int8_t)

const MPI_UINT8_T = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_uint8_t)

const MPI_INT16_T = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_int16_t)

const MPI_UINT16_T = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_uint16_t)

const MPI_INT32_T = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_int32_t)

const MPI_UINT32_T = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_uint32_t)

const MPI_INT64_T = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_int64_t)

const MPI_UINT64_T = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_uint64_t)

const MPI_AINT = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_aint)

const MPI_OFFSET = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_offset)

const MPI_C_BOOL = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_c_bool)

const MPI_C_COMPLEX = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_c_float_complex)

const MPI_C_FLOAT_COMPLEX = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_c_float_complex)

const MPI_C_DOUBLE_COMPLEX = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_c_double_complex)

const MPI_C_LONG_DOUBLE_COMPLEX = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_c_long_double_complex)

const MPI_CXX_BOOL = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_cxx_bool)

const MPI_CXX_COMPLEX = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_cxx_cplex)

const MPI_CXX_FLOAT_COMPLEX = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_cxx_cplex)

const MPI_CXX_DOUBLE_COMPLEX = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_cxx_dblcplex)

const MPI_CXX_LONG_DOUBLE_COMPLEX = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_cxx_ldblcplex)

const MPI_COUNT = OMPI_PREDEFINED_GLOBAL(MPI_Datatype, ompi_mpi_count)

const MPI_ERRORS_ARE_FATAL = OMPI_PREDEFINED_GLOBAL(MPI_Errhandler, ompi_mpi_errors_are_fatal)

const MPI_ERRORS_RETURN = OMPI_PREDEFINED_GLOBAL(MPI_Errhandler, ompi_mpi_errors_return)

const MPI_TYPECLASS_INTEGER = 1

const MPI_TYPECLASS_REAL = 2

const MPI_TYPECLASS_COMPLEX = 3

const MPI_DUP_FN = OMPI_C_MPI_DUP_FN

const MPI_NULL_COPY_FN = OMPI_C_MPI_NULL_COPY_FN

const MPI_NULL_DELETE_FN = OMPI_C_MPI_NULL_DELETE_FN

# exports
const PREFIXES = ["MPI_"]
for name in names(@__MODULE__; all=true), prefix in PREFIXES
    if startswith(string(name), prefix)
        @eval export $name
    end
end

end # module
