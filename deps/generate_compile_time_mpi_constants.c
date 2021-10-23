#include <assert.h>
#include <ctype.h>
#include <stddef.h>
#include <stdio.h>

#include <mpi.h>

int main(int argc, char **argv) {
  MPI_Init(&argc, &argv);

  FILE *file = fopen("compile_time_mpi_constants.jl", "w");

  fprintf(file, "# This file has been generated automatically by "
                "`generate_compile_time_mpi_constants`.\n");
  fprintf(file, "# Do not edit.\n");
  fprintf(file, "\n");

  fprintf(
      file,
      "# MPI library version (for reference only; this is not a constant)\n");
  int len;
  char library_version[MPI_MAX_LIBRARY_VERSION_STRING];
  MPI_Get_library_version(library_version, &len);
  fprintf(file, "const MPI_LIBRARY_VERSION_ = \"");
  for (const char *restrict p = library_version; *p; ++p) {
    switch (*p) {
    case '\t':
      fprintf(file, "\\t");
      break;
    case '\n':
      fprintf(file, "\\n");
      break;
    case '"':
    case '$':
    case '\\':
      fprintf(file, "\\%c", *p);
      break;
    default:
      // Omit non-printable characters for safety
      if (isprint(*p))
        fprintf(file, "%c", *p);
    }
  }
  fprintf(file, "\"\n");
  fprintf(file, "\n");

  fprintf(file, "# Compile-time constants\n");
  fprintf(file, "\n");
  fprintf(file, "# Version:\n");
  fprintf(file,
          "# (We add an underscore to avoid a name conflict with `MPI.jl`)\n");
  fprintf(file, "const MPI_VERSION_ = Cint(%d)\n", MPI_VERSION);
  fprintf(file, "const MPI_SUBVERSION_ = Cint(%d)\n", MPI_SUBVERSION);
  fprintf(file, "\n");
  fprintf(file, "# Implementation limits:\n");
  fprintf(file, "const MPI_MAX_DATAREP_STRING = Cint(%d)\n",
          MPI_MAX_DATAREP_STRING);
  fprintf(file, "const MPI_MAX_ERROR_STRING = Cint(%d)\n",
          MPI_MAX_ERROR_STRING);
  fprintf(file, "const MPI_MAX_INFO_KEY = Cint(%d)\n", MPI_MAX_INFO_KEY);
  fprintf(file, "const MPI_MAX_INFO_VAL = Cint(%d)\n", MPI_MAX_INFO_VAL);
  fprintf(file, "const MPI_MAX_LIBRARY_VERSION_STRING = Cint(%d)\n",
          MPI_MAX_LIBRARY_VERSION_STRING);
  fprintf(file, "const MPI_MAX_OBJECT_NAME = Cint(%d)\n", MPI_MAX_OBJECT_NAME);
  fprintf(file, "const MPI_MAX_PORT_NAME = Cint(%d)\n", MPI_MAX_PORT_NAME);
  fprintf(file, "const MPI_MAX_PROCESSOR_NAME = Cint(%d)\n",
          MPI_MAX_PROCESSOR_NAME);

  fprintf(file, "\n");
  fprintf(file, "# Types\n");
  fprintf(file, "\n");
  fprintf(file, "# Various (signed) integer types:\n");
  fprintf(file, "const MPI_Aint = Int%zu\n", 8 * sizeof(MPI_Aint));
  fprintf(file, "const MPI_Count = Int%zu\n", 8 * sizeof(MPI_Count));
  fprintf(file, "const MPI_Fint = Int%zu\n", 8 * sizeof(MPI_Fint));
  fprintf(file, "const MPI_Offset = Int%zu\n", 8 * sizeof(MPI_Offset));
  fprintf(file, "\n");
  fprintf(file, "# Status:\n");
  static_assert(sizeof(MPI_Status) % sizeof(int) == 0,
                "MPI_Status is not made of `int` fields");
  static_assert(offsetof(MPI_Status, MPI_ERROR) % sizeof(int) == 0,
                "MPI_Status field MPI_ERROR is not aligned to `int`");
  static_assert(offsetof(MPI_Status, MPI_SOURCE) % sizeof(int) == 0,
                "MPI_Status field MPI_SOURCE is not aligned to `int`");
  static_assert(offsetof(MPI_Status, MPI_TAG) % sizeof(int) == 0,
                "MPI_Status field MPI_TAG is not aligned to `int`");
  fprintf(file, "struct MPI_Status\n");
  for (size_t n = 0; n < sizeof(MPI_Status) / sizeof(int); ++n) {
    if (n == offsetof(MPI_Status, MPI_ERROR) / sizeof(int))
      fprintf(file, "    MPI_ERROR::Cint\n");
    else if (n == offsetof(MPI_Status, MPI_SOURCE) / sizeof(int))
      fprintf(file, "    MPI_SOURCE::Cint\n");
    else if (n == offsetof(MPI_Status, MPI_TAG) / sizeof(int))
      fprintf(file, "    MPI_TAG::Cint\n");
    else
      fprintf(file, "    private%zu::Cint\n", n);
  }
  fprintf(file, "end\n");
  fprintf(file, "\n");
  fprintf(file, "# Opaque handles:\n");
  fprintf(file, "const MPI_Comm = UInt%zu\n", 8 * sizeof(MPI_Comm));
  fprintf(file, "const MPI_Datatype = UInt%zu\n", 8 * sizeof(MPI_Datatype));
  fprintf(file, "const MPI_Errhandler = UInt%zu\n", 8 * sizeof(MPI_Errhandler));
  fprintf(file, "const MPI_File = UInt%zu\n", 8 * sizeof(MPI_File));
  fprintf(file, "const MPI_Group = UInt%zu\n", 8 * sizeof(MPI_Group));
  fprintf(file, "const MPI_Info = UInt%zu\n", 8 * sizeof(MPI_Info));
  fprintf(file, "const MPI_Message = UInt%zu\n", 8 * sizeof(MPI_Message));
  fprintf(file, "const MPI_Op = UInt%zu\n", 8 * sizeof(MPI_Op));
  fprintf(file, "const MPI_Request = UInt%zu\n", 8 * sizeof(MPI_Request));
  fprintf(file, "const MPI_Win = UInt%zu\n", 8 * sizeof(MPI_Win));
  fprintf(file, "\n");
  fprintf(file, "# Function pointers:\n");
  fprintf(file, "const MPI_Comm_copy_attr_function = Ptr{Cvoid}\n");
  fprintf(file, "const MPI_Comm_delete_attr_function = Ptr{Cvoid}\n");
  fprintf(file, "const MPI_Comm_errhandler_function = Ptr{Cvoid}\n");
  fprintf(file,
          "const MPI_Comm_errhandler_fn = MPI_Comm_errhandler_function\n");
  fprintf(file, "const MPI_Copy_function = MPI_Comm_copy_attr_function\n");
  fprintf(file, "const MPI_Datarep_conversion_function = Ptr{Cvoid}\n");
  fprintf(file, "const MPI_Datarep_extent_function = Ptr{Cvoid}\n");
  fprintf(file, "const MPI_Delete_function = Ptr{Cvoid}\n");
  fprintf(file, "const MPI_File_errhandler_function = Ptr{Cvoid}\n");
  fprintf(file, "const MPI_File_errhandler_fn = Ptr{Cvoid}\n");
  fprintf(file, "const MPI_Grequest_cancel_function = Ptr{Cvoid}\n");
  fprintf(file, "const MPI_Grequest_free_function = Ptr{Cvoid}\n");
  fprintf(file, "const MPI_Grequest_query_function = Ptr{Cvoid}\n");
  fprintf(file, "const MPI_Type_copy_attr_function = Ptr{Cvoid}\n");
  fprintf(file, "const MPI_Type_delete_attr_function = Ptr{Cvoid}\n");
  fprintf(file, "const MPI_User_function = Ptr{Cvoid}\n");
  fprintf(file, "const MPI_Win_copy_attr_function = Ptr{Cvoid}\n");
  fprintf(file, "const MPI_Win_delete_attr_function = Ptr{Cvoid}\n");
  fprintf(file, "const MPI_Win_errhandler_function = Ptr{Cvoid}\n");
  fprintf(file, "const MPI_Win_errhandler_fn = MPI_Win_errhandler_function\n");

  fclose(file);

  MPI_Finalize();
  return 0;
}
