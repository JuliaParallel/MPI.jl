typealias MPI_Comm          Ptr{Void}
typealias MPI_Datatype      Ptr{Void}
typealias MPI_Errhandler    Ptr{Void}
typealias MPI_Group         Ptr{Void}
typealias MPI_Message       Ptr{Void}
typealias MPI_Op            Ptr{Void}
typealias MPI_Request       Ptr{Void}
typealias MPI_User_function Ptr{Void}

immutable Comm
    val::MPI_Comm
end

type Request
    val::MPI_Request
    buffer
end

# Miscellaneous constants
const ANY_SOURCE         = Cint(-1)
const PROC_NULL          = Cint(-2)
const ROOT               = Cint(-4)
const ANY_TAG            = Cint(-1)
const UNDEFINED          = Cint(-32766)

# NULL handles
const GROUP_NULL       = cglobal((:ompi_mpi_group_null, libmpi))
const COMM_NULL        = Comm(cglobal((:ompi_mpi_comm_null, libmpi)))
const REQUEST_NULL     = Request(cglobal((:ompi_request_null, libmpi)), nothing)
const MESSAGE_NULL     = cglobal((:ompi_message_null, libmpi))
const OP_NULL          = cglobal((:ompi_mpi_op_null, libmpi))
const ERRHANDLER_NULL  = cglobal((:ompi_mpi_errhandler_null, libmpi))
const INFO_NULL        = cglobal((:ompi_mpi_info_null, libmpi))
const WIN_NULL         = cglobal((:ompi_mpi_win_null, libmpi))

# MPI predefined handles
const COMM_WORLD       = Comm(cglobal((:ompi_mpi_comm_world, libmpi)))
const COMM_SELF        = Comm(cglobal((:ompi_mpi_comm_self, libmpi)))

const GROUP_EMPTY      = cglobal((:ompi_mpi_group_empty, libmpi))

const MESSAGE_NO_PROC  = cglobal((:ompi_message_no_proc, libmpi))

const MAX     = cglobal((:ompi_mpi_op_max, libmpi))
const MIN     = cglobal((:ompi_mpi_op_min, libmpi))
const SUM     = cglobal((:ompi_mpi_op_sum, libmpi))
const PROD    = cglobal((:ompi_mpi_op_prod, libmpi))
const LAND    = cglobal((:ompi_mpi_op_land, libmpi))
const BAND    = cglobal((:ompi_mpi_op_band, libmpi))
const LOR     = cglobal((:ompi_mpi_op_lor, libmpi))
const BOR     = cglobal((:ompi_mpi_op_bor, libmpi))
const LXOR    = cglobal((:ompi_mpi_op_lxor, libmpi))
const BXOR    = cglobal((:ompi_mpi_op_bxor, libmpi))
const MAXLOC  = cglobal((:ompi_mpi_op_maxloc, libmpi))
const MINLOC  = cglobal((:ompi_mpi_op_minloc, libmpi))
const REPLACE = cglobal((:ompi_mpi_op_replace, libmpi))
const NO_OP   = cglobal((:ompi_mpi_op_no_op, libmpi))

