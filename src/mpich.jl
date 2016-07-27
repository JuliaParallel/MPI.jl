typealias MPI_Comm          Cint
typealias MPI_Datatype      Cint
typealias MPI_Errhandler    Cint
typealias MPI_Group         Cint
typealias MPI_Message       Cint
typealias MPI_Op            Cint
typealias MPI_Request       Cint
typealias MPI_User_function Cint

immutable Comm
    val::MPI_Comm
end

type Request
    val::MPI_Request
    buffer
end

# Define some null objects
const COMM_NULL       = Comm(Cint(0x04000000))
const OP_NULL         = Cint(0x18000000)
const GROUP_NULL      = Cint(0x08000000)
const DATATYPE_NULL   = Cint(0x0c000000)
const REQUEST_NULL    = Request(Cint(0x2c000000), nothing)
const ERRHANDLER_NULL = Cint(0x14000000)
const MESSAGE_NULL    = Cint(0x2c000000)
const MESSAGE_NO_PROC = Cint(0x6c000000)

# C types
const CHAR               = Cint(0x4c000101)
const SIGNED_CHAR        = Cint(0x4c000118)
const UNSIGNED_CHAR      = Cint(0x4c000102)
const BYTE               = Cint(0x4c00010d)
const WCHAR              = Cint(0x4c00040e)
const SHORT              = Cint(0x4c000203)
const UNSIGNED_SHORT     = Cint(0x4c000204)
const INT                = Cint(0x4c000405)
const UNSIGNED           = Cint(0x4c000406)
const LONG               = Cint(0x4c000807)
const UNSIGNED_LONG      = Cint(0x4c000808)
const FLOAT              = Cint(0x4c00040a)
const DOUBLE             = Cint(0x4c00080b)
const LONG_DOUBLE        = Cint(0x4c00100c)
const LONG_LONG_INT      = Cint(0x4c000809)
const UNSIGNED_LONG_LONG = Cint(0x4c000819)
const LONG_LONG          = LONG_LONG_INT

# C99 fixed-width datatypes
const INT8_T             = Cint(0x4c000137)
const INT16_T            = Cint(0x4c000238)
const INT32_T            = Cint(0x4c000439)
const INT64_T            = Cint(0x4c00083a)
const UINT8_T            = Cint(0x4c00013b)
const UINT16_T           = Cint(0x4c00023c)
const UINT32_T           = Cint(0x4c00043d)
const UINT64_T           = Cint(0x4c00083e)

# other C99 types
const C_BOOL                 = Cint(0x4c00013f)
const C_FLOAT_COMPLEX        = Cint(0x4c000840)
const C_COMPLEX              = C_FLOAT_COMPLEX
const C_DOUBLE_COMPLEX       = Cint(0x4c001041)
const C_LONG_DOUBLE_COMPLEX  = Cint(0x4c002042)

# MPI-3 C++ types
const CXX_BOOL                = Cint(0x4c000133)
const CXX_FLOAT_COMPLEX       = Cint(0x4c000834)
const CXX_DOUBLE_COMPLEX      = Cint(0x4c001035)
const CXX_LONG_DOUBLE_COMPLEX = Cint(0x4c002036)

const COMM_WORLD = Comm(Cint(0x44000000))
const COMM_SELF  = Comm(Cint(0x44000001))

const MAX     = Cint(0x58000001)
const MIN     = Cint(0x58000002)
const SUM     = Cint(0x58000003)
const PROD    = Cint(0x58000004)
const LAND    = Cint(0x58000005)
const BAND    = Cint(0x58000006)
const LOR     = Cint(0x58000007)
const BOR     = Cint(0x58000008)
const LXOR    = Cint(0x58000009)
const BXOR    = Cint(0x5800000a)
const MINLOC  = Cint(0x5800000b)
const MAXLOC  = Cint(0x5800000c)
const REPLACE = Cint(0x5800000d)
const NO_OP   = Cint(0x5800000e)

PROC_NULL     = Cint(-1)
ANY_SOURCE    = Cint(-2)
ROOT          = Cint(-3)
ANY_TAG       = Cint(-1)
UNDEFINED     = Cint(-32766)

immutable Status
    count_lo::Cint
    count_hi_and_cancelled::Cint
    source::Cint
    tag::Cint
    error::Cint
end
