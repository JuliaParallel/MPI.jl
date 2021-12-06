# This file has been generated automatically by `generate_compile_time_mpi_constants`.
# Do not edit.

# MPI library version (for reference only; this is not a constant)
const MPI_LIBRARY_VERSION_ = "Microsoft MPI x86_64"

# Compile-time constants

# Version:
# (We add an underscore to avoid a name conflict with `MPI.jl`)
const MPI_VERSION_ = Cint(2)
const MPI_SUBVERSION_ = Cint(0)

# Implementation limits:
const MPI_MAX_DATAREP_STRING = Cint(128)
const MPI_MAX_ERROR_STRING = Cint(512)
const MPI_MAX_INFO_KEY = Cint(255)
const MPI_MAX_INFO_VAL = Cint(1024)
const MPI_MAX_LIBRARY_VERSION_STRING = Cint(8192)
const MPI_MAX_OBJECT_NAME = Cint(128)
const MPI_MAX_PORT_NAME = Cint(256)
const MPI_MAX_PROCESSOR_NAME = Cint(128)

# Types

# Various (signed) integer types:
const MPI_Aint = Int64
const MPI_Count = Int64
const MPI_Fint = Int32
const MPI_Offset = Int64

# Status:
struct MPI_Status
    private0::Cint
    private1::Cint
    MPI_SOURCE::Cint
    MPI_TAG::Cint
    MPI_ERROR::Cint
end

# Opaque handles:
const MPI_Comm = UInt32
const MPI_Datatype = UInt32
const MPI_Errhandler = UInt32
const MPI_File = UInt64
const MPI_Group = UInt32
const MPI_Info = UInt32
const MPI_Message = UInt32
const MPI_Op = UInt32
const MPI_Request = UInt32
const MPI_Win = UInt32

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
