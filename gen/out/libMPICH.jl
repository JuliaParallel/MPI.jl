module libMPICH

using MPICH_jll
export MPICH_jll

using CEnum

const MPI_Comm = Cint

const MPI_Op = Cint

const MPI_Group = Cint

const MPI_Datatype = Cint

const MPI_Request = Cint

const MPI_Errhandler = Cint

const MPI_Message = Cint

const MPI_Win = Cint

const MPI_Session = Cint

mutable struct ADIOI_FileD end

const MPI_File = Ptr{ADIOI_FileD}

# typedef int ( MPI_Copy_function ) ( MPI_Comm , int , void * , void * , void * , int * )
const MPI_Copy_function = Cvoid

# typedef int ( MPI_Delete_function ) ( MPI_Comm , int , void * , void * )
const MPI_Delete_function = Cvoid

function MPIR_Dup_fn(oldcomm, keyval, extra_state, attribute_val_in, attribute_val_out, flag)
    ccall((:MPIR_Dup_fn, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}), oldcomm, keyval, extra_state, attribute_val_in, attribute_val_out, flag)
end

# typedef int ( MPI_Comm_copy_attr_function ) ( MPI_Comm , int , void * , void * , void * , int * )
const MPI_Comm_copy_attr_function = Cvoid

# typedef int ( MPI_Comm_delete_attr_function ) ( MPI_Comm , int , void * , void * )
const MPI_Comm_delete_attr_function = Cvoid

# typedef int ( MPI_Win_copy_attr_function ) ( MPI_Win , int , void * , void * , void * , int * )
const MPI_Win_copy_attr_function = Cvoid

# typedef int ( MPI_Win_delete_attr_function ) ( MPI_Win , int , void * , void * )
const MPI_Win_delete_attr_function = Cvoid

# typedef int ( MPI_Type_copy_attr_function ) ( MPI_Datatype , int , void * , void * , void * , int * )
const MPI_Type_copy_attr_function = Cvoid

# typedef int ( MPI_Type_delete_attr_function ) ( MPI_Datatype , int , void * , void * )
const MPI_Type_delete_attr_function = Cvoid

const MPI_Info = Cint

mutable struct MPIR_T_enum_s end

const MPI_T_enum = Ptr{MPIR_T_enum_s}

mutable struct MPIR_T_cvar_handle_s end

const MPI_T_cvar_handle = Ptr{MPIR_T_cvar_handle_s}

mutable struct MPIR_T_pvar_handle_s end

const MPI_T_pvar_handle = Ptr{MPIR_T_pvar_handle_s}

mutable struct MPIR_T_pvar_session_s end

const MPI_T_pvar_session = Ptr{MPIR_T_pvar_session_s}

const MPI_Fint = Cint

struct MPI_Status
    count_lo::Cint
    count_hi_and_cancelled::Cint
    MPI_SOURCE::Cint
    MPI_TAG::Cint
    MPI_ERROR::Cint
end

# typedef int ( MPI_Datarep_conversion_function ) ( void * , MPI_Datatype , int , void * , MPI_Offset , void * )
const MPI_Datarep_conversion_function = Cvoid

# typedef int ( MPI_Datarep_conversion_function_c ) ( void * , MPI_Datatype , MPI_Count , void * , MPI_Offset , void * )
const MPI_Datarep_conversion_function_c = Cvoid

function MPI_Wait(request, status)
    ccall((:MPI_Wait, libmpi), Cint, (Ptr{MPI_Request}, Ptr{MPI_Status}), request, status)
end

function MPI_Test(request, flag, status)
    ccall((:MPI_Test, libmpi), Cint, (Ptr{MPI_Request}, Ptr{Cint}, Ptr{MPI_Status}), request, flag, status)
end

function PMPI_Wait(request, status)
    ccall((:PMPI_Wait, libmpi), Cint, (Ptr{MPI_Request}, Ptr{MPI_Status}), request, status)
end

function PMPI_Test(request, flag, status)
    ccall((:PMPI_Test, libmpi), Cint, (Ptr{MPI_Request}, Ptr{Cint}, Ptr{MPI_Status}), request, flag, status)
end

@cenum MPIR_Win_flavor::UInt32 begin
    MPI_WIN_FLAVOR_CREATE = 1
    MPI_WIN_FLAVOR_ALLOCATE = 2
    MPI_WIN_FLAVOR_DYNAMIC = 3
    MPI_WIN_FLAVOR_SHARED = 4
end

const MPIR_Win_flavor_t = MPIR_Win_flavor

@cenum MPIR_Win_model::UInt32 begin
    MPI_WIN_SEPARATE = 1
    MPI_WIN_UNIFIED = 2
end

const MPIR_Win_model_t = MPIR_Win_model

@cenum MPIR_Topo_type::UInt32 begin
    MPI_GRAPH = 1
    MPI_CART = 2
    MPI_DIST_GRAPH = 3
end

# typedef void ( MPI_Handler_function ) ( MPI_Comm * , int * , ... )
const MPI_Handler_function = Cvoid

# typedef void ( MPI_Comm_errhandler_function ) ( MPI_Comm * , int * , ... )
const MPI_Comm_errhandler_function = Cvoid

# typedef void ( MPI_File_errhandler_function ) ( MPI_File * , int * , ... )
const MPI_File_errhandler_function = Cvoid

# typedef void ( MPI_Win_errhandler_function ) ( MPI_Win * , int * , ... )
const MPI_Win_errhandler_function = Cvoid

# typedef void ( MPI_Session_errhandler_function ) ( MPI_Session * , int * , ... )
const MPI_Session_errhandler_function = Cvoid

# typedef MPI_Comm_errhandler_function MPI_Comm_errhandler_fn
const MPI_Comm_errhandler_fn = MPI_Comm_errhandler_function

# typedef MPI_File_errhandler_function MPI_File_errhandler_fn
const MPI_File_errhandler_fn = MPI_File_errhandler_function

# typedef MPI_Win_errhandler_function MPI_Win_errhandler_fn
const MPI_Win_errhandler_fn = MPI_Win_errhandler_function

# typedef MPI_Session_errhandler_function MPI_Session_errhandler_fn
const MPI_Session_errhandler_fn = MPI_Session_errhandler_function

const MPIX_Grequest_class = Cint

@cenum MPIR_Combiner_enum::UInt32 begin
    MPI_COMBINER_NAMED = 1
    MPI_COMBINER_DUP = 2
    MPI_COMBINER_CONTIGUOUS = 3
    MPI_COMBINER_VECTOR = 4
    MPI_COMBINER_HVECTOR_INTEGER = 5
    MPI_COMBINER_HVECTOR = 6
    MPI_COMBINER_INDEXED = 7
    MPI_COMBINER_HINDEXED_INTEGER = 8
    MPI_COMBINER_HINDEXED = 9
    MPI_COMBINER_INDEXED_BLOCK = 10
    MPI_COMBINER_STRUCT_INTEGER = 11
    MPI_COMBINER_STRUCT = 12
    MPI_COMBINER_SUBARRAY = 13
    MPI_COMBINER_DARRAY = 14
    MPI_COMBINER_F90_REAL = 15
    MPI_COMBINER_F90_COMPLEX = 16
    MPI_COMBINER_F90_INTEGER = 17
    MPI_COMBINER_RESIZED = 18
    MPI_COMBINER_HINDEXED_BLOCK = 19
end

const MPI_Aint = Clong

const MPI_Count = Clong

const MPI_Offset = Clong

# typedef void ( MPI_User_function ) ( void * , void * , int * , MPI_Datatype * )
const MPI_User_function = Cvoid

# typedef void ( MPI_User_function_c ) ( void * , void * , MPI_Count * , MPI_Datatype * )
const MPI_User_function_c = Cvoid

mutable struct MPIR_T_event_registration_s end

mutable struct MPIR_T_event_instance_s end

const MPI_T_event_registration = Ptr{MPIR_T_event_registration_s}

const MPI_T_event_instance = Ptr{MPIR_T_event_instance_s}

@cenum MPIR_T_verbosity_t::UInt32 begin
    MPI_T_VERBOSITY_INVALID = 0
    MPI_T_VERBOSITY_USER_BASIC = 221
    MPI_T_VERBOSITY_USER_DETAIL = 222
    MPI_T_VERBOSITY_USER_ALL = 223
    MPI_T_VERBOSITY_TUNER_BASIC = 224
    MPI_T_VERBOSITY_TUNER_DETAIL = 225
    MPI_T_VERBOSITY_TUNER_ALL = 226
    MPI_T_VERBOSITY_MPIDEV_BASIC = 227
    MPI_T_VERBOSITY_MPIDEV_DETAIL = 228
    MPI_T_VERBOSITY_MPIDEV_ALL = 229
end

@cenum MPIR_T_bind_t::UInt32 begin
    MPI_T_BIND_INVALID = 0
    MPI_T_BIND_NO_OBJECT = 9700
    MPI_T_BIND_MPI_COMM = 9701
    MPI_T_BIND_MPI_DATATYPE = 9702
    MPI_T_BIND_MPI_ERRHANDLER = 9703
    MPI_T_BIND_MPI_FILE = 9704
    MPI_T_BIND_MPI_GROUP = 9705
    MPI_T_BIND_MPI_OP = 9706
    MPI_T_BIND_MPI_REQUEST = 9707
    MPI_T_BIND_MPI_WIN = 9708
    MPI_T_BIND_MPI_MESSAGE = 9709
    MPI_T_BIND_MPI_INFO = 9710
end

@cenum MPIR_T_scope_t::UInt32 begin
    MPI_T_SCOPE_INVALID = 0
    MPI_T_SCOPE_CONSTANT = 60438
    MPI_T_SCOPE_READONLY = 60439
    MPI_T_SCOPE_LOCAL = 60440
    MPI_T_SCOPE_GROUP = 60441
    MPI_T_SCOPE_GROUP_EQ = 60442
    MPI_T_SCOPE_ALL = 60443
    MPI_T_SCOPE_ALL_EQ = 60444
end

@cenum MPIR_T_pvar_class_t::UInt32 begin
    MPI_T_PVAR_CLASS_INVALID = 0
    MPIR_T_PVAR_CLASS_FIRST = 240
    MPI_T_PVAR_CLASS_STATE = 240
    MPI_T_PVAR_CLASS_LEVEL = 241
    MPI_T_PVAR_CLASS_SIZE = 242
    MPI_T_PVAR_CLASS_PERCENTAGE = 243
    MPI_T_PVAR_CLASS_HIGHWATERMARK = 244
    MPI_T_PVAR_CLASS_LOWWATERMARK = 245
    MPI_T_PVAR_CLASS_COUNTER = 246
    MPI_T_PVAR_CLASS_AGGREGATE = 247
    MPI_T_PVAR_CLASS_TIMER = 248
    MPI_T_PVAR_CLASS_GENERIC = 249
    MPIR_T_PVAR_CLASS_LAST = 250
    MPIR_T_PVAR_CLASS_NUMBER = 10
end

@cenum MPI_T_cb_safety::UInt32 begin
    MPI_T_CB_REQUIRE_NONE = 0
    MPI_T_CB_REQUIRE_MPI_RESTRICTED = 1
    MPI_T_CB_REQUIRE_THREAD_SAFE = 2
    MPI_T_CB_REQUIRE_ASYNC_SIGNAL_SAFE = 3
end

@cenum MPI_T_source_order::UInt32 begin
    MPI_T_SOURCE_ORDERED = 0
    MPI_T_SOURCE_UNORDERED = 1
end

# typedef void ( MPI_T_event_cb_function ) ( MPI_T_event_instance event_instance , MPI_T_event_registration event_registration , MPI_T_cb_safety cb_safety , void * user_data )
const MPI_T_event_cb_function = Cvoid

# typedef void ( MPI_T_event_free_cb_function ) ( MPI_T_event_registration event_registration , MPI_T_cb_safety cb_safety , void * user_data )
const MPI_T_event_free_cb_function = Cvoid

# typedef void ( MPI_T_event_dropped_cb_function ) ( MPI_Count count , MPI_T_event_registration event_registration , int source_index , MPI_T_cb_safety cb_safety , void * user_data )
const MPI_T_event_dropped_cb_function = Cvoid

struct MPI_F08_status
    count_lo::MPI_Fint
    count_hi_and_cancelled::MPI_Fint
    MPI_SOURCE::MPI_Fint
    MPI_TAG::MPI_Fint
    MPI_ERROR::MPI_Fint
end

# typedef int ( MPI_Grequest_cancel_function ) ( void * , int )
const MPI_Grequest_cancel_function = Cvoid

# typedef int ( MPI_Grequest_free_function ) ( void * )
const MPI_Grequest_free_function = Cvoid

# typedef int ( MPI_Grequest_query_function ) ( void * , MPI_Status * )
const MPI_Grequest_query_function = Cvoid

# typedef int ( MPIX_Grequest_poll_function ) ( void * , MPI_Status * )
const MPIX_Grequest_poll_function = Cvoid

# typedef int ( MPIX_Grequest_wait_function ) ( int , void * * , double , MPI_Status * )
const MPIX_Grequest_wait_function = Cvoid

# typedef int ( MPI_Datarep_extent_function ) ( MPI_Datatype datatype , MPI_Aint * , void * )
const MPI_Datarep_extent_function = Cvoid

struct QMPI_Context
    storage_stack::Ptr{Ptr{Cvoid}}
end

function QMPI_Register_tool_name(tool_name, init_function_ptr)
    ccall((:QMPI_Register_tool_name, libmpi), Cint, (Ptr{Cchar}, Ptr{Cvoid}), tool_name, init_function_ptr)
end

function QMPI_Register_tool_storage(tool_id, tool_storage)
    ccall((:QMPI_Register_tool_storage, libmpi), Cint, (Cint, Ptr{Cvoid}), tool_id, tool_storage)
end

@cenum QMPI_Functions_enum::UInt32 begin
    MPI_ATTR_DELETE_T = 0
    MPI_ATTR_GET_T = 1
    MPI_ATTR_PUT_T = 2
    MPI_COMM_CREATE_KEYVAL_T = 3
    MPI_COMM_DELETE_ATTR_T = 4
    MPI_COMM_FREE_KEYVAL_T = 5
    MPI_COMM_GET_ATTR_T = 6
    MPI_COMM_SET_ATTR_T = 7
    MPI_KEYVAL_CREATE_T = 8
    MPI_KEYVAL_FREE_T = 9
    MPI_TYPE_CREATE_KEYVAL_T = 10
    MPI_TYPE_DELETE_ATTR_T = 11
    MPI_TYPE_FREE_KEYVAL_T = 12
    MPI_TYPE_GET_ATTR_T = 13
    MPI_TYPE_SET_ATTR_T = 14
    MPI_WIN_CREATE_KEYVAL_T = 15
    MPI_WIN_DELETE_ATTR_T = 16
    MPI_WIN_FREE_KEYVAL_T = 17
    MPI_WIN_GET_ATTR_T = 18
    MPI_WIN_SET_ATTR_T = 19
    MPI_ALLGATHER_T = 20
    MPI_ALLGATHER_C_T = 21
    MPI_ALLGATHER_INIT_T = 22
    MPI_ALLGATHER_INIT_C_T = 23
    MPI_ALLGATHERV_T = 24
    MPI_ALLGATHERV_C_T = 25
    MPI_ALLGATHERV_INIT_T = 26
    MPI_ALLGATHERV_INIT_C_T = 27
    MPI_ALLREDUCE_T = 28
    MPI_ALLREDUCE_C_T = 29
    MPI_ALLREDUCE_INIT_T = 30
    MPI_ALLREDUCE_INIT_C_T = 31
    MPI_ALLTOALL_T = 32
    MPI_ALLTOALL_C_T = 33
    MPI_ALLTOALL_INIT_T = 34
    MPI_ALLTOALL_INIT_C_T = 35
    MPI_ALLTOALLV_T = 36
    MPI_ALLTOALLV_C_T = 37
    MPI_ALLTOALLV_INIT_T = 38
    MPI_ALLTOALLV_INIT_C_T = 39
    MPI_ALLTOALLW_T = 40
    MPI_ALLTOALLW_C_T = 41
    MPI_ALLTOALLW_INIT_T = 42
    MPI_ALLTOALLW_INIT_C_T = 43
    MPI_BARRIER_T = 44
    MPI_BARRIER_INIT_T = 45
    MPI_BCAST_T = 46
    MPI_BCAST_C_T = 47
    MPI_BCAST_INIT_T = 48
    MPI_BCAST_INIT_C_T = 49
    MPI_EXSCAN_T = 50
    MPI_EXSCAN_C_T = 51
    MPI_EXSCAN_INIT_T = 52
    MPI_EXSCAN_INIT_C_T = 53
    MPI_GATHER_T = 54
    MPI_GATHER_C_T = 55
    MPI_GATHER_INIT_T = 56
    MPI_GATHER_INIT_C_T = 57
    MPI_GATHERV_T = 58
    MPI_GATHERV_C_T = 59
    MPI_GATHERV_INIT_T = 60
    MPI_GATHERV_INIT_C_T = 61
    MPI_IALLGATHER_T = 62
    MPI_IALLGATHER_C_T = 63
    MPI_IALLGATHERV_T = 64
    MPI_IALLGATHERV_C_T = 65
    MPI_IALLREDUCE_T = 66
    MPI_IALLREDUCE_C_T = 67
    MPI_IALLTOALL_T = 68
    MPI_IALLTOALL_C_T = 69
    MPI_IALLTOALLV_T = 70
    MPI_IALLTOALLV_C_T = 71
    MPI_IALLTOALLW_T = 72
    MPI_IALLTOALLW_C_T = 73
    MPI_IBARRIER_T = 74
    MPI_IBCAST_T = 75
    MPI_IBCAST_C_T = 76
    MPI_IEXSCAN_T = 77
    MPI_IEXSCAN_C_T = 78
    MPI_IGATHER_T = 79
    MPI_IGATHER_C_T = 80
    MPI_IGATHERV_T = 81
    MPI_IGATHERV_C_T = 82
    MPI_INEIGHBOR_ALLGATHER_T = 83
    MPI_INEIGHBOR_ALLGATHER_C_T = 84
    MPI_INEIGHBOR_ALLGATHERV_T = 85
    MPI_INEIGHBOR_ALLGATHERV_C_T = 86
    MPI_INEIGHBOR_ALLTOALL_T = 87
    MPI_INEIGHBOR_ALLTOALL_C_T = 88
    MPI_INEIGHBOR_ALLTOALLV_T = 89
    MPI_INEIGHBOR_ALLTOALLV_C_T = 90
    MPI_INEIGHBOR_ALLTOALLW_T = 91
    MPI_INEIGHBOR_ALLTOALLW_C_T = 92
    MPI_IREDUCE_T = 93
    MPI_IREDUCE_C_T = 94
    MPI_IREDUCE_SCATTER_T = 95
    MPI_IREDUCE_SCATTER_C_T = 96
    MPI_IREDUCE_SCATTER_BLOCK_T = 97
    MPI_IREDUCE_SCATTER_BLOCK_C_T = 98
    MPI_ISCAN_T = 99
    MPI_ISCAN_C_T = 100
    MPI_ISCATTER_T = 101
    MPI_ISCATTER_C_T = 102
    MPI_ISCATTERV_T = 103
    MPI_ISCATTERV_C_T = 104
    MPI_NEIGHBOR_ALLGATHER_T = 105
    MPI_NEIGHBOR_ALLGATHER_C_T = 106
    MPI_NEIGHBOR_ALLGATHER_INIT_T = 107
    MPI_NEIGHBOR_ALLGATHER_INIT_C_T = 108
    MPI_NEIGHBOR_ALLGATHERV_T = 109
    MPI_NEIGHBOR_ALLGATHERV_C_T = 110
    MPI_NEIGHBOR_ALLGATHERV_INIT_T = 111
    MPI_NEIGHBOR_ALLGATHERV_INIT_C_T = 112
    MPI_NEIGHBOR_ALLTOALL_T = 113
    MPI_NEIGHBOR_ALLTOALL_C_T = 114
    MPI_NEIGHBOR_ALLTOALL_INIT_T = 115
    MPI_NEIGHBOR_ALLTOALL_INIT_C_T = 116
    MPI_NEIGHBOR_ALLTOALLV_T = 117
    MPI_NEIGHBOR_ALLTOALLV_C_T = 118
    MPI_NEIGHBOR_ALLTOALLV_INIT_T = 119
    MPI_NEIGHBOR_ALLTOALLV_INIT_C_T = 120
    MPI_NEIGHBOR_ALLTOALLW_T = 121
    MPI_NEIGHBOR_ALLTOALLW_C_T = 122
    MPI_NEIGHBOR_ALLTOALLW_INIT_T = 123
    MPI_NEIGHBOR_ALLTOALLW_INIT_C_T = 124
    MPI_REDUCE_T = 125
    MPI_REDUCE_C_T = 126
    MPI_REDUCE_INIT_T = 127
    MPI_REDUCE_INIT_C_T = 128
    MPI_REDUCE_LOCAL_T = 129
    MPI_REDUCE_LOCAL_C_T = 130
    MPI_REDUCE_SCATTER_T = 131
    MPI_REDUCE_SCATTER_C_T = 132
    MPI_REDUCE_SCATTER_BLOCK_T = 133
    MPI_REDUCE_SCATTER_BLOCK_C_T = 134
    MPI_REDUCE_SCATTER_BLOCK_INIT_T = 135
    MPI_REDUCE_SCATTER_BLOCK_INIT_C_T = 136
    MPI_REDUCE_SCATTER_INIT_T = 137
    MPI_REDUCE_SCATTER_INIT_C_T = 138
    MPI_SCAN_T = 139
    MPI_SCAN_C_T = 140
    MPI_SCAN_INIT_T = 141
    MPI_SCAN_INIT_C_T = 142
    MPI_SCATTER_T = 143
    MPI_SCATTER_C_T = 144
    MPI_SCATTER_INIT_T = 145
    MPI_SCATTER_INIT_C_T = 146
    MPI_SCATTERV_T = 147
    MPI_SCATTERV_C_T = 148
    MPI_SCATTERV_INIT_T = 149
    MPI_SCATTERV_INIT_C_T = 150
    MPI_COMM_COMPARE_T = 151
    MPI_COMM_CREATE_T = 152
    MPI_COMM_CREATE_GROUP_T = 153
    MPI_COMM_DUP_T = 154
    MPI_COMM_DUP_WITH_INFO_T = 155
    MPI_COMM_FREE_T = 156
    MPI_COMM_GET_INFO_T = 157
    MPI_COMM_GET_NAME_T = 158
    MPI_COMM_GROUP_T = 159
    MPI_COMM_IDUP_T = 160
    MPI_COMM_IDUP_WITH_INFO_T = 161
    MPI_COMM_RANK_T = 162
    MPI_COMM_REMOTE_GROUP_T = 163
    MPI_COMM_REMOTE_SIZE_T = 164
    MPI_COMM_SET_INFO_T = 165
    MPI_COMM_SET_NAME_T = 166
    MPI_COMM_SIZE_T = 167
    MPI_COMM_SPLIT_T = 168
    MPI_COMM_SPLIT_TYPE_T = 169
    MPI_COMM_TEST_INTER_T = 170
    MPI_INTERCOMM_CREATE_T = 171
    MPI_INTERCOMM_CREATE_FROM_GROUPS_T = 172
    MPI_INTERCOMM_MERGE_T = 173
    MPIX_COMM_REVOKE_T = 174
    MPIX_COMM_SHRINK_T = 175
    MPIX_COMM_FAILURE_ACK_T = 176
    MPIX_COMM_FAILURE_GET_ACKED_T = 177
    MPIX_COMM_AGREE_T = 178
    MPI_GET_ADDRESS_T = 179
    MPI_GET_COUNT_T = 180
    MPI_GET_COUNT_C_T = 181
    MPI_GET_ELEMENTS_T = 182
    MPI_GET_ELEMENTS_C_T = 183
    MPI_GET_ELEMENTS_X_T = 184
    MPI_PACK_T = 185
    MPI_PACK_C_T = 186
    MPI_PACK_EXTERNAL_T = 187
    MPI_PACK_EXTERNAL_C_T = 188
    MPI_PACK_EXTERNAL_SIZE_T = 189
    MPI_PACK_EXTERNAL_SIZE_C_T = 190
    MPI_PACK_SIZE_T = 191
    MPI_PACK_SIZE_C_T = 192
    MPI_STATUS_SET_ELEMENTS_T = 193
    MPI_STATUS_SET_ELEMENTS_X_T = 194
    MPI_TYPE_COMMIT_T = 195
    MPI_TYPE_CONTIGUOUS_T = 196
    MPI_TYPE_CONTIGUOUS_C_T = 197
    MPI_TYPE_CREATE_DARRAY_T = 198
    MPI_TYPE_CREATE_DARRAY_C_T = 199
    MPI_TYPE_CREATE_HINDEXED_T = 200
    MPI_TYPE_CREATE_HINDEXED_C_T = 201
    MPI_TYPE_CREATE_HINDEXED_BLOCK_T = 202
    MPI_TYPE_CREATE_HINDEXED_BLOCK_C_T = 203
    MPI_TYPE_CREATE_HVECTOR_T = 204
    MPI_TYPE_CREATE_HVECTOR_C_T = 205
    MPI_TYPE_CREATE_INDEXED_BLOCK_T = 206
    MPI_TYPE_CREATE_INDEXED_BLOCK_C_T = 207
    MPI_TYPE_CREATE_RESIZED_T = 208
    MPI_TYPE_CREATE_RESIZED_C_T = 209
    MPI_TYPE_CREATE_STRUCT_T = 210
    MPI_TYPE_CREATE_STRUCT_C_T = 211
    MPI_TYPE_CREATE_SUBARRAY_T = 212
    MPI_TYPE_CREATE_SUBARRAY_C_T = 213
    MPI_TYPE_DUP_T = 214
    MPI_TYPE_FREE_T = 215
    MPI_TYPE_GET_CONTENTS_T = 216
    MPI_TYPE_GET_CONTENTS_C_T = 217
    MPI_TYPE_GET_ENVELOPE_T = 218
    MPI_TYPE_GET_ENVELOPE_C_T = 219
    MPI_TYPE_GET_EXTENT_T = 220
    MPI_TYPE_GET_EXTENT_C_T = 221
    MPI_TYPE_GET_EXTENT_X_T = 222
    MPI_TYPE_GET_NAME_T = 223
    MPI_TYPE_GET_TRUE_EXTENT_T = 224
    MPI_TYPE_GET_TRUE_EXTENT_C_T = 225
    MPI_TYPE_GET_TRUE_EXTENT_X_T = 226
    MPI_TYPE_INDEXED_T = 227
    MPI_TYPE_INDEXED_C_T = 228
    MPI_TYPE_MATCH_SIZE_T = 229
    MPI_TYPE_SET_NAME_T = 230
    MPI_TYPE_SIZE_T = 231
    MPI_TYPE_SIZE_C_T = 232
    MPI_TYPE_SIZE_X_T = 233
    MPI_TYPE_VECTOR_T = 234
    MPI_TYPE_VECTOR_C_T = 235
    MPI_UNPACK_T = 236
    MPI_UNPACK_C_T = 237
    MPI_UNPACK_EXTERNAL_T = 238
    MPI_UNPACK_EXTERNAL_C_T = 239
    MPI_ADDRESS_T = 240
    MPI_TYPE_EXTENT_T = 241
    MPI_TYPE_LB_T = 242
    MPI_TYPE_UB_T = 243
    MPI_TYPE_HINDEXED_T = 244
    MPI_TYPE_HVECTOR_T = 245
    MPI_TYPE_STRUCT_T = 246
    MPI_ADD_ERROR_CLASS_T = 247
    MPI_ADD_ERROR_CODE_T = 248
    MPI_ADD_ERROR_STRING_T = 249
    MPI_COMM_CALL_ERRHANDLER_T = 250
    MPI_COMM_CREATE_ERRHANDLER_T = 251
    MPI_COMM_GET_ERRHANDLER_T = 252
    MPI_COMM_SET_ERRHANDLER_T = 253
    MPI_ERRHANDLER_FREE_T = 254
    MPI_ERROR_CLASS_T = 255
    MPI_ERROR_STRING_T = 256
    MPI_FILE_CALL_ERRHANDLER_T = 257
    MPI_FILE_CREATE_ERRHANDLER_T = 258
    MPI_FILE_GET_ERRHANDLER_T = 259
    MPI_FILE_SET_ERRHANDLER_T = 260
    MPI_SESSION_CALL_ERRHANDLER_T = 261
    MPI_SESSION_CREATE_ERRHANDLER_T = 262
    MPI_SESSION_GET_ERRHANDLER_T = 263
    MPI_SESSION_SET_ERRHANDLER_T = 264
    MPI_WIN_CALL_ERRHANDLER_T = 265
    MPI_WIN_CREATE_ERRHANDLER_T = 266
    MPI_WIN_GET_ERRHANDLER_T = 267
    MPI_WIN_SET_ERRHANDLER_T = 268
    MPIX_DELETE_ERROR_CLASS_T = 269
    MPIX_DELETE_ERROR_CODE_T = 270
    MPIX_DELETE_ERROR_STRING_T = 271
    MPI_ERRHANDLER_CREATE_T = 272
    MPI_ERRHANDLER_GET_T = 273
    MPI_ERRHANDLER_SET_T = 274
    MPI_GROUP_COMPARE_T = 275
    MPI_GROUP_DIFFERENCE_T = 276
    MPI_GROUP_EXCL_T = 277
    MPI_GROUP_FREE_T = 278
    MPI_GROUP_INCL_T = 279
    MPI_GROUP_INTERSECTION_T = 280
    MPI_GROUP_RANGE_EXCL_T = 281
    MPI_GROUP_RANGE_INCL_T = 282
    MPI_GROUP_RANK_T = 283
    MPI_GROUP_SIZE_T = 284
    MPI_GROUP_TRANSLATE_RANKS_T = 285
    MPI_GROUP_UNION_T = 286
    MPI_INFO_CREATE_T = 287
    MPI_INFO_CREATE_ENV_T = 288
    MPI_INFO_DELETE_T = 289
    MPI_INFO_DUP_T = 290
    MPI_INFO_FREE_T = 291
    MPI_INFO_GET_T = 292
    MPI_INFO_GET_NKEYS_T = 293
    MPI_INFO_GET_NTHKEY_T = 294
    MPI_INFO_GET_STRING_T = 295
    MPI_INFO_GET_VALUELEN_T = 296
    MPI_INFO_SET_T = 297
    MPI_ABORT_T = 298
    MPI_COMM_CREATE_FROM_GROUP_T = 299
    MPI_FINALIZE_T = 300
    MPI_FINALIZED_T = 301
    MPI_GROUP_FROM_SESSION_PSET_T = 302
    MPI_INIT_T = 303
    MPI_INIT_THREAD_T = 304
    MPI_INITIALIZED_T = 305
    MPI_IS_THREAD_MAIN_T = 306
    MPI_QUERY_THREAD_T = 307
    MPI_SESSION_FINALIZE_T = 308
    MPI_SESSION_GET_INFO_T = 309
    MPI_SESSION_GET_NTH_PSET_T = 310
    MPI_SESSION_GET_NUM_PSETS_T = 311
    MPI_SESSION_GET_PSET_INFO_T = 312
    MPI_SESSION_INIT_T = 313
    MPI_AINT_ADD_T = 314
    MPI_AINT_DIFF_T = 315
    MPI_GET_LIBRARY_VERSION_T = 316
    MPI_GET_PROCESSOR_NAME_T = 317
    MPI_GET_VERSION_T = 318
    MPI_PCONTROL_T = 319
    MPIX_GPU_QUERY_SUPPORT_T = 320
    MPIX_QUERY_CUDA_SUPPORT_T = 321
    MPIX_QUERY_ZE_SUPPORT_T = 322
    MPIX_QUERY_HIP_SUPPORT_T = 323
    MPI_T_CATEGORY_CHANGED_T = 324
    MPI_T_CATEGORY_GET_CATEGORIES_T = 325
    MPI_T_CATEGORY_GET_CVARS_T = 326
    MPI_T_CATEGORY_GET_EVENTS_T = 327
    MPI_T_CATEGORY_GET_INDEX_T = 328
    MPI_T_CATEGORY_GET_INFO_T = 329
    MPI_T_CATEGORY_GET_NUM_T = 330
    MPI_T_CATEGORY_GET_NUM_EVENTS_T = 331
    MPI_T_CATEGORY_GET_PVARS_T = 332
    MPI_T_CVAR_GET_INDEX_T = 333
    MPI_T_CVAR_GET_INFO_T = 334
    MPI_T_CVAR_GET_NUM_T = 335
    MPI_T_CVAR_HANDLE_ALLOC_T = 336
    MPI_T_CVAR_HANDLE_FREE_T = 337
    MPI_T_CVAR_READ_T = 338
    MPI_T_CVAR_WRITE_T = 339
    MPI_T_ENUM_GET_INFO_T = 340
    MPI_T_ENUM_GET_ITEM_T = 341
    MPI_T_EVENT_CALLBACK_GET_INFO_T = 342
    MPI_T_EVENT_CALLBACK_SET_INFO_T = 343
    MPI_T_EVENT_COPY_T = 344
    MPI_T_EVENT_GET_INDEX_T = 345
    MPI_T_EVENT_GET_INFO_T = 346
    MPI_T_EVENT_GET_NUM_T = 347
    MPI_T_EVENT_GET_SOURCE_T = 348
    MPI_T_EVENT_GET_TIMESTAMP_T = 349
    MPI_T_EVENT_HANDLE_ALLOC_T = 350
    MPI_T_EVENT_HANDLE_FREE_T = 351
    MPI_T_EVENT_HANDLE_GET_INFO_T = 352
    MPI_T_EVENT_HANDLE_SET_INFO_T = 353
    MPI_T_EVENT_READ_T = 354
    MPI_T_EVENT_REGISTER_CALLBACK_T = 355
    MPI_T_EVENT_SET_DROPPED_HANDLER_T = 356
    MPI_T_FINALIZE_T = 357
    MPI_T_INIT_THREAD_T = 358
    MPI_T_PVAR_GET_INDEX_T = 359
    MPI_T_PVAR_GET_INFO_T = 360
    MPI_T_PVAR_GET_NUM_T = 361
    MPI_T_PVAR_HANDLE_ALLOC_T = 362
    MPI_T_PVAR_HANDLE_FREE_T = 363
    MPI_T_PVAR_READ_T = 364
    MPI_T_PVAR_READRESET_T = 365
    MPI_T_PVAR_RESET_T = 366
    MPI_T_PVAR_SESSION_CREATE_T = 367
    MPI_T_PVAR_SESSION_FREE_T = 368
    MPI_T_PVAR_START_T = 369
    MPI_T_PVAR_STOP_T = 370
    MPI_T_PVAR_WRITE_T = 371
    MPI_T_SOURCE_GET_INFO_T = 372
    MPI_T_SOURCE_GET_NUM_T = 373
    MPI_T_SOURCE_GET_TIMESTAMP_T = 374
    MPI_OP_COMMUTATIVE_T = 375
    MPI_OP_CREATE_T = 376
    MPI_OP_CREATE_C_T = 377
    MPI_OP_FREE_T = 378
    MPI_PARRIVED_T = 379
    MPI_PREADY_T = 380
    MPI_PREADY_LIST_T = 381
    MPI_PREADY_RANGE_T = 382
    MPI_PRECV_INIT_T = 383
    MPI_PSEND_INIT_T = 384
    MPI_BSEND_T = 385
    MPI_BSEND_C_T = 386
    MPI_BSEND_INIT_T = 387
    MPI_BSEND_INIT_C_T = 388
    MPI_BUFFER_ATTACH_T = 389
    MPI_BUFFER_ATTACH_C_T = 390
    MPI_BUFFER_DETACH_T = 391
    MPI_BUFFER_DETACH_C_T = 392
    MPI_IBSEND_T = 393
    MPI_IBSEND_C_T = 394
    MPI_IMPROBE_T = 395
    MPI_IMRECV_T = 396
    MPI_IMRECV_C_T = 397
    MPI_IPROBE_T = 398
    MPI_IRECV_T = 399
    MPI_IRECV_C_T = 400
    MPI_IRSEND_T = 401
    MPI_IRSEND_C_T = 402
    MPI_ISEND_T = 403
    MPI_ISEND_C_T = 404
    MPI_ISENDRECV_T = 405
    MPI_ISENDRECV_C_T = 406
    MPI_ISENDRECV_REPLACE_T = 407
    MPI_ISENDRECV_REPLACE_C_T = 408
    MPI_ISSEND_T = 409
    MPI_ISSEND_C_T = 410
    MPI_MPROBE_T = 411
    MPI_MRECV_T = 412
    MPI_MRECV_C_T = 413
    MPI_PROBE_T = 414
    MPI_RECV_T = 415
    MPI_RECV_C_T = 416
    MPI_RECV_INIT_T = 417
    MPI_RECV_INIT_C_T = 418
    MPI_RSEND_T = 419
    MPI_RSEND_C_T = 420
    MPI_RSEND_INIT_T = 421
    MPI_RSEND_INIT_C_T = 422
    MPI_SEND_T = 423
    MPI_SEND_C_T = 424
    MPI_SEND_INIT_T = 425
    MPI_SEND_INIT_C_T = 426
    MPI_SENDRECV_T = 427
    MPI_SENDRECV_C_T = 428
    MPI_SENDRECV_REPLACE_T = 429
    MPI_SENDRECV_REPLACE_C_T = 430
    MPI_SSEND_T = 431
    MPI_SSEND_C_T = 432
    MPI_SSEND_INIT_T = 433
    MPI_SSEND_INIT_C_T = 434
    MPI_CANCEL_T = 435
    MPI_GREQUEST_COMPLETE_T = 436
    MPI_GREQUEST_START_T = 437
    MPI_REQUEST_FREE_T = 438
    MPI_REQUEST_GET_STATUS_T = 439
    MPI_START_T = 440
    MPI_STARTALL_T = 441
    MPI_STATUS_SET_CANCELLED_T = 442
    MPI_TEST_T = 443
    MPI_TEST_CANCELLED_T = 444
    MPI_TESTALL_T = 445
    MPI_TESTANY_T = 446
    MPI_TESTSOME_T = 447
    MPI_WAIT_T = 448
    MPI_WAITALL_T = 449
    MPI_WAITANY_T = 450
    MPI_WAITSOME_T = 451
    MPIX_GREQUEST_START_T = 452
    MPIX_GREQUEST_CLASS_CREATE_T = 453
    MPIX_GREQUEST_CLASS_ALLOCATE_T = 454
    MPI_ACCUMULATE_T = 455
    MPI_ACCUMULATE_C_T = 456
    MPI_ALLOC_MEM_T = 457
    MPI_COMPARE_AND_SWAP_T = 458
    MPI_FETCH_AND_OP_T = 459
    MPI_FREE_MEM_T = 460
    MPI_GET_T = 461
    MPI_GET_C_T = 462
    MPI_GET_ACCUMULATE_T = 463
    MPI_GET_ACCUMULATE_C_T = 464
    MPI_PUT_T = 465
    MPI_PUT_C_T = 466
    MPI_RACCUMULATE_T = 467
    MPI_RACCUMULATE_C_T = 468
    MPI_RGET_T = 469
    MPI_RGET_C_T = 470
    MPI_RGET_ACCUMULATE_T = 471
    MPI_RGET_ACCUMULATE_C_T = 472
    MPI_RPUT_T = 473
    MPI_RPUT_C_T = 474
    MPI_WIN_ALLOCATE_T = 475
    MPI_WIN_ALLOCATE_C_T = 476
    MPI_WIN_ALLOCATE_SHARED_T = 477
    MPI_WIN_ALLOCATE_SHARED_C_T = 478
    MPI_WIN_ATTACH_T = 479
    MPI_WIN_COMPLETE_T = 480
    MPI_WIN_CREATE_T = 481
    MPI_WIN_CREATE_C_T = 482
    MPI_WIN_CREATE_DYNAMIC_T = 483
    MPI_WIN_DETACH_T = 484
    MPI_WIN_FENCE_T = 485
    MPI_WIN_FLUSH_T = 486
    MPI_WIN_FLUSH_ALL_T = 487
    MPI_WIN_FLUSH_LOCAL_T = 488
    MPI_WIN_FLUSH_LOCAL_ALL_T = 489
    MPI_WIN_FREE_T = 490
    MPI_WIN_GET_GROUP_T = 491
    MPI_WIN_GET_INFO_T = 492
    MPI_WIN_GET_NAME_T = 493
    MPI_WIN_LOCK_T = 494
    MPI_WIN_LOCK_ALL_T = 495
    MPI_WIN_POST_T = 496
    MPI_WIN_SET_INFO_T = 497
    MPI_WIN_SET_NAME_T = 498
    MPI_WIN_SHARED_QUERY_T = 499
    MPI_WIN_SHARED_QUERY_C_T = 500
    MPI_WIN_START_T = 501
    MPI_WIN_SYNC_T = 502
    MPI_WIN_TEST_T = 503
    MPI_WIN_UNLOCK_T = 504
    MPI_WIN_UNLOCK_ALL_T = 505
    MPI_WIN_WAIT_T = 506
    MPI_CLOSE_PORT_T = 507
    MPI_COMM_ACCEPT_T = 508
    MPI_COMM_CONNECT_T = 509
    MPI_COMM_DISCONNECT_T = 510
    MPI_COMM_GET_PARENT_T = 511
    MPI_COMM_JOIN_T = 512
    MPI_COMM_SPAWN_T = 513
    MPI_COMM_SPAWN_MULTIPLE_T = 514
    MPI_LOOKUP_NAME_T = 515
    MPI_OPEN_PORT_T = 516
    MPI_PUBLISH_NAME_T = 517
    MPI_UNPUBLISH_NAME_T = 518
    MPI_WTICK_T = 519
    MPI_WTIME_T = 520
    MPI_CART_COORDS_T = 521
    MPI_CART_CREATE_T = 522
    MPI_CART_GET_T = 523
    MPI_CART_MAP_T = 524
    MPI_CART_RANK_T = 525
    MPI_CART_SHIFT_T = 526
    MPI_CART_SUB_T = 527
    MPI_CARTDIM_GET_T = 528
    MPI_DIMS_CREATE_T = 529
    MPI_DIST_GRAPH_CREATE_T = 530
    MPI_DIST_GRAPH_CREATE_ADJACENT_T = 531
    MPI_DIST_GRAPH_NEIGHBORS_T = 532
    MPI_DIST_GRAPH_NEIGHBORS_COUNT_T = 533
    MPI_GRAPH_CREATE_T = 534
    MPI_GRAPH_GET_T = 535
    MPI_GRAPH_MAP_T = 536
    MPI_GRAPH_NEIGHBORS_T = 537
    MPI_GRAPH_NEIGHBORS_COUNT_T = 538
    MPI_GRAPHDIMS_GET_T = 539
    MPI_TOPO_TEST_T = 540
    MPI_LAST_FUNC_T = 541
end

function QMPI_Register_function(calling_tool_id, function_enum, function_ptr)
    ccall((:QMPI_Register_function, libmpi), Cint, (Cint, QMPI_Functions_enum, Ptr{Cvoid}), calling_tool_id, function_enum, function_ptr)
end

function QMPI_Get_function(calling_tool_id, function_enum, function_ptr, next_tool_id)
    ccall((:QMPI_Get_function, libmpi), Cint, (Cint, QMPI_Functions_enum, Ptr{Ptr{Cvoid}}, Ptr{Cint}), calling_tool_id, function_enum, function_ptr, next_tool_id)
end

function QMPI_Get_tool_storage(context, tool_id, storage)
    ccall((:QMPI_Get_tool_storage, libmpi), Cint, (QMPI_Context, Cint, Ptr{Ptr{Cvoid}}), context, tool_id, storage)
end

function QMPI_Get_calling_address(context, address)
    ccall((:QMPI_Get_calling_address, libmpi), Cint, (QMPI_Context, Ptr{Ptr{Cvoid}}), context, address)
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

function MPI_Register_datarep(datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)
    ccall((:MPI_Register_datarep, libmpi), Cint, (Ptr{Cchar}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}), datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)
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

function MPI_File_iread_at_all(fh, offset, buf, count, datatype, request)
    ccall((:MPI_File_iread_at_all, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

function MPI_File_iwrite_at_all(fh, offset, buf, count, datatype, request)
    ccall((:MPI_File_iwrite_at_all, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

function MPI_File_iread_all(fh, buf, count, datatype, request)
    ccall((:MPI_File_iread_all, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

function MPI_File_iwrite_all(fh, buf, count, datatype, request)
    ccall((:MPI_File_iwrite_all, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

function MPI_File_read_c(fh, buf, count, datatype, status)
    ccall((:MPI_File_read_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function MPI_File_read_all_c(fh, buf, count, datatype, status)
    ccall((:MPI_File_read_all_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function MPI_File_read_all_begin_c(fh, buf, count, datatype)
    ccall((:MPI_File_read_all_begin_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype), fh, buf, count, datatype)
end

function MPI_File_read_at_c(fh, offset, buf, count, datatype, status)
    ccall((:MPI_File_read_at_c, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

function MPI_File_read_at_all_c(fh, offset, buf, count, datatype, status)
    ccall((:MPI_File_read_at_all_c, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

function MPI_File_read_at_all_begin_c(fh, offset, buf, count, datatype)
    ccall((:MPI_File_read_at_all_begin_c, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, MPI_Count, MPI_Datatype), fh, offset, buf, count, datatype)
end

function MPI_File_read_ordered_c(fh, buf, count, datatype, status)
    ccall((:MPI_File_read_ordered_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function MPI_File_read_ordered_begin_c(fh, buf, count, datatype)
    ccall((:MPI_File_read_ordered_begin_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype), fh, buf, count, datatype)
end

function MPI_File_read_shared_c(fh, buf, count, datatype, status)
    ccall((:MPI_File_read_shared_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function MPI_File_write_c(fh, buf, count, datatype, status)
    ccall((:MPI_File_write_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function MPI_File_write_all_c(fh, buf, count, datatype, status)
    ccall((:MPI_File_write_all_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function MPI_File_write_all_begin_c(fh, buf, count, datatype)
    ccall((:MPI_File_write_all_begin_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype), fh, buf, count, datatype)
end

function MPI_File_write_at_c(fh, offset, buf, count, datatype, status)
    ccall((:MPI_File_write_at_c, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

function MPI_File_write_at_all_c(fh, offset, buf, count, datatype, status)
    ccall((:MPI_File_write_at_all_c, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

function MPI_File_write_at_all_begin_c(fh, offset, buf, count, datatype)
    ccall((:MPI_File_write_at_all_begin_c, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, MPI_Count, MPI_Datatype), fh, offset, buf, count, datatype)
end

function MPI_File_write_ordered_c(fh, buf, count, datatype, status)
    ccall((:MPI_File_write_ordered_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function MPI_File_write_ordered_begin_c(fh, buf, count, datatype)
    ccall((:MPI_File_write_ordered_begin_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype), fh, buf, count, datatype)
end

function MPI_File_write_shared_c(fh, buf, count, datatype, status)
    ccall((:MPI_File_write_shared_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function MPI_File_iread_c(fh, buf, count, datatype, request)
    ccall((:MPI_File_iread_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

function MPI_File_iread_all_c(fh, buf, count, datatype, request)
    ccall((:MPI_File_iread_all_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

function MPI_File_iread_at_c(fh, offset, buf, count, datatype, request)
    ccall((:MPI_File_iread_at_c, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

function MPI_File_iread_at_all_c(fh, offset, buf, count, datatype, request)
    ccall((:MPI_File_iread_at_all_c, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

function MPI_File_iread_shared_c(fh, buf, count, datatype, request)
    ccall((:MPI_File_iread_shared_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

function MPI_File_iwrite_c(fh, buf, count, datatype, request)
    ccall((:MPI_File_iwrite_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

function MPI_File_iwrite_all_c(fh, buf, count, datatype, request)
    ccall((:MPI_File_iwrite_all_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

function MPI_File_iwrite_at_c(fh, offset, buf, count, datatype, request)
    ccall((:MPI_File_iwrite_at_c, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

function MPI_File_iwrite_at_all_c(fh, offset, buf, count, datatype, request)
    ccall((:MPI_File_iwrite_at_all_c, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

function MPI_File_iwrite_shared_c(fh, buf, count, datatype, request)
    ccall((:MPI_File_iwrite_shared_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

function MPI_File_get_type_extent_c(fh, datatype, extent)
    ccall((:MPI_File_get_type_extent_c, libmpi), Cint, (MPI_File, MPI_Datatype, Ptr{MPI_Count}), fh, datatype, extent)
end

function MPI_Register_datarep_c(datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)
    ccall((:MPI_Register_datarep_c, libmpi), Cint, (Ptr{Cchar}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}), datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)
end

function MPI_File_f2c(file)
    ccall((:MPI_File_f2c, libmpi), MPI_File, (MPI_Fint,), file)
end

function MPI_File_c2f(file)
    ccall((:MPI_File_c2f, libmpi), MPI_Fint, (MPI_File,), file)
end

function PMPI_File_open(arg1, arg2, arg3, arg4, arg5)
    ccall((:PMPI_File_open, libmpi), Cint, (MPI_Comm, Ptr{Cchar}, Cint, MPI_Info, Ptr{MPI_File}), arg1, arg2, arg3, arg4, arg5)
end

function PMPI_File_close(arg1)
    ccall((:PMPI_File_close, libmpi), Cint, (Ptr{MPI_File},), arg1)
end

function PMPI_File_delete(arg1, arg2)
    ccall((:PMPI_File_delete, libmpi), Cint, (Ptr{Cchar}, MPI_Info), arg1, arg2)
end

function PMPI_File_set_size(arg1, arg2)
    ccall((:PMPI_File_set_size, libmpi), Cint, (MPI_File, MPI_Offset), arg1, arg2)
end

function PMPI_File_preallocate(arg1, arg2)
    ccall((:PMPI_File_preallocate, libmpi), Cint, (MPI_File, MPI_Offset), arg1, arg2)
end

function PMPI_File_get_size(arg1, arg2)
    ccall((:PMPI_File_get_size, libmpi), Cint, (MPI_File, Ptr{MPI_Offset}), arg1, arg2)
end

function PMPI_File_get_group(arg1, arg2)
    ccall((:PMPI_File_get_group, libmpi), Cint, (MPI_File, Ptr{MPI_Group}), arg1, arg2)
end

function PMPI_File_get_amode(arg1, arg2)
    ccall((:PMPI_File_get_amode, libmpi), Cint, (MPI_File, Ptr{Cint}), arg1, arg2)
end

function PMPI_File_set_info(arg1, arg2)
    ccall((:PMPI_File_set_info, libmpi), Cint, (MPI_File, MPI_Info), arg1, arg2)
end

function PMPI_File_get_info(arg1, arg2)
    ccall((:PMPI_File_get_info, libmpi), Cint, (MPI_File, Ptr{MPI_Info}), arg1, arg2)
end

function PMPI_File_set_view(arg1, arg2, arg3, arg4, arg5, arg6)
    ccall((:PMPI_File_set_view, libmpi), Cint, (MPI_File, MPI_Offset, MPI_Datatype, MPI_Datatype, Ptr{Cchar}, MPI_Info), arg1, arg2, arg3, arg4, arg5, arg6)
end

function PMPI_File_get_view(arg1, arg2, arg3, arg4, arg5)
    ccall((:PMPI_File_get_view, libmpi), Cint, (MPI_File, Ptr{MPI_Offset}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}, Ptr{Cchar}), arg1, arg2, arg3, arg4, arg5)
end

function PMPI_File_read_at(arg1, arg2, arg3, arg4, arg5, arg6)
    ccall((:PMPI_File_read_at, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), arg1, arg2, arg3, arg4, arg5, arg6)
end

function PMPI_File_read_at_all(arg1, arg2, arg3, arg4, arg5, arg6)
    ccall((:PMPI_File_read_at_all, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), arg1, arg2, arg3, arg4, arg5, arg6)
end

function PMPI_File_write_at(arg1, arg2, arg3, arg4, arg5, arg6)
    ccall((:PMPI_File_write_at, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), arg1, arg2, arg3, arg4, arg5, arg6)
end

function PMPI_File_write_at_all(arg1, arg2, arg3, arg4, arg5, arg6)
    ccall((:PMPI_File_write_at_all, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), arg1, arg2, arg3, arg4, arg5, arg6)
end

function PMPI_File_iread_at(arg1, arg2, arg3, arg4, arg5, arg6)
    ccall((:PMPI_File_iread_at, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), arg1, arg2, arg3, arg4, arg5, arg6)
end

function PMPI_File_iwrite_at(arg1, arg2, arg3, arg4, arg5, arg6)
    ccall((:PMPI_File_iwrite_at, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), arg1, arg2, arg3, arg4, arg5, arg6)
end

function PMPI_File_read(arg1, arg2, arg3, arg4, arg5)
    ccall((:PMPI_File_read, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), arg1, arg2, arg3, arg4, arg5)
end

function PMPI_File_read_all(arg1, arg2, arg3, arg4, arg5)
    ccall((:PMPI_File_read_all, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), arg1, arg2, arg3, arg4, arg5)
end

function PMPI_File_write(arg1, arg2, arg3, arg4, arg5)
    ccall((:PMPI_File_write, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), arg1, arg2, arg3, arg4, arg5)
end

function PMPI_File_write_all(arg1, arg2, arg3, arg4, arg5)
    ccall((:PMPI_File_write_all, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), arg1, arg2, arg3, arg4, arg5)
end

function PMPI_File_iread(arg1, arg2, arg3, arg4, arg5)
    ccall((:PMPI_File_iread, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), arg1, arg2, arg3, arg4, arg5)
end

function PMPI_File_iwrite(arg1, arg2, arg3, arg4, arg5)
    ccall((:PMPI_File_iwrite, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), arg1, arg2, arg3, arg4, arg5)
end

function PMPI_File_seek(arg1, arg2, arg3)
    ccall((:PMPI_File_seek, libmpi), Cint, (MPI_File, MPI_Offset, Cint), arg1, arg2, arg3)
end

function PMPI_File_get_position(arg1, arg2)
    ccall((:PMPI_File_get_position, libmpi), Cint, (MPI_File, Ptr{MPI_Offset}), arg1, arg2)
end

function PMPI_File_get_byte_offset(arg1, arg2, arg3)
    ccall((:PMPI_File_get_byte_offset, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{MPI_Offset}), arg1, arg2, arg3)
end

function PMPI_File_read_shared(arg1, arg2, arg3, arg4, arg5)
    ccall((:PMPI_File_read_shared, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), arg1, arg2, arg3, arg4, arg5)
end

function PMPI_File_write_shared(arg1, arg2, arg3, arg4, arg5)
    ccall((:PMPI_File_write_shared, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), arg1, arg2, arg3, arg4, arg5)
end

function PMPI_File_iread_shared(arg1, arg2, arg3, arg4, arg5)
    ccall((:PMPI_File_iread_shared, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), arg1, arg2, arg3, arg4, arg5)
end

function PMPI_File_iwrite_shared(arg1, arg2, arg3, arg4, arg5)
    ccall((:PMPI_File_iwrite_shared, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), arg1, arg2, arg3, arg4, arg5)
end

function PMPI_File_read_ordered(arg1, arg2, arg3, arg4, arg5)
    ccall((:PMPI_File_read_ordered, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), arg1, arg2, arg3, arg4, arg5)
end

function PMPI_File_write_ordered(arg1, arg2, arg3, arg4, arg5)
    ccall((:PMPI_File_write_ordered, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Status}), arg1, arg2, arg3, arg4, arg5)
end

function PMPI_File_seek_shared(arg1, arg2, arg3)
    ccall((:PMPI_File_seek_shared, libmpi), Cint, (MPI_File, MPI_Offset, Cint), arg1, arg2, arg3)
end

function PMPI_File_get_position_shared(arg1, arg2)
    ccall((:PMPI_File_get_position_shared, libmpi), Cint, (MPI_File, Ptr{MPI_Offset}), arg1, arg2)
end

function PMPI_File_read_at_all_begin(arg1, arg2, arg3, arg4, arg5)
    ccall((:PMPI_File_read_at_all_begin, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype), arg1, arg2, arg3, arg4, arg5)
end

function PMPI_File_read_at_all_end(arg1, arg2, arg3)
    ccall((:PMPI_File_read_at_all_end, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Ptr{MPI_Status}), arg1, arg2, arg3)
end

function PMPI_File_write_at_all_begin(arg1, arg2, arg3, arg4, arg5)
    ccall((:PMPI_File_write_at_all_begin, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype), arg1, arg2, arg3, arg4, arg5)
end

function PMPI_File_write_at_all_end(arg1, arg2, arg3)
    ccall((:PMPI_File_write_at_all_end, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Ptr{MPI_Status}), arg1, arg2, arg3)
end

function PMPI_File_read_all_begin(arg1, arg2, arg3, arg4)
    ccall((:PMPI_File_read_all_begin, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype), arg1, arg2, arg3, arg4)
end

function PMPI_File_read_all_end(arg1, arg2, arg3)
    ccall((:PMPI_File_read_all_end, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Ptr{MPI_Status}), arg1, arg2, arg3)
end

function PMPI_File_write_all_begin(arg1, arg2, arg3, arg4)
    ccall((:PMPI_File_write_all_begin, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype), arg1, arg2, arg3, arg4)
end

function PMPI_File_write_all_end(arg1, arg2, arg3)
    ccall((:PMPI_File_write_all_end, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Ptr{MPI_Status}), arg1, arg2, arg3)
end

function PMPI_File_read_ordered_begin(arg1, arg2, arg3, arg4)
    ccall((:PMPI_File_read_ordered_begin, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype), arg1, arg2, arg3, arg4)
end

function PMPI_File_read_ordered_end(arg1, arg2, arg3)
    ccall((:PMPI_File_read_ordered_end, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Ptr{MPI_Status}), arg1, arg2, arg3)
end

function PMPI_File_write_ordered_begin(arg1, arg2, arg3, arg4)
    ccall((:PMPI_File_write_ordered_begin, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype), arg1, arg2, arg3, arg4)
end

function PMPI_File_write_ordered_end(arg1, arg2, arg3)
    ccall((:PMPI_File_write_ordered_end, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Ptr{MPI_Status}), arg1, arg2, arg3)
end

function PMPI_File_get_type_extent(arg1, arg2, arg3)
    ccall((:PMPI_File_get_type_extent, libmpi), Cint, (MPI_File, MPI_Datatype, Ptr{MPI_Aint}), arg1, arg2, arg3)
end

function PMPI_Register_datarep(arg1, arg2, arg3, arg4, arg5)
    ccall((:PMPI_Register_datarep, libmpi), Cint, (Ptr{Cchar}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}), arg1, arg2, arg3, arg4, arg5)
end

function PMPI_File_set_atomicity(arg1, arg2)
    ccall((:PMPI_File_set_atomicity, libmpi), Cint, (MPI_File, Cint), arg1, arg2)
end

function PMPI_File_get_atomicity(arg1, arg2)
    ccall((:PMPI_File_get_atomicity, libmpi), Cint, (MPI_File, Ptr{Cint}), arg1, arg2)
end

function PMPI_File_sync(arg1)
    ccall((:PMPI_File_sync, libmpi), Cint, (MPI_File,), arg1)
end

function PMPI_File_iread_at_all(fh, offset, buf, count, datatype, request)
    ccall((:PMPI_File_iread_at_all, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

function PMPI_File_iwrite_at_all(fh, offset, buf, count, datatype, request)
    ccall((:PMPI_File_iwrite_at_all, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

function PMPI_File_iread_all(fh, buf, count, datatype, request)
    ccall((:PMPI_File_iread_all, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

function PMPI_File_iwrite_all(fh, buf, count, datatype, request)
    ccall((:PMPI_File_iwrite_all, libmpi), Cint, (MPI_File, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

function PMPI_File_read_c(fh, buf, count, datatype, status)
    ccall((:PMPI_File_read_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function PMPI_File_read_all_c(fh, buf, count, datatype, status)
    ccall((:PMPI_File_read_all_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function PMPI_File_read_all_begin_c(fh, buf, count, datatype)
    ccall((:PMPI_File_read_all_begin_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype), fh, buf, count, datatype)
end

function PMPI_File_read_at_c(fh, offset, buf, count, datatype, status)
    ccall((:PMPI_File_read_at_c, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

function PMPI_File_read_at_all_c(fh, offset, buf, count, datatype, status)
    ccall((:PMPI_File_read_at_all_c, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

function PMPI_File_read_at_all_begin_c(fh, offset, buf, count, datatype)
    ccall((:PMPI_File_read_at_all_begin_c, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, MPI_Count, MPI_Datatype), fh, offset, buf, count, datatype)
end

function PMPI_File_read_ordered_c(fh, buf, count, datatype, status)
    ccall((:PMPI_File_read_ordered_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function PMPI_File_read_ordered_begin_c(fh, buf, count, datatype)
    ccall((:PMPI_File_read_ordered_begin_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype), fh, buf, count, datatype)
end

function PMPI_File_read_shared_c(fh, buf, count, datatype, status)
    ccall((:PMPI_File_read_shared_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function PMPI_File_write_c(fh, buf, count, datatype, status)
    ccall((:PMPI_File_write_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function PMPI_File_write_all_c(fh, buf, count, datatype, status)
    ccall((:PMPI_File_write_all_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function PMPI_File_write_all_begin_c(fh, buf, count, datatype)
    ccall((:PMPI_File_write_all_begin_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype), fh, buf, count, datatype)
end

function PMPI_File_write_at_c(fh, offset, buf, count, datatype, status)
    ccall((:PMPI_File_write_at_c, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

function PMPI_File_write_at_all_c(fh, offset, buf, count, datatype, status)
    ccall((:PMPI_File_write_at_all_c, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

function PMPI_File_write_at_all_begin_c(fh, offset, buf, count, datatype)
    ccall((:PMPI_File_write_at_all_begin_c, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, MPI_Count, MPI_Datatype), fh, offset, buf, count, datatype)
end

function PMPI_File_write_ordered_c(fh, buf, count, datatype, status)
    ccall((:PMPI_File_write_ordered_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function PMPI_File_write_ordered_begin_c(fh, buf, count, datatype)
    ccall((:PMPI_File_write_ordered_begin_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype), fh, buf, count, datatype)
end

function PMPI_File_write_shared_c(fh, buf, count, datatype, status)
    ccall((:PMPI_File_write_shared_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

function PMPI_File_iread_c(fh, buf, count, datatype, request)
    ccall((:PMPI_File_iread_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

function PMPI_File_iread_all_c(fh, buf, count, datatype, request)
    ccall((:PMPI_File_iread_all_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

function PMPI_File_iread_at_c(fh, offset, buf, count, datatype, request)
    ccall((:PMPI_File_iread_at_c, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

function PMPI_File_iread_at_all_c(fh, offset, buf, count, datatype, request)
    ccall((:PMPI_File_iread_at_all_c, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

function PMPI_File_iread_shared_c(fh, buf, count, datatype, request)
    ccall((:PMPI_File_iread_shared_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

function PMPI_File_iwrite_c(fh, buf, count, datatype, request)
    ccall((:PMPI_File_iwrite_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

function PMPI_File_iwrite_all_c(fh, buf, count, datatype, request)
    ccall((:PMPI_File_iwrite_all_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

function PMPI_File_iwrite_at_c(fh, offset, buf, count, datatype, request)
    ccall((:PMPI_File_iwrite_at_c, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

function PMPI_File_iwrite_at_all_c(fh, offset, buf, count, datatype, request)
    ccall((:PMPI_File_iwrite_at_all_c, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

function PMPI_File_iwrite_shared_c(fh, buf, count, datatype, request)
    ccall((:PMPI_File_iwrite_shared_c, libmpi), Cint, (MPI_File, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

function PMPI_File_get_type_extent_c(fh, datatype, extent)
    ccall((:PMPI_File_get_type_extent_c, libmpi), Cint, (MPI_File, MPI_Datatype, Ptr{MPI_Count}), fh, datatype, extent)
end

function PMPI_Register_datarep_c(datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)
    ccall((:PMPI_Register_datarep_c, libmpi), Cint, (Ptr{Cchar}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}), datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)
end

function PMPI_File_f2c(arg1)
    ccall((:PMPI_File_f2c, libmpi), MPI_File, (MPI_Fint,), arg1)
end

function PMPI_File_c2f(arg1)
    ccall((:PMPI_File_c2f, libmpi), MPI_Fint, (MPI_File,), arg1)
end

function MPI_Status_c2f(c_status, f_status)
    ccall((:MPI_Status_c2f, libmpi), Cint, (Ptr{MPI_Status}, Ptr{MPI_Fint}), c_status, f_status)
end

function MPI_Status_f2c(f_status, c_status)
    ccall((:MPI_Status_f2c, libmpi), Cint, (Ptr{MPI_Fint}, Ptr{MPI_Status}), f_status, c_status)
end

function MPI_Status_f082c(f08_status, c_status)
    ccall((:MPI_Status_f082c, libmpi), Cint, (Ptr{MPI_F08_status}, Ptr{MPI_Status}), f08_status, c_status)
end

function MPI_Status_c2f08(c_status, f08_status)
    ccall((:MPI_Status_c2f08, libmpi), Cint, (Ptr{MPI_Status}, Ptr{MPI_F08_status}), c_status, f08_status)
end

function MPI_Status_f082f(f08_status, f_status)
    ccall((:MPI_Status_f082f, libmpi), Cint, (Ptr{MPI_F08_status}, Ptr{MPI_Fint}), f08_status, f_status)
end

function MPI_Status_f2f08(f_status, f08_status)
    ccall((:MPI_Status_f2f08, libmpi), Cint, (Ptr{MPI_Fint}, Ptr{MPI_F08_status}), f_status, f08_status)
end

function MPI_Type_create_f90_integer(r, newtype)
    ccall((:MPI_Type_create_f90_integer, libmpi), Cint, (Cint, Ptr{MPI_Datatype}), r, newtype)
end

function MPI_Type_create_f90_real(p, r, newtype)
    ccall((:MPI_Type_create_f90_real, libmpi), Cint, (Cint, Cint, Ptr{MPI_Datatype}), p, r, newtype)
end

function MPI_Type_create_f90_complex(p, r, newtype)
    ccall((:MPI_Type_create_f90_complex, libmpi), Cint, (Cint, Cint, Ptr{MPI_Datatype}), p, r, newtype)
end

function MPI_Attr_delete(comm, keyval)
    ccall((:MPI_Attr_delete, libmpi), Cint, (MPI_Comm, Cint), comm, keyval)
end

function MPI_Attr_get(comm, keyval, attribute_val, flag)
    ccall((:MPI_Attr_get, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cvoid}, Ptr{Cint}), comm, keyval, attribute_val, flag)
end

function MPI_Attr_put(comm, keyval, attribute_val)
    ccall((:MPI_Attr_put, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cvoid}), comm, keyval, attribute_val)
end

function MPI_Comm_create_keyval(comm_copy_attr_fn, comm_delete_attr_fn, comm_keyval, extra_state)
    ccall((:MPI_Comm_create_keyval, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cvoid}), comm_copy_attr_fn, comm_delete_attr_fn, comm_keyval, extra_state)
end

function MPI_Comm_delete_attr(comm, comm_keyval)
    ccall((:MPI_Comm_delete_attr, libmpi), Cint, (MPI_Comm, Cint), comm, comm_keyval)
end

function MPI_Comm_free_keyval(comm_keyval)
    ccall((:MPI_Comm_free_keyval, libmpi), Cint, (Ptr{Cint},), comm_keyval)
end

function MPI_Comm_get_attr(comm, comm_keyval, attribute_val, flag)
    ccall((:MPI_Comm_get_attr, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cvoid}, Ptr{Cint}), comm, comm_keyval, attribute_val, flag)
end

function MPI_Comm_set_attr(comm, comm_keyval, attribute_val)
    ccall((:MPI_Comm_set_attr, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cvoid}), comm, comm_keyval, attribute_val)
end

function MPI_Keyval_create(copy_fn, delete_fn, keyval, extra_state)
    ccall((:MPI_Keyval_create, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cvoid}), copy_fn, delete_fn, keyval, extra_state)
end

function MPI_Keyval_free(keyval)
    ccall((:MPI_Keyval_free, libmpi), Cint, (Ptr{Cint},), keyval)
end

function MPI_Type_create_keyval(type_copy_attr_fn, type_delete_attr_fn, type_keyval, extra_state)
    ccall((:MPI_Type_create_keyval, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cvoid}), type_copy_attr_fn, type_delete_attr_fn, type_keyval, extra_state)
end

function MPI_Type_delete_attr(datatype, type_keyval)
    ccall((:MPI_Type_delete_attr, libmpi), Cint, (MPI_Datatype, Cint), datatype, type_keyval)
end

function MPI_Type_free_keyval(type_keyval)
    ccall((:MPI_Type_free_keyval, libmpi), Cint, (Ptr{Cint},), type_keyval)
end

function MPI_Type_get_attr(datatype, type_keyval, attribute_val, flag)
    ccall((:MPI_Type_get_attr, libmpi), Cint, (MPI_Datatype, Cint, Ptr{Cvoid}, Ptr{Cint}), datatype, type_keyval, attribute_val, flag)
end

function MPI_Type_set_attr(datatype, type_keyval, attribute_val)
    ccall((:MPI_Type_set_attr, libmpi), Cint, (MPI_Datatype, Cint, Ptr{Cvoid}), datatype, type_keyval, attribute_val)
end

function MPI_Win_create_keyval(win_copy_attr_fn, win_delete_attr_fn, win_keyval, extra_state)
    ccall((:MPI_Win_create_keyval, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cvoid}), win_copy_attr_fn, win_delete_attr_fn, win_keyval, extra_state)
end

function MPI_Win_delete_attr(win, win_keyval)
    ccall((:MPI_Win_delete_attr, libmpi), Cint, (MPI_Win, Cint), win, win_keyval)
end

function MPI_Win_free_keyval(win_keyval)
    ccall((:MPI_Win_free_keyval, libmpi), Cint, (Ptr{Cint},), win_keyval)
end

function MPI_Win_get_attr(win, win_keyval, attribute_val, flag)
    ccall((:MPI_Win_get_attr, libmpi), Cint, (MPI_Win, Cint, Ptr{Cvoid}, Ptr{Cint}), win, win_keyval, attribute_val, flag)
end

function MPI_Win_set_attr(win, win_keyval, attribute_val)
    ccall((:MPI_Win_set_attr, libmpi), Cint, (MPI_Win, Cint, Ptr{Cvoid}), win, win_keyval, attribute_val)
end

function MPI_Allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:MPI_Allgather, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function MPI_Allgather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    ccall((:MPI_Allgather_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

function MPI_Allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    ccall((:MPI_Allgatherv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

function MPI_Allgatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    ccall((:MPI_Allgatherv_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
end

function MPI_Allreduce(sendbuf, recvbuf, count, datatype, op, comm)
    ccall((:MPI_Allreduce, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

function MPI_Allreduce_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    ccall((:MPI_Allreduce_init, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

function MPI_Alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:MPI_Alltoall, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function MPI_Alltoall_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    ccall((:MPI_Alltoall_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

function MPI_Alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    ccall((:MPI_Alltoallv, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

function MPI_Alltoallv_init(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    ccall((:MPI_Alltoallv_init, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
end

function MPI_Alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    ccall((:MPI_Alltoallw, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPI_Comm), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

function MPI_Alltoallw_init(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    ccall((:MPI_Alltoallw_init, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
end

function MPI_Barrier(comm)
    ccall((:MPI_Barrier, libmpi), Cint, (MPI_Comm,), comm)
end

function MPI_Barrier_init(comm, info, request)
    ccall((:MPI_Barrier_init, libmpi), Cint, (MPI_Comm, MPI_Info, Ptr{MPI_Request}), comm, info, request)
end

function MPI_Bcast(buffer, count, datatype, root, comm)
    ccall((:MPI_Bcast, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm), buffer, count, datatype, root, comm)
end

function MPI_Bcast_init(buffer, count, datatype, root, comm, info, request)
    ccall((:MPI_Bcast_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), buffer, count, datatype, root, comm, info, request)
end

function MPI_Exscan(sendbuf, recvbuf, count, datatype, op, comm)
    ccall((:MPI_Exscan, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

function MPI_Exscan_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    ccall((:MPI_Exscan_init, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

function MPI_Gather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    ccall((:MPI_Gather, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

function MPI_Gather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    ccall((:MPI_Gather_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

function MPI_Gatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
    ccall((:MPI_Gatherv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
end

function MPI_Gatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
    ccall((:MPI_Gatherv_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
end

function MPI_Iallgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:MPI_Iallgather, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function MPI_Iallgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    ccall((:MPI_Iallgatherv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

function MPI_Iallreduce(sendbuf, recvbuf, count, datatype, op, comm, request)
    ccall((:MPI_Iallreduce, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

function MPI_Ialltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:MPI_Ialltoall, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function MPI_Ialltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    ccall((:MPI_Ialltoallv, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

function MPI_Ialltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    ccall((:MPI_Ialltoallw, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

function MPI_Ibarrier(comm, request)
    ccall((:MPI_Ibarrier, libmpi), Cint, (MPI_Comm, Ptr{MPI_Request}), comm, request)
end

function MPI_Ibcast(buffer, count, datatype, root, comm, request)
    ccall((:MPI_Ibcast, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), buffer, count, datatype, root, comm, request)
end

function MPI_Iexscan(sendbuf, recvbuf, count, datatype, op, comm, request)
    ccall((:MPI_Iexscan, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

function MPI_Igather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    ccall((:MPI_Igather, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

function MPI_Igatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
    ccall((:MPI_Igatherv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
end

function MPI_Ineighbor_allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:MPI_Ineighbor_allgather, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function MPI_Ineighbor_allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    ccall((:MPI_Ineighbor_allgatherv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

function MPI_Ineighbor_alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:MPI_Ineighbor_alltoall, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function MPI_Ineighbor_alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    ccall((:MPI_Ineighbor_alltoallv, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

function MPI_Ineighbor_alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    ccall((:MPI_Ineighbor_alltoallw, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

function MPI_Ireduce(sendbuf, recvbuf, count, datatype, op, root, comm, request)
    ccall((:MPI_Ireduce, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, root, comm, request)
end

function MPI_Ireduce_scatter(sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
    ccall((:MPI_Ireduce_scatter, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
end

function MPI_Ireduce_scatter_block(sendbuf, recvbuf, recvcount, datatype, op, comm, request)
    ccall((:MPI_Ireduce_scatter_block, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, recvcount, datatype, op, comm, request)
end

function MPI_Iscan(sendbuf, recvbuf, count, datatype, op, comm, request)
    ccall((:MPI_Iscan, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

function MPI_Iscatter(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    ccall((:MPI_Iscatter, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

function MPI_Iscatterv(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    ccall((:MPI_Iscatterv, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

function MPI_Neighbor_allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:MPI_Neighbor_allgather, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function MPI_Neighbor_allgather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    ccall((:MPI_Neighbor_allgather_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

function MPI_Neighbor_allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    ccall((:MPI_Neighbor_allgatherv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

function MPI_Neighbor_allgatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    ccall((:MPI_Neighbor_allgatherv_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
end

function MPI_Neighbor_alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:MPI_Neighbor_alltoall, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function MPI_Neighbor_alltoall_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    ccall((:MPI_Neighbor_alltoall_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

function MPI_Neighbor_alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    ccall((:MPI_Neighbor_alltoallv, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

function MPI_Neighbor_alltoallv_init(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    ccall((:MPI_Neighbor_alltoallv_init, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
end

function MPI_Neighbor_alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    ccall((:MPI_Neighbor_alltoallw, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

function MPI_Neighbor_alltoallw_init(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    ccall((:MPI_Neighbor_alltoallw_init, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
end

function MPI_Reduce(sendbuf, recvbuf, count, datatype, op, root, comm)
    ccall((:MPI_Reduce, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm), sendbuf, recvbuf, count, datatype, op, root, comm)
end

function MPI_Reduce_init(sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
    ccall((:MPI_Reduce_init, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
end

function MPI_Reduce_local(inbuf, inoutbuf, count, datatype, op)
    ccall((:MPI_Reduce_local, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op), inbuf, inoutbuf, count, datatype, op)
end

function MPI_Reduce_scatter(sendbuf, recvbuf, recvcounts, datatype, op, comm)
    ccall((:MPI_Reduce_scatter, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, recvcounts, datatype, op, comm)
end

function MPI_Reduce_scatter_block(sendbuf, recvbuf, recvcount, datatype, op, comm)
    ccall((:MPI_Reduce_scatter_block, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, recvcount, datatype, op, comm)
end

function MPI_Reduce_scatter_block_init(sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
    ccall((:MPI_Reduce_scatter_block_init, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
end

function MPI_Reduce_scatter_init(sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
    ccall((:MPI_Reduce_scatter_init, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
end

function MPI_Scan(sendbuf, recvbuf, count, datatype, op, comm)
    ccall((:MPI_Scan, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

function MPI_Scan_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    ccall((:MPI_Scan_init, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

function MPI_Scatter(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    ccall((:MPI_Scatter, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

function MPI_Scatter_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    ccall((:MPI_Scatter_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

function MPI_Scatterv(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
    ccall((:MPI_Scatterv, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

function MPI_Scatterv_init(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    ccall((:MPI_Scatterv_init, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

function MPI_Comm_compare(comm1, comm2, result)
    ccall((:MPI_Comm_compare, libmpi), Cint, (MPI_Comm, MPI_Comm, Ptr{Cint}), comm1, comm2, result)
end

function MPI_Comm_create(comm, group, newcomm)
    ccall((:MPI_Comm_create, libmpi), Cint, (MPI_Comm, MPI_Group, Ptr{MPI_Comm}), comm, group, newcomm)
end

function MPI_Comm_create_group(comm, group, tag, newcomm)
    ccall((:MPI_Comm_create_group, libmpi), Cint, (MPI_Comm, MPI_Group, Cint, Ptr{MPI_Comm}), comm, group, tag, newcomm)
end

function MPI_Comm_dup(comm, newcomm)
    ccall((:MPI_Comm_dup, libmpi), Cint, (MPI_Comm, Ptr{MPI_Comm}), comm, newcomm)
end

function MPI_Comm_dup_with_info(comm, info, newcomm)
    ccall((:MPI_Comm_dup_with_info, libmpi), Cint, (MPI_Comm, MPI_Info, Ptr{MPI_Comm}), comm, info, newcomm)
end

function MPI_Comm_free(comm)
    ccall((:MPI_Comm_free, libmpi), Cint, (Ptr{MPI_Comm},), comm)
end

function MPI_Comm_get_info(comm, info_used)
    ccall((:MPI_Comm_get_info, libmpi), Cint, (MPI_Comm, Ptr{MPI_Info}), comm, info_used)
end

function MPI_Comm_get_name(comm, comm_name, resultlen)
    ccall((:MPI_Comm_get_name, libmpi), Cint, (MPI_Comm, Ptr{Cchar}, Ptr{Cint}), comm, comm_name, resultlen)
end

function MPI_Comm_group(comm, group)
    ccall((:MPI_Comm_group, libmpi), Cint, (MPI_Comm, Ptr{MPI_Group}), comm, group)
end

function MPI_Comm_idup(comm, newcomm, request)
    ccall((:MPI_Comm_idup, libmpi), Cint, (MPI_Comm, Ptr{MPI_Comm}, Ptr{MPI_Request}), comm, newcomm, request)
end

function MPI_Comm_idup_with_info(comm, info, newcomm, request)
    ccall((:MPI_Comm_idup_with_info, libmpi), Cint, (MPI_Comm, MPI_Info, Ptr{MPI_Comm}, Ptr{MPI_Request}), comm, info, newcomm, request)
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

function MPI_Comm_set_info(comm, info)
    ccall((:MPI_Comm_set_info, libmpi), Cint, (MPI_Comm, MPI_Info), comm, info)
end

function MPI_Comm_set_name(comm, comm_name)
    ccall((:MPI_Comm_set_name, libmpi), Cint, (MPI_Comm, Ptr{Cchar}), comm, comm_name)
end

function MPI_Comm_size(comm, size)
    ccall((:MPI_Comm_size, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, size)
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

function MPI_Intercomm_create(local_comm, local_leader, peer_comm, remote_leader, tag, newintercomm)
    ccall((:MPI_Intercomm_create, libmpi), Cint, (MPI_Comm, Cint, MPI_Comm, Cint, Cint, Ptr{MPI_Comm}), local_comm, local_leader, peer_comm, remote_leader, tag, newintercomm)
end

function MPI_Intercomm_create_from_groups(local_group, local_leader, remote_group, remote_leader, stringtag, info, errhandler, newintercomm)
    ccall((:MPI_Intercomm_create_from_groups, libmpi), Cint, (MPI_Group, Cint, MPI_Group, Cint, Ptr{Cchar}, MPI_Info, MPI_Errhandler, Ptr{MPI_Comm}), local_group, local_leader, remote_group, remote_leader, stringtag, info, errhandler, newintercomm)
end

function MPI_Intercomm_merge(intercomm, high, newintracomm)
    ccall((:MPI_Intercomm_merge, libmpi), Cint, (MPI_Comm, Cint, Ptr{MPI_Comm}), intercomm, high, newintracomm)
end

function MPIX_Comm_revoke(comm)
    ccall((:MPIX_Comm_revoke, libmpi), Cint, (MPI_Comm,), comm)
end

function MPIX_Comm_shrink(comm, newcomm)
    ccall((:MPIX_Comm_shrink, libmpi), Cint, (MPI_Comm, Ptr{MPI_Comm}), comm, newcomm)
end

function MPIX_Comm_failure_ack(comm)
    ccall((:MPIX_Comm_failure_ack, libmpi), Cint, (MPI_Comm,), comm)
end

function MPIX_Comm_failure_get_acked(comm, failedgrp)
    ccall((:MPIX_Comm_failure_get_acked, libmpi), Cint, (MPI_Comm, Ptr{MPI_Group}), comm, failedgrp)
end

function MPIX_Comm_agree(comm, flag)
    ccall((:MPIX_Comm_agree, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, flag)
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

function MPI_Pack(inbuf, incount, datatype, outbuf, outsize, position, comm)
    ccall((:MPI_Pack, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, Ptr{Cint}, MPI_Comm), inbuf, incount, datatype, outbuf, outsize, position, comm)
end

function MPI_Pack_external(datarep, inbuf, incount, datatype, outbuf, outsize, position)
    ccall((:MPI_Pack_external, libmpi), Cint, (Ptr{Cchar}, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, MPI_Aint, Ptr{MPI_Aint}), datarep, inbuf, incount, datatype, outbuf, outsize, position)
end

function MPI_Pack_external_size(datarep, incount, datatype, size)
    ccall((:MPI_Pack_external_size, libmpi), Cint, (Ptr{Cchar}, Cint, MPI_Datatype, Ptr{MPI_Aint}), datarep, incount, datatype, size)
end

function MPI_Pack_size(incount, datatype, comm, size)
    ccall((:MPI_Pack_size, libmpi), Cint, (Cint, MPI_Datatype, MPI_Comm, Ptr{Cint}), incount, datatype, comm, size)
end

function MPI_Status_set_elements(status, datatype, count)
    ccall((:MPI_Status_set_elements, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Cint), status, datatype, count)
end

function MPI_Status_set_elements_x(status, datatype, count)
    ccall((:MPI_Status_set_elements_x, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, MPI_Count), status, datatype, count)
end

function MPI_Type_commit(datatype)
    ccall((:MPI_Type_commit, libmpi), Cint, (Ptr{MPI_Datatype},), datatype)
end

function MPI_Type_contiguous(count, oldtype, newtype)
    ccall((:MPI_Type_contiguous, libmpi), Cint, (Cint, MPI_Datatype, Ptr{MPI_Datatype}), count, oldtype, newtype)
end

function MPI_Type_create_darray(size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
    ccall((:MPI_Type_create_darray, libmpi), Cint, (Cint, Cint, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
end

function MPI_Type_create_hindexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    ccall((:MPI_Type_create_hindexed, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

function MPI_Type_create_hindexed_block(count, blocklength, array_of_displacements, oldtype, newtype)
    ccall((:MPI_Type_create_hindexed_block, libmpi), Cint, (Cint, Cint, Ptr{MPI_Aint}, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, array_of_displacements, oldtype, newtype)
end

function MPI_Type_create_hvector(count, blocklength, stride, oldtype, newtype)
    ccall((:MPI_Type_create_hvector, libmpi), Cint, (Cint, Cint, MPI_Aint, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

function MPI_Type_create_indexed_block(count, blocklength, array_of_displacements, oldtype, newtype)
    ccall((:MPI_Type_create_indexed_block, libmpi), Cint, (Cint, Cint, Ptr{Cint}, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, array_of_displacements, oldtype, newtype)
end

function MPI_Type_create_resized(oldtype, lb, extent, newtype)
    ccall((:MPI_Type_create_resized, libmpi), Cint, (MPI_Datatype, MPI_Aint, MPI_Aint, Ptr{MPI_Datatype}), oldtype, lb, extent, newtype)
end

function MPI_Type_create_struct(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
    ccall((:MPI_Type_create_struct, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
end

function MPI_Type_create_subarray(ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
    ccall((:MPI_Type_create_subarray, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
end

function MPI_Type_dup(oldtype, newtype)
    ccall((:MPI_Type_dup, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Datatype}), oldtype, newtype)
end

function MPI_Type_free(datatype)
    ccall((:MPI_Type_free, libmpi), Cint, (Ptr{MPI_Datatype},), datatype)
end

function MPI_Type_get_contents(datatype, max_integers, max_addresses, max_datatypes, array_of_integers, array_of_addresses, array_of_datatypes)
    ccall((:MPI_Type_get_contents, libmpi), Cint, (MPI_Datatype, Cint, Cint, Cint, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}), datatype, max_integers, max_addresses, max_datatypes, array_of_integers, array_of_addresses, array_of_datatypes)
end

function MPI_Type_get_envelope(datatype, num_integers, num_addresses, num_datatypes, combiner)
    ccall((:MPI_Type_get_envelope, libmpi), Cint, (MPI_Datatype, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), datatype, num_integers, num_addresses, num_datatypes, combiner)
end

function MPI_Type_get_extent(datatype, lb, extent)
    ccall((:MPI_Type_get_extent, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Aint}, Ptr{MPI_Aint}), datatype, lb, extent)
end

function MPI_Type_get_extent_x(datatype, lb, extent)
    ccall((:MPI_Type_get_extent_x, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), datatype, lb, extent)
end

function MPI_Type_get_name(datatype, type_name, resultlen)
    ccall((:MPI_Type_get_name, libmpi), Cint, (MPI_Datatype, Ptr{Cchar}, Ptr{Cint}), datatype, type_name, resultlen)
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

function MPI_Type_match_size(typeclass, size, datatype)
    ccall((:MPI_Type_match_size, libmpi), Cint, (Cint, Cint, Ptr{MPI_Datatype}), typeclass, size, datatype)
end

function MPI_Type_set_name(datatype, type_name)
    ccall((:MPI_Type_set_name, libmpi), Cint, (MPI_Datatype, Ptr{Cchar}), datatype, type_name)
end

function MPI_Type_size(datatype, size)
    ccall((:MPI_Type_size, libmpi), Cint, (MPI_Datatype, Ptr{Cint}), datatype, size)
end

function MPI_Type_size_x(datatype, size)
    ccall((:MPI_Type_size_x, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}), datatype, size)
end

function MPI_Type_vector(count, blocklength, stride, oldtype, newtype)
    ccall((:MPI_Type_vector, libmpi), Cint, (Cint, Cint, Cint, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

function MPI_Unpack(inbuf, insize, position, outbuf, outcount, datatype, comm)
    ccall((:MPI_Unpack, libmpi), Cint, (Ptr{Cvoid}, Cint, Ptr{Cint}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm), inbuf, insize, position, outbuf, outcount, datatype, comm)
end

function MPI_Unpack_external(datarep, inbuf, insize, position, outbuf, outcount, datatype)
    ccall((:MPI_Unpack_external, libmpi), Cint, (Ptr{Cchar}, Ptr{Cvoid}, MPI_Aint, Ptr{MPI_Aint}, Ptr{Cvoid}, Cint, MPI_Datatype), datarep, inbuf, insize, position, outbuf, outcount, datatype)
end

function MPI_Address(location, address)
    ccall((:MPI_Address, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Aint}), location, address)
end

function MPI_Type_extent(datatype, extent)
    ccall((:MPI_Type_extent, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Aint}), datatype, extent)
end

function MPI_Type_lb(datatype, displacement)
    ccall((:MPI_Type_lb, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Aint}), datatype, displacement)
end

function MPI_Type_ub(datatype, displacement)
    ccall((:MPI_Type_ub, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Aint}), datatype, displacement)
end

function MPI_Type_hindexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    ccall((:MPI_Type_hindexed, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

function MPI_Type_hvector(count, blocklength, stride, oldtype, newtype)
    ccall((:MPI_Type_hvector, libmpi), Cint, (Cint, Cint, MPI_Aint, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

function MPI_Type_struct(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
    ccall((:MPI_Type_struct, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
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

function MPI_Comm_call_errhandler(comm, errorcode)
    ccall((:MPI_Comm_call_errhandler, libmpi), Cint, (MPI_Comm, Cint), comm, errorcode)
end

function MPI_Comm_create_errhandler(comm_errhandler_fn, errhandler)
    ccall((:MPI_Comm_create_errhandler, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Errhandler}), comm_errhandler_fn, errhandler)
end

function MPI_Comm_get_errhandler(comm, errhandler)
    ccall((:MPI_Comm_get_errhandler, libmpi), Cint, (MPI_Comm, Ptr{MPI_Errhandler}), comm, errhandler)
end

function MPI_Comm_set_errhandler(comm, errhandler)
    ccall((:MPI_Comm_set_errhandler, libmpi), Cint, (MPI_Comm, MPI_Errhandler), comm, errhandler)
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

function MPI_File_call_errhandler(fh, errorcode)
    ccall((:MPI_File_call_errhandler, libmpi), Cint, (MPI_File, Cint), fh, errorcode)
end

function MPI_File_create_errhandler(file_errhandler_fn, errhandler)
    ccall((:MPI_File_create_errhandler, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Errhandler}), file_errhandler_fn, errhandler)
end

function MPI_File_get_errhandler(file, errhandler)
    ccall((:MPI_File_get_errhandler, libmpi), Cint, (MPI_File, Ptr{MPI_Errhandler}), file, errhandler)
end

function MPI_File_set_errhandler(file, errhandler)
    ccall((:MPI_File_set_errhandler, libmpi), Cint, (MPI_File, MPI_Errhandler), file, errhandler)
end

function MPI_Session_call_errhandler(session, errorcode)
    ccall((:MPI_Session_call_errhandler, libmpi), Cint, (MPI_Session, Cint), session, errorcode)
end

function MPI_Session_create_errhandler(session_errhandler_fn, errhandler)
    ccall((:MPI_Session_create_errhandler, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Errhandler}), session_errhandler_fn, errhandler)
end

function MPI_Session_get_errhandler(session, errhandler)
    ccall((:MPI_Session_get_errhandler, libmpi), Cint, (MPI_Session, Ptr{MPI_Errhandler}), session, errhandler)
end

function MPI_Session_set_errhandler(session, errhandler)
    ccall((:MPI_Session_set_errhandler, libmpi), Cint, (MPI_Session, MPI_Errhandler), session, errhandler)
end

function MPI_Win_call_errhandler(win, errorcode)
    ccall((:MPI_Win_call_errhandler, libmpi), Cint, (MPI_Win, Cint), win, errorcode)
end

function MPI_Win_create_errhandler(win_errhandler_fn, errhandler)
    ccall((:MPI_Win_create_errhandler, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Errhandler}), win_errhandler_fn, errhandler)
end

function MPI_Win_get_errhandler(win, errhandler)
    ccall((:MPI_Win_get_errhandler, libmpi), Cint, (MPI_Win, Ptr{MPI_Errhandler}), win, errhandler)
end

function MPI_Win_set_errhandler(win, errhandler)
    ccall((:MPI_Win_set_errhandler, libmpi), Cint, (MPI_Win, MPI_Errhandler), win, errhandler)
end

function MPIX_Delete_error_class(errorclass)
    ccall((:MPIX_Delete_error_class, libmpi), Cint, (Cint,), errorclass)
end

function MPIX_Delete_error_code(errorcode)
    ccall((:MPIX_Delete_error_code, libmpi), Cint, (Cint,), errorcode)
end

function MPIX_Delete_error_string(errorcode)
    ccall((:MPIX_Delete_error_string, libmpi), Cint, (Cint,), errorcode)
end

function MPI_Errhandler_create(comm_errhandler_fn, errhandler)
    ccall((:MPI_Errhandler_create, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Errhandler}), comm_errhandler_fn, errhandler)
end

function MPI_Errhandler_get(comm, errhandler)
    ccall((:MPI_Errhandler_get, libmpi), Cint, (MPI_Comm, Ptr{MPI_Errhandler}), comm, errhandler)
end

function MPI_Errhandler_set(comm, errhandler)
    ccall((:MPI_Errhandler_set, libmpi), Cint, (MPI_Comm, MPI_Errhandler), comm, errhandler)
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

function MPI_Info_create(info)
    ccall((:MPI_Info_create, libmpi), Cint, (Ptr{MPI_Info},), info)
end

function MPI_Info_create_env(argc, argv, info)
    ccall((:MPI_Info_create_env, libmpi), Cint, (Cint, Ptr{Ptr{Cchar}}, Ptr{MPI_Info}), argc, argv, info)
end

function MPI_Info_delete(info, key)
    ccall((:MPI_Info_delete, libmpi), Cint, (MPI_Info, Ptr{Cchar}), info, key)
end

function MPI_Info_dup(info, newinfo)
    ccall((:MPI_Info_dup, libmpi), Cint, (MPI_Info, Ptr{MPI_Info}), info, newinfo)
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

function MPI_Info_get_string(info, key, buflen, value, flag)
    ccall((:MPI_Info_get_string, libmpi), Cint, (MPI_Info, Ptr{Cchar}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}), info, key, buflen, value, flag)
end

function MPI_Info_get_valuelen(info, key, valuelen, flag)
    ccall((:MPI_Info_get_valuelen, libmpi), Cint, (MPI_Info, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}), info, key, valuelen, flag)
end

function MPI_Info_set(info, key, value)
    ccall((:MPI_Info_set, libmpi), Cint, (MPI_Info, Ptr{Cchar}, Ptr{Cchar}), info, key, value)
end

function MPI_Abort(comm, errorcode)
    ccall((:MPI_Abort, libmpi), Cint, (MPI_Comm, Cint), comm, errorcode)
end

function MPI_Comm_create_from_group(group, stringtag, info, errhandler, newcomm)
    ccall((:MPI_Comm_create_from_group, libmpi), Cint, (MPI_Group, Ptr{Cchar}, MPI_Info, MPI_Errhandler, Ptr{MPI_Comm}), group, stringtag, info, errhandler, newcomm)
end

function MPI_Finalize()
    ccall((:MPI_Finalize, libmpi), Cint, ())
end

function MPI_Finalized(flag)
    ccall((:MPI_Finalized, libmpi), Cint, (Ptr{Cint},), flag)
end

function MPI_Group_from_session_pset(session, pset_name, newgroup)
    ccall((:MPI_Group_from_session_pset, libmpi), Cint, (MPI_Session, Ptr{Cchar}, Ptr{MPI_Group}), session, pset_name, newgroup)
end

function MPI_Init(argc, argv)
    ccall((:MPI_Init, libmpi), Cint, (Ptr{Cint}, Ptr{Ptr{Ptr{Cchar}}}), argc, argv)
end

function MPI_Init_thread(argc, argv, required, provided)
    ccall((:MPI_Init_thread, libmpi), Cint, (Ptr{Cint}, Ptr{Ptr{Ptr{Cchar}}}, Cint, Ptr{Cint}), argc, argv, required, provided)
end

function MPI_Initialized(flag)
    ccall((:MPI_Initialized, libmpi), Cint, (Ptr{Cint},), flag)
end

function MPI_Is_thread_main(flag)
    ccall((:MPI_Is_thread_main, libmpi), Cint, (Ptr{Cint},), flag)
end

function MPI_Query_thread(provided)
    ccall((:MPI_Query_thread, libmpi), Cint, (Ptr{Cint},), provided)
end

function MPI_Session_finalize(session)
    ccall((:MPI_Session_finalize, libmpi), Cint, (Ptr{MPI_Session},), session)
end

function MPI_Session_get_info(session, info_used)
    ccall((:MPI_Session_get_info, libmpi), Cint, (MPI_Session, Ptr{MPI_Info}), session, info_used)
end

function MPI_Session_get_nth_pset(session, info, n, pset_len, pset_name)
    ccall((:MPI_Session_get_nth_pset, libmpi), Cint, (MPI_Session, MPI_Info, Cint, Ptr{Cint}, Ptr{Cchar}), session, info, n, pset_len, pset_name)
end

function MPI_Session_get_num_psets(session, info, npset_names)
    ccall((:MPI_Session_get_num_psets, libmpi), Cint, (MPI_Session, MPI_Info, Ptr{Cint}), session, info, npset_names)
end

function MPI_Session_get_pset_info(session, pset_name, info)
    ccall((:MPI_Session_get_pset_info, libmpi), Cint, (MPI_Session, Ptr{Cchar}, Ptr{MPI_Info}), session, pset_name, info)
end

function MPI_Session_init(info, errhandler, session)
    ccall((:MPI_Session_init, libmpi), Cint, (MPI_Info, MPI_Errhandler, Ptr{MPI_Session}), info, errhandler, session)
end

function MPI_Aint_add(base, disp)
    ccall((:MPI_Aint_add, libmpi), MPI_Aint, (MPI_Aint, MPI_Aint), base, disp)
end

function MPI_Aint_diff(addr1, addr2)
    ccall((:MPI_Aint_diff, libmpi), MPI_Aint, (MPI_Aint, MPI_Aint), addr1, addr2)
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

function MPIX_GPU_query_support(gpu_type, is_supported)
    ccall((:MPIX_GPU_query_support, libmpi), Cint, (Cint, Ptr{Cint}), gpu_type, is_supported)
end

function MPIX_Query_cuda_support()
    ccall((:MPIX_Query_cuda_support, libmpi), Cint, ())
end

function MPIX_Query_ze_support()
    ccall((:MPIX_Query_ze_support, libmpi), Cint, ())
end

function MPIX_Query_hip_support()
    ccall((:MPIX_Query_hip_support, libmpi), Cint, ())
end

function MPI_Op_commutative(op, commute)
    ccall((:MPI_Op_commutative, libmpi), Cint, (MPI_Op, Ptr{Cint}), op, commute)
end

function MPI_Op_create(user_fn, commute, op)
    ccall((:MPI_Op_create, libmpi), Cint, (Ptr{Cvoid}, Cint, Ptr{MPI_Op}), user_fn, commute, op)
end

function MPI_Op_free(op)
    ccall((:MPI_Op_free, libmpi), Cint, (Ptr{MPI_Op},), op)
end

function MPI_Parrived(request, partition, flag)
    ccall((:MPI_Parrived, libmpi), Cint, (MPI_Request, Cint, Ptr{Cint}), request, partition, flag)
end

function MPI_Pready(partition, request)
    ccall((:MPI_Pready, libmpi), Cint, (Cint, MPI_Request), partition, request)
end

function MPI_Pready_list(length, array_of_partitions, request)
    ccall((:MPI_Pready_list, libmpi), Cint, (Cint, Ptr{Cint}, MPI_Request), length, array_of_partitions, request)
end

function MPI_Pready_range(partition_low, partition_high, request)
    ccall((:MPI_Pready_range, libmpi), Cint, (Cint, Cint, MPI_Request), partition_low, partition_high, request)
end

function MPI_Precv_init(buf, partitions, count, datatype, dest, tag, comm, info, request)
    ccall((:MPI_Precv_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), buf, partitions, count, datatype, dest, tag, comm, info, request)
end

function MPI_Psend_init(buf, partitions, count, datatype, dest, tag, comm, info, request)
    ccall((:MPI_Psend_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), buf, partitions, count, datatype, dest, tag, comm, info, request)
end

function MPI_Bsend(buf, count, datatype, dest, tag, comm)
    ccall((:MPI_Bsend, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

function MPI_Bsend_init(buf, count, datatype, dest, tag, comm, request)
    ccall((:MPI_Bsend_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function MPI_Buffer_attach(buffer, size)
    ccall((:MPI_Buffer_attach, libmpi), Cint, (Ptr{Cvoid}, Cint), buffer, size)
end

function MPI_Buffer_detach(buffer_addr, size)
    ccall((:MPI_Buffer_detach, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}), buffer_addr, size)
end

function MPI_Ibsend(buf, count, datatype, dest, tag, comm, request)
    ccall((:MPI_Ibsend, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function MPI_Improbe(source, tag, comm, flag, message, status)
    ccall((:MPI_Improbe, libmpi), Cint, (Cint, Cint, MPI_Comm, Ptr{Cint}, Ptr{MPI_Message}, Ptr{MPI_Status}), source, tag, comm, flag, message, status)
end

function MPI_Imrecv(buf, count, datatype, message, request)
    ccall((:MPI_Imrecv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Request}), buf, count, datatype, message, request)
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

function MPI_Isendrecv(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
    ccall((:MPI_Isendrecv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
end

function MPI_Isendrecv_replace(buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
    ccall((:MPI_Isendrecv_replace, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
end

function MPI_Issend(buf, count, datatype, dest, tag, comm, request)
    ccall((:MPI_Issend, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function MPI_Mprobe(source, tag, comm, message, status)
    ccall((:MPI_Mprobe, libmpi), Cint, (Cint, Cint, MPI_Comm, Ptr{MPI_Message}, Ptr{MPI_Status}), source, tag, comm, message, status)
end

function MPI_Mrecv(buf, count, datatype, message, status)
    ccall((:MPI_Mrecv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Status}), buf, count, datatype, message, status)
end

function MPI_Probe(source, tag, comm, status)
    ccall((:MPI_Probe, libmpi), Cint, (Cint, Cint, MPI_Comm, Ptr{MPI_Status}), source, tag, comm, status)
end

function MPI_Recv(buf, count, datatype, source, tag, comm, status)
    ccall((:MPI_Recv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), buf, count, datatype, source, tag, comm, status)
end

function MPI_Recv_init(buf, count, datatype, source, tag, comm, request)
    ccall((:MPI_Recv_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, source, tag, comm, request)
end

function MPI_Rsend(buf, count, datatype, dest, tag, comm)
    ccall((:MPI_Rsend, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

function MPI_Rsend_init(buf, count, datatype, dest, tag, comm, request)
    ccall((:MPI_Rsend_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function MPI_Send(buf, count, datatype, dest, tag, comm)
    ccall((:MPI_Send, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

function MPI_Send_init(buf, count, datatype, dest, tag, comm, request)
    ccall((:MPI_Send_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function MPI_Sendrecv(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
    ccall((:MPI_Sendrecv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
end

function MPI_Sendrecv_replace(buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
    ccall((:MPI_Sendrecv_replace, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
end

function MPI_Ssend(buf, count, datatype, dest, tag, comm)
    ccall((:MPI_Ssend, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

function MPI_Ssend_init(buf, count, datatype, dest, tag, comm, request)
    ccall((:MPI_Ssend_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function MPI_Cancel(request)
    ccall((:MPI_Cancel, libmpi), Cint, (Ptr{MPI_Request},), request)
end

function MPI_Grequest_complete(request)
    ccall((:MPI_Grequest_complete, libmpi), Cint, (MPI_Request,), request)
end

function MPI_Grequest_start(query_fn, free_fn, cancel_fn, extra_state, request)
    ccall((:MPI_Grequest_start, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{MPI_Request}), query_fn, free_fn, cancel_fn, extra_state, request)
end

function MPI_Request_free(request)
    ccall((:MPI_Request_free, libmpi), Cint, (Ptr{MPI_Request},), request)
end

function MPI_Request_get_status(request, flag, status)
    ccall((:MPI_Request_get_status, libmpi), Cint, (MPI_Request, Ptr{Cint}, Ptr{MPI_Status}), request, flag, status)
end

function MPI_Start(request)
    ccall((:MPI_Start, libmpi), Cint, (Ptr{MPI_Request},), request)
end

function MPI_Startall(count, array_of_requests)
    ccall((:MPI_Startall, libmpi), Cint, (Cint, Ptr{MPI_Request}), count, array_of_requests)
end

function MPI_Status_set_cancelled(status, flag)
    ccall((:MPI_Status_set_cancelled, libmpi), Cint, (Ptr{MPI_Status}, Cint), status, flag)
end

function MPI_Test_cancelled(status, flag)
    ccall((:MPI_Test_cancelled, libmpi), Cint, (Ptr{MPI_Status}, Ptr{Cint}), status, flag)
end

function MPI_Testall(count, array_of_requests, flag, array_of_statuses)
    ccall((:MPI_Testall, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{MPI_Status}), count, array_of_requests, flag, array_of_statuses)
end

function MPI_Testany(count, array_of_requests, indx, flag, status)
    ccall((:MPI_Testany, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Status}), count, array_of_requests, indx, flag, status)
end

function MPI_Testsome(incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
    ccall((:MPI_Testsome, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Status}), incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
end

function MPI_Waitall(count, array_of_requests, array_of_statuses)
    ccall((:MPI_Waitall, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{MPI_Status}), count, array_of_requests, array_of_statuses)
end

function MPI_Waitany(count, array_of_requests, indx, status)
    ccall((:MPI_Waitany, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{MPI_Status}), count, array_of_requests, indx, status)
end

function MPI_Waitsome(incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
    ccall((:MPI_Waitsome, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Status}), incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
end

function MPI_Accumulate(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    ccall((:MPI_Accumulate, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

function MPI_Alloc_mem(size, info, baseptr)
    ccall((:MPI_Alloc_mem, libmpi), Cint, (MPI_Aint, MPI_Info, Ptr{Cvoid}), size, info, baseptr)
end

function MPI_Compare_and_swap(origin_addr, compare_addr, result_addr, datatype, target_rank, target_disp, win)
    ccall((:MPI_Compare_and_swap, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, MPI_Datatype, Cint, MPI_Aint, MPI_Win), origin_addr, compare_addr, result_addr, datatype, target_rank, target_disp, win)
end

function MPI_Fetch_and_op(origin_addr, result_addr, datatype, target_rank, target_disp, op, win)
    ccall((:MPI_Fetch_and_op, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Datatype, Cint, MPI_Aint, MPI_Op, MPI_Win), origin_addr, result_addr, datatype, target_rank, target_disp, op, win)
end

function MPI_Free_mem(base)
    ccall((:MPI_Free_mem, libmpi), Cint, (Ptr{Cvoid},), base)
end

function MPI_Get(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    ccall((:MPI_Get, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

function MPI_Get_accumulate(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    ccall((:MPI_Get_accumulate, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win), origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

function MPI_Put(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    ccall((:MPI_Put, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

function MPI_Raccumulate(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    ccall((:MPI_Raccumulate, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

function MPI_Rget(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    ccall((:MPI_Rget, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

function MPI_Rget_accumulate(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    ccall((:MPI_Rget_accumulate, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

function MPI_Rput(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    ccall((:MPI_Rput, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
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

function MPI_Win_complete(win)
    ccall((:MPI_Win_complete, libmpi), Cint, (MPI_Win,), win)
end

function MPI_Win_create(base, size, disp_unit, info, comm, win)
    ccall((:MPI_Win_create, libmpi), Cint, (Ptr{Cvoid}, MPI_Aint, Cint, MPI_Info, MPI_Comm, Ptr{MPI_Win}), base, size, disp_unit, info, comm, win)
end

function MPI_Win_create_dynamic(info, comm, win)
    ccall((:MPI_Win_create_dynamic, libmpi), Cint, (MPI_Info, MPI_Comm, Ptr{MPI_Win}), info, comm, win)
end

function MPI_Win_detach(win, base)
    ccall((:MPI_Win_detach, libmpi), Cint, (MPI_Win, Ptr{Cvoid}), win, base)
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

function MPI_Close_port(port_name)
    ccall((:MPI_Close_port, libmpi), Cint, (Ptr{Cchar},), port_name)
end

function MPI_Comm_accept(port_name, info, root, comm, newcomm)
    ccall((:MPI_Comm_accept, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Cint, MPI_Comm, Ptr{MPI_Comm}), port_name, info, root, comm, newcomm)
end

function MPI_Comm_connect(port_name, info, root, comm, newcomm)
    ccall((:MPI_Comm_connect, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Cint, MPI_Comm, Ptr{MPI_Comm}), port_name, info, root, comm, newcomm)
end

function MPI_Comm_disconnect(comm)
    ccall((:MPI_Comm_disconnect, libmpi), Cint, (Ptr{MPI_Comm},), comm)
end

function MPI_Comm_get_parent(parent)
    ccall((:MPI_Comm_get_parent, libmpi), Cint, (Ptr{MPI_Comm},), parent)
end

function MPI_Comm_join(fd, intercomm)
    ccall((:MPI_Comm_join, libmpi), Cint, (Cint, Ptr{MPI_Comm}), fd, intercomm)
end

function MPI_Comm_spawn(command, argv, maxprocs, info, root, comm, intercomm, array_of_errcodes)
    ccall((:MPI_Comm_spawn, libmpi), Cint, (Ptr{Cchar}, Ptr{Ptr{Cchar}}, Cint, MPI_Info, Cint, MPI_Comm, Ptr{MPI_Comm}, Ptr{Cint}), command, argv, maxprocs, info, root, comm, intercomm, array_of_errcodes)
end

function MPI_Comm_spawn_multiple(count, array_of_commands, array_of_argv, array_of_maxprocs, array_of_info, root, comm, intercomm, array_of_errcodes)
    ccall((:MPI_Comm_spawn_multiple, libmpi), Cint, (Cint, Ptr{Ptr{Cchar}}, Ptr{Ptr{Ptr{Cchar}}}, Ptr{Cint}, Ptr{MPI_Info}, Cint, MPI_Comm, Ptr{MPI_Comm}, Ptr{Cint}), count, array_of_commands, array_of_argv, array_of_maxprocs, array_of_info, root, comm, intercomm, array_of_errcodes)
end

function MPI_Lookup_name(service_name, info, port_name)
    ccall((:MPI_Lookup_name, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Ptr{Cchar}), service_name, info, port_name)
end

function MPI_Open_port(info, port_name)
    ccall((:MPI_Open_port, libmpi), Cint, (MPI_Info, Ptr{Cchar}), info, port_name)
end

function MPI_Publish_name(service_name, info, port_name)
    ccall((:MPI_Publish_name, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Ptr{Cchar}), service_name, info, port_name)
end

function MPI_Unpublish_name(service_name, info, port_name)
    ccall((:MPI_Unpublish_name, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Ptr{Cchar}), service_name, info, port_name)
end

function MPI_Wtick()
    ccall((:MPI_Wtick, libmpi), Cdouble, ())
end

function MPI_Wtime()
    ccall((:MPI_Wtime, libmpi), Cdouble, ())
end

function MPI_Cart_coords(comm, rank, maxdims, coords)
    ccall((:MPI_Cart_coords, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{Cint}), comm, rank, maxdims, coords)
end

function MPI_Cart_create(comm_old, ndims, dims, periods, reorder, comm_cart)
    ccall((:MPI_Cart_create, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{MPI_Comm}), comm_old, ndims, dims, periods, reorder, comm_cart)
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

function MPI_Cart_sub(comm, remain_dims, newcomm)
    ccall((:MPI_Cart_sub, libmpi), Cint, (MPI_Comm, Ptr{Cint}, Ptr{MPI_Comm}), comm, remain_dims, newcomm)
end

function MPI_Cartdim_get(comm, ndims)
    ccall((:MPI_Cartdim_get, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, ndims)
end

function MPI_Dims_create(nnodes, ndims, dims)
    ccall((:MPI_Dims_create, libmpi), Cint, (Cint, Cint, Ptr{Cint}), nnodes, ndims, dims)
end

function MPI_Dist_graph_create(comm_old, n, sources, degrees, destinations, weights, info, reorder, comm_dist_graph)
    ccall((:MPI_Dist_graph_create, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, MPI_Info, Cint, Ptr{MPI_Comm}), comm_old, n, sources, degrees, destinations, weights, info, reorder, comm_dist_graph)
end

function MPI_Dist_graph_create_adjacent(comm_old, indegree, sources, sourceweights, outdegree, destinations, destweights, info, reorder, comm_dist_graph)
    ccall((:MPI_Dist_graph_create_adjacent, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{Cint}, Ptr{Cint}, MPI_Info, Cint, Ptr{MPI_Comm}), comm_old, indegree, sources, sourceweights, outdegree, destinations, destweights, info, reorder, comm_dist_graph)
end

function MPI_Dist_graph_neighbors(comm, maxindegree, sources, sourceweights, maxoutdegree, destinations, destweights)
    ccall((:MPI_Dist_graph_neighbors, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{Cint}, Ptr{Cint}), comm, maxindegree, sources, sourceweights, maxoutdegree, destinations, destweights)
end

function MPI_Dist_graph_neighbors_count(comm, indegree, outdegree, weighted)
    ccall((:MPI_Dist_graph_neighbors_count, libmpi), Cint, (MPI_Comm, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), comm, indegree, outdegree, weighted)
end

function MPI_Graph_create(comm_old, nnodes, indx, edges, reorder, comm_graph)
    ccall((:MPI_Graph_create, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{MPI_Comm}), comm_old, nnodes, indx, edges, reorder, comm_graph)
end

function MPI_Graph_get(comm, maxindex, maxedges, indx, edges)
    ccall((:MPI_Graph_get, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{Cint}, Ptr{Cint}), comm, maxindex, maxedges, indx, edges)
end

function MPI_Graph_map(comm, nnodes, indx, edges, newrank)
    ccall((:MPI_Graph_map, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), comm, nnodes, indx, edges, newrank)
end

function MPI_Graph_neighbors(comm, rank, maxneighbors, neighbors)
    ccall((:MPI_Graph_neighbors, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{Cint}), comm, rank, maxneighbors, neighbors)
end

function MPI_Graph_neighbors_count(comm, rank, nneighbors)
    ccall((:MPI_Graph_neighbors_count, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}), comm, rank, nneighbors)
end

function MPI_Graphdims_get(comm, nnodes, nedges)
    ccall((:MPI_Graphdims_get, libmpi), Cint, (MPI_Comm, Ptr{Cint}, Ptr{Cint}), comm, nnodes, nedges)
end

function MPI_Topo_test(comm, status)
    ccall((:MPI_Topo_test, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, status)
end

function MPI_T_category_changed(update_number)
    ccall((:MPI_T_category_changed, libmpi), Cint, (Ptr{Cint},), update_number)
end

function MPI_T_category_get_categories(cat_index, len, indices)
    ccall((:MPI_T_category_get_categories, libmpi), Cint, (Cint, Cint, Ptr{Cint}), cat_index, len, indices)
end

function MPI_T_category_get_cvars(cat_index, len, indices)
    ccall((:MPI_T_category_get_cvars, libmpi), Cint, (Cint, Cint, Ptr{Cint}), cat_index, len, indices)
end

function MPI_T_category_get_events(cat_index, len, indices)
    ccall((:MPI_T_category_get_events, libmpi), Cint, (Cint, Cint, Ptr{Cint}), cat_index, len, indices)
end

function MPI_T_category_get_index(name, cat_index)
    ccall((:MPI_T_category_get_index, libmpi), Cint, (Ptr{Cchar}, Ptr{Cint}), name, cat_index)
end

function MPI_T_category_get_info(cat_index, name, name_len, desc, desc_len, num_cvars, num_pvars, num_categories)
    ccall((:MPI_T_category_get_info, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), cat_index, name, name_len, desc, desc_len, num_cvars, num_pvars, num_categories)
end

function MPI_T_category_get_num(num_cat)
    ccall((:MPI_T_category_get_num, libmpi), Cint, (Ptr{Cint},), num_cat)
end

function MPI_T_category_get_num_events(cat_index, num_events)
    ccall((:MPI_T_category_get_num_events, libmpi), Cint, (Cint, Ptr{Cint}), cat_index, num_events)
end

function MPI_T_category_get_pvars(cat_index, len, indices)
    ccall((:MPI_T_category_get_pvars, libmpi), Cint, (Cint, Cint, Ptr{Cint}), cat_index, len, indices)
end

function MPI_T_cvar_get_index(name, cvar_index)
    ccall((:MPI_T_cvar_get_index, libmpi), Cint, (Ptr{Cchar}, Ptr{Cint}), name, cvar_index)
end

function MPI_T_cvar_get_info(cvar_index, name, name_len, verbosity, datatype, enumtype, desc, desc_len, bind, scope)
    ccall((:MPI_T_cvar_get_info, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{MPI_T_enum}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), cvar_index, name, name_len, verbosity, datatype, enumtype, desc, desc_len, bind, scope)
end

function MPI_T_cvar_get_num(num_cvar)
    ccall((:MPI_T_cvar_get_num, libmpi), Cint, (Ptr{Cint},), num_cvar)
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

function MPI_T_enum_get_info(enumtype, num, name, name_len)
    ccall((:MPI_T_enum_get_info, libmpi), Cint, (MPI_T_enum, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}), enumtype, num, name, name_len)
end

function MPI_T_enum_get_item(enumtype, indx, value, name, name_len)
    ccall((:MPI_T_enum_get_item, libmpi), Cint, (MPI_T_enum, Cint, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}), enumtype, indx, value, name, name_len)
end

function MPI_T_event_callback_get_info(event_registration, cb_safety, info_used)
    ccall((:MPI_T_event_callback_get_info, libmpi), Cint, (MPI_T_event_registration, MPI_T_cb_safety, Ptr{MPI_Info}), event_registration, cb_safety, info_used)
end

function MPI_T_event_callback_set_info(event_registration, cb_safety, info)
    ccall((:MPI_T_event_callback_set_info, libmpi), Cint, (MPI_T_event_registration, MPI_T_cb_safety, MPI_Info), event_registration, cb_safety, info)
end

function MPI_T_event_copy(event_instance, buffer)
    ccall((:MPI_T_event_copy, libmpi), Cint, (MPI_T_event_instance, Ptr{Cvoid}), event_instance, buffer)
end

function MPI_T_event_get_index(name, event_index)
    ccall((:MPI_T_event_get_index, libmpi), Cint, (Ptr{Cchar}, Ptr{Cint}), name, event_index)
end

function MPI_T_event_get_info(event_index, name, name_len, verbosity, array_of_datatypes, array_of_displacements, num_elements, enumtype, info, desc, desc_len, bind)
    ccall((:MPI_T_event_get_info, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{MPI_Aint}, Ptr{Cint}, Ptr{MPI_T_enum}, Ptr{MPI_Info}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}), event_index, name, name_len, verbosity, array_of_datatypes, array_of_displacements, num_elements, enumtype, info, desc, desc_len, bind)
end

function MPI_T_event_get_num(num_events)
    ccall((:MPI_T_event_get_num, libmpi), Cint, (Ptr{Cint},), num_events)
end

function MPI_T_event_get_source(event_instance, source_index)
    ccall((:MPI_T_event_get_source, libmpi), Cint, (MPI_T_event_instance, Ptr{Cint}), event_instance, source_index)
end

function MPI_T_event_get_timestamp(event_instance, event_timestamp)
    ccall((:MPI_T_event_get_timestamp, libmpi), Cint, (MPI_T_event_instance, Ptr{MPI_Count}), event_instance, event_timestamp)
end

function MPI_T_event_handle_alloc(event_index, obj_handle, info, event_registration)
    ccall((:MPI_T_event_handle_alloc, libmpi), Cint, (Cint, Ptr{Cvoid}, MPI_Info, Ptr{MPI_T_event_registration}), event_index, obj_handle, info, event_registration)
end

function MPI_T_event_handle_free(event_registration, user_data, free_cb_function)
    ccall((:MPI_T_event_handle_free, libmpi), Cint, (MPI_T_event_registration, Ptr{Cvoid}, MPI_T_event_free_cb_function), event_registration, user_data, free_cb_function)
end

function MPI_T_event_handle_get_info(event_registration, info_used)
    ccall((:MPI_T_event_handle_get_info, libmpi), Cint, (MPI_T_event_registration, Ptr{MPI_Info}), event_registration, info_used)
end

function MPI_T_event_handle_set_info(event_registration, info)
    ccall((:MPI_T_event_handle_set_info, libmpi), Cint, (MPI_T_event_registration, MPI_Info), event_registration, info)
end

function MPI_T_event_read(event_instance, element_index, buffer)
    ccall((:MPI_T_event_read, libmpi), Cint, (MPI_T_event_instance, Cint, Ptr{Cvoid}), event_instance, element_index, buffer)
end

function MPI_T_event_register_callback(event_registration, cb_safety, info, user_data, event_cb_function)
    ccall((:MPI_T_event_register_callback, libmpi), Cint, (MPI_T_event_registration, MPI_T_cb_safety, MPI_Info, Ptr{Cvoid}, MPI_T_event_cb_function), event_registration, cb_safety, info, user_data, event_cb_function)
end

function MPI_T_event_set_dropped_handler(event_registration, dropped_cb_function)
    ccall((:MPI_T_event_set_dropped_handler, libmpi), Cint, (MPI_T_event_registration, MPI_T_event_dropped_cb_function), event_registration, dropped_cb_function)
end

function MPI_T_finalize()
    ccall((:MPI_T_finalize, libmpi), Cint, ())
end

function MPI_T_init_thread(required, provided)
    ccall((:MPI_T_init_thread, libmpi), Cint, (Cint, Ptr{Cint}), required, provided)
end

function MPI_T_pvar_get_index(name, var_class, pvar_index)
    ccall((:MPI_T_pvar_get_index, libmpi), Cint, (Ptr{Cchar}, Cint, Ptr{Cint}), name, var_class, pvar_index)
end

function MPI_T_pvar_get_info(pvar_index, name, name_len, verbosity, var_class, datatype, enumtype, desc, desc_len, bind, readonly, continuous, atomic)
    ccall((:MPI_T_pvar_get_info, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{MPI_T_enum}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), pvar_index, name, name_len, verbosity, var_class, datatype, enumtype, desc, desc_len, bind, readonly, continuous, atomic)
end

function MPI_T_pvar_get_num(num_pvar)
    ccall((:MPI_T_pvar_get_num, libmpi), Cint, (Ptr{Cint},), num_pvar)
end

function MPI_T_pvar_handle_alloc(session, pvar_index, obj_handle, handle, count)
    ccall((:MPI_T_pvar_handle_alloc, libmpi), Cint, (MPI_T_pvar_session, Cint, Ptr{Cvoid}, Ptr{MPI_T_pvar_handle}, Ptr{Cint}), session, pvar_index, obj_handle, handle, count)
end

function MPI_T_pvar_handle_free(session, handle)
    ccall((:MPI_T_pvar_handle_free, libmpi), Cint, (MPI_T_pvar_session, Ptr{MPI_T_pvar_handle}), session, handle)
end

function MPI_T_pvar_read(session, handle, buf)
    ccall((:MPI_T_pvar_read, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle, Ptr{Cvoid}), session, handle, buf)
end

function MPI_T_pvar_readreset(session, handle, buf)
    ccall((:MPI_T_pvar_readreset, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle, Ptr{Cvoid}), session, handle, buf)
end

function MPI_T_pvar_reset(session, handle)
    ccall((:MPI_T_pvar_reset, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle), session, handle)
end

function MPI_T_pvar_session_create(session)
    ccall((:MPI_T_pvar_session_create, libmpi), Cint, (Ptr{MPI_T_pvar_session},), session)
end

function MPI_T_pvar_session_free(session)
    ccall((:MPI_T_pvar_session_free, libmpi), Cint, (Ptr{MPI_T_pvar_session},), session)
end

function MPI_T_pvar_start(session, handle)
    ccall((:MPI_T_pvar_start, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle), session, handle)
end

function MPI_T_pvar_stop(session, handle)
    ccall((:MPI_T_pvar_stop, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle), session, handle)
end

function MPI_T_pvar_write(session, handle, buf)
    ccall((:MPI_T_pvar_write, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle, Ptr{Cvoid}), session, handle, buf)
end

function MPI_T_source_get_info(source_index, name, name_len, desc, desc_len, ordering, ticks_per_second, max_ticks, info)
    ccall((:MPI_T_source_get_info, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}, Ptr{MPI_T_source_order}, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Info}), source_index, name, name_len, desc, desc_len, ordering, ticks_per_second, max_ticks, info)
end

function MPI_T_source_get_num(num_sources)
    ccall((:MPI_T_source_get_num, libmpi), Cint, (Ptr{Cint},), num_sources)
end

function MPI_T_source_get_timestamp(source_index, timestamp)
    ccall((:MPI_T_source_get_timestamp, libmpi), Cint, (Cint, Ptr{MPI_Count}), source_index, timestamp)
end

function MPIX_Grequest_start(query_fn, free_fn, cancel_fn, poll_fn, wait_fn, extra_state, request)
    ccall((:MPIX_Grequest_start, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{MPI_Request}), query_fn, free_fn, cancel_fn, poll_fn, wait_fn, extra_state, request)
end

function MPIX_Grequest_class_create(query_fn, free_fn, cancel_fn, poll_fn, wait_fn, greq_class)
    ccall((:MPIX_Grequest_class_create, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{MPIX_Grequest_class}), query_fn, free_fn, cancel_fn, poll_fn, wait_fn, greq_class)
end

function MPIX_Grequest_class_allocate(greq_class, extra_state, request)
    ccall((:MPIX_Grequest_class_allocate, libmpi), Cint, (MPIX_Grequest_class, Ptr{Cvoid}, Ptr{MPI_Request}), greq_class, extra_state, request)
end

function MPI_Allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:MPI_Allgather_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function MPI_Allgather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    ccall((:MPI_Allgather_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

function MPI_Allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    ccall((:MPI_Allgatherv_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

function MPI_Allgatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    ccall((:MPI_Allgatherv_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
end

function MPI_Allreduce_c(sendbuf, recvbuf, count, datatype, op, comm)
    ccall((:MPI_Allreduce_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

function MPI_Allreduce_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    ccall((:MPI_Allreduce_init_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

function MPI_Alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:MPI_Alltoall_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function MPI_Alltoall_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    ccall((:MPI_Alltoall_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

function MPI_Alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    ccall((:MPI_Alltoallv_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

function MPI_Alltoallv_init_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    ccall((:MPI_Alltoallv_init_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
end

function MPI_Alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    ccall((:MPI_Alltoallw_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

function MPI_Alltoallw_init_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    ccall((:MPI_Alltoallw_init_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
end

function MPI_Bcast_c(buffer, count, datatype, root, comm)
    ccall((:MPI_Bcast_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm), buffer, count, datatype, root, comm)
end

function MPI_Bcast_init_c(buffer, count, datatype, root, comm, info, request)
    ccall((:MPI_Bcast_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), buffer, count, datatype, root, comm, info, request)
end

function MPI_Exscan_c(sendbuf, recvbuf, count, datatype, op, comm)
    ccall((:MPI_Exscan_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

function MPI_Exscan_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    ccall((:MPI_Exscan_init_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

function MPI_Gather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    ccall((:MPI_Gather_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

function MPI_Gather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    ccall((:MPI_Gather_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

function MPI_Gatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
    ccall((:MPI_Gatherv_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
end

function MPI_Gatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
    ccall((:MPI_Gatherv_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
end

function MPI_Iallgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:MPI_Iallgather_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function MPI_Iallgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    ccall((:MPI_Iallgatherv_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

function MPI_Iallreduce_c(sendbuf, recvbuf, count, datatype, op, comm, request)
    ccall((:MPI_Iallreduce_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

function MPI_Ialltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:MPI_Ialltoall_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function MPI_Ialltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    ccall((:MPI_Ialltoallv_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

function MPI_Ialltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    ccall((:MPI_Ialltoallw_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

function MPI_Ibcast_c(buffer, count, datatype, root, comm, request)
    ccall((:MPI_Ibcast_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), buffer, count, datatype, root, comm, request)
end

function MPI_Iexscan_c(sendbuf, recvbuf, count, datatype, op, comm, request)
    ccall((:MPI_Iexscan_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

function MPI_Igather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    ccall((:MPI_Igather_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

function MPI_Igatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
    ccall((:MPI_Igatherv_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
end

function MPI_Ineighbor_allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:MPI_Ineighbor_allgather_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function MPI_Ineighbor_allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    ccall((:MPI_Ineighbor_allgatherv_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

function MPI_Ineighbor_alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:MPI_Ineighbor_alltoall_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function MPI_Ineighbor_alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    ccall((:MPI_Ineighbor_alltoallv_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

function MPI_Ineighbor_alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    ccall((:MPI_Ineighbor_alltoallw_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

function MPI_Ireduce_c(sendbuf, recvbuf, count, datatype, op, root, comm, request)
    ccall((:MPI_Ireduce_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, root, comm, request)
end

function MPI_Ireduce_scatter_c(sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
    ccall((:MPI_Ireduce_scatter_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{MPI_Count}, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
end

function MPI_Ireduce_scatter_block_c(sendbuf, recvbuf, recvcount, datatype, op, comm, request)
    ccall((:MPI_Ireduce_scatter_block_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, recvcount, datatype, op, comm, request)
end

function MPI_Iscan_c(sendbuf, recvbuf, count, datatype, op, comm, request)
    ccall((:MPI_Iscan_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

function MPI_Iscatter_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    ccall((:MPI_Iscatter_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

function MPI_Iscatterv_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    ccall((:MPI_Iscatterv_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

function MPI_Neighbor_allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:MPI_Neighbor_allgather_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function MPI_Neighbor_allgather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    ccall((:MPI_Neighbor_allgather_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

function MPI_Neighbor_allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    ccall((:MPI_Neighbor_allgatherv_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

function MPI_Neighbor_allgatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    ccall((:MPI_Neighbor_allgatherv_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
end

function MPI_Neighbor_alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:MPI_Neighbor_alltoall_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function MPI_Neighbor_alltoall_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    ccall((:MPI_Neighbor_alltoall_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

function MPI_Neighbor_alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    ccall((:MPI_Neighbor_alltoallv_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

function MPI_Neighbor_alltoallv_init_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    ccall((:MPI_Neighbor_alltoallv_init_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
end

function MPI_Neighbor_alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    ccall((:MPI_Neighbor_alltoallw_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

function MPI_Neighbor_alltoallw_init_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    ccall((:MPI_Neighbor_alltoallw_init_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
end

function MPI_Reduce_c(sendbuf, recvbuf, count, datatype, op, root, comm)
    ccall((:MPI_Reduce_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, Cint, MPI_Comm), sendbuf, recvbuf, count, datatype, op, root, comm)
end

function MPI_Reduce_init_c(sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
    ccall((:MPI_Reduce_init_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
end

function MPI_Reduce_local_c(inbuf, inoutbuf, count, datatype, op)
    ccall((:MPI_Reduce_local_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op), inbuf, inoutbuf, count, datatype, op)
end

function MPI_Reduce_scatter_c(sendbuf, recvbuf, recvcounts, datatype, op, comm)
    ccall((:MPI_Reduce_scatter_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{MPI_Count}, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, recvcounts, datatype, op, comm)
end

function MPI_Reduce_scatter_block_c(sendbuf, recvbuf, recvcount, datatype, op, comm)
    ccall((:MPI_Reduce_scatter_block_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, recvcount, datatype, op, comm)
end

function MPI_Reduce_scatter_block_init_c(sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
    ccall((:MPI_Reduce_scatter_block_init_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
end

function MPI_Reduce_scatter_init_c(sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
    ccall((:MPI_Reduce_scatter_init_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{MPI_Count}, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
end

function MPI_Scan_c(sendbuf, recvbuf, count, datatype, op, comm)
    ccall((:MPI_Scan_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

function MPI_Scan_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    ccall((:MPI_Scan_init_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

function MPI_Scatter_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    ccall((:MPI_Scatter_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

function MPI_Scatter_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    ccall((:MPI_Scatter_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

function MPI_Scatterv_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
    ccall((:MPI_Scatterv_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

function MPI_Scatterv_init_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    ccall((:MPI_Scatterv_init_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

function MPI_Get_count_c(status, datatype, count)
    ccall((:MPI_Get_count_c, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Ptr{MPI_Count}), status, datatype, count)
end

function MPI_Get_elements_c(status, datatype, count)
    ccall((:MPI_Get_elements_c, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Ptr{MPI_Count}), status, datatype, count)
end

function MPI_Pack_c(inbuf, incount, datatype, outbuf, outsize, position, comm)
    ccall((:MPI_Pack_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, Ptr{MPI_Count}, MPI_Comm), inbuf, incount, datatype, outbuf, outsize, position, comm)
end

function MPI_Pack_external_c(datarep, inbuf, incount, datatype, outbuf, outsize, position)
    ccall((:MPI_Pack_external_c, libmpi), Cint, (Ptr{Cchar}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, Ptr{MPI_Count}), datarep, inbuf, incount, datatype, outbuf, outsize, position)
end

function MPI_Pack_external_size_c(datarep, incount, datatype, size)
    ccall((:MPI_Pack_external_size_c, libmpi), Cint, (Ptr{Cchar}, MPI_Count, MPI_Datatype, Ptr{MPI_Count}), datarep, incount, datatype, size)
end

function MPI_Pack_size_c(incount, datatype, comm, size)
    ccall((:MPI_Pack_size_c, libmpi), Cint, (MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Count}), incount, datatype, comm, size)
end

function MPI_Type_contiguous_c(count, oldtype, newtype)
    ccall((:MPI_Type_contiguous_c, libmpi), Cint, (MPI_Count, MPI_Datatype, Ptr{MPI_Datatype}), count, oldtype, newtype)
end

function MPI_Type_create_darray_c(size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
    ccall((:MPI_Type_create_darray_c, libmpi), Cint, (Cint, Cint, Cint, Ptr{MPI_Count}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
end

function MPI_Type_create_hindexed_c(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    ccall((:MPI_Type_create_hindexed_c, libmpi), Cint, (MPI_Count, Ptr{MPI_Count}, Ptr{MPI_Count}, MPI_Datatype, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

function MPI_Type_create_hindexed_block_c(count, blocklength, array_of_displacements, oldtype, newtype)
    ccall((:MPI_Type_create_hindexed_block_c, libmpi), Cint, (MPI_Count, MPI_Count, Ptr{MPI_Count}, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, array_of_displacements, oldtype, newtype)
end

function MPI_Type_create_hvector_c(count, blocklength, stride, oldtype, newtype)
    ccall((:MPI_Type_create_hvector_c, libmpi), Cint, (MPI_Count, MPI_Count, MPI_Count, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

function MPI_Type_create_indexed_block_c(count, blocklength, array_of_displacements, oldtype, newtype)
    ccall((:MPI_Type_create_indexed_block_c, libmpi), Cint, (MPI_Count, MPI_Count, Ptr{MPI_Count}, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, array_of_displacements, oldtype, newtype)
end

function MPI_Type_create_resized_c(oldtype, lb, extent, newtype)
    ccall((:MPI_Type_create_resized_c, libmpi), Cint, (MPI_Datatype, MPI_Count, MPI_Count, Ptr{MPI_Datatype}), oldtype, lb, extent, newtype)
end

function MPI_Type_create_struct_c(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
    ccall((:MPI_Type_create_struct_c, libmpi), Cint, (MPI_Count, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
end

function MPI_Type_create_subarray_c(ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
    ccall((:MPI_Type_create_subarray_c, libmpi), Cint, (Cint, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Count}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
end

function MPI_Type_get_contents_c(datatype, max_integers, max_addresses, max_large_counts, max_datatypes, array_of_integers, array_of_addresses, array_of_large_counts, array_of_datatypes)
    ccall((:MPI_Type_get_contents_c, libmpi), Cint, (MPI_Datatype, MPI_Count, MPI_Count, MPI_Count, MPI_Count, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Count}, Ptr{MPI_Datatype}), datatype, max_integers, max_addresses, max_large_counts, max_datatypes, array_of_integers, array_of_addresses, array_of_large_counts, array_of_datatypes)
end

function MPI_Type_get_envelope_c(datatype, num_integers, num_addresses, num_large_counts, num_datatypes, combiner)
    ccall((:MPI_Type_get_envelope_c, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{Cint}), datatype, num_integers, num_addresses, num_large_counts, num_datatypes, combiner)
end

function MPI_Type_get_extent_c(datatype, lb, extent)
    ccall((:MPI_Type_get_extent_c, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), datatype, lb, extent)
end

function MPI_Type_get_true_extent_c(datatype, true_lb, true_extent)
    ccall((:MPI_Type_get_true_extent_c, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), datatype, true_lb, true_extent)
end

function MPI_Type_indexed_c(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    ccall((:MPI_Type_indexed_c, libmpi), Cint, (MPI_Count, Ptr{MPI_Count}, Ptr{MPI_Count}, MPI_Datatype, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

function MPI_Type_size_c(datatype, size)
    ccall((:MPI_Type_size_c, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}), datatype, size)
end

function MPI_Type_vector_c(count, blocklength, stride, oldtype, newtype)
    ccall((:MPI_Type_vector_c, libmpi), Cint, (MPI_Count, MPI_Count, MPI_Count, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

function MPI_Unpack_c(inbuf, insize, position, outbuf, outcount, datatype, comm)
    ccall((:MPI_Unpack_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, Ptr{MPI_Count}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm), inbuf, insize, position, outbuf, outcount, datatype, comm)
end

function MPI_Unpack_external_c(datarep, inbuf, insize, position, outbuf, outcount, datatype)
    ccall((:MPI_Unpack_external_c, libmpi), Cint, (Ptr{Cchar}, Ptr{Cvoid}, MPI_Count, Ptr{MPI_Count}, Ptr{Cvoid}, MPI_Count, MPI_Datatype), datarep, inbuf, insize, position, outbuf, outcount, datatype)
end

function MPI_Op_create_c(user_fn, commute, op)
    ccall((:MPI_Op_create_c, libmpi), Cint, (Ptr{Cvoid}, Cint, Ptr{MPI_Op}), user_fn, commute, op)
end

function MPI_Bsend_c(buf, count, datatype, dest, tag, comm)
    ccall((:MPI_Bsend_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

function MPI_Bsend_init_c(buf, count, datatype, dest, tag, comm, request)
    ccall((:MPI_Bsend_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function MPI_Buffer_attach_c(buffer, size)
    ccall((:MPI_Buffer_attach_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count), buffer, size)
end

function MPI_Buffer_detach_c(buffer_addr, size)
    ccall((:MPI_Buffer_detach_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}), buffer_addr, size)
end

function MPI_Ibsend_c(buf, count, datatype, dest, tag, comm, request)
    ccall((:MPI_Ibsend_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function MPI_Imrecv_c(buf, count, datatype, message, request)
    ccall((:MPI_Imrecv_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Request}), buf, count, datatype, message, request)
end

function MPI_Irecv_c(buf, count, datatype, source, tag, comm, request)
    ccall((:MPI_Irecv_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, source, tag, comm, request)
end

function MPI_Irsend_c(buf, count, datatype, dest, tag, comm, request)
    ccall((:MPI_Irsend_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function MPI_Isend_c(buf, count, datatype, dest, tag, comm, request)
    ccall((:MPI_Isend_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function MPI_Isendrecv_c(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
    ccall((:MPI_Isendrecv_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
end

function MPI_Isendrecv_replace_c(buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
    ccall((:MPI_Isendrecv_replace_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
end

function MPI_Issend_c(buf, count, datatype, dest, tag, comm, request)
    ccall((:MPI_Issend_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function MPI_Mrecv_c(buf, count, datatype, message, status)
    ccall((:MPI_Mrecv_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Status}), buf, count, datatype, message, status)
end

function MPI_Recv_c(buf, count, datatype, source, tag, comm, status)
    ccall((:MPI_Recv_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), buf, count, datatype, source, tag, comm, status)
end

function MPI_Recv_init_c(buf, count, datatype, source, tag, comm, request)
    ccall((:MPI_Recv_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, source, tag, comm, request)
end

function MPI_Rsend_c(buf, count, datatype, dest, tag, comm)
    ccall((:MPI_Rsend_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

function MPI_Rsend_init_c(buf, count, datatype, dest, tag, comm, request)
    ccall((:MPI_Rsend_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function MPI_Send_c(buf, count, datatype, dest, tag, comm)
    ccall((:MPI_Send_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

function MPI_Send_init_c(buf, count, datatype, dest, tag, comm, request)
    ccall((:MPI_Send_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function MPI_Sendrecv_c(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
    ccall((:MPI_Sendrecv_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
end

function MPI_Sendrecv_replace_c(buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
    ccall((:MPI_Sendrecv_replace_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
end

function MPI_Ssend_c(buf, count, datatype, dest, tag, comm)
    ccall((:MPI_Ssend_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

function MPI_Ssend_init_c(buf, count, datatype, dest, tag, comm, request)
    ccall((:MPI_Ssend_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function MPI_Accumulate_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    ccall((:MPI_Accumulate_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Op, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

function MPI_Get_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    ccall((:MPI_Get_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

function MPI_Get_accumulate_c(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    ccall((:MPI_Get_accumulate_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Op, MPI_Win), origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

function MPI_Put_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    ccall((:MPI_Put_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

function MPI_Raccumulate_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    ccall((:MPI_Raccumulate_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

function MPI_Rget_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    ccall((:MPI_Rget_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

function MPI_Rget_accumulate_c(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    ccall((:MPI_Rget_accumulate_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

function MPI_Rput_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    ccall((:MPI_Rput_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

function MPI_Win_allocate_c(size, disp_unit, info, comm, baseptr, win)
    ccall((:MPI_Win_allocate_c, libmpi), Cint, (MPI_Aint, MPI_Aint, MPI_Info, MPI_Comm, Ptr{Cvoid}, Ptr{MPI_Win}), size, disp_unit, info, comm, baseptr, win)
end

function MPI_Win_allocate_shared_c(size, disp_unit, info, comm, baseptr, win)
    ccall((:MPI_Win_allocate_shared_c, libmpi), Cint, (MPI_Aint, MPI_Aint, MPI_Info, MPI_Comm, Ptr{Cvoid}, Ptr{MPI_Win}), size, disp_unit, info, comm, baseptr, win)
end

function MPI_Win_create_c(base, size, disp_unit, info, comm, win)
    ccall((:MPI_Win_create_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Aint, MPI_Aint, MPI_Info, MPI_Comm, Ptr{MPI_Win}), base, size, disp_unit, info, comm, win)
end

function MPI_Win_shared_query_c(win, rank, size, disp_unit, baseptr)
    ccall((:MPI_Win_shared_query_c, libmpi), Cint, (MPI_Win, Cint, Ptr{MPI_Aint}, Ptr{MPI_Aint}, Ptr{Cvoid}), win, rank, size, disp_unit, baseptr)
end

function PMPI_Status_c2f(c_status, f_status)
    ccall((:PMPI_Status_c2f, libmpi), Cint, (Ptr{MPI_Status}, Ptr{MPI_Fint}), c_status, f_status)
end

function PMPI_Status_f2c(f_status, c_status)
    ccall((:PMPI_Status_f2c, libmpi), Cint, (Ptr{MPI_Fint}, Ptr{MPI_Status}), f_status, c_status)
end

function PMPI_Status_f082c(f08_status, c_status)
    ccall((:PMPI_Status_f082c, libmpi), Cint, (Ptr{MPI_F08_status}, Ptr{MPI_Status}), f08_status, c_status)
end

function PMPI_Status_c2f08(c_status, f08_status)
    ccall((:PMPI_Status_c2f08, libmpi), Cint, (Ptr{MPI_Status}, Ptr{MPI_F08_status}), c_status, f08_status)
end

function PMPI_Status_f082f(f08_status, f_status)
    ccall((:PMPI_Status_f082f, libmpi), Cint, (Ptr{MPI_F08_status}, Ptr{MPI_Fint}), f08_status, f_status)
end

function PMPI_Status_f2f08(f_status, f08_status)
    ccall((:PMPI_Status_f2f08, libmpi), Cint, (Ptr{MPI_Fint}, Ptr{MPI_F08_status}), f_status, f08_status)
end

function PMPI_Type_create_f90_integer(r, newtype)
    ccall((:PMPI_Type_create_f90_integer, libmpi), Cint, (Cint, Ptr{MPI_Datatype}), r, newtype)
end

function PMPI_Type_create_f90_real(p, r, newtype)
    ccall((:PMPI_Type_create_f90_real, libmpi), Cint, (Cint, Cint, Ptr{MPI_Datatype}), p, r, newtype)
end

function PMPI_Type_create_f90_complex(p, r, newtype)
    ccall((:PMPI_Type_create_f90_complex, libmpi), Cint, (Cint, Cint, Ptr{MPI_Datatype}), p, r, newtype)
end

function PMPI_Attr_delete(comm, keyval)
    ccall((:PMPI_Attr_delete, libmpi), Cint, (MPI_Comm, Cint), comm, keyval)
end

function PMPI_Attr_get(comm, keyval, attribute_val, flag)
    ccall((:PMPI_Attr_get, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cvoid}, Ptr{Cint}), comm, keyval, attribute_val, flag)
end

function PMPI_Attr_put(comm, keyval, attribute_val)
    ccall((:PMPI_Attr_put, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cvoid}), comm, keyval, attribute_val)
end

function PMPI_Comm_create_keyval(comm_copy_attr_fn, comm_delete_attr_fn, comm_keyval, extra_state)
    ccall((:PMPI_Comm_create_keyval, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cvoid}), comm_copy_attr_fn, comm_delete_attr_fn, comm_keyval, extra_state)
end

function PMPI_Comm_delete_attr(comm, comm_keyval)
    ccall((:PMPI_Comm_delete_attr, libmpi), Cint, (MPI_Comm, Cint), comm, comm_keyval)
end

function PMPI_Comm_free_keyval(comm_keyval)
    ccall((:PMPI_Comm_free_keyval, libmpi), Cint, (Ptr{Cint},), comm_keyval)
end

function PMPI_Comm_get_attr(comm, comm_keyval, attribute_val, flag)
    ccall((:PMPI_Comm_get_attr, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cvoid}, Ptr{Cint}), comm, comm_keyval, attribute_val, flag)
end

function PMPI_Comm_set_attr(comm, comm_keyval, attribute_val)
    ccall((:PMPI_Comm_set_attr, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cvoid}), comm, comm_keyval, attribute_val)
end

function PMPI_Keyval_create(copy_fn, delete_fn, keyval, extra_state)
    ccall((:PMPI_Keyval_create, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cvoid}), copy_fn, delete_fn, keyval, extra_state)
end

function PMPI_Keyval_free(keyval)
    ccall((:PMPI_Keyval_free, libmpi), Cint, (Ptr{Cint},), keyval)
end

function PMPI_Type_create_keyval(type_copy_attr_fn, type_delete_attr_fn, type_keyval, extra_state)
    ccall((:PMPI_Type_create_keyval, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cvoid}), type_copy_attr_fn, type_delete_attr_fn, type_keyval, extra_state)
end

function PMPI_Type_delete_attr(datatype, type_keyval)
    ccall((:PMPI_Type_delete_attr, libmpi), Cint, (MPI_Datatype, Cint), datatype, type_keyval)
end

function PMPI_Type_free_keyval(type_keyval)
    ccall((:PMPI_Type_free_keyval, libmpi), Cint, (Ptr{Cint},), type_keyval)
end

function PMPI_Type_get_attr(datatype, type_keyval, attribute_val, flag)
    ccall((:PMPI_Type_get_attr, libmpi), Cint, (MPI_Datatype, Cint, Ptr{Cvoid}, Ptr{Cint}), datatype, type_keyval, attribute_val, flag)
end

function PMPI_Type_set_attr(datatype, type_keyval, attribute_val)
    ccall((:PMPI_Type_set_attr, libmpi), Cint, (MPI_Datatype, Cint, Ptr{Cvoid}), datatype, type_keyval, attribute_val)
end

function PMPI_Win_create_keyval(win_copy_attr_fn, win_delete_attr_fn, win_keyval, extra_state)
    ccall((:PMPI_Win_create_keyval, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cvoid}), win_copy_attr_fn, win_delete_attr_fn, win_keyval, extra_state)
end

function PMPI_Win_delete_attr(win, win_keyval)
    ccall((:PMPI_Win_delete_attr, libmpi), Cint, (MPI_Win, Cint), win, win_keyval)
end

function PMPI_Win_free_keyval(win_keyval)
    ccall((:PMPI_Win_free_keyval, libmpi), Cint, (Ptr{Cint},), win_keyval)
end

function PMPI_Win_get_attr(win, win_keyval, attribute_val, flag)
    ccall((:PMPI_Win_get_attr, libmpi), Cint, (MPI_Win, Cint, Ptr{Cvoid}, Ptr{Cint}), win, win_keyval, attribute_val, flag)
end

function PMPI_Win_set_attr(win, win_keyval, attribute_val)
    ccall((:PMPI_Win_set_attr, libmpi), Cint, (MPI_Win, Cint, Ptr{Cvoid}), win, win_keyval, attribute_val)
end

function PMPI_Allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:PMPI_Allgather, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function PMPI_Allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:PMPI_Allgather_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function PMPI_Allgather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    ccall((:PMPI_Allgather_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

function PMPI_Allgather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    ccall((:PMPI_Allgather_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

function PMPI_Allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    ccall((:PMPI_Allgatherv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

function PMPI_Allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    ccall((:PMPI_Allgatherv_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

function PMPI_Allgatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    ccall((:PMPI_Allgatherv_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
end

function PMPI_Allgatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    ccall((:PMPI_Allgatherv_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
end

function PMPI_Allreduce(sendbuf, recvbuf, count, datatype, op, comm)
    ccall((:PMPI_Allreduce, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

function PMPI_Allreduce_c(sendbuf, recvbuf, count, datatype, op, comm)
    ccall((:PMPI_Allreduce_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

function PMPI_Allreduce_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    ccall((:PMPI_Allreduce_init, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

function PMPI_Allreduce_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    ccall((:PMPI_Allreduce_init_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

function PMPI_Alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:PMPI_Alltoall, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function PMPI_Alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:PMPI_Alltoall_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function PMPI_Alltoall_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    ccall((:PMPI_Alltoall_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

function PMPI_Alltoall_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    ccall((:PMPI_Alltoall_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

function PMPI_Alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    ccall((:PMPI_Alltoallv, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

function PMPI_Alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    ccall((:PMPI_Alltoallv_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

function PMPI_Alltoallv_init(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    ccall((:PMPI_Alltoallv_init, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
end

function PMPI_Alltoallv_init_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    ccall((:PMPI_Alltoallv_init_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
end

function PMPI_Alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    ccall((:PMPI_Alltoallw, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPI_Comm), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

function PMPI_Alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    ccall((:PMPI_Alltoallw_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

function PMPI_Alltoallw_init(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    ccall((:PMPI_Alltoallw_init, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
end

function PMPI_Alltoallw_init_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    ccall((:PMPI_Alltoallw_init_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
end

function PMPI_Barrier(comm)
    ccall((:PMPI_Barrier, libmpi), Cint, (MPI_Comm,), comm)
end

function PMPI_Barrier_init(comm, info, request)
    ccall((:PMPI_Barrier_init, libmpi), Cint, (MPI_Comm, MPI_Info, Ptr{MPI_Request}), comm, info, request)
end

function PMPI_Bcast(buffer, count, datatype, root, comm)
    ccall((:PMPI_Bcast, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm), buffer, count, datatype, root, comm)
end

function PMPI_Bcast_c(buffer, count, datatype, root, comm)
    ccall((:PMPI_Bcast_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm), buffer, count, datatype, root, comm)
end

function PMPI_Bcast_init(buffer, count, datatype, root, comm, info, request)
    ccall((:PMPI_Bcast_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), buffer, count, datatype, root, comm, info, request)
end

function PMPI_Bcast_init_c(buffer, count, datatype, root, comm, info, request)
    ccall((:PMPI_Bcast_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), buffer, count, datatype, root, comm, info, request)
end

function PMPI_Exscan(sendbuf, recvbuf, count, datatype, op, comm)
    ccall((:PMPI_Exscan, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

function PMPI_Exscan_c(sendbuf, recvbuf, count, datatype, op, comm)
    ccall((:PMPI_Exscan_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

function PMPI_Exscan_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    ccall((:PMPI_Exscan_init, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

function PMPI_Exscan_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    ccall((:PMPI_Exscan_init_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

function PMPI_Gather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    ccall((:PMPI_Gather, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

function PMPI_Gather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    ccall((:PMPI_Gather_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

function PMPI_Gather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    ccall((:PMPI_Gather_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

function PMPI_Gather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    ccall((:PMPI_Gather_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

function PMPI_Gatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
    ccall((:PMPI_Gatherv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
end

function PMPI_Gatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
    ccall((:PMPI_Gatherv_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
end

function PMPI_Gatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
    ccall((:PMPI_Gatherv_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
end

function PMPI_Gatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
    ccall((:PMPI_Gatherv_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
end

function PMPI_Iallgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:PMPI_Iallgather, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function PMPI_Iallgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:PMPI_Iallgather_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function PMPI_Iallgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    ccall((:PMPI_Iallgatherv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

function PMPI_Iallgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    ccall((:PMPI_Iallgatherv_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

function PMPI_Iallreduce(sendbuf, recvbuf, count, datatype, op, comm, request)
    ccall((:PMPI_Iallreduce, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

function PMPI_Iallreduce_c(sendbuf, recvbuf, count, datatype, op, comm, request)
    ccall((:PMPI_Iallreduce_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

function PMPI_Ialltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:PMPI_Ialltoall, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function PMPI_Ialltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:PMPI_Ialltoall_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function PMPI_Ialltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    ccall((:PMPI_Ialltoallv, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

function PMPI_Ialltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    ccall((:PMPI_Ialltoallv_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

function PMPI_Ialltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    ccall((:PMPI_Ialltoallw, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

function PMPI_Ialltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    ccall((:PMPI_Ialltoallw_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

function PMPI_Ibarrier(comm, request)
    ccall((:PMPI_Ibarrier, libmpi), Cint, (MPI_Comm, Ptr{MPI_Request}), comm, request)
end

function PMPI_Ibcast(buffer, count, datatype, root, comm, request)
    ccall((:PMPI_Ibcast, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), buffer, count, datatype, root, comm, request)
end

function PMPI_Ibcast_c(buffer, count, datatype, root, comm, request)
    ccall((:PMPI_Ibcast_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), buffer, count, datatype, root, comm, request)
end

function PMPI_Iexscan(sendbuf, recvbuf, count, datatype, op, comm, request)
    ccall((:PMPI_Iexscan, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

function PMPI_Iexscan_c(sendbuf, recvbuf, count, datatype, op, comm, request)
    ccall((:PMPI_Iexscan_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

function PMPI_Igather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    ccall((:PMPI_Igather, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

function PMPI_Igather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    ccall((:PMPI_Igather_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

function PMPI_Igatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
    ccall((:PMPI_Igatherv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
end

function PMPI_Igatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
    ccall((:PMPI_Igatherv_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
end

function PMPI_Ineighbor_allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:PMPI_Ineighbor_allgather, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function PMPI_Ineighbor_allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:PMPI_Ineighbor_allgather_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function PMPI_Ineighbor_allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    ccall((:PMPI_Ineighbor_allgatherv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

function PMPI_Ineighbor_allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    ccall((:PMPI_Ineighbor_allgatherv_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

function PMPI_Ineighbor_alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:PMPI_Ineighbor_alltoall, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function PMPI_Ineighbor_alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:PMPI_Ineighbor_alltoall_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function PMPI_Ineighbor_alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    ccall((:PMPI_Ineighbor_alltoallv, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

function PMPI_Ineighbor_alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    ccall((:PMPI_Ineighbor_alltoallv_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

function PMPI_Ineighbor_alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    ccall((:PMPI_Ineighbor_alltoallw, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

function PMPI_Ineighbor_alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    ccall((:PMPI_Ineighbor_alltoallw_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

function PMPI_Ireduce(sendbuf, recvbuf, count, datatype, op, root, comm, request)
    ccall((:PMPI_Ireduce, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, root, comm, request)
end

function PMPI_Ireduce_c(sendbuf, recvbuf, count, datatype, op, root, comm, request)
    ccall((:PMPI_Ireduce_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, root, comm, request)
end

function PMPI_Ireduce_scatter(sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
    ccall((:PMPI_Ireduce_scatter, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
end

function PMPI_Ireduce_scatter_c(sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
    ccall((:PMPI_Ireduce_scatter_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{MPI_Count}, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
end

function PMPI_Ireduce_scatter_block(sendbuf, recvbuf, recvcount, datatype, op, comm, request)
    ccall((:PMPI_Ireduce_scatter_block, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, recvcount, datatype, op, comm, request)
end

function PMPI_Ireduce_scatter_block_c(sendbuf, recvbuf, recvcount, datatype, op, comm, request)
    ccall((:PMPI_Ireduce_scatter_block_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, recvcount, datatype, op, comm, request)
end

function PMPI_Iscan(sendbuf, recvbuf, count, datatype, op, comm, request)
    ccall((:PMPI_Iscan, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

function PMPI_Iscan_c(sendbuf, recvbuf, count, datatype, op, comm, request)
    ccall((:PMPI_Iscan_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

function PMPI_Iscatter(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    ccall((:PMPI_Iscatter, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

function PMPI_Iscatter_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    ccall((:PMPI_Iscatter_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

function PMPI_Iscatterv(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    ccall((:PMPI_Iscatterv, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

function PMPI_Iscatterv_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    ccall((:PMPI_Iscatterv_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

function PMPI_Neighbor_allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:PMPI_Neighbor_allgather, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function PMPI_Neighbor_allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:PMPI_Neighbor_allgather_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function PMPI_Neighbor_allgather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    ccall((:PMPI_Neighbor_allgather_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

function PMPI_Neighbor_allgather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    ccall((:PMPI_Neighbor_allgather_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

function PMPI_Neighbor_allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    ccall((:PMPI_Neighbor_allgatherv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

function PMPI_Neighbor_allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    ccall((:PMPI_Neighbor_allgatherv_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

function PMPI_Neighbor_allgatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    ccall((:PMPI_Neighbor_allgatherv_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
end

function PMPI_Neighbor_allgatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    ccall((:PMPI_Neighbor_allgatherv_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
end

function PMPI_Neighbor_alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:PMPI_Neighbor_alltoall, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function PMPI_Neighbor_alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:PMPI_Neighbor_alltoall_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function PMPI_Neighbor_alltoall_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    ccall((:PMPI_Neighbor_alltoall_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

function PMPI_Neighbor_alltoall_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    ccall((:PMPI_Neighbor_alltoall_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

function PMPI_Neighbor_alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    ccall((:PMPI_Neighbor_alltoallv, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

function PMPI_Neighbor_alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    ccall((:PMPI_Neighbor_alltoallv_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

function PMPI_Neighbor_alltoallv_init(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    ccall((:PMPI_Neighbor_alltoallv_init, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
end

function PMPI_Neighbor_alltoallv_init_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    ccall((:PMPI_Neighbor_alltoallv_init_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
end

function PMPI_Neighbor_alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    ccall((:PMPI_Neighbor_alltoallw, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

function PMPI_Neighbor_alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    ccall((:PMPI_Neighbor_alltoallw_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

function PMPI_Neighbor_alltoallw_init(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    ccall((:PMPI_Neighbor_alltoallw_init, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
end

function PMPI_Neighbor_alltoallw_init_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    ccall((:PMPI_Neighbor_alltoallw_init_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
end

function PMPI_Reduce(sendbuf, recvbuf, count, datatype, op, root, comm)
    ccall((:PMPI_Reduce, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm), sendbuf, recvbuf, count, datatype, op, root, comm)
end

function PMPI_Reduce_c(sendbuf, recvbuf, count, datatype, op, root, comm)
    ccall((:PMPI_Reduce_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, Cint, MPI_Comm), sendbuf, recvbuf, count, datatype, op, root, comm)
end

function PMPI_Reduce_init(sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
    ccall((:PMPI_Reduce_init, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
end

function PMPI_Reduce_init_c(sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
    ccall((:PMPI_Reduce_init_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
end

function PMPI_Reduce_local(inbuf, inoutbuf, count, datatype, op)
    ccall((:PMPI_Reduce_local, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op), inbuf, inoutbuf, count, datatype, op)
end

function PMPI_Reduce_local_c(inbuf, inoutbuf, count, datatype, op)
    ccall((:PMPI_Reduce_local_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op), inbuf, inoutbuf, count, datatype, op)
end

function PMPI_Reduce_scatter(sendbuf, recvbuf, recvcounts, datatype, op, comm)
    ccall((:PMPI_Reduce_scatter, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, recvcounts, datatype, op, comm)
end

function PMPI_Reduce_scatter_c(sendbuf, recvbuf, recvcounts, datatype, op, comm)
    ccall((:PMPI_Reduce_scatter_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{MPI_Count}, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, recvcounts, datatype, op, comm)
end

function PMPI_Reduce_scatter_block(sendbuf, recvbuf, recvcount, datatype, op, comm)
    ccall((:PMPI_Reduce_scatter_block, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, recvcount, datatype, op, comm)
end

function PMPI_Reduce_scatter_block_c(sendbuf, recvbuf, recvcount, datatype, op, comm)
    ccall((:PMPI_Reduce_scatter_block_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, recvcount, datatype, op, comm)
end

function PMPI_Reduce_scatter_block_init(sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
    ccall((:PMPI_Reduce_scatter_block_init, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
end

function PMPI_Reduce_scatter_block_init_c(sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
    ccall((:PMPI_Reduce_scatter_block_init_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
end

function PMPI_Reduce_scatter_init(sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
    ccall((:PMPI_Reduce_scatter_init, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
end

function PMPI_Reduce_scatter_init_c(sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
    ccall((:PMPI_Reduce_scatter_init_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{MPI_Count}, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
end

function PMPI_Scan(sendbuf, recvbuf, count, datatype, op, comm)
    ccall((:PMPI_Scan, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

function PMPI_Scan_c(sendbuf, recvbuf, count, datatype, op, comm)
    ccall((:PMPI_Scan_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

function PMPI_Scan_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    ccall((:PMPI_Scan_init, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

function PMPI_Scan_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    ccall((:PMPI_Scan_init_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

function PMPI_Scatter(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    ccall((:PMPI_Scatter, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

function PMPI_Scatter_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    ccall((:PMPI_Scatter_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

function PMPI_Scatter_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    ccall((:PMPI_Scatter_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

function PMPI_Scatter_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    ccall((:PMPI_Scatter_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

function PMPI_Scatterv(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
    ccall((:PMPI_Scatterv, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

function PMPI_Scatterv_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
    ccall((:PMPI_Scatterv_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

function PMPI_Scatterv_init(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    ccall((:PMPI_Scatterv_init, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

function PMPI_Scatterv_init_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    ccall((:PMPI_Scatterv_init_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

function PMPI_Comm_compare(comm1, comm2, result)
    ccall((:PMPI_Comm_compare, libmpi), Cint, (MPI_Comm, MPI_Comm, Ptr{Cint}), comm1, comm2, result)
end

function PMPI_Comm_create(comm, group, newcomm)
    ccall((:PMPI_Comm_create, libmpi), Cint, (MPI_Comm, MPI_Group, Ptr{MPI_Comm}), comm, group, newcomm)
end

function PMPI_Comm_create_group(comm, group, tag, newcomm)
    ccall((:PMPI_Comm_create_group, libmpi), Cint, (MPI_Comm, MPI_Group, Cint, Ptr{MPI_Comm}), comm, group, tag, newcomm)
end

function PMPI_Comm_dup(comm, newcomm)
    ccall((:PMPI_Comm_dup, libmpi), Cint, (MPI_Comm, Ptr{MPI_Comm}), comm, newcomm)
end

function PMPI_Comm_dup_with_info(comm, info, newcomm)
    ccall((:PMPI_Comm_dup_with_info, libmpi), Cint, (MPI_Comm, MPI_Info, Ptr{MPI_Comm}), comm, info, newcomm)
end

function PMPI_Comm_free(comm)
    ccall((:PMPI_Comm_free, libmpi), Cint, (Ptr{MPI_Comm},), comm)
end

function PMPI_Comm_get_info(comm, info_used)
    ccall((:PMPI_Comm_get_info, libmpi), Cint, (MPI_Comm, Ptr{MPI_Info}), comm, info_used)
end

function PMPI_Comm_get_name(comm, comm_name, resultlen)
    ccall((:PMPI_Comm_get_name, libmpi), Cint, (MPI_Comm, Ptr{Cchar}, Ptr{Cint}), comm, comm_name, resultlen)
end

function PMPI_Comm_group(comm, group)
    ccall((:PMPI_Comm_group, libmpi), Cint, (MPI_Comm, Ptr{MPI_Group}), comm, group)
end

function PMPI_Comm_idup(comm, newcomm, request)
    ccall((:PMPI_Comm_idup, libmpi), Cint, (MPI_Comm, Ptr{MPI_Comm}, Ptr{MPI_Request}), comm, newcomm, request)
end

function PMPI_Comm_idup_with_info(comm, info, newcomm, request)
    ccall((:PMPI_Comm_idup_with_info, libmpi), Cint, (MPI_Comm, MPI_Info, Ptr{MPI_Comm}, Ptr{MPI_Request}), comm, info, newcomm, request)
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

function PMPI_Comm_set_info(comm, info)
    ccall((:PMPI_Comm_set_info, libmpi), Cint, (MPI_Comm, MPI_Info), comm, info)
end

function PMPI_Comm_set_name(comm, comm_name)
    ccall((:PMPI_Comm_set_name, libmpi), Cint, (MPI_Comm, Ptr{Cchar}), comm, comm_name)
end

function PMPI_Comm_size(comm, size)
    ccall((:PMPI_Comm_size, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, size)
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

function PMPI_Intercomm_create(local_comm, local_leader, peer_comm, remote_leader, tag, newintercomm)
    ccall((:PMPI_Intercomm_create, libmpi), Cint, (MPI_Comm, Cint, MPI_Comm, Cint, Cint, Ptr{MPI_Comm}), local_comm, local_leader, peer_comm, remote_leader, tag, newintercomm)
end

function PMPI_Intercomm_create_from_groups(local_group, local_leader, remote_group, remote_leader, stringtag, info, errhandler, newintercomm)
    ccall((:PMPI_Intercomm_create_from_groups, libmpi), Cint, (MPI_Group, Cint, MPI_Group, Cint, Ptr{Cchar}, MPI_Info, MPI_Errhandler, Ptr{MPI_Comm}), local_group, local_leader, remote_group, remote_leader, stringtag, info, errhandler, newintercomm)
end

function PMPI_Intercomm_merge(intercomm, high, newintracomm)
    ccall((:PMPI_Intercomm_merge, libmpi), Cint, (MPI_Comm, Cint, Ptr{MPI_Comm}), intercomm, high, newintracomm)
end

function PMPIX_Comm_revoke(comm)
    ccall((:PMPIX_Comm_revoke, libmpi), Cint, (MPI_Comm,), comm)
end

function PMPIX_Comm_shrink(comm, newcomm)
    ccall((:PMPIX_Comm_shrink, libmpi), Cint, (MPI_Comm, Ptr{MPI_Comm}), comm, newcomm)
end

function PMPIX_Comm_failure_ack(comm)
    ccall((:PMPIX_Comm_failure_ack, libmpi), Cint, (MPI_Comm,), comm)
end

function PMPIX_Comm_failure_get_acked(comm, failedgrp)
    ccall((:PMPIX_Comm_failure_get_acked, libmpi), Cint, (MPI_Comm, Ptr{MPI_Group}), comm, failedgrp)
end

function PMPIX_Comm_agree(comm, flag)
    ccall((:PMPIX_Comm_agree, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, flag)
end

function PMPI_Get_address(location, address)
    ccall((:PMPI_Get_address, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Aint}), location, address)
end

function PMPI_Get_count(status, datatype, count)
    ccall((:PMPI_Get_count, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Ptr{Cint}), status, datatype, count)
end

function PMPI_Get_count_c(status, datatype, count)
    ccall((:PMPI_Get_count_c, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Ptr{MPI_Count}), status, datatype, count)
end

function PMPI_Get_elements(status, datatype, count)
    ccall((:PMPI_Get_elements, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Ptr{Cint}), status, datatype, count)
end

function PMPI_Get_elements_c(status, datatype, count)
    ccall((:PMPI_Get_elements_c, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Ptr{MPI_Count}), status, datatype, count)
end

function PMPI_Get_elements_x(status, datatype, count)
    ccall((:PMPI_Get_elements_x, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Ptr{MPI_Count}), status, datatype, count)
end

function PMPI_Pack(inbuf, incount, datatype, outbuf, outsize, position, comm)
    ccall((:PMPI_Pack, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, Ptr{Cint}, MPI_Comm), inbuf, incount, datatype, outbuf, outsize, position, comm)
end

function PMPI_Pack_c(inbuf, incount, datatype, outbuf, outsize, position, comm)
    ccall((:PMPI_Pack_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, Ptr{MPI_Count}, MPI_Comm), inbuf, incount, datatype, outbuf, outsize, position, comm)
end

function PMPI_Pack_external(datarep, inbuf, incount, datatype, outbuf, outsize, position)
    ccall((:PMPI_Pack_external, libmpi), Cint, (Ptr{Cchar}, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, MPI_Aint, Ptr{MPI_Aint}), datarep, inbuf, incount, datatype, outbuf, outsize, position)
end

function PMPI_Pack_external_c(datarep, inbuf, incount, datatype, outbuf, outsize, position)
    ccall((:PMPI_Pack_external_c, libmpi), Cint, (Ptr{Cchar}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, Ptr{MPI_Count}), datarep, inbuf, incount, datatype, outbuf, outsize, position)
end

function PMPI_Pack_external_size(datarep, incount, datatype, size)
    ccall((:PMPI_Pack_external_size, libmpi), Cint, (Ptr{Cchar}, Cint, MPI_Datatype, Ptr{MPI_Aint}), datarep, incount, datatype, size)
end

function PMPI_Pack_external_size_c(datarep, incount, datatype, size)
    ccall((:PMPI_Pack_external_size_c, libmpi), Cint, (Ptr{Cchar}, MPI_Count, MPI_Datatype, Ptr{MPI_Count}), datarep, incount, datatype, size)
end

function PMPI_Pack_size(incount, datatype, comm, size)
    ccall((:PMPI_Pack_size, libmpi), Cint, (Cint, MPI_Datatype, MPI_Comm, Ptr{Cint}), incount, datatype, comm, size)
end

function PMPI_Pack_size_c(incount, datatype, comm, size)
    ccall((:PMPI_Pack_size_c, libmpi), Cint, (MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Count}), incount, datatype, comm, size)
end

function PMPI_Status_set_elements(status, datatype, count)
    ccall((:PMPI_Status_set_elements, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Cint), status, datatype, count)
end

function PMPI_Status_set_elements_x(status, datatype, count)
    ccall((:PMPI_Status_set_elements_x, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, MPI_Count), status, datatype, count)
end

function PMPI_Type_commit(datatype)
    ccall((:PMPI_Type_commit, libmpi), Cint, (Ptr{MPI_Datatype},), datatype)
end

function PMPI_Type_contiguous(count, oldtype, newtype)
    ccall((:PMPI_Type_contiguous, libmpi), Cint, (Cint, MPI_Datatype, Ptr{MPI_Datatype}), count, oldtype, newtype)
end

function PMPI_Type_contiguous_c(count, oldtype, newtype)
    ccall((:PMPI_Type_contiguous_c, libmpi), Cint, (MPI_Count, MPI_Datatype, Ptr{MPI_Datatype}), count, oldtype, newtype)
end

function PMPI_Type_create_darray(size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
    ccall((:PMPI_Type_create_darray, libmpi), Cint, (Cint, Cint, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
end

function PMPI_Type_create_darray_c(size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
    ccall((:PMPI_Type_create_darray_c, libmpi), Cint, (Cint, Cint, Cint, Ptr{MPI_Count}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
end

function PMPI_Type_create_hindexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    ccall((:PMPI_Type_create_hindexed, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

function PMPI_Type_create_hindexed_c(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    ccall((:PMPI_Type_create_hindexed_c, libmpi), Cint, (MPI_Count, Ptr{MPI_Count}, Ptr{MPI_Count}, MPI_Datatype, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

function PMPI_Type_create_hindexed_block(count, blocklength, array_of_displacements, oldtype, newtype)
    ccall((:PMPI_Type_create_hindexed_block, libmpi), Cint, (Cint, Cint, Ptr{MPI_Aint}, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, array_of_displacements, oldtype, newtype)
end

function PMPI_Type_create_hindexed_block_c(count, blocklength, array_of_displacements, oldtype, newtype)
    ccall((:PMPI_Type_create_hindexed_block_c, libmpi), Cint, (MPI_Count, MPI_Count, Ptr{MPI_Count}, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, array_of_displacements, oldtype, newtype)
end

function PMPI_Type_create_hvector(count, blocklength, stride, oldtype, newtype)
    ccall((:PMPI_Type_create_hvector, libmpi), Cint, (Cint, Cint, MPI_Aint, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

function PMPI_Type_create_hvector_c(count, blocklength, stride, oldtype, newtype)
    ccall((:PMPI_Type_create_hvector_c, libmpi), Cint, (MPI_Count, MPI_Count, MPI_Count, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

function PMPI_Type_create_indexed_block(count, blocklength, array_of_displacements, oldtype, newtype)
    ccall((:PMPI_Type_create_indexed_block, libmpi), Cint, (Cint, Cint, Ptr{Cint}, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, array_of_displacements, oldtype, newtype)
end

function PMPI_Type_create_indexed_block_c(count, blocklength, array_of_displacements, oldtype, newtype)
    ccall((:PMPI_Type_create_indexed_block_c, libmpi), Cint, (MPI_Count, MPI_Count, Ptr{MPI_Count}, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, array_of_displacements, oldtype, newtype)
end

function PMPI_Type_create_resized(oldtype, lb, extent, newtype)
    ccall((:PMPI_Type_create_resized, libmpi), Cint, (MPI_Datatype, MPI_Aint, MPI_Aint, Ptr{MPI_Datatype}), oldtype, lb, extent, newtype)
end

function PMPI_Type_create_resized_c(oldtype, lb, extent, newtype)
    ccall((:PMPI_Type_create_resized_c, libmpi), Cint, (MPI_Datatype, MPI_Count, MPI_Count, Ptr{MPI_Datatype}), oldtype, lb, extent, newtype)
end

function PMPI_Type_create_struct(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
    ccall((:PMPI_Type_create_struct, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
end

function PMPI_Type_create_struct_c(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
    ccall((:PMPI_Type_create_struct_c, libmpi), Cint, (MPI_Count, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
end

function PMPI_Type_create_subarray(ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
    ccall((:PMPI_Type_create_subarray, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
end

function PMPI_Type_create_subarray_c(ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
    ccall((:PMPI_Type_create_subarray_c, libmpi), Cint, (Cint, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Count}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
end

function PMPI_Type_dup(oldtype, newtype)
    ccall((:PMPI_Type_dup, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Datatype}), oldtype, newtype)
end

function PMPI_Type_free(datatype)
    ccall((:PMPI_Type_free, libmpi), Cint, (Ptr{MPI_Datatype},), datatype)
end

function PMPI_Type_get_contents(datatype, max_integers, max_addresses, max_datatypes, array_of_integers, array_of_addresses, array_of_datatypes)
    ccall((:PMPI_Type_get_contents, libmpi), Cint, (MPI_Datatype, Cint, Cint, Cint, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}), datatype, max_integers, max_addresses, max_datatypes, array_of_integers, array_of_addresses, array_of_datatypes)
end

function PMPI_Type_get_contents_c(datatype, max_integers, max_addresses, max_large_counts, max_datatypes, array_of_integers, array_of_addresses, array_of_large_counts, array_of_datatypes)
    ccall((:PMPI_Type_get_contents_c, libmpi), Cint, (MPI_Datatype, MPI_Count, MPI_Count, MPI_Count, MPI_Count, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Count}, Ptr{MPI_Datatype}), datatype, max_integers, max_addresses, max_large_counts, max_datatypes, array_of_integers, array_of_addresses, array_of_large_counts, array_of_datatypes)
end

function PMPI_Type_get_envelope(datatype, num_integers, num_addresses, num_datatypes, combiner)
    ccall((:PMPI_Type_get_envelope, libmpi), Cint, (MPI_Datatype, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), datatype, num_integers, num_addresses, num_datatypes, combiner)
end

function PMPI_Type_get_envelope_c(datatype, num_integers, num_addresses, num_large_counts, num_datatypes, combiner)
    ccall((:PMPI_Type_get_envelope_c, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{Cint}), datatype, num_integers, num_addresses, num_large_counts, num_datatypes, combiner)
end

function PMPI_Type_get_extent(datatype, lb, extent)
    ccall((:PMPI_Type_get_extent, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Aint}, Ptr{MPI_Aint}), datatype, lb, extent)
end

function PMPI_Type_get_extent_c(datatype, lb, extent)
    ccall((:PMPI_Type_get_extent_c, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), datatype, lb, extent)
end

function PMPI_Type_get_extent_x(datatype, lb, extent)
    ccall((:PMPI_Type_get_extent_x, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), datatype, lb, extent)
end

function PMPI_Type_get_name(datatype, type_name, resultlen)
    ccall((:PMPI_Type_get_name, libmpi), Cint, (MPI_Datatype, Ptr{Cchar}, Ptr{Cint}), datatype, type_name, resultlen)
end

function PMPI_Type_get_true_extent(datatype, true_lb, true_extent)
    ccall((:PMPI_Type_get_true_extent, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Aint}, Ptr{MPI_Aint}), datatype, true_lb, true_extent)
end

function PMPI_Type_get_true_extent_c(datatype, true_lb, true_extent)
    ccall((:PMPI_Type_get_true_extent_c, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), datatype, true_lb, true_extent)
end

function PMPI_Type_get_true_extent_x(datatype, true_lb, true_extent)
    ccall((:PMPI_Type_get_true_extent_x, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), datatype, true_lb, true_extent)
end

function PMPI_Type_indexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    ccall((:PMPI_Type_indexed, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

function PMPI_Type_indexed_c(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    ccall((:PMPI_Type_indexed_c, libmpi), Cint, (MPI_Count, Ptr{MPI_Count}, Ptr{MPI_Count}, MPI_Datatype, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

function PMPI_Type_match_size(typeclass, size, datatype)
    ccall((:PMPI_Type_match_size, libmpi), Cint, (Cint, Cint, Ptr{MPI_Datatype}), typeclass, size, datatype)
end

function PMPI_Type_set_name(datatype, type_name)
    ccall((:PMPI_Type_set_name, libmpi), Cint, (MPI_Datatype, Ptr{Cchar}), datatype, type_name)
end

function PMPI_Type_size(datatype, size)
    ccall((:PMPI_Type_size, libmpi), Cint, (MPI_Datatype, Ptr{Cint}), datatype, size)
end

function PMPI_Type_size_c(datatype, size)
    ccall((:PMPI_Type_size_c, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}), datatype, size)
end

function PMPI_Type_size_x(datatype, size)
    ccall((:PMPI_Type_size_x, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}), datatype, size)
end

function PMPI_Type_vector(count, blocklength, stride, oldtype, newtype)
    ccall((:PMPI_Type_vector, libmpi), Cint, (Cint, Cint, Cint, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

function PMPI_Type_vector_c(count, blocklength, stride, oldtype, newtype)
    ccall((:PMPI_Type_vector_c, libmpi), Cint, (MPI_Count, MPI_Count, MPI_Count, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

function PMPI_Unpack(inbuf, insize, position, outbuf, outcount, datatype, comm)
    ccall((:PMPI_Unpack, libmpi), Cint, (Ptr{Cvoid}, Cint, Ptr{Cint}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm), inbuf, insize, position, outbuf, outcount, datatype, comm)
end

function PMPI_Unpack_c(inbuf, insize, position, outbuf, outcount, datatype, comm)
    ccall((:PMPI_Unpack_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, Ptr{MPI_Count}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm), inbuf, insize, position, outbuf, outcount, datatype, comm)
end

function PMPI_Unpack_external(datarep, inbuf, insize, position, outbuf, outcount, datatype)
    ccall((:PMPI_Unpack_external, libmpi), Cint, (Ptr{Cchar}, Ptr{Cvoid}, MPI_Aint, Ptr{MPI_Aint}, Ptr{Cvoid}, Cint, MPI_Datatype), datarep, inbuf, insize, position, outbuf, outcount, datatype)
end

function PMPI_Unpack_external_c(datarep, inbuf, insize, position, outbuf, outcount, datatype)
    ccall((:PMPI_Unpack_external_c, libmpi), Cint, (Ptr{Cchar}, Ptr{Cvoid}, MPI_Count, Ptr{MPI_Count}, Ptr{Cvoid}, MPI_Count, MPI_Datatype), datarep, inbuf, insize, position, outbuf, outcount, datatype)
end

function PMPI_Address(location, address)
    ccall((:PMPI_Address, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Aint}), location, address)
end

function PMPI_Type_extent(datatype, extent)
    ccall((:PMPI_Type_extent, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Aint}), datatype, extent)
end

function PMPI_Type_lb(datatype, displacement)
    ccall((:PMPI_Type_lb, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Aint}), datatype, displacement)
end

function PMPI_Type_ub(datatype, displacement)
    ccall((:PMPI_Type_ub, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Aint}), datatype, displacement)
end

function PMPI_Type_hindexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    ccall((:PMPI_Type_hindexed, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

function PMPI_Type_hvector(count, blocklength, stride, oldtype, newtype)
    ccall((:PMPI_Type_hvector, libmpi), Cint, (Cint, Cint, MPI_Aint, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

function PMPI_Type_struct(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
    ccall((:PMPI_Type_struct, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
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

function PMPI_Comm_call_errhandler(comm, errorcode)
    ccall((:PMPI_Comm_call_errhandler, libmpi), Cint, (MPI_Comm, Cint), comm, errorcode)
end

function PMPI_Comm_create_errhandler(comm_errhandler_fn, errhandler)
    ccall((:PMPI_Comm_create_errhandler, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Errhandler}), comm_errhandler_fn, errhandler)
end

function PMPI_Comm_get_errhandler(comm, errhandler)
    ccall((:PMPI_Comm_get_errhandler, libmpi), Cint, (MPI_Comm, Ptr{MPI_Errhandler}), comm, errhandler)
end

function PMPI_Comm_set_errhandler(comm, errhandler)
    ccall((:PMPI_Comm_set_errhandler, libmpi), Cint, (MPI_Comm, MPI_Errhandler), comm, errhandler)
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

function PMPI_File_call_errhandler(fh, errorcode)
    ccall((:PMPI_File_call_errhandler, libmpi), Cint, (MPI_File, Cint), fh, errorcode)
end

function PMPI_File_create_errhandler(file_errhandler_fn, errhandler)
    ccall((:PMPI_File_create_errhandler, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Errhandler}), file_errhandler_fn, errhandler)
end

function PMPI_File_get_errhandler(file, errhandler)
    ccall((:PMPI_File_get_errhandler, libmpi), Cint, (MPI_File, Ptr{MPI_Errhandler}), file, errhandler)
end

function PMPI_File_set_errhandler(file, errhandler)
    ccall((:PMPI_File_set_errhandler, libmpi), Cint, (MPI_File, MPI_Errhandler), file, errhandler)
end

function PMPI_Session_call_errhandler(session, errorcode)
    ccall((:PMPI_Session_call_errhandler, libmpi), Cint, (MPI_Session, Cint), session, errorcode)
end

function PMPI_Session_create_errhandler(session_errhandler_fn, errhandler)
    ccall((:PMPI_Session_create_errhandler, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Errhandler}), session_errhandler_fn, errhandler)
end

function PMPI_Session_get_errhandler(session, errhandler)
    ccall((:PMPI_Session_get_errhandler, libmpi), Cint, (MPI_Session, Ptr{MPI_Errhandler}), session, errhandler)
end

function PMPI_Session_set_errhandler(session, errhandler)
    ccall((:PMPI_Session_set_errhandler, libmpi), Cint, (MPI_Session, MPI_Errhandler), session, errhandler)
end

function PMPI_Win_call_errhandler(win, errorcode)
    ccall((:PMPI_Win_call_errhandler, libmpi), Cint, (MPI_Win, Cint), win, errorcode)
end

function PMPI_Win_create_errhandler(win_errhandler_fn, errhandler)
    ccall((:PMPI_Win_create_errhandler, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Errhandler}), win_errhandler_fn, errhandler)
end

function PMPI_Win_get_errhandler(win, errhandler)
    ccall((:PMPI_Win_get_errhandler, libmpi), Cint, (MPI_Win, Ptr{MPI_Errhandler}), win, errhandler)
end

function PMPI_Win_set_errhandler(win, errhandler)
    ccall((:PMPI_Win_set_errhandler, libmpi), Cint, (MPI_Win, MPI_Errhandler), win, errhandler)
end

function PMPIX_Delete_error_class(errorclass)
    ccall((:PMPIX_Delete_error_class, libmpi), Cint, (Cint,), errorclass)
end

function PMPIX_Delete_error_code(errorcode)
    ccall((:PMPIX_Delete_error_code, libmpi), Cint, (Cint,), errorcode)
end

function PMPIX_Delete_error_string(errorcode)
    ccall((:PMPIX_Delete_error_string, libmpi), Cint, (Cint,), errorcode)
end

function PMPI_Errhandler_create(comm_errhandler_fn, errhandler)
    ccall((:PMPI_Errhandler_create, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Errhandler}), comm_errhandler_fn, errhandler)
end

function PMPI_Errhandler_get(comm, errhandler)
    ccall((:PMPI_Errhandler_get, libmpi), Cint, (MPI_Comm, Ptr{MPI_Errhandler}), comm, errhandler)
end

function PMPI_Errhandler_set(comm, errhandler)
    ccall((:PMPI_Errhandler_set, libmpi), Cint, (MPI_Comm, MPI_Errhandler), comm, errhandler)
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

function PMPI_Info_create(info)
    ccall((:PMPI_Info_create, libmpi), Cint, (Ptr{MPI_Info},), info)
end

function PMPI_Info_create_env(argc, argv, info)
    ccall((:PMPI_Info_create_env, libmpi), Cint, (Cint, Ptr{Ptr{Cchar}}, Ptr{MPI_Info}), argc, argv, info)
end

function PMPI_Info_delete(info, key)
    ccall((:PMPI_Info_delete, libmpi), Cint, (MPI_Info, Ptr{Cchar}), info, key)
end

function PMPI_Info_dup(info, newinfo)
    ccall((:PMPI_Info_dup, libmpi), Cint, (MPI_Info, Ptr{MPI_Info}), info, newinfo)
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

function PMPI_Info_get_string(info, key, buflen, value, flag)
    ccall((:PMPI_Info_get_string, libmpi), Cint, (MPI_Info, Ptr{Cchar}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}), info, key, buflen, value, flag)
end

function PMPI_Info_get_valuelen(info, key, valuelen, flag)
    ccall((:PMPI_Info_get_valuelen, libmpi), Cint, (MPI_Info, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}), info, key, valuelen, flag)
end

function PMPI_Info_set(info, key, value)
    ccall((:PMPI_Info_set, libmpi), Cint, (MPI_Info, Ptr{Cchar}, Ptr{Cchar}), info, key, value)
end

function PMPI_Abort(comm, errorcode)
    ccall((:PMPI_Abort, libmpi), Cint, (MPI_Comm, Cint), comm, errorcode)
end

function PMPI_Comm_create_from_group(group, stringtag, info, errhandler, newcomm)
    ccall((:PMPI_Comm_create_from_group, libmpi), Cint, (MPI_Group, Ptr{Cchar}, MPI_Info, MPI_Errhandler, Ptr{MPI_Comm}), group, stringtag, info, errhandler, newcomm)
end

function PMPI_Finalize()
    ccall((:PMPI_Finalize, libmpi), Cint, ())
end

function PMPI_Finalized(flag)
    ccall((:PMPI_Finalized, libmpi), Cint, (Ptr{Cint},), flag)
end

function PMPI_Group_from_session_pset(session, pset_name, newgroup)
    ccall((:PMPI_Group_from_session_pset, libmpi), Cint, (MPI_Session, Ptr{Cchar}, Ptr{MPI_Group}), session, pset_name, newgroup)
end

function PMPI_Init(argc, argv)
    ccall((:PMPI_Init, libmpi), Cint, (Ptr{Cint}, Ptr{Ptr{Ptr{Cchar}}}), argc, argv)
end

function PMPI_Init_thread(argc, argv, required, provided)
    ccall((:PMPI_Init_thread, libmpi), Cint, (Ptr{Cint}, Ptr{Ptr{Ptr{Cchar}}}, Cint, Ptr{Cint}), argc, argv, required, provided)
end

function PMPI_Initialized(flag)
    ccall((:PMPI_Initialized, libmpi), Cint, (Ptr{Cint},), flag)
end

function PMPI_Is_thread_main(flag)
    ccall((:PMPI_Is_thread_main, libmpi), Cint, (Ptr{Cint},), flag)
end

function PMPI_Query_thread(provided)
    ccall((:PMPI_Query_thread, libmpi), Cint, (Ptr{Cint},), provided)
end

function PMPI_Session_finalize(session)
    ccall((:PMPI_Session_finalize, libmpi), Cint, (Ptr{MPI_Session},), session)
end

function PMPI_Session_get_info(session, info_used)
    ccall((:PMPI_Session_get_info, libmpi), Cint, (MPI_Session, Ptr{MPI_Info}), session, info_used)
end

function PMPI_Session_get_nth_pset(session, info, n, pset_len, pset_name)
    ccall((:PMPI_Session_get_nth_pset, libmpi), Cint, (MPI_Session, MPI_Info, Cint, Ptr{Cint}, Ptr{Cchar}), session, info, n, pset_len, pset_name)
end

function PMPI_Session_get_num_psets(session, info, npset_names)
    ccall((:PMPI_Session_get_num_psets, libmpi), Cint, (MPI_Session, MPI_Info, Ptr{Cint}), session, info, npset_names)
end

function PMPI_Session_get_pset_info(session, pset_name, info)
    ccall((:PMPI_Session_get_pset_info, libmpi), Cint, (MPI_Session, Ptr{Cchar}, Ptr{MPI_Info}), session, pset_name, info)
end

function PMPI_Session_init(info, errhandler, session)
    ccall((:PMPI_Session_init, libmpi), Cint, (MPI_Info, MPI_Errhandler, Ptr{MPI_Session}), info, errhandler, session)
end

function PMPI_Aint_add(base, disp)
    ccall((:PMPI_Aint_add, libmpi), MPI_Aint, (MPI_Aint, MPI_Aint), base, disp)
end

function PMPI_Aint_diff(addr1, addr2)
    ccall((:PMPI_Aint_diff, libmpi), MPI_Aint, (MPI_Aint, MPI_Aint), addr1, addr2)
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

function PMPIX_GPU_query_support(gpu_type, is_supported)
    ccall((:PMPIX_GPU_query_support, libmpi), Cint, (Cint, Ptr{Cint}), gpu_type, is_supported)
end

function PMPIX_Query_cuda_support()
    ccall((:PMPIX_Query_cuda_support, libmpi), Cint, ())
end

function PMPIX_Query_ze_support()
    ccall((:PMPIX_Query_ze_support, libmpi), Cint, ())
end

function PMPIX_Query_hip_support()
    ccall((:PMPIX_Query_hip_support, libmpi), Cint, ())
end

function PMPI_T_category_changed(update_number)
    ccall((:PMPI_T_category_changed, libmpi), Cint, (Ptr{Cint},), update_number)
end

function PMPI_T_category_get_categories(cat_index, len, indices)
    ccall((:PMPI_T_category_get_categories, libmpi), Cint, (Cint, Cint, Ptr{Cint}), cat_index, len, indices)
end

function PMPI_T_category_get_cvars(cat_index, len, indices)
    ccall((:PMPI_T_category_get_cvars, libmpi), Cint, (Cint, Cint, Ptr{Cint}), cat_index, len, indices)
end

function PMPI_T_category_get_events(cat_index, len, indices)
    ccall((:PMPI_T_category_get_events, libmpi), Cint, (Cint, Cint, Ptr{Cint}), cat_index, len, indices)
end

function PMPI_T_category_get_index(name, cat_index)
    ccall((:PMPI_T_category_get_index, libmpi), Cint, (Ptr{Cchar}, Ptr{Cint}), name, cat_index)
end

function PMPI_T_category_get_info(cat_index, name, name_len, desc, desc_len, num_cvars, num_pvars, num_categories)
    ccall((:PMPI_T_category_get_info, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), cat_index, name, name_len, desc, desc_len, num_cvars, num_pvars, num_categories)
end

function PMPI_T_category_get_num(num_cat)
    ccall((:PMPI_T_category_get_num, libmpi), Cint, (Ptr{Cint},), num_cat)
end

function PMPI_T_category_get_num_events(cat_index, num_events)
    ccall((:PMPI_T_category_get_num_events, libmpi), Cint, (Cint, Ptr{Cint}), cat_index, num_events)
end

function PMPI_T_category_get_pvars(cat_index, len, indices)
    ccall((:PMPI_T_category_get_pvars, libmpi), Cint, (Cint, Cint, Ptr{Cint}), cat_index, len, indices)
end

function PMPI_T_cvar_get_index(name, cvar_index)
    ccall((:PMPI_T_cvar_get_index, libmpi), Cint, (Ptr{Cchar}, Ptr{Cint}), name, cvar_index)
end

function PMPI_T_cvar_get_info(cvar_index, name, name_len, verbosity, datatype, enumtype, desc, desc_len, bind, scope)
    ccall((:PMPI_T_cvar_get_info, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{MPI_T_enum}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), cvar_index, name, name_len, verbosity, datatype, enumtype, desc, desc_len, bind, scope)
end

function PMPI_T_cvar_get_num(num_cvar)
    ccall((:PMPI_T_cvar_get_num, libmpi), Cint, (Ptr{Cint},), num_cvar)
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

function PMPI_T_enum_get_info(enumtype, num, name, name_len)
    ccall((:PMPI_T_enum_get_info, libmpi), Cint, (MPI_T_enum, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}), enumtype, num, name, name_len)
end

function PMPI_T_enum_get_item(enumtype, indx, value, name, name_len)
    ccall((:PMPI_T_enum_get_item, libmpi), Cint, (MPI_T_enum, Cint, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}), enumtype, indx, value, name, name_len)
end

function PMPI_T_event_callback_get_info(event_registration, cb_safety, info_used)
    ccall((:PMPI_T_event_callback_get_info, libmpi), Cint, (MPI_T_event_registration, MPI_T_cb_safety, Ptr{MPI_Info}), event_registration, cb_safety, info_used)
end

function PMPI_T_event_callback_set_info(event_registration, cb_safety, info)
    ccall((:PMPI_T_event_callback_set_info, libmpi), Cint, (MPI_T_event_registration, MPI_T_cb_safety, MPI_Info), event_registration, cb_safety, info)
end

function PMPI_T_event_copy(event_instance, buffer)
    ccall((:PMPI_T_event_copy, libmpi), Cint, (MPI_T_event_instance, Ptr{Cvoid}), event_instance, buffer)
end

function PMPI_T_event_get_index(name, event_index)
    ccall((:PMPI_T_event_get_index, libmpi), Cint, (Ptr{Cchar}, Ptr{Cint}), name, event_index)
end

function PMPI_T_event_get_info(event_index, name, name_len, verbosity, array_of_datatypes, array_of_displacements, num_elements, enumtype, info, desc, desc_len, bind)
    ccall((:PMPI_T_event_get_info, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{MPI_Aint}, Ptr{Cint}, Ptr{MPI_T_enum}, Ptr{MPI_Info}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}), event_index, name, name_len, verbosity, array_of_datatypes, array_of_displacements, num_elements, enumtype, info, desc, desc_len, bind)
end

function PMPI_T_event_get_num(num_events)
    ccall((:PMPI_T_event_get_num, libmpi), Cint, (Ptr{Cint},), num_events)
end

function PMPI_T_event_get_source(event_instance, source_index)
    ccall((:PMPI_T_event_get_source, libmpi), Cint, (MPI_T_event_instance, Ptr{Cint}), event_instance, source_index)
end

function PMPI_T_event_get_timestamp(event_instance, event_timestamp)
    ccall((:PMPI_T_event_get_timestamp, libmpi), Cint, (MPI_T_event_instance, Ptr{MPI_Count}), event_instance, event_timestamp)
end

function PMPI_T_event_handle_alloc(event_index, obj_handle, info, event_registration)
    ccall((:PMPI_T_event_handle_alloc, libmpi), Cint, (Cint, Ptr{Cvoid}, MPI_Info, Ptr{MPI_T_event_registration}), event_index, obj_handle, info, event_registration)
end

function PMPI_T_event_handle_free(event_registration, user_data, free_cb_function)
    ccall((:PMPI_T_event_handle_free, libmpi), Cint, (MPI_T_event_registration, Ptr{Cvoid}, MPI_T_event_free_cb_function), event_registration, user_data, free_cb_function)
end

function PMPI_T_event_handle_get_info(event_registration, info_used)
    ccall((:PMPI_T_event_handle_get_info, libmpi), Cint, (MPI_T_event_registration, Ptr{MPI_Info}), event_registration, info_used)
end

function PMPI_T_event_handle_set_info(event_registration, info)
    ccall((:PMPI_T_event_handle_set_info, libmpi), Cint, (MPI_T_event_registration, MPI_Info), event_registration, info)
end

function PMPI_T_event_read(event_instance, element_index, buffer)
    ccall((:PMPI_T_event_read, libmpi), Cint, (MPI_T_event_instance, Cint, Ptr{Cvoid}), event_instance, element_index, buffer)
end

function PMPI_T_event_register_callback(event_registration, cb_safety, info, user_data, event_cb_function)
    ccall((:PMPI_T_event_register_callback, libmpi), Cint, (MPI_T_event_registration, MPI_T_cb_safety, MPI_Info, Ptr{Cvoid}, MPI_T_event_cb_function), event_registration, cb_safety, info, user_data, event_cb_function)
end

function PMPI_T_event_set_dropped_handler(event_registration, dropped_cb_function)
    ccall((:PMPI_T_event_set_dropped_handler, libmpi), Cint, (MPI_T_event_registration, MPI_T_event_dropped_cb_function), event_registration, dropped_cb_function)
end

function PMPI_T_finalize()
    ccall((:PMPI_T_finalize, libmpi), Cint, ())
end

function PMPI_T_init_thread(required, provided)
    ccall((:PMPI_T_init_thread, libmpi), Cint, (Cint, Ptr{Cint}), required, provided)
end

function PMPI_T_pvar_get_index(name, var_class, pvar_index)
    ccall((:PMPI_T_pvar_get_index, libmpi), Cint, (Ptr{Cchar}, Cint, Ptr{Cint}), name, var_class, pvar_index)
end

function PMPI_T_pvar_get_info(pvar_index, name, name_len, verbosity, var_class, datatype, enumtype, desc, desc_len, bind, readonly, continuous, atomic)
    ccall((:PMPI_T_pvar_get_info, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{MPI_T_enum}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), pvar_index, name, name_len, verbosity, var_class, datatype, enumtype, desc, desc_len, bind, readonly, continuous, atomic)
end

function PMPI_T_pvar_get_num(num_pvar)
    ccall((:PMPI_T_pvar_get_num, libmpi), Cint, (Ptr{Cint},), num_pvar)
end

function PMPI_T_pvar_handle_alloc(session, pvar_index, obj_handle, handle, count)
    ccall((:PMPI_T_pvar_handle_alloc, libmpi), Cint, (MPI_T_pvar_session, Cint, Ptr{Cvoid}, Ptr{MPI_T_pvar_handle}, Ptr{Cint}), session, pvar_index, obj_handle, handle, count)
end

function PMPI_T_pvar_handle_free(session, handle)
    ccall((:PMPI_T_pvar_handle_free, libmpi), Cint, (MPI_T_pvar_session, Ptr{MPI_T_pvar_handle}), session, handle)
end

function PMPI_T_pvar_read(session, handle, buf)
    ccall((:PMPI_T_pvar_read, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle, Ptr{Cvoid}), session, handle, buf)
end

function PMPI_T_pvar_readreset(session, handle, buf)
    ccall((:PMPI_T_pvar_readreset, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle, Ptr{Cvoid}), session, handle, buf)
end

function PMPI_T_pvar_reset(session, handle)
    ccall((:PMPI_T_pvar_reset, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle), session, handle)
end

function PMPI_T_pvar_session_create(session)
    ccall((:PMPI_T_pvar_session_create, libmpi), Cint, (Ptr{MPI_T_pvar_session},), session)
end

function PMPI_T_pvar_session_free(session)
    ccall((:PMPI_T_pvar_session_free, libmpi), Cint, (Ptr{MPI_T_pvar_session},), session)
end

function PMPI_T_pvar_start(session, handle)
    ccall((:PMPI_T_pvar_start, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle), session, handle)
end

function PMPI_T_pvar_stop(session, handle)
    ccall((:PMPI_T_pvar_stop, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle), session, handle)
end

function PMPI_T_pvar_write(session, handle, buf)
    ccall((:PMPI_T_pvar_write, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle, Ptr{Cvoid}), session, handle, buf)
end

function PMPI_T_source_get_info(source_index, name, name_len, desc, desc_len, ordering, ticks_per_second, max_ticks, info)
    ccall((:PMPI_T_source_get_info, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}, Ptr{MPI_T_source_order}, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Info}), source_index, name, name_len, desc, desc_len, ordering, ticks_per_second, max_ticks, info)
end

function PMPI_T_source_get_num(num_sources)
    ccall((:PMPI_T_source_get_num, libmpi), Cint, (Ptr{Cint},), num_sources)
end

function PMPI_T_source_get_timestamp(source_index, timestamp)
    ccall((:PMPI_T_source_get_timestamp, libmpi), Cint, (Cint, Ptr{MPI_Count}), source_index, timestamp)
end

function PMPI_Op_commutative(op, commute)
    ccall((:PMPI_Op_commutative, libmpi), Cint, (MPI_Op, Ptr{Cint}), op, commute)
end

function PMPI_Op_create(user_fn, commute, op)
    ccall((:PMPI_Op_create, libmpi), Cint, (Ptr{Cvoid}, Cint, Ptr{MPI_Op}), user_fn, commute, op)
end

function PMPI_Op_create_c(user_fn, commute, op)
    ccall((:PMPI_Op_create_c, libmpi), Cint, (Ptr{Cvoid}, Cint, Ptr{MPI_Op}), user_fn, commute, op)
end

function PMPI_Op_free(op)
    ccall((:PMPI_Op_free, libmpi), Cint, (Ptr{MPI_Op},), op)
end

function PMPI_Parrived(request, partition, flag)
    ccall((:PMPI_Parrived, libmpi), Cint, (MPI_Request, Cint, Ptr{Cint}), request, partition, flag)
end

function PMPI_Pready(partition, request)
    ccall((:PMPI_Pready, libmpi), Cint, (Cint, MPI_Request), partition, request)
end

function PMPI_Pready_list(length, array_of_partitions, request)
    ccall((:PMPI_Pready_list, libmpi), Cint, (Cint, Ptr{Cint}, MPI_Request), length, array_of_partitions, request)
end

function PMPI_Pready_range(partition_low, partition_high, request)
    ccall((:PMPI_Pready_range, libmpi), Cint, (Cint, Cint, MPI_Request), partition_low, partition_high, request)
end

function PMPI_Precv_init(buf, partitions, count, datatype, dest, tag, comm, info, request)
    ccall((:PMPI_Precv_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), buf, partitions, count, datatype, dest, tag, comm, info, request)
end

function PMPI_Psend_init(buf, partitions, count, datatype, dest, tag, comm, info, request)
    ccall((:PMPI_Psend_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), buf, partitions, count, datatype, dest, tag, comm, info, request)
end

function PMPI_Bsend(buf, count, datatype, dest, tag, comm)
    ccall((:PMPI_Bsend, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

function PMPI_Bsend_c(buf, count, datatype, dest, tag, comm)
    ccall((:PMPI_Bsend_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

function PMPI_Bsend_init(buf, count, datatype, dest, tag, comm, request)
    ccall((:PMPI_Bsend_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function PMPI_Bsend_init_c(buf, count, datatype, dest, tag, comm, request)
    ccall((:PMPI_Bsend_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function PMPI_Buffer_attach(buffer, size)
    ccall((:PMPI_Buffer_attach, libmpi), Cint, (Ptr{Cvoid}, Cint), buffer, size)
end

function PMPI_Buffer_attach_c(buffer, size)
    ccall((:PMPI_Buffer_attach_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count), buffer, size)
end

function PMPI_Buffer_detach(buffer_addr, size)
    ccall((:PMPI_Buffer_detach, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cint}), buffer_addr, size)
end

function PMPI_Buffer_detach_c(buffer_addr, size)
    ccall((:PMPI_Buffer_detach_c, libmpi), Cint, (Ptr{Cvoid}, Ptr{MPI_Count}), buffer_addr, size)
end

function PMPI_Ibsend(buf, count, datatype, dest, tag, comm, request)
    ccall((:PMPI_Ibsend, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function PMPI_Ibsend_c(buf, count, datatype, dest, tag, comm, request)
    ccall((:PMPI_Ibsend_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function PMPI_Improbe(source, tag, comm, flag, message, status)
    ccall((:PMPI_Improbe, libmpi), Cint, (Cint, Cint, MPI_Comm, Ptr{Cint}, Ptr{MPI_Message}, Ptr{MPI_Status}), source, tag, comm, flag, message, status)
end

function PMPI_Imrecv(buf, count, datatype, message, request)
    ccall((:PMPI_Imrecv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Request}), buf, count, datatype, message, request)
end

function PMPI_Imrecv_c(buf, count, datatype, message, request)
    ccall((:PMPI_Imrecv_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Request}), buf, count, datatype, message, request)
end

function PMPI_Iprobe(source, tag, comm, flag, status)
    ccall((:PMPI_Iprobe, libmpi), Cint, (Cint, Cint, MPI_Comm, Ptr{Cint}, Ptr{MPI_Status}), source, tag, comm, flag, status)
end

function PMPI_Irecv(buf, count, datatype, source, tag, comm, request)
    ccall((:PMPI_Irecv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, source, tag, comm, request)
end

function PMPI_Irecv_c(buf, count, datatype, source, tag, comm, request)
    ccall((:PMPI_Irecv_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, source, tag, comm, request)
end

function PMPI_Irsend(buf, count, datatype, dest, tag, comm, request)
    ccall((:PMPI_Irsend, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function PMPI_Irsend_c(buf, count, datatype, dest, tag, comm, request)
    ccall((:PMPI_Irsend_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function PMPI_Isend(buf, count, datatype, dest, tag, comm, request)
    ccall((:PMPI_Isend, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function PMPI_Isend_c(buf, count, datatype, dest, tag, comm, request)
    ccall((:PMPI_Isend_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function PMPI_Isendrecv(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
    ccall((:PMPI_Isendrecv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
end

function PMPI_Isendrecv_c(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
    ccall((:PMPI_Isendrecv_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
end

function PMPI_Isendrecv_replace(buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
    ccall((:PMPI_Isendrecv_replace, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
end

function PMPI_Isendrecv_replace_c(buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
    ccall((:PMPI_Isendrecv_replace_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
end

function PMPI_Issend(buf, count, datatype, dest, tag, comm, request)
    ccall((:PMPI_Issend, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function PMPI_Issend_c(buf, count, datatype, dest, tag, comm, request)
    ccall((:PMPI_Issend_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function PMPI_Mprobe(source, tag, comm, message, status)
    ccall((:PMPI_Mprobe, libmpi), Cint, (Cint, Cint, MPI_Comm, Ptr{MPI_Message}, Ptr{MPI_Status}), source, tag, comm, message, status)
end

function PMPI_Mrecv(buf, count, datatype, message, status)
    ccall((:PMPI_Mrecv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Status}), buf, count, datatype, message, status)
end

function PMPI_Mrecv_c(buf, count, datatype, message, status)
    ccall((:PMPI_Mrecv_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Status}), buf, count, datatype, message, status)
end

function PMPI_Probe(source, tag, comm, status)
    ccall((:PMPI_Probe, libmpi), Cint, (Cint, Cint, MPI_Comm, Ptr{MPI_Status}), source, tag, comm, status)
end

function PMPI_Recv(buf, count, datatype, source, tag, comm, status)
    ccall((:PMPI_Recv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), buf, count, datatype, source, tag, comm, status)
end

function PMPI_Recv_c(buf, count, datatype, source, tag, comm, status)
    ccall((:PMPI_Recv_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), buf, count, datatype, source, tag, comm, status)
end

function PMPI_Recv_init(buf, count, datatype, source, tag, comm, request)
    ccall((:PMPI_Recv_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, source, tag, comm, request)
end

function PMPI_Recv_init_c(buf, count, datatype, source, tag, comm, request)
    ccall((:PMPI_Recv_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, source, tag, comm, request)
end

function PMPI_Rsend(buf, count, datatype, dest, tag, comm)
    ccall((:PMPI_Rsend, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

function PMPI_Rsend_c(buf, count, datatype, dest, tag, comm)
    ccall((:PMPI_Rsend_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

function PMPI_Rsend_init(buf, count, datatype, dest, tag, comm, request)
    ccall((:PMPI_Rsend_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function PMPI_Rsend_init_c(buf, count, datatype, dest, tag, comm, request)
    ccall((:PMPI_Rsend_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function PMPI_Send(buf, count, datatype, dest, tag, comm)
    ccall((:PMPI_Send, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

function PMPI_Send_c(buf, count, datatype, dest, tag, comm)
    ccall((:PMPI_Send_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

function PMPI_Send_init(buf, count, datatype, dest, tag, comm, request)
    ccall((:PMPI_Send_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function PMPI_Send_init_c(buf, count, datatype, dest, tag, comm, request)
    ccall((:PMPI_Send_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function PMPI_Sendrecv(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
    ccall((:PMPI_Sendrecv, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
end

function PMPI_Sendrecv_c(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
    ccall((:PMPI_Sendrecv_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
end

function PMPI_Sendrecv_replace(buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
    ccall((:PMPI_Sendrecv_replace, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
end

function PMPI_Sendrecv_replace_c(buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
    ccall((:PMPI_Sendrecv_replace_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
end

function PMPI_Ssend(buf, count, datatype, dest, tag, comm)
    ccall((:PMPI_Ssend, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

function PMPI_Ssend_c(buf, count, datatype, dest, tag, comm)
    ccall((:PMPI_Ssend_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

function PMPI_Ssend_init(buf, count, datatype, dest, tag, comm, request)
    ccall((:PMPI_Ssend_init, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function PMPI_Ssend_init_c(buf, count, datatype, dest, tag, comm, request)
    ccall((:PMPI_Ssend_init_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

function PMPI_Cancel(request)
    ccall((:PMPI_Cancel, libmpi), Cint, (Ptr{MPI_Request},), request)
end

function PMPI_Grequest_complete(request)
    ccall((:PMPI_Grequest_complete, libmpi), Cint, (MPI_Request,), request)
end

function PMPI_Grequest_start(query_fn, free_fn, cancel_fn, extra_state, request)
    ccall((:PMPI_Grequest_start, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{MPI_Request}), query_fn, free_fn, cancel_fn, extra_state, request)
end

function PMPI_Request_free(request)
    ccall((:PMPI_Request_free, libmpi), Cint, (Ptr{MPI_Request},), request)
end

function PMPI_Request_get_status(request, flag, status)
    ccall((:PMPI_Request_get_status, libmpi), Cint, (MPI_Request, Ptr{Cint}, Ptr{MPI_Status}), request, flag, status)
end

function PMPI_Start(request)
    ccall((:PMPI_Start, libmpi), Cint, (Ptr{MPI_Request},), request)
end

function PMPI_Startall(count, array_of_requests)
    ccall((:PMPI_Startall, libmpi), Cint, (Cint, Ptr{MPI_Request}), count, array_of_requests)
end

function PMPI_Status_set_cancelled(status, flag)
    ccall((:PMPI_Status_set_cancelled, libmpi), Cint, (Ptr{MPI_Status}, Cint), status, flag)
end

function PMPI_Test_cancelled(status, flag)
    ccall((:PMPI_Test_cancelled, libmpi), Cint, (Ptr{MPI_Status}, Ptr{Cint}), status, flag)
end

function PMPI_Testall(count, array_of_requests, flag, array_of_statuses)
    ccall((:PMPI_Testall, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{MPI_Status}), count, array_of_requests, flag, array_of_statuses)
end

function PMPI_Testany(count, array_of_requests, indx, flag, status)
    ccall((:PMPI_Testany, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Status}), count, array_of_requests, indx, flag, status)
end

function PMPI_Testsome(incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
    ccall((:PMPI_Testsome, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Status}), incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
end

function PMPI_Waitall(count, array_of_requests, array_of_statuses)
    ccall((:PMPI_Waitall, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{MPI_Status}), count, array_of_requests, array_of_statuses)
end

function PMPI_Waitany(count, array_of_requests, indx, status)
    ccall((:PMPI_Waitany, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{MPI_Status}), count, array_of_requests, indx, status)
end

function PMPI_Waitsome(incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
    ccall((:PMPI_Waitsome, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Status}), incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
end

function PMPIX_Grequest_start(query_fn, free_fn, cancel_fn, poll_fn, wait_fn, extra_state, request)
    ccall((:PMPIX_Grequest_start, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{MPI_Request}), query_fn, free_fn, cancel_fn, poll_fn, wait_fn, extra_state, request)
end

function PMPIX_Grequest_class_create(query_fn, free_fn, cancel_fn, poll_fn, wait_fn, greq_class)
    ccall((:PMPIX_Grequest_class_create, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{MPIX_Grequest_class}), query_fn, free_fn, cancel_fn, poll_fn, wait_fn, greq_class)
end

function PMPIX_Grequest_class_allocate(greq_class, extra_state, request)
    ccall((:PMPIX_Grequest_class_allocate, libmpi), Cint, (MPIX_Grequest_class, Ptr{Cvoid}, Ptr{MPI_Request}), greq_class, extra_state, request)
end

function PMPI_Accumulate(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    ccall((:PMPI_Accumulate, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

function PMPI_Accumulate_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    ccall((:PMPI_Accumulate_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Op, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

function PMPI_Alloc_mem(size, info, baseptr)
    ccall((:PMPI_Alloc_mem, libmpi), Cint, (MPI_Aint, MPI_Info, Ptr{Cvoid}), size, info, baseptr)
end

function PMPI_Compare_and_swap(origin_addr, compare_addr, result_addr, datatype, target_rank, target_disp, win)
    ccall((:PMPI_Compare_and_swap, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, MPI_Datatype, Cint, MPI_Aint, MPI_Win), origin_addr, compare_addr, result_addr, datatype, target_rank, target_disp, win)
end

function PMPI_Fetch_and_op(origin_addr, result_addr, datatype, target_rank, target_disp, op, win)
    ccall((:PMPI_Fetch_and_op, libmpi), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, MPI_Datatype, Cint, MPI_Aint, MPI_Op, MPI_Win), origin_addr, result_addr, datatype, target_rank, target_disp, op, win)
end

function PMPI_Free_mem(base)
    ccall((:PMPI_Free_mem, libmpi), Cint, (Ptr{Cvoid},), base)
end

function PMPI_Get(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    ccall((:PMPI_Get, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

function PMPI_Get_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    ccall((:PMPI_Get_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

function PMPI_Get_accumulate(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    ccall((:PMPI_Get_accumulate, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win), origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

function PMPI_Get_accumulate_c(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    ccall((:PMPI_Get_accumulate_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Op, MPI_Win), origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

function PMPI_Put(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    ccall((:PMPI_Put, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

function PMPI_Put_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    ccall((:PMPI_Put_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

function PMPI_Raccumulate(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    ccall((:PMPI_Raccumulate, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

function PMPI_Raccumulate_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    ccall((:PMPI_Raccumulate_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

function PMPI_Rget(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    ccall((:PMPI_Rget, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

function PMPI_Rget_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    ccall((:PMPI_Rget_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

function PMPI_Rget_accumulate(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    ccall((:PMPI_Rget_accumulate, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

function PMPI_Rget_accumulate_c(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    ccall((:PMPI_Rget_accumulate_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

function PMPI_Rput(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    ccall((:PMPI_Rput, libmpi), Cint, (Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

function PMPI_Rput_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    ccall((:PMPI_Rput_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

function PMPI_Win_allocate(size, disp_unit, info, comm, baseptr, win)
    ccall((:PMPI_Win_allocate, libmpi), Cint, (MPI_Aint, Cint, MPI_Info, MPI_Comm, Ptr{Cvoid}, Ptr{MPI_Win}), size, disp_unit, info, comm, baseptr, win)
end

function PMPI_Win_allocate_c(size, disp_unit, info, comm, baseptr, win)
    ccall((:PMPI_Win_allocate_c, libmpi), Cint, (MPI_Aint, MPI_Aint, MPI_Info, MPI_Comm, Ptr{Cvoid}, Ptr{MPI_Win}), size, disp_unit, info, comm, baseptr, win)
end

function PMPI_Win_allocate_shared(size, disp_unit, info, comm, baseptr, win)
    ccall((:PMPI_Win_allocate_shared, libmpi), Cint, (MPI_Aint, Cint, MPI_Info, MPI_Comm, Ptr{Cvoid}, Ptr{MPI_Win}), size, disp_unit, info, comm, baseptr, win)
end

function PMPI_Win_allocate_shared_c(size, disp_unit, info, comm, baseptr, win)
    ccall((:PMPI_Win_allocate_shared_c, libmpi), Cint, (MPI_Aint, MPI_Aint, MPI_Info, MPI_Comm, Ptr{Cvoid}, Ptr{MPI_Win}), size, disp_unit, info, comm, baseptr, win)
end

function PMPI_Win_attach(win, base, size)
    ccall((:PMPI_Win_attach, libmpi), Cint, (MPI_Win, Ptr{Cvoid}, MPI_Aint), win, base, size)
end

function PMPI_Win_complete(win)
    ccall((:PMPI_Win_complete, libmpi), Cint, (MPI_Win,), win)
end

function PMPI_Win_create(base, size, disp_unit, info, comm, win)
    ccall((:PMPI_Win_create, libmpi), Cint, (Ptr{Cvoid}, MPI_Aint, Cint, MPI_Info, MPI_Comm, Ptr{MPI_Win}), base, size, disp_unit, info, comm, win)
end

function PMPI_Win_create_c(base, size, disp_unit, info, comm, win)
    ccall((:PMPI_Win_create_c, libmpi), Cint, (Ptr{Cvoid}, MPI_Aint, MPI_Aint, MPI_Info, MPI_Comm, Ptr{MPI_Win}), base, size, disp_unit, info, comm, win)
end

function PMPI_Win_create_dynamic(info, comm, win)
    ccall((:PMPI_Win_create_dynamic, libmpi), Cint, (MPI_Info, MPI_Comm, Ptr{MPI_Win}), info, comm, win)
end

function PMPI_Win_detach(win, base)
    ccall((:PMPI_Win_detach, libmpi), Cint, (MPI_Win, Ptr{Cvoid}), win, base)
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

function PMPI_Win_set_info(win, info)
    ccall((:PMPI_Win_set_info, libmpi), Cint, (MPI_Win, MPI_Info), win, info)
end

function PMPI_Win_set_name(win, win_name)
    ccall((:PMPI_Win_set_name, libmpi), Cint, (MPI_Win, Ptr{Cchar}), win, win_name)
end

function PMPI_Win_shared_query(win, rank, size, disp_unit, baseptr)
    ccall((:PMPI_Win_shared_query, libmpi), Cint, (MPI_Win, Cint, Ptr{MPI_Aint}, Ptr{Cint}, Ptr{Cvoid}), win, rank, size, disp_unit, baseptr)
end

function PMPI_Win_shared_query_c(win, rank, size, disp_unit, baseptr)
    ccall((:PMPI_Win_shared_query_c, libmpi), Cint, (MPI_Win, Cint, Ptr{MPI_Aint}, Ptr{MPI_Aint}, Ptr{Cvoid}), win, rank, size, disp_unit, baseptr)
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

function PMPI_Close_port(port_name)
    ccall((:PMPI_Close_port, libmpi), Cint, (Ptr{Cchar},), port_name)
end

function PMPI_Comm_accept(port_name, info, root, comm, newcomm)
    ccall((:PMPI_Comm_accept, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Cint, MPI_Comm, Ptr{MPI_Comm}), port_name, info, root, comm, newcomm)
end

function PMPI_Comm_connect(port_name, info, root, comm, newcomm)
    ccall((:PMPI_Comm_connect, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Cint, MPI_Comm, Ptr{MPI_Comm}), port_name, info, root, comm, newcomm)
end

function PMPI_Comm_disconnect(comm)
    ccall((:PMPI_Comm_disconnect, libmpi), Cint, (Ptr{MPI_Comm},), comm)
end

function PMPI_Comm_get_parent(parent)
    ccall((:PMPI_Comm_get_parent, libmpi), Cint, (Ptr{MPI_Comm},), parent)
end

function PMPI_Comm_join(fd, intercomm)
    ccall((:PMPI_Comm_join, libmpi), Cint, (Cint, Ptr{MPI_Comm}), fd, intercomm)
end

function PMPI_Comm_spawn(command, argv, maxprocs, info, root, comm, intercomm, array_of_errcodes)
    ccall((:PMPI_Comm_spawn, libmpi), Cint, (Ptr{Cchar}, Ptr{Ptr{Cchar}}, Cint, MPI_Info, Cint, MPI_Comm, Ptr{MPI_Comm}, Ptr{Cint}), command, argv, maxprocs, info, root, comm, intercomm, array_of_errcodes)
end

function PMPI_Comm_spawn_multiple(count, array_of_commands, array_of_argv, array_of_maxprocs, array_of_info, root, comm, intercomm, array_of_errcodes)
    ccall((:PMPI_Comm_spawn_multiple, libmpi), Cint, (Cint, Ptr{Ptr{Cchar}}, Ptr{Ptr{Ptr{Cchar}}}, Ptr{Cint}, Ptr{MPI_Info}, Cint, MPI_Comm, Ptr{MPI_Comm}, Ptr{Cint}), count, array_of_commands, array_of_argv, array_of_maxprocs, array_of_info, root, comm, intercomm, array_of_errcodes)
end

function PMPI_Lookup_name(service_name, info, port_name)
    ccall((:PMPI_Lookup_name, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Ptr{Cchar}), service_name, info, port_name)
end

function PMPI_Open_port(info, port_name)
    ccall((:PMPI_Open_port, libmpi), Cint, (MPI_Info, Ptr{Cchar}), info, port_name)
end

function PMPI_Publish_name(service_name, info, port_name)
    ccall((:PMPI_Publish_name, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Ptr{Cchar}), service_name, info, port_name)
end

function PMPI_Unpublish_name(service_name, info, port_name)
    ccall((:PMPI_Unpublish_name, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Ptr{Cchar}), service_name, info, port_name)
end

function PMPI_Wtick()
    ccall((:PMPI_Wtick, libmpi), Cdouble, ())
end

function PMPI_Wtime()
    ccall((:PMPI_Wtime, libmpi), Cdouble, ())
end

function PMPI_Cart_coords(comm, rank, maxdims, coords)
    ccall((:PMPI_Cart_coords, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{Cint}), comm, rank, maxdims, coords)
end

function PMPI_Cart_create(comm_old, ndims, dims, periods, reorder, comm_cart)
    ccall((:PMPI_Cart_create, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{MPI_Comm}), comm_old, ndims, dims, periods, reorder, comm_cart)
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

function PMPI_Cart_sub(comm, remain_dims, newcomm)
    ccall((:PMPI_Cart_sub, libmpi), Cint, (MPI_Comm, Ptr{Cint}, Ptr{MPI_Comm}), comm, remain_dims, newcomm)
end

function PMPI_Cartdim_get(comm, ndims)
    ccall((:PMPI_Cartdim_get, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, ndims)
end

function PMPI_Dims_create(nnodes, ndims, dims)
    ccall((:PMPI_Dims_create, libmpi), Cint, (Cint, Cint, Ptr{Cint}), nnodes, ndims, dims)
end

function PMPI_Dist_graph_create(comm_old, n, sources, degrees, destinations, weights, info, reorder, comm_dist_graph)
    ccall((:PMPI_Dist_graph_create, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, MPI_Info, Cint, Ptr{MPI_Comm}), comm_old, n, sources, degrees, destinations, weights, info, reorder, comm_dist_graph)
end

function PMPI_Dist_graph_create_adjacent(comm_old, indegree, sources, sourceweights, outdegree, destinations, destweights, info, reorder, comm_dist_graph)
    ccall((:PMPI_Dist_graph_create_adjacent, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{Cint}, Ptr{Cint}, MPI_Info, Cint, Ptr{MPI_Comm}), comm_old, indegree, sources, sourceweights, outdegree, destinations, destweights, info, reorder, comm_dist_graph)
end

function PMPI_Dist_graph_neighbors(comm, maxindegree, sources, sourceweights, maxoutdegree, destinations, destweights)
    ccall((:PMPI_Dist_graph_neighbors, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{Cint}, Ptr{Cint}), comm, maxindegree, sources, sourceweights, maxoutdegree, destinations, destweights)
end

function PMPI_Dist_graph_neighbors_count(comm, indegree, outdegree, weighted)
    ccall((:PMPI_Dist_graph_neighbors_count, libmpi), Cint, (MPI_Comm, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), comm, indegree, outdegree, weighted)
end

function PMPI_Graph_create(comm_old, nnodes, indx, edges, reorder, comm_graph)
    ccall((:PMPI_Graph_create, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{MPI_Comm}), comm_old, nnodes, indx, edges, reorder, comm_graph)
end

function PMPI_Graph_get(comm, maxindex, maxedges, indx, edges)
    ccall((:PMPI_Graph_get, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{Cint}, Ptr{Cint}), comm, maxindex, maxedges, indx, edges)
end

function PMPI_Graph_map(comm, nnodes, indx, edges, newrank)
    ccall((:PMPI_Graph_map, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), comm, nnodes, indx, edges, newrank)
end

function PMPI_Graph_neighbors(comm, rank, maxneighbors, neighbors)
    ccall((:PMPI_Graph_neighbors, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{Cint}), comm, rank, maxneighbors, neighbors)
end

function PMPI_Graph_neighbors_count(comm, rank, nneighbors)
    ccall((:PMPI_Graph_neighbors_count, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}), comm, rank, nneighbors)
end

function PMPI_Graphdims_get(comm, nnodes, nedges)
    ccall((:PMPI_Graphdims_get, libmpi), Cint, (MPI_Comm, Ptr{Cint}, Ptr{Cint}), comm, nnodes, nedges)
end

function PMPI_Topo_test(comm, status)
    ccall((:PMPI_Topo_test, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, status)
end

function QMPI_Attr_delete(context, tool_id, comm, keyval)
    ccall((:QMPI_Attr_delete, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint), context, tool_id, comm, keyval)
end

function QMPI_Attr_get(context, tool_id, comm, keyval, attribute_val, flag)
    ccall((:QMPI_Attr_get, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Ptr{Cvoid}, Ptr{Cint}), context, tool_id, comm, keyval, attribute_val, flag)
end

function QMPI_Attr_put(context, tool_id, comm, keyval, attribute_val)
    ccall((:QMPI_Attr_put, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Ptr{Cvoid}), context, tool_id, comm, keyval, attribute_val)
end

function QMPI_Comm_create_keyval(context, tool_id, comm_copy_attr_fn, comm_delete_attr_fn, comm_keyval, extra_state)
    ccall((:QMPI_Comm_create_keyval, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cvoid}), context, tool_id, comm_copy_attr_fn, comm_delete_attr_fn, comm_keyval, extra_state)
end

function QMPI_Comm_delete_attr(context, tool_id, comm, comm_keyval)
    ccall((:QMPI_Comm_delete_attr, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint), context, tool_id, comm, comm_keyval)
end

function QMPI_Comm_free_keyval(context, tool_id, comm_keyval)
    ccall((:QMPI_Comm_free_keyval, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, comm_keyval)
end

function QMPI_Comm_get_attr(context, tool_id, comm, comm_keyval, attribute_val, flag)
    ccall((:QMPI_Comm_get_attr, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Ptr{Cvoid}, Ptr{Cint}), context, tool_id, comm, comm_keyval, attribute_val, flag)
end

function QMPI_Comm_set_attr(context, tool_id, comm, comm_keyval, attribute_val)
    ccall((:QMPI_Comm_set_attr, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Ptr{Cvoid}), context, tool_id, comm, comm_keyval, attribute_val)
end

function QMPI_Keyval_create(context, tool_id, copy_fn, delete_fn, keyval, extra_state)
    ccall((:QMPI_Keyval_create, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cvoid}), context, tool_id, copy_fn, delete_fn, keyval, extra_state)
end

function QMPI_Keyval_free(context, tool_id, keyval)
    ccall((:QMPI_Keyval_free, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, keyval)
end

function QMPI_Type_create_keyval(context, tool_id, type_copy_attr_fn, type_delete_attr_fn, type_keyval, extra_state)
    ccall((:QMPI_Type_create_keyval, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cvoid}), context, tool_id, type_copy_attr_fn, type_delete_attr_fn, type_keyval, extra_state)
end

function QMPI_Type_delete_attr(context, tool_id, datatype, type_keyval)
    ccall((:QMPI_Type_delete_attr, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Cint), context, tool_id, datatype, type_keyval)
end

function QMPI_Type_free_keyval(context, tool_id, type_keyval)
    ccall((:QMPI_Type_free_keyval, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, type_keyval)
end

function QMPI_Type_get_attr(context, tool_id, datatype, type_keyval, attribute_val, flag)
    ccall((:QMPI_Type_get_attr, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Cint, Ptr{Cvoid}, Ptr{Cint}), context, tool_id, datatype, type_keyval, attribute_val, flag)
end

function QMPI_Type_set_attr(context, tool_id, datatype, type_keyval, attribute_val)
    ccall((:QMPI_Type_set_attr, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Cint, Ptr{Cvoid}), context, tool_id, datatype, type_keyval, attribute_val)
end

function QMPI_Win_create_keyval(context, tool_id, win_copy_attr_fn, win_delete_attr_fn, win_keyval, extra_state)
    ccall((:QMPI_Win_create_keyval, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cvoid}), context, tool_id, win_copy_attr_fn, win_delete_attr_fn, win_keyval, extra_state)
end

function QMPI_Win_delete_attr(context, tool_id, win, win_keyval)
    ccall((:QMPI_Win_delete_attr, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, Cint), context, tool_id, win, win_keyval)
end

function QMPI_Win_free_keyval(context, tool_id, win_keyval)
    ccall((:QMPI_Win_free_keyval, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, win_keyval)
end

function QMPI_Win_get_attr(context, tool_id, win, win_keyval, attribute_val, flag)
    ccall((:QMPI_Win_get_attr, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, Cint, Ptr{Cvoid}, Ptr{Cint}), context, tool_id, win, win_keyval, attribute_val, flag)
end

function QMPI_Win_set_attr(context, tool_id, win, win_keyval, attribute_val)
    ccall((:QMPI_Win_set_attr, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, Cint, Ptr{Cvoid}), context, tool_id, win, win_keyval, attribute_val)
end

function QMPI_Allgather(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:QMPI_Allgather, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function QMPI_Allgather_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:QMPI_Allgather_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function QMPI_Allgather_init(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    ccall((:QMPI_Allgather_init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

function QMPI_Allgather_init_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    ccall((:QMPI_Allgather_init_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

function QMPI_Allgatherv(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    ccall((:QMPI_Allgatherv, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

function QMPI_Allgatherv_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    ccall((:QMPI_Allgatherv_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

function QMPI_Allgatherv_init(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    ccall((:QMPI_Allgatherv_init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
end

function QMPI_Allgatherv_init_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    ccall((:QMPI_Allgatherv_init_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
end

function QMPI_Allreduce(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)
    ccall((:QMPI_Allreduce, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)
end

function QMPI_Allreduce_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)
    ccall((:QMPI_Allreduce_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)
end

function QMPI_Allreduce_init(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)
    ccall((:QMPI_Allreduce_init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

function QMPI_Allreduce_init_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)
    ccall((:QMPI_Allreduce_init_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

function QMPI_Alltoall(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:QMPI_Alltoall, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function QMPI_Alltoall_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:QMPI_Alltoall_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function QMPI_Alltoall_init(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    ccall((:QMPI_Alltoall_init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

function QMPI_Alltoall_init_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    ccall((:QMPI_Alltoall_init_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

function QMPI_Alltoallv(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    ccall((:QMPI_Alltoallv, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

function QMPI_Alltoallv_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    ccall((:QMPI_Alltoallv_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

function QMPI_Alltoallv_init(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    ccall((:QMPI_Alltoallv_init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
end

function QMPI_Alltoallv_init_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    ccall((:QMPI_Alltoallv_init_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
end

function QMPI_Alltoallw(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    ccall((:QMPI_Alltoallw, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPI_Comm), context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

function QMPI_Alltoallw_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    ccall((:QMPI_Alltoallw_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm), context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

function QMPI_Alltoallw_init(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    ccall((:QMPI_Alltoallw_init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
end

function QMPI_Alltoallw_init_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    ccall((:QMPI_Alltoallw_init_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
end

function QMPI_Barrier(context, tool_id, comm)
    ccall((:QMPI_Barrier, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm), context, tool_id, comm)
end

function QMPI_Barrier_init(context, tool_id, comm, info, request)
    ccall((:QMPI_Barrier_init, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, comm, info, request)
end

function QMPI_Bcast(context, tool_id, buffer, count, datatype, root, comm)
    ccall((:QMPI_Bcast, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm), context, tool_id, buffer, count, datatype, root, comm)
end

function QMPI_Bcast_c(context, tool_id, buffer, count, datatype, root, comm)
    ccall((:QMPI_Bcast_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm), context, tool_id, buffer, count, datatype, root, comm)
end

function QMPI_Bcast_init(context, tool_id, buffer, count, datatype, root, comm, info, request)
    ccall((:QMPI_Bcast_init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, buffer, count, datatype, root, comm, info, request)
end

function QMPI_Bcast_init_c(context, tool_id, buffer, count, datatype, root, comm, info, request)
    ccall((:QMPI_Bcast_init_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, buffer, count, datatype, root, comm, info, request)
end

function QMPI_Exscan(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)
    ccall((:QMPI_Exscan, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)
end

function QMPI_Exscan_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)
    ccall((:QMPI_Exscan_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)
end

function QMPI_Exscan_init(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)
    ccall((:QMPI_Exscan_init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

function QMPI_Exscan_init_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)
    ccall((:QMPI_Exscan_init_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

function QMPI_Gather(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    ccall((:QMPI_Gather, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

function QMPI_Gather_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    ccall((:QMPI_Gather_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

function QMPI_Gather_init(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    ccall((:QMPI_Gather_init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

function QMPI_Gather_init_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    ccall((:QMPI_Gather_init_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

function QMPI_Gatherv(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
    ccall((:QMPI_Gatherv, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
end

function QMPI_Gatherv_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
    ccall((:QMPI_Gatherv_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Cint, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
end

function QMPI_Gatherv_init(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
    ccall((:QMPI_Gatherv_init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
end

function QMPI_Gatherv_init_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
    ccall((:QMPI_Gatherv_init_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
end

function QMPI_Iallgather(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:QMPI_Iallgather, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function QMPI_Iallgather_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:QMPI_Iallgather_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function QMPI_Iallgatherv(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    ccall((:QMPI_Iallgatherv, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

function QMPI_Iallgatherv_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    ccall((:QMPI_Iallgatherv_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

function QMPI_Iallreduce(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)
    ccall((:QMPI_Iallreduce, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)
end

function QMPI_Iallreduce_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)
    ccall((:QMPI_Iallreduce_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)
end

function QMPI_Ialltoall(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:QMPI_Ialltoall, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function QMPI_Ialltoall_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:QMPI_Ialltoall_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function QMPI_Ialltoallv(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    ccall((:QMPI_Ialltoallv, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

function QMPI_Ialltoallv_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    ccall((:QMPI_Ialltoallv_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

function QMPI_Ialltoallw(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    ccall((:QMPI_Ialltoallw, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

function QMPI_Ialltoallw_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    ccall((:QMPI_Ialltoallw_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

function QMPI_Ibarrier(context, tool_id, comm, request)
    ccall((:QMPI_Ibarrier, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, comm, request)
end

function QMPI_Ibcast(context, tool_id, buffer, count, datatype, root, comm, request)
    ccall((:QMPI_Ibcast, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buffer, count, datatype, root, comm, request)
end

function QMPI_Ibcast_c(context, tool_id, buffer, count, datatype, root, comm, request)
    ccall((:QMPI_Ibcast_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buffer, count, datatype, root, comm, request)
end

function QMPI_Iexscan(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)
    ccall((:QMPI_Iexscan, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)
end

function QMPI_Iexscan_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)
    ccall((:QMPI_Iexscan_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)
end

function QMPI_Igather(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    ccall((:QMPI_Igather, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

function QMPI_Igather_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    ccall((:QMPI_Igather_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

function QMPI_Igatherv(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
    ccall((:QMPI_Igatherv, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
end

function QMPI_Igatherv_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
    ccall((:QMPI_Igatherv_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
end

function QMPI_Ineighbor_allgather(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:QMPI_Ineighbor_allgather, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function QMPI_Ineighbor_allgather_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:QMPI_Ineighbor_allgather_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function QMPI_Ineighbor_allgatherv(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    ccall((:QMPI_Ineighbor_allgatherv, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

function QMPI_Ineighbor_allgatherv_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    ccall((:QMPI_Ineighbor_allgatherv_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

function QMPI_Ineighbor_alltoall(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:QMPI_Ineighbor_alltoall, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function QMPI_Ineighbor_alltoall_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    ccall((:QMPI_Ineighbor_alltoall_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

function QMPI_Ineighbor_alltoallv(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    ccall((:QMPI_Ineighbor_alltoallv, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

function QMPI_Ineighbor_alltoallv_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    ccall((:QMPI_Ineighbor_alltoallv_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

function QMPI_Ineighbor_alltoallw(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    ccall((:QMPI_Ineighbor_alltoallw, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

function QMPI_Ineighbor_alltoallw_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    ccall((:QMPI_Ineighbor_alltoallw_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

function QMPI_Ireduce(context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm, request)
    ccall((:QMPI_Ireduce, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm, request)
end

function QMPI_Ireduce_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm, request)
    ccall((:QMPI_Ireduce_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm, request)
end

function QMPI_Ireduce_scatter(context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
    ccall((:QMPI_Ireduce_scatter, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
end

function QMPI_Ireduce_scatter_c(context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
    ccall((:QMPI_Ireduce_scatter_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{MPI_Count}, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
end

function QMPI_Ireduce_scatter_block(context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm, request)
    ccall((:QMPI_Ireduce_scatter_block, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm, request)
end

function QMPI_Ireduce_scatter_block_c(context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm, request)
    ccall((:QMPI_Ireduce_scatter_block_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm, request)
end

function QMPI_Iscan(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)
    ccall((:QMPI_Iscan, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)
end

function QMPI_Iscan_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)
    ccall((:QMPI_Iscan_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)
end

function QMPI_Iscatter(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    ccall((:QMPI_Iscatter, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

function QMPI_Iscatter_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    ccall((:QMPI_Iscatter_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

function QMPI_Iscatterv(context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    ccall((:QMPI_Iscatterv, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

function QMPI_Iscatterv_c(context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    ccall((:QMPI_Iscatterv_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

function QMPI_Neighbor_allgather(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:QMPI_Neighbor_allgather, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function QMPI_Neighbor_allgather_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:QMPI_Neighbor_allgather_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function QMPI_Neighbor_allgather_init(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    ccall((:QMPI_Neighbor_allgather_init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

function QMPI_Neighbor_allgather_init_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    ccall((:QMPI_Neighbor_allgather_init_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

function QMPI_Neighbor_allgatherv(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    ccall((:QMPI_Neighbor_allgatherv, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

function QMPI_Neighbor_allgatherv_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    ccall((:QMPI_Neighbor_allgatherv_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

function QMPI_Neighbor_allgatherv_init(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    ccall((:QMPI_Neighbor_allgatherv_init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
end

function QMPI_Neighbor_allgatherv_init_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    ccall((:QMPI_Neighbor_allgatherv_init_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
end

function QMPI_Neighbor_alltoall(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:QMPI_Neighbor_alltoall, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function QMPI_Neighbor_alltoall_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    ccall((:QMPI_Neighbor_alltoall_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

function QMPI_Neighbor_alltoall_init(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    ccall((:QMPI_Neighbor_alltoall_init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

function QMPI_Neighbor_alltoall_init_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    ccall((:QMPI_Neighbor_alltoall_init_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

function QMPI_Neighbor_alltoallv(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    ccall((:QMPI_Neighbor_alltoallv, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

function QMPI_Neighbor_alltoallv_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    ccall((:QMPI_Neighbor_alltoallv_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

function QMPI_Neighbor_alltoallv_init(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    ccall((:QMPI_Neighbor_alltoallv_init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
end

function QMPI_Neighbor_alltoallv_init_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    ccall((:QMPI_Neighbor_alltoallv_init_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
end

function QMPI_Neighbor_alltoallw(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    ccall((:QMPI_Neighbor_alltoallw, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm), context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

function QMPI_Neighbor_alltoallw_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    ccall((:QMPI_Neighbor_alltoallw_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm), context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

function QMPI_Neighbor_alltoallw_init(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    ccall((:QMPI_Neighbor_alltoallw_init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
end

function QMPI_Neighbor_alltoallw_init_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    ccall((:QMPI_Neighbor_alltoallw_init_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
end

function QMPI_Reduce(context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm)
    ccall((:QMPI_Reduce, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm), context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm)
end

function QMPI_Reduce_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm)
    ccall((:QMPI_Reduce_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, Cint, MPI_Comm), context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm)
end

function QMPI_Reduce_init(context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
    ccall((:QMPI_Reduce_init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
end

function QMPI_Reduce_init_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
    ccall((:QMPI_Reduce_init_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
end

function QMPI_Reduce_local(context, tool_id, inbuf, inoutbuf, count, datatype, op)
    ccall((:QMPI_Reduce_local, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op), context, tool_id, inbuf, inoutbuf, count, datatype, op)
end

function QMPI_Reduce_local_c(context, tool_id, inbuf, inoutbuf, count, datatype, op)
    ccall((:QMPI_Reduce_local_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op), context, tool_id, inbuf, inoutbuf, count, datatype, op)
end

function QMPI_Reduce_scatter(context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm)
    ccall((:QMPI_Reduce_scatter, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, MPI_Datatype, MPI_Op, MPI_Comm), context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm)
end

function QMPI_Reduce_scatter_c(context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm)
    ccall((:QMPI_Reduce_scatter_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{MPI_Count}, MPI_Datatype, MPI_Op, MPI_Comm), context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm)
end

function QMPI_Reduce_scatter_block(context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm)
    ccall((:QMPI_Reduce_scatter_block, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm), context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm)
end

function QMPI_Reduce_scatter_block_c(context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm)
    ccall((:QMPI_Reduce_scatter_block_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm), context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm)
end

function QMPI_Reduce_scatter_block_init(context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
    ccall((:QMPI_Reduce_scatter_block_init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
end

function QMPI_Reduce_scatter_block_init_c(context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
    ccall((:QMPI_Reduce_scatter_block_init_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
end

function QMPI_Reduce_scatter_init(context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
    ccall((:QMPI_Reduce_scatter_init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cint}, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
end

function QMPI_Reduce_scatter_init_c(context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
    ccall((:QMPI_Reduce_scatter_init_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{MPI_Count}, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
end

function QMPI_Scan(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)
    ccall((:QMPI_Scan, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)
end

function QMPI_Scan_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)
    ccall((:QMPI_Scan_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)
end

function QMPI_Scan_init(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)
    ccall((:QMPI_Scan_init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

function QMPI_Scan_init_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)
    ccall((:QMPI_Scan_init_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

function QMPI_Scatter(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    ccall((:QMPI_Scatter, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

function QMPI_Scatter_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    ccall((:QMPI_Scatter_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

function QMPI_Scatter_init(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    ccall((:QMPI_Scatter_init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

function QMPI_Scatter_init_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    ccall((:QMPI_Scatter_init_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

function QMPI_Scatterv(context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
    ccall((:QMPI_Scatterv, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm), context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

function QMPI_Scatterv_c(context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
    ccall((:QMPI_Scatterv_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm), context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

function QMPI_Scatterv_init(context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    ccall((:QMPI_Scatterv_init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

function QMPI_Scatterv_init_c(context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    ccall((:QMPI_Scatterv_init_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

function QMPI_Comm_compare(context, tool_id, comm1, comm2, result)
    ccall((:QMPI_Comm_compare, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, MPI_Comm, Ptr{Cint}), context, tool_id, comm1, comm2, result)
end

function QMPI_Comm_create(context, tool_id, comm, group, newcomm)
    ccall((:QMPI_Comm_create, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, MPI_Group, Ptr{MPI_Comm}), context, tool_id, comm, group, newcomm)
end

function QMPI_Comm_create_group(context, tool_id, comm, group, tag, newcomm)
    ccall((:QMPI_Comm_create_group, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, MPI_Group, Cint, Ptr{MPI_Comm}), context, tool_id, comm, group, tag, newcomm)
end

function QMPI_Comm_dup(context, tool_id, comm, newcomm)
    ccall((:QMPI_Comm_dup, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{MPI_Comm}), context, tool_id, comm, newcomm)
end

function QMPI_Comm_dup_with_info(context, tool_id, comm, info, newcomm)
    ccall((:QMPI_Comm_dup_with_info, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Comm}), context, tool_id, comm, info, newcomm)
end

function QMPI_Comm_free(context, tool_id, comm)
    ccall((:QMPI_Comm_free, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Comm}), context, tool_id, comm)
end

function QMPI_Comm_get_info(context, tool_id, comm, info_used)
    ccall((:QMPI_Comm_get_info, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{MPI_Info}), context, tool_id, comm, info_used)
end

function QMPI_Comm_get_name(context, tool_id, comm, comm_name, resultlen)
    ccall((:QMPI_Comm_get_name, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{Cchar}, Ptr{Cint}), context, tool_id, comm, comm_name, resultlen)
end

function QMPI_Comm_group(context, tool_id, comm, group)
    ccall((:QMPI_Comm_group, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{MPI_Group}), context, tool_id, comm, group)
end

function QMPI_Comm_idup(context, tool_id, comm, newcomm, request)
    ccall((:QMPI_Comm_idup, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{MPI_Comm}, Ptr{MPI_Request}), context, tool_id, comm, newcomm, request)
end

function QMPI_Comm_idup_with_info(context, tool_id, comm, info, newcomm, request)
    ccall((:QMPI_Comm_idup_with_info, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Comm}, Ptr{MPI_Request}), context, tool_id, comm, info, newcomm, request)
end

function QMPI_Comm_rank(context, tool_id, comm, rank)
    ccall((:QMPI_Comm_rank, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{Cint}), context, tool_id, comm, rank)
end

function QMPI_Comm_remote_group(context, tool_id, comm, group)
    ccall((:QMPI_Comm_remote_group, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{MPI_Group}), context, tool_id, comm, group)
end

function QMPI_Comm_remote_size(context, tool_id, comm, size)
    ccall((:QMPI_Comm_remote_size, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{Cint}), context, tool_id, comm, size)
end

function QMPI_Comm_set_info(context, tool_id, comm, info)
    ccall((:QMPI_Comm_set_info, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, MPI_Info), context, tool_id, comm, info)
end

function QMPI_Comm_set_name(context, tool_id, comm, comm_name)
    ccall((:QMPI_Comm_set_name, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{Cchar}), context, tool_id, comm, comm_name)
end

function QMPI_Comm_size(context, tool_id, comm, size)
    ccall((:QMPI_Comm_size, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{Cint}), context, tool_id, comm, size)
end

function QMPI_Comm_split(context, tool_id, comm, color, key, newcomm)
    ccall((:QMPI_Comm_split, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Cint, Ptr{MPI_Comm}), context, tool_id, comm, color, key, newcomm)
end

function QMPI_Comm_split_type(context, tool_id, comm, split_type, key, info, newcomm)
    ccall((:QMPI_Comm_split_type, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Cint, MPI_Info, Ptr{MPI_Comm}), context, tool_id, comm, split_type, key, info, newcomm)
end

function QMPI_Comm_test_inter(context, tool_id, comm, flag)
    ccall((:QMPI_Comm_test_inter, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{Cint}), context, tool_id, comm, flag)
end

function QMPI_Intercomm_create(context, tool_id, local_comm, local_leader, peer_comm, remote_leader, tag, newintercomm)
    ccall((:QMPI_Intercomm_create, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, MPI_Comm, Cint, Cint, Ptr{MPI_Comm}), context, tool_id, local_comm, local_leader, peer_comm, remote_leader, tag, newintercomm)
end

function QMPI_Intercomm_create_from_groups(context, tool_id, local_group, local_leader, remote_group, remote_leader, stringtag, info, errhandler, newintercomm)
    ccall((:QMPI_Intercomm_create_from_groups, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, Cint, MPI_Group, Cint, Ptr{Cchar}, MPI_Info, MPI_Errhandler, Ptr{MPI_Comm}), context, tool_id, local_group, local_leader, remote_group, remote_leader, stringtag, info, errhandler, newintercomm)
end

function QMPI_Intercomm_merge(context, tool_id, intercomm, high, newintracomm)
    ccall((:QMPI_Intercomm_merge, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Ptr{MPI_Comm}), context, tool_id, intercomm, high, newintracomm)
end

function QMPIX_Comm_revoke(context, tool_id, comm)
    ccall((:QMPIX_Comm_revoke, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm), context, tool_id, comm)
end

function QMPIX_Comm_shrink(context, tool_id, comm, newcomm)
    ccall((:QMPIX_Comm_shrink, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{MPI_Comm}), context, tool_id, comm, newcomm)
end

function QMPIX_Comm_failure_ack(context, tool_id, comm)
    ccall((:QMPIX_Comm_failure_ack, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm), context, tool_id, comm)
end

function QMPIX_Comm_failure_get_acked(context, tool_id, comm, failedgrp)
    ccall((:QMPIX_Comm_failure_get_acked, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{MPI_Group}), context, tool_id, comm, failedgrp)
end

function QMPIX_Comm_agree(context, tool_id, comm, flag)
    ccall((:QMPIX_Comm_agree, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{Cint}), context, tool_id, comm, flag)
end

function QMPI_Get_address(context, tool_id, location, address)
    ccall((:QMPI_Get_address, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{MPI_Aint}), context, tool_id, location, address)
end

function QMPI_Get_count(context, tool_id, status, datatype, count)
    ccall((:QMPI_Get_count, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Status}, MPI_Datatype, Ptr{Cint}), context, tool_id, status, datatype, count)
end

function QMPI_Get_count_c(context, tool_id, status, datatype, count)
    ccall((:QMPI_Get_count_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Status}, MPI_Datatype, Ptr{MPI_Count}), context, tool_id, status, datatype, count)
end

function QMPI_Get_elements(context, tool_id, status, datatype, count)
    ccall((:QMPI_Get_elements, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Status}, MPI_Datatype, Ptr{Cint}), context, tool_id, status, datatype, count)
end

function QMPI_Get_elements_c(context, tool_id, status, datatype, count)
    ccall((:QMPI_Get_elements_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Status}, MPI_Datatype, Ptr{MPI_Count}), context, tool_id, status, datatype, count)
end

function QMPI_Get_elements_x(context, tool_id, status, datatype, count)
    ccall((:QMPI_Get_elements_x, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Status}, MPI_Datatype, Ptr{MPI_Count}), context, tool_id, status, datatype, count)
end

function QMPI_Pack(context, tool_id, inbuf, incount, datatype, outbuf, outsize, position, comm)
    ccall((:QMPI_Pack, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, Ptr{Cint}, MPI_Comm), context, tool_id, inbuf, incount, datatype, outbuf, outsize, position, comm)
end

function QMPI_Pack_c(context, tool_id, inbuf, incount, datatype, outbuf, outsize, position, comm)
    ccall((:QMPI_Pack_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, Ptr{MPI_Count}, MPI_Comm), context, tool_id, inbuf, incount, datatype, outbuf, outsize, position, comm)
end

function QMPI_Pack_external(context, tool_id, datarep, inbuf, incount, datatype, outbuf, outsize, position)
    ccall((:QMPI_Pack_external, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, MPI_Aint, Ptr{MPI_Aint}), context, tool_id, datarep, inbuf, incount, datatype, outbuf, outsize, position)
end

function QMPI_Pack_external_c(context, tool_id, datarep, inbuf, incount, datatype, outbuf, outsize, position)
    ccall((:QMPI_Pack_external_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, Ptr{MPI_Count}), context, tool_id, datarep, inbuf, incount, datatype, outbuf, outsize, position)
end

function QMPI_Pack_external_size(context, tool_id, datarep, incount, datatype, size)
    ccall((:QMPI_Pack_external_size, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, Cint, MPI_Datatype, Ptr{MPI_Aint}), context, tool_id, datarep, incount, datatype, size)
end

function QMPI_Pack_external_size_c(context, tool_id, datarep, incount, datatype, size)
    ccall((:QMPI_Pack_external_size_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, MPI_Count, MPI_Datatype, Ptr{MPI_Count}), context, tool_id, datarep, incount, datatype, size)
end

function QMPI_Pack_size(context, tool_id, incount, datatype, comm, size)
    ccall((:QMPI_Pack_size, libmpi), Cint, (QMPI_Context, Cint, Cint, MPI_Datatype, MPI_Comm, Ptr{Cint}), context, tool_id, incount, datatype, comm, size)
end

function QMPI_Pack_size_c(context, tool_id, incount, datatype, comm, size)
    ccall((:QMPI_Pack_size_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Count}), context, tool_id, incount, datatype, comm, size)
end

function QMPI_Status_set_elements(context, tool_id, status, datatype, count)
    ccall((:QMPI_Status_set_elements, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Status}, MPI_Datatype, Cint), context, tool_id, status, datatype, count)
end

function QMPI_Status_set_elements_x(context, tool_id, status, datatype, count)
    ccall((:QMPI_Status_set_elements_x, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Status}, MPI_Datatype, MPI_Count), context, tool_id, status, datatype, count)
end

function QMPI_Type_commit(context, tool_id, datatype)
    ccall((:QMPI_Type_commit, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Datatype}), context, tool_id, datatype)
end

function QMPI_Type_contiguous(context, tool_id, count, oldtype, newtype)
    ccall((:QMPI_Type_contiguous, libmpi), Cint, (QMPI_Context, Cint, Cint, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, oldtype, newtype)
end

function QMPI_Type_contiguous_c(context, tool_id, count, oldtype, newtype)
    ccall((:QMPI_Type_contiguous_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Count, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, oldtype, newtype)
end

function QMPI_Type_create_darray(context, tool_id, size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
    ccall((:QMPI_Type_create_darray, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
end

function QMPI_Type_create_darray_c(context, tool_id, size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
    ccall((:QMPI_Type_create_darray_c, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, Cint, Ptr{MPI_Count}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
end

function QMPI_Type_create_hindexed(context, tool_id, count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    ccall((:QMPI_Type_create_hindexed, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cint}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

function QMPI_Type_create_hindexed_c(context, tool_id, count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    ccall((:QMPI_Type_create_hindexed_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Count, Ptr{MPI_Count}, Ptr{MPI_Count}, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

function QMPI_Type_create_hindexed_block(context, tool_id, count, blocklength, array_of_displacements, oldtype, newtype)
    ccall((:QMPI_Type_create_hindexed_block, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, Ptr{MPI_Aint}, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, blocklength, array_of_displacements, oldtype, newtype)
end

function QMPI_Type_create_hindexed_block_c(context, tool_id, count, blocklength, array_of_displacements, oldtype, newtype)
    ccall((:QMPI_Type_create_hindexed_block_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Count, MPI_Count, Ptr{MPI_Count}, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, blocklength, array_of_displacements, oldtype, newtype)
end

function QMPI_Type_create_hvector(context, tool_id, count, blocklength, stride, oldtype, newtype)
    ccall((:QMPI_Type_create_hvector, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, MPI_Aint, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, blocklength, stride, oldtype, newtype)
end

function QMPI_Type_create_hvector_c(context, tool_id, count, blocklength, stride, oldtype, newtype)
    ccall((:QMPI_Type_create_hvector_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Count, MPI_Count, MPI_Count, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, blocklength, stride, oldtype, newtype)
end

function QMPI_Type_create_indexed_block(context, tool_id, count, blocklength, array_of_displacements, oldtype, newtype)
    ccall((:QMPI_Type_create_indexed_block, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, Ptr{Cint}, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, blocklength, array_of_displacements, oldtype, newtype)
end

function QMPI_Type_create_indexed_block_c(context, tool_id, count, blocklength, array_of_displacements, oldtype, newtype)
    ccall((:QMPI_Type_create_indexed_block_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Count, MPI_Count, Ptr{MPI_Count}, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, blocklength, array_of_displacements, oldtype, newtype)
end

function QMPI_Type_create_resized(context, tool_id, oldtype, lb, extent, newtype)
    ccall((:QMPI_Type_create_resized, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, MPI_Aint, MPI_Aint, Ptr{MPI_Datatype}), context, tool_id, oldtype, lb, extent, newtype)
end

function QMPI_Type_create_resized_c(context, tool_id, oldtype, lb, extent, newtype)
    ccall((:QMPI_Type_create_resized_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, MPI_Count, MPI_Count, Ptr{MPI_Datatype}), context, tool_id, oldtype, lb, extent, newtype)
end

function QMPI_Type_create_struct(context, tool_id, count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
    ccall((:QMPI_Type_create_struct, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}), context, tool_id, count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
end

function QMPI_Type_create_struct_c(context, tool_id, count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
    ccall((:QMPI_Type_create_struct_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Count, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}), context, tool_id, count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
end

function QMPI_Type_create_subarray(context, tool_id, ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
    ccall((:QMPI_Type_create_subarray, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
end

function QMPI_Type_create_subarray_c(context, tool_id, ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
    ccall((:QMPI_Type_create_subarray_c, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Count}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
end

function QMPI_Type_dup(context, tool_id, oldtype, newtype)
    ccall((:QMPI_Type_dup, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, oldtype, newtype)
end

function QMPI_Type_free(context, tool_id, datatype)
    ccall((:QMPI_Type_free, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Datatype}), context, tool_id, datatype)
end

function QMPI_Type_get_contents(context, tool_id, datatype, max_integers, max_addresses, max_datatypes, array_of_integers, array_of_addresses, array_of_datatypes)
    ccall((:QMPI_Type_get_contents, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Cint, Cint, Cint, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}), context, tool_id, datatype, max_integers, max_addresses, max_datatypes, array_of_integers, array_of_addresses, array_of_datatypes)
end

function QMPI_Type_get_contents_c(context, tool_id, datatype, max_integers, max_addresses, max_large_counts, max_datatypes, array_of_integers, array_of_addresses, array_of_large_counts, array_of_datatypes)
    ccall((:QMPI_Type_get_contents_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, MPI_Count, MPI_Count, MPI_Count, MPI_Count, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Count}, Ptr{MPI_Datatype}), context, tool_id, datatype, max_integers, max_addresses, max_large_counts, max_datatypes, array_of_integers, array_of_addresses, array_of_large_counts, array_of_datatypes)
end

function QMPI_Type_get_envelope(context, tool_id, datatype, num_integers, num_addresses, num_datatypes, combiner)
    ccall((:QMPI_Type_get_envelope, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), context, tool_id, datatype, num_integers, num_addresses, num_datatypes, combiner)
end

function QMPI_Type_get_envelope_c(context, tool_id, datatype, num_integers, num_addresses, num_large_counts, num_datatypes, combiner)
    ccall((:QMPI_Type_get_envelope_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{Cint}), context, tool_id, datatype, num_integers, num_addresses, num_large_counts, num_datatypes, combiner)
end

function QMPI_Type_get_extent(context, tool_id, datatype, lb, extent)
    ccall((:QMPI_Type_get_extent, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{MPI_Aint}, Ptr{MPI_Aint}), context, tool_id, datatype, lb, extent)
end

function QMPI_Type_get_extent_c(context, tool_id, datatype, lb, extent)
    ccall((:QMPI_Type_get_extent_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), context, tool_id, datatype, lb, extent)
end

function QMPI_Type_get_extent_x(context, tool_id, datatype, lb, extent)
    ccall((:QMPI_Type_get_extent_x, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), context, tool_id, datatype, lb, extent)
end

function QMPI_Type_get_name(context, tool_id, datatype, type_name, resultlen)
    ccall((:QMPI_Type_get_name, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{Cchar}, Ptr{Cint}), context, tool_id, datatype, type_name, resultlen)
end

function QMPI_Type_get_true_extent(context, tool_id, datatype, true_lb, true_extent)
    ccall((:QMPI_Type_get_true_extent, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{MPI_Aint}, Ptr{MPI_Aint}), context, tool_id, datatype, true_lb, true_extent)
end

function QMPI_Type_get_true_extent_c(context, tool_id, datatype, true_lb, true_extent)
    ccall((:QMPI_Type_get_true_extent_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), context, tool_id, datatype, true_lb, true_extent)
end

function QMPI_Type_get_true_extent_x(context, tool_id, datatype, true_lb, true_extent)
    ccall((:QMPI_Type_get_true_extent_x, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), context, tool_id, datatype, true_lb, true_extent)
end

function QMPI_Type_indexed(context, tool_id, count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    ccall((:QMPI_Type_indexed, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

function QMPI_Type_indexed_c(context, tool_id, count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    ccall((:QMPI_Type_indexed_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Count, Ptr{MPI_Count}, Ptr{MPI_Count}, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

function QMPI_Type_match_size(context, tool_id, typeclass, size, datatype)
    ccall((:QMPI_Type_match_size, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, Ptr{MPI_Datatype}), context, tool_id, typeclass, size, datatype)
end

function QMPI_Type_set_name(context, tool_id, datatype, type_name)
    ccall((:QMPI_Type_set_name, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{Cchar}), context, tool_id, datatype, type_name)
end

function QMPI_Type_size(context, tool_id, datatype, size)
    ccall((:QMPI_Type_size, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{Cint}), context, tool_id, datatype, size)
end

function QMPI_Type_size_c(context, tool_id, datatype, size)
    ccall((:QMPI_Type_size_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{MPI_Count}), context, tool_id, datatype, size)
end

function QMPI_Type_size_x(context, tool_id, datatype, size)
    ccall((:QMPI_Type_size_x, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{MPI_Count}), context, tool_id, datatype, size)
end

function QMPI_Type_vector(context, tool_id, count, blocklength, stride, oldtype, newtype)
    ccall((:QMPI_Type_vector, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, Cint, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, blocklength, stride, oldtype, newtype)
end

function QMPI_Type_vector_c(context, tool_id, count, blocklength, stride, oldtype, newtype)
    ccall((:QMPI_Type_vector_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Count, MPI_Count, MPI_Count, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, blocklength, stride, oldtype, newtype)
end

function QMPI_Unpack(context, tool_id, inbuf, insize, position, outbuf, outcount, datatype, comm)
    ccall((:QMPI_Unpack, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, Ptr{Cint}, Ptr{Cvoid}, Cint, MPI_Datatype, MPI_Comm), context, tool_id, inbuf, insize, position, outbuf, outcount, datatype, comm)
end

function QMPI_Unpack_c(context, tool_id, inbuf, insize, position, outbuf, outcount, datatype, comm)
    ccall((:QMPI_Unpack_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, Ptr{MPI_Count}, Ptr{Cvoid}, MPI_Count, MPI_Datatype, MPI_Comm), context, tool_id, inbuf, insize, position, outbuf, outcount, datatype, comm)
end

function QMPI_Unpack_external(context, tool_id, datarep, inbuf, insize, position, outbuf, outcount, datatype)
    ccall((:QMPI_Unpack_external, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, Ptr{Cvoid}, MPI_Aint, Ptr{MPI_Aint}, Ptr{Cvoid}, Cint, MPI_Datatype), context, tool_id, datarep, inbuf, insize, position, outbuf, outcount, datatype)
end

function QMPI_Unpack_external_c(context, tool_id, datarep, inbuf, insize, position, outbuf, outcount, datatype)
    ccall((:QMPI_Unpack_external_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, Ptr{Cvoid}, MPI_Count, Ptr{MPI_Count}, Ptr{Cvoid}, MPI_Count, MPI_Datatype), context, tool_id, datarep, inbuf, insize, position, outbuf, outcount, datatype)
end

function QMPI_Address(context, tool_id, location, address)
    ccall((:QMPI_Address, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{MPI_Aint}), context, tool_id, location, address)
end

function QMPI_Type_extent(context, tool_id, datatype, extent)
    ccall((:QMPI_Type_extent, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{MPI_Aint}), context, tool_id, datatype, extent)
end

function QMPI_Type_lb(context, tool_id, datatype, displacement)
    ccall((:QMPI_Type_lb, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{MPI_Aint}), context, tool_id, datatype, displacement)
end

function QMPI_Type_ub(context, tool_id, datatype, displacement)
    ccall((:QMPI_Type_ub, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{MPI_Aint}), context, tool_id, datatype, displacement)
end

function QMPI_Type_hindexed(context, tool_id, count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    ccall((:QMPI_Type_hindexed, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cint}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

function QMPI_Type_hvector(context, tool_id, count, blocklength, stride, oldtype, newtype)
    ccall((:QMPI_Type_hvector, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, MPI_Aint, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, blocklength, stride, oldtype, newtype)
end

function QMPI_Type_struct(context, tool_id, count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
    ccall((:QMPI_Type_struct, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}), context, tool_id, count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
end

function QMPI_Add_error_class(context, tool_id, errorclass)
    ccall((:QMPI_Add_error_class, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, errorclass)
end

function QMPI_Add_error_code(context, tool_id, errorclass, errorcode)
    ccall((:QMPI_Add_error_code, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cint}), context, tool_id, errorclass, errorcode)
end

function QMPI_Add_error_string(context, tool_id, errorcode, string)
    ccall((:QMPI_Add_error_string, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cchar}), context, tool_id, errorcode, string)
end

function QMPI_Comm_call_errhandler(context, tool_id, comm, errorcode)
    ccall((:QMPI_Comm_call_errhandler, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint), context, tool_id, comm, errorcode)
end

function QMPI_Comm_create_errhandler(context, tool_id, comm_errhandler_fn, errhandler)
    ccall((:QMPI_Comm_create_errhandler, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{MPI_Errhandler}), context, tool_id, comm_errhandler_fn, errhandler)
end

function QMPI_Comm_get_errhandler(context, tool_id, comm, errhandler)
    ccall((:QMPI_Comm_get_errhandler, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{MPI_Errhandler}), context, tool_id, comm, errhandler)
end

function QMPI_Comm_set_errhandler(context, tool_id, comm, errhandler)
    ccall((:QMPI_Comm_set_errhandler, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, MPI_Errhandler), context, tool_id, comm, errhandler)
end

function QMPI_Errhandler_free(context, tool_id, errhandler)
    ccall((:QMPI_Errhandler_free, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Errhandler}), context, tool_id, errhandler)
end

function QMPI_Error_class(context, tool_id, errorcode, errorclass)
    ccall((:QMPI_Error_class, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cint}), context, tool_id, errorcode, errorclass)
end

function QMPI_Error_string(context, tool_id, errorcode, string, resultlen)
    ccall((:QMPI_Error_string, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cchar}, Ptr{Cint}), context, tool_id, errorcode, string, resultlen)
end

function QMPI_File_call_errhandler(context, tool_id, fh, errorcode)
    ccall((:QMPI_File_call_errhandler, libmpi), Cint, (QMPI_Context, Cint, MPI_File, Cint), context, tool_id, fh, errorcode)
end

function QMPI_File_create_errhandler(context, tool_id, file_errhandler_fn, errhandler)
    ccall((:QMPI_File_create_errhandler, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{MPI_Errhandler}), context, tool_id, file_errhandler_fn, errhandler)
end

function QMPI_File_get_errhandler(context, tool_id, file, errhandler)
    ccall((:QMPI_File_get_errhandler, libmpi), Cint, (QMPI_Context, Cint, MPI_File, Ptr{MPI_Errhandler}), context, tool_id, file, errhandler)
end

function QMPI_File_set_errhandler(context, tool_id, file, errhandler)
    ccall((:QMPI_File_set_errhandler, libmpi), Cint, (QMPI_Context, Cint, MPI_File, MPI_Errhandler), context, tool_id, file, errhandler)
end

function QMPI_Session_call_errhandler(context, tool_id, session, errorcode)
    ccall((:QMPI_Session_call_errhandler, libmpi), Cint, (QMPI_Context, Cint, MPI_Session, Cint), context, tool_id, session, errorcode)
end

function QMPI_Session_create_errhandler(context, tool_id, session_errhandler_fn, errhandler)
    ccall((:QMPI_Session_create_errhandler, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{MPI_Errhandler}), context, tool_id, session_errhandler_fn, errhandler)
end

function QMPI_Session_get_errhandler(context, tool_id, session, errhandler)
    ccall((:QMPI_Session_get_errhandler, libmpi), Cint, (QMPI_Context, Cint, MPI_Session, Ptr{MPI_Errhandler}), context, tool_id, session, errhandler)
end

function QMPI_Session_set_errhandler(context, tool_id, session, errhandler)
    ccall((:QMPI_Session_set_errhandler, libmpi), Cint, (QMPI_Context, Cint, MPI_Session, MPI_Errhandler), context, tool_id, session, errhandler)
end

function QMPI_Win_call_errhandler(context, tool_id, win, errorcode)
    ccall((:QMPI_Win_call_errhandler, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, Cint), context, tool_id, win, errorcode)
end

function QMPI_Win_create_errhandler(context, tool_id, win_errhandler_fn, errhandler)
    ccall((:QMPI_Win_create_errhandler, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{MPI_Errhandler}), context, tool_id, win_errhandler_fn, errhandler)
end

function QMPI_Win_get_errhandler(context, tool_id, win, errhandler)
    ccall((:QMPI_Win_get_errhandler, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, Ptr{MPI_Errhandler}), context, tool_id, win, errhandler)
end

function QMPI_Win_set_errhandler(context, tool_id, win, errhandler)
    ccall((:QMPI_Win_set_errhandler, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, MPI_Errhandler), context, tool_id, win, errhandler)
end

function QMPIX_Delete_error_class(context, tool_id, errorclass)
    ccall((:QMPIX_Delete_error_class, libmpi), Cint, (QMPI_Context, Cint, Cint), context, tool_id, errorclass)
end

function QMPIX_Delete_error_code(context, tool_id, errorcode)
    ccall((:QMPIX_Delete_error_code, libmpi), Cint, (QMPI_Context, Cint, Cint), context, tool_id, errorcode)
end

function QMPIX_Delete_error_string(context, tool_id, errorcode)
    ccall((:QMPIX_Delete_error_string, libmpi), Cint, (QMPI_Context, Cint, Cint), context, tool_id, errorcode)
end

function QMPI_Errhandler_create(context, tool_id, comm_errhandler_fn, errhandler)
    ccall((:QMPI_Errhandler_create, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{MPI_Errhandler}), context, tool_id, comm_errhandler_fn, errhandler)
end

function QMPI_Errhandler_get(context, tool_id, comm, errhandler)
    ccall((:QMPI_Errhandler_get, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{MPI_Errhandler}), context, tool_id, comm, errhandler)
end

function QMPI_Errhandler_set(context, tool_id, comm, errhandler)
    ccall((:QMPI_Errhandler_set, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, MPI_Errhandler), context, tool_id, comm, errhandler)
end

function QMPI_Group_compare(context, tool_id, group1, group2, result)
    ccall((:QMPI_Group_compare, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, MPI_Group, Ptr{Cint}), context, tool_id, group1, group2, result)
end

function QMPI_Group_difference(context, tool_id, group1, group2, newgroup)
    ccall((:QMPI_Group_difference, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, MPI_Group, Ptr{MPI_Group}), context, tool_id, group1, group2, newgroup)
end

function QMPI_Group_excl(context, tool_id, group, n, ranks, newgroup)
    ccall((:QMPI_Group_excl, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, Cint, Ptr{Cint}, Ptr{MPI_Group}), context, tool_id, group, n, ranks, newgroup)
end

function QMPI_Group_free(context, tool_id, group)
    ccall((:QMPI_Group_free, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Group}), context, tool_id, group)
end

function QMPI_Group_incl(context, tool_id, group, n, ranks, newgroup)
    ccall((:QMPI_Group_incl, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, Cint, Ptr{Cint}, Ptr{MPI_Group}), context, tool_id, group, n, ranks, newgroup)
end

function QMPI_Group_intersection(context, tool_id, group1, group2, newgroup)
    ccall((:QMPI_Group_intersection, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, MPI_Group, Ptr{MPI_Group}), context, tool_id, group1, group2, newgroup)
end

function QMPI_Group_range_excl(context, tool_id, group, n, ranges, newgroup)
    ccall((:QMPI_Group_range_excl, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, Cint, Ptr{NTuple{3, Cint}}, Ptr{MPI_Group}), context, tool_id, group, n, ranges, newgroup)
end

function QMPI_Group_range_incl(context, tool_id, group, n, ranges, newgroup)
    ccall((:QMPI_Group_range_incl, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, Cint, Ptr{NTuple{3, Cint}}, Ptr{MPI_Group}), context, tool_id, group, n, ranges, newgroup)
end

function QMPI_Group_rank(context, tool_id, group, rank)
    ccall((:QMPI_Group_rank, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, Ptr{Cint}), context, tool_id, group, rank)
end

function QMPI_Group_size(context, tool_id, group, size)
    ccall((:QMPI_Group_size, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, Ptr{Cint}), context, tool_id, group, size)
end

function QMPI_Group_translate_ranks(context, tool_id, group1, n, ranks1, group2, ranks2)
    ccall((:QMPI_Group_translate_ranks, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, Cint, Ptr{Cint}, MPI_Group, Ptr{Cint}), context, tool_id, group1, n, ranks1, group2, ranks2)
end

function QMPI_Group_union(context, tool_id, group1, group2, newgroup)
    ccall((:QMPI_Group_union, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, MPI_Group, Ptr{MPI_Group}), context, tool_id, group1, group2, newgroup)
end

function QMPI_Info_create(context, tool_id, info)
    ccall((:QMPI_Info_create, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Info}), context, tool_id, info)
end

function QMPI_Info_create_env(context, tool_id, argc, argv, info)
    ccall((:QMPI_Info_create_env, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Ptr{Cchar}}, Ptr{MPI_Info}), context, tool_id, argc, argv, info)
end

function QMPI_Info_delete(context, tool_id, info, key)
    ccall((:QMPI_Info_delete, libmpi), Cint, (QMPI_Context, Cint, MPI_Info, Ptr{Cchar}), context, tool_id, info, key)
end

function QMPI_Info_dup(context, tool_id, info, newinfo)
    ccall((:QMPI_Info_dup, libmpi), Cint, (QMPI_Context, Cint, MPI_Info, Ptr{MPI_Info}), context, tool_id, info, newinfo)
end

function QMPI_Info_free(context, tool_id, info)
    ccall((:QMPI_Info_free, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Info}), context, tool_id, info)
end

function QMPI_Info_get(context, tool_id, info, key, valuelen, value, flag)
    ccall((:QMPI_Info_get, libmpi), Cint, (QMPI_Context, Cint, MPI_Info, Ptr{Cchar}, Cint, Ptr{Cchar}, Ptr{Cint}), context, tool_id, info, key, valuelen, value, flag)
end

function QMPI_Info_get_nkeys(context, tool_id, info, nkeys)
    ccall((:QMPI_Info_get_nkeys, libmpi), Cint, (QMPI_Context, Cint, MPI_Info, Ptr{Cint}), context, tool_id, info, nkeys)
end

function QMPI_Info_get_nthkey(context, tool_id, info, n, key)
    ccall((:QMPI_Info_get_nthkey, libmpi), Cint, (QMPI_Context, Cint, MPI_Info, Cint, Ptr{Cchar}), context, tool_id, info, n, key)
end

function QMPI_Info_get_string(context, tool_id, info, key, buflen, value, flag)
    ccall((:QMPI_Info_get_string, libmpi), Cint, (QMPI_Context, Cint, MPI_Info, Ptr{Cchar}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}), context, tool_id, info, key, buflen, value, flag)
end

function QMPI_Info_get_valuelen(context, tool_id, info, key, valuelen, flag)
    ccall((:QMPI_Info_get_valuelen, libmpi), Cint, (QMPI_Context, Cint, MPI_Info, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}), context, tool_id, info, key, valuelen, flag)
end

function QMPI_Info_set(context, tool_id, info, key, value)
    ccall((:QMPI_Info_set, libmpi), Cint, (QMPI_Context, Cint, MPI_Info, Ptr{Cchar}, Ptr{Cchar}), context, tool_id, info, key, value)
end

function QMPI_Abort(context, tool_id, comm, errorcode)
    ccall((:QMPI_Abort, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint), context, tool_id, comm, errorcode)
end

function QMPI_Comm_create_from_group(context, tool_id, group, stringtag, info, errhandler, newcomm)
    ccall((:QMPI_Comm_create_from_group, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, Ptr{Cchar}, MPI_Info, MPI_Errhandler, Ptr{MPI_Comm}), context, tool_id, group, stringtag, info, errhandler, newcomm)
end

function QMPI_Finalize(context, tool_id)
    ccall((:QMPI_Finalize, libmpi), Cint, (QMPI_Context, Cint), context, tool_id)
end

function QMPI_Finalized(context, tool_id, flag)
    ccall((:QMPI_Finalized, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, flag)
end

function QMPI_Group_from_session_pset(context, tool_id, session, pset_name, newgroup)
    ccall((:QMPI_Group_from_session_pset, libmpi), Cint, (QMPI_Context, Cint, MPI_Session, Ptr{Cchar}, Ptr{MPI_Group}), context, tool_id, session, pset_name, newgroup)
end

function QMPI_Init(context, tool_id, argc, argv)
    ccall((:QMPI_Init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}, Ptr{Ptr{Ptr{Cchar}}}), context, tool_id, argc, argv)
end

function QMPI_Init_thread(context, tool_id, argc, argv, required, provided)
    ccall((:QMPI_Init_thread, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}, Ptr{Ptr{Ptr{Cchar}}}, Cint, Ptr{Cint}), context, tool_id, argc, argv, required, provided)
end

function QMPI_Initialized(context, tool_id, flag)
    ccall((:QMPI_Initialized, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, flag)
end

function QMPI_Is_thread_main(context, tool_id, flag)
    ccall((:QMPI_Is_thread_main, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, flag)
end

function QMPI_Query_thread(context, tool_id, provided)
    ccall((:QMPI_Query_thread, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, provided)
end

function QMPI_Session_finalize(context, tool_id, session)
    ccall((:QMPI_Session_finalize, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Session}), context, tool_id, session)
end

function QMPI_Session_get_info(context, tool_id, session, info_used)
    ccall((:QMPI_Session_get_info, libmpi), Cint, (QMPI_Context, Cint, MPI_Session, Ptr{MPI_Info}), context, tool_id, session, info_used)
end

function QMPI_Session_get_nth_pset(context, tool_id, session, info, n, pset_len, pset_name)
    ccall((:QMPI_Session_get_nth_pset, libmpi), Cint, (QMPI_Context, Cint, MPI_Session, MPI_Info, Cint, Ptr{Cint}, Ptr{Cchar}), context, tool_id, session, info, n, pset_len, pset_name)
end

function QMPI_Session_get_num_psets(context, tool_id, session, info, npset_names)
    ccall((:QMPI_Session_get_num_psets, libmpi), Cint, (QMPI_Context, Cint, MPI_Session, MPI_Info, Ptr{Cint}), context, tool_id, session, info, npset_names)
end

function QMPI_Session_get_pset_info(context, tool_id, session, pset_name, info)
    ccall((:QMPI_Session_get_pset_info, libmpi), Cint, (QMPI_Context, Cint, MPI_Session, Ptr{Cchar}, Ptr{MPI_Info}), context, tool_id, session, pset_name, info)
end

function QMPI_Session_init(context, tool_id, info, errhandler, session)
    ccall((:QMPI_Session_init, libmpi), Cint, (QMPI_Context, Cint, MPI_Info, MPI_Errhandler, Ptr{MPI_Session}), context, tool_id, info, errhandler, session)
end

function QMPI_Aint_add(context, tool_id, base, disp)
    ccall((:QMPI_Aint_add, libmpi), MPI_Aint, (QMPI_Context, Cint, MPI_Aint, MPI_Aint), context, tool_id, base, disp)
end

function QMPI_Aint_diff(context, tool_id, addr1, addr2)
    ccall((:QMPI_Aint_diff, libmpi), MPI_Aint, (QMPI_Context, Cint, MPI_Aint, MPI_Aint), context, tool_id, addr1, addr2)
end

function QMPI_Get_library_version(context, tool_id, version, resultlen)
    ccall((:QMPI_Get_library_version, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, Ptr{Cint}), context, tool_id, version, resultlen)
end

function QMPI_Get_processor_name(context, tool_id, name, resultlen)
    ccall((:QMPI_Get_processor_name, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, Ptr{Cint}), context, tool_id, name, resultlen)
end

function QMPI_Get_version(context, tool_id, version, subversion)
    ccall((:QMPI_Get_version, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}, Ptr{Cint}), context, tool_id, version, subversion)
end

function QMPIX_GPU_query_support(context, tool_id, gpu_type, is_supported)
    ccall((:QMPIX_GPU_query_support, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cint}), context, tool_id, gpu_type, is_supported)
end

function QMPIX_Query_cuda_support(context, tool_id)
    ccall((:QMPIX_Query_cuda_support, libmpi), Cint, (QMPI_Context, Cint), context, tool_id)
end

function QMPIX_Query_ze_support(context, tool_id)
    ccall((:QMPIX_Query_ze_support, libmpi), Cint, (QMPI_Context, Cint), context, tool_id)
end

function QMPIX_Query_hip_support(context, tool_id)
    ccall((:QMPIX_Query_hip_support, libmpi), Cint, (QMPI_Context, Cint), context, tool_id)
end

function QMPI_T_category_changed(context, tool_id, update_number)
    ccall((:QMPI_T_category_changed, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, update_number)
end

function QMPI_T_category_get_categories(context, tool_id, cat_index, len, indices)
    ccall((:QMPI_T_category_get_categories, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, Ptr{Cint}), context, tool_id, cat_index, len, indices)
end

function QMPI_T_category_get_cvars(context, tool_id, cat_index, len, indices)
    ccall((:QMPI_T_category_get_cvars, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, Ptr{Cint}), context, tool_id, cat_index, len, indices)
end

function QMPI_T_category_get_events(context, tool_id, cat_index, len, indices)
    ccall((:QMPI_T_category_get_events, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, Ptr{Cint}), context, tool_id, cat_index, len, indices)
end

function QMPI_T_category_get_index(context, tool_id, name, cat_index)
    ccall((:QMPI_T_category_get_index, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, Ptr{Cint}), context, tool_id, name, cat_index)
end

function QMPI_T_category_get_info(context, tool_id, cat_index, name, name_len, desc, desc_len, num_cvars, num_pvars, num_categories)
    ccall((:QMPI_T_category_get_info, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), context, tool_id, cat_index, name, name_len, desc, desc_len, num_cvars, num_pvars, num_categories)
end

function QMPI_T_category_get_num(context, tool_id, num_cat)
    ccall((:QMPI_T_category_get_num, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, num_cat)
end

function QMPI_T_category_get_num_events(context, tool_id, cat_index, num_events)
    ccall((:QMPI_T_category_get_num_events, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cint}), context, tool_id, cat_index, num_events)
end

function QMPI_T_category_get_pvars(context, tool_id, cat_index, len, indices)
    ccall((:QMPI_T_category_get_pvars, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, Ptr{Cint}), context, tool_id, cat_index, len, indices)
end

function QMPI_T_cvar_get_index(context, tool_id, name, cvar_index)
    ccall((:QMPI_T_cvar_get_index, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, Ptr{Cint}), context, tool_id, name, cvar_index)
end

function QMPI_T_cvar_get_info(context, tool_id, cvar_index, name, name_len, verbosity, datatype, enumtype, desc, desc_len, bind, scope)
    ccall((:QMPI_T_cvar_get_info, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{MPI_T_enum}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), context, tool_id, cvar_index, name, name_len, verbosity, datatype, enumtype, desc, desc_len, bind, scope)
end

function QMPI_T_cvar_get_num(context, tool_id, num_cvar)
    ccall((:QMPI_T_cvar_get_num, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, num_cvar)
end

function QMPI_T_cvar_handle_alloc(context, tool_id, cvar_index, obj_handle, handle, count)
    ccall((:QMPI_T_cvar_handle_alloc, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cvoid}, Ptr{MPI_T_cvar_handle}, Ptr{Cint}), context, tool_id, cvar_index, obj_handle, handle, count)
end

function QMPI_T_cvar_handle_free(context, tool_id, handle)
    ccall((:QMPI_T_cvar_handle_free, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_T_cvar_handle}), context, tool_id, handle)
end

function QMPI_T_cvar_read(context, tool_id, handle, buf)
    ccall((:QMPI_T_cvar_read, libmpi), Cint, (QMPI_Context, Cint, MPI_T_cvar_handle, Ptr{Cvoid}), context, tool_id, handle, buf)
end

function QMPI_T_cvar_write(context, tool_id, handle, buf)
    ccall((:QMPI_T_cvar_write, libmpi), Cint, (QMPI_Context, Cint, MPI_T_cvar_handle, Ptr{Cvoid}), context, tool_id, handle, buf)
end

function QMPI_T_enum_get_info(context, tool_id, enumtype, num, name, name_len)
    ccall((:QMPI_T_enum_get_info, libmpi), Cint, (QMPI_Context, Cint, MPI_T_enum, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}), context, tool_id, enumtype, num, name, name_len)
end

function QMPI_T_enum_get_item(context, tool_id, enumtype, indx, value, name, name_len)
    ccall((:QMPI_T_enum_get_item, libmpi), Cint, (QMPI_Context, Cint, MPI_T_enum, Cint, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}), context, tool_id, enumtype, indx, value, name, name_len)
end

function QMPI_T_event_callback_get_info(context, tool_id, event_registration, cb_safety, info_used)
    ccall((:QMPI_T_event_callback_get_info, libmpi), Cint, (QMPI_Context, Cint, MPI_T_event_registration, MPI_T_cb_safety, Ptr{MPI_Info}), context, tool_id, event_registration, cb_safety, info_used)
end

function QMPI_T_event_callback_set_info(context, tool_id, event_registration, cb_safety, info)
    ccall((:QMPI_T_event_callback_set_info, libmpi), Cint, (QMPI_Context, Cint, MPI_T_event_registration, MPI_T_cb_safety, MPI_Info), context, tool_id, event_registration, cb_safety, info)
end

function QMPI_T_event_copy(context, tool_id, event_instance, buffer)
    ccall((:QMPI_T_event_copy, libmpi), Cint, (QMPI_Context, Cint, MPI_T_event_instance, Ptr{Cvoid}), context, tool_id, event_instance, buffer)
end

function QMPI_T_event_get_index(context, tool_id, name, event_index)
    ccall((:QMPI_T_event_get_index, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, Ptr{Cint}), context, tool_id, name, event_index)
end

function QMPI_T_event_get_info(context, tool_id, event_index, name, name_len, verbosity, array_of_datatypes, array_of_displacements, num_elements, enumtype, info, desc, desc_len, bind)
    ccall((:QMPI_T_event_get_info, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{MPI_Aint}, Ptr{Cint}, Ptr{MPI_T_enum}, Ptr{MPI_Info}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}), context, tool_id, event_index, name, name_len, verbosity, array_of_datatypes, array_of_displacements, num_elements, enumtype, info, desc, desc_len, bind)
end

function QMPI_T_event_get_num(context, tool_id, num_events)
    ccall((:QMPI_T_event_get_num, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, num_events)
end

function QMPI_T_event_get_source(context, tool_id, event_instance, source_index)
    ccall((:QMPI_T_event_get_source, libmpi), Cint, (QMPI_Context, Cint, MPI_T_event_instance, Ptr{Cint}), context, tool_id, event_instance, source_index)
end

function QMPI_T_event_get_timestamp(context, tool_id, event_instance, event_timestamp)
    ccall((:QMPI_T_event_get_timestamp, libmpi), Cint, (QMPI_Context, Cint, MPI_T_event_instance, Ptr{MPI_Count}), context, tool_id, event_instance, event_timestamp)
end

function QMPI_T_event_handle_alloc(context, tool_id, event_index, obj_handle, info, event_registration)
    ccall((:QMPI_T_event_handle_alloc, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cvoid}, MPI_Info, Ptr{MPI_T_event_registration}), context, tool_id, event_index, obj_handle, info, event_registration)
end

function QMPI_T_event_handle_free(context, tool_id, event_registration, user_data, free_cb_function)
    ccall((:QMPI_T_event_handle_free, libmpi), Cint, (QMPI_Context, Cint, MPI_T_event_registration, Ptr{Cvoid}, MPI_T_event_free_cb_function), context, tool_id, event_registration, user_data, free_cb_function)
end

function QMPI_T_event_handle_get_info(context, tool_id, event_registration, info_used)
    ccall((:QMPI_T_event_handle_get_info, libmpi), Cint, (QMPI_Context, Cint, MPI_T_event_registration, Ptr{MPI_Info}), context, tool_id, event_registration, info_used)
end

function QMPI_T_event_handle_set_info(context, tool_id, event_registration, info)
    ccall((:QMPI_T_event_handle_set_info, libmpi), Cint, (QMPI_Context, Cint, MPI_T_event_registration, MPI_Info), context, tool_id, event_registration, info)
end

function QMPI_T_event_read(context, tool_id, event_instance, element_index, buffer)
    ccall((:QMPI_T_event_read, libmpi), Cint, (QMPI_Context, Cint, MPI_T_event_instance, Cint, Ptr{Cvoid}), context, tool_id, event_instance, element_index, buffer)
end

function QMPI_T_event_register_callback(context, tool_id, event_registration, cb_safety, info, user_data, event_cb_function)
    ccall((:QMPI_T_event_register_callback, libmpi), Cint, (QMPI_Context, Cint, MPI_T_event_registration, MPI_T_cb_safety, MPI_Info, Ptr{Cvoid}, MPI_T_event_cb_function), context, tool_id, event_registration, cb_safety, info, user_data, event_cb_function)
end

function QMPI_T_event_set_dropped_handler(context, tool_id, event_registration, dropped_cb_function)
    ccall((:QMPI_T_event_set_dropped_handler, libmpi), Cint, (QMPI_Context, Cint, MPI_T_event_registration, MPI_T_event_dropped_cb_function), context, tool_id, event_registration, dropped_cb_function)
end

function QMPI_T_finalize(context, tool_id)
    ccall((:QMPI_T_finalize, libmpi), Cint, (QMPI_Context, Cint), context, tool_id)
end

function QMPI_T_init_thread(context, tool_id, required, provided)
    ccall((:QMPI_T_init_thread, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cint}), context, tool_id, required, provided)
end

function QMPI_T_pvar_get_index(context, tool_id, name, var_class, pvar_index)
    ccall((:QMPI_T_pvar_get_index, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, Cint, Ptr{Cint}), context, tool_id, name, var_class, pvar_index)
end

function QMPI_T_pvar_get_info(context, tool_id, pvar_index, name, name_len, verbosity, var_class, datatype, enumtype, desc, desc_len, bind, readonly, continuous, atomic)
    ccall((:QMPI_T_pvar_get_info, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{MPI_T_enum}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), context, tool_id, pvar_index, name, name_len, verbosity, var_class, datatype, enumtype, desc, desc_len, bind, readonly, continuous, atomic)
end

function QMPI_T_pvar_get_num(context, tool_id, num_pvar)
    ccall((:QMPI_T_pvar_get_num, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, num_pvar)
end

function QMPI_T_pvar_handle_alloc(context, tool_id, session, pvar_index, obj_handle, handle, count)
    ccall((:QMPI_T_pvar_handle_alloc, libmpi), Cint, (QMPI_Context, Cint, MPI_T_pvar_session, Cint, Ptr{Cvoid}, Ptr{MPI_T_pvar_handle}, Ptr{Cint}), context, tool_id, session, pvar_index, obj_handle, handle, count)
end

function QMPI_T_pvar_handle_free(context, tool_id, session, handle)
    ccall((:QMPI_T_pvar_handle_free, libmpi), Cint, (QMPI_Context, Cint, MPI_T_pvar_session, Ptr{MPI_T_pvar_handle}), context, tool_id, session, handle)
end

function QMPI_T_pvar_read(context, tool_id, session, handle, buf)
    ccall((:QMPI_T_pvar_read, libmpi), Cint, (QMPI_Context, Cint, MPI_T_pvar_session, MPI_T_pvar_handle, Ptr{Cvoid}), context, tool_id, session, handle, buf)
end

function QMPI_T_pvar_readreset(context, tool_id, session, handle, buf)
    ccall((:QMPI_T_pvar_readreset, libmpi), Cint, (QMPI_Context, Cint, MPI_T_pvar_session, MPI_T_pvar_handle, Ptr{Cvoid}), context, tool_id, session, handle, buf)
end

function QMPI_T_pvar_reset(context, tool_id, session, handle)
    ccall((:QMPI_T_pvar_reset, libmpi), Cint, (QMPI_Context, Cint, MPI_T_pvar_session, MPI_T_pvar_handle), context, tool_id, session, handle)
end

function QMPI_T_pvar_session_create(context, tool_id, session)
    ccall((:QMPI_T_pvar_session_create, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_T_pvar_session}), context, tool_id, session)
end

function QMPI_T_pvar_session_free(context, tool_id, session)
    ccall((:QMPI_T_pvar_session_free, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_T_pvar_session}), context, tool_id, session)
end

function QMPI_T_pvar_start(context, tool_id, session, handle)
    ccall((:QMPI_T_pvar_start, libmpi), Cint, (QMPI_Context, Cint, MPI_T_pvar_session, MPI_T_pvar_handle), context, tool_id, session, handle)
end

function QMPI_T_pvar_stop(context, tool_id, session, handle)
    ccall((:QMPI_T_pvar_stop, libmpi), Cint, (QMPI_Context, Cint, MPI_T_pvar_session, MPI_T_pvar_handle), context, tool_id, session, handle)
end

function QMPI_T_pvar_write(context, tool_id, session, handle, buf)
    ccall((:QMPI_T_pvar_write, libmpi), Cint, (QMPI_Context, Cint, MPI_T_pvar_session, MPI_T_pvar_handle, Ptr{Cvoid}), context, tool_id, session, handle, buf)
end

function QMPI_T_source_get_info(context, tool_id, source_index, name, name_len, desc, desc_len, ordering, ticks_per_second, max_ticks, info)
    ccall((:QMPI_T_source_get_info, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}, Ptr{MPI_T_source_order}, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Info}), context, tool_id, source_index, name, name_len, desc, desc_len, ordering, ticks_per_second, max_ticks, info)
end

function QMPI_T_source_get_num(context, tool_id, num_sources)
    ccall((:QMPI_T_source_get_num, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, num_sources)
end

function QMPI_T_source_get_timestamp(context, tool_id, source_index, timestamp)
    ccall((:QMPI_T_source_get_timestamp, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{MPI_Count}), context, tool_id, source_index, timestamp)
end

function QMPI_Op_commutative(context, tool_id, op, commute)
    ccall((:QMPI_Op_commutative, libmpi), Cint, (QMPI_Context, Cint, MPI_Op, Ptr{Cint}), context, tool_id, op, commute)
end

function QMPI_Op_create(context, tool_id, user_fn, commute, op)
    ccall((:QMPI_Op_create, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, Ptr{MPI_Op}), context, tool_id, user_fn, commute, op)
end

function QMPI_Op_create_c(context, tool_id, user_fn, commute, op)
    ccall((:QMPI_Op_create_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, Ptr{MPI_Op}), context, tool_id, user_fn, commute, op)
end

function QMPI_Op_free(context, tool_id, op)
    ccall((:QMPI_Op_free, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Op}), context, tool_id, op)
end

function QMPI_Parrived(context, tool_id, request, partition, flag)
    ccall((:QMPI_Parrived, libmpi), Cint, (QMPI_Context, Cint, MPI_Request, Cint, Ptr{Cint}), context, tool_id, request, partition, flag)
end

function QMPI_Pready(context, tool_id, partition, request)
    ccall((:QMPI_Pready, libmpi), Cint, (QMPI_Context, Cint, Cint, MPI_Request), context, tool_id, partition, request)
end

function QMPI_Pready_list(context, tool_id, length, array_of_partitions, request)
    ccall((:QMPI_Pready_list, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cint}, MPI_Request), context, tool_id, length, array_of_partitions, request)
end

function QMPI_Pready_range(context, tool_id, partition_low, partition_high, request)
    ccall((:QMPI_Pready_range, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, MPI_Request), context, tool_id, partition_low, partition_high, request)
end

function QMPI_Precv_init(context, tool_id, buf, partitions, count, datatype, dest, tag, comm, info, request)
    ccall((:QMPI_Precv_init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, buf, partitions, count, datatype, dest, tag, comm, info, request)
end

function QMPI_Psend_init(context, tool_id, buf, partitions, count, datatype, dest, tag, comm, info, request)
    ccall((:QMPI_Psend_init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, buf, partitions, count, datatype, dest, tag, comm, info, request)
end

function QMPI_Bsend(context, tool_id, buf, count, datatype, dest, tag, comm)
    ccall((:QMPI_Bsend, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), context, tool_id, buf, count, datatype, dest, tag, comm)
end

function QMPI_Bsend_c(context, tool_id, buf, count, datatype, dest, tag, comm)
    ccall((:QMPI_Bsend_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm), context, tool_id, buf, count, datatype, dest, tag, comm)
end

function QMPI_Bsend_init(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    ccall((:QMPI_Bsend_init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

function QMPI_Bsend_init_c(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    ccall((:QMPI_Bsend_init_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

function QMPI_Buffer_attach(context, tool_id, buffer, size)
    ccall((:QMPI_Buffer_attach, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint), context, tool_id, buffer, size)
end

function QMPI_Buffer_attach_c(context, tool_id, buffer, size)
    ccall((:QMPI_Buffer_attach_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count), context, tool_id, buffer, size)
end

function QMPI_Buffer_detach(context, tool_id, buffer_addr, size)
    ccall((:QMPI_Buffer_detach, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cint}), context, tool_id, buffer_addr, size)
end

function QMPI_Buffer_detach_c(context, tool_id, buffer_addr, size)
    ccall((:QMPI_Buffer_detach_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{MPI_Count}), context, tool_id, buffer_addr, size)
end

function QMPI_Ibsend(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    ccall((:QMPI_Ibsend, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

function QMPI_Ibsend_c(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    ccall((:QMPI_Ibsend_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

function QMPI_Improbe(context, tool_id, source, tag, comm, flag, message, status)
    ccall((:QMPI_Improbe, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, MPI_Comm, Ptr{Cint}, Ptr{MPI_Message}, Ptr{MPI_Status}), context, tool_id, source, tag, comm, flag, message, status)
end

function QMPI_Imrecv(context, tool_id, buf, count, datatype, message, request)
    ccall((:QMPI_Imrecv, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, message, request)
end

function QMPI_Imrecv_c(context, tool_id, buf, count, datatype, message, request)
    ccall((:QMPI_Imrecv_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, message, request)
end

function QMPI_Iprobe(context, tool_id, source, tag, comm, flag, status)
    ccall((:QMPI_Iprobe, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, MPI_Comm, Ptr{Cint}, Ptr{MPI_Status}), context, tool_id, source, tag, comm, flag, status)
end

function QMPI_Irecv(context, tool_id, buf, count, datatype, source, tag, comm, request)
    ccall((:QMPI_Irecv, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, source, tag, comm, request)
end

function QMPI_Irecv_c(context, tool_id, buf, count, datatype, source, tag, comm, request)
    ccall((:QMPI_Irecv_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, source, tag, comm, request)
end

function QMPI_Irsend(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    ccall((:QMPI_Irsend, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

function QMPI_Irsend_c(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    ccall((:QMPI_Irsend_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

function QMPI_Isend(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    ccall((:QMPI_Isend, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

function QMPI_Isend_c(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    ccall((:QMPI_Isend_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

function QMPI_Isendrecv(context, tool_id, sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
    ccall((:QMPI_Isendrecv, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
end

function QMPI_Isendrecv_c(context, tool_id, sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
    ccall((:QMPI_Isendrecv_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
end

function QMPI_Isendrecv_replace(context, tool_id, buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
    ccall((:QMPI_Isendrecv_replace, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
end

function QMPI_Isendrecv_replace_c(context, tool_id, buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
    ccall((:QMPI_Isendrecv_replace_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
end

function QMPI_Issend(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    ccall((:QMPI_Issend, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

function QMPI_Issend_c(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    ccall((:QMPI_Issend_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

function QMPI_Mprobe(context, tool_id, source, tag, comm, message, status)
    ccall((:QMPI_Mprobe, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Message}, Ptr{MPI_Status}), context, tool_id, source, tag, comm, message, status)
end

function QMPI_Mrecv(context, tool_id, buf, count, datatype, message, status)
    ccall((:QMPI_Mrecv, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Status}), context, tool_id, buf, count, datatype, message, status)
end

function QMPI_Mrecv_c(context, tool_id, buf, count, datatype, message, status)
    ccall((:QMPI_Mrecv_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Status}), context, tool_id, buf, count, datatype, message, status)
end

function QMPI_Probe(context, tool_id, source, tag, comm, status)
    ccall((:QMPI_Probe, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), context, tool_id, source, tag, comm, status)
end

function QMPI_Recv(context, tool_id, buf, count, datatype, source, tag, comm, status)
    ccall((:QMPI_Recv, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), context, tool_id, buf, count, datatype, source, tag, comm, status)
end

function QMPI_Recv_c(context, tool_id, buf, count, datatype, source, tag, comm, status)
    ccall((:QMPI_Recv_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), context, tool_id, buf, count, datatype, source, tag, comm, status)
end

function QMPI_Recv_init(context, tool_id, buf, count, datatype, source, tag, comm, request)
    ccall((:QMPI_Recv_init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, source, tag, comm, request)
end

function QMPI_Recv_init_c(context, tool_id, buf, count, datatype, source, tag, comm, request)
    ccall((:QMPI_Recv_init_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, source, tag, comm, request)
end

function QMPI_Rsend(context, tool_id, buf, count, datatype, dest, tag, comm)
    ccall((:QMPI_Rsend, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), context, tool_id, buf, count, datatype, dest, tag, comm)
end

function QMPI_Rsend_c(context, tool_id, buf, count, datatype, dest, tag, comm)
    ccall((:QMPI_Rsend_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm), context, tool_id, buf, count, datatype, dest, tag, comm)
end

function QMPI_Rsend_init(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    ccall((:QMPI_Rsend_init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

function QMPI_Rsend_init_c(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    ccall((:QMPI_Rsend_init_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

function QMPI_Send(context, tool_id, buf, count, datatype, dest, tag, comm)
    ccall((:QMPI_Send, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), context, tool_id, buf, count, datatype, dest, tag, comm)
end

function QMPI_Send_c(context, tool_id, buf, count, datatype, dest, tag, comm)
    ccall((:QMPI_Send_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm), context, tool_id, buf, count, datatype, dest, tag, comm)
end

function QMPI_Send_init(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    ccall((:QMPI_Send_init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

function QMPI_Send_init_c(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    ccall((:QMPI_Send_init_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

function QMPI_Sendrecv(context, tool_id, sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
    ccall((:QMPI_Sendrecv, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), context, tool_id, sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
end

function QMPI_Sendrecv_c(context, tool_id, sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
    ccall((:QMPI_Sendrecv_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), context, tool_id, sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
end

function QMPI_Sendrecv_replace(context, tool_id, buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
    ccall((:QMPI_Sendrecv_replace, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), context, tool_id, buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
end

function QMPI_Sendrecv_replace_c(context, tool_id, buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
    ccall((:QMPI_Sendrecv_replace_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), context, tool_id, buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
end

function QMPI_Ssend(context, tool_id, buf, count, datatype, dest, tag, comm)
    ccall((:QMPI_Ssend, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), context, tool_id, buf, count, datatype, dest, tag, comm)
end

function QMPI_Ssend_c(context, tool_id, buf, count, datatype, dest, tag, comm)
    ccall((:QMPI_Ssend_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm), context, tool_id, buf, count, datatype, dest, tag, comm)
end

function QMPI_Ssend_init(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    ccall((:QMPI_Ssend_init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

function QMPI_Ssend_init_c(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    ccall((:QMPI_Ssend_init_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

function QMPI_Cancel(context, tool_id, request)
    ccall((:QMPI_Cancel, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Request}), context, tool_id, request)
end

function QMPI_Grequest_complete(context, tool_id, request)
    ccall((:QMPI_Grequest_complete, libmpi), Cint, (QMPI_Context, Cint, MPI_Request), context, tool_id, request)
end

function QMPI_Grequest_start(context, tool_id, query_fn, free_fn, cancel_fn, extra_state, request)
    ccall((:QMPI_Grequest_start, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{MPI_Request}), context, tool_id, query_fn, free_fn, cancel_fn, extra_state, request)
end

function QMPI_Request_free(context, tool_id, request)
    ccall((:QMPI_Request_free, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Request}), context, tool_id, request)
end

function QMPI_Request_get_status(context, tool_id, request, flag, status)
    ccall((:QMPI_Request_get_status, libmpi), Cint, (QMPI_Context, Cint, MPI_Request, Ptr{Cint}, Ptr{MPI_Status}), context, tool_id, request, flag, status)
end

function QMPI_Start(context, tool_id, request)
    ccall((:QMPI_Start, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Request}), context, tool_id, request)
end

function QMPI_Startall(context, tool_id, count, array_of_requests)
    ccall((:QMPI_Startall, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{MPI_Request}), context, tool_id, count, array_of_requests)
end

function QMPI_Status_set_cancelled(context, tool_id, status, flag)
    ccall((:QMPI_Status_set_cancelled, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Status}, Cint), context, tool_id, status, flag)
end

function QMPI_Test(context, tool_id, request, flag, status)
    ccall((:QMPI_Test, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{MPI_Status}), context, tool_id, request, flag, status)
end

function QMPI_Test_cancelled(context, tool_id, status, flag)
    ccall((:QMPI_Test_cancelled, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Status}, Ptr{Cint}), context, tool_id, status, flag)
end

function QMPI_Testall(context, tool_id, count, array_of_requests, flag, array_of_statuses)
    ccall((:QMPI_Testall, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{MPI_Status}), context, tool_id, count, array_of_requests, flag, array_of_statuses)
end

function QMPI_Testany(context, tool_id, count, array_of_requests, indx, flag, status)
    ccall((:QMPI_Testany, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Status}), context, tool_id, count, array_of_requests, indx, flag, status)
end

function QMPI_Testsome(context, tool_id, incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
    ccall((:QMPI_Testsome, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Status}), context, tool_id, incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
end

function QMPI_Wait(context, tool_id, request, status)
    ccall((:QMPI_Wait, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Request}, Ptr{MPI_Status}), context, tool_id, request, status)
end

function QMPI_Waitall(context, tool_id, count, array_of_requests, array_of_statuses)
    ccall((:QMPI_Waitall, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{MPI_Request}, Ptr{MPI_Status}), context, tool_id, count, array_of_requests, array_of_statuses)
end

function QMPI_Waitany(context, tool_id, count, array_of_requests, indx, status)
    ccall((:QMPI_Waitany, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{MPI_Status}), context, tool_id, count, array_of_requests, indx, status)
end

function QMPI_Waitsome(context, tool_id, incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
    ccall((:QMPI_Waitsome, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Status}), context, tool_id, incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
end

function QMPIX_Grequest_start(context, tool_id, query_fn, free_fn, cancel_fn, poll_fn, wait_fn, extra_state, request)
    ccall((:QMPIX_Grequest_start, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{MPI_Request}), context, tool_id, query_fn, free_fn, cancel_fn, poll_fn, wait_fn, extra_state, request)
end

function QMPIX_Grequest_class_create(context, tool_id, query_fn, free_fn, cancel_fn, poll_fn, wait_fn, greq_class)
    ccall((:QMPIX_Grequest_class_create, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{MPIX_Grequest_class}), context, tool_id, query_fn, free_fn, cancel_fn, poll_fn, wait_fn, greq_class)
end

function QMPIX_Grequest_class_allocate(context, tool_id, greq_class, extra_state, request)
    ccall((:QMPIX_Grequest_class_allocate, libmpi), Cint, (QMPI_Context, Cint, MPIX_Grequest_class, Ptr{Cvoid}, Ptr{MPI_Request}), context, tool_id, greq_class, extra_state, request)
end

function QMPI_Accumulate(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    ccall((:QMPI_Accumulate, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win), context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

function QMPI_Accumulate_c(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    ccall((:QMPI_Accumulate_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Op, MPI_Win), context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

function QMPI_Alloc_mem(context, tool_id, size, info, baseptr)
    ccall((:QMPI_Alloc_mem, libmpi), Cint, (QMPI_Context, Cint, MPI_Aint, MPI_Info, Ptr{Cvoid}), context, tool_id, size, info, baseptr)
end

function QMPI_Compare_and_swap(context, tool_id, origin_addr, compare_addr, result_addr, datatype, target_rank, target_disp, win)
    ccall((:QMPI_Compare_and_swap, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, MPI_Datatype, Cint, MPI_Aint, MPI_Win), context, tool_id, origin_addr, compare_addr, result_addr, datatype, target_rank, target_disp, win)
end

function QMPI_Fetch_and_op(context, tool_id, origin_addr, result_addr, datatype, target_rank, target_disp, op, win)
    ccall((:QMPI_Fetch_and_op, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Ptr{Cvoid}, MPI_Datatype, Cint, MPI_Aint, MPI_Op, MPI_Win), context, tool_id, origin_addr, result_addr, datatype, target_rank, target_disp, op, win)
end

function QMPI_Free_mem(context, tool_id, base)
    ccall((:QMPI_Free_mem, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}), context, tool_id, base)
end

function QMPI_Get(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    ccall((:QMPI_Get, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win), context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

function QMPI_Get_c(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    ccall((:QMPI_Get_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Win), context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

function QMPI_Get_accumulate(context, tool_id, origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    ccall((:QMPI_Get_accumulate, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win), context, tool_id, origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

function QMPI_Get_accumulate_c(context, tool_id, origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    ccall((:QMPI_Get_accumulate_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Op, MPI_Win), context, tool_id, origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

function QMPI_Put(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    ccall((:QMPI_Put, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win), context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

function QMPI_Put_c(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    ccall((:QMPI_Put_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Win), context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

function QMPI_Raccumulate(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    ccall((:QMPI_Raccumulate, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

function QMPI_Raccumulate_c(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    ccall((:QMPI_Raccumulate_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

function QMPI_Rget(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    ccall((:QMPI_Rget, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

function QMPI_Rget_c(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    ccall((:QMPI_Rget_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

function QMPI_Rget_accumulate(context, tool_id, origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    ccall((:QMPI_Rget_accumulate, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), context, tool_id, origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

function QMPI_Rget_accumulate_c(context, tool_id, origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    ccall((:QMPI_Rget_accumulate_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), context, tool_id, origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

function QMPI_Rput(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    ccall((:QMPI_Rput, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

function QMPI_Rput_c(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    ccall((:QMPI_Rput_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

function QMPI_Win_allocate(context, tool_id, size, disp_unit, info, comm, baseptr, win)
    ccall((:QMPI_Win_allocate, libmpi), Cint, (QMPI_Context, Cint, MPI_Aint, Cint, MPI_Info, MPI_Comm, Ptr{Cvoid}, Ptr{MPI_Win}), context, tool_id, size, disp_unit, info, comm, baseptr, win)
end

function QMPI_Win_allocate_c(context, tool_id, size, disp_unit, info, comm, baseptr, win)
    ccall((:QMPI_Win_allocate_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Aint, MPI_Aint, MPI_Info, MPI_Comm, Ptr{Cvoid}, Ptr{MPI_Win}), context, tool_id, size, disp_unit, info, comm, baseptr, win)
end

function QMPI_Win_allocate_shared(context, tool_id, size, disp_unit, info, comm, baseptr, win)
    ccall((:QMPI_Win_allocate_shared, libmpi), Cint, (QMPI_Context, Cint, MPI_Aint, Cint, MPI_Info, MPI_Comm, Ptr{Cvoid}, Ptr{MPI_Win}), context, tool_id, size, disp_unit, info, comm, baseptr, win)
end

function QMPI_Win_allocate_shared_c(context, tool_id, size, disp_unit, info, comm, baseptr, win)
    ccall((:QMPI_Win_allocate_shared_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Aint, MPI_Aint, MPI_Info, MPI_Comm, Ptr{Cvoid}, Ptr{MPI_Win}), context, tool_id, size, disp_unit, info, comm, baseptr, win)
end

function QMPI_Win_attach(context, tool_id, win, base, size)
    ccall((:QMPI_Win_attach, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, Ptr{Cvoid}, MPI_Aint), context, tool_id, win, base, size)
end

function QMPI_Win_complete(context, tool_id, win)
    ccall((:QMPI_Win_complete, libmpi), Cint, (QMPI_Context, Cint, MPI_Win), context, tool_id, win)
end

function QMPI_Win_create(context, tool_id, base, size, disp_unit, info, comm, win)
    ccall((:QMPI_Win_create, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Aint, Cint, MPI_Info, MPI_Comm, Ptr{MPI_Win}), context, tool_id, base, size, disp_unit, info, comm, win)
end

function QMPI_Win_create_c(context, tool_id, base, size, disp_unit, info, comm, win)
    ccall((:QMPI_Win_create_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cvoid}, MPI_Aint, MPI_Aint, MPI_Info, MPI_Comm, Ptr{MPI_Win}), context, tool_id, base, size, disp_unit, info, comm, win)
end

function QMPI_Win_create_dynamic(context, tool_id, info, comm, win)
    ccall((:QMPI_Win_create_dynamic, libmpi), Cint, (QMPI_Context, Cint, MPI_Info, MPI_Comm, Ptr{MPI_Win}), context, tool_id, info, comm, win)
end

function QMPI_Win_detach(context, tool_id, win, base)
    ccall((:QMPI_Win_detach, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, Ptr{Cvoid}), context, tool_id, win, base)
end

function QMPI_Win_fence(context, tool_id, assert, win)
    ccall((:QMPI_Win_fence, libmpi), Cint, (QMPI_Context, Cint, Cint, MPI_Win), context, tool_id, assert, win)
end

function QMPI_Win_flush(context, tool_id, rank, win)
    ccall((:QMPI_Win_flush, libmpi), Cint, (QMPI_Context, Cint, Cint, MPI_Win), context, tool_id, rank, win)
end

function QMPI_Win_flush_all(context, tool_id, win)
    ccall((:QMPI_Win_flush_all, libmpi), Cint, (QMPI_Context, Cint, MPI_Win), context, tool_id, win)
end

function QMPI_Win_flush_local(context, tool_id, rank, win)
    ccall((:QMPI_Win_flush_local, libmpi), Cint, (QMPI_Context, Cint, Cint, MPI_Win), context, tool_id, rank, win)
end

function QMPI_Win_flush_local_all(context, tool_id, win)
    ccall((:QMPI_Win_flush_local_all, libmpi), Cint, (QMPI_Context, Cint, MPI_Win), context, tool_id, win)
end

function QMPI_Win_free(context, tool_id, win)
    ccall((:QMPI_Win_free, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Win}), context, tool_id, win)
end

function QMPI_Win_get_group(context, tool_id, win, group)
    ccall((:QMPI_Win_get_group, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, Ptr{MPI_Group}), context, tool_id, win, group)
end

function QMPI_Win_get_info(context, tool_id, win, info_used)
    ccall((:QMPI_Win_get_info, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, Ptr{MPI_Info}), context, tool_id, win, info_used)
end

function QMPI_Win_get_name(context, tool_id, win, win_name, resultlen)
    ccall((:QMPI_Win_get_name, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, Ptr{Cchar}, Ptr{Cint}), context, tool_id, win, win_name, resultlen)
end

function QMPI_Win_lock(context, tool_id, lock_type, rank, assert, win)
    ccall((:QMPI_Win_lock, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, Cint, MPI_Win), context, tool_id, lock_type, rank, assert, win)
end

function QMPI_Win_lock_all(context, tool_id, assert, win)
    ccall((:QMPI_Win_lock_all, libmpi), Cint, (QMPI_Context, Cint, Cint, MPI_Win), context, tool_id, assert, win)
end

function QMPI_Win_post(context, tool_id, group, assert, win)
    ccall((:QMPI_Win_post, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, Cint, MPI_Win), context, tool_id, group, assert, win)
end

function QMPI_Win_set_info(context, tool_id, win, info)
    ccall((:QMPI_Win_set_info, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, MPI_Info), context, tool_id, win, info)
end

function QMPI_Win_set_name(context, tool_id, win, win_name)
    ccall((:QMPI_Win_set_name, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, Ptr{Cchar}), context, tool_id, win, win_name)
end

function QMPI_Win_shared_query(context, tool_id, win, rank, size, disp_unit, baseptr)
    ccall((:QMPI_Win_shared_query, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, Cint, Ptr{MPI_Aint}, Ptr{Cint}, Ptr{Cvoid}), context, tool_id, win, rank, size, disp_unit, baseptr)
end

function QMPI_Win_shared_query_c(context, tool_id, win, rank, size, disp_unit, baseptr)
    ccall((:QMPI_Win_shared_query_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, Cint, Ptr{MPI_Aint}, Ptr{MPI_Aint}, Ptr{Cvoid}), context, tool_id, win, rank, size, disp_unit, baseptr)
end

function QMPI_Win_start(context, tool_id, group, assert, win)
    ccall((:QMPI_Win_start, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, Cint, MPI_Win), context, tool_id, group, assert, win)
end

function QMPI_Win_sync(context, tool_id, win)
    ccall((:QMPI_Win_sync, libmpi), Cint, (QMPI_Context, Cint, MPI_Win), context, tool_id, win)
end

function QMPI_Win_test(context, tool_id, win, flag)
    ccall((:QMPI_Win_test, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, Ptr{Cint}), context, tool_id, win, flag)
end

function QMPI_Win_unlock(context, tool_id, rank, win)
    ccall((:QMPI_Win_unlock, libmpi), Cint, (QMPI_Context, Cint, Cint, MPI_Win), context, tool_id, rank, win)
end

function QMPI_Win_unlock_all(context, tool_id, win)
    ccall((:QMPI_Win_unlock_all, libmpi), Cint, (QMPI_Context, Cint, MPI_Win), context, tool_id, win)
end

function QMPI_Win_wait(context, tool_id, win)
    ccall((:QMPI_Win_wait, libmpi), Cint, (QMPI_Context, Cint, MPI_Win), context, tool_id, win)
end

function QMPI_Close_port(context, tool_id, port_name)
    ccall((:QMPI_Close_port, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}), context, tool_id, port_name)
end

function QMPI_Comm_accept(context, tool_id, port_name, info, root, comm, newcomm)
    ccall((:QMPI_Comm_accept, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, MPI_Info, Cint, MPI_Comm, Ptr{MPI_Comm}), context, tool_id, port_name, info, root, comm, newcomm)
end

function QMPI_Comm_connect(context, tool_id, port_name, info, root, comm, newcomm)
    ccall((:QMPI_Comm_connect, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, MPI_Info, Cint, MPI_Comm, Ptr{MPI_Comm}), context, tool_id, port_name, info, root, comm, newcomm)
end

function QMPI_Comm_disconnect(context, tool_id, comm)
    ccall((:QMPI_Comm_disconnect, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Comm}), context, tool_id, comm)
end

function QMPI_Comm_get_parent(context, tool_id, parent)
    ccall((:QMPI_Comm_get_parent, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Comm}), context, tool_id, parent)
end

function QMPI_Comm_join(context, tool_id, fd, intercomm)
    ccall((:QMPI_Comm_join, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{MPI_Comm}), context, tool_id, fd, intercomm)
end

function QMPI_Comm_spawn(context, tool_id, command, argv, maxprocs, info, root, comm, intercomm, array_of_errcodes)
    ccall((:QMPI_Comm_spawn, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, Ptr{Ptr{Cchar}}, Cint, MPI_Info, Cint, MPI_Comm, Ptr{MPI_Comm}, Ptr{Cint}), context, tool_id, command, argv, maxprocs, info, root, comm, intercomm, array_of_errcodes)
end

function QMPI_Comm_spawn_multiple(context, tool_id, count, array_of_commands, array_of_argv, array_of_maxprocs, array_of_info, root, comm, intercomm, array_of_errcodes)
    ccall((:QMPI_Comm_spawn_multiple, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Ptr{Cchar}}, Ptr{Ptr{Ptr{Cchar}}}, Ptr{Cint}, Ptr{MPI_Info}, Cint, MPI_Comm, Ptr{MPI_Comm}, Ptr{Cint}), context, tool_id, count, array_of_commands, array_of_argv, array_of_maxprocs, array_of_info, root, comm, intercomm, array_of_errcodes)
end

function QMPI_Lookup_name(context, tool_id, service_name, info, port_name)
    ccall((:QMPI_Lookup_name, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, MPI_Info, Ptr{Cchar}), context, tool_id, service_name, info, port_name)
end

function QMPI_Open_port(context, tool_id, info, port_name)
    ccall((:QMPI_Open_port, libmpi), Cint, (QMPI_Context, Cint, MPI_Info, Ptr{Cchar}), context, tool_id, info, port_name)
end

function QMPI_Publish_name(context, tool_id, service_name, info, port_name)
    ccall((:QMPI_Publish_name, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, MPI_Info, Ptr{Cchar}), context, tool_id, service_name, info, port_name)
end

function QMPI_Unpublish_name(context, tool_id, service_name, info, port_name)
    ccall((:QMPI_Unpublish_name, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, MPI_Info, Ptr{Cchar}), context, tool_id, service_name, info, port_name)
end

function QMPI_Wtick(context, tool_id)
    ccall((:QMPI_Wtick, libmpi), Cdouble, (QMPI_Context, Cint), context, tool_id)
end

function QMPI_Wtime(context, tool_id)
    ccall((:QMPI_Wtime, libmpi), Cdouble, (QMPI_Context, Cint), context, tool_id)
end

function QMPI_Cart_coords(context, tool_id, comm, rank, maxdims, coords)
    ccall((:QMPI_Cart_coords, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Cint, Ptr{Cint}), context, tool_id, comm, rank, maxdims, coords)
end

function QMPI_Cart_create(context, tool_id, comm_old, ndims, dims, periods, reorder, comm_cart)
    ccall((:QMPI_Cart_create, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{MPI_Comm}), context, tool_id, comm_old, ndims, dims, periods, reorder, comm_cart)
end

function QMPI_Cart_get(context, tool_id, comm, maxdims, dims, periods, coords)
    ccall((:QMPI_Cart_get, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), context, tool_id, comm, maxdims, dims, periods, coords)
end

function QMPI_Cart_map(context, tool_id, comm, ndims, dims, periods, newrank)
    ccall((:QMPI_Cart_map, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), context, tool_id, comm, ndims, dims, periods, newrank)
end

function QMPI_Cart_rank(context, tool_id, comm, coords, rank)
    ccall((:QMPI_Cart_rank, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{Cint}, Ptr{Cint}), context, tool_id, comm, coords, rank)
end

function QMPI_Cart_shift(context, tool_id, comm, direction, disp, rank_source, rank_dest)
    ccall((:QMPI_Cart_shift, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Cint, Ptr{Cint}, Ptr{Cint}), context, tool_id, comm, direction, disp, rank_source, rank_dest)
end

function QMPI_Cart_sub(context, tool_id, comm, remain_dims, newcomm)
    ccall((:QMPI_Cart_sub, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{Cint}, Ptr{MPI_Comm}), context, tool_id, comm, remain_dims, newcomm)
end

function QMPI_Cartdim_get(context, tool_id, comm, ndims)
    ccall((:QMPI_Cartdim_get, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{Cint}), context, tool_id, comm, ndims)
end

function QMPI_Dims_create(context, tool_id, nnodes, ndims, dims)
    ccall((:QMPI_Dims_create, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, Ptr{Cint}), context, tool_id, nnodes, ndims, dims)
end

function QMPI_Dist_graph_create(context, tool_id, comm_old, n, sources, degrees, destinations, weights, info, reorder, comm_dist_graph)
    ccall((:QMPI_Dist_graph_create, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, MPI_Info, Cint, Ptr{MPI_Comm}), context, tool_id, comm_old, n, sources, degrees, destinations, weights, info, reorder, comm_dist_graph)
end

function QMPI_Dist_graph_create_adjacent(context, tool_id, comm_old, indegree, sources, sourceweights, outdegree, destinations, destweights, info, reorder, comm_dist_graph)
    ccall((:QMPI_Dist_graph_create_adjacent, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{Cint}, Ptr{Cint}, MPI_Info, Cint, Ptr{MPI_Comm}), context, tool_id, comm_old, indegree, sources, sourceweights, outdegree, destinations, destweights, info, reorder, comm_dist_graph)
end

function QMPI_Dist_graph_neighbors(context, tool_id, comm, maxindegree, sources, sourceweights, maxoutdegree, destinations, destweights)
    ccall((:QMPI_Dist_graph_neighbors, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{Cint}, Ptr{Cint}), context, tool_id, comm, maxindegree, sources, sourceweights, maxoutdegree, destinations, destweights)
end

function QMPI_Dist_graph_neighbors_count(context, tool_id, comm, indegree, outdegree, weighted)
    ccall((:QMPI_Dist_graph_neighbors_count, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), context, tool_id, comm, indegree, outdegree, weighted)
end

function QMPI_Graph_create(context, tool_id, comm_old, nnodes, indx, edges, reorder, comm_graph)
    ccall((:QMPI_Graph_create, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{MPI_Comm}), context, tool_id, comm_old, nnodes, indx, edges, reorder, comm_graph)
end

function QMPI_Graph_get(context, tool_id, comm, maxindex, maxedges, indx, edges)
    ccall((:QMPI_Graph_get, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Cint, Ptr{Cint}, Ptr{Cint}), context, tool_id, comm, maxindex, maxedges, indx, edges)
end

function QMPI_Graph_map(context, tool_id, comm, nnodes, indx, edges, newrank)
    ccall((:QMPI_Graph_map, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), context, tool_id, comm, nnodes, indx, edges, newrank)
end

function QMPI_Graph_neighbors(context, tool_id, comm, rank, maxneighbors, neighbors)
    ccall((:QMPI_Graph_neighbors, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Cint, Ptr{Cint}), context, tool_id, comm, rank, maxneighbors, neighbors)
end

function QMPI_Graph_neighbors_count(context, tool_id, comm, rank, nneighbors)
    ccall((:QMPI_Graph_neighbors_count, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Ptr{Cint}), context, tool_id, comm, rank, nneighbors)
end

function QMPI_Graphdims_get(context, tool_id, comm, nnodes, nedges)
    ccall((:QMPI_Graphdims_get, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{Cint}, Ptr{Cint}), context, tool_id, comm, nnodes, nedges)
end

function QMPI_Topo_test(context, tool_id, comm, status)
    ccall((:QMPI_Topo_test, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{Cint}), context, tool_id, comm, status)
end

# typedef int ( QMPI_Attr_delete_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , int keyval )
const QMPI_Attr_delete_t = Cvoid

# typedef int ( QMPI_Attr_get_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , int keyval , void * attribute_val , int * flag )
const QMPI_Attr_get_t = Cvoid

# typedef int ( QMPI_Attr_put_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , int keyval , void * attribute_val )
const QMPI_Attr_put_t = Cvoid

# typedef int ( QMPI_Comm_create_keyval_t ) ( QMPI_Context context , int tool_id , MPI_Comm_copy_attr_function * comm_copy_attr_fn , MPI_Comm_delete_attr_function * comm_delete_attr_fn , int * comm_keyval , void * extra_state )
const QMPI_Comm_create_keyval_t = Cvoid

# typedef int ( QMPI_Comm_delete_attr_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , int comm_keyval )
const QMPI_Comm_delete_attr_t = Cvoid

# typedef int ( QMPI_Comm_free_keyval_t ) ( QMPI_Context context , int tool_id , int * comm_keyval )
const QMPI_Comm_free_keyval_t = Cvoid

# typedef int ( QMPI_Comm_get_attr_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , int comm_keyval , void * attribute_val , int * flag )
const QMPI_Comm_get_attr_t = Cvoid

# typedef int ( QMPI_Comm_set_attr_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , int comm_keyval , void * attribute_val )
const QMPI_Comm_set_attr_t = Cvoid

# typedef int ( QMPI_Keyval_create_t ) ( QMPI_Context context , int tool_id , MPI_Copy_function * copy_fn , MPI_Delete_function * delete_fn , int * keyval , void * extra_state )
const QMPI_Keyval_create_t = Cvoid

# typedef int ( QMPI_Keyval_free_t ) ( QMPI_Context context , int tool_id , int * keyval )
const QMPI_Keyval_free_t = Cvoid

# typedef int ( QMPI_Type_create_keyval_t ) ( QMPI_Context context , int tool_id , MPI_Type_copy_attr_function * type_copy_attr_fn , MPI_Type_delete_attr_function * type_delete_attr_fn , int * type_keyval , void * extra_state )
const QMPI_Type_create_keyval_t = Cvoid

# typedef int ( QMPI_Type_delete_attr_t ) ( QMPI_Context context , int tool_id , MPI_Datatype datatype , int type_keyval )
const QMPI_Type_delete_attr_t = Cvoid

# typedef int ( QMPI_Type_free_keyval_t ) ( QMPI_Context context , int tool_id , int * type_keyval )
const QMPI_Type_free_keyval_t = Cvoid

# typedef int ( QMPI_Type_get_attr_t ) ( QMPI_Context context , int tool_id , MPI_Datatype datatype , int type_keyval , void * attribute_val , int * flag )
const QMPI_Type_get_attr_t = Cvoid

# typedef int ( QMPI_Type_set_attr_t ) ( QMPI_Context context , int tool_id , MPI_Datatype datatype , int type_keyval , void * attribute_val )
const QMPI_Type_set_attr_t = Cvoid

# typedef int ( QMPI_Win_create_keyval_t ) ( QMPI_Context context , int tool_id , MPI_Win_copy_attr_function * win_copy_attr_fn , MPI_Win_delete_attr_function * win_delete_attr_fn , int * win_keyval , void * extra_state )
const QMPI_Win_create_keyval_t = Cvoid

# typedef int ( QMPI_Win_delete_attr_t ) ( QMPI_Context context , int tool_id , MPI_Win win , int win_keyval )
const QMPI_Win_delete_attr_t = Cvoid

# typedef int ( QMPI_Win_free_keyval_t ) ( QMPI_Context context , int tool_id , int * win_keyval )
const QMPI_Win_free_keyval_t = Cvoid

# typedef int ( QMPI_Win_get_attr_t ) ( QMPI_Context context , int tool_id , MPI_Win win , int win_keyval , void * attribute_val , int * flag )
const QMPI_Win_get_attr_t = Cvoid

# typedef int ( QMPI_Win_set_attr_t ) ( QMPI_Context context , int tool_id , MPI_Win win , int win_keyval , void * attribute_val )
const QMPI_Win_set_attr_t = Cvoid

# typedef int ( QMPI_Allgather_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , void * recvbuf , int recvcount , MPI_Datatype recvtype , MPI_Comm comm )
const QMPI_Allgather_t = Cvoid

# typedef int ( QMPI_Allgather_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , void * recvbuf , MPI_Count recvcount , MPI_Datatype recvtype , MPI_Comm comm )
const QMPI_Allgather_c_t = Cvoid

# typedef int ( QMPI_Allgather_init_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , void * recvbuf , int recvcount , MPI_Datatype recvtype , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Allgather_init_t = Cvoid

# typedef int ( QMPI_Allgather_init_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , void * recvbuf , MPI_Count recvcount , MPI_Datatype recvtype , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Allgather_init_c_t = Cvoid

# typedef int ( QMPI_Allgatherv_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , void * recvbuf , const int recvcounts [ ] , const int displs [ ] , MPI_Datatype recvtype , MPI_Comm comm )
const QMPI_Allgatherv_t = Cvoid

# typedef int ( QMPI_Allgatherv_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , void * recvbuf , const MPI_Count recvcounts [ ] , const MPI_Aint displs [ ] , MPI_Datatype recvtype , MPI_Comm comm )
const QMPI_Allgatherv_c_t = Cvoid

# typedef int ( QMPI_Allgatherv_init_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , void * recvbuf , const int recvcounts [ ] , const int displs [ ] , MPI_Datatype recvtype , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Allgatherv_init_t = Cvoid

# typedef int ( QMPI_Allgatherv_init_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , void * recvbuf , const MPI_Count recvcounts [ ] , const MPI_Aint displs [ ] , MPI_Datatype recvtype , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Allgatherv_init_c_t = Cvoid

# typedef int ( QMPI_Allreduce_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , int count , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm )
const QMPI_Allreduce_t = Cvoid

# typedef int ( QMPI_Allreduce_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , MPI_Count count , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm )
const QMPI_Allreduce_c_t = Cvoid

# typedef int ( QMPI_Allreduce_init_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , int count , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Allreduce_init_t = Cvoid

# typedef int ( QMPI_Allreduce_init_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , MPI_Count count , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Allreduce_init_c_t = Cvoid

# typedef int ( QMPI_Alltoall_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , void * recvbuf , int recvcount , MPI_Datatype recvtype , MPI_Comm comm )
const QMPI_Alltoall_t = Cvoid

# typedef int ( QMPI_Alltoall_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , void * recvbuf , MPI_Count recvcount , MPI_Datatype recvtype , MPI_Comm comm )
const QMPI_Alltoall_c_t = Cvoid

# typedef int ( QMPI_Alltoall_init_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , void * recvbuf , int recvcount , MPI_Datatype recvtype , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Alltoall_init_t = Cvoid

# typedef int ( QMPI_Alltoall_init_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , void * recvbuf , MPI_Count recvcount , MPI_Datatype recvtype , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Alltoall_init_c_t = Cvoid

# typedef int ( QMPI_Alltoallv_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const int sendcounts [ ] , const int sdispls [ ] , MPI_Datatype sendtype , void * recvbuf , const int recvcounts [ ] , const int rdispls [ ] , MPI_Datatype recvtype , MPI_Comm comm )
const QMPI_Alltoallv_t = Cvoid

# typedef int ( QMPI_Alltoallv_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const MPI_Count sendcounts [ ] , const MPI_Aint sdispls [ ] , MPI_Datatype sendtype , void * recvbuf , const MPI_Count recvcounts [ ] , const MPI_Aint rdispls [ ] , MPI_Datatype recvtype , MPI_Comm comm )
const QMPI_Alltoallv_c_t = Cvoid

# typedef int ( QMPI_Alltoallv_init_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const int sendcounts [ ] , const int sdispls [ ] , MPI_Datatype sendtype , void * recvbuf , const int recvcounts [ ] , const int rdispls [ ] , MPI_Datatype recvtype , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Alltoallv_init_t = Cvoid

# typedef int ( QMPI_Alltoallv_init_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const MPI_Count sendcounts [ ] , const MPI_Aint sdispls [ ] , MPI_Datatype sendtype , void * recvbuf , const MPI_Count recvcounts [ ] , const MPI_Aint rdispls [ ] , MPI_Datatype recvtype , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Alltoallv_init_c_t = Cvoid

# typedef int ( QMPI_Alltoallw_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const int sendcounts [ ] , const int sdispls [ ] , const MPI_Datatype sendtypes [ ] , void * recvbuf , const int recvcounts [ ] , const int rdispls [ ] , const MPI_Datatype recvtypes [ ] , MPI_Comm comm )
const QMPI_Alltoallw_t = Cvoid

# typedef int ( QMPI_Alltoallw_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const MPI_Count sendcounts [ ] , const MPI_Aint sdispls [ ] , const MPI_Datatype sendtypes [ ] , void * recvbuf , const MPI_Count recvcounts [ ] , const MPI_Aint rdispls [ ] , const MPI_Datatype recvtypes [ ] , MPI_Comm comm )
const QMPI_Alltoallw_c_t = Cvoid

# typedef int ( QMPI_Alltoallw_init_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const int sendcounts [ ] , const int sdispls [ ] , const MPI_Datatype sendtypes [ ] , void * recvbuf , const int recvcounts [ ] , const int rdispls [ ] , const MPI_Datatype recvtypes [ ] , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Alltoallw_init_t = Cvoid

# typedef int ( QMPI_Alltoallw_init_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const MPI_Count sendcounts [ ] , const MPI_Aint sdispls [ ] , const MPI_Datatype sendtypes [ ] , void * recvbuf , const MPI_Count recvcounts [ ] , const MPI_Aint rdispls [ ] , const MPI_Datatype recvtypes [ ] , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Alltoallw_init_c_t = Cvoid

# typedef int ( QMPI_Barrier_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm )
const QMPI_Barrier_t = Cvoid

# typedef int ( QMPI_Barrier_init_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Barrier_init_t = Cvoid

# typedef int ( QMPI_Bcast_t ) ( QMPI_Context context , int tool_id , void * buffer , int count , MPI_Datatype datatype , int root , MPI_Comm comm )
const QMPI_Bcast_t = Cvoid

# typedef int ( QMPI_Bcast_c_t ) ( QMPI_Context context , int tool_id , void * buffer , MPI_Count count , MPI_Datatype datatype , int root , MPI_Comm comm )
const QMPI_Bcast_c_t = Cvoid

# typedef int ( QMPI_Bcast_init_t ) ( QMPI_Context context , int tool_id , void * buffer , int count , MPI_Datatype datatype , int root , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Bcast_init_t = Cvoid

# typedef int ( QMPI_Bcast_init_c_t ) ( QMPI_Context context , int tool_id , void * buffer , MPI_Count count , MPI_Datatype datatype , int root , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Bcast_init_c_t = Cvoid

# typedef int ( QMPI_Exscan_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , int count , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm )
const QMPI_Exscan_t = Cvoid

# typedef int ( QMPI_Exscan_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , MPI_Count count , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm )
const QMPI_Exscan_c_t = Cvoid

# typedef int ( QMPI_Exscan_init_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , int count , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Exscan_init_t = Cvoid

# typedef int ( QMPI_Exscan_init_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , MPI_Count count , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Exscan_init_c_t = Cvoid

# typedef int ( QMPI_Gather_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , void * recvbuf , int recvcount , MPI_Datatype recvtype , int root , MPI_Comm comm )
const QMPI_Gather_t = Cvoid

# typedef int ( QMPI_Gather_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , void * recvbuf , MPI_Count recvcount , MPI_Datatype recvtype , int root , MPI_Comm comm )
const QMPI_Gather_c_t = Cvoid

# typedef int ( QMPI_Gather_init_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , void * recvbuf , int recvcount , MPI_Datatype recvtype , int root , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Gather_init_t = Cvoid

# typedef int ( QMPI_Gather_init_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , void * recvbuf , MPI_Count recvcount , MPI_Datatype recvtype , int root , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Gather_init_c_t = Cvoid

# typedef int ( QMPI_Gatherv_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , void * recvbuf , const int recvcounts [ ] , const int displs [ ] , MPI_Datatype recvtype , int root , MPI_Comm comm )
const QMPI_Gatherv_t = Cvoid

# typedef int ( QMPI_Gatherv_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , void * recvbuf , const MPI_Count recvcounts [ ] , const MPI_Aint displs [ ] , MPI_Datatype recvtype , int root , MPI_Comm comm )
const QMPI_Gatherv_c_t = Cvoid

# typedef int ( QMPI_Gatherv_init_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , void * recvbuf , const int recvcounts [ ] , const int displs [ ] , MPI_Datatype recvtype , int root , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Gatherv_init_t = Cvoid

# typedef int ( QMPI_Gatherv_init_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , void * recvbuf , const MPI_Count recvcounts [ ] , const MPI_Aint displs [ ] , MPI_Datatype recvtype , int root , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Gatherv_init_c_t = Cvoid

# typedef int ( QMPI_Iallgather_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , void * recvbuf , int recvcount , MPI_Datatype recvtype , MPI_Comm comm , MPI_Request * request )
const QMPI_Iallgather_t = Cvoid

# typedef int ( QMPI_Iallgather_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , void * recvbuf , MPI_Count recvcount , MPI_Datatype recvtype , MPI_Comm comm , MPI_Request * request )
const QMPI_Iallgather_c_t = Cvoid

# typedef int ( QMPI_Iallgatherv_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , void * recvbuf , const int recvcounts [ ] , const int displs [ ] , MPI_Datatype recvtype , MPI_Comm comm , MPI_Request * request )
const QMPI_Iallgatherv_t = Cvoid

# typedef int ( QMPI_Iallgatherv_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , void * recvbuf , const MPI_Count recvcounts [ ] , const MPI_Aint displs [ ] , MPI_Datatype recvtype , MPI_Comm comm , MPI_Request * request )
const QMPI_Iallgatherv_c_t = Cvoid

# typedef int ( QMPI_Iallreduce_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , int count , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm , MPI_Request * request )
const QMPI_Iallreduce_t = Cvoid

# typedef int ( QMPI_Iallreduce_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , MPI_Count count , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm , MPI_Request * request )
const QMPI_Iallreduce_c_t = Cvoid

# typedef int ( QMPI_Ialltoall_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , void * recvbuf , int recvcount , MPI_Datatype recvtype , MPI_Comm comm , MPI_Request * request )
const QMPI_Ialltoall_t = Cvoid

# typedef int ( QMPI_Ialltoall_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , void * recvbuf , MPI_Count recvcount , MPI_Datatype recvtype , MPI_Comm comm , MPI_Request * request )
const QMPI_Ialltoall_c_t = Cvoid

# typedef int ( QMPI_Ialltoallv_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const int sendcounts [ ] , const int sdispls [ ] , MPI_Datatype sendtype , void * recvbuf , const int recvcounts [ ] , const int rdispls [ ] , MPI_Datatype recvtype , MPI_Comm comm , MPI_Request * request )
const QMPI_Ialltoallv_t = Cvoid

# typedef int ( QMPI_Ialltoallv_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const MPI_Count sendcounts [ ] , const MPI_Aint sdispls [ ] , MPI_Datatype sendtype , void * recvbuf , const MPI_Count recvcounts [ ] , const MPI_Aint rdispls [ ] , MPI_Datatype recvtype , MPI_Comm comm , MPI_Request * request )
const QMPI_Ialltoallv_c_t = Cvoid

# typedef int ( QMPI_Ialltoallw_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const int sendcounts [ ] , const int sdispls [ ] , const MPI_Datatype sendtypes [ ] , void * recvbuf , const int recvcounts [ ] , const int rdispls [ ] , const MPI_Datatype recvtypes [ ] , MPI_Comm comm , MPI_Request * request )
const QMPI_Ialltoallw_t = Cvoid

# typedef int ( QMPI_Ialltoallw_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const MPI_Count sendcounts [ ] , const MPI_Aint sdispls [ ] , const MPI_Datatype sendtypes [ ] , void * recvbuf , const MPI_Count recvcounts [ ] , const MPI_Aint rdispls [ ] , const MPI_Datatype recvtypes [ ] , MPI_Comm comm , MPI_Request * request )
const QMPI_Ialltoallw_c_t = Cvoid

# typedef int ( QMPI_Ibarrier_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , MPI_Request * request )
const QMPI_Ibarrier_t = Cvoid

# typedef int ( QMPI_Ibcast_t ) ( QMPI_Context context , int tool_id , void * buffer , int count , MPI_Datatype datatype , int root , MPI_Comm comm , MPI_Request * request )
const QMPI_Ibcast_t = Cvoid

# typedef int ( QMPI_Ibcast_c_t ) ( QMPI_Context context , int tool_id , void * buffer , MPI_Count count , MPI_Datatype datatype , int root , MPI_Comm comm , MPI_Request * request )
const QMPI_Ibcast_c_t = Cvoid

# typedef int ( QMPI_Iexscan_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , int count , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm , MPI_Request * request )
const QMPI_Iexscan_t = Cvoid

# typedef int ( QMPI_Iexscan_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , MPI_Count count , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm , MPI_Request * request )
const QMPI_Iexscan_c_t = Cvoid

# typedef int ( QMPI_Igather_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , void * recvbuf , int recvcount , MPI_Datatype recvtype , int root , MPI_Comm comm , MPI_Request * request )
const QMPI_Igather_t = Cvoid

# typedef int ( QMPI_Igather_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , void * recvbuf , MPI_Count recvcount , MPI_Datatype recvtype , int root , MPI_Comm comm , MPI_Request * request )
const QMPI_Igather_c_t = Cvoid

# typedef int ( QMPI_Igatherv_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , void * recvbuf , const int recvcounts [ ] , const int displs [ ] , MPI_Datatype recvtype , int root , MPI_Comm comm , MPI_Request * request )
const QMPI_Igatherv_t = Cvoid

# typedef int ( QMPI_Igatherv_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , void * recvbuf , const MPI_Count recvcounts [ ] , const MPI_Aint displs [ ] , MPI_Datatype recvtype , int root , MPI_Comm comm , MPI_Request * request )
const QMPI_Igatherv_c_t = Cvoid

# typedef int ( QMPI_Ineighbor_allgather_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , void * recvbuf , int recvcount , MPI_Datatype recvtype , MPI_Comm comm , MPI_Request * request )
const QMPI_Ineighbor_allgather_t = Cvoid

# typedef int ( QMPI_Ineighbor_allgather_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , void * recvbuf , MPI_Count recvcount , MPI_Datatype recvtype , MPI_Comm comm , MPI_Request * request )
const QMPI_Ineighbor_allgather_c_t = Cvoid

# typedef int ( QMPI_Ineighbor_allgatherv_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , void * recvbuf , const int recvcounts [ ] , const int displs [ ] , MPI_Datatype recvtype , MPI_Comm comm , MPI_Request * request )
const QMPI_Ineighbor_allgatherv_t = Cvoid

# typedef int ( QMPI_Ineighbor_allgatherv_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , void * recvbuf , const MPI_Count recvcounts [ ] , const MPI_Aint displs [ ] , MPI_Datatype recvtype , MPI_Comm comm , MPI_Request * request )
const QMPI_Ineighbor_allgatherv_c_t = Cvoid

# typedef int ( QMPI_Ineighbor_alltoall_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , void * recvbuf , int recvcount , MPI_Datatype recvtype , MPI_Comm comm , MPI_Request * request )
const QMPI_Ineighbor_alltoall_t = Cvoid

# typedef int ( QMPI_Ineighbor_alltoall_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , void * recvbuf , MPI_Count recvcount , MPI_Datatype recvtype , MPI_Comm comm , MPI_Request * request )
const QMPI_Ineighbor_alltoall_c_t = Cvoid

# typedef int ( QMPI_Ineighbor_alltoallv_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const int sendcounts [ ] , const int sdispls [ ] , MPI_Datatype sendtype , void * recvbuf , const int recvcounts [ ] , const int rdispls [ ] , MPI_Datatype recvtype , MPI_Comm comm , MPI_Request * request )
const QMPI_Ineighbor_alltoallv_t = Cvoid

# typedef int ( QMPI_Ineighbor_alltoallv_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const MPI_Count sendcounts [ ] , const MPI_Aint sdispls [ ] , MPI_Datatype sendtype , void * recvbuf , const MPI_Count recvcounts [ ] , const MPI_Aint rdispls [ ] , MPI_Datatype recvtype , MPI_Comm comm , MPI_Request * request )
const QMPI_Ineighbor_alltoallv_c_t = Cvoid

# typedef int ( QMPI_Ineighbor_alltoallw_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const int sendcounts [ ] , const MPI_Aint sdispls [ ] , const MPI_Datatype sendtypes [ ] , void * recvbuf , const int recvcounts [ ] , const MPI_Aint rdispls [ ] , const MPI_Datatype recvtypes [ ] , MPI_Comm comm , MPI_Request * request )
const QMPI_Ineighbor_alltoallw_t = Cvoid

# typedef int ( QMPI_Ineighbor_alltoallw_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const MPI_Count sendcounts [ ] , const MPI_Aint sdispls [ ] , const MPI_Datatype sendtypes [ ] , void * recvbuf , const MPI_Count recvcounts [ ] , const MPI_Aint rdispls [ ] , const MPI_Datatype recvtypes [ ] , MPI_Comm comm , MPI_Request * request )
const QMPI_Ineighbor_alltoallw_c_t = Cvoid

# typedef int ( QMPI_Ireduce_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , int count , MPI_Datatype datatype , MPI_Op op , int root , MPI_Comm comm , MPI_Request * request )
const QMPI_Ireduce_t = Cvoid

# typedef int ( QMPI_Ireduce_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , MPI_Count count , MPI_Datatype datatype , MPI_Op op , int root , MPI_Comm comm , MPI_Request * request )
const QMPI_Ireduce_c_t = Cvoid

# typedef int ( QMPI_Ireduce_scatter_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , const int recvcounts [ ] , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm , MPI_Request * request )
const QMPI_Ireduce_scatter_t = Cvoid

# typedef int ( QMPI_Ireduce_scatter_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , const MPI_Count recvcounts [ ] , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm , MPI_Request * request )
const QMPI_Ireduce_scatter_c_t = Cvoid

# typedef int ( QMPI_Ireduce_scatter_block_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , int recvcount , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm , MPI_Request * request )
const QMPI_Ireduce_scatter_block_t = Cvoid

# typedef int ( QMPI_Ireduce_scatter_block_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , MPI_Count recvcount , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm , MPI_Request * request )
const QMPI_Ireduce_scatter_block_c_t = Cvoid

# typedef int ( QMPI_Iscan_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , int count , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm , MPI_Request * request )
const QMPI_Iscan_t = Cvoid

# typedef int ( QMPI_Iscan_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , MPI_Count count , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm , MPI_Request * request )
const QMPI_Iscan_c_t = Cvoid

# typedef int ( QMPI_Iscatter_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , void * recvbuf , int recvcount , MPI_Datatype recvtype , int root , MPI_Comm comm , MPI_Request * request )
const QMPI_Iscatter_t = Cvoid

# typedef int ( QMPI_Iscatter_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , void * recvbuf , MPI_Count recvcount , MPI_Datatype recvtype , int root , MPI_Comm comm , MPI_Request * request )
const QMPI_Iscatter_c_t = Cvoid

# typedef int ( QMPI_Iscatterv_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const int sendcounts [ ] , const int displs [ ] , MPI_Datatype sendtype , void * recvbuf , int recvcount , MPI_Datatype recvtype , int root , MPI_Comm comm , MPI_Request * request )
const QMPI_Iscatterv_t = Cvoid

# typedef int ( QMPI_Iscatterv_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const MPI_Count sendcounts [ ] , const MPI_Aint displs [ ] , MPI_Datatype sendtype , void * recvbuf , MPI_Count recvcount , MPI_Datatype recvtype , int root , MPI_Comm comm , MPI_Request * request )
const QMPI_Iscatterv_c_t = Cvoid

# typedef int ( QMPI_Neighbor_allgather_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , void * recvbuf , int recvcount , MPI_Datatype recvtype , MPI_Comm comm )
const QMPI_Neighbor_allgather_t = Cvoid

# typedef int ( QMPI_Neighbor_allgather_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , void * recvbuf , MPI_Count recvcount , MPI_Datatype recvtype , MPI_Comm comm )
const QMPI_Neighbor_allgather_c_t = Cvoid

# typedef int ( QMPI_Neighbor_allgather_init_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , void * recvbuf , int recvcount , MPI_Datatype recvtype , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Neighbor_allgather_init_t = Cvoid

# typedef int ( QMPI_Neighbor_allgather_init_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , void * recvbuf , MPI_Count recvcount , MPI_Datatype recvtype , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Neighbor_allgather_init_c_t = Cvoid

# typedef int ( QMPI_Neighbor_allgatherv_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , void * recvbuf , const int recvcounts [ ] , const int displs [ ] , MPI_Datatype recvtype , MPI_Comm comm )
const QMPI_Neighbor_allgatherv_t = Cvoid

# typedef int ( QMPI_Neighbor_allgatherv_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , void * recvbuf , const MPI_Count recvcounts [ ] , const MPI_Aint displs [ ] , MPI_Datatype recvtype , MPI_Comm comm )
const QMPI_Neighbor_allgatherv_c_t = Cvoid

# typedef int ( QMPI_Neighbor_allgatherv_init_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , void * recvbuf , const int recvcounts [ ] , const int displs [ ] , MPI_Datatype recvtype , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Neighbor_allgatherv_init_t = Cvoid

# typedef int ( QMPI_Neighbor_allgatherv_init_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , void * recvbuf , const MPI_Count recvcounts [ ] , const MPI_Aint displs [ ] , MPI_Datatype recvtype , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Neighbor_allgatherv_init_c_t = Cvoid

# typedef int ( QMPI_Neighbor_alltoall_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , void * recvbuf , int recvcount , MPI_Datatype recvtype , MPI_Comm comm )
const QMPI_Neighbor_alltoall_t = Cvoid

# typedef int ( QMPI_Neighbor_alltoall_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , void * recvbuf , MPI_Count recvcount , MPI_Datatype recvtype , MPI_Comm comm )
const QMPI_Neighbor_alltoall_c_t = Cvoid

# typedef int ( QMPI_Neighbor_alltoall_init_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , void * recvbuf , int recvcount , MPI_Datatype recvtype , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Neighbor_alltoall_init_t = Cvoid

# typedef int ( QMPI_Neighbor_alltoall_init_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , void * recvbuf , MPI_Count recvcount , MPI_Datatype recvtype , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Neighbor_alltoall_init_c_t = Cvoid

# typedef int ( QMPI_Neighbor_alltoallv_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const int sendcounts [ ] , const int sdispls [ ] , MPI_Datatype sendtype , void * recvbuf , const int recvcounts [ ] , const int rdispls [ ] , MPI_Datatype recvtype , MPI_Comm comm )
const QMPI_Neighbor_alltoallv_t = Cvoid

# typedef int ( QMPI_Neighbor_alltoallv_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const MPI_Count sendcounts [ ] , const MPI_Aint sdispls [ ] , MPI_Datatype sendtype , void * recvbuf , const MPI_Count recvcounts [ ] , const MPI_Aint rdispls [ ] , MPI_Datatype recvtype , MPI_Comm comm )
const QMPI_Neighbor_alltoallv_c_t = Cvoid

# typedef int ( QMPI_Neighbor_alltoallv_init_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const int sendcounts [ ] , const int sdispls [ ] , MPI_Datatype sendtype , void * recvbuf , const int recvcounts [ ] , const int rdispls [ ] , MPI_Datatype recvtype , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Neighbor_alltoallv_init_t = Cvoid

# typedef int ( QMPI_Neighbor_alltoallv_init_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const MPI_Count sendcounts [ ] , const MPI_Aint sdispls [ ] , MPI_Datatype sendtype , void * recvbuf , const MPI_Count recvcounts [ ] , const MPI_Aint rdispls [ ] , MPI_Datatype recvtype , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Neighbor_alltoallv_init_c_t = Cvoid

# typedef int ( QMPI_Neighbor_alltoallw_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const int sendcounts [ ] , const MPI_Aint sdispls [ ] , const MPI_Datatype sendtypes [ ] , void * recvbuf , const int recvcounts [ ] , const MPI_Aint rdispls [ ] , const MPI_Datatype recvtypes [ ] , MPI_Comm comm )
const QMPI_Neighbor_alltoallw_t = Cvoid

# typedef int ( QMPI_Neighbor_alltoallw_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const MPI_Count sendcounts [ ] , const MPI_Aint sdispls [ ] , const MPI_Datatype sendtypes [ ] , void * recvbuf , const MPI_Count recvcounts [ ] , const MPI_Aint rdispls [ ] , const MPI_Datatype recvtypes [ ] , MPI_Comm comm )
const QMPI_Neighbor_alltoallw_c_t = Cvoid

# typedef int ( QMPI_Neighbor_alltoallw_init_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const int sendcounts [ ] , const MPI_Aint sdispls [ ] , const MPI_Datatype sendtypes [ ] , void * recvbuf , const int recvcounts [ ] , const MPI_Aint rdispls [ ] , const MPI_Datatype recvtypes [ ] , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Neighbor_alltoallw_init_t = Cvoid

# typedef int ( QMPI_Neighbor_alltoallw_init_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const MPI_Count sendcounts [ ] , const MPI_Aint sdispls [ ] , const MPI_Datatype sendtypes [ ] , void * recvbuf , const MPI_Count recvcounts [ ] , const MPI_Aint rdispls [ ] , const MPI_Datatype recvtypes [ ] , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Neighbor_alltoallw_init_c_t = Cvoid

# typedef int ( QMPI_Reduce_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , int count , MPI_Datatype datatype , MPI_Op op , int root , MPI_Comm comm )
const QMPI_Reduce_t = Cvoid

# typedef int ( QMPI_Reduce_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , MPI_Count count , MPI_Datatype datatype , MPI_Op op , int root , MPI_Comm comm )
const QMPI_Reduce_c_t = Cvoid

# typedef int ( QMPI_Reduce_init_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , int count , MPI_Datatype datatype , MPI_Op op , int root , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Reduce_init_t = Cvoid

# typedef int ( QMPI_Reduce_init_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , MPI_Count count , MPI_Datatype datatype , MPI_Op op , int root , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Reduce_init_c_t = Cvoid

# typedef int ( QMPI_Reduce_local_t ) ( QMPI_Context context , int tool_id , const void * inbuf , void * inoutbuf , int count , MPI_Datatype datatype , MPI_Op op )
const QMPI_Reduce_local_t = Cvoid

# typedef int ( QMPI_Reduce_local_c_t ) ( QMPI_Context context , int tool_id , const void * inbuf , void * inoutbuf , MPI_Count count , MPI_Datatype datatype , MPI_Op op )
const QMPI_Reduce_local_c_t = Cvoid

# typedef int ( QMPI_Reduce_scatter_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , const int recvcounts [ ] , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm )
const QMPI_Reduce_scatter_t = Cvoid

# typedef int ( QMPI_Reduce_scatter_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , const MPI_Count recvcounts [ ] , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm )
const QMPI_Reduce_scatter_c_t = Cvoid

# typedef int ( QMPI_Reduce_scatter_block_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , int recvcount , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm )
const QMPI_Reduce_scatter_block_t = Cvoid

# typedef int ( QMPI_Reduce_scatter_block_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , MPI_Count recvcount , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm )
const QMPI_Reduce_scatter_block_c_t = Cvoid

# typedef int ( QMPI_Reduce_scatter_block_init_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , int recvcount , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Reduce_scatter_block_init_t = Cvoid

# typedef int ( QMPI_Reduce_scatter_block_init_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , MPI_Count recvcount , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Reduce_scatter_block_init_c_t = Cvoid

# typedef int ( QMPI_Reduce_scatter_init_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , const int recvcounts [ ] , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Reduce_scatter_init_t = Cvoid

# typedef int ( QMPI_Reduce_scatter_init_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , const MPI_Count recvcounts [ ] , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Reduce_scatter_init_c_t = Cvoid

# typedef int ( QMPI_Scan_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , int count , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm )
const QMPI_Scan_t = Cvoid

# typedef int ( QMPI_Scan_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , MPI_Count count , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm )
const QMPI_Scan_c_t = Cvoid

# typedef int ( QMPI_Scan_init_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , int count , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Scan_init_t = Cvoid

# typedef int ( QMPI_Scan_init_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , void * recvbuf , MPI_Count count , MPI_Datatype datatype , MPI_Op op , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Scan_init_c_t = Cvoid

# typedef int ( QMPI_Scatter_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , void * recvbuf , int recvcount , MPI_Datatype recvtype , int root , MPI_Comm comm )
const QMPI_Scatter_t = Cvoid

# typedef int ( QMPI_Scatter_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , void * recvbuf , MPI_Count recvcount , MPI_Datatype recvtype , int root , MPI_Comm comm )
const QMPI_Scatter_c_t = Cvoid

# typedef int ( QMPI_Scatter_init_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , void * recvbuf , int recvcount , MPI_Datatype recvtype , int root , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Scatter_init_t = Cvoid

# typedef int ( QMPI_Scatter_init_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , void * recvbuf , MPI_Count recvcount , MPI_Datatype recvtype , int root , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Scatter_init_c_t = Cvoid

# typedef int ( QMPI_Scatterv_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const int sendcounts [ ] , const int displs [ ] , MPI_Datatype sendtype , void * recvbuf , int recvcount , MPI_Datatype recvtype , int root , MPI_Comm comm )
const QMPI_Scatterv_t = Cvoid

# typedef int ( QMPI_Scatterv_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const MPI_Count sendcounts [ ] , const MPI_Aint displs [ ] , MPI_Datatype sendtype , void * recvbuf , MPI_Count recvcount , MPI_Datatype recvtype , int root , MPI_Comm comm )
const QMPI_Scatterv_c_t = Cvoid

# typedef int ( QMPI_Scatterv_init_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const int sendcounts [ ] , const int displs [ ] , MPI_Datatype sendtype , void * recvbuf , int recvcount , MPI_Datatype recvtype , int root , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Scatterv_init_t = Cvoid

# typedef int ( QMPI_Scatterv_init_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , const MPI_Count sendcounts [ ] , const MPI_Aint displs [ ] , MPI_Datatype sendtype , void * recvbuf , MPI_Count recvcount , MPI_Datatype recvtype , int root , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Scatterv_init_c_t = Cvoid

# typedef int ( QMPI_Comm_compare_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm1 , MPI_Comm comm2 , int * result )
const QMPI_Comm_compare_t = Cvoid

# typedef int ( QMPI_Comm_create_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , MPI_Group group , MPI_Comm * newcomm )
const QMPI_Comm_create_t = Cvoid

# typedef int ( QMPI_Comm_create_group_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , MPI_Group group , int tag , MPI_Comm * newcomm )
const QMPI_Comm_create_group_t = Cvoid

# typedef int ( QMPI_Comm_dup_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , MPI_Comm * newcomm )
const QMPI_Comm_dup_t = Cvoid

# typedef int ( QMPI_Comm_dup_with_info_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , MPI_Info info , MPI_Comm * newcomm )
const QMPI_Comm_dup_with_info_t = Cvoid

# typedef int ( QMPI_Comm_free_t ) ( QMPI_Context context , int tool_id , MPI_Comm * comm )
const QMPI_Comm_free_t = Cvoid

# typedef int ( QMPI_Comm_get_info_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , MPI_Info * info_used )
const QMPI_Comm_get_info_t = Cvoid

# typedef int ( QMPI_Comm_get_name_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , char * comm_name , int * resultlen )
const QMPI_Comm_get_name_t = Cvoid

# typedef int ( QMPI_Comm_group_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , MPI_Group * group )
const QMPI_Comm_group_t = Cvoid

# typedef int ( QMPI_Comm_idup_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , MPI_Comm * newcomm , MPI_Request * request )
const QMPI_Comm_idup_t = Cvoid

# typedef int ( QMPI_Comm_idup_with_info_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , MPI_Info info , MPI_Comm * newcomm , MPI_Request * request )
const QMPI_Comm_idup_with_info_t = Cvoid

# typedef int ( QMPI_Comm_rank_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , int * rank )
const QMPI_Comm_rank_t = Cvoid

# typedef int ( QMPI_Comm_remote_group_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , MPI_Group * group )
const QMPI_Comm_remote_group_t = Cvoid

# typedef int ( QMPI_Comm_remote_size_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , int * size )
const QMPI_Comm_remote_size_t = Cvoid

# typedef int ( QMPI_Comm_set_info_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , MPI_Info info )
const QMPI_Comm_set_info_t = Cvoid

# typedef int ( QMPI_Comm_set_name_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , const char * comm_name )
const QMPI_Comm_set_name_t = Cvoid

# typedef int ( QMPI_Comm_size_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , int * size )
const QMPI_Comm_size_t = Cvoid

# typedef int ( QMPI_Comm_split_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , int color , int key , MPI_Comm * newcomm )
const QMPI_Comm_split_t = Cvoid

# typedef int ( QMPI_Comm_split_type_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , int split_type , int key , MPI_Info info , MPI_Comm * newcomm )
const QMPI_Comm_split_type_t = Cvoid

# typedef int ( QMPI_Comm_test_inter_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , int * flag )
const QMPI_Comm_test_inter_t = Cvoid

# typedef int ( QMPI_Intercomm_create_t ) ( QMPI_Context context , int tool_id , MPI_Comm local_comm , int local_leader , MPI_Comm peer_comm , int remote_leader , int tag , MPI_Comm * newintercomm )
const QMPI_Intercomm_create_t = Cvoid

# typedef int ( QMPI_Intercomm_create_from_groups_t ) ( QMPI_Context context , int tool_id , MPI_Group local_group , int local_leader , MPI_Group remote_group , int remote_leader , const char * stringtag , MPI_Info info , MPI_Errhandler errhandler , MPI_Comm * newintercomm )
const QMPI_Intercomm_create_from_groups_t = Cvoid

# typedef int ( QMPI_Intercomm_merge_t ) ( QMPI_Context context , int tool_id , MPI_Comm intercomm , int high , MPI_Comm * newintracomm )
const QMPI_Intercomm_merge_t = Cvoid

# typedef int ( QMPIX_Comm_revoke_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm )
const QMPIX_Comm_revoke_t = Cvoid

# typedef int ( QMPIX_Comm_shrink_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , MPI_Comm * newcomm )
const QMPIX_Comm_shrink_t = Cvoid

# typedef int ( QMPIX_Comm_failure_ack_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm )
const QMPIX_Comm_failure_ack_t = Cvoid

# typedef int ( QMPIX_Comm_failure_get_acked_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , MPI_Group * failedgrp )
const QMPIX_Comm_failure_get_acked_t = Cvoid

# typedef int ( QMPIX_Comm_agree_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , int * flag )
const QMPIX_Comm_agree_t = Cvoid

# typedef int ( QMPI_Get_address_t ) ( QMPI_Context context , int tool_id , const void * location , MPI_Aint * address )
const QMPI_Get_address_t = Cvoid

# typedef int ( QMPI_Get_count_t ) ( QMPI_Context context , int tool_id , const MPI_Status * status , MPI_Datatype datatype , int * count )
const QMPI_Get_count_t = Cvoid

# typedef int ( QMPI_Get_count_c_t ) ( QMPI_Context context , int tool_id , const MPI_Status * status , MPI_Datatype datatype , MPI_Count * count )
const QMPI_Get_count_c_t = Cvoid

# typedef int ( QMPI_Get_elements_t ) ( QMPI_Context context , int tool_id , const MPI_Status * status , MPI_Datatype datatype , int * count )
const QMPI_Get_elements_t = Cvoid

# typedef int ( QMPI_Get_elements_c_t ) ( QMPI_Context context , int tool_id , const MPI_Status * status , MPI_Datatype datatype , MPI_Count * count )
const QMPI_Get_elements_c_t = Cvoid

# typedef int ( QMPI_Get_elements_x_t ) ( QMPI_Context context , int tool_id , const MPI_Status * status , MPI_Datatype datatype , MPI_Count * count )
const QMPI_Get_elements_x_t = Cvoid

# typedef int ( QMPI_Pack_t ) ( QMPI_Context context , int tool_id , const void * inbuf , int incount , MPI_Datatype datatype , void * outbuf , int outsize , int * position , MPI_Comm comm )
const QMPI_Pack_t = Cvoid

# typedef int ( QMPI_Pack_c_t ) ( QMPI_Context context , int tool_id , const void * inbuf , MPI_Count incount , MPI_Datatype datatype , void * outbuf , MPI_Count outsize , MPI_Count * position , MPI_Comm comm )
const QMPI_Pack_c_t = Cvoid

# typedef int ( QMPI_Pack_external_t ) ( QMPI_Context context , int tool_id , const char * datarep , const void * inbuf , int incount , MPI_Datatype datatype , void * outbuf , MPI_Aint outsize , MPI_Aint * position )
const QMPI_Pack_external_t = Cvoid

# typedef int ( QMPI_Pack_external_c_t ) ( QMPI_Context context , int tool_id , const char * datarep , const void * inbuf , MPI_Count incount , MPI_Datatype datatype , void * outbuf , MPI_Count outsize , MPI_Count * position )
const QMPI_Pack_external_c_t = Cvoid

# typedef int ( QMPI_Pack_external_size_t ) ( QMPI_Context context , int tool_id , const char * datarep , int incount , MPI_Datatype datatype , MPI_Aint * size )
const QMPI_Pack_external_size_t = Cvoid

# typedef int ( QMPI_Pack_external_size_c_t ) ( QMPI_Context context , int tool_id , const char * datarep , MPI_Count incount , MPI_Datatype datatype , MPI_Count * size )
const QMPI_Pack_external_size_c_t = Cvoid

# typedef int ( QMPI_Pack_size_t ) ( QMPI_Context context , int tool_id , int incount , MPI_Datatype datatype , MPI_Comm comm , int * size )
const QMPI_Pack_size_t = Cvoid

# typedef int ( QMPI_Pack_size_c_t ) ( QMPI_Context context , int tool_id , MPI_Count incount , MPI_Datatype datatype , MPI_Comm comm , MPI_Count * size )
const QMPI_Pack_size_c_t = Cvoid

# typedef int ( QMPI_Status_set_elements_t ) ( QMPI_Context context , int tool_id , MPI_Status * status , MPI_Datatype datatype , int count )
const QMPI_Status_set_elements_t = Cvoid

# typedef int ( QMPI_Status_set_elements_x_t ) ( QMPI_Context context , int tool_id , MPI_Status * status , MPI_Datatype datatype , MPI_Count count )
const QMPI_Status_set_elements_x_t = Cvoid

# typedef int ( QMPI_Type_commit_t ) ( QMPI_Context context , int tool_id , MPI_Datatype * datatype )
const QMPI_Type_commit_t = Cvoid

# typedef int ( QMPI_Type_contiguous_t ) ( QMPI_Context context , int tool_id , int count , MPI_Datatype oldtype , MPI_Datatype * newtype )
const QMPI_Type_contiguous_t = Cvoid

# typedef int ( QMPI_Type_contiguous_c_t ) ( QMPI_Context context , int tool_id , MPI_Count count , MPI_Datatype oldtype , MPI_Datatype * newtype )
const QMPI_Type_contiguous_c_t = Cvoid

# typedef int ( QMPI_Type_create_darray_t ) ( QMPI_Context context , int tool_id , int size , int rank , int ndims , const int array_of_gsizes [ ] , const int array_of_distribs [ ] , const int array_of_dargs [ ] , const int array_of_psizes [ ] , int order , MPI_Datatype oldtype , MPI_Datatype * newtype )
const QMPI_Type_create_darray_t = Cvoid

# typedef int ( QMPI_Type_create_darray_c_t ) ( QMPI_Context context , int tool_id , int size , int rank , int ndims , const MPI_Count array_of_gsizes [ ] , const int array_of_distribs [ ] , const int array_of_dargs [ ] , const int array_of_psizes [ ] , int order , MPI_Datatype oldtype , MPI_Datatype * newtype )
const QMPI_Type_create_darray_c_t = Cvoid

# typedef int ( QMPI_Type_create_hindexed_t ) ( QMPI_Context context , int tool_id , int count , const int array_of_blocklengths [ ] , const MPI_Aint array_of_displacements [ ] , MPI_Datatype oldtype , MPI_Datatype * newtype )
const QMPI_Type_create_hindexed_t = Cvoid

# typedef int ( QMPI_Type_create_hindexed_c_t ) ( QMPI_Context context , int tool_id , MPI_Count count , const MPI_Count array_of_blocklengths [ ] , const MPI_Count array_of_displacements [ ] , MPI_Datatype oldtype , MPI_Datatype * newtype )
const QMPI_Type_create_hindexed_c_t = Cvoid

# typedef int ( QMPI_Type_create_hindexed_block_t ) ( QMPI_Context context , int tool_id , int count , int blocklength , const MPI_Aint array_of_displacements [ ] , MPI_Datatype oldtype , MPI_Datatype * newtype )
const QMPI_Type_create_hindexed_block_t = Cvoid

# typedef int ( QMPI_Type_create_hindexed_block_c_t ) ( QMPI_Context context , int tool_id , MPI_Count count , MPI_Count blocklength , const MPI_Count array_of_displacements [ ] , MPI_Datatype oldtype , MPI_Datatype * newtype )
const QMPI_Type_create_hindexed_block_c_t = Cvoid

# typedef int ( QMPI_Type_create_hvector_t ) ( QMPI_Context context , int tool_id , int count , int blocklength , MPI_Aint stride , MPI_Datatype oldtype , MPI_Datatype * newtype )
const QMPI_Type_create_hvector_t = Cvoid

# typedef int ( QMPI_Type_create_hvector_c_t ) ( QMPI_Context context , int tool_id , MPI_Count count , MPI_Count blocklength , MPI_Count stride , MPI_Datatype oldtype , MPI_Datatype * newtype )
const QMPI_Type_create_hvector_c_t = Cvoid

# typedef int ( QMPI_Type_create_indexed_block_t ) ( QMPI_Context context , int tool_id , int count , int blocklength , const int array_of_displacements [ ] , MPI_Datatype oldtype , MPI_Datatype * newtype )
const QMPI_Type_create_indexed_block_t = Cvoid

# typedef int ( QMPI_Type_create_indexed_block_c_t ) ( QMPI_Context context , int tool_id , MPI_Count count , MPI_Count blocklength , const MPI_Count array_of_displacements [ ] , MPI_Datatype oldtype , MPI_Datatype * newtype )
const QMPI_Type_create_indexed_block_c_t = Cvoid

# typedef int ( QMPI_Type_create_resized_t ) ( QMPI_Context context , int tool_id , MPI_Datatype oldtype , MPI_Aint lb , MPI_Aint extent , MPI_Datatype * newtype )
const QMPI_Type_create_resized_t = Cvoid

# typedef int ( QMPI_Type_create_resized_c_t ) ( QMPI_Context context , int tool_id , MPI_Datatype oldtype , MPI_Count lb , MPI_Count extent , MPI_Datatype * newtype )
const QMPI_Type_create_resized_c_t = Cvoid

# typedef int ( QMPI_Type_create_struct_t ) ( QMPI_Context context , int tool_id , int count , const int array_of_blocklengths [ ] , const MPI_Aint array_of_displacements [ ] , const MPI_Datatype array_of_types [ ] , MPI_Datatype * newtype )
const QMPI_Type_create_struct_t = Cvoid

# typedef int ( QMPI_Type_create_struct_c_t ) ( QMPI_Context context , int tool_id , MPI_Count count , const MPI_Count array_of_blocklengths [ ] , const MPI_Count array_of_displacements [ ] , const MPI_Datatype array_of_types [ ] , MPI_Datatype * newtype )
const QMPI_Type_create_struct_c_t = Cvoid

# typedef int ( QMPI_Type_create_subarray_t ) ( QMPI_Context context , int tool_id , int ndims , const int array_of_sizes [ ] , const int array_of_subsizes [ ] , const int array_of_starts [ ] , int order , MPI_Datatype oldtype , MPI_Datatype * newtype )
const QMPI_Type_create_subarray_t = Cvoid

# typedef int ( QMPI_Type_create_subarray_c_t ) ( QMPI_Context context , int tool_id , int ndims , const MPI_Count array_of_sizes [ ] , const MPI_Count array_of_subsizes [ ] , const MPI_Count array_of_starts [ ] , int order , MPI_Datatype oldtype , MPI_Datatype * newtype )
const QMPI_Type_create_subarray_c_t = Cvoid

# typedef int ( QMPI_Type_dup_t ) ( QMPI_Context context , int tool_id , MPI_Datatype oldtype , MPI_Datatype * newtype )
const QMPI_Type_dup_t = Cvoid

# typedef int ( QMPI_Type_free_t ) ( QMPI_Context context , int tool_id , MPI_Datatype * datatype )
const QMPI_Type_free_t = Cvoid

# typedef int ( QMPI_Type_get_contents_t ) ( QMPI_Context context , int tool_id , MPI_Datatype datatype , int max_integers , int max_addresses , int max_datatypes , int array_of_integers [ ] , MPI_Aint array_of_addresses [ ] , MPI_Datatype array_of_datatypes [ ] )
const QMPI_Type_get_contents_t = Cvoid

# typedef int ( QMPI_Type_get_contents_c_t ) ( QMPI_Context context , int tool_id , MPI_Datatype datatype , MPI_Count max_integers , MPI_Count max_addresses , MPI_Count max_large_counts , MPI_Count max_datatypes , int array_of_integers [ ] , MPI_Aint array_of_addresses [ ] , MPI_Count array_of_large_counts [ ] , MPI_Datatype array_of_datatypes [ ] )
const QMPI_Type_get_contents_c_t = Cvoid

# typedef int ( QMPI_Type_get_envelope_t ) ( QMPI_Context context , int tool_id , MPI_Datatype datatype , int * num_integers , int * num_addresses , int * num_datatypes , int * combiner )
const QMPI_Type_get_envelope_t = Cvoid

# typedef int ( QMPI_Type_get_envelope_c_t ) ( QMPI_Context context , int tool_id , MPI_Datatype datatype , MPI_Count * num_integers , MPI_Count * num_addresses , MPI_Count * num_large_counts , MPI_Count * num_datatypes , int * combiner )
const QMPI_Type_get_envelope_c_t = Cvoid

# typedef int ( QMPI_Type_get_extent_t ) ( QMPI_Context context , int tool_id , MPI_Datatype datatype , MPI_Aint * lb , MPI_Aint * extent )
const QMPI_Type_get_extent_t = Cvoid

# typedef int ( QMPI_Type_get_extent_c_t ) ( QMPI_Context context , int tool_id , MPI_Datatype datatype , MPI_Count * lb , MPI_Count * extent )
const QMPI_Type_get_extent_c_t = Cvoid

# typedef int ( QMPI_Type_get_extent_x_t ) ( QMPI_Context context , int tool_id , MPI_Datatype datatype , MPI_Count * lb , MPI_Count * extent )
const QMPI_Type_get_extent_x_t = Cvoid

# typedef int ( QMPI_Type_get_name_t ) ( QMPI_Context context , int tool_id , MPI_Datatype datatype , char * type_name , int * resultlen )
const QMPI_Type_get_name_t = Cvoid

# typedef int ( QMPI_Type_get_true_extent_t ) ( QMPI_Context context , int tool_id , MPI_Datatype datatype , MPI_Aint * true_lb , MPI_Aint * true_extent )
const QMPI_Type_get_true_extent_t = Cvoid

# typedef int ( QMPI_Type_get_true_extent_c_t ) ( QMPI_Context context , int tool_id , MPI_Datatype datatype , MPI_Count * true_lb , MPI_Count * true_extent )
const QMPI_Type_get_true_extent_c_t = Cvoid

# typedef int ( QMPI_Type_get_true_extent_x_t ) ( QMPI_Context context , int tool_id , MPI_Datatype datatype , MPI_Count * true_lb , MPI_Count * true_extent )
const QMPI_Type_get_true_extent_x_t = Cvoid

# typedef int ( QMPI_Type_indexed_t ) ( QMPI_Context context , int tool_id , int count , const int array_of_blocklengths [ ] , const int array_of_displacements [ ] , MPI_Datatype oldtype , MPI_Datatype * newtype )
const QMPI_Type_indexed_t = Cvoid

# typedef int ( QMPI_Type_indexed_c_t ) ( QMPI_Context context , int tool_id , MPI_Count count , const MPI_Count array_of_blocklengths [ ] , const MPI_Count array_of_displacements [ ] , MPI_Datatype oldtype , MPI_Datatype * newtype )
const QMPI_Type_indexed_c_t = Cvoid

# typedef int ( QMPI_Type_match_size_t ) ( QMPI_Context context , int tool_id , int typeclass , int size , MPI_Datatype * datatype )
const QMPI_Type_match_size_t = Cvoid

# typedef int ( QMPI_Type_set_name_t ) ( QMPI_Context context , int tool_id , MPI_Datatype datatype , const char * type_name )
const QMPI_Type_set_name_t = Cvoid

# typedef int ( QMPI_Type_size_t ) ( QMPI_Context context , int tool_id , MPI_Datatype datatype , int * size )
const QMPI_Type_size_t = Cvoid

# typedef int ( QMPI_Type_size_c_t ) ( QMPI_Context context , int tool_id , MPI_Datatype datatype , MPI_Count * size )
const QMPI_Type_size_c_t = Cvoid

# typedef int ( QMPI_Type_size_x_t ) ( QMPI_Context context , int tool_id , MPI_Datatype datatype , MPI_Count * size )
const QMPI_Type_size_x_t = Cvoid

# typedef int ( QMPI_Type_vector_t ) ( QMPI_Context context , int tool_id , int count , int blocklength , int stride , MPI_Datatype oldtype , MPI_Datatype * newtype )
const QMPI_Type_vector_t = Cvoid

# typedef int ( QMPI_Type_vector_c_t ) ( QMPI_Context context , int tool_id , MPI_Count count , MPI_Count blocklength , MPI_Count stride , MPI_Datatype oldtype , MPI_Datatype * newtype )
const QMPI_Type_vector_c_t = Cvoid

# typedef int ( QMPI_Unpack_t ) ( QMPI_Context context , int tool_id , const void * inbuf , int insize , int * position , void * outbuf , int outcount , MPI_Datatype datatype , MPI_Comm comm )
const QMPI_Unpack_t = Cvoid

# typedef int ( QMPI_Unpack_c_t ) ( QMPI_Context context , int tool_id , const void * inbuf , MPI_Count insize , MPI_Count * position , void * outbuf , MPI_Count outcount , MPI_Datatype datatype , MPI_Comm comm )
const QMPI_Unpack_c_t = Cvoid

# typedef int ( QMPI_Unpack_external_t ) ( QMPI_Context context , int tool_id , const char datarep [ ] , const void * inbuf , MPI_Aint insize , MPI_Aint * position , void * outbuf , int outcount , MPI_Datatype datatype )
const QMPI_Unpack_external_t = Cvoid

# typedef int ( QMPI_Unpack_external_c_t ) ( QMPI_Context context , int tool_id , const char datarep [ ] , const void * inbuf , MPI_Count insize , MPI_Count * position , void * outbuf , MPI_Count outcount , MPI_Datatype datatype )
const QMPI_Unpack_external_c_t = Cvoid

# typedef int ( QMPI_Address_t ) ( QMPI_Context context , int tool_id , void * location , MPI_Aint * address )
const QMPI_Address_t = Cvoid

# typedef int ( QMPI_Type_extent_t ) ( QMPI_Context context , int tool_id , MPI_Datatype datatype , MPI_Aint * extent )
const QMPI_Type_extent_t = Cvoid

# typedef int ( QMPI_Type_lb_t ) ( QMPI_Context context , int tool_id , MPI_Datatype datatype , MPI_Aint * displacement )
const QMPI_Type_lb_t = Cvoid

# typedef int ( QMPI_Type_ub_t ) ( QMPI_Context context , int tool_id , MPI_Datatype datatype , MPI_Aint * displacement )
const QMPI_Type_ub_t = Cvoid

# typedef int ( QMPI_Type_hindexed_t ) ( QMPI_Context context , int tool_id , int count , int array_of_blocklengths [ ] , MPI_Aint array_of_displacements [ ] , MPI_Datatype oldtype , MPI_Datatype * newtype )
const QMPI_Type_hindexed_t = Cvoid

# typedef int ( QMPI_Type_hvector_t ) ( QMPI_Context context , int tool_id , int count , int blocklength , MPI_Aint stride , MPI_Datatype oldtype , MPI_Datatype * newtype )
const QMPI_Type_hvector_t = Cvoid

# typedef int ( QMPI_Type_struct_t ) ( QMPI_Context context , int tool_id , int count , int array_of_blocklengths [ ] , MPI_Aint array_of_displacements [ ] , MPI_Datatype array_of_types [ ] , MPI_Datatype * newtype )
const QMPI_Type_struct_t = Cvoid

# typedef int ( QMPI_Add_error_class_t ) ( QMPI_Context context , int tool_id , int * errorclass )
const QMPI_Add_error_class_t = Cvoid

# typedef int ( QMPI_Add_error_code_t ) ( QMPI_Context context , int tool_id , int errorclass , int * errorcode )
const QMPI_Add_error_code_t = Cvoid

# typedef int ( QMPI_Add_error_string_t ) ( QMPI_Context context , int tool_id , int errorcode , const char * string )
const QMPI_Add_error_string_t = Cvoid

# typedef int ( QMPI_Comm_call_errhandler_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , int errorcode )
const QMPI_Comm_call_errhandler_t = Cvoid

# typedef int ( QMPI_Comm_create_errhandler_t ) ( QMPI_Context context , int tool_id , MPI_Comm_errhandler_function * comm_errhandler_fn , MPI_Errhandler * errhandler )
const QMPI_Comm_create_errhandler_t = Cvoid

# typedef int ( QMPI_Comm_get_errhandler_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , MPI_Errhandler * errhandler )
const QMPI_Comm_get_errhandler_t = Cvoid

# typedef int ( QMPI_Comm_set_errhandler_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , MPI_Errhandler errhandler )
const QMPI_Comm_set_errhandler_t = Cvoid

# typedef int ( QMPI_Errhandler_free_t ) ( QMPI_Context context , int tool_id , MPI_Errhandler * errhandler )
const QMPI_Errhandler_free_t = Cvoid

# typedef int ( QMPI_Error_class_t ) ( QMPI_Context context , int tool_id , int errorcode , int * errorclass )
const QMPI_Error_class_t = Cvoid

# typedef int ( QMPI_Error_string_t ) ( QMPI_Context context , int tool_id , int errorcode , char * string , int * resultlen )
const QMPI_Error_string_t = Cvoid

# typedef int ( QMPI_File_call_errhandler_t ) ( QMPI_Context context , int tool_id , MPI_File fh , int errorcode )
const QMPI_File_call_errhandler_t = Cvoid

# typedef int ( QMPI_File_create_errhandler_t ) ( QMPI_Context context , int tool_id , MPI_File_errhandler_function * file_errhandler_fn , MPI_Errhandler * errhandler )
const QMPI_File_create_errhandler_t = Cvoid

# typedef int ( QMPI_File_get_errhandler_t ) ( QMPI_Context context , int tool_id , MPI_File file , MPI_Errhandler * errhandler )
const QMPI_File_get_errhandler_t = Cvoid

# typedef int ( QMPI_File_set_errhandler_t ) ( QMPI_Context context , int tool_id , MPI_File file , MPI_Errhandler errhandler )
const QMPI_File_set_errhandler_t = Cvoid

# typedef int ( QMPI_Session_call_errhandler_t ) ( QMPI_Context context , int tool_id , MPI_Session session , int errorcode )
const QMPI_Session_call_errhandler_t = Cvoid

# typedef int ( QMPI_Session_create_errhandler_t ) ( QMPI_Context context , int tool_id , MPI_Session_errhandler_function * session_errhandler_fn , MPI_Errhandler * errhandler )
const QMPI_Session_create_errhandler_t = Cvoid

# typedef int ( QMPI_Session_get_errhandler_t ) ( QMPI_Context context , int tool_id , MPI_Session session , MPI_Errhandler * errhandler )
const QMPI_Session_get_errhandler_t = Cvoid

# typedef int ( QMPI_Session_set_errhandler_t ) ( QMPI_Context context , int tool_id , MPI_Session session , MPI_Errhandler errhandler )
const QMPI_Session_set_errhandler_t = Cvoid

# typedef int ( QMPI_Win_call_errhandler_t ) ( QMPI_Context context , int tool_id , MPI_Win win , int errorcode )
const QMPI_Win_call_errhandler_t = Cvoid

# typedef int ( QMPI_Win_create_errhandler_t ) ( QMPI_Context context , int tool_id , MPI_Win_errhandler_function * win_errhandler_fn , MPI_Errhandler * errhandler )
const QMPI_Win_create_errhandler_t = Cvoid

# typedef int ( QMPI_Win_get_errhandler_t ) ( QMPI_Context context , int tool_id , MPI_Win win , MPI_Errhandler * errhandler )
const QMPI_Win_get_errhandler_t = Cvoid

# typedef int ( QMPI_Win_set_errhandler_t ) ( QMPI_Context context , int tool_id , MPI_Win win , MPI_Errhandler errhandler )
const QMPI_Win_set_errhandler_t = Cvoid

# typedef int ( QMPIX_Delete_error_class_t ) ( QMPI_Context context , int tool_id , int errorclass )
const QMPIX_Delete_error_class_t = Cvoid

# typedef int ( QMPIX_Delete_error_code_t ) ( QMPI_Context context , int tool_id , int errorcode )
const QMPIX_Delete_error_code_t = Cvoid

# typedef int ( QMPIX_Delete_error_string_t ) ( QMPI_Context context , int tool_id , int errorcode )
const QMPIX_Delete_error_string_t = Cvoid

# typedef int ( QMPI_Errhandler_create_t ) ( QMPI_Context context , int tool_id , MPI_Comm_errhandler_function * comm_errhandler_fn , MPI_Errhandler * errhandler )
const QMPI_Errhandler_create_t = Cvoid

# typedef int ( QMPI_Errhandler_get_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , MPI_Errhandler * errhandler )
const QMPI_Errhandler_get_t = Cvoid

# typedef int ( QMPI_Errhandler_set_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , MPI_Errhandler errhandler )
const QMPI_Errhandler_set_t = Cvoid

# typedef int ( QMPI_Group_compare_t ) ( QMPI_Context context , int tool_id , MPI_Group group1 , MPI_Group group2 , int * result )
const QMPI_Group_compare_t = Cvoid

# typedef int ( QMPI_Group_difference_t ) ( QMPI_Context context , int tool_id , MPI_Group group1 , MPI_Group group2 , MPI_Group * newgroup )
const QMPI_Group_difference_t = Cvoid

# typedef int ( QMPI_Group_excl_t ) ( QMPI_Context context , int tool_id , MPI_Group group , int n , const int ranks [ ] , MPI_Group * newgroup )
const QMPI_Group_excl_t = Cvoid

# typedef int ( QMPI_Group_free_t ) ( QMPI_Context context , int tool_id , MPI_Group * group )
const QMPI_Group_free_t = Cvoid

# typedef int ( QMPI_Group_incl_t ) ( QMPI_Context context , int tool_id , MPI_Group group , int n , const int ranks [ ] , MPI_Group * newgroup )
const QMPI_Group_incl_t = Cvoid

# typedef int ( QMPI_Group_intersection_t ) ( QMPI_Context context , int tool_id , MPI_Group group1 , MPI_Group group2 , MPI_Group * newgroup )
const QMPI_Group_intersection_t = Cvoid

# typedef int ( QMPI_Group_range_excl_t ) ( QMPI_Context context , int tool_id , MPI_Group group , int n , int ranges [ ] [ 3 ] , MPI_Group * newgroup )
const QMPI_Group_range_excl_t = Cvoid

# typedef int ( QMPI_Group_range_incl_t ) ( QMPI_Context context , int tool_id , MPI_Group group , int n , int ranges [ ] [ 3 ] , MPI_Group * newgroup )
const QMPI_Group_range_incl_t = Cvoid

# typedef int ( QMPI_Group_rank_t ) ( QMPI_Context context , int tool_id , MPI_Group group , int * rank )
const QMPI_Group_rank_t = Cvoid

# typedef int ( QMPI_Group_size_t ) ( QMPI_Context context , int tool_id , MPI_Group group , int * size )
const QMPI_Group_size_t = Cvoid

# typedef int ( QMPI_Group_translate_ranks_t ) ( QMPI_Context context , int tool_id , MPI_Group group1 , int n , const int ranks1 [ ] , MPI_Group group2 , int ranks2 [ ] )
const QMPI_Group_translate_ranks_t = Cvoid

# typedef int ( QMPI_Group_union_t ) ( QMPI_Context context , int tool_id , MPI_Group group1 , MPI_Group group2 , MPI_Group * newgroup )
const QMPI_Group_union_t = Cvoid

# typedef int ( QMPI_Info_create_t ) ( QMPI_Context context , int tool_id , MPI_Info * info )
const QMPI_Info_create_t = Cvoid

# typedef int ( QMPI_Info_create_env_t ) ( QMPI_Context context , int tool_id , int argc , char * argv [ ] , MPI_Info * info )
const QMPI_Info_create_env_t = Cvoid

# typedef int ( QMPI_Info_delete_t ) ( QMPI_Context context , int tool_id , MPI_Info info , const char * key )
const QMPI_Info_delete_t = Cvoid

# typedef int ( QMPI_Info_dup_t ) ( QMPI_Context context , int tool_id , MPI_Info info , MPI_Info * newinfo )
const QMPI_Info_dup_t = Cvoid

# typedef int ( QMPI_Info_free_t ) ( QMPI_Context context , int tool_id , MPI_Info * info )
const QMPI_Info_free_t = Cvoid

# typedef int ( QMPI_Info_get_t ) ( QMPI_Context context , int tool_id , MPI_Info info , const char * key , int valuelen , char * value , int * flag )
const QMPI_Info_get_t = Cvoid

# typedef int ( QMPI_Info_get_nkeys_t ) ( QMPI_Context context , int tool_id , MPI_Info info , int * nkeys )
const QMPI_Info_get_nkeys_t = Cvoid

# typedef int ( QMPI_Info_get_nthkey_t ) ( QMPI_Context context , int tool_id , MPI_Info info , int n , char * key )
const QMPI_Info_get_nthkey_t = Cvoid

# typedef int ( QMPI_Info_get_string_t ) ( QMPI_Context context , int tool_id , MPI_Info info , const char * key , int * buflen , char * value , int * flag )
const QMPI_Info_get_string_t = Cvoid

# typedef int ( QMPI_Info_get_valuelen_t ) ( QMPI_Context context , int tool_id , MPI_Info info , const char * key , int * valuelen , int * flag )
const QMPI_Info_get_valuelen_t = Cvoid

# typedef int ( QMPI_Info_set_t ) ( QMPI_Context context , int tool_id , MPI_Info info , const char * key , const char * value )
const QMPI_Info_set_t = Cvoid

# typedef int ( QMPI_Abort_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , int errorcode )
const QMPI_Abort_t = Cvoid

# typedef int ( QMPI_Comm_create_from_group_t ) ( QMPI_Context context , int tool_id , MPI_Group group , const char * stringtag , MPI_Info info , MPI_Errhandler errhandler , MPI_Comm * newcomm )
const QMPI_Comm_create_from_group_t = Cvoid

# typedef int ( QMPI_Finalize_t ) ( QMPI_Context context , int tool_id )
const QMPI_Finalize_t = Cvoid

# typedef int ( QMPI_Finalized_t ) ( QMPI_Context context , int tool_id , int * flag )
const QMPI_Finalized_t = Cvoid

# typedef int ( QMPI_Group_from_session_pset_t ) ( QMPI_Context context , int tool_id , MPI_Session session , const char * pset_name , MPI_Group * newgroup )
const QMPI_Group_from_session_pset_t = Cvoid

# typedef int ( QMPI_Init_t ) ( QMPI_Context context , int tool_id , int * argc , char * * * argv )
const QMPI_Init_t = Cvoid

# typedef int ( QMPI_Init_thread_t ) ( QMPI_Context context , int tool_id , int * argc , char * * * argv , int required , int * provided )
const QMPI_Init_thread_t = Cvoid

# typedef int ( QMPI_Initialized_t ) ( QMPI_Context context , int tool_id , int * flag )
const QMPI_Initialized_t = Cvoid

# typedef int ( QMPI_Is_thread_main_t ) ( QMPI_Context context , int tool_id , int * flag )
const QMPI_Is_thread_main_t = Cvoid

# typedef int ( QMPI_Query_thread_t ) ( QMPI_Context context , int tool_id , int * provided )
const QMPI_Query_thread_t = Cvoid

# typedef int ( QMPI_Session_finalize_t ) ( QMPI_Context context , int tool_id , MPI_Session * session )
const QMPI_Session_finalize_t = Cvoid

# typedef int ( QMPI_Session_get_info_t ) ( QMPI_Context context , int tool_id , MPI_Session session , MPI_Info * info_used )
const QMPI_Session_get_info_t = Cvoid

# typedef int ( QMPI_Session_get_nth_pset_t ) ( QMPI_Context context , int tool_id , MPI_Session session , MPI_Info info , int n , int * pset_len , char * pset_name )
const QMPI_Session_get_nth_pset_t = Cvoid

# typedef int ( QMPI_Session_get_num_psets_t ) ( QMPI_Context context , int tool_id , MPI_Session session , MPI_Info info , int * npset_names )
const QMPI_Session_get_num_psets_t = Cvoid

# typedef int ( QMPI_Session_get_pset_info_t ) ( QMPI_Context context , int tool_id , MPI_Session session , const char * pset_name , MPI_Info * info )
const QMPI_Session_get_pset_info_t = Cvoid

# typedef int ( QMPI_Session_init_t ) ( QMPI_Context context , int tool_id , MPI_Info info , MPI_Errhandler errhandler , MPI_Session * session )
const QMPI_Session_init_t = Cvoid

# typedef MPI_Aint ( QMPI_Aint_add_t ) ( QMPI_Context context , int tool_id , MPI_Aint base , MPI_Aint disp )
const QMPI_Aint_add_t = Cvoid

# typedef MPI_Aint ( QMPI_Aint_diff_t ) ( QMPI_Context context , int tool_id , MPI_Aint addr1 , MPI_Aint addr2 )
const QMPI_Aint_diff_t = Cvoid

# typedef int ( QMPI_Get_library_version_t ) ( QMPI_Context context , int tool_id , char * version , int * resultlen )
const QMPI_Get_library_version_t = Cvoid

# typedef int ( QMPI_Get_processor_name_t ) ( QMPI_Context context , int tool_id , char * name , int * resultlen )
const QMPI_Get_processor_name_t = Cvoid

# typedef int ( QMPI_Get_version_t ) ( QMPI_Context context , int tool_id , int * version , int * subversion )
const QMPI_Get_version_t = Cvoid

# typedef int ( QMPI_Pcontrol_t ) ( QMPI_Context context , int tool_id , const int level , ... )
const QMPI_Pcontrol_t = Cvoid

# typedef int ( QMPIX_GPU_query_support_t ) ( QMPI_Context context , int tool_id , int gpu_type , int * is_supported )
const QMPIX_GPU_query_support_t = Cvoid

# typedef int ( QMPIX_Query_cuda_support_t ) ( QMPI_Context context , int tool_id )
const QMPIX_Query_cuda_support_t = Cvoid

# typedef int ( QMPIX_Query_ze_support_t ) ( QMPI_Context context , int tool_id )
const QMPIX_Query_ze_support_t = Cvoid

# typedef int ( QMPIX_Query_hip_support_t ) ( QMPI_Context context , int tool_id )
const QMPIX_Query_hip_support_t = Cvoid

# typedef int ( QMPI_T_category_changed_t ) ( QMPI_Context context , int tool_id , int * update_number )
const QMPI_T_category_changed_t = Cvoid

# typedef int ( QMPI_T_category_get_categories_t ) ( QMPI_Context context , int tool_id , int cat_index , int len , int indices [ ] )
const QMPI_T_category_get_categories_t = Cvoid

# typedef int ( QMPI_T_category_get_cvars_t ) ( QMPI_Context context , int tool_id , int cat_index , int len , int indices [ ] )
const QMPI_T_category_get_cvars_t = Cvoid

# typedef int ( QMPI_T_category_get_events_t ) ( QMPI_Context context , int tool_id , int cat_index , int len , int indices [ ] )
const QMPI_T_category_get_events_t = Cvoid

# typedef int ( QMPI_T_category_get_index_t ) ( QMPI_Context context , int tool_id , const char * name , int * cat_index )
const QMPI_T_category_get_index_t = Cvoid

# typedef int ( QMPI_T_category_get_info_t ) ( QMPI_Context context , int tool_id , int cat_index , char * name , int * name_len , char * desc , int * desc_len , int * num_cvars , int * num_pvars , int * num_categories )
const QMPI_T_category_get_info_t = Cvoid

# typedef int ( QMPI_T_category_get_num_t ) ( QMPI_Context context , int tool_id , int * num_cat )
const QMPI_T_category_get_num_t = Cvoid

# typedef int ( QMPI_T_category_get_num_events_t ) ( QMPI_Context context , int tool_id , int cat_index , int * num_events )
const QMPI_T_category_get_num_events_t = Cvoid

# typedef int ( QMPI_T_category_get_pvars_t ) ( QMPI_Context context , int tool_id , int cat_index , int len , int indices [ ] )
const QMPI_T_category_get_pvars_t = Cvoid

# typedef int ( QMPI_T_cvar_get_index_t ) ( QMPI_Context context , int tool_id , const char * name , int * cvar_index )
const QMPI_T_cvar_get_index_t = Cvoid

# typedef int ( QMPI_T_cvar_get_info_t ) ( QMPI_Context context , int tool_id , int cvar_index , char * name , int * name_len , int * verbosity , MPI_Datatype * datatype , MPI_T_enum * enumtype , char * desc , int * desc_len , int * bind , int * scope )
const QMPI_T_cvar_get_info_t = Cvoid

# typedef int ( QMPI_T_cvar_get_num_t ) ( QMPI_Context context , int tool_id , int * num_cvar )
const QMPI_T_cvar_get_num_t = Cvoid

# typedef int ( QMPI_T_cvar_handle_alloc_t ) ( QMPI_Context context , int tool_id , int cvar_index , void * obj_handle , MPI_T_cvar_handle * handle , int * count )
const QMPI_T_cvar_handle_alloc_t = Cvoid

# typedef int ( QMPI_T_cvar_handle_free_t ) ( QMPI_Context context , int tool_id , MPI_T_cvar_handle * handle )
const QMPI_T_cvar_handle_free_t = Cvoid

# typedef int ( QMPI_T_cvar_read_t ) ( QMPI_Context context , int tool_id , MPI_T_cvar_handle handle , void * buf )
const QMPI_T_cvar_read_t = Cvoid

# typedef int ( QMPI_T_cvar_write_t ) ( QMPI_Context context , int tool_id , MPI_T_cvar_handle handle , const void * buf )
const QMPI_T_cvar_write_t = Cvoid

# typedef int ( QMPI_T_enum_get_info_t ) ( QMPI_Context context , int tool_id , MPI_T_enum enumtype , int * num , char * name , int * name_len )
const QMPI_T_enum_get_info_t = Cvoid

# typedef int ( QMPI_T_enum_get_item_t ) ( QMPI_Context context , int tool_id , MPI_T_enum enumtype , int indx , int * value , char * name , int * name_len )
const QMPI_T_enum_get_item_t = Cvoid

# typedef int ( QMPI_T_event_callback_get_info_t ) ( QMPI_Context context , int tool_id , MPI_T_event_registration event_registration , MPI_T_cb_safety cb_safety , MPI_Info * info_used )
const QMPI_T_event_callback_get_info_t = Cvoid

# typedef int ( QMPI_T_event_callback_set_info_t ) ( QMPI_Context context , int tool_id , MPI_T_event_registration event_registration , MPI_T_cb_safety cb_safety , MPI_Info info )
const QMPI_T_event_callback_set_info_t = Cvoid

# typedef int ( QMPI_T_event_copy_t ) ( QMPI_Context context , int tool_id , MPI_T_event_instance event_instance , void * buffer )
const QMPI_T_event_copy_t = Cvoid

# typedef int ( QMPI_T_event_get_index_t ) ( QMPI_Context context , int tool_id , const char * name , int * event_index )
const QMPI_T_event_get_index_t = Cvoid

# typedef int ( QMPI_T_event_get_info_t ) ( QMPI_Context context , int tool_id , int event_index , char * name , int * name_len , int * verbosity , MPI_Datatype array_of_datatypes [ ] , MPI_Aint array_of_displacements [ ] , int * num_elements , MPI_T_enum * enumtype , MPI_Info * info , char * desc , int * desc_len , int * bind )
const QMPI_T_event_get_info_t = Cvoid

# typedef int ( QMPI_T_event_get_num_t ) ( QMPI_Context context , int tool_id , int * num_events )
const QMPI_T_event_get_num_t = Cvoid

# typedef int ( QMPI_T_event_get_source_t ) ( QMPI_Context context , int tool_id , MPI_T_event_instance event_instance , int * source_index )
const QMPI_T_event_get_source_t = Cvoid

# typedef int ( QMPI_T_event_get_timestamp_t ) ( QMPI_Context context , int tool_id , MPI_T_event_instance event_instance , MPI_Count * event_timestamp )
const QMPI_T_event_get_timestamp_t = Cvoid

# typedef int ( QMPI_T_event_handle_alloc_t ) ( QMPI_Context context , int tool_id , int event_index , void * obj_handle , MPI_Info info , MPI_T_event_registration * event_registration )
const QMPI_T_event_handle_alloc_t = Cvoid

# typedef int ( QMPI_T_event_handle_free_t ) ( QMPI_Context context , int tool_id , MPI_T_event_registration event_registration , void * user_data , MPI_T_event_free_cb_function free_cb_function )
const QMPI_T_event_handle_free_t = Cvoid

# typedef int ( QMPI_T_event_handle_get_info_t ) ( QMPI_Context context , int tool_id , MPI_T_event_registration event_registration , MPI_Info * info_used )
const QMPI_T_event_handle_get_info_t = Cvoid

# typedef int ( QMPI_T_event_handle_set_info_t ) ( QMPI_Context context , int tool_id , MPI_T_event_registration event_registration , MPI_Info info )
const QMPI_T_event_handle_set_info_t = Cvoid

# typedef int ( QMPI_T_event_read_t ) ( QMPI_Context context , int tool_id , MPI_T_event_instance event_instance , int element_index , void * buffer )
const QMPI_T_event_read_t = Cvoid

# typedef int ( QMPI_T_event_register_callback_t ) ( QMPI_Context context , int tool_id , MPI_T_event_registration event_registration , MPI_T_cb_safety cb_safety , MPI_Info info , void * user_data , MPI_T_event_cb_function event_cb_function )
const QMPI_T_event_register_callback_t = Cvoid

# typedef int ( QMPI_T_event_set_dropped_handler_t ) ( QMPI_Context context , int tool_id , MPI_T_event_registration event_registration , MPI_T_event_dropped_cb_function dropped_cb_function )
const QMPI_T_event_set_dropped_handler_t = Cvoid

# typedef int ( QMPI_T_finalize_t ) ( QMPI_Context context , int tool_id )
const QMPI_T_finalize_t = Cvoid

# typedef int ( QMPI_T_init_thread_t ) ( QMPI_Context context , int tool_id , int required , int * provided )
const QMPI_T_init_thread_t = Cvoid

# typedef int ( QMPI_T_pvar_get_index_t ) ( QMPI_Context context , int tool_id , const char * name , int var_class , int * pvar_index )
const QMPI_T_pvar_get_index_t = Cvoid

# typedef int ( QMPI_T_pvar_get_info_t ) ( QMPI_Context context , int tool_id , int pvar_index , char * name , int * name_len , int * verbosity , int * var_class , MPI_Datatype * datatype , MPI_T_enum * enumtype , char * desc , int * desc_len , int * bind , int * readonly , int * continuous , int * atomic )
const QMPI_T_pvar_get_info_t = Cvoid

# typedef int ( QMPI_T_pvar_get_num_t ) ( QMPI_Context context , int tool_id , int * num_pvar )
const QMPI_T_pvar_get_num_t = Cvoid

# typedef int ( QMPI_T_pvar_handle_alloc_t ) ( QMPI_Context context , int tool_id , MPI_T_pvar_session session , int pvar_index , void * obj_handle , MPI_T_pvar_handle * handle , int * count )
const QMPI_T_pvar_handle_alloc_t = Cvoid

# typedef int ( QMPI_T_pvar_handle_free_t ) ( QMPI_Context context , int tool_id , MPI_T_pvar_session session , MPI_T_pvar_handle * handle )
const QMPI_T_pvar_handle_free_t = Cvoid

# typedef int ( QMPI_T_pvar_read_t ) ( QMPI_Context context , int tool_id , MPI_T_pvar_session session , MPI_T_pvar_handle handle , void * buf )
const QMPI_T_pvar_read_t = Cvoid

# typedef int ( QMPI_T_pvar_readreset_t ) ( QMPI_Context context , int tool_id , MPI_T_pvar_session session , MPI_T_pvar_handle handle , void * buf )
const QMPI_T_pvar_readreset_t = Cvoid

# typedef int ( QMPI_T_pvar_reset_t ) ( QMPI_Context context , int tool_id , MPI_T_pvar_session session , MPI_T_pvar_handle handle )
const QMPI_T_pvar_reset_t = Cvoid

# typedef int ( QMPI_T_pvar_session_create_t ) ( QMPI_Context context , int tool_id , MPI_T_pvar_session * session )
const QMPI_T_pvar_session_create_t = Cvoid

# typedef int ( QMPI_T_pvar_session_free_t ) ( QMPI_Context context , int tool_id , MPI_T_pvar_session * session )
const QMPI_T_pvar_session_free_t = Cvoid

# typedef int ( QMPI_T_pvar_start_t ) ( QMPI_Context context , int tool_id , MPI_T_pvar_session session , MPI_T_pvar_handle handle )
const QMPI_T_pvar_start_t = Cvoid

# typedef int ( QMPI_T_pvar_stop_t ) ( QMPI_Context context , int tool_id , MPI_T_pvar_session session , MPI_T_pvar_handle handle )
const QMPI_T_pvar_stop_t = Cvoid

# typedef int ( QMPI_T_pvar_write_t ) ( QMPI_Context context , int tool_id , MPI_T_pvar_session session , MPI_T_pvar_handle handle , const void * buf )
const QMPI_T_pvar_write_t = Cvoid

# typedef int ( QMPI_T_source_get_info_t ) ( QMPI_Context context , int tool_id , int source_index , char * name , int * name_len , char * desc , int * desc_len , MPI_T_source_order * ordering , MPI_Count * ticks_per_second , MPI_Count * max_ticks , MPI_Info * info )
const QMPI_T_source_get_info_t = Cvoid

# typedef int ( QMPI_T_source_get_num_t ) ( QMPI_Context context , int tool_id , int * num_sources )
const QMPI_T_source_get_num_t = Cvoid

# typedef int ( QMPI_T_source_get_timestamp_t ) ( QMPI_Context context , int tool_id , int source_index , MPI_Count * timestamp )
const QMPI_T_source_get_timestamp_t = Cvoid

# typedef int ( QMPI_Op_commutative_t ) ( QMPI_Context context , int tool_id , MPI_Op op , int * commute )
const QMPI_Op_commutative_t = Cvoid

# typedef int ( QMPI_Op_create_t ) ( QMPI_Context context , int tool_id , MPI_User_function * user_fn , int commute , MPI_Op * op )
const QMPI_Op_create_t = Cvoid

# typedef int ( QMPI_Op_create_c_t ) ( QMPI_Context context , int tool_id , MPI_User_function_c * user_fn , int commute , MPI_Op * op )
const QMPI_Op_create_c_t = Cvoid

# typedef int ( QMPI_Op_free_t ) ( QMPI_Context context , int tool_id , MPI_Op * op )
const QMPI_Op_free_t = Cvoid

# typedef int ( QMPI_Parrived_t ) ( QMPI_Context context , int tool_id , MPI_Request request , int partition , int * flag )
const QMPI_Parrived_t = Cvoid

# typedef int ( QMPI_Pready_t ) ( QMPI_Context context , int tool_id , int partition , MPI_Request request )
const QMPI_Pready_t = Cvoid

# typedef int ( QMPI_Pready_list_t ) ( QMPI_Context context , int tool_id , int length , int array_of_partitions [ ] , MPI_Request request )
const QMPI_Pready_list_t = Cvoid

# typedef int ( QMPI_Pready_range_t ) ( QMPI_Context context , int tool_id , int partition_low , int partition_high , MPI_Request request )
const QMPI_Pready_range_t = Cvoid

# typedef int ( QMPI_Precv_init_t ) ( QMPI_Context context , int tool_id , void * buf , int partitions , MPI_Count count , MPI_Datatype datatype , int dest , int tag , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Precv_init_t = Cvoid

# typedef int ( QMPI_Psend_init_t ) ( QMPI_Context context , int tool_id , const void * buf , int partitions , MPI_Count count , MPI_Datatype datatype , int dest , int tag , MPI_Comm comm , MPI_Info info , MPI_Request * request )
const QMPI_Psend_init_t = Cvoid

# typedef int ( QMPI_Bsend_t ) ( QMPI_Context context , int tool_id , const void * buf , int count , MPI_Datatype datatype , int dest , int tag , MPI_Comm comm )
const QMPI_Bsend_t = Cvoid

# typedef int ( QMPI_Bsend_c_t ) ( QMPI_Context context , int tool_id , const void * buf , MPI_Count count , MPI_Datatype datatype , int dest , int tag , MPI_Comm comm )
const QMPI_Bsend_c_t = Cvoid

# typedef int ( QMPI_Bsend_init_t ) ( QMPI_Context context , int tool_id , const void * buf , int count , MPI_Datatype datatype , int dest , int tag , MPI_Comm comm , MPI_Request * request )
const QMPI_Bsend_init_t = Cvoid

# typedef int ( QMPI_Bsend_init_c_t ) ( QMPI_Context context , int tool_id , const void * buf , MPI_Count count , MPI_Datatype datatype , int dest , int tag , MPI_Comm comm , MPI_Request * request )
const QMPI_Bsend_init_c_t = Cvoid

# typedef int ( QMPI_Buffer_attach_t ) ( QMPI_Context context , int tool_id , void * buffer , int size )
const QMPI_Buffer_attach_t = Cvoid

# typedef int ( QMPI_Buffer_attach_c_t ) ( QMPI_Context context , int tool_id , void * buffer , MPI_Count size )
const QMPI_Buffer_attach_c_t = Cvoid

# typedef int ( QMPI_Buffer_detach_t ) ( QMPI_Context context , int tool_id , void * buffer_addr , int * size )
const QMPI_Buffer_detach_t = Cvoid

# typedef int ( QMPI_Buffer_detach_c_t ) ( QMPI_Context context , int tool_id , void * buffer_addr , MPI_Count * size )
const QMPI_Buffer_detach_c_t = Cvoid

# typedef int ( QMPI_Ibsend_t ) ( QMPI_Context context , int tool_id , const void * buf , int count , MPI_Datatype datatype , int dest , int tag , MPI_Comm comm , MPI_Request * request )
const QMPI_Ibsend_t = Cvoid

# typedef int ( QMPI_Ibsend_c_t ) ( QMPI_Context context , int tool_id , const void * buf , MPI_Count count , MPI_Datatype datatype , int dest , int tag , MPI_Comm comm , MPI_Request * request )
const QMPI_Ibsend_c_t = Cvoid

# typedef int ( QMPI_Improbe_t ) ( QMPI_Context context , int tool_id , int source , int tag , MPI_Comm comm , int * flag , MPI_Message * message , MPI_Status * status )
const QMPI_Improbe_t = Cvoid

# typedef int ( QMPI_Imrecv_t ) ( QMPI_Context context , int tool_id , void * buf , int count , MPI_Datatype datatype , MPI_Message * message , MPI_Request * request )
const QMPI_Imrecv_t = Cvoid

# typedef int ( QMPI_Imrecv_c_t ) ( QMPI_Context context , int tool_id , void * buf , MPI_Count count , MPI_Datatype datatype , MPI_Message * message , MPI_Request * request )
const QMPI_Imrecv_c_t = Cvoid

# typedef int ( QMPI_Iprobe_t ) ( QMPI_Context context , int tool_id , int source , int tag , MPI_Comm comm , int * flag , MPI_Status * status )
const QMPI_Iprobe_t = Cvoid

# typedef int ( QMPI_Irecv_t ) ( QMPI_Context context , int tool_id , void * buf , int count , MPI_Datatype datatype , int source , int tag , MPI_Comm comm , MPI_Request * request )
const QMPI_Irecv_t = Cvoid

# typedef int ( QMPI_Irecv_c_t ) ( QMPI_Context context , int tool_id , void * buf , MPI_Count count , MPI_Datatype datatype , int source , int tag , MPI_Comm comm , MPI_Request * request )
const QMPI_Irecv_c_t = Cvoid

# typedef int ( QMPI_Irsend_t ) ( QMPI_Context context , int tool_id , const void * buf , int count , MPI_Datatype datatype , int dest , int tag , MPI_Comm comm , MPI_Request * request )
const QMPI_Irsend_t = Cvoid

# typedef int ( QMPI_Irsend_c_t ) ( QMPI_Context context , int tool_id , const void * buf , MPI_Count count , MPI_Datatype datatype , int dest , int tag , MPI_Comm comm , MPI_Request * request )
const QMPI_Irsend_c_t = Cvoid

# typedef int ( QMPI_Isend_t ) ( QMPI_Context context , int tool_id , const void * buf , int count , MPI_Datatype datatype , int dest , int tag , MPI_Comm comm , MPI_Request * request )
const QMPI_Isend_t = Cvoid

# typedef int ( QMPI_Isend_c_t ) ( QMPI_Context context , int tool_id , const void * buf , MPI_Count count , MPI_Datatype datatype , int dest , int tag , MPI_Comm comm , MPI_Request * request )
const QMPI_Isend_c_t = Cvoid

# typedef int ( QMPI_Isendrecv_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , int dest , int sendtag , void * recvbuf , int recvcount , MPI_Datatype recvtype , int source , int recvtag , MPI_Comm comm , MPI_Request * request )
const QMPI_Isendrecv_t = Cvoid

# typedef int ( QMPI_Isendrecv_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , int dest , int sendtag , void * recvbuf , MPI_Count recvcount , MPI_Datatype recvtype , int source , int recvtag , MPI_Comm comm , MPI_Request * request )
const QMPI_Isendrecv_c_t = Cvoid

# typedef int ( QMPI_Isendrecv_replace_t ) ( QMPI_Context context , int tool_id , void * buf , int count , MPI_Datatype datatype , int dest , int sendtag , int source , int recvtag , MPI_Comm comm , MPI_Request * request )
const QMPI_Isendrecv_replace_t = Cvoid

# typedef int ( QMPI_Isendrecv_replace_c_t ) ( QMPI_Context context , int tool_id , void * buf , MPI_Count count , MPI_Datatype datatype , int dest , int sendtag , int source , int recvtag , MPI_Comm comm , MPI_Request * request )
const QMPI_Isendrecv_replace_c_t = Cvoid

# typedef int ( QMPI_Issend_t ) ( QMPI_Context context , int tool_id , const void * buf , int count , MPI_Datatype datatype , int dest , int tag , MPI_Comm comm , MPI_Request * request )
const QMPI_Issend_t = Cvoid

# typedef int ( QMPI_Issend_c_t ) ( QMPI_Context context , int tool_id , const void * buf , MPI_Count count , MPI_Datatype datatype , int dest , int tag , MPI_Comm comm , MPI_Request * request )
const QMPI_Issend_c_t = Cvoid

# typedef int ( QMPI_Mprobe_t ) ( QMPI_Context context , int tool_id , int source , int tag , MPI_Comm comm , MPI_Message * message , MPI_Status * status )
const QMPI_Mprobe_t = Cvoid

# typedef int ( QMPI_Mrecv_t ) ( QMPI_Context context , int tool_id , void * buf , int count , MPI_Datatype datatype , MPI_Message * message , MPI_Status * status )
const QMPI_Mrecv_t = Cvoid

# typedef int ( QMPI_Mrecv_c_t ) ( QMPI_Context context , int tool_id , void * buf , MPI_Count count , MPI_Datatype datatype , MPI_Message * message , MPI_Status * status )
const QMPI_Mrecv_c_t = Cvoid

# typedef int ( QMPI_Probe_t ) ( QMPI_Context context , int tool_id , int source , int tag , MPI_Comm comm , MPI_Status * status )
const QMPI_Probe_t = Cvoid

# typedef int ( QMPI_Recv_t ) ( QMPI_Context context , int tool_id , void * buf , int count , MPI_Datatype datatype , int source , int tag , MPI_Comm comm , MPI_Status * status )
const QMPI_Recv_t = Cvoid

# typedef int ( QMPI_Recv_c_t ) ( QMPI_Context context , int tool_id , void * buf , MPI_Count count , MPI_Datatype datatype , int source , int tag , MPI_Comm comm , MPI_Status * status )
const QMPI_Recv_c_t = Cvoid

# typedef int ( QMPI_Recv_init_t ) ( QMPI_Context context , int tool_id , void * buf , int count , MPI_Datatype datatype , int source , int tag , MPI_Comm comm , MPI_Request * request )
const QMPI_Recv_init_t = Cvoid

# typedef int ( QMPI_Recv_init_c_t ) ( QMPI_Context context , int tool_id , void * buf , MPI_Count count , MPI_Datatype datatype , int source , int tag , MPI_Comm comm , MPI_Request * request )
const QMPI_Recv_init_c_t = Cvoid

# typedef int ( QMPI_Rsend_t ) ( QMPI_Context context , int tool_id , const void * buf , int count , MPI_Datatype datatype , int dest , int tag , MPI_Comm comm )
const QMPI_Rsend_t = Cvoid

# typedef int ( QMPI_Rsend_c_t ) ( QMPI_Context context , int tool_id , const void * buf , MPI_Count count , MPI_Datatype datatype , int dest , int tag , MPI_Comm comm )
const QMPI_Rsend_c_t = Cvoid

# typedef int ( QMPI_Rsend_init_t ) ( QMPI_Context context , int tool_id , const void * buf , int count , MPI_Datatype datatype , int dest , int tag , MPI_Comm comm , MPI_Request * request )
const QMPI_Rsend_init_t = Cvoid

# typedef int ( QMPI_Rsend_init_c_t ) ( QMPI_Context context , int tool_id , const void * buf , MPI_Count count , MPI_Datatype datatype , int dest , int tag , MPI_Comm comm , MPI_Request * request )
const QMPI_Rsend_init_c_t = Cvoid

# typedef int ( QMPI_Send_t ) ( QMPI_Context context , int tool_id , const void * buf , int count , MPI_Datatype datatype , int dest , int tag , MPI_Comm comm )
const QMPI_Send_t = Cvoid

# typedef int ( QMPI_Send_c_t ) ( QMPI_Context context , int tool_id , const void * buf , MPI_Count count , MPI_Datatype datatype , int dest , int tag , MPI_Comm comm )
const QMPI_Send_c_t = Cvoid

# typedef int ( QMPI_Send_init_t ) ( QMPI_Context context , int tool_id , const void * buf , int count , MPI_Datatype datatype , int dest , int tag , MPI_Comm comm , MPI_Request * request )
const QMPI_Send_init_t = Cvoid

# typedef int ( QMPI_Send_init_c_t ) ( QMPI_Context context , int tool_id , const void * buf , MPI_Count count , MPI_Datatype datatype , int dest , int tag , MPI_Comm comm , MPI_Request * request )
const QMPI_Send_init_c_t = Cvoid

# typedef int ( QMPI_Sendrecv_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , int sendcount , MPI_Datatype sendtype , int dest , int sendtag , void * recvbuf , int recvcount , MPI_Datatype recvtype , int source , int recvtag , MPI_Comm comm , MPI_Status * status )
const QMPI_Sendrecv_t = Cvoid

# typedef int ( QMPI_Sendrecv_c_t ) ( QMPI_Context context , int tool_id , const void * sendbuf , MPI_Count sendcount , MPI_Datatype sendtype , int dest , int sendtag , void * recvbuf , MPI_Count recvcount , MPI_Datatype recvtype , int source , int recvtag , MPI_Comm comm , MPI_Status * status )
const QMPI_Sendrecv_c_t = Cvoid

# typedef int ( QMPI_Sendrecv_replace_t ) ( QMPI_Context context , int tool_id , void * buf , int count , MPI_Datatype datatype , int dest , int sendtag , int source , int recvtag , MPI_Comm comm , MPI_Status * status )
const QMPI_Sendrecv_replace_t = Cvoid

# typedef int ( QMPI_Sendrecv_replace_c_t ) ( QMPI_Context context , int tool_id , void * buf , MPI_Count count , MPI_Datatype datatype , int dest , int sendtag , int source , int recvtag , MPI_Comm comm , MPI_Status * status )
const QMPI_Sendrecv_replace_c_t = Cvoid

# typedef int ( QMPI_Ssend_t ) ( QMPI_Context context , int tool_id , const void * buf , int count , MPI_Datatype datatype , int dest , int tag , MPI_Comm comm )
const QMPI_Ssend_t = Cvoid

# typedef int ( QMPI_Ssend_c_t ) ( QMPI_Context context , int tool_id , const void * buf , MPI_Count count , MPI_Datatype datatype , int dest , int tag , MPI_Comm comm )
const QMPI_Ssend_c_t = Cvoid

# typedef int ( QMPI_Ssend_init_t ) ( QMPI_Context context , int tool_id , const void * buf , int count , MPI_Datatype datatype , int dest , int tag , MPI_Comm comm , MPI_Request * request )
const QMPI_Ssend_init_t = Cvoid

# typedef int ( QMPI_Ssend_init_c_t ) ( QMPI_Context context , int tool_id , const void * buf , MPI_Count count , MPI_Datatype datatype , int dest , int tag , MPI_Comm comm , MPI_Request * request )
const QMPI_Ssend_init_c_t = Cvoid

# typedef int ( QMPI_Cancel_t ) ( QMPI_Context context , int tool_id , MPI_Request * request )
const QMPI_Cancel_t = Cvoid

# typedef int ( QMPI_Grequest_complete_t ) ( QMPI_Context context , int tool_id , MPI_Request request )
const QMPI_Grequest_complete_t = Cvoid

# typedef int ( QMPI_Grequest_start_t ) ( QMPI_Context context , int tool_id , MPI_Grequest_query_function * query_fn , MPI_Grequest_free_function * free_fn , MPI_Grequest_cancel_function * cancel_fn , void * extra_state , MPI_Request * request )
const QMPI_Grequest_start_t = Cvoid

# typedef int ( QMPI_Request_free_t ) ( QMPI_Context context , int tool_id , MPI_Request * request )
const QMPI_Request_free_t = Cvoid

# typedef int ( QMPI_Request_get_status_t ) ( QMPI_Context context , int tool_id , MPI_Request request , int * flag , MPI_Status * status )
const QMPI_Request_get_status_t = Cvoid

# typedef int ( QMPI_Start_t ) ( QMPI_Context context , int tool_id , MPI_Request * request )
const QMPI_Start_t = Cvoid

# typedef int ( QMPI_Startall_t ) ( QMPI_Context context , int tool_id , int count , MPI_Request array_of_requests [ ] )
const QMPI_Startall_t = Cvoid

# typedef int ( QMPI_Status_set_cancelled_t ) ( QMPI_Context context , int tool_id , MPI_Status * status , int flag )
const QMPI_Status_set_cancelled_t = Cvoid

# typedef int ( QMPI_Test_t ) ( QMPI_Context context , int tool_id , MPI_Request * request , int * flag , MPI_Status * status )
const QMPI_Test_t = Cvoid

# typedef int ( QMPI_Test_cancelled_t ) ( QMPI_Context context , int tool_id , const MPI_Status * status , int * flag )
const QMPI_Test_cancelled_t = Cvoid

# typedef int ( QMPI_Testall_t ) ( QMPI_Context context , int tool_id , int count , MPI_Request array_of_requests [ ] , int * flag , MPI_Status array_of_statuses [ ] )
const QMPI_Testall_t = Cvoid

# typedef int ( QMPI_Testany_t ) ( QMPI_Context context , int tool_id , int count , MPI_Request array_of_requests [ ] , int * indx , int * flag , MPI_Status * status )
const QMPI_Testany_t = Cvoid

# typedef int ( QMPI_Testsome_t ) ( QMPI_Context context , int tool_id , int incount , MPI_Request array_of_requests [ ] , int * outcount , int array_of_indices [ ] , MPI_Status array_of_statuses [ ] )
const QMPI_Testsome_t = Cvoid

# typedef int ( QMPI_Wait_t ) ( QMPI_Context context , int tool_id , MPI_Request * request , MPI_Status * status )
const QMPI_Wait_t = Cvoid

# typedef int ( QMPI_Waitall_t ) ( QMPI_Context context , int tool_id , int count , MPI_Request array_of_requests [ ] , MPI_Status array_of_statuses [ ] )
const QMPI_Waitall_t = Cvoid

# typedef int ( QMPI_Waitany_t ) ( QMPI_Context context , int tool_id , int count , MPI_Request array_of_requests [ ] , int * indx , MPI_Status * status )
const QMPI_Waitany_t = Cvoid

# typedef int ( QMPI_Waitsome_t ) ( QMPI_Context context , int tool_id , int incount , MPI_Request array_of_requests [ ] , int * outcount , int array_of_indices [ ] , MPI_Status array_of_statuses [ ] )
const QMPI_Waitsome_t = Cvoid

# typedef int ( QMPIX_Grequest_start_t ) ( QMPI_Context context , int tool_id , MPI_Grequest_query_function * query_fn , MPI_Grequest_free_function * free_fn , MPI_Grequest_cancel_function * cancel_fn , MPIX_Grequest_poll_function * poll_fn , MPIX_Grequest_wait_function * wait_fn , void * extra_state , MPI_Request * request )
const QMPIX_Grequest_start_t = Cvoid

# typedef int ( QMPIX_Grequest_class_create_t ) ( QMPI_Context context , int tool_id , MPI_Grequest_query_function * query_fn , MPI_Grequest_free_function * free_fn , MPI_Grequest_cancel_function * cancel_fn , MPIX_Grequest_poll_function * poll_fn , MPIX_Grequest_wait_function * wait_fn , MPIX_Grequest_class * greq_class )
const QMPIX_Grequest_class_create_t = Cvoid

# typedef int ( QMPIX_Grequest_class_allocate_t ) ( QMPI_Context context , int tool_id , MPIX_Grequest_class greq_class , void * extra_state , MPI_Request * request )
const QMPIX_Grequest_class_allocate_t = Cvoid

# typedef int ( QMPI_Accumulate_t ) ( QMPI_Context context , int tool_id , const void * origin_addr , int origin_count , MPI_Datatype origin_datatype , int target_rank , MPI_Aint target_disp , int target_count , MPI_Datatype target_datatype , MPI_Op op , MPI_Win win )
const QMPI_Accumulate_t = Cvoid

# typedef int ( QMPI_Accumulate_c_t ) ( QMPI_Context context , int tool_id , const void * origin_addr , MPI_Count origin_count , MPI_Datatype origin_datatype , int target_rank , MPI_Aint target_disp , MPI_Count target_count , MPI_Datatype target_datatype , MPI_Op op , MPI_Win win )
const QMPI_Accumulate_c_t = Cvoid

# typedef int ( QMPI_Alloc_mem_t ) ( QMPI_Context context , int tool_id , MPI_Aint size , MPI_Info info , void * baseptr )
const QMPI_Alloc_mem_t = Cvoid

# typedef int ( QMPI_Compare_and_swap_t ) ( QMPI_Context context , int tool_id , const void * origin_addr , const void * compare_addr , void * result_addr , MPI_Datatype datatype , int target_rank , MPI_Aint target_disp , MPI_Win win )
const QMPI_Compare_and_swap_t = Cvoid

# typedef int ( QMPI_Fetch_and_op_t ) ( QMPI_Context context , int tool_id , const void * origin_addr , void * result_addr , MPI_Datatype datatype , int target_rank , MPI_Aint target_disp , MPI_Op op , MPI_Win win )
const QMPI_Fetch_and_op_t = Cvoid

# typedef int ( QMPI_Free_mem_t ) ( QMPI_Context context , int tool_id , void * base )
const QMPI_Free_mem_t = Cvoid

# typedef int ( QMPI_Get_t ) ( QMPI_Context context , int tool_id , void * origin_addr , int origin_count , MPI_Datatype origin_datatype , int target_rank , MPI_Aint target_disp , int target_count , MPI_Datatype target_datatype , MPI_Win win )
const QMPI_Get_t = Cvoid

# typedef int ( QMPI_Get_c_t ) ( QMPI_Context context , int tool_id , void * origin_addr , MPI_Count origin_count , MPI_Datatype origin_datatype , int target_rank , MPI_Aint target_disp , MPI_Count target_count , MPI_Datatype target_datatype , MPI_Win win )
const QMPI_Get_c_t = Cvoid

# typedef int ( QMPI_Get_accumulate_t ) ( QMPI_Context context , int tool_id , const void * origin_addr , int origin_count , MPI_Datatype origin_datatype , void * result_addr , int result_count , MPI_Datatype result_datatype , int target_rank , MPI_Aint target_disp , int target_count , MPI_Datatype target_datatype , MPI_Op op , MPI_Win win )
const QMPI_Get_accumulate_t = Cvoid

# typedef int ( QMPI_Get_accumulate_c_t ) ( QMPI_Context context , int tool_id , const void * origin_addr , MPI_Count origin_count , MPI_Datatype origin_datatype , void * result_addr , MPI_Count result_count , MPI_Datatype result_datatype , int target_rank , MPI_Aint target_disp , MPI_Count target_count , MPI_Datatype target_datatype , MPI_Op op , MPI_Win win )
const QMPI_Get_accumulate_c_t = Cvoid

# typedef int ( QMPI_Put_t ) ( QMPI_Context context , int tool_id , const void * origin_addr , int origin_count , MPI_Datatype origin_datatype , int target_rank , MPI_Aint target_disp , int target_count , MPI_Datatype target_datatype , MPI_Win win )
const QMPI_Put_t = Cvoid

# typedef int ( QMPI_Put_c_t ) ( QMPI_Context context , int tool_id , const void * origin_addr , MPI_Count origin_count , MPI_Datatype origin_datatype , int target_rank , MPI_Aint target_disp , MPI_Count target_count , MPI_Datatype target_datatype , MPI_Win win )
const QMPI_Put_c_t = Cvoid

# typedef int ( QMPI_Raccumulate_t ) ( QMPI_Context context , int tool_id , const void * origin_addr , int origin_count , MPI_Datatype origin_datatype , int target_rank , MPI_Aint target_disp , int target_count , MPI_Datatype target_datatype , MPI_Op op , MPI_Win win , MPI_Request * request )
const QMPI_Raccumulate_t = Cvoid

# typedef int ( QMPI_Raccumulate_c_t ) ( QMPI_Context context , int tool_id , const void * origin_addr , MPI_Count origin_count , MPI_Datatype origin_datatype , int target_rank , MPI_Aint target_disp , MPI_Count target_count , MPI_Datatype target_datatype , MPI_Op op , MPI_Win win , MPI_Request * request )
const QMPI_Raccumulate_c_t = Cvoid

# typedef int ( QMPI_Rget_t ) ( QMPI_Context context , int tool_id , void * origin_addr , int origin_count , MPI_Datatype origin_datatype , int target_rank , MPI_Aint target_disp , int target_count , MPI_Datatype target_datatype , MPI_Win win , MPI_Request * request )
const QMPI_Rget_t = Cvoid

# typedef int ( QMPI_Rget_c_t ) ( QMPI_Context context , int tool_id , void * origin_addr , MPI_Count origin_count , MPI_Datatype origin_datatype , int target_rank , MPI_Aint target_disp , MPI_Count target_count , MPI_Datatype target_datatype , MPI_Win win , MPI_Request * request )
const QMPI_Rget_c_t = Cvoid

# typedef int ( QMPI_Rget_accumulate_t ) ( QMPI_Context context , int tool_id , const void * origin_addr , int origin_count , MPI_Datatype origin_datatype , void * result_addr , int result_count , MPI_Datatype result_datatype , int target_rank , MPI_Aint target_disp , int target_count , MPI_Datatype target_datatype , MPI_Op op , MPI_Win win , MPI_Request * request )
const QMPI_Rget_accumulate_t = Cvoid

# typedef int ( QMPI_Rget_accumulate_c_t ) ( QMPI_Context context , int tool_id , const void * origin_addr , MPI_Count origin_count , MPI_Datatype origin_datatype , void * result_addr , MPI_Count result_count , MPI_Datatype result_datatype , int target_rank , MPI_Aint target_disp , MPI_Count target_count , MPI_Datatype target_datatype , MPI_Op op , MPI_Win win , MPI_Request * request )
const QMPI_Rget_accumulate_c_t = Cvoid

# typedef int ( QMPI_Rput_t ) ( QMPI_Context context , int tool_id , const void * origin_addr , int origin_count , MPI_Datatype origin_datatype , int target_rank , MPI_Aint target_disp , int target_count , MPI_Datatype target_datatype , MPI_Win win , MPI_Request * request )
const QMPI_Rput_t = Cvoid

# typedef int ( QMPI_Rput_c_t ) ( QMPI_Context context , int tool_id , const void * origin_addr , MPI_Count origin_count , MPI_Datatype origin_datatype , int target_rank , MPI_Aint target_disp , MPI_Count target_count , MPI_Datatype target_datatype , MPI_Win win , MPI_Request * request )
const QMPI_Rput_c_t = Cvoid

# typedef int ( QMPI_Win_allocate_t ) ( QMPI_Context context , int tool_id , MPI_Aint size , int disp_unit , MPI_Info info , MPI_Comm comm , void * baseptr , MPI_Win * win )
const QMPI_Win_allocate_t = Cvoid

# typedef int ( QMPI_Win_allocate_c_t ) ( QMPI_Context context , int tool_id , MPI_Aint size , MPI_Aint disp_unit , MPI_Info info , MPI_Comm comm , void * baseptr , MPI_Win * win )
const QMPI_Win_allocate_c_t = Cvoid

# typedef int ( QMPI_Win_allocate_shared_t ) ( QMPI_Context context , int tool_id , MPI_Aint size , int disp_unit , MPI_Info info , MPI_Comm comm , void * baseptr , MPI_Win * win )
const QMPI_Win_allocate_shared_t = Cvoid

# typedef int ( QMPI_Win_allocate_shared_c_t ) ( QMPI_Context context , int tool_id , MPI_Aint size , MPI_Aint disp_unit , MPI_Info info , MPI_Comm comm , void * baseptr , MPI_Win * win )
const QMPI_Win_allocate_shared_c_t = Cvoid

# typedef int ( QMPI_Win_attach_t ) ( QMPI_Context context , int tool_id , MPI_Win win , void * base , MPI_Aint size )
const QMPI_Win_attach_t = Cvoid

# typedef int ( QMPI_Win_complete_t ) ( QMPI_Context context , int tool_id , MPI_Win win )
const QMPI_Win_complete_t = Cvoid

# typedef int ( QMPI_Win_create_t ) ( QMPI_Context context , int tool_id , void * base , MPI_Aint size , int disp_unit , MPI_Info info , MPI_Comm comm , MPI_Win * win )
const QMPI_Win_create_t = Cvoid

# typedef int ( QMPI_Win_create_c_t ) ( QMPI_Context context , int tool_id , void * base , MPI_Aint size , MPI_Aint disp_unit , MPI_Info info , MPI_Comm comm , MPI_Win * win )
const QMPI_Win_create_c_t = Cvoid

# typedef int ( QMPI_Win_create_dynamic_t ) ( QMPI_Context context , int tool_id , MPI_Info info , MPI_Comm comm , MPI_Win * win )
const QMPI_Win_create_dynamic_t = Cvoid

# typedef int ( QMPI_Win_detach_t ) ( QMPI_Context context , int tool_id , MPI_Win win , const void * base )
const QMPI_Win_detach_t = Cvoid

# typedef int ( QMPI_Win_fence_t ) ( QMPI_Context context , int tool_id , int assert , MPI_Win win )
const QMPI_Win_fence_t = Cvoid

# typedef int ( QMPI_Win_flush_t ) ( QMPI_Context context , int tool_id , int rank , MPI_Win win )
const QMPI_Win_flush_t = Cvoid

# typedef int ( QMPI_Win_flush_all_t ) ( QMPI_Context context , int tool_id , MPI_Win win )
const QMPI_Win_flush_all_t = Cvoid

# typedef int ( QMPI_Win_flush_local_t ) ( QMPI_Context context , int tool_id , int rank , MPI_Win win )
const QMPI_Win_flush_local_t = Cvoid

# typedef int ( QMPI_Win_flush_local_all_t ) ( QMPI_Context context , int tool_id , MPI_Win win )
const QMPI_Win_flush_local_all_t = Cvoid

# typedef int ( QMPI_Win_free_t ) ( QMPI_Context context , int tool_id , MPI_Win * win )
const QMPI_Win_free_t = Cvoid

# typedef int ( QMPI_Win_get_group_t ) ( QMPI_Context context , int tool_id , MPI_Win win , MPI_Group * group )
const QMPI_Win_get_group_t = Cvoid

# typedef int ( QMPI_Win_get_info_t ) ( QMPI_Context context , int tool_id , MPI_Win win , MPI_Info * info_used )
const QMPI_Win_get_info_t = Cvoid

# typedef int ( QMPI_Win_get_name_t ) ( QMPI_Context context , int tool_id , MPI_Win win , char * win_name , int * resultlen )
const QMPI_Win_get_name_t = Cvoid

# typedef int ( QMPI_Win_lock_t ) ( QMPI_Context context , int tool_id , int lock_type , int rank , int assert , MPI_Win win )
const QMPI_Win_lock_t = Cvoid

# typedef int ( QMPI_Win_lock_all_t ) ( QMPI_Context context , int tool_id , int assert , MPI_Win win )
const QMPI_Win_lock_all_t = Cvoid

# typedef int ( QMPI_Win_post_t ) ( QMPI_Context context , int tool_id , MPI_Group group , int assert , MPI_Win win )
const QMPI_Win_post_t = Cvoid

# typedef int ( QMPI_Win_set_info_t ) ( QMPI_Context context , int tool_id , MPI_Win win , MPI_Info info )
const QMPI_Win_set_info_t = Cvoid

# typedef int ( QMPI_Win_set_name_t ) ( QMPI_Context context , int tool_id , MPI_Win win , const char * win_name )
const QMPI_Win_set_name_t = Cvoid

# typedef int ( QMPI_Win_shared_query_t ) ( QMPI_Context context , int tool_id , MPI_Win win , int rank , MPI_Aint * size , int * disp_unit , void * baseptr )
const QMPI_Win_shared_query_t = Cvoid

# typedef int ( QMPI_Win_shared_query_c_t ) ( QMPI_Context context , int tool_id , MPI_Win win , int rank , MPI_Aint * size , MPI_Aint * disp_unit , void * baseptr )
const QMPI_Win_shared_query_c_t = Cvoid

# typedef int ( QMPI_Win_start_t ) ( QMPI_Context context , int tool_id , MPI_Group group , int assert , MPI_Win win )
const QMPI_Win_start_t = Cvoid

# typedef int ( QMPI_Win_sync_t ) ( QMPI_Context context , int tool_id , MPI_Win win )
const QMPI_Win_sync_t = Cvoid

# typedef int ( QMPI_Win_test_t ) ( QMPI_Context context , int tool_id , MPI_Win win , int * flag )
const QMPI_Win_test_t = Cvoid

# typedef int ( QMPI_Win_unlock_t ) ( QMPI_Context context , int tool_id , int rank , MPI_Win win )
const QMPI_Win_unlock_t = Cvoid

# typedef int ( QMPI_Win_unlock_all_t ) ( QMPI_Context context , int tool_id , MPI_Win win )
const QMPI_Win_unlock_all_t = Cvoid

# typedef int ( QMPI_Win_wait_t ) ( QMPI_Context context , int tool_id , MPI_Win win )
const QMPI_Win_wait_t = Cvoid

# typedef int ( QMPI_Close_port_t ) ( QMPI_Context context , int tool_id , const char * port_name )
const QMPI_Close_port_t = Cvoid

# typedef int ( QMPI_Comm_accept_t ) ( QMPI_Context context , int tool_id , const char * port_name , MPI_Info info , int root , MPI_Comm comm , MPI_Comm * newcomm )
const QMPI_Comm_accept_t = Cvoid

# typedef int ( QMPI_Comm_connect_t ) ( QMPI_Context context , int tool_id , const char * port_name , MPI_Info info , int root , MPI_Comm comm , MPI_Comm * newcomm )
const QMPI_Comm_connect_t = Cvoid

# typedef int ( QMPI_Comm_disconnect_t ) ( QMPI_Context context , int tool_id , MPI_Comm * comm )
const QMPI_Comm_disconnect_t = Cvoid

# typedef int ( QMPI_Comm_get_parent_t ) ( QMPI_Context context , int tool_id , MPI_Comm * parent )
const QMPI_Comm_get_parent_t = Cvoid

# typedef int ( QMPI_Comm_join_t ) ( QMPI_Context context , int tool_id , int fd , MPI_Comm * intercomm )
const QMPI_Comm_join_t = Cvoid

# typedef int ( QMPI_Comm_spawn_t ) ( QMPI_Context context , int tool_id , const char * command , char * argv [ ] , int maxprocs , MPI_Info info , int root , MPI_Comm comm , MPI_Comm * intercomm , int array_of_errcodes [ ] )
const QMPI_Comm_spawn_t = Cvoid

# typedef int ( QMPI_Comm_spawn_multiple_t ) ( QMPI_Context context , int tool_id , int count , char * array_of_commands [ ] , char * * array_of_argv [ ] , const int array_of_maxprocs [ ] , const MPI_Info array_of_info [ ] , int root , MPI_Comm comm , MPI_Comm * intercomm , int array_of_errcodes [ ] )
const QMPI_Comm_spawn_multiple_t = Cvoid

# typedef int ( QMPI_Lookup_name_t ) ( QMPI_Context context , int tool_id , const char * service_name , MPI_Info info , char * port_name )
const QMPI_Lookup_name_t = Cvoid

# typedef int ( QMPI_Open_port_t ) ( QMPI_Context context , int tool_id , MPI_Info info , char * port_name )
const QMPI_Open_port_t = Cvoid

# typedef int ( QMPI_Publish_name_t ) ( QMPI_Context context , int tool_id , const char * service_name , MPI_Info info , const char * port_name )
const QMPI_Publish_name_t = Cvoid

# typedef int ( QMPI_Unpublish_name_t ) ( QMPI_Context context , int tool_id , const char * service_name , MPI_Info info , const char * port_name )
const QMPI_Unpublish_name_t = Cvoid

# typedef double ( QMPI_Wtick_t ) ( QMPI_Context context , int tool_id )
const QMPI_Wtick_t = Cvoid

# typedef double ( QMPI_Wtime_t ) ( QMPI_Context context , int tool_id )
const QMPI_Wtime_t = Cvoid

# typedef int ( QMPI_Cart_coords_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , int rank , int maxdims , int coords [ ] )
const QMPI_Cart_coords_t = Cvoid

# typedef int ( QMPI_Cart_create_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm_old , int ndims , const int dims [ ] , const int periods [ ] , int reorder , MPI_Comm * comm_cart )
const QMPI_Cart_create_t = Cvoid

# typedef int ( QMPI_Cart_get_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , int maxdims , int dims [ ] , int periods [ ] , int coords [ ] )
const QMPI_Cart_get_t = Cvoid

# typedef int ( QMPI_Cart_map_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , int ndims , const int dims [ ] , const int periods [ ] , int * newrank )
const QMPI_Cart_map_t = Cvoid

# typedef int ( QMPI_Cart_rank_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , const int coords [ ] , int * rank )
const QMPI_Cart_rank_t = Cvoid

# typedef int ( QMPI_Cart_shift_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , int direction , int disp , int * rank_source , int * rank_dest )
const QMPI_Cart_shift_t = Cvoid

# typedef int ( QMPI_Cart_sub_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , const int remain_dims [ ] , MPI_Comm * newcomm )
const QMPI_Cart_sub_t = Cvoid

# typedef int ( QMPI_Cartdim_get_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , int * ndims )
const QMPI_Cartdim_get_t = Cvoid

# typedef int ( QMPI_Dims_create_t ) ( QMPI_Context context , int tool_id , int nnodes , int ndims , int dims [ ] )
const QMPI_Dims_create_t = Cvoid

# typedef int ( QMPI_Dist_graph_create_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm_old , int n , const int sources [ ] , const int degrees [ ] , const int destinations [ ] , const int weights [ ] , MPI_Info info , int reorder , MPI_Comm * comm_dist_graph )
const QMPI_Dist_graph_create_t = Cvoid

# typedef int ( QMPI_Dist_graph_create_adjacent_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm_old , int indegree , const int sources [ ] , const int sourceweights [ ] , int outdegree , const int destinations [ ] , const int destweights [ ] , MPI_Info info , int reorder , MPI_Comm * comm_dist_graph )
const QMPI_Dist_graph_create_adjacent_t = Cvoid

# typedef int ( QMPI_Dist_graph_neighbors_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , int maxindegree , int sources [ ] , int sourceweights [ ] , int maxoutdegree , int destinations [ ] , int destweights [ ] )
const QMPI_Dist_graph_neighbors_t = Cvoid

# typedef int ( QMPI_Dist_graph_neighbors_count_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , int * indegree , int * outdegree , int * weighted )
const QMPI_Dist_graph_neighbors_count_t = Cvoid

# typedef int ( QMPI_Graph_create_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm_old , int nnodes , const int indx [ ] , const int edges [ ] , int reorder , MPI_Comm * comm_graph )
const QMPI_Graph_create_t = Cvoid

# typedef int ( QMPI_Graph_get_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , int maxindex , int maxedges , int indx [ ] , int edges [ ] )
const QMPI_Graph_get_t = Cvoid

# typedef int ( QMPI_Graph_map_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , int nnodes , const int indx [ ] , const int edges [ ] , int * newrank )
const QMPI_Graph_map_t = Cvoid

# typedef int ( QMPI_Graph_neighbors_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , int rank , int maxneighbors , int neighbors [ ] )
const QMPI_Graph_neighbors_t = Cvoid

# typedef int ( QMPI_Graph_neighbors_count_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , int rank , int * nneighbors )
const QMPI_Graph_neighbors_count_t = Cvoid

# typedef int ( QMPI_Graphdims_get_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , int * nnodes , int * nedges )
const QMPI_Graphdims_get_t = Cvoid

# typedef int ( QMPI_Topo_test_t ) ( QMPI_Context context , int tool_id , MPI_Comm comm , int * status )
const QMPI_Topo_test_t = Cvoid

const NO_TAGS_WITH_MODIFIERS = 1

const MPI_COMM_NULL = MPI_Comm(0x04000000)

const MPI_OP_NULL = MPI_Op(0x18000000)

const MPI_GROUP_NULL = MPI_Group(0x08000000)

const MPI_DATATYPE_NULL = MPI_Datatype(0x0c000000)

const MPI_REQUEST_NULL = MPI_Request(0x2c000000)

const MPI_ERRHANDLER_NULL = MPI_Errhandler(0x14000000)

const MPI_MESSAGE_NULL = MPI_Message(0x2c000000)

const MPI_MESSAGE_NO_PROC = MPI_Message(0x6c000000)

const MPI_IDENT = 0

const MPI_CONGRUENT = 1

const MPI_SIMILAR = 2

const MPI_UNEQUAL = 3

const MPI_CHAR = MPI_Datatype(0x4c000101)

const MPI_SIGNED_CHAR = MPI_Datatype(0x4c000118)

const MPI_UNSIGNED_CHAR = MPI_Datatype(0x4c000102)

const MPI_BYTE = MPI_Datatype(0x4c00010d)

const MPI_WCHAR = MPI_Datatype(0x4c00040e)

const MPI_SHORT = MPI_Datatype(0x4c000203)

const MPI_UNSIGNED_SHORT = MPI_Datatype(0x4c000204)

const MPI_INT = MPI_Datatype(0x4c000405)

const MPI_UNSIGNED = MPI_Datatype(0x4c000406)

const MPI_LONG = MPI_Datatype(0x4c000807)

const MPI_UNSIGNED_LONG = MPI_Datatype(0x4c000808)

const MPI_FLOAT = MPI_Datatype(0x4c00040a)

const MPI_DOUBLE = MPI_Datatype(0x4c00080b)

const MPI_LONG_DOUBLE = MPI_Datatype(0x4c00100c)

const MPI_LONG_LONG_INT = MPI_Datatype(0x4c000809)

const MPI_UNSIGNED_LONG_LONG = MPI_Datatype(0x4c000819)

const MPI_LONG_LONG = MPI_LONG_LONG_INT

const MPI_PACKED = MPI_Datatype(0x4c00010f)

const MPI_LB = MPI_Datatype(0x4c000010)

const MPI_UB = MPI_Datatype(0x4c000011)

const MPI_FLOAT_INT = MPI_Datatype(0x8c000000)

const MPI_DOUBLE_INT = MPI_Datatype(0x8c000001)

const MPI_LONG_INT = MPI_Datatype(0x8c000002)

const MPI_SHORT_INT = MPI_Datatype(0x8c000003)

const MPI_2INT = MPI_Datatype(0x4c000816)

const MPI_LONG_DOUBLE_INT = MPI_Datatype(0x8c000004)

const MPI_COMPLEX = MPI_Datatype(0x4c00081e)

const MPI_DOUBLE_COMPLEX = MPI_Datatype(0x4c001022)

const MPI_LOGICAL = MPI_Datatype(0x4c00041d)

const MPI_REAL = MPI_Datatype(0x4c00041c)

const MPI_DOUBLE_PRECISION = MPI_Datatype(0x4c00081f)

const MPI_INTEGER = MPI_Datatype(0x4c00041b)

const MPI_2INTEGER = MPI_Datatype(0x4c000820)

const MPI_2REAL = MPI_Datatype(0x4c000821)

const MPI_2DOUBLE_PRECISION = MPI_Datatype(0x4c001023)

const MPI_CHARACTER = MPI_Datatype(0x4c00011a)

const MPI_REAL4 = MPI_Datatype(0x4c000427)

const MPI_REAL8 = MPI_Datatype(0x4c000829)

const MPI_REAL16 = MPI_Datatype(0x4c00102b)

const MPI_COMPLEX8 = MPI_Datatype(0x4c000828)

const MPI_COMPLEX16 = MPI_Datatype(0x4c00102a)

const MPI_COMPLEX32 = MPI_Datatype(0x4c00202c)

const MPI_INTEGER1 = MPI_Datatype(0x4c00012d)

const MPI_INTEGER2 = MPI_Datatype(0x4c00022f)

const MPI_INTEGER4 = MPI_Datatype(0x4c000430)

const MPI_INTEGER8 = MPI_Datatype(0x4c000831)

const MPI_INTEGER16 = MPI_Datatype(MPI_DATATYPE_NULL)

const MPI_INT8_T = MPI_Datatype(0x4c000137)

const MPI_INT16_T = MPI_Datatype(0x4c000238)

const MPI_INT32_T = MPI_Datatype(0x4c000439)

const MPI_INT64_T = MPI_Datatype(0x4c00083a)

const MPI_UINT8_T = MPI_Datatype(0x4c00013b)

const MPI_UINT16_T = MPI_Datatype(0x4c00023c)

const MPI_UINT32_T = MPI_Datatype(0x4c00043d)

const MPI_UINT64_T = MPI_Datatype(0x4c00083e)

const MPI_C_BOOL = MPI_Datatype(0x4c00013f)

const MPI_C_FLOAT_COMPLEX = MPI_Datatype(0x4c000840)

const MPI_C_COMPLEX = MPI_C_FLOAT_COMPLEX

const MPI_C_DOUBLE_COMPLEX = MPI_Datatype(0x4c001041)

const MPI_C_LONG_DOUBLE_COMPLEX = MPI_Datatype(0x4c002042)

const MPIX_C_FLOAT16 = MPI_Datatype(0x4c000246)

const MPI_AINT = MPI_Datatype(0x4c000843)

const MPI_OFFSET = MPI_Datatype(0x4c000844)

const MPI_COUNT = MPI_Datatype(0x4c000845)

const MPI_CXX_BOOL = MPI_Datatype(0x4c000133)

const MPI_CXX_FLOAT_COMPLEX = MPI_Datatype(0x4c000834)

const MPI_CXX_DOUBLE_COMPLEX = MPI_Datatype(0x4c001035)

const MPI_CXX_LONG_DOUBLE_COMPLEX = MPI_Datatype(0x4c002036)

const MPI_TYPECLASS_REAL = 1

const MPI_TYPECLASS_INTEGER = 2

const MPI_TYPECLASS_COMPLEX = 3

const MPI_COMM_WORLD = MPI_Comm(0x44000000)

const MPI_COMM_SELF = MPI_Comm(0x44000001)

const MPI_GROUP_EMPTY = MPI_Group(0x48000000)

const MPI_WIN_NULL = MPI_Win(0x20000000)

const MPI_SESSION_NULL = MPI_Session(0x38000000)

const MPI_FILE_NULL = MPI_File(0)

const MPI_MAX = MPI_Op(0x58000001)

const MPI_MIN = MPI_Op(0x58000002)

const MPI_SUM = MPI_Op(0x58000003)

const MPI_PROD = MPI_Op(0x58000004)

const MPI_LAND = MPI_Op(0x58000005)

const MPI_BAND = MPI_Op(0x58000006)

const MPI_LOR = MPI_Op(0x58000007)

const MPI_BOR = MPI_Op(0x58000008)

const MPI_LXOR = MPI_Op(0x58000009)

const MPI_BXOR = MPI_Op(0x5800000a)

const MPI_MINLOC = MPI_Op(0x5800000b)

const MPI_MAXLOC = MPI_Op(0x5800000c)

const MPI_REPLACE = MPI_Op(0x5800000d)

const MPI_NO_OP = MPI_Op(0x5800000e)

const MPI_TAG_UB = 0x64400001

const MPI_HOST = 0x64400003

const MPI_IO = 0x64400005

const MPI_WTIME_IS_GLOBAL = 0x64400007

const MPI_UNIVERSE_SIZE = 0x64400009

const MPI_LASTUSEDCODE = 0x6440000b

const MPI_APPNUM = 0x6440000d

const MPI_WIN_BASE = 0x66000001

const MPI_WIN_SIZE = 0x66000003

const MPI_WIN_DISP_UNIT = 0x66000005

const MPI_WIN_CREATE_FLAVOR = 0x66000007

const MPI_WIN_MODEL = 0x66000009

const MPI_MAX_PROCESSOR_NAME = 128

const MPI_MAX_LIBRARY_VERSION_STRING = 8192

const MPI_MAX_ERROR_STRING = 512

const MPI_MAX_PORT_NAME = 256

const MPI_MAX_OBJECT_NAME = 128

const MPI_MAX_STRINGTAG_LEN = 256

const MPI_MAX_PSET_NAME_LEN = 256

const MPI_UNDEFINED = -32766

const MPI_KEYVAL_INVALID = 0x24000000

const MPI_BSEND_OVERHEAD = 96

# Skipping MacroDefinition: MPI_BOTTOM ( void * ) 0

const MPI_PROC_NULL = -1

const MPI_ANY_SOURCE = -2

const MPI_ROOT = -3

const MPI_ANY_TAG = -1

const MPI_LOCK_EXCLUSIVE = 234

const MPI_LOCK_SHARED = 235

const MPI_ERRORS_ARE_FATAL = MPI_Errhandler(0x54000000)

const MPI_ERRORS_RETURN = MPI_Errhandler(0x54000001)

const MPI_ERRORS_ABORT = MPI_Errhandler(0x54000003)

const MPIR_ERRORS_THROW_EXCEPTIONS = MPI_Errhandler(0x54000002)

# Skipping MacroDefinition: MPI_NULL_COPY_FN ( ( MPI_Copy_function * ) 0 )

# Skipping MacroDefinition: MPI_NULL_DELETE_FN ( ( MPI_Delete_function * ) 0 )

const MPI_DUP_FN = MPIR_Dup_fn

# Skipping MacroDefinition: MPI_COMM_NULL_COPY_FN ( ( MPI_Comm_copy_attr_function * ) 0 )

# Skipping MacroDefinition: MPI_COMM_NULL_DELETE_FN ( ( MPI_Comm_delete_attr_function * ) 0 )

# Skipping MacroDefinition: MPI_COMM_DUP_FN ( ( MPI_Comm_copy_attr_function * ) MPI_DUP_FN )

# Skipping MacroDefinition: MPI_WIN_NULL_COPY_FN ( ( MPI_Win_copy_attr_function * ) 0 )

# Skipping MacroDefinition: MPI_WIN_NULL_DELETE_FN ( ( MPI_Win_delete_attr_function * ) 0 )

# Skipping MacroDefinition: MPI_WIN_DUP_FN ( ( MPI_Win_copy_attr_function * ) MPI_DUP_FN )

# Skipping MacroDefinition: MPI_TYPE_NULL_COPY_FN ( ( MPI_Type_copy_attr_function * ) 0 )

# Skipping MacroDefinition: MPI_TYPE_NULL_DELETE_FN ( ( MPI_Type_delete_attr_function * ) 0 )

# Skipping MacroDefinition: MPI_TYPE_DUP_FN ( ( MPI_Type_copy_attr_function * ) MPI_DUP_FN )

const MPI_VERSION = 4

const MPI_SUBVERSION = 0

const MPICH_NAME = 4

const MPICH = 1

const MPICH_HAS_C2F = 1

const MPICH_VERSION = "4.0.2"

const MPICH_NUMVERSION = 40002300

const MPICH_RELEASE_TYPE_ALPHA = 0

const MPICH_RELEASE_TYPE_BETA = 1

const MPICH_RELEASE_TYPE_RC = 2

const MPICH_RELEASE_TYPE_PATCH = 3

const MPI_INFO_NULL = MPI_Info(0x1c000000)

const MPI_INFO_ENV = MPI_Info(0x5c000001)

const MPI_MAX_INFO_KEY = 255

const MPI_MAX_INFO_VAL = 1024

const MPI_ORDER_C = 56

const MPI_ORDER_FORTRAN = 57

const MPI_DISTRIBUTE_BLOCK = 121

const MPI_DISTRIBUTE_CYCLIC = 122

const MPI_DISTRIBUTE_NONE = 123

const MPI_DISTRIBUTE_DFLT_DARG = -49767

# Skipping MacroDefinition: MPI_IN_PLACE ( void * ) - 1

const MPI_MODE_NOCHECK = 1024

const MPI_MODE_NOSTORE = 2048

const MPI_MODE_NOPUT = 4096

const MPI_MODE_NOPRECEDE = 8192

const MPI_MODE_NOSUCCEED = 16384

const MPI_COMM_TYPE_SHARED = 1

const MPI_COMM_TYPE_HW_GUIDED = 2

const MPI_COMM_TYPE_HW_UNGUIDED = 3

const MPIX_COMM_TYPE_NEIGHBORHOOD = 4

const MPI_AINT_FMT_DEC_SPEC = "%ld"

const MPI_AINT_FMT_HEX_SPEC = "%lx"

const MPI_T_ENUM_NULL = MPI_T_enum(NULL)

const MPI_T_CVAR_HANDLE_NULL = MPI_T_cvar_handle(NULL)

const MPI_T_PVAR_HANDLE_NULL = MPI_T_pvar_handle(NULL)

const MPI_T_PVAR_SESSION_NULL = MPI_T_pvar_session(NULL)

# Skipping MacroDefinition: MPI_STATUS_IGNORE ( MPI_Status * ) 1

# Skipping MacroDefinition: MPI_STATUSES_IGNORE ( MPI_Status * ) 1

# Skipping MacroDefinition: MPI_ERRCODES_IGNORE ( int * ) 0

const MPI_ARGV_NULL = (Cchar * (*))(0)

# Skipping MacroDefinition: MPI_ARGVS_NULL ( char * * * ) 0

const MPI_F_STATUS_SIZE = 5

const MPI_F_SOURCE = 2

const MPI_F_TAG = 3

const MPI_F_ERROR = 4

const MPI_THREAD_SINGLE = 0

const MPI_THREAD_FUNNELED = 1

const MPI_THREAD_SERIALIZED = 2

const MPI_THREAD_MULTIPLE = 3

const MPI_SUCCESS = 0

const MPI_ERR_BUFFER = 1

const MPI_ERR_COUNT = 2

const MPI_ERR_TYPE = 3

const MPI_ERR_TAG = 4

const MPI_ERR_COMM = 5

const MPI_ERR_RANK = 6

const MPI_ERR_ROOT = 7

const MPI_ERR_TRUNCATE = 14

const MPI_ERR_GROUP = 8

const MPI_ERR_OP = 9

const MPI_ERR_REQUEST = 19

const MPI_ERR_TOPOLOGY = 10

const MPI_ERR_DIMS = 11

const MPI_ERR_ARG = 12

const MPI_ERR_OTHER = 15

const MPI_ERR_UNKNOWN = 13

const MPI_ERR_INTERN = 16

const MPI_ERR_IN_STATUS = 17

const MPI_ERR_PENDING = 18

const MPI_ERR_ACCESS = 20

const MPI_ERR_AMODE = 21

const MPI_ERR_BAD_FILE = 22

const MPI_ERR_CONVERSION = 23

const MPI_ERR_DUP_DATAREP = 24

const MPI_ERR_FILE_EXISTS = 25

const MPI_ERR_FILE_IN_USE = 26

const MPI_ERR_FILE = 27

const MPI_ERR_IO = 32

const MPI_ERR_NO_SPACE = 36

const MPI_ERR_NO_SUCH_FILE = 37

const MPI_ERR_READ_ONLY = 40

const MPI_ERR_UNSUPPORTED_DATAREP = 43

const MPI_ERR_INFO = 28

const MPI_ERR_INFO_KEY = 29

const MPI_ERR_INFO_VALUE = 30

const MPI_ERR_INFO_NOKEY = 31

const MPI_ERR_NAME = 33

const MPI_ERR_NO_MEM = 34

const MPI_ERR_NOT_SAME = 35

const MPI_ERR_PORT = 38

const MPI_ERR_QUOTA = 39

const MPI_ERR_SERVICE = 41

const MPI_ERR_SPAWN = 42

const MPI_ERR_UNSUPPORTED_OPERATION = 44

const MPI_ERR_WIN = 45

const MPI_ERR_BASE = 46

const MPI_ERR_LOCKTYPE = 47

const MPI_ERR_KEYVAL = 48

const MPI_ERR_RMA_CONFLICT = 49

const MPI_ERR_RMA_SYNC = 50

const MPI_ERR_SIZE = 51

const MPI_ERR_DISP = 52

const MPI_ERR_ASSERT = 53

const MPI_ERR_RMA_RANGE = 55

const MPI_ERR_RMA_ATTACH = 56

const MPI_ERR_RMA_SHARED = 57

const MPI_ERR_RMA_FLAVOR = 58

const MPI_T_ERR_MEMORY = 59

const MPI_T_ERR_NOT_INITIALIZED = 60

const MPI_T_ERR_CANNOT_INIT = 61

const MPI_T_ERR_INVALID_INDEX = 62

const MPI_T_ERR_INVALID_ITEM = 63

const MPI_T_ERR_INVALID_HANDLE = 64

const MPI_T_ERR_OUT_OF_HANDLES = 65

const MPI_T_ERR_OUT_OF_SESSIONS = 66

const MPI_T_ERR_INVALID_SESSION = 67

const MPI_T_ERR_CVAR_SET_NOT_NOW = 68

const MPI_T_ERR_CVAR_SET_NEVER = 69

const MPI_T_ERR_PVAR_NO_STARTSTOP = 70

const MPI_T_ERR_PVAR_NO_WRITE = 71

const MPI_T_ERR_PVAR_NO_ATOMIC = 72

const MPI_T_ERR_INVALID_NAME = 73

const MPI_T_ERR_INVALID = 74

const MPI_ERR_SESSION = 75

const MPI_ERR_PROC_ABORTED = 76

const MPI_ERR_VALUE_TOO_LARGE = 77

const MPI_T_ERR_NOT_SUPPORTED = 78

const MPI_ERR_LASTCODE = 0x3fffffff

const MPICH_ERR_LAST_CLASS = 78

const MPICH_ERR_FIRST_MPIX = 100

const MPIX_ERR_PROC_FAILED = MPICH_ERR_FIRST_MPIX + 1

const MPIX_ERR_PROC_FAILED_PENDING = MPICH_ERR_FIRST_MPIX + 2

const MPIX_ERR_REVOKED = MPICH_ERR_FIRST_MPIX + 3

const MPIX_ERR_EAGAIN = MPICH_ERR_FIRST_MPIX + 4

const MPIX_ERR_NOREQ = MPICH_ERR_FIRST_MPIX + 5

const MPICH_ERR_LAST_MPIX = MPICH_ERR_FIRST_MPIX + 5

# Skipping MacroDefinition: MPI_CONVERSION_FN_NULL ( ( MPI_Datarep_conversion_function * ) 0 )

# Skipping MacroDefinition: MPI_CONVERSION_FN_NULL_C ( ( MPI_Datarep_conversion_function_c * ) 0 )

const QMPI_MAX_TOOL_NAME_LENGTH = 256

const MPIX_GPU_SUPPORT_CUDA = 0

const MPIX_GPU_SUPPORT_ZE = 1

const MPIX_GPU_SUPPORT_HIP = 2

const MPIIMPL_ADVERTISES_FEATURES = 1

const MPIIMPL_HAVE_MPI_INFO = 1

const MPIIMPL_HAVE_MPI_COMBINER_DARRAY = 1

const MPIIMPL_HAVE_MPI_TYPE_CREATE_DARRAY = 1

const MPIIMPL_HAVE_MPI_COMBINER_SUBARRAY = 1

const MPIIMPL_HAVE_MPI_COMBINER_DUP = 1

const MPIIMPL_HAVE_MPI_GREQUEST = 1

const MPIIMPL_HAVE_STATUS_SET_BYTES = 1

const MPIIMPL_HAVE_STATUS_SET_INFO = 1

const ROMIO_VERSION = 126

const HAVE_MPI_GREQUEST = 1

const MPIO_Request = MPI_Request

const MPIO_Wait = MPI_Wait

const MPIO_Test = MPI_Test

const PMPIO_Wait = PMPI_Wait

const PMPIO_Test = PMPI_Test

const MPI_MODE_RDONLY = 2

const MPI_MODE_RDWR = 8

const MPI_MODE_WRONLY = 4

const MPI_MODE_CREATE = 1

const MPI_MODE_EXCL = 64

const MPI_MODE_DELETE_ON_CLOSE = 16

const MPI_MODE_UNIQUE_OPEN = 32

const MPI_MODE_APPEND = 128

const MPI_MODE_SEQUENTIAL = 256

const MPI_DISPLACEMENT_CURRENT = -54278278

const MPIO_REQUEST_NULL = MPIO_Request(0)

const MPI_SEEK_SET = 600

const MPI_SEEK_CUR = 602

const MPI_SEEK_END = 604

const MPI_MAX_DATAREP_STRING = 128

# exports
const PREFIXES = ["MPI_"]
for name in names(@__MODULE__; all=true), prefix in PREFIXES
    if startswith(string(name), prefix)
        @eval export $name
    end
end

end # module
