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

const DATATYPE_NULL           = Cint(0x0c000000)

const CHAR                    = Cint(0x4c000101)
const UNSIGNED_CHAR           = Cint(0x4c000102)
const SHORT                   = Cint(0x4c000203)
const UNSIGNED_SHORT          = Cint(0x4c000204)
const INT                     = Cint(0x4c000405)
const UNSIGNED                = Cint(0x4c000406)
const LONG                    = Cint(0x4c000407)
const UNSIGNED_LONG           = Cint(0x4c000408)
const LONG_LONG_INT           = Cint(0x4c000809)
const LONG_LONG               = LONG_LONG_INT
const FLOAT                   = Cint(0x4c00040a)
const DOUBLE                  = Cint(0x4c00080b)
const LONG_DOUBLE             = Cint(0x4c00080c)
const BYTE                    = Cint(0x4c00010d)
const WCHAR                   = Cint(0x4c00020e)

const PACKED                  = Cint(0x4c00010f)
const LB                      = Cint(0x4c000010)
const UB                      = Cint(0x4c000011)

const C_COMPLEX               = Cint(0x4c000812)
const C_FLOAT_COMPLEX         = Cint(0x4c000813)
const C_DOUBLE_COMPLEX        = Cint(0x4c001014)
const C_LONG_DOUBLE_COMPLEX   = Cint(0x4c001015)

const C_BOOL                  = Cint(0x4c000117)
const SIGNED_CHAR             = Cint(0x4c000118)
const UNSIGNED_LONG_LONG      = Cint(0x4c000819)

const INT8_T                  = Cint(0x4c000133)
const INT16_T                 = Cint(0x4c000234)
const INT32_T                 = Cint(0x4c000435)
const INT64_T                 = Cint(0x4c000836)
const UINT8_T                 = Cint(0x4c000137)
const UINT16_T                = Cint(0x4c000238)
const UINT32_T                = Cint(0x4c000439)
const UINT64_T                = Cint(0x4c00083a)

# Comm
const COMM_NULL               = Comm(Cint(0x04000000))
const COMM_WORLD              = Comm(Cint(0x44000000))
const COMM_SELF               = Comm(Cint(0x44000001))

# Op
const OP_NULL                 = Cint(0x18000000)
const MAX                     = Cint(0x58000001)
const MIN                     = Cint(0x58000002)
const SUM                     = Cint(0x58000003)
const PROD                    = Cint(0x58000004)
const LAND                    = Cint(0x58000005)
const BAND                    = Cint(0x58000006)
const LOR                     = Cint(0x58000007)
const BOR                     = Cint(0x58000008)
const LXOR                    = Cint(0x58000009)
const BXOR                    = Cint(0x5800000a)
const MINLOC                  = Cint(0x5800000b)
const MAXLOC                  = Cint(0x5800000c)
const REPLACE                 = Cint(0x5800000d)

# Request
const REQUEST_NULL            = Request(Cint(0x2c000000), nothing)

# Misc constants

const UNDEFINED   = Cint(-32766)

const PROC_NULL   = Cint(-1)
const ANY_SOURCE  = Cint(-2)
const ROOT        = Cint(-3)

const ANY_TAG     = Cint(-1)

immutable Status
    count_lo::Cint
    count_hi_and_cancelled::Cint
    source::Cint
    tag::Cint
    error::Cint
end

