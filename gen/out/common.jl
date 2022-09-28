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