# C datatypes
const DATATYPE_NULL   = cglobal((:ompi_mpi_datatype_null, libmpi))
const BYTE            = cglobal((:ompi_mpi_byte, libmpi))
const PACKED          = cglobal((:ompi_mpi_packed, libmpi))
const CHAR            = cglobal((:ompi_mpi_char, libmpi))
const SHORT           = cglobal((:ompi_mpi_short, libmpi))
const INT             = cglobal((:ompi_mpi_int, libmpi))
const LONG            = cglobal((:ompi_mpi_long, libmpi))
const FLOAT           = cglobal((:ompi_mpi_float, libmpi))
const DOUBLE          = cglobal((:ompi_mpi_double, libmpi))
const LONG_DOUBLE     = cglobal((:ompi_mpi_long_double, libmpi))
const UNSIGNED_CHAR   = cglobal((:ompi_mpi_unsigned_char, libmpi))
const SIGNED_CHAR     = cglobal((:ompi_mpi_signed_char, libmpi))
const UNSIGNED_SHORT  = cglobal((:ompi_mpi_unsigned_short, libmpi))
const UNSIGNED_LONG   = cglobal((:ompi_mpi_unsigned_long, libmpi))
const UNSIGNED        = cglobal((:ompi_mpi_unsigned, libmpi))
const FLOAT_INT       = cglobal((:ompi_mpi_float_int, libmpi))
const DOUBLE_INT      = cglobal((:ompi_mpi_double_int, libmpi))
const LONG_DOUBLE_INT = cglobal((:ompi_mpi_longdbl_int, libmpi))
const LONG_INT        = cglobal((:ompi_mpi_long_int, libmpi))
const SHORT_INT       = cglobal((:ompi_mpi_short_int, libmpi))
const MPI_2INT        = cglobal((:ompi_mpi_2int, libmpi))
const UB              = cglobal((:ompi_mpi_ub, libmpi))
const LB              = cglobal((:ompi_mpi_lb, libmpi))
const WCHAR           = cglobal((:ompi_mpi_wchar, libmpi))
if Libdl.dlsym_e(Libdl.dlopen(libmpi), :ompi_mpi_long_long_int) != C_NULL
    const LONG_LONG_INT      = cglobal((:ompi_mpi_long_long_int, libmpi))
    const LONG_LONG          = cglobal((:ompi_mpi_long_long_int, libmpi))
    const UNSIGNED_LONG_LONG = cglobal((:ompi_mpi_unsigned_long_long, libmpi))
end
const MPI_2COMPLEX        = cglobal((:ompi_mpi_2cplex, libmpi))
const MPI_2DOUBLE_COMPLEX = cglobal((:ompi_mpi_2dblcplex, libmpi))

# New datatypes from the MPI 2.2 standard
const INT8_T                = cglobal((:ompi_mpi_int8_t, libmpi))
const UINT8_T               = cglobal((:ompi_mpi_uint8_t, libmpi))
const INT16_T               = cglobal((:ompi_mpi_int16_t, libmpi))
const UINT16_T              = cglobal((:ompi_mpi_uint16_t, libmpi))
const INT32_T               = cglobal((:ompi_mpi_int32_t, libmpi))
const UINT32_T              = cglobal((:ompi_mpi_uint32_t, libmpi))
const INT64_T               = cglobal((:ompi_mpi_int64_t, libmpi))
const UINT64_T              = cglobal((:ompi_mpi_uint64_t, libmpi))
const AINT                  = cglobal((:ompi_mpi_aint, libmpi))
const OFFSET                = cglobal((:ompi_mpi_offset, libmpi))
const C_BOOL                = cglobal((:ompi_mpi_c_bool, libmpi))
if Libdl.dlsym_e(Libdl.dlopen(libmpi), :ompi_mpi_c_complex) != C_NULL
    const C_COMPLEX             = cglobal((:ompi_mpi_c_complex, libmpi))
    const C_FLOAT_COMPLEX       = cglobal((:ompi_mpi_c_float_complex, libmpi))
end
if Libdl.dlsym_e(Libdl.dlopen(libmpi), :ompi_mpi_c_double_complex) != C_NULL
    const C_DOUBLE_COMPLEX      = cglobal((:ompi_mpi_c_double_complex, libmpi))
end
if Libdl.dlsym_e(Libdl.dlopen(libmpi), :ompi_mpi_c_long_double_complex) != C_NULL
    const C_LONG_DOUBLE_COMPLEX = cglobal((:ompi_mpi_c_long_double_complex, libmpi))
end
const CXX_BOOL                = cglobal((:ompi_mpi_cxx_bool, libmpi))
const CXX_FLOAT_COMPLEX       = cglobal((:ompi_mpi_cxx_cplex, libmpi))
const CXX_DOUBLE_COMPLEX      = cglobal((:ompi_mpi_cxx_dblcplex, libmpi))
const CXX_LONG_DOUBLE_COMPLEX = cglobal((:ompi_mpi_cxx_ldblcplex, libmpi))

immutable Status
    # These fields are publicly defined in the MPI specification.
    # User applications may freely read from these fields.
    source::Cint
    tag::Cint
    error::Cint

    _cancelled::Cint
    _ucount::Csize_t
    # The following fields is buffer space
    # buf::NTuple{6,Cint}
end
