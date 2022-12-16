# WARNING: this signature file for MPICH_jll has been auto-generated, please edit MPI.jl/gen/src/MPIgenerator.jl instead !

"""
    MPIR_Dup_fn(oldcomm, keyval, extra_state, attribute_val_in, attribute_val_out, flag)

$(_doc_external(:MPIR_Dup_fn))
"""
function MPIR_Dup_fn(oldcomm, keyval, extra_state, attribute_val_in, attribute_val_out, flag)
    @mpichk ccall((:MPIR_Dup_fn, libmpi), Cint, (MPI_Comm, Cint, MPIPtr, MPIPtr, MPIPtr, Ptr{Cint}), oldcomm, keyval, extra_state, attribute_val_in, attribute_val_out, flag)
end

"""
    MPI_Wait(request, status)

$(_doc_external(:MPI_Wait))
"""
function MPI_Wait(request, status)
    @mpichk ccall((:MPI_Wait, libmpi), Cint, (Ptr{MPI_Request}, Ptr{MPI_Status}), request, status)
end

"""
    MPI_Test(request, flag, status)

$(_doc_external(:MPI_Test))
"""
function MPI_Test(request, flag, status)
    @mpichk ccall((:MPI_Test, libmpi), Cint, (Ptr{MPI_Request}, Ptr{Cint}, Ptr{MPI_Status}), request, flag, status)
end

"""
    PMPI_Wait(request, status)

$(_doc_external(:PMPI_Wait))
"""
function PMPI_Wait(request, status)
    @mpichk ccall((:PMPI_Wait, libmpi), Cint, (Ptr{MPI_Request}, Ptr{MPI_Status}), request, status)
end

"""
    PMPI_Test(request, flag, status)

$(_doc_external(:PMPI_Test))
"""
function PMPI_Test(request, flag, status)
    @mpichk ccall((:PMPI_Test, libmpi), Cint, (Ptr{MPI_Request}, Ptr{Cint}, Ptr{MPI_Status}), request, flag, status)
end

"""
    MPI_Status_c2f(c_status, f_status)

$(_doc_external(:MPI_Status_c2f))
"""
function MPI_Status_c2f(c_status, f_status)
    @mpichk ccall((:MPI_Status_c2f, libmpi), Cint, (Ptr{MPI_Status}, Ptr{MPI_Fint}), c_status, f_status)
end

"""
    MPI_Status_f2c(f_status, c_status)

$(_doc_external(:MPI_Status_f2c))
"""
function MPI_Status_f2c(f_status, c_status)
    @mpichk ccall((:MPI_Status_f2c, libmpi), Cint, (Ptr{MPI_Fint}, Ptr{MPI_Status}), f_status, c_status)
end

"""
    MPI_Status_f082c(f08_status, c_status)

$(_doc_external(:MPI_Status_f082c))
"""
function MPI_Status_f082c(f08_status, c_status)
    @mpichk ccall((:MPI_Status_f082c, libmpi), Cint, (Ptr{MPI_F08_status}, Ptr{MPI_Status}), f08_status, c_status)
end

"""
    MPI_Status_f082f(f08_status, f_status)

$(_doc_external(:MPI_Status_f082f))
"""
function MPI_Status_f082f(f08_status, f_status)
    @mpichk ccall((:MPI_Status_f082f, libmpi), Cint, (Ptr{MPI_F08_status}, Ptr{MPI_Fint}), f08_status, f_status)
end

"""
    MPI_Type_create_f90_integer(r, newtype)

$(_doc_external(:MPI_Type_create_f90_integer))
"""
function MPI_Type_create_f90_integer(r, newtype)
    @mpichk ccall((:MPI_Type_create_f90_integer, libmpi), Cint, (Cint, Ptr{MPI_Datatype}), r, newtype)
end

"""
    MPI_Type_create_f90_real(p, r, newtype)

$(_doc_external(:MPI_Type_create_f90_real))
"""
function MPI_Type_create_f90_real(p, r, newtype)
    @mpichk ccall((:MPI_Type_create_f90_real, libmpi), Cint, (Cint, Cint, Ptr{MPI_Datatype}), p, r, newtype)
end

"""
    MPI_Type_create_f90_complex(p, r, newtype)

$(_doc_external(:MPI_Type_create_f90_complex))
"""
function MPI_Type_create_f90_complex(p, r, newtype)
    @mpichk ccall((:MPI_Type_create_f90_complex, libmpi), Cint, (Cint, Cint, Ptr{MPI_Datatype}), p, r, newtype)
end

"""
    MPI_Attr_delete(comm, keyval)

$(_doc_external(:MPI_Attr_delete))
"""
function MPI_Attr_delete(comm, keyval)
    @mpichk ccall((:MPI_Attr_delete, libmpi), Cint, (MPI_Comm, Cint), comm, keyval)
end

"""
    MPI_Attr_get(comm, keyval, attribute_val, flag)

$(_doc_external(:MPI_Attr_get))
"""
function MPI_Attr_get(comm, keyval, attribute_val, flag)
    @mpichk ccall((:MPI_Attr_get, libmpi), Cint, (MPI_Comm, Cint, MPIPtr, Ptr{Cint}), comm, keyval, attribute_val, flag)
end

"""
    MPI_Attr_put(comm, keyval, attribute_val)

$(_doc_external(:MPI_Attr_put))
"""
function MPI_Attr_put(comm, keyval, attribute_val)
    @mpichk ccall((:MPI_Attr_put, libmpi), Cint, (MPI_Comm, Cint, MPIPtr), comm, keyval, attribute_val)
end

"""
    MPI_Comm_create_keyval(comm_copy_attr_fn, comm_delete_attr_fn, comm_keyval, extra_state)

$(_doc_external(:MPI_Comm_create_keyval))
"""
function MPI_Comm_create_keyval(comm_copy_attr_fn, comm_delete_attr_fn, comm_keyval, extra_state)
    @mpichk ccall((:MPI_Comm_create_keyval, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{Cint}, MPIPtr), comm_copy_attr_fn, comm_delete_attr_fn, comm_keyval, extra_state)
end

"""
    MPI_Comm_delete_attr(comm, comm_keyval)

$(_doc_external(:MPI_Comm_delete_attr))
"""
function MPI_Comm_delete_attr(comm, comm_keyval)
    @mpichk ccall((:MPI_Comm_delete_attr, libmpi), Cint, (MPI_Comm, Cint), comm, comm_keyval)
end

"""
    MPI_Comm_free_keyval(comm_keyval)

$(_doc_external(:MPI_Comm_free_keyval))
"""
function MPI_Comm_free_keyval(comm_keyval)
    @mpichk ccall((:MPI_Comm_free_keyval, libmpi), Cint, (Ptr{Cint},), comm_keyval)
end

"""
    MPI_Comm_get_attr(comm, comm_keyval, attribute_val, flag)

$(_doc_external(:MPI_Comm_get_attr))
"""
function MPI_Comm_get_attr(comm, comm_keyval, attribute_val, flag)
    @mpichk ccall((:MPI_Comm_get_attr, libmpi), Cint, (MPI_Comm, Cint, MPIPtr, Ptr{Cint}), comm, comm_keyval, attribute_val, flag)
end

"""
    MPI_Comm_set_attr(comm, comm_keyval, attribute_val)

$(_doc_external(:MPI_Comm_set_attr))
"""
function MPI_Comm_set_attr(comm, comm_keyval, attribute_val)
    @mpichk ccall((:MPI_Comm_set_attr, libmpi), Cint, (MPI_Comm, Cint, MPIPtr), comm, comm_keyval, attribute_val)
end

"""
    MPI_Keyval_create(copy_fn, delete_fn, keyval, extra_state)

$(_doc_external(:MPI_Keyval_create))
"""
function MPI_Keyval_create(copy_fn, delete_fn, keyval, extra_state)
    @mpichk ccall((:MPI_Keyval_create, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{Cint}, MPIPtr), copy_fn, delete_fn, keyval, extra_state)
end

"""
    MPI_Keyval_free(keyval)

$(_doc_external(:MPI_Keyval_free))
"""
function MPI_Keyval_free(keyval)
    @mpichk ccall((:MPI_Keyval_free, libmpi), Cint, (Ptr{Cint},), keyval)
end

"""
    MPI_Type_create_keyval(type_copy_attr_fn, type_delete_attr_fn, type_keyval, extra_state)

$(_doc_external(:MPI_Type_create_keyval))
"""
function MPI_Type_create_keyval(type_copy_attr_fn, type_delete_attr_fn, type_keyval, extra_state)
    @mpichk ccall((:MPI_Type_create_keyval, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{Cint}, MPIPtr), type_copy_attr_fn, type_delete_attr_fn, type_keyval, extra_state)
end

"""
    MPI_Type_delete_attr(datatype, type_keyval)

$(_doc_external(:MPI_Type_delete_attr))
"""
function MPI_Type_delete_attr(datatype, type_keyval)
    @mpichk ccall((:MPI_Type_delete_attr, libmpi), Cint, (MPI_Datatype, Cint), datatype, type_keyval)
end

"""
    MPI_Type_free_keyval(type_keyval)

$(_doc_external(:MPI_Type_free_keyval))
"""
function MPI_Type_free_keyval(type_keyval)
    @mpichk ccall((:MPI_Type_free_keyval, libmpi), Cint, (Ptr{Cint},), type_keyval)
end

"""
    MPI_Type_get_attr(datatype, type_keyval, attribute_val, flag)

$(_doc_external(:MPI_Type_get_attr))
"""
function MPI_Type_get_attr(datatype, type_keyval, attribute_val, flag)
    @mpichk ccall((:MPI_Type_get_attr, libmpi), Cint, (MPI_Datatype, Cint, MPIPtr, Ptr{Cint}), datatype, type_keyval, attribute_val, flag)
end

"""
    MPI_Type_set_attr(datatype, type_keyval, attribute_val)

$(_doc_external(:MPI_Type_set_attr))
"""
function MPI_Type_set_attr(datatype, type_keyval, attribute_val)
    @mpichk ccall((:MPI_Type_set_attr, libmpi), Cint, (MPI_Datatype, Cint, MPIPtr), datatype, type_keyval, attribute_val)
end

"""
    MPI_Win_create_keyval(win_copy_attr_fn, win_delete_attr_fn, win_keyval, extra_state)

$(_doc_external(:MPI_Win_create_keyval))
"""
function MPI_Win_create_keyval(win_copy_attr_fn, win_delete_attr_fn, win_keyval, extra_state)
    @mpichk ccall((:MPI_Win_create_keyval, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{Cint}, MPIPtr), win_copy_attr_fn, win_delete_attr_fn, win_keyval, extra_state)
end

"""
    MPI_Win_delete_attr(win, win_keyval)

$(_doc_external(:MPI_Win_delete_attr))
"""
function MPI_Win_delete_attr(win, win_keyval)
    @mpichk ccall((:MPI_Win_delete_attr, libmpi), Cint, (MPI_Win, Cint), win, win_keyval)
end

"""
    MPI_Win_free_keyval(win_keyval)

$(_doc_external(:MPI_Win_free_keyval))
"""
function MPI_Win_free_keyval(win_keyval)
    @mpichk ccall((:MPI_Win_free_keyval, libmpi), Cint, (Ptr{Cint},), win_keyval)
end

"""
    MPI_Win_get_attr(win, win_keyval, attribute_val, flag)

$(_doc_external(:MPI_Win_get_attr))
"""
function MPI_Win_get_attr(win, win_keyval, attribute_val, flag)
    @mpichk ccall((:MPI_Win_get_attr, libmpi), Cint, (MPI_Win, Cint, MPIPtr, Ptr{Cint}), win, win_keyval, attribute_val, flag)
end

"""
    MPI_Win_set_attr(win, win_keyval, attribute_val)

$(_doc_external(:MPI_Win_set_attr))
"""
function MPI_Win_set_attr(win, win_keyval, attribute_val)
    @mpichk ccall((:MPI_Win_set_attr, libmpi), Cint, (MPI_Win, Cint, MPIPtr), win, win_keyval, attribute_val)
end

"""
    MPI_Allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:MPI_Allgather))
"""
function MPI_Allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:MPI_Allgather, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

"""
    MPI_Allgather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:MPI_Allgather_init))
"""
function MPI_Allgather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Allgather_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    MPI_Allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)

$(_doc_external(:MPI_Allgatherv))
"""
function MPI_Allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    @mpichk ccall((:MPI_Allgatherv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

"""
    MPI_Allgatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)

$(_doc_external(:MPI_Allgatherv_init))
"""
function MPI_Allgatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Allgatherv_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
end

"""
    MPI_Allreduce(sendbuf, recvbuf, count, datatype, op, comm)

$(_doc_external(:MPI_Allreduce))
"""
function MPI_Allreduce(sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk ccall((:MPI_Allreduce, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

"""
    MPI_Allreduce_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)

$(_doc_external(:MPI_Allreduce_init))
"""
function MPI_Allreduce_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk ccall((:MPI_Allreduce_init, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

"""
    MPI_Alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:MPI_Alltoall))
"""
function MPI_Alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:MPI_Alltoall, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

"""
    MPI_Alltoall_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:MPI_Alltoall_init))
"""
function MPI_Alltoall_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Alltoall_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    MPI_Alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)

$(_doc_external(:MPI_Alltoallv))
"""
function MPI_Alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    @mpichk ccall((:MPI_Alltoallv, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

"""
    MPI_Alltoallv_init(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)

$(_doc_external(:MPI_Alltoallv_init))
"""
function MPI_Alltoallv_init(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Alltoallv_init, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
end

"""
    MPI_Alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)

$(_doc_external(:MPI_Alltoallw))
"""
function MPI_Alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    @mpichk ccall((:MPI_Alltoallw, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPI_Comm), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

"""
    MPI_Alltoallw_init(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)

$(_doc_external(:MPI_Alltoallw_init))
"""
function MPI_Alltoallw_init(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    @mpichk ccall((:MPI_Alltoallw_init, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
end

"""
    MPI_Barrier(comm)

$(_doc_external(:MPI_Barrier))
"""
function MPI_Barrier(comm)
    @mpichk ccall((:MPI_Barrier, libmpi), Cint, (MPI_Comm,), comm)
end

"""
    MPI_Barrier_init(comm, info, request)

$(_doc_external(:MPI_Barrier_init))
"""
function MPI_Barrier_init(comm, info, request)
    @mpichk ccall((:MPI_Barrier_init, libmpi), Cint, (MPI_Comm, MPI_Info, Ptr{MPI_Request}), comm, info, request)
end

"""
    MPI_Bcast(buffer, count, datatype, root, comm)

$(_doc_external(:MPI_Bcast))
"""
function MPI_Bcast(buffer, count, datatype, root, comm)
    @mpichk ccall((:MPI_Bcast, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm), buffer, count, datatype, root, comm)
end

"""
    MPI_Bcast_init(buffer, count, datatype, root, comm, info, request)

$(_doc_external(:MPI_Bcast_init))
"""
function MPI_Bcast_init(buffer, count, datatype, root, comm, info, request)
    @mpichk ccall((:MPI_Bcast_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), buffer, count, datatype, root, comm, info, request)
end

"""
    MPI_Exscan(sendbuf, recvbuf, count, datatype, op, comm)

$(_doc_external(:MPI_Exscan))
"""
function MPI_Exscan(sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk ccall((:MPI_Exscan, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

"""
    MPI_Exscan_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)

$(_doc_external(:MPI_Exscan_init))
"""
function MPI_Exscan_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk ccall((:MPI_Exscan_init, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

"""
    MPI_Gather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)

$(_doc_external(:MPI_Gather))
"""
function MPI_Gather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk ccall((:MPI_Gather, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

"""
    MPI_Gather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

$(_doc_external(:MPI_Gather_init))
"""
function MPI_Gather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk ccall((:MPI_Gather_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

"""
    MPI_Gatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)

$(_doc_external(:MPI_Gatherv))
"""
function MPI_Gatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
    @mpichk ccall((:MPI_Gatherv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
end

"""
    MPI_Gatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)

$(_doc_external(:MPI_Gatherv_init))
"""
function MPI_Gatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
    @mpichk ccall((:MPI_Gatherv_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
end

"""
    MPI_Iallgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:MPI_Iallgather))
"""
function MPI_Iallgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:MPI_Iallgather, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    MPI_Iallgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)

$(_doc_external(:MPI_Iallgatherv))
"""
function MPI_Iallgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    @mpichk ccall((:MPI_Iallgatherv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

"""
    MPI_Iallreduce(sendbuf, recvbuf, count, datatype, op, comm, request)

$(_doc_external(:MPI_Iallreduce))
"""
function MPI_Iallreduce(sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk ccall((:MPI_Iallreduce, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

"""
    MPI_Ialltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:MPI_Ialltoall))
"""
function MPI_Ialltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:MPI_Ialltoall, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    MPI_Ialltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)

$(_doc_external(:MPI_Ialltoallv))
"""
function MPI_Ialltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    @mpichk ccall((:MPI_Ialltoallv, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

"""
    MPI_Ialltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)

$(_doc_external(:MPI_Ialltoallw))
"""
function MPI_Ialltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    @mpichk ccall((:MPI_Ialltoallw, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

"""
    MPI_Ibarrier(comm, request)

$(_doc_external(:MPI_Ibarrier))
"""
function MPI_Ibarrier(comm, request)
    @mpichk ccall((:MPI_Ibarrier, libmpi), Cint, (MPI_Comm, Ptr{MPI_Request}), comm, request)
end

"""
    MPI_Ibcast(buffer, count, datatype, root, comm, request)

$(_doc_external(:MPI_Ibcast))
"""
function MPI_Ibcast(buffer, count, datatype, root, comm, request)
    @mpichk ccall((:MPI_Ibcast, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), buffer, count, datatype, root, comm, request)
end

"""
    MPI_Iexscan(sendbuf, recvbuf, count, datatype, op, comm, request)

$(_doc_external(:MPI_Iexscan))
"""
function MPI_Iexscan(sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk ccall((:MPI_Iexscan, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

"""
    MPI_Igather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

$(_doc_external(:MPI_Igather))
"""
function MPI_Igather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk ccall((:MPI_Igather, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

"""
    MPI_Igatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)

$(_doc_external(:MPI_Igatherv))
"""
function MPI_Igatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
    @mpichk ccall((:MPI_Igatherv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
end

"""
    MPI_Ineighbor_allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:MPI_Ineighbor_allgather))
"""
function MPI_Ineighbor_allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:MPI_Ineighbor_allgather, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    MPI_Ineighbor_allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)

$(_doc_external(:MPI_Ineighbor_allgatherv))
"""
function MPI_Ineighbor_allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    @mpichk ccall((:MPI_Ineighbor_allgatherv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

"""
    MPI_Ineighbor_alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:MPI_Ineighbor_alltoall))
"""
function MPI_Ineighbor_alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:MPI_Ineighbor_alltoall, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    MPI_Ineighbor_alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)

$(_doc_external(:MPI_Ineighbor_alltoallv))
"""
function MPI_Ineighbor_alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    @mpichk ccall((:MPI_Ineighbor_alltoallv, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

"""
    MPI_Ineighbor_alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)

$(_doc_external(:MPI_Ineighbor_alltoallw))
"""
function MPI_Ineighbor_alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    @mpichk ccall((:MPI_Ineighbor_alltoallw, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

"""
    MPI_Ireduce(sendbuf, recvbuf, count, datatype, op, root, comm, request)

$(_doc_external(:MPI_Ireduce))
"""
function MPI_Ireduce(sendbuf, recvbuf, count, datatype, op, root, comm, request)
    @mpichk ccall((:MPI_Ireduce, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, root, comm, request)
end

"""
    MPI_Ireduce_scatter(sendbuf, recvbuf, recvcounts, datatype, op, comm, request)

$(_doc_external(:MPI_Ireduce_scatter))
"""
function MPI_Ireduce_scatter(sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
    @mpichk ccall((:MPI_Ireduce_scatter, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{Cint}, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
end

"""
    MPI_Ireduce_scatter_block(sendbuf, recvbuf, recvcount, datatype, op, comm, request)

$(_doc_external(:MPI_Ireduce_scatter_block))
"""
function MPI_Ireduce_scatter_block(sendbuf, recvbuf, recvcount, datatype, op, comm, request)
    @mpichk ccall((:MPI_Ireduce_scatter_block, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, recvcount, datatype, op, comm, request)
end

"""
    MPI_Iscan(sendbuf, recvbuf, count, datatype, op, comm, request)

$(_doc_external(:MPI_Iscan))
"""
function MPI_Iscan(sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk ccall((:MPI_Iscan, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

"""
    MPI_Iscatter(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

$(_doc_external(:MPI_Iscatter))
"""
function MPI_Iscatter(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk ccall((:MPI_Iscatter, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

"""
    MPI_Iscatterv(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

$(_doc_external(:MPI_Iscatterv))
"""
function MPI_Iscatterv(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk ccall((:MPI_Iscatterv, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

"""
    MPI_Neighbor_allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:MPI_Neighbor_allgather))
"""
function MPI_Neighbor_allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:MPI_Neighbor_allgather, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm) v"3.0.0"
end

"""
    MPI_Neighbor_allgather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:MPI_Neighbor_allgather_init))
"""
function MPI_Neighbor_allgather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Neighbor_allgather_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    MPI_Neighbor_allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)

$(_doc_external(:MPI_Neighbor_allgatherv))
"""
function MPI_Neighbor_allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    @mpichk ccall((:MPI_Neighbor_allgatherv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm) v"3.0.0"
end

"""
    MPI_Neighbor_allgatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)

$(_doc_external(:MPI_Neighbor_allgatherv_init))
"""
function MPI_Neighbor_allgatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Neighbor_allgatherv_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
end

"""
    MPI_Neighbor_alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:MPI_Neighbor_alltoall))
"""
function MPI_Neighbor_alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:MPI_Neighbor_alltoall, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm) v"3.0.0"
end

"""
    MPI_Neighbor_alltoall_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:MPI_Neighbor_alltoall_init))
"""
function MPI_Neighbor_alltoall_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Neighbor_alltoall_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    MPI_Neighbor_alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)

$(_doc_external(:MPI_Neighbor_alltoallv))
"""
function MPI_Neighbor_alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    @mpichk ccall((:MPI_Neighbor_alltoallv, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm) v"3.0.0"
end

"""
    MPI_Neighbor_alltoallv_init(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)

$(_doc_external(:MPI_Neighbor_alltoallv_init))
"""
function MPI_Neighbor_alltoallv_init(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Neighbor_alltoallv_init, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
end

"""
    MPI_Neighbor_alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)

$(_doc_external(:MPI_Neighbor_alltoallw))
"""
function MPI_Neighbor_alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    @mpichk ccall((:MPI_Neighbor_alltoallw, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

"""
    MPI_Neighbor_alltoallw_init(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)

$(_doc_external(:MPI_Neighbor_alltoallw_init))
"""
function MPI_Neighbor_alltoallw_init(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    @mpichk ccall((:MPI_Neighbor_alltoallw_init, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
end

"""
    MPI_Reduce(sendbuf, recvbuf, count, datatype, op, root, comm)

$(_doc_external(:MPI_Reduce))
"""
function MPI_Reduce(sendbuf, recvbuf, count, datatype, op, root, comm)
    @mpichk ccall((:MPI_Reduce, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm), sendbuf, recvbuf, count, datatype, op, root, comm)
end

"""
    MPI_Reduce_init(sendbuf, recvbuf, count, datatype, op, root, comm, info, request)

$(_doc_external(:MPI_Reduce_init))
"""
function MPI_Reduce_init(sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
    @mpichk ccall((:MPI_Reduce_init, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
end

"""
    MPI_Reduce_local(inbuf, inoutbuf, count, datatype, op)

$(_doc_external(:MPI_Reduce_local))
"""
function MPI_Reduce_local(inbuf, inoutbuf, count, datatype, op)
    @mpichk ccall((:MPI_Reduce_local, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op), inbuf, inoutbuf, count, datatype, op)
end

"""
    MPI_Reduce_scatter(sendbuf, recvbuf, recvcounts, datatype, op, comm)

$(_doc_external(:MPI_Reduce_scatter))
"""
function MPI_Reduce_scatter(sendbuf, recvbuf, recvcounts, datatype, op, comm)
    @mpichk ccall((:MPI_Reduce_scatter, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{Cint}, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, recvcounts, datatype, op, comm)
end

"""
    MPI_Reduce_scatter_block(sendbuf, recvbuf, recvcount, datatype, op, comm)

$(_doc_external(:MPI_Reduce_scatter_block))
"""
function MPI_Reduce_scatter_block(sendbuf, recvbuf, recvcount, datatype, op, comm)
    @mpichk ccall((:MPI_Reduce_scatter_block, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, recvcount, datatype, op, comm)
end

"""
    MPI_Reduce_scatter_block_init(sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)

$(_doc_external(:MPI_Reduce_scatter_block_init))
"""
function MPI_Reduce_scatter_block_init(sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
    @mpichk ccall((:MPI_Reduce_scatter_block_init, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
end

"""
    MPI_Reduce_scatter_init(sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)

$(_doc_external(:MPI_Reduce_scatter_init))
"""
function MPI_Reduce_scatter_init(sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
    @mpichk ccall((:MPI_Reduce_scatter_init, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{Cint}, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
end

"""
    MPI_Scan(sendbuf, recvbuf, count, datatype, op, comm)

$(_doc_external(:MPI_Scan))
"""
function MPI_Scan(sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk ccall((:MPI_Scan, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

"""
    MPI_Scan_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)

$(_doc_external(:MPI_Scan_init))
"""
function MPI_Scan_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk ccall((:MPI_Scan_init, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

"""
    MPI_Scatter(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)

$(_doc_external(:MPI_Scatter))
"""
function MPI_Scatter(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk ccall((:MPI_Scatter, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

"""
    MPI_Scatter_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

$(_doc_external(:MPI_Scatter_init))
"""
function MPI_Scatter_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk ccall((:MPI_Scatter_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

"""
    MPI_Scatterv(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)

$(_doc_external(:MPI_Scatterv))
"""
function MPI_Scatterv(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk ccall((:MPI_Scatterv, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

"""
    MPI_Scatterv_init(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

$(_doc_external(:MPI_Scatterv_init))
"""
function MPI_Scatterv_init(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk ccall((:MPI_Scatterv_init, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

"""
    MPI_Comm_compare(comm1, comm2, result)

$(_doc_external(:MPI_Comm_compare))
"""
function MPI_Comm_compare(comm1, comm2, result)
    @mpichk ccall((:MPI_Comm_compare, libmpi), Cint, (MPI_Comm, MPI_Comm, Ptr{Cint}), comm1, comm2, result)
end

"""
    MPI_Comm_create(comm, group, newcomm)

$(_doc_external(:MPI_Comm_create))
"""
function MPI_Comm_create(comm, group, newcomm)
    @mpichk ccall((:MPI_Comm_create, libmpi), Cint, (MPI_Comm, MPI_Group, Ptr{MPI_Comm}), comm, group, newcomm)
end

"""
    MPI_Comm_create_group(comm, group, tag, newcomm)

$(_doc_external(:MPI_Comm_create_group))
"""
function MPI_Comm_create_group(comm, group, tag, newcomm)
    @mpichk ccall((:MPI_Comm_create_group, libmpi), Cint, (MPI_Comm, MPI_Group, Cint, Ptr{MPI_Comm}), comm, group, tag, newcomm)
end

"""
    MPI_Comm_dup(comm, newcomm)

$(_doc_external(:MPI_Comm_dup))
"""
function MPI_Comm_dup(comm, newcomm)
    @mpichk ccall((:MPI_Comm_dup, libmpi), Cint, (MPI_Comm, Ptr{MPI_Comm}), comm, newcomm)
end

"""
    MPI_Comm_dup_with_info(comm, info, newcomm)

$(_doc_external(:MPI_Comm_dup_with_info))
"""
function MPI_Comm_dup_with_info(comm, info, newcomm)
    @mpichk ccall((:MPI_Comm_dup_with_info, libmpi), Cint, (MPI_Comm, MPI_Info, Ptr{MPI_Comm}), comm, info, newcomm)
end

"""
    MPI_Comm_free(comm)

$(_doc_external(:MPI_Comm_free))
"""
function MPI_Comm_free(comm)
    @mpichk ccall((:MPI_Comm_free, libmpi), Cint, (Ptr{MPI_Comm},), comm)
end

"""
    MPI_Comm_get_info(comm, info_used)

$(_doc_external(:MPI_Comm_get_info))
"""
function MPI_Comm_get_info(comm, info_used)
    @mpichk ccall((:MPI_Comm_get_info, libmpi), Cint, (MPI_Comm, Ptr{MPI_Info}), comm, info_used)
end

"""
    MPI_Comm_get_name(comm, comm_name, resultlen)

$(_doc_external(:MPI_Comm_get_name))
"""
function MPI_Comm_get_name(comm, comm_name, resultlen)
    @mpichk ccall((:MPI_Comm_get_name, libmpi), Cint, (MPI_Comm, Ptr{Cchar}, Ptr{Cint}), comm, comm_name, resultlen)
end

"""
    MPI_Comm_group(comm, group)

$(_doc_external(:MPI_Comm_group))
"""
function MPI_Comm_group(comm, group)
    @mpichk ccall((:MPI_Comm_group, libmpi), Cint, (MPI_Comm, Ptr{MPI_Group}), comm, group)
end

"""
    MPI_Comm_idup(comm, newcomm, request)

$(_doc_external(:MPI_Comm_idup))
"""
function MPI_Comm_idup(comm, newcomm, request)
    @mpichk ccall((:MPI_Comm_idup, libmpi), Cint, (MPI_Comm, Ptr{MPI_Comm}, Ptr{MPI_Request}), comm, newcomm, request)
end

"""
    MPI_Comm_idup_with_info(comm, info, newcomm, request)

$(_doc_external(:MPI_Comm_idup_with_info))
"""
function MPI_Comm_idup_with_info(comm, info, newcomm, request)
    @mpichk ccall((:MPI_Comm_idup_with_info, libmpi), Cint, (MPI_Comm, MPI_Info, Ptr{MPI_Comm}, Ptr{MPI_Request}), comm, info, newcomm, request)
end

"""
    MPI_Comm_rank(comm, rank)

$(_doc_external(:MPI_Comm_rank))
"""
function MPI_Comm_rank(comm, rank)
    @mpichk ccall((:MPI_Comm_rank, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, rank)
end

"""
    MPI_Comm_remote_group(comm, group)

$(_doc_external(:MPI_Comm_remote_group))
"""
function MPI_Comm_remote_group(comm, group)
    @mpichk ccall((:MPI_Comm_remote_group, libmpi), Cint, (MPI_Comm, Ptr{MPI_Group}), comm, group)
end

"""
    MPI_Comm_remote_size(comm, size)

$(_doc_external(:MPI_Comm_remote_size))
"""
function MPI_Comm_remote_size(comm, size)
    @mpichk ccall((:MPI_Comm_remote_size, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, size)
end

"""
    MPI_Comm_set_info(comm, info)

$(_doc_external(:MPI_Comm_set_info))
"""
function MPI_Comm_set_info(comm, info)
    @mpichk ccall((:MPI_Comm_set_info, libmpi), Cint, (MPI_Comm, MPI_Info), comm, info)
end

"""
    MPI_Comm_set_name(comm, comm_name)

$(_doc_external(:MPI_Comm_set_name))
"""
function MPI_Comm_set_name(comm, comm_name)
    @mpichk ccall((:MPI_Comm_set_name, libmpi), Cint, (MPI_Comm, Ptr{Cchar}), comm, comm_name)
end

"""
    MPI_Comm_size(comm, size)

$(_doc_external(:MPI_Comm_size))
"""
function MPI_Comm_size(comm, size)
    @mpichk ccall((:MPI_Comm_size, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, size)
end

"""
    MPI_Comm_split(comm, color, key, newcomm)

$(_doc_external(:MPI_Comm_split))
"""
function MPI_Comm_split(comm, color, key, newcomm)
    @mpichk ccall((:MPI_Comm_split, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{MPI_Comm}), comm, color, key, newcomm)
end

"""
    MPI_Comm_split_type(comm, split_type, key, info, newcomm)

$(_doc_external(:MPI_Comm_split_type))
"""
function MPI_Comm_split_type(comm, split_type, key, info, newcomm)
    @mpichk ccall((:MPI_Comm_split_type, libmpi), Cint, (MPI_Comm, Cint, Cint, MPI_Info, Ptr{MPI_Comm}), comm, split_type, key, info, newcomm)
end

"""
    MPI_Comm_test_inter(comm, flag)

$(_doc_external(:MPI_Comm_test_inter))
"""
function MPI_Comm_test_inter(comm, flag)
    @mpichk ccall((:MPI_Comm_test_inter, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, flag)
end

"""
    MPI_Intercomm_create(local_comm, local_leader, peer_comm, remote_leader, tag, newintercomm)

$(_doc_external(:MPI_Intercomm_create))
"""
function MPI_Intercomm_create(local_comm, local_leader, peer_comm, remote_leader, tag, newintercomm)
    @mpichk ccall((:MPI_Intercomm_create, libmpi), Cint, (MPI_Comm, Cint, MPI_Comm, Cint, Cint, Ptr{MPI_Comm}), local_comm, local_leader, peer_comm, remote_leader, tag, newintercomm)
end

"""
    MPI_Intercomm_create_from_groups(local_group, local_leader, remote_group, remote_leader, stringtag, info, errhandler, newintercomm)

$(_doc_external(:MPI_Intercomm_create_from_groups))
"""
function MPI_Intercomm_create_from_groups(local_group, local_leader, remote_group, remote_leader, stringtag, info, errhandler, newintercomm)
    @mpichk ccall((:MPI_Intercomm_create_from_groups, libmpi), Cint, (MPI_Group, Cint, MPI_Group, Cint, Ptr{Cchar}, MPI_Info, MPI_Errhandler, Ptr{MPI_Comm}), local_group, local_leader, remote_group, remote_leader, stringtag, info, errhandler, newintercomm)
end

"""
    MPI_Intercomm_merge(intercomm, high, newintracomm)

$(_doc_external(:MPI_Intercomm_merge))
"""
function MPI_Intercomm_merge(intercomm, high, newintracomm)
    @mpichk ccall((:MPI_Intercomm_merge, libmpi), Cint, (MPI_Comm, Cint, Ptr{MPI_Comm}), intercomm, high, newintracomm)
end

"""
    MPIX_Comm_revoke(comm)

$(_doc_external(:MPIX_Comm_revoke))
"""
function MPIX_Comm_revoke(comm)
    @mpichk ccall((:MPIX_Comm_revoke, libmpi), Cint, (MPI_Comm,), comm)
end

"""
    MPIX_Comm_shrink(comm, newcomm)

$(_doc_external(:MPIX_Comm_shrink))
"""
function MPIX_Comm_shrink(comm, newcomm)
    @mpichk ccall((:MPIX_Comm_shrink, libmpi), Cint, (MPI_Comm, Ptr{MPI_Comm}), comm, newcomm)
end

"""
    MPIX_Comm_failure_ack(comm)

$(_doc_external(:MPIX_Comm_failure_ack))
"""
function MPIX_Comm_failure_ack(comm)
    @mpichk ccall((:MPIX_Comm_failure_ack, libmpi), Cint, (MPI_Comm,), comm)
end

"""
    MPIX_Comm_failure_get_acked(comm, failedgrp)

$(_doc_external(:MPIX_Comm_failure_get_acked))
"""
function MPIX_Comm_failure_get_acked(comm, failedgrp)
    @mpichk ccall((:MPIX_Comm_failure_get_acked, libmpi), Cint, (MPI_Comm, Ptr{MPI_Group}), comm, failedgrp)
end

"""
    MPIX_Comm_agree(comm, flag)

$(_doc_external(:MPIX_Comm_agree))
"""
function MPIX_Comm_agree(comm, flag)
    @mpichk ccall((:MPIX_Comm_agree, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, flag)
end

"""
    MPI_Get_address(location, address)

$(_doc_external(:MPI_Get_address))
"""
function MPI_Get_address(location, address)
    @mpichk ccall((:MPI_Get_address, libmpi), Cint, (MPIPtr, Ptr{MPI_Aint}), location, address)
end

"""
    MPI_Get_count(status, datatype, count)

$(_doc_external(:MPI_Get_count))
"""
function MPI_Get_count(status, datatype, count)
    @mpichk ccall((:MPI_Get_count, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Ptr{Cint}), status, datatype, count)
end

"""
    MPI_Get_elements(status, datatype, count)

$(_doc_external(:MPI_Get_elements))
"""
function MPI_Get_elements(status, datatype, count)
    @mpichk ccall((:MPI_Get_elements, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Ptr{Cint}), status, datatype, count)
end

"""
    MPI_Get_elements_x(status, datatype, count)

$(_doc_external(:MPI_Get_elements_x))
"""
function MPI_Get_elements_x(status, datatype, count)
    @mpichk ccall((:MPI_Get_elements_x, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Ptr{MPI_Count}), status, datatype, count)
end

"""
    MPI_Pack(inbuf, incount, datatype, outbuf, outsize, position, comm)

$(_doc_external(:MPI_Pack))
"""
function MPI_Pack(inbuf, incount, datatype, outbuf, outsize, position, comm)
    @mpichk ccall((:MPI_Pack, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, Ptr{Cint}, MPI_Comm), inbuf, incount, datatype, outbuf, outsize, position, comm)
end

"""
    MPI_Pack_external(datarep, inbuf, incount, datatype, outbuf, outsize, position)

$(_doc_external(:MPI_Pack_external))
"""
function MPI_Pack_external(datarep, inbuf, incount, datatype, outbuf, outsize, position)
    @mpichk ccall((:MPI_Pack_external, libmpi), Cint, (Ptr{Cchar}, MPIPtr, Cint, MPI_Datatype, MPIPtr, MPI_Aint, Ptr{MPI_Aint}), datarep, inbuf, incount, datatype, outbuf, outsize, position)
end

"""
    MPI_Pack_external_size(datarep, incount, datatype, size)

$(_doc_external(:MPI_Pack_external_size))
"""
function MPI_Pack_external_size(datarep, incount, datatype, size)
    @mpichk ccall((:MPI_Pack_external_size, libmpi), Cint, (Ptr{Cchar}, Cint, MPI_Datatype, Ptr{MPI_Aint}), datarep, incount, datatype, size)
end

"""
    MPI_Pack_size(incount, datatype, comm, size)

$(_doc_external(:MPI_Pack_size))
"""
function MPI_Pack_size(incount, datatype, comm, size)
    @mpichk ccall((:MPI_Pack_size, libmpi), Cint, (Cint, MPI_Datatype, MPI_Comm, Ptr{Cint}), incount, datatype, comm, size)
end

"""
    MPI_Status_set_elements(status, datatype, count)

$(_doc_external(:MPI_Status_set_elements))
"""
function MPI_Status_set_elements(status, datatype, count)
    @mpichk ccall((:MPI_Status_set_elements, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Cint), status, datatype, count)
end

"""
    MPI_Status_set_elements_x(status, datatype, count)

$(_doc_external(:MPI_Status_set_elements_x))
"""
function MPI_Status_set_elements_x(status, datatype, count)
    @mpichk ccall((:MPI_Status_set_elements_x, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, MPI_Count), status, datatype, count)
end

"""
    MPI_Type_commit(datatype)

$(_doc_external(:MPI_Type_commit))
"""
function MPI_Type_commit(datatype)
    @mpichk ccall((:MPI_Type_commit, libmpi), Cint, (Ptr{MPI_Datatype},), datatype)
end

"""
    MPI_Type_contiguous(count, oldtype, newtype)

$(_doc_external(:MPI_Type_contiguous))
"""
function MPI_Type_contiguous(count, oldtype, newtype)
    @mpichk ccall((:MPI_Type_contiguous, libmpi), Cint, (Cint, MPI_Datatype, Ptr{MPI_Datatype}), count, oldtype, newtype)
end

"""
    MPI_Type_create_darray(size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)

$(_doc_external(:MPI_Type_create_darray))
"""
function MPI_Type_create_darray(size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
    @mpichk ccall((:MPI_Type_create_darray, libmpi), Cint, (Cint, Cint, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
end

"""
    MPI_Type_create_hindexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)

$(_doc_external(:MPI_Type_create_hindexed))
"""
function MPI_Type_create_hindexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:MPI_Type_create_hindexed, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

"""
    MPI_Type_create_hindexed_block(count, blocklength, array_of_displacements, oldtype, newtype)

$(_doc_external(:MPI_Type_create_hindexed_block))
"""
function MPI_Type_create_hindexed_block(count, blocklength, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:MPI_Type_create_hindexed_block, libmpi), Cint, (Cint, Cint, Ptr{MPI_Aint}, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, array_of_displacements, oldtype, newtype)
end

"""
    MPI_Type_create_hvector(count, blocklength, stride, oldtype, newtype)

$(_doc_external(:MPI_Type_create_hvector))
"""
function MPI_Type_create_hvector(count, blocklength, stride, oldtype, newtype)
    @mpichk ccall((:MPI_Type_create_hvector, libmpi), Cint, (Cint, Cint, MPI_Aint, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

"""
    MPI_Type_create_indexed_block(count, blocklength, array_of_displacements, oldtype, newtype)

$(_doc_external(:MPI_Type_create_indexed_block))
"""
function MPI_Type_create_indexed_block(count, blocklength, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:MPI_Type_create_indexed_block, libmpi), Cint, (Cint, Cint, Ptr{Cint}, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, array_of_displacements, oldtype, newtype)
end

"""
    MPI_Type_create_resized(oldtype, lb, extent, newtype)

$(_doc_external(:MPI_Type_create_resized))
"""
function MPI_Type_create_resized(oldtype, lb, extent, newtype)
    @mpichk ccall((:MPI_Type_create_resized, libmpi), Cint, (MPI_Datatype, MPI_Aint, MPI_Aint, Ptr{MPI_Datatype}), oldtype, lb, extent, newtype)
end

"""
    MPI_Type_create_struct(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)

$(_doc_external(:MPI_Type_create_struct))
"""
function MPI_Type_create_struct(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
    @mpichk ccall((:MPI_Type_create_struct, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
end

"""
    MPI_Type_create_subarray(ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)

$(_doc_external(:MPI_Type_create_subarray))
"""
function MPI_Type_create_subarray(ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
    @mpichk ccall((:MPI_Type_create_subarray, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
end

"""
    MPI_Type_dup(oldtype, newtype)

$(_doc_external(:MPI_Type_dup))
"""
function MPI_Type_dup(oldtype, newtype)
    @mpichk ccall((:MPI_Type_dup, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Datatype}), oldtype, newtype)
end

"""
    MPI_Type_free(datatype)

$(_doc_external(:MPI_Type_free))
"""
function MPI_Type_free(datatype)
    @mpichk ccall((:MPI_Type_free, libmpi), Cint, (Ptr{MPI_Datatype},), datatype)
end

"""
    MPI_Type_get_contents(datatype, max_integers, max_addresses, max_datatypes, array_of_integers, array_of_addresses, array_of_datatypes)

$(_doc_external(:MPI_Type_get_contents))
"""
function MPI_Type_get_contents(datatype, max_integers, max_addresses, max_datatypes, array_of_integers, array_of_addresses, array_of_datatypes)
    @mpichk ccall((:MPI_Type_get_contents, libmpi), Cint, (MPI_Datatype, Cint, Cint, Cint, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}), datatype, max_integers, max_addresses, max_datatypes, array_of_integers, array_of_addresses, array_of_datatypes)
end

"""
    MPI_Type_get_envelope(datatype, num_integers, num_addresses, num_datatypes, combiner)

$(_doc_external(:MPI_Type_get_envelope))
"""
function MPI_Type_get_envelope(datatype, num_integers, num_addresses, num_datatypes, combiner)
    @mpichk ccall((:MPI_Type_get_envelope, libmpi), Cint, (MPI_Datatype, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), datatype, num_integers, num_addresses, num_datatypes, combiner)
end

"""
    MPI_Type_get_extent(datatype, lb, extent)

$(_doc_external(:MPI_Type_get_extent))
"""
function MPI_Type_get_extent(datatype, lb, extent)
    @mpichk ccall((:MPI_Type_get_extent, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Aint}, Ptr{MPI_Aint}), datatype, lb, extent)
end

"""
    MPI_Type_get_extent_x(datatype, lb, extent)

$(_doc_external(:MPI_Type_get_extent_x))
"""
function MPI_Type_get_extent_x(datatype, lb, extent)
    @mpichk ccall((:MPI_Type_get_extent_x, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), datatype, lb, extent)
end

"""
    MPI_Type_get_name(datatype, type_name, resultlen)

$(_doc_external(:MPI_Type_get_name))
"""
function MPI_Type_get_name(datatype, type_name, resultlen)
    @mpichk ccall((:MPI_Type_get_name, libmpi), Cint, (MPI_Datatype, Ptr{Cchar}, Ptr{Cint}), datatype, type_name, resultlen)
end

"""
    MPI_Type_get_true_extent(datatype, true_lb, true_extent)

$(_doc_external(:MPI_Type_get_true_extent))
"""
function MPI_Type_get_true_extent(datatype, true_lb, true_extent)
    @mpichk ccall((:MPI_Type_get_true_extent, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Aint}, Ptr{MPI_Aint}), datatype, true_lb, true_extent)
end

"""
    MPI_Type_get_true_extent_x(datatype, true_lb, true_extent)

$(_doc_external(:MPI_Type_get_true_extent_x))
"""
function MPI_Type_get_true_extent_x(datatype, true_lb, true_extent)
    @mpichk ccall((:MPI_Type_get_true_extent_x, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), datatype, true_lb, true_extent)
end

"""
    MPI_Type_indexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)

$(_doc_external(:MPI_Type_indexed))
"""
function MPI_Type_indexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:MPI_Type_indexed, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

"""
    MPI_Type_match_size(typeclass, size, datatype)

$(_doc_external(:MPI_Type_match_size))
"""
function MPI_Type_match_size(typeclass, size, datatype)
    @mpichk ccall((:MPI_Type_match_size, libmpi), Cint, (Cint, Cint, Ptr{MPI_Datatype}), typeclass, size, datatype)
end

"""
    MPI_Type_set_name(datatype, type_name)

$(_doc_external(:MPI_Type_set_name))
"""
function MPI_Type_set_name(datatype, type_name)
    @mpichk ccall((:MPI_Type_set_name, libmpi), Cint, (MPI_Datatype, Ptr{Cchar}), datatype, type_name)
end

"""
    MPI_Type_size(datatype, size)

$(_doc_external(:MPI_Type_size))
"""
function MPI_Type_size(datatype, size)
    @mpichk ccall((:MPI_Type_size, libmpi), Cint, (MPI_Datatype, Ptr{Cint}), datatype, size)
end

"""
    MPI_Type_size_x(datatype, size)

$(_doc_external(:MPI_Type_size_x))
"""
function MPI_Type_size_x(datatype, size)
    @mpichk ccall((:MPI_Type_size_x, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}), datatype, size)
end

"""
    MPI_Type_vector(count, blocklength, stride, oldtype, newtype)

$(_doc_external(:MPI_Type_vector))
"""
function MPI_Type_vector(count, blocklength, stride, oldtype, newtype)
    @mpichk ccall((:MPI_Type_vector, libmpi), Cint, (Cint, Cint, Cint, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

"""
    MPI_Unpack(inbuf, insize, position, outbuf, outcount, datatype, comm)

$(_doc_external(:MPI_Unpack))
"""
function MPI_Unpack(inbuf, insize, position, outbuf, outcount, datatype, comm)
    @mpichk ccall((:MPI_Unpack, libmpi), Cint, (MPIPtr, Cint, Ptr{Cint}, MPIPtr, Cint, MPI_Datatype, MPI_Comm), inbuf, insize, position, outbuf, outcount, datatype, comm)
end

"""
    MPI_Unpack_external(datarep, inbuf, insize, position, outbuf, outcount, datatype)

$(_doc_external(:MPI_Unpack_external))
"""
function MPI_Unpack_external(datarep, inbuf, insize, position, outbuf, outcount, datatype)
    @mpichk ccall((:MPI_Unpack_external, libmpi), Cint, (Ptr{Cchar}, MPIPtr, MPI_Aint, Ptr{MPI_Aint}, MPIPtr, Cint, MPI_Datatype), datarep, inbuf, insize, position, outbuf, outcount, datatype)
end

"""
    MPI_Address(location, address)

$(_doc_external(:MPI_Address))
"""
function MPI_Address(location, address)
    @mpichk ccall((:MPI_Address, libmpi), Cint, (MPIPtr, Ptr{MPI_Aint}), location, address)
end

"""
    MPI_Type_extent(datatype, extent)

$(_doc_external(:MPI_Type_extent))
"""
function MPI_Type_extent(datatype, extent)
    @mpichk ccall((:MPI_Type_extent, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Aint}), datatype, extent)
end

"""
    MPI_Type_lb(datatype, displacement)

$(_doc_external(:MPI_Type_lb))
"""
function MPI_Type_lb(datatype, displacement)
    @mpichk ccall((:MPI_Type_lb, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Aint}), datatype, displacement)
end

"""
    MPI_Type_ub(datatype, displacement)

$(_doc_external(:MPI_Type_ub))
"""
function MPI_Type_ub(datatype, displacement)
    @mpichk ccall((:MPI_Type_ub, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Aint}), datatype, displacement)
end

"""
    MPI_Type_hindexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)

$(_doc_external(:MPI_Type_hindexed))
"""
function MPI_Type_hindexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:MPI_Type_hindexed, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

"""
    MPI_Type_hvector(count, blocklength, stride, oldtype, newtype)

$(_doc_external(:MPI_Type_hvector))
"""
function MPI_Type_hvector(count, blocklength, stride, oldtype, newtype)
    @mpichk ccall((:MPI_Type_hvector, libmpi), Cint, (Cint, Cint, MPI_Aint, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

"""
    MPI_Type_struct(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)

$(_doc_external(:MPI_Type_struct))
"""
function MPI_Type_struct(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
    @mpichk ccall((:MPI_Type_struct, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
end

"""
    MPI_Add_error_class(errorclass)

$(_doc_external(:MPI_Add_error_class))
"""
function MPI_Add_error_class(errorclass)
    @mpichk ccall((:MPI_Add_error_class, libmpi), Cint, (Ptr{Cint},), errorclass)
end

"""
    MPI_Add_error_code(errorclass, errorcode)

$(_doc_external(:MPI_Add_error_code))
"""
function MPI_Add_error_code(errorclass, errorcode)
    @mpichk ccall((:MPI_Add_error_code, libmpi), Cint, (Cint, Ptr{Cint}), errorclass, errorcode)
end

"""
    MPI_Add_error_string(errorcode, string)

$(_doc_external(:MPI_Add_error_string))
"""
function MPI_Add_error_string(errorcode, string)
    @mpichk ccall((:MPI_Add_error_string, libmpi), Cint, (Cint, Ptr{Cchar}), errorcode, string)
end

"""
    MPI_Comm_call_errhandler(comm, errorcode)

$(_doc_external(:MPI_Comm_call_errhandler))
"""
function MPI_Comm_call_errhandler(comm, errorcode)
    @mpichk ccall((:MPI_Comm_call_errhandler, libmpi), Cint, (MPI_Comm, Cint), comm, errorcode)
end

"""
    MPI_Comm_create_errhandler(comm_errhandler_fn, errhandler)

$(_doc_external(:MPI_Comm_create_errhandler))
"""
function MPI_Comm_create_errhandler(comm_errhandler_fn, errhandler)
    @mpichk ccall((:MPI_Comm_create_errhandler, libmpi), Cint, (MPIPtr, Ptr{MPI_Errhandler}), comm_errhandler_fn, errhandler)
end

"""
    MPI_Comm_get_errhandler(comm, errhandler)

$(_doc_external(:MPI_Comm_get_errhandler))
"""
function MPI_Comm_get_errhandler(comm, errhandler)
    @mpichk ccall((:MPI_Comm_get_errhandler, libmpi), Cint, (MPI_Comm, Ptr{MPI_Errhandler}), comm, errhandler)
end

"""
    MPI_Comm_set_errhandler(comm, errhandler)

$(_doc_external(:MPI_Comm_set_errhandler))
"""
function MPI_Comm_set_errhandler(comm, errhandler)
    @mpichk ccall((:MPI_Comm_set_errhandler, libmpi), Cint, (MPI_Comm, MPI_Errhandler), comm, errhandler)
end

"""
    MPI_Errhandler_free(errhandler)

$(_doc_external(:MPI_Errhandler_free))
"""
function MPI_Errhandler_free(errhandler)
    @mpichk ccall((:MPI_Errhandler_free, libmpi), Cint, (Ptr{MPI_Errhandler},), errhandler)
end

"""
    MPI_Error_class(errorcode, errorclass)

$(_doc_external(:MPI_Error_class))
"""
function MPI_Error_class(errorcode, errorclass)
    @mpichk ccall((:MPI_Error_class, libmpi), Cint, (Cint, Ptr{Cint}), errorcode, errorclass)
end

"""
    MPI_Error_string(errorcode, string, resultlen)

$(_doc_external(:MPI_Error_string))
"""
function MPI_Error_string(errorcode, string, resultlen)
    @mpichk ccall((:MPI_Error_string, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}), errorcode, string, resultlen)
end

"""
    MPI_File_call_errhandler(fh, errorcode)

$(_doc_external(:MPI_File_call_errhandler))
"""
function MPI_File_call_errhandler(fh, errorcode)
    @mpichk ccall((:MPI_File_call_errhandler, libmpi), Cint, (MPI_File, Cint), fh, errorcode)
end

"""
    MPI_File_create_errhandler(file_errhandler_fn, errhandler)

$(_doc_external(:MPI_File_create_errhandler))
"""
function MPI_File_create_errhandler(file_errhandler_fn, errhandler)
    @mpichk ccall((:MPI_File_create_errhandler, libmpi), Cint, (MPIPtr, Ptr{MPI_Errhandler}), file_errhandler_fn, errhandler)
end

"""
    MPI_File_get_errhandler(file, errhandler)

$(_doc_external(:MPI_File_get_errhandler))
"""
function MPI_File_get_errhandler(file, errhandler)
    @mpichk ccall((:MPI_File_get_errhandler, libmpi), Cint, (MPI_File, Ptr{MPI_Errhandler}), file, errhandler)
end

"""
    MPI_File_set_errhandler(file, errhandler)

$(_doc_external(:MPI_File_set_errhandler))
"""
function MPI_File_set_errhandler(file, errhandler)
    @mpichk ccall((:MPI_File_set_errhandler, libmpi), Cint, (MPI_File, MPI_Errhandler), file, errhandler)
end

"""
    MPI_Session_call_errhandler(session, errorcode)

$(_doc_external(:MPI_Session_call_errhandler))
"""
function MPI_Session_call_errhandler(session, errorcode)
    @mpichk ccall((:MPI_Session_call_errhandler, libmpi), Cint, (MPI_Session, Cint), session, errorcode)
end

"""
    MPI_Session_create_errhandler(session_errhandler_fn, errhandler)

$(_doc_external(:MPI_Session_create_errhandler))
"""
function MPI_Session_create_errhandler(session_errhandler_fn, errhandler)
    @mpichk ccall((:MPI_Session_create_errhandler, libmpi), Cint, (MPIPtr, Ptr{MPI_Errhandler}), session_errhandler_fn, errhandler)
end

"""
    MPI_Session_get_errhandler(session, errhandler)

$(_doc_external(:MPI_Session_get_errhandler))
"""
function MPI_Session_get_errhandler(session, errhandler)
    @mpichk ccall((:MPI_Session_get_errhandler, libmpi), Cint, (MPI_Session, Ptr{MPI_Errhandler}), session, errhandler)
end

"""
    MPI_Session_set_errhandler(session, errhandler)

$(_doc_external(:MPI_Session_set_errhandler))
"""
function MPI_Session_set_errhandler(session, errhandler)
    @mpichk ccall((:MPI_Session_set_errhandler, libmpi), Cint, (MPI_Session, MPI_Errhandler), session, errhandler)
end

"""
    MPI_Win_call_errhandler(win, errorcode)

$(_doc_external(:MPI_Win_call_errhandler))
"""
function MPI_Win_call_errhandler(win, errorcode)
    @mpichk ccall((:MPI_Win_call_errhandler, libmpi), Cint, (MPI_Win, Cint), win, errorcode)
end

"""
    MPI_Win_create_errhandler(win_errhandler_fn, errhandler)

$(_doc_external(:MPI_Win_create_errhandler))
"""
function MPI_Win_create_errhandler(win_errhandler_fn, errhandler)
    @mpichk ccall((:MPI_Win_create_errhandler, libmpi), Cint, (MPIPtr, Ptr{MPI_Errhandler}), win_errhandler_fn, errhandler)
end

"""
    MPI_Win_get_errhandler(win, errhandler)

$(_doc_external(:MPI_Win_get_errhandler))
"""
function MPI_Win_get_errhandler(win, errhandler)
    @mpichk ccall((:MPI_Win_get_errhandler, libmpi), Cint, (MPI_Win, Ptr{MPI_Errhandler}), win, errhandler)
end

"""
    MPI_Win_set_errhandler(win, errhandler)

$(_doc_external(:MPI_Win_set_errhandler))
"""
function MPI_Win_set_errhandler(win, errhandler)
    @mpichk ccall((:MPI_Win_set_errhandler, libmpi), Cint, (MPI_Win, MPI_Errhandler), win, errhandler)
end

"""
    MPIX_Delete_error_class(errorclass)

$(_doc_external(:MPIX_Delete_error_class))
"""
function MPIX_Delete_error_class(errorclass)
    @mpichk ccall((:MPIX_Delete_error_class, libmpi), Cint, (Cint,), errorclass)
end

"""
    MPIX_Delete_error_code(errorcode)

$(_doc_external(:MPIX_Delete_error_code))
"""
function MPIX_Delete_error_code(errorcode)
    @mpichk ccall((:MPIX_Delete_error_code, libmpi), Cint, (Cint,), errorcode)
end

"""
    MPIX_Delete_error_string(errorcode)

$(_doc_external(:MPIX_Delete_error_string))
"""
function MPIX_Delete_error_string(errorcode)
    @mpichk ccall((:MPIX_Delete_error_string, libmpi), Cint, (Cint,), errorcode)
end

"""
    MPI_Errhandler_create(comm_errhandler_fn, errhandler)

$(_doc_external(:MPI_Errhandler_create))
"""
function MPI_Errhandler_create(comm_errhandler_fn, errhandler)
    @mpichk ccall((:MPI_Errhandler_create, libmpi), Cint, (MPIPtr, Ptr{MPI_Errhandler}), comm_errhandler_fn, errhandler)
end

"""
    MPI_Errhandler_get(comm, errhandler)

$(_doc_external(:MPI_Errhandler_get))
"""
function MPI_Errhandler_get(comm, errhandler)
    @mpichk ccall((:MPI_Errhandler_get, libmpi), Cint, (MPI_Comm, Ptr{MPI_Errhandler}), comm, errhandler)
end

"""
    MPI_Errhandler_set(comm, errhandler)

$(_doc_external(:MPI_Errhandler_set))
"""
function MPI_Errhandler_set(comm, errhandler)
    @mpichk ccall((:MPI_Errhandler_set, libmpi), Cint, (MPI_Comm, MPI_Errhandler), comm, errhandler)
end

"""
    MPI_Group_compare(group1, group2, result)

$(_doc_external(:MPI_Group_compare))
"""
function MPI_Group_compare(group1, group2, result)
    @mpichk ccall((:MPI_Group_compare, libmpi), Cint, (MPI_Group, MPI_Group, Ptr{Cint}), group1, group2, result)
end

"""
    MPI_Group_difference(group1, group2, newgroup)

$(_doc_external(:MPI_Group_difference))
"""
function MPI_Group_difference(group1, group2, newgroup)
    @mpichk ccall((:MPI_Group_difference, libmpi), Cint, (MPI_Group, MPI_Group, Ptr{MPI_Group}), group1, group2, newgroup)
end

"""
    MPI_Group_excl(group, n, ranks, newgroup)

$(_doc_external(:MPI_Group_excl))
"""
function MPI_Group_excl(group, n, ranks, newgroup)
    @mpichk ccall((:MPI_Group_excl, libmpi), Cint, (MPI_Group, Cint, Ptr{Cint}, Ptr{MPI_Group}), group, n, ranks, newgroup)
end

"""
    MPI_Group_free(group)

$(_doc_external(:MPI_Group_free))
"""
function MPI_Group_free(group)
    @mpichk ccall((:MPI_Group_free, libmpi), Cint, (Ptr{MPI_Group},), group)
end

"""
    MPI_Group_incl(group, n, ranks, newgroup)

$(_doc_external(:MPI_Group_incl))
"""
function MPI_Group_incl(group, n, ranks, newgroup)
    @mpichk ccall((:MPI_Group_incl, libmpi), Cint, (MPI_Group, Cint, Ptr{Cint}, Ptr{MPI_Group}), group, n, ranks, newgroup)
end

"""
    MPI_Group_intersection(group1, group2, newgroup)

$(_doc_external(:MPI_Group_intersection))
"""
function MPI_Group_intersection(group1, group2, newgroup)
    @mpichk ccall((:MPI_Group_intersection, libmpi), Cint, (MPI_Group, MPI_Group, Ptr{MPI_Group}), group1, group2, newgroup)
end

"""
    MPI_Group_range_excl(group, n, ranges, newgroup)

$(_doc_external(:MPI_Group_range_excl))
"""
function MPI_Group_range_excl(group, n, ranges, newgroup)
    @mpichk ccall((:MPI_Group_range_excl, libmpi), Cint, (MPI_Group, Cint, Ptr{NTuple{3, Cint}}, Ptr{MPI_Group}), group, n, ranges, newgroup)
end

"""
    MPI_Group_range_incl(group, n, ranges, newgroup)

$(_doc_external(:MPI_Group_range_incl))
"""
function MPI_Group_range_incl(group, n, ranges, newgroup)
    @mpichk ccall((:MPI_Group_range_incl, libmpi), Cint, (MPI_Group, Cint, Ptr{NTuple{3, Cint}}, Ptr{MPI_Group}), group, n, ranges, newgroup)
end

"""
    MPI_Group_rank(group, rank)

$(_doc_external(:MPI_Group_rank))
"""
function MPI_Group_rank(group, rank)
    @mpichk ccall((:MPI_Group_rank, libmpi), Cint, (MPI_Group, Ptr{Cint}), group, rank)
end

"""
    MPI_Group_size(group, size)

$(_doc_external(:MPI_Group_size))
"""
function MPI_Group_size(group, size)
    @mpichk ccall((:MPI_Group_size, libmpi), Cint, (MPI_Group, Ptr{Cint}), group, size)
end

"""
    MPI_Group_translate_ranks(group1, n, ranks1, group2, ranks2)

$(_doc_external(:MPI_Group_translate_ranks))
"""
function MPI_Group_translate_ranks(group1, n, ranks1, group2, ranks2)
    @mpichk ccall((:MPI_Group_translate_ranks, libmpi), Cint, (MPI_Group, Cint, Ptr{Cint}, MPI_Group, Ptr{Cint}), group1, n, ranks1, group2, ranks2)
end

"""
    MPI_Group_union(group1, group2, newgroup)

$(_doc_external(:MPI_Group_union))
"""
function MPI_Group_union(group1, group2, newgroup)
    @mpichk ccall((:MPI_Group_union, libmpi), Cint, (MPI_Group, MPI_Group, Ptr{MPI_Group}), group1, group2, newgroup)
end

"""
    MPI_Info_create(info)

$(_doc_external(:MPI_Info_create))
"""
function MPI_Info_create(info)
    @mpichk ccall((:MPI_Info_create, libmpi), Cint, (Ptr{MPI_Info},), info)
end

"""
    MPI_Info_create_env(argc, argv, info)

$(_doc_external(:MPI_Info_create_env))
"""
function MPI_Info_create_env(argc, argv, info)
    @mpichk ccall((:MPI_Info_create_env, libmpi), Cint, (Cint, Ptr{Ptr{Cchar}}, Ptr{MPI_Info}), argc, argv, info)
end

"""
    MPI_Info_delete(info, key)

$(_doc_external(:MPI_Info_delete))
"""
function MPI_Info_delete(info, key)
    @mpichk ccall((:MPI_Info_delete, libmpi), Cint, (MPI_Info, Ptr{Cchar}), info, key)
end

"""
    MPI_Info_dup(info, newinfo)

$(_doc_external(:MPI_Info_dup))
"""
function MPI_Info_dup(info, newinfo)
    @mpichk ccall((:MPI_Info_dup, libmpi), Cint, (MPI_Info, Ptr{MPI_Info}), info, newinfo)
end

"""
    MPI_Info_free(info)

$(_doc_external(:MPI_Info_free))
"""
function MPI_Info_free(info)
    @mpichk ccall((:MPI_Info_free, libmpi), Cint, (Ptr{MPI_Info},), info)
end

"""
    MPI_Info_get(info, key, valuelen, value, flag)

$(_doc_external(:MPI_Info_get))
"""
function MPI_Info_get(info, key, valuelen, value, flag)
    @mpichk ccall((:MPI_Info_get, libmpi), Cint, (MPI_Info, Ptr{Cchar}, Cint, Ptr{Cchar}, Ptr{Cint}), info, key, valuelen, value, flag)
end

"""
    MPI_Info_get_nkeys(info, nkeys)

$(_doc_external(:MPI_Info_get_nkeys))
"""
function MPI_Info_get_nkeys(info, nkeys)
    @mpichk ccall((:MPI_Info_get_nkeys, libmpi), Cint, (MPI_Info, Ptr{Cint}), info, nkeys)
end

"""
    MPI_Info_get_nthkey(info, n, key)

$(_doc_external(:MPI_Info_get_nthkey))
"""
function MPI_Info_get_nthkey(info, n, key)
    @mpichk ccall((:MPI_Info_get_nthkey, libmpi), Cint, (MPI_Info, Cint, Ptr{Cchar}), info, n, key)
end

"""
    MPI_Info_get_string(info, key, buflen, value, flag)

$(_doc_external(:MPI_Info_get_string))
"""
function MPI_Info_get_string(info, key, buflen, value, flag)
    @mpichk ccall((:MPI_Info_get_string, libmpi), Cint, (MPI_Info, Ptr{Cchar}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}), info, key, buflen, value, flag)
end

"""
    MPI_Info_get_valuelen(info, key, valuelen, flag)

$(_doc_external(:MPI_Info_get_valuelen))
"""
function MPI_Info_get_valuelen(info, key, valuelen, flag)
    @mpichk ccall((:MPI_Info_get_valuelen, libmpi), Cint, (MPI_Info, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}), info, key, valuelen, flag)
end

"""
    MPI_Info_set(info, key, value)

$(_doc_external(:MPI_Info_set))
"""
function MPI_Info_set(info, key, value)
    @mpichk ccall((:MPI_Info_set, libmpi), Cint, (MPI_Info, Ptr{Cchar}, Ptr{Cchar}), info, key, value)
end

"""
    MPI_Abort(comm, errorcode)

$(_doc_external(:MPI_Abort))
"""
function MPI_Abort(comm, errorcode)
    @mpichk ccall((:MPI_Abort, libmpi), Cint, (MPI_Comm, Cint), comm, errorcode)
end

"""
    MPI_Comm_create_from_group(group, stringtag, info, errhandler, newcomm)

$(_doc_external(:MPI_Comm_create_from_group))
"""
function MPI_Comm_create_from_group(group, stringtag, info, errhandler, newcomm)
    @mpichk ccall((:MPI_Comm_create_from_group, libmpi), Cint, (MPI_Group, Ptr{Cchar}, MPI_Info, MPI_Errhandler, Ptr{MPI_Comm}), group, stringtag, info, errhandler, newcomm)
end

"""
    MPI_Finalize()

$(_doc_external(:MPI_Finalize))
"""
function MPI_Finalize()
    @mpichk ccall((:MPI_Finalize, libmpi), Cint, ())
end

"""
    MPI_Finalized(flag)

$(_doc_external(:MPI_Finalized))
"""
function MPI_Finalized(flag)
    @mpichk ccall((:MPI_Finalized, libmpi), Cint, (Ptr{Cint},), flag)
end

"""
    MPI_Init(argc, argv)

$(_doc_external(:MPI_Init))
"""
function MPI_Init(argc, argv)
    @mpichk ccall((:MPI_Init, libmpi), Cint, (Ptr{Cint}, Ptr{Ptr{Ptr{Cchar}}}), argc, argv)
end

"""
    MPI_Init_thread(argc, argv, required, provided)

$(_doc_external(:MPI_Init_thread))
"""
function MPI_Init_thread(argc, argv, required, provided)
    @mpichk ccall((:MPI_Init_thread, libmpi), Cint, (Ptr{Cint}, Ptr{Ptr{Ptr{Cchar}}}, Cint, Ptr{Cint}), argc, argv, required, provided)
end

"""
    MPI_Initialized(flag)

$(_doc_external(:MPI_Initialized))
"""
function MPI_Initialized(flag)
    @mpichk ccall((:MPI_Initialized, libmpi), Cint, (Ptr{Cint},), flag)
end

"""
    MPI_Is_thread_main(flag)

$(_doc_external(:MPI_Is_thread_main))
"""
function MPI_Is_thread_main(flag)
    @mpichk ccall((:MPI_Is_thread_main, libmpi), Cint, (Ptr{Cint},), flag)
end

"""
    MPI_Query_thread(provided)

$(_doc_external(:MPI_Query_thread))
"""
function MPI_Query_thread(provided)
    @mpichk ccall((:MPI_Query_thread, libmpi), Cint, (Ptr{Cint},), provided)
end

"""
    MPI_Session_finalize(session)

$(_doc_external(:MPI_Session_finalize))
"""
function MPI_Session_finalize(session)
    @mpichk ccall((:MPI_Session_finalize, libmpi), Cint, (Ptr{MPI_Session},), session)
end

"""
    MPI_Session_get_info(session, info_used)

$(_doc_external(:MPI_Session_get_info))
"""
function MPI_Session_get_info(session, info_used)
    @mpichk ccall((:MPI_Session_get_info, libmpi), Cint, (MPI_Session, Ptr{MPI_Info}), session, info_used)
end

"""
    MPI_Session_get_nth_pset(session, info, n, pset_len, pset_name)

$(_doc_external(:MPI_Session_get_nth_pset))
"""
function MPI_Session_get_nth_pset(session, info, n, pset_len, pset_name)
    @mpichk ccall((:MPI_Session_get_nth_pset, libmpi), Cint, (MPI_Session, MPI_Info, Cint, Ptr{Cint}, Ptr{Cchar}), session, info, n, pset_len, pset_name)
end

"""
    MPI_Session_get_num_psets(session, info, npset_names)

$(_doc_external(:MPI_Session_get_num_psets))
"""
function MPI_Session_get_num_psets(session, info, npset_names)
    @mpichk ccall((:MPI_Session_get_num_psets, libmpi), Cint, (MPI_Session, MPI_Info, Ptr{Cint}), session, info, npset_names)
end

"""
    MPI_Session_get_pset_info(session, pset_name, info)

$(_doc_external(:MPI_Session_get_pset_info))
"""
function MPI_Session_get_pset_info(session, pset_name, info)
    @mpichk ccall((:MPI_Session_get_pset_info, libmpi), Cint, (MPI_Session, Ptr{Cchar}, Ptr{MPI_Info}), session, pset_name, info)
end

"""
    MPI_Session_init(info, errhandler, session)

$(_doc_external(:MPI_Session_init))
"""
function MPI_Session_init(info, errhandler, session)
    @mpichk ccall((:MPI_Session_init, libmpi), Cint, (MPI_Info, MPI_Errhandler, Ptr{MPI_Session}), info, errhandler, session)
end

"""
    MPI_Aint_add(base, disp)

$(_doc_external(:MPI_Aint_add))
"""
function MPI_Aint_add(base, disp)
    @mpichk ccall((:MPI_Aint_add, libmpi), MPI_Aint, (MPI_Aint, MPI_Aint), base, disp)
end

"""
    MPI_Aint_diff(addr1, addr2)

$(_doc_external(:MPI_Aint_diff))
"""
function MPI_Aint_diff(addr1, addr2)
    @mpichk ccall((:MPI_Aint_diff, libmpi), MPI_Aint, (MPI_Aint, MPI_Aint), addr1, addr2)
end

"""
    MPI_Get_library_version(version, resultlen)

$(_doc_external(:MPI_Get_library_version))
"""
function MPI_Get_library_version(version, resultlen)
    @mpicall ccall((:MPI_Get_library_version, libmpi), Cint, (Ptr{Cchar}, Ptr{Cint}), version, resultlen)
end

"""
    MPI_Get_processor_name(name, resultlen)

$(_doc_external(:MPI_Get_processor_name))
"""
function MPI_Get_processor_name(name, resultlen)
    @mpicall ccall((:MPI_Get_processor_name, libmpi), Cint, (Ptr{Cchar}, Ptr{Cint}), name, resultlen)
end

"""
    MPI_Get_version(version, subversion)

$(_doc_external(:MPI_Get_version))
"""
function MPI_Get_version(version, subversion)
    @mpicall ccall((:MPI_Get_version, libmpi), Cint, (Ptr{Cint}, Ptr{Cint}), version, subversion)
end

"""
    MPIX_GPU_query_support(gpu_type, is_supported)

$(_doc_external(:MPIX_GPU_query_support))
"""
function MPIX_GPU_query_support(gpu_type, is_supported)
    @mpichk ccall((:MPIX_GPU_query_support, libmpi), Cint, (Cint, Ptr{Cint}), gpu_type, is_supported)
end

"""
    MPIX_Query_cuda_support()

$(_doc_external(:MPIX_Query_cuda_support))
"""
function MPIX_Query_cuda_support()
    @mpichk ccall((:MPIX_Query_cuda_support, libmpi), Cint, ())
end

"""
    MPIX_Query_ze_support()

$(_doc_external(:MPIX_Query_ze_support))
"""
function MPIX_Query_ze_support()
    @mpichk ccall((:MPIX_Query_ze_support, libmpi), Cint, ())
end

"""
    MPIX_Query_hip_support()

$(_doc_external(:MPIX_Query_hip_support))
"""
function MPIX_Query_hip_support()
    @mpichk ccall((:MPIX_Query_hip_support, libmpi), Cint, ())
end

"""
    MPI_Op_commutative(op, commute)

$(_doc_external(:MPI_Op_commutative))
"""
function MPI_Op_commutative(op, commute)
    @mpichk ccall((:MPI_Op_commutative, libmpi), Cint, (MPI_Op, Ptr{Cint}), op, commute)
end

"""
    MPI_Op_create(user_fn, commute, op)

$(_doc_external(:MPI_Op_create))
"""
function MPI_Op_create(user_fn, commute, op)
    @mpichk ccall((:MPI_Op_create, libmpi), Cint, (MPIPtr, Cint, Ptr{MPI_Op}), user_fn, commute, op)
end

"""
    MPI_Op_free(op)

$(_doc_external(:MPI_Op_free))
"""
function MPI_Op_free(op)
    @mpichk ccall((:MPI_Op_free, libmpi), Cint, (Ptr{MPI_Op},), op)
end

"""
    MPI_Parrived(request, partition, flag)

$(_doc_external(:MPI_Parrived))
"""
function MPI_Parrived(request, partition, flag)
    @mpichk ccall((:MPI_Parrived, libmpi), Cint, (MPI_Request, Cint, Ptr{Cint}), request, partition, flag)
end

"""
    MPI_Pready(partition, request)

$(_doc_external(:MPI_Pready))
"""
function MPI_Pready(partition, request)
    @mpichk ccall((:MPI_Pready, libmpi), Cint, (Cint, MPI_Request), partition, request)
end

"""
    MPI_Pready_list(length, array_of_partitions, request)

$(_doc_external(:MPI_Pready_list))
"""
function MPI_Pready_list(length, array_of_partitions, request)
    @mpichk ccall((:MPI_Pready_list, libmpi), Cint, (Cint, Ptr{Cint}, MPI_Request), length, array_of_partitions, request)
end

"""
    MPI_Pready_range(partition_low, partition_high, request)

$(_doc_external(:MPI_Pready_range))
"""
function MPI_Pready_range(partition_low, partition_high, request)
    @mpichk ccall((:MPI_Pready_range, libmpi), Cint, (Cint, Cint, MPI_Request), partition_low, partition_high, request)
end

"""
    MPI_Precv_init(buf, partitions, count, datatype, dest, tag, comm, info, request)

$(_doc_external(:MPI_Precv_init))
"""
function MPI_Precv_init(buf, partitions, count, datatype, dest, tag, comm, info, request)
    @mpichk ccall((:MPI_Precv_init, libmpi), Cint, (MPIPtr, Cint, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), buf, partitions, count, datatype, dest, tag, comm, info, request)
end

"""
    MPI_Psend_init(buf, partitions, count, datatype, dest, tag, comm, info, request)

$(_doc_external(:MPI_Psend_init))
"""
function MPI_Psend_init(buf, partitions, count, datatype, dest, tag, comm, info, request)
    @mpichk ccall((:MPI_Psend_init, libmpi), Cint, (MPIPtr, Cint, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), buf, partitions, count, datatype, dest, tag, comm, info, request)
end

"""
    MPI_Bsend(buf, count, datatype, dest, tag, comm)

$(_doc_external(:MPI_Bsend))
"""
function MPI_Bsend(buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:MPI_Bsend, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

"""
    MPI_Bsend_init(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Bsend_init))
"""
function MPI_Bsend_init(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Bsend_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Buffer_attach(buffer, size)

$(_doc_external(:MPI_Buffer_attach))
"""
function MPI_Buffer_attach(buffer, size)
    @mpichk ccall((:MPI_Buffer_attach, libmpi), Cint, (MPIPtr, Cint), buffer, size)
end

"""
    MPI_Buffer_detach(buffer_addr, size)

$(_doc_external(:MPI_Buffer_detach))
"""
function MPI_Buffer_detach(buffer_addr, size)
    @mpichk ccall((:MPI_Buffer_detach, libmpi), Cint, (MPIPtr, Ptr{Cint}), buffer_addr, size)
end

"""
    MPI_Ibsend(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Ibsend))
"""
function MPI_Ibsend(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Ibsend, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Improbe(source, tag, comm, flag, message, status)

$(_doc_external(:MPI_Improbe))
"""
function MPI_Improbe(source, tag, comm, flag, message, status)
    @mpichk ccall((:MPI_Improbe, libmpi), Cint, (Cint, Cint, MPI_Comm, Ptr{Cint}, Ptr{MPI_Message}, Ptr{MPI_Status}), source, tag, comm, flag, message, status)
end

"""
    MPI_Imrecv(buf, count, datatype, message, request)

$(_doc_external(:MPI_Imrecv))
"""
function MPI_Imrecv(buf, count, datatype, message, request)
    @mpichk ccall((:MPI_Imrecv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Request}), buf, count, datatype, message, request)
end

"""
    MPI_Iprobe(source, tag, comm, flag, status)

$(_doc_external(:MPI_Iprobe))
"""
function MPI_Iprobe(source, tag, comm, flag, status)
    @mpichk ccall((:MPI_Iprobe, libmpi), Cint, (Cint, Cint, MPI_Comm, Ptr{Cint}, Ptr{MPI_Status}), source, tag, comm, flag, status)
end

"""
    MPI_Irecv(buf, count, datatype, source, tag, comm, request)

$(_doc_external(:MPI_Irecv))
"""
function MPI_Irecv(buf, count, datatype, source, tag, comm, request)
    @mpichk ccall((:MPI_Irecv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, source, tag, comm, request)
end

"""
    MPI_Irsend(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Irsend))
"""
function MPI_Irsend(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Irsend, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Isend(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Isend))
"""
function MPI_Isend(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Isend, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Isendrecv(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)

$(_doc_external(:MPI_Isendrecv))
"""
function MPI_Isendrecv(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
    @mpichk ccall((:MPI_Isendrecv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
end

"""
    MPI_Isendrecv_replace(buf, count, datatype, dest, sendtag, source, recvtag, comm, request)

$(_doc_external(:MPI_Isendrecv_replace))
"""
function MPI_Isendrecv_replace(buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
    @mpichk ccall((:MPI_Isendrecv_replace, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
end

"""
    MPI_Issend(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Issend))
"""
function MPI_Issend(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Issend, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Mprobe(source, tag, comm, message, status)

$(_doc_external(:MPI_Mprobe))
"""
function MPI_Mprobe(source, tag, comm, message, status)
    @mpichk ccall((:MPI_Mprobe, libmpi), Cint, (Cint, Cint, MPI_Comm, Ptr{MPI_Message}, Ptr{MPI_Status}), source, tag, comm, message, status)
end

"""
    MPI_Mrecv(buf, count, datatype, message, status)

$(_doc_external(:MPI_Mrecv))
"""
function MPI_Mrecv(buf, count, datatype, message, status)
    @mpichk ccall((:MPI_Mrecv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Status}), buf, count, datatype, message, status)
end

"""
    MPI_Probe(source, tag, comm, status)

$(_doc_external(:MPI_Probe))
"""
function MPI_Probe(source, tag, comm, status)
    @mpichk ccall((:MPI_Probe, libmpi), Cint, (Cint, Cint, MPI_Comm, Ptr{MPI_Status}), source, tag, comm, status)
end

"""
    MPI_Recv(buf, count, datatype, source, tag, comm, status)

$(_doc_external(:MPI_Recv))
"""
function MPI_Recv(buf, count, datatype, source, tag, comm, status)
    @mpichk ccall((:MPI_Recv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), buf, count, datatype, source, tag, comm, status)
end

"""
    MPI_Recv_init(buf, count, datatype, source, tag, comm, request)

$(_doc_external(:MPI_Recv_init))
"""
function MPI_Recv_init(buf, count, datatype, source, tag, comm, request)
    @mpichk ccall((:MPI_Recv_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, source, tag, comm, request)
end

"""
    MPI_Rsend(buf, count, datatype, dest, tag, comm)

$(_doc_external(:MPI_Rsend))
"""
function MPI_Rsend(buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:MPI_Rsend, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

"""
    MPI_Rsend_init(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Rsend_init))
"""
function MPI_Rsend_init(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Rsend_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Send(buf, count, datatype, dest, tag, comm)

$(_doc_external(:MPI_Send))
"""
function MPI_Send(buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:MPI_Send, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

"""
    MPI_Send_init(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Send_init))
"""
function MPI_Send_init(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Send_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Sendrecv(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)

$(_doc_external(:MPI_Sendrecv))
"""
function MPI_Sendrecv(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
    @mpichk ccall((:MPI_Sendrecv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
end

"""
    MPI_Sendrecv_replace(buf, count, datatype, dest, sendtag, source, recvtag, comm, status)

$(_doc_external(:MPI_Sendrecv_replace))
"""
function MPI_Sendrecv_replace(buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
    @mpichk ccall((:MPI_Sendrecv_replace, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
end

"""
    MPI_Ssend(buf, count, datatype, dest, tag, comm)

$(_doc_external(:MPI_Ssend))
"""
function MPI_Ssend(buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:MPI_Ssend, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

"""
    MPI_Ssend_init(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Ssend_init))
"""
function MPI_Ssend_init(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Ssend_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Cancel(request)

$(_doc_external(:MPI_Cancel))
"""
function MPI_Cancel(request)
    @mpichk ccall((:MPI_Cancel, libmpi), Cint, (Ptr{MPI_Request},), request)
end

"""
    MPI_Grequest_complete(request)

$(_doc_external(:MPI_Grequest_complete))
"""
function MPI_Grequest_complete(request)
    @mpichk ccall((:MPI_Grequest_complete, libmpi), Cint, (MPI_Request,), request)
end

"""
    MPI_Grequest_start(query_fn, free_fn, cancel_fn, extra_state, request)

$(_doc_external(:MPI_Grequest_start))
"""
function MPI_Grequest_start(query_fn, free_fn, cancel_fn, extra_state, request)
    @mpichk ccall((:MPI_Grequest_start, libmpi), Cint, (MPIPtr, MPIPtr, MPIPtr, MPIPtr, Ptr{MPI_Request}), query_fn, free_fn, cancel_fn, extra_state, request)
end

"""
    MPI_Request_free(request)

$(_doc_external(:MPI_Request_free))
"""
function MPI_Request_free(request)
    @mpichk ccall((:MPI_Request_free, libmpi), Cint, (Ptr{MPI_Request},), request)
end

"""
    MPI_Request_get_status(request, flag, status)

$(_doc_external(:MPI_Request_get_status))
"""
function MPI_Request_get_status(request, flag, status)
    @mpichk ccall((:MPI_Request_get_status, libmpi), Cint, (MPI_Request, Ptr{Cint}, Ptr{MPI_Status}), request, flag, status)
end

"""
    MPI_Start(request)

$(_doc_external(:MPI_Start))
"""
function MPI_Start(request)
    @mpichk ccall((:MPI_Start, libmpi), Cint, (Ptr{MPI_Request},), request)
end

"""
    MPI_Startall(count, array_of_requests)

$(_doc_external(:MPI_Startall))
"""
function MPI_Startall(count, array_of_requests)
    @mpichk ccall((:MPI_Startall, libmpi), Cint, (Cint, Ptr{MPI_Request}), count, array_of_requests)
end

"""
    MPI_Status_set_cancelled(status, flag)

$(_doc_external(:MPI_Status_set_cancelled))
"""
function MPI_Status_set_cancelled(status, flag)
    @mpichk ccall((:MPI_Status_set_cancelled, libmpi), Cint, (Ptr{MPI_Status}, Cint), status, flag)
end

"""
    MPI_Test_cancelled(status, flag)

$(_doc_external(:MPI_Test_cancelled))
"""
function MPI_Test_cancelled(status, flag)
    @mpichk ccall((:MPI_Test_cancelled, libmpi), Cint, (Ptr{MPI_Status}, Ptr{Cint}), status, flag)
end

"""
    MPI_Testall(count, array_of_requests, flag, array_of_statuses)

$(_doc_external(:MPI_Testall))
"""
function MPI_Testall(count, array_of_requests, flag, array_of_statuses)
    @mpichk ccall((:MPI_Testall, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{MPI_Status}), count, array_of_requests, flag, array_of_statuses)
end

"""
    MPI_Testany(count, array_of_requests, indx, flag, status)

$(_doc_external(:MPI_Testany))
"""
function MPI_Testany(count, array_of_requests, indx, flag, status)
    @mpichk ccall((:MPI_Testany, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Status}), count, array_of_requests, indx, flag, status)
end

"""
    MPI_Testsome(incount, array_of_requests, outcount, array_of_indices, array_of_statuses)

$(_doc_external(:MPI_Testsome))
"""
function MPI_Testsome(incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
    @mpichk ccall((:MPI_Testsome, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Status}), incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
end

"""
    MPI_Waitall(count, array_of_requests, array_of_statuses)

$(_doc_external(:MPI_Waitall))
"""
function MPI_Waitall(count, array_of_requests, array_of_statuses)
    @mpichk ccall((:MPI_Waitall, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{MPI_Status}), count, array_of_requests, array_of_statuses)
end

"""
    MPI_Waitany(count, array_of_requests, indx, status)

$(_doc_external(:MPI_Waitany))
"""
function MPI_Waitany(count, array_of_requests, indx, status)
    @mpichk ccall((:MPI_Waitany, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{MPI_Status}), count, array_of_requests, indx, status)
end

"""
    MPI_Waitsome(incount, array_of_requests, outcount, array_of_indices, array_of_statuses)

$(_doc_external(:MPI_Waitsome))
"""
function MPI_Waitsome(incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
    @mpichk ccall((:MPI_Waitsome, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Status}), incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
end

"""
    MPI_Accumulate(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)

$(_doc_external(:MPI_Accumulate))
"""
function MPI_Accumulate(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    @mpichk ccall((:MPI_Accumulate, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

"""
    MPI_Alloc_mem(size, info, baseptr)

$(_doc_external(:MPI_Alloc_mem))
"""
function MPI_Alloc_mem(size, info, baseptr)
    @mpichk ccall((:MPI_Alloc_mem, libmpi), Cint, (MPI_Aint, MPI_Info, MPIPtr), size, info, baseptr)
end

"""
    MPI_Compare_and_swap(origin_addr, compare_addr, result_addr, datatype, target_rank, target_disp, win)

$(_doc_external(:MPI_Compare_and_swap))
"""
function MPI_Compare_and_swap(origin_addr, compare_addr, result_addr, datatype, target_rank, target_disp, win)
    @mpichk ccall((:MPI_Compare_and_swap, libmpi), Cint, (MPIPtr, MPIPtr, MPIPtr, MPI_Datatype, Cint, MPI_Aint, MPI_Win), origin_addr, compare_addr, result_addr, datatype, target_rank, target_disp, win)
end

"""
    MPI_Fetch_and_op(origin_addr, result_addr, datatype, target_rank, target_disp, op, win)

$(_doc_external(:MPI_Fetch_and_op))
"""
function MPI_Fetch_and_op(origin_addr, result_addr, datatype, target_rank, target_disp, op, win)
    @mpichk ccall((:MPI_Fetch_and_op, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Datatype, Cint, MPI_Aint, MPI_Op, MPI_Win), origin_addr, result_addr, datatype, target_rank, target_disp, op, win)
end

"""
    MPI_Free_mem(base)

$(_doc_external(:MPI_Free_mem))
"""
function MPI_Free_mem(base)
    @mpichk ccall((:MPI_Free_mem, libmpi), Cint, (MPIPtr,), base)
end

"""
    MPI_Get(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)

$(_doc_external(:MPI_Get))
"""
function MPI_Get(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    @mpichk ccall((:MPI_Get, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

"""
    MPI_Get_accumulate(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)

$(_doc_external(:MPI_Get_accumulate))
"""
function MPI_Get_accumulate(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    @mpichk ccall((:MPI_Get_accumulate, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win), origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

"""
    MPI_Put(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)

$(_doc_external(:MPI_Put))
"""
function MPI_Put(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    @mpichk ccall((:MPI_Put, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

"""
    MPI_Raccumulate(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)

$(_doc_external(:MPI_Raccumulate))
"""
function MPI_Raccumulate(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    @mpichk ccall((:MPI_Raccumulate, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

"""
    MPI_Rget(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)

$(_doc_external(:MPI_Rget))
"""
function MPI_Rget(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    @mpichk ccall((:MPI_Rget, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

"""
    MPI_Rget_accumulate(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)

$(_doc_external(:MPI_Rget_accumulate))
"""
function MPI_Rget_accumulate(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    @mpichk ccall((:MPI_Rget_accumulate, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

"""
    MPI_Rput(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)

$(_doc_external(:MPI_Rput))
"""
function MPI_Rput(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    @mpichk ccall((:MPI_Rput, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

"""
    MPI_Win_allocate(size, disp_unit, info, comm, baseptr, win)

$(_doc_external(:MPI_Win_allocate))
"""
function MPI_Win_allocate(size, disp_unit, info, comm, baseptr, win)
    @mpichk ccall((:MPI_Win_allocate, libmpi), Cint, (MPI_Aint, Cint, MPI_Info, MPI_Comm, MPIPtr, Ptr{MPI_Win}), size, disp_unit, info, comm, baseptr, win)
end

"""
    MPI_Win_allocate_shared(size, disp_unit, info, comm, baseptr, win)

$(_doc_external(:MPI_Win_allocate_shared))
"""
function MPI_Win_allocate_shared(size, disp_unit, info, comm, baseptr, win)
    @mpichk ccall((:MPI_Win_allocate_shared, libmpi), Cint, (MPI_Aint, Cint, MPI_Info, MPI_Comm, MPIPtr, Ptr{MPI_Win}), size, disp_unit, info, comm, baseptr, win)
end

"""
    MPI_Win_attach(win, base, size)

$(_doc_external(:MPI_Win_attach))
"""
function MPI_Win_attach(win, base, size)
    @mpichk ccall((:MPI_Win_attach, libmpi), Cint, (MPI_Win, MPIPtr, MPI_Aint), win, base, size)
end

"""
    MPI_Win_complete(win)

$(_doc_external(:MPI_Win_complete))
"""
function MPI_Win_complete(win)
    @mpichk ccall((:MPI_Win_complete, libmpi), Cint, (MPI_Win,), win)
end

"""
    MPI_Win_create(base, size, disp_unit, info, comm, win)

$(_doc_external(:MPI_Win_create))
"""
function MPI_Win_create(base, size, disp_unit, info, comm, win)
    @mpichk ccall((:MPI_Win_create, libmpi), Cint, (MPIPtr, MPI_Aint, Cint, MPI_Info, MPI_Comm, Ptr{MPI_Win}), base, size, disp_unit, info, comm, win)
end

"""
    MPI_Win_create_dynamic(info, comm, win)

$(_doc_external(:MPI_Win_create_dynamic))
"""
function MPI_Win_create_dynamic(info, comm, win)
    @mpichk ccall((:MPI_Win_create_dynamic, libmpi), Cint, (MPI_Info, MPI_Comm, Ptr{MPI_Win}), info, comm, win)
end

"""
    MPI_Win_detach(win, base)

$(_doc_external(:MPI_Win_detach))
"""
function MPI_Win_detach(win, base)
    @mpichk ccall((:MPI_Win_detach, libmpi), Cint, (MPI_Win, MPIPtr), win, base)
end

"""
    MPI_Win_fence(assert, win)

$(_doc_external(:MPI_Win_fence))
"""
function MPI_Win_fence(assert, win)
    @mpichk ccall((:MPI_Win_fence, libmpi), Cint, (Cint, MPI_Win), assert, win)
end

"""
    MPI_Win_flush(rank, win)

$(_doc_external(:MPI_Win_flush))
"""
function MPI_Win_flush(rank, win)
    @mpichk ccall((:MPI_Win_flush, libmpi), Cint, (Cint, MPI_Win), rank, win)
end

"""
    MPI_Win_flush_all(win)

$(_doc_external(:MPI_Win_flush_all))
"""
function MPI_Win_flush_all(win)
    @mpichk ccall((:MPI_Win_flush_all, libmpi), Cint, (MPI_Win,), win)
end

"""
    MPI_Win_flush_local(rank, win)

$(_doc_external(:MPI_Win_flush_local))
"""
function MPI_Win_flush_local(rank, win)
    @mpichk ccall((:MPI_Win_flush_local, libmpi), Cint, (Cint, MPI_Win), rank, win)
end

"""
    MPI_Win_flush_local_all(win)

$(_doc_external(:MPI_Win_flush_local_all))
"""
function MPI_Win_flush_local_all(win)
    @mpichk ccall((:MPI_Win_flush_local_all, libmpi), Cint, (MPI_Win,), win)
end

"""
    MPI_Win_free(win)

$(_doc_external(:MPI_Win_free))
"""
function MPI_Win_free(win)
    @mpichk ccall((:MPI_Win_free, libmpi), Cint, (Ptr{MPI_Win},), win)
end

"""
    MPI_Win_get_group(win, group)

$(_doc_external(:MPI_Win_get_group))
"""
function MPI_Win_get_group(win, group)
    @mpichk ccall((:MPI_Win_get_group, libmpi), Cint, (MPI_Win, Ptr{MPI_Group}), win, group)
end

"""
    MPI_Win_get_info(win, info_used)

$(_doc_external(:MPI_Win_get_info))
"""
function MPI_Win_get_info(win, info_used)
    @mpichk ccall((:MPI_Win_get_info, libmpi), Cint, (MPI_Win, Ptr{MPI_Info}), win, info_used)
end

"""
    MPI_Win_get_name(win, win_name, resultlen)

$(_doc_external(:MPI_Win_get_name))
"""
function MPI_Win_get_name(win, win_name, resultlen)
    @mpichk ccall((:MPI_Win_get_name, libmpi), Cint, (MPI_Win, Ptr{Cchar}, Ptr{Cint}), win, win_name, resultlen)
end

"""
    MPI_Win_lock(lock_type, rank, assert, win)

$(_doc_external(:MPI_Win_lock))
"""
function MPI_Win_lock(lock_type, rank, assert, win)
    @mpichk ccall((:MPI_Win_lock, libmpi), Cint, (Cint, Cint, Cint, MPI_Win), lock_type, rank, assert, win)
end

"""
    MPI_Win_lock_all(assert, win)

$(_doc_external(:MPI_Win_lock_all))
"""
function MPI_Win_lock_all(assert, win)
    @mpichk ccall((:MPI_Win_lock_all, libmpi), Cint, (Cint, MPI_Win), assert, win)
end

"""
    MPI_Win_post(group, assert, win)

$(_doc_external(:MPI_Win_post))
"""
function MPI_Win_post(group, assert, win)
    @mpichk ccall((:MPI_Win_post, libmpi), Cint, (MPI_Group, Cint, MPI_Win), group, assert, win)
end

"""
    MPI_Win_set_info(win, info)

$(_doc_external(:MPI_Win_set_info))
"""
function MPI_Win_set_info(win, info)
    @mpichk ccall((:MPI_Win_set_info, libmpi), Cint, (MPI_Win, MPI_Info), win, info)
end

"""
    MPI_Win_set_name(win, win_name)

$(_doc_external(:MPI_Win_set_name))
"""
function MPI_Win_set_name(win, win_name)
    @mpichk ccall((:MPI_Win_set_name, libmpi), Cint, (MPI_Win, Ptr{Cchar}), win, win_name)
end

"""
    MPI_Win_shared_query(win, rank, size, disp_unit, baseptr)

$(_doc_external(:MPI_Win_shared_query))
"""
function MPI_Win_shared_query(win, rank, size, disp_unit, baseptr)
    @mpichk ccall((:MPI_Win_shared_query, libmpi), Cint, (MPI_Win, Cint, Ptr{MPI_Aint}, Ptr{Cint}, MPIPtr), win, rank, size, disp_unit, baseptr)
end

"""
    MPI_Win_start(group, assert, win)

$(_doc_external(:MPI_Win_start))
"""
function MPI_Win_start(group, assert, win)
    @mpichk ccall((:MPI_Win_start, libmpi), Cint, (MPI_Group, Cint, MPI_Win), group, assert, win)
end

"""
    MPI_Win_sync(win)

$(_doc_external(:MPI_Win_sync))
"""
function MPI_Win_sync(win)
    @mpichk ccall((:MPI_Win_sync, libmpi), Cint, (MPI_Win,), win)
end

"""
    MPI_Win_test(win, flag)

$(_doc_external(:MPI_Win_test))
"""
function MPI_Win_test(win, flag)
    @mpichk ccall((:MPI_Win_test, libmpi), Cint, (MPI_Win, Ptr{Cint}), win, flag)
end

"""
    MPI_Win_unlock(rank, win)

$(_doc_external(:MPI_Win_unlock))
"""
function MPI_Win_unlock(rank, win)
    @mpichk ccall((:MPI_Win_unlock, libmpi), Cint, (Cint, MPI_Win), rank, win)
end

"""
    MPI_Win_unlock_all(win)

$(_doc_external(:MPI_Win_unlock_all))
"""
function MPI_Win_unlock_all(win)
    @mpichk ccall((:MPI_Win_unlock_all, libmpi), Cint, (MPI_Win,), win)
end

"""
    MPI_Win_wait(win)

$(_doc_external(:MPI_Win_wait))
"""
function MPI_Win_wait(win)
    @mpichk ccall((:MPI_Win_wait, libmpi), Cint, (MPI_Win,), win)
end

"""
    MPI_Close_port(port_name)

$(_doc_external(:MPI_Close_port))
"""
function MPI_Close_port(port_name)
    @mpichk ccall((:MPI_Close_port, libmpi), Cint, (Ptr{Cchar},), port_name)
end

"""
    MPI_Comm_accept(port_name, info, root, comm, newcomm)

$(_doc_external(:MPI_Comm_accept))
"""
function MPI_Comm_accept(port_name, info, root, comm, newcomm)
    @mpichk ccall((:MPI_Comm_accept, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Cint, MPI_Comm, Ptr{MPI_Comm}), port_name, info, root, comm, newcomm)
end

"""
    MPI_Comm_connect(port_name, info, root, comm, newcomm)

$(_doc_external(:MPI_Comm_connect))
"""
function MPI_Comm_connect(port_name, info, root, comm, newcomm)
    @mpichk ccall((:MPI_Comm_connect, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Cint, MPI_Comm, Ptr{MPI_Comm}), port_name, info, root, comm, newcomm)
end

"""
    MPI_Comm_disconnect(comm)

$(_doc_external(:MPI_Comm_disconnect))
"""
function MPI_Comm_disconnect(comm)
    @mpichk ccall((:MPI_Comm_disconnect, libmpi), Cint, (Ptr{MPI_Comm},), comm)
end

"""
    MPI_Comm_get_parent(parent)

$(_doc_external(:MPI_Comm_get_parent))
"""
function MPI_Comm_get_parent(parent)
    @mpichk ccall((:MPI_Comm_get_parent, libmpi), Cint, (Ptr{MPI_Comm},), parent)
end

"""
    MPI_Comm_join(fd, intercomm)

$(_doc_external(:MPI_Comm_join))
"""
function MPI_Comm_join(fd, intercomm)
    @mpichk ccall((:MPI_Comm_join, libmpi), Cint, (Cint, Ptr{MPI_Comm}), fd, intercomm)
end

"""
    MPI_Comm_spawn(command, argv, maxprocs, info, root, comm, intercomm, array_of_errcodes)

$(_doc_external(:MPI_Comm_spawn))
"""
function MPI_Comm_spawn(command, argv, maxprocs, info, root, comm, intercomm, array_of_errcodes)
    @mpichk ccall((:MPI_Comm_spawn, libmpi), Cint, (Ptr{Cchar}, Ptr{Ptr{Cchar}}, Cint, MPI_Info, Cint, MPI_Comm, Ptr{MPI_Comm}, Ptr{Cint}), command, argv, maxprocs, info, root, comm, intercomm, array_of_errcodes)
end

"""
    MPI_Comm_spawn_multiple(count, array_of_commands, array_of_argv, array_of_maxprocs, array_of_info, root, comm, intercomm, array_of_errcodes)

$(_doc_external(:MPI_Comm_spawn_multiple))
"""
function MPI_Comm_spawn_multiple(count, array_of_commands, array_of_argv, array_of_maxprocs, array_of_info, root, comm, intercomm, array_of_errcodes)
    @mpichk ccall((:MPI_Comm_spawn_multiple, libmpi), Cint, (Cint, Ptr{Ptr{Cchar}}, Ptr{Ptr{Ptr{Cchar}}}, Ptr{Cint}, Ptr{MPI_Info}, Cint, MPI_Comm, Ptr{MPI_Comm}, Ptr{Cint}), count, array_of_commands, array_of_argv, array_of_maxprocs, array_of_info, root, comm, intercomm, array_of_errcodes)
end

"""
    MPI_Lookup_name(service_name, info, port_name)

$(_doc_external(:MPI_Lookup_name))
"""
function MPI_Lookup_name(service_name, info, port_name)
    @mpichk ccall((:MPI_Lookup_name, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Ptr{Cchar}), service_name, info, port_name)
end

"""
    MPI_Open_port(info, port_name)

$(_doc_external(:MPI_Open_port))
"""
function MPI_Open_port(info, port_name)
    @mpichk ccall((:MPI_Open_port, libmpi), Cint, (MPI_Info, Ptr{Cchar}), info, port_name)
end

"""
    MPI_Publish_name(service_name, info, port_name)

$(_doc_external(:MPI_Publish_name))
"""
function MPI_Publish_name(service_name, info, port_name)
    @mpichk ccall((:MPI_Publish_name, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Ptr{Cchar}), service_name, info, port_name)
end

"""
    MPI_Unpublish_name(service_name, info, port_name)

$(_doc_external(:MPI_Unpublish_name))
"""
function MPI_Unpublish_name(service_name, info, port_name)
    @mpichk ccall((:MPI_Unpublish_name, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Ptr{Cchar}), service_name, info, port_name)
end

"""
    MPI_Wtick()

$(_doc_external(:MPI_Wtick))
"""
function MPI_Wtick()
    @mpicall ccall((:MPI_Wtick, libmpi), Cdouble, ())
end

"""
    MPI_Wtime()

$(_doc_external(:MPI_Wtime))
"""
function MPI_Wtime()
    @mpicall ccall((:MPI_Wtime, libmpi), Cdouble, ())
end

"""
    MPI_Cart_coords(comm, rank, maxdims, coords)

$(_doc_external(:MPI_Cart_coords))
"""
function MPI_Cart_coords(comm, rank, maxdims, coords)
    @mpichk ccall((:MPI_Cart_coords, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{Cint}), comm, rank, maxdims, coords)
end

"""
    MPI_Cart_create(comm_old, ndims, dims, periods, reorder, comm_cart)

$(_doc_external(:MPI_Cart_create))
"""
function MPI_Cart_create(comm_old, ndims, dims, periods, reorder, comm_cart)
    @mpichk ccall((:MPI_Cart_create, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{MPI_Comm}), comm_old, ndims, dims, periods, reorder, comm_cart)
end

"""
    MPI_Cart_get(comm, maxdims, dims, periods, coords)

$(_doc_external(:MPI_Cart_get))
"""
function MPI_Cart_get(comm, maxdims, dims, periods, coords)
    @mpichk ccall((:MPI_Cart_get, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), comm, maxdims, dims, periods, coords)
end

"""
    MPI_Cart_map(comm, ndims, dims, periods, newrank)

$(_doc_external(:MPI_Cart_map))
"""
function MPI_Cart_map(comm, ndims, dims, periods, newrank)
    @mpichk ccall((:MPI_Cart_map, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), comm, ndims, dims, periods, newrank)
end

"""
    MPI_Cart_rank(comm, coords, rank)

$(_doc_external(:MPI_Cart_rank))
"""
function MPI_Cart_rank(comm, coords, rank)
    @mpichk ccall((:MPI_Cart_rank, libmpi), Cint, (MPI_Comm, Ptr{Cint}, Ptr{Cint}), comm, coords, rank)
end

"""
    MPI_Cart_shift(comm, direction, disp, rank_source, rank_dest)

$(_doc_external(:MPI_Cart_shift))
"""
function MPI_Cart_shift(comm, direction, disp, rank_source, rank_dest)
    @mpichk ccall((:MPI_Cart_shift, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{Cint}, Ptr{Cint}), comm, direction, disp, rank_source, rank_dest)
end

"""
    MPI_Cart_sub(comm, remain_dims, newcomm)

$(_doc_external(:MPI_Cart_sub))
"""
function MPI_Cart_sub(comm, remain_dims, newcomm)
    @mpichk ccall((:MPI_Cart_sub, libmpi), Cint, (MPI_Comm, Ptr{Cint}, Ptr{MPI_Comm}), comm, remain_dims, newcomm)
end

"""
    MPI_Cartdim_get(comm, ndims)

$(_doc_external(:MPI_Cartdim_get))
"""
function MPI_Cartdim_get(comm, ndims)
    @mpichk ccall((:MPI_Cartdim_get, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, ndims)
end

"""
    MPI_Dims_create(nnodes, ndims, dims)

$(_doc_external(:MPI_Dims_create))
"""
function MPI_Dims_create(nnodes, ndims, dims)
    @mpichk ccall((:MPI_Dims_create, libmpi), Cint, (Cint, Cint, Ptr{Cint}), nnodes, ndims, dims)
end

"""
    MPI_Dist_graph_create(comm_old, n, sources, degrees, destinations, weights, info, reorder, comm_dist_graph)

$(_doc_external(:MPI_Dist_graph_create))
"""
function MPI_Dist_graph_create(comm_old, n, sources, degrees, destinations, weights, info, reorder, comm_dist_graph)
    @mpichk ccall((:MPI_Dist_graph_create, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, MPI_Info, Cint, Ptr{MPI_Comm}), comm_old, n, sources, degrees, destinations, weights, info, reorder, comm_dist_graph) v"2.2.0"
end

"""
    MPI_Dist_graph_create_adjacent(comm_old, indegree, sources, sourceweights, outdegree, destinations, destweights, info, reorder, comm_dist_graph)

$(_doc_external(:MPI_Dist_graph_create_adjacent))
"""
function MPI_Dist_graph_create_adjacent(comm_old, indegree, sources, sourceweights, outdegree, destinations, destweights, info, reorder, comm_dist_graph)
    @mpichk ccall((:MPI_Dist_graph_create_adjacent, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{Cint}, Ptr{Cint}, MPI_Info, Cint, Ptr{MPI_Comm}), comm_old, indegree, sources, sourceweights, outdegree, destinations, destweights, info, reorder, comm_dist_graph) v"2.2.0"
end

"""
    MPI_Dist_graph_neighbors(comm, maxindegree, sources, sourceweights, maxoutdegree, destinations, destweights)

$(_doc_external(:MPI_Dist_graph_neighbors))
"""
function MPI_Dist_graph_neighbors(comm, maxindegree, sources, sourceweights, maxoutdegree, destinations, destweights)
    @mpichk ccall((:MPI_Dist_graph_neighbors, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{Cint}, Ptr{Cint}), comm, maxindegree, sources, sourceweights, maxoutdegree, destinations, destweights) v"2.2.0"
end

"""
    MPI_Dist_graph_neighbors_count(comm, indegree, outdegree, weighted)

$(_doc_external(:MPI_Dist_graph_neighbors_count))
"""
function MPI_Dist_graph_neighbors_count(comm, indegree, outdegree, weighted)
    @mpichk ccall((:MPI_Dist_graph_neighbors_count, libmpi), Cint, (MPI_Comm, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), comm, indegree, outdegree, weighted) v"2.2.0"
end

"""
    MPI_Graph_create(comm_old, nnodes, indx, edges, reorder, comm_graph)

$(_doc_external(:MPI_Graph_create))
"""
function MPI_Graph_create(comm_old, nnodes, indx, edges, reorder, comm_graph)
    @mpichk ccall((:MPI_Graph_create, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{MPI_Comm}), comm_old, nnodes, indx, edges, reorder, comm_graph)
end

"""
    MPI_Graph_get(comm, maxindex, maxedges, indx, edges)

$(_doc_external(:MPI_Graph_get))
"""
function MPI_Graph_get(comm, maxindex, maxedges, indx, edges)
    @mpichk ccall((:MPI_Graph_get, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{Cint}, Ptr{Cint}), comm, maxindex, maxedges, indx, edges)
end

"""
    MPI_Graph_map(comm, nnodes, indx, edges, newrank)

$(_doc_external(:MPI_Graph_map))
"""
function MPI_Graph_map(comm, nnodes, indx, edges, newrank)
    @mpichk ccall((:MPI_Graph_map, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), comm, nnodes, indx, edges, newrank)
end

"""
    MPI_Graph_neighbors(comm, rank, maxneighbors, neighbors)

$(_doc_external(:MPI_Graph_neighbors))
"""
function MPI_Graph_neighbors(comm, rank, maxneighbors, neighbors)
    @mpichk ccall((:MPI_Graph_neighbors, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{Cint}), comm, rank, maxneighbors, neighbors)
end

"""
    MPI_Graph_neighbors_count(comm, rank, nneighbors)

$(_doc_external(:MPI_Graph_neighbors_count))
"""
function MPI_Graph_neighbors_count(comm, rank, nneighbors)
    @mpichk ccall((:MPI_Graph_neighbors_count, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}), comm, rank, nneighbors)
end

"""
    MPI_Graphdims_get(comm, nnodes, nedges)

$(_doc_external(:MPI_Graphdims_get))
"""
function MPI_Graphdims_get(comm, nnodes, nedges)
    @mpichk ccall((:MPI_Graphdims_get, libmpi), Cint, (MPI_Comm, Ptr{Cint}, Ptr{Cint}), comm, nnodes, nedges)
end

"""
    MPI_Topo_test(comm, status)

$(_doc_external(:MPI_Topo_test))
"""
function MPI_Topo_test(comm, status)
    @mpichk ccall((:MPI_Topo_test, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, status)
end

"""
    MPI_T_category_changed(update_number)

$(_doc_external(:MPI_T_category_changed))
"""
function MPI_T_category_changed(update_number)
    @mpichk ccall((:MPI_T_category_changed, libmpi), Cint, (Ptr{Cint},), update_number)
end

"""
    MPI_T_category_get_categories(cat_index, len, indices)

$(_doc_external(:MPI_T_category_get_categories))
"""
function MPI_T_category_get_categories(cat_index, len, indices)
    @mpichk ccall((:MPI_T_category_get_categories, libmpi), Cint, (Cint, Cint, Ptr{Cint}), cat_index, len, indices)
end

"""
    MPI_T_category_get_cvars(cat_index, len, indices)

$(_doc_external(:MPI_T_category_get_cvars))
"""
function MPI_T_category_get_cvars(cat_index, len, indices)
    @mpichk ccall((:MPI_T_category_get_cvars, libmpi), Cint, (Cint, Cint, Ptr{Cint}), cat_index, len, indices)
end

"""
    MPI_T_category_get_events(cat_index, len, indices)

$(_doc_external(:MPI_T_category_get_events))
"""
function MPI_T_category_get_events(cat_index, len, indices)
    @mpichk ccall((:MPI_T_category_get_events, libmpi), Cint, (Cint, Cint, Ptr{Cint}), cat_index, len, indices)
end

"""
    MPI_T_category_get_index(name, cat_index)

$(_doc_external(:MPI_T_category_get_index))
"""
function MPI_T_category_get_index(name, cat_index)
    @mpichk ccall((:MPI_T_category_get_index, libmpi), Cint, (Ptr{Cchar}, Ptr{Cint}), name, cat_index)
end

"""
    MPI_T_category_get_info(cat_index, name, name_len, desc, desc_len, num_cvars, num_pvars, num_categories)

$(_doc_external(:MPI_T_category_get_info))
"""
function MPI_T_category_get_info(cat_index, name, name_len, desc, desc_len, num_cvars, num_pvars, num_categories)
    @mpichk ccall((:MPI_T_category_get_info, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), cat_index, name, name_len, desc, desc_len, num_cvars, num_pvars, num_categories)
end

"""
    MPI_T_category_get_num(num_cat)

$(_doc_external(:MPI_T_category_get_num))
"""
function MPI_T_category_get_num(num_cat)
    @mpichk ccall((:MPI_T_category_get_num, libmpi), Cint, (Ptr{Cint},), num_cat)
end

"""
    MPI_T_category_get_num_events(cat_index, num_events)

$(_doc_external(:MPI_T_category_get_num_events))
"""
function MPI_T_category_get_num_events(cat_index, num_events)
    @mpichk ccall((:MPI_T_category_get_num_events, libmpi), Cint, (Cint, Ptr{Cint}), cat_index, num_events)
end

"""
    MPI_T_category_get_pvars(cat_index, len, indices)

$(_doc_external(:MPI_T_category_get_pvars))
"""
function MPI_T_category_get_pvars(cat_index, len, indices)
    @mpichk ccall((:MPI_T_category_get_pvars, libmpi), Cint, (Cint, Cint, Ptr{Cint}), cat_index, len, indices)
end

"""
    MPI_T_cvar_get_index(name, cvar_index)

$(_doc_external(:MPI_T_cvar_get_index))
"""
function MPI_T_cvar_get_index(name, cvar_index)
    @mpichk ccall((:MPI_T_cvar_get_index, libmpi), Cint, (Ptr{Cchar}, Ptr{Cint}), name, cvar_index)
end

"""
    MPI_T_cvar_get_info(cvar_index, name, name_len, verbosity, datatype, enumtype, desc, desc_len, bind, scope)

$(_doc_external(:MPI_T_cvar_get_info))
"""
function MPI_T_cvar_get_info(cvar_index, name, name_len, verbosity, datatype, enumtype, desc, desc_len, bind, scope)
    @mpichk ccall((:MPI_T_cvar_get_info, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{MPI_T_enum}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), cvar_index, name, name_len, verbosity, datatype, enumtype, desc, desc_len, bind, scope)
end

"""
    MPI_T_cvar_get_num(num_cvar)

$(_doc_external(:MPI_T_cvar_get_num))
"""
function MPI_T_cvar_get_num(num_cvar)
    @mpichk ccall((:MPI_T_cvar_get_num, libmpi), Cint, (Ptr{Cint},), num_cvar)
end

"""
    MPI_T_cvar_handle_alloc(cvar_index, obj_handle, handle, count)

$(_doc_external(:MPI_T_cvar_handle_alloc))
"""
function MPI_T_cvar_handle_alloc(cvar_index, obj_handle, handle, count)
    @mpichk ccall((:MPI_T_cvar_handle_alloc, libmpi), Cint, (Cint, MPIPtr, Ptr{MPI_T_cvar_handle}, Ptr{Cint}), cvar_index, obj_handle, handle, count)
end

"""
    MPI_T_cvar_handle_free(handle)

$(_doc_external(:MPI_T_cvar_handle_free))
"""
function MPI_T_cvar_handle_free(handle)
    @mpichk ccall((:MPI_T_cvar_handle_free, libmpi), Cint, (Ptr{MPI_T_cvar_handle},), handle)
end

"""
    MPI_T_cvar_read(handle, buf)

$(_doc_external(:MPI_T_cvar_read))
"""
function MPI_T_cvar_read(handle, buf)
    @mpichk ccall((:MPI_T_cvar_read, libmpi), Cint, (MPI_T_cvar_handle, MPIPtr), handle, buf)
end

"""
    MPI_T_cvar_write(handle, buf)

$(_doc_external(:MPI_T_cvar_write))
"""
function MPI_T_cvar_write(handle, buf)
    @mpichk ccall((:MPI_T_cvar_write, libmpi), Cint, (MPI_T_cvar_handle, MPIPtr), handle, buf)
end

"""
    MPI_T_enum_get_info(enumtype, num, name, name_len)

$(_doc_external(:MPI_T_enum_get_info))
"""
function MPI_T_enum_get_info(enumtype, num, name, name_len)
    @mpichk ccall((:MPI_T_enum_get_info, libmpi), Cint, (MPI_T_enum, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}), enumtype, num, name, name_len)
end

"""
    MPI_T_enum_get_item(enumtype, indx, value, name, name_len)

$(_doc_external(:MPI_T_enum_get_item))
"""
function MPI_T_enum_get_item(enumtype, indx, value, name, name_len)
    @mpichk ccall((:MPI_T_enum_get_item, libmpi), Cint, (MPI_T_enum, Cint, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}), enumtype, indx, value, name, name_len)
end

"""
    MPI_T_event_callback_get_info(event_registration, cb_safety, info_used)

$(_doc_external(:MPI_T_event_callback_get_info))
"""
function MPI_T_event_callback_get_info(event_registration, cb_safety, info_used)
    @mpichk ccall((:MPI_T_event_callback_get_info, libmpi), Cint, (MPI_T_event_registration, MPI_T_cb_safety, Ptr{MPI_Info}), event_registration, cb_safety, info_used)
end

"""
    MPI_T_event_callback_set_info(event_registration, cb_safety, info)

$(_doc_external(:MPI_T_event_callback_set_info))
"""
function MPI_T_event_callback_set_info(event_registration, cb_safety, info)
    @mpichk ccall((:MPI_T_event_callback_set_info, libmpi), Cint, (MPI_T_event_registration, MPI_T_cb_safety, MPI_Info), event_registration, cb_safety, info)
end

"""
    MPI_T_event_copy(event_instance, buffer)

$(_doc_external(:MPI_T_event_copy))
"""
function MPI_T_event_copy(event_instance, buffer)
    @mpichk ccall((:MPI_T_event_copy, libmpi), Cint, (MPI_T_event_instance, MPIPtr), event_instance, buffer)
end

"""
    MPI_T_event_get_index(name, event_index)

$(_doc_external(:MPI_T_event_get_index))
"""
function MPI_T_event_get_index(name, event_index)
    @mpichk ccall((:MPI_T_event_get_index, libmpi), Cint, (Ptr{Cchar}, Ptr{Cint}), name, event_index)
end

"""
    MPI_T_event_get_info(event_index, name, name_len, verbosity, array_of_datatypes, array_of_displacements, num_elements, enumtype, info, desc, desc_len, bind)

$(_doc_external(:MPI_T_event_get_info))
"""
function MPI_T_event_get_info(event_index, name, name_len, verbosity, array_of_datatypes, array_of_displacements, num_elements, enumtype, info, desc, desc_len, bind)
    @mpichk ccall((:MPI_T_event_get_info, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{MPI_Aint}, Ptr{Cint}, Ptr{MPI_T_enum}, Ptr{MPI_Info}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}), event_index, name, name_len, verbosity, array_of_datatypes, array_of_displacements, num_elements, enumtype, info, desc, desc_len, bind)
end

"""
    MPI_T_event_get_num(num_events)

$(_doc_external(:MPI_T_event_get_num))
"""
function MPI_T_event_get_num(num_events)
    @mpichk ccall((:MPI_T_event_get_num, libmpi), Cint, (Ptr{Cint},), num_events)
end

"""
    MPI_T_event_get_source(event_instance, source_index)

$(_doc_external(:MPI_T_event_get_source))
"""
function MPI_T_event_get_source(event_instance, source_index)
    @mpichk ccall((:MPI_T_event_get_source, libmpi), Cint, (MPI_T_event_instance, Ptr{Cint}), event_instance, source_index)
end

"""
    MPI_T_event_get_timestamp(event_instance, event_timestamp)

$(_doc_external(:MPI_T_event_get_timestamp))
"""
function MPI_T_event_get_timestamp(event_instance, event_timestamp)
    @mpichk ccall((:MPI_T_event_get_timestamp, libmpi), Cint, (MPI_T_event_instance, Ptr{MPI_Count}), event_instance, event_timestamp)
end

"""
    MPI_T_event_handle_alloc(event_index, obj_handle, info, event_registration)

$(_doc_external(:MPI_T_event_handle_alloc))
"""
function MPI_T_event_handle_alloc(event_index, obj_handle, info, event_registration)
    @mpichk ccall((:MPI_T_event_handle_alloc, libmpi), Cint, (Cint, MPIPtr, MPI_Info, Ptr{MPI_T_event_registration}), event_index, obj_handle, info, event_registration)
end

"""
    MPI_T_event_handle_free(event_registration, user_data, free_cb_function)

$(_doc_external(:MPI_T_event_handle_free))
"""
function MPI_T_event_handle_free(event_registration, user_data, free_cb_function)
    @mpichk ccall((:MPI_T_event_handle_free, libmpi), Cint, (MPI_T_event_registration, MPIPtr, MPI_T_event_free_cb_function), event_registration, user_data, free_cb_function)
end

"""
    MPI_T_event_handle_get_info(event_registration, info_used)

$(_doc_external(:MPI_T_event_handle_get_info))
"""
function MPI_T_event_handle_get_info(event_registration, info_used)
    @mpichk ccall((:MPI_T_event_handle_get_info, libmpi), Cint, (MPI_T_event_registration, Ptr{MPI_Info}), event_registration, info_used)
end

"""
    MPI_T_event_handle_set_info(event_registration, info)

$(_doc_external(:MPI_T_event_handle_set_info))
"""
function MPI_T_event_handle_set_info(event_registration, info)
    @mpichk ccall((:MPI_T_event_handle_set_info, libmpi), Cint, (MPI_T_event_registration, MPI_Info), event_registration, info)
end

"""
    MPI_T_event_read(event_instance, element_index, buffer)

$(_doc_external(:MPI_T_event_read))
"""
function MPI_T_event_read(event_instance, element_index, buffer)
    @mpichk ccall((:MPI_T_event_read, libmpi), Cint, (MPI_T_event_instance, Cint, MPIPtr), event_instance, element_index, buffer)
end

"""
    MPI_T_event_register_callback(event_registration, cb_safety, info, user_data, event_cb_function)

$(_doc_external(:MPI_T_event_register_callback))
"""
function MPI_T_event_register_callback(event_registration, cb_safety, info, user_data, event_cb_function)
    @mpichk ccall((:MPI_T_event_register_callback, libmpi), Cint, (MPI_T_event_registration, MPI_T_cb_safety, MPI_Info, MPIPtr, MPI_T_event_cb_function), event_registration, cb_safety, info, user_data, event_cb_function)
end

"""
    MPI_T_event_set_dropped_handler(event_registration, dropped_cb_function)

$(_doc_external(:MPI_T_event_set_dropped_handler))
"""
function MPI_T_event_set_dropped_handler(event_registration, dropped_cb_function)
    @mpichk ccall((:MPI_T_event_set_dropped_handler, libmpi), Cint, (MPI_T_event_registration, MPI_T_event_dropped_cb_function), event_registration, dropped_cb_function)
end

"""
    MPI_T_finalize()

$(_doc_external(:MPI_T_finalize))
"""
function MPI_T_finalize()
    @mpichk ccall((:MPI_T_finalize, libmpi), Cint, ())
end

"""
    MPI_T_init_thread(required, provided)

$(_doc_external(:MPI_T_init_thread))
"""
function MPI_T_init_thread(required, provided)
    @mpichk ccall((:MPI_T_init_thread, libmpi), Cint, (Cint, Ptr{Cint}), required, provided)
end

"""
    MPI_T_pvar_get_index(name, var_class, pvar_index)

$(_doc_external(:MPI_T_pvar_get_index))
"""
function MPI_T_pvar_get_index(name, var_class, pvar_index)
    @mpichk ccall((:MPI_T_pvar_get_index, libmpi), Cint, (Ptr{Cchar}, Cint, Ptr{Cint}), name, var_class, pvar_index)
end

"""
    MPI_T_pvar_get_info(pvar_index, name, name_len, verbosity, var_class, datatype, enumtype, desc, desc_len, bind, readonly, continuous, atomic)

$(_doc_external(:MPI_T_pvar_get_info))
"""
function MPI_T_pvar_get_info(pvar_index, name, name_len, verbosity, var_class, datatype, enumtype, desc, desc_len, bind, readonly, continuous, atomic)
    @mpichk ccall((:MPI_T_pvar_get_info, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{MPI_T_enum}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), pvar_index, name, name_len, verbosity, var_class, datatype, enumtype, desc, desc_len, bind, readonly, continuous, atomic)
end

"""
    MPI_T_pvar_get_num(num_pvar)

$(_doc_external(:MPI_T_pvar_get_num))
"""
function MPI_T_pvar_get_num(num_pvar)
    @mpichk ccall((:MPI_T_pvar_get_num, libmpi), Cint, (Ptr{Cint},), num_pvar)
end

"""
    MPI_T_pvar_handle_alloc(session, pvar_index, obj_handle, handle, count)

$(_doc_external(:MPI_T_pvar_handle_alloc))
"""
function MPI_T_pvar_handle_alloc(session, pvar_index, obj_handle, handle, count)
    @mpichk ccall((:MPI_T_pvar_handle_alloc, libmpi), Cint, (MPI_T_pvar_session, Cint, MPIPtr, Ptr{MPI_T_pvar_handle}, Ptr{Cint}), session, pvar_index, obj_handle, handle, count)
end

"""
    MPI_T_pvar_handle_free(session, handle)

$(_doc_external(:MPI_T_pvar_handle_free))
"""
function MPI_T_pvar_handle_free(session, handle)
    @mpichk ccall((:MPI_T_pvar_handle_free, libmpi), Cint, (MPI_T_pvar_session, Ptr{MPI_T_pvar_handle}), session, handle)
end

"""
    MPI_T_pvar_read(session, handle, buf)

$(_doc_external(:MPI_T_pvar_read))
"""
function MPI_T_pvar_read(session, handle, buf)
    @mpichk ccall((:MPI_T_pvar_read, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle, MPIPtr), session, handle, buf)
end

"""
    MPI_T_pvar_readreset(session, handle, buf)

$(_doc_external(:MPI_T_pvar_readreset))
"""
function MPI_T_pvar_readreset(session, handle, buf)
    @mpichk ccall((:MPI_T_pvar_readreset, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle, MPIPtr), session, handle, buf)
end

"""
    MPI_T_pvar_reset(session, handle)

$(_doc_external(:MPI_T_pvar_reset))
"""
function MPI_T_pvar_reset(session, handle)
    @mpichk ccall((:MPI_T_pvar_reset, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle), session, handle)
end

"""
    MPI_T_pvar_session_create(session)

$(_doc_external(:MPI_T_pvar_session_create))
"""
function MPI_T_pvar_session_create(session)
    @mpichk ccall((:MPI_T_pvar_session_create, libmpi), Cint, (Ptr{MPI_T_pvar_session},), session)
end

"""
    MPI_T_pvar_session_free(session)

$(_doc_external(:MPI_T_pvar_session_free))
"""
function MPI_T_pvar_session_free(session)
    @mpichk ccall((:MPI_T_pvar_session_free, libmpi), Cint, (Ptr{MPI_T_pvar_session},), session)
end

"""
    MPI_T_pvar_start(session, handle)

$(_doc_external(:MPI_T_pvar_start))
"""
function MPI_T_pvar_start(session, handle)
    @mpichk ccall((:MPI_T_pvar_start, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle), session, handle)
end

"""
    MPI_T_pvar_stop(session, handle)

$(_doc_external(:MPI_T_pvar_stop))
"""
function MPI_T_pvar_stop(session, handle)
    @mpichk ccall((:MPI_T_pvar_stop, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle), session, handle)
end

"""
    MPI_T_pvar_write(session, handle, buf)

$(_doc_external(:MPI_T_pvar_write))
"""
function MPI_T_pvar_write(session, handle, buf)
    @mpichk ccall((:MPI_T_pvar_write, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle, MPIPtr), session, handle, buf)
end

"""
    MPI_T_source_get_info(source_index, name, name_len, desc, desc_len, ordering, ticks_per_second, max_ticks, info)

$(_doc_external(:MPI_T_source_get_info))
"""
function MPI_T_source_get_info(source_index, name, name_len, desc, desc_len, ordering, ticks_per_second, max_ticks, info)
    @mpichk ccall((:MPI_T_source_get_info, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}, Ptr{MPI_T_source_order}, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Info}), source_index, name, name_len, desc, desc_len, ordering, ticks_per_second, max_ticks, info)
end

"""
    MPI_T_source_get_num(num_sources)

$(_doc_external(:MPI_T_source_get_num))
"""
function MPI_T_source_get_num(num_sources)
    @mpichk ccall((:MPI_T_source_get_num, libmpi), Cint, (Ptr{Cint},), num_sources)
end

"""
    MPI_T_source_get_timestamp(source_index, timestamp)

$(_doc_external(:MPI_T_source_get_timestamp))
"""
function MPI_T_source_get_timestamp(source_index, timestamp)
    @mpichk ccall((:MPI_T_source_get_timestamp, libmpi), Cint, (Cint, Ptr{MPI_Count}), source_index, timestamp)
end

"""
    MPIX_Grequest_start(query_fn, free_fn, cancel_fn, poll_fn, wait_fn, extra_state, request)

$(_doc_external(:MPIX_Grequest_start))
"""
function MPIX_Grequest_start(query_fn, free_fn, cancel_fn, poll_fn, wait_fn, extra_state, request)
    @mpichk ccall((:MPIX_Grequest_start, libmpi), Cint, (MPIPtr, MPIPtr, MPIPtr, MPIPtr, MPIPtr, MPIPtr, Ptr{MPI_Request}), query_fn, free_fn, cancel_fn, poll_fn, wait_fn, extra_state, request)
end

"""
    MPIX_Grequest_class_create(query_fn, free_fn, cancel_fn, poll_fn, wait_fn, greq_class)

$(_doc_external(:MPIX_Grequest_class_create))
"""
function MPIX_Grequest_class_create(query_fn, free_fn, cancel_fn, poll_fn, wait_fn, greq_class)
    @mpichk ccall((:MPIX_Grequest_class_create, libmpi), Cint, (MPIPtr, MPIPtr, MPIPtr, MPIPtr, MPIPtr, Ptr{MPIX_Grequest_class}), query_fn, free_fn, cancel_fn, poll_fn, wait_fn, greq_class)
end

"""
    MPIX_Grequest_class_allocate(greq_class, extra_state, request)

$(_doc_external(:MPIX_Grequest_class_allocate))
"""
function MPIX_Grequest_class_allocate(greq_class, extra_state, request)
    @mpichk ccall((:MPIX_Grequest_class_allocate, libmpi), Cint, (MPIX_Grequest_class, MPIPtr, Ptr{MPI_Request}), greq_class, extra_state, request)
end

"""
    MPI_Allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:MPI_Allgather_c))
"""
function MPI_Allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:MPI_Allgather_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

"""
    MPI_Allgather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:MPI_Allgather_init_c))
"""
function MPI_Allgather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Allgather_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    MPI_Allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)

$(_doc_external(:MPI_Allgatherv_c))
"""
function MPI_Allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    @mpichk ccall((:MPI_Allgatherv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

"""
    MPI_Allgatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)

$(_doc_external(:MPI_Allgatherv_init_c))
"""
function MPI_Allgatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Allgatherv_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
end

"""
    MPI_Allreduce_c(sendbuf, recvbuf, count, datatype, op, comm)

$(_doc_external(:MPI_Allreduce_c))
"""
function MPI_Allreduce_c(sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk ccall((:MPI_Allreduce_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

"""
    MPI_Allreduce_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)

$(_doc_external(:MPI_Allreduce_init_c))
"""
function MPI_Allreduce_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk ccall((:MPI_Allreduce_init_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

"""
    MPI_Alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:MPI_Alltoall_c))
"""
function MPI_Alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:MPI_Alltoall_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

"""
    MPI_Alltoall_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:MPI_Alltoall_init_c))
"""
function MPI_Alltoall_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Alltoall_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    MPI_Alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)

$(_doc_external(:MPI_Alltoallv_c))
"""
function MPI_Alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    @mpichk ccall((:MPI_Alltoallv_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

"""
    MPI_Alltoallv_init_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)

$(_doc_external(:MPI_Alltoallv_init_c))
"""
function MPI_Alltoallv_init_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Alltoallv_init_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
end

"""
    MPI_Alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)

$(_doc_external(:MPI_Alltoallw_c))
"""
function MPI_Alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    @mpichk ccall((:MPI_Alltoallw_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

"""
    MPI_Alltoallw_init_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)

$(_doc_external(:MPI_Alltoallw_init_c))
"""
function MPI_Alltoallw_init_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    @mpichk ccall((:MPI_Alltoallw_init_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
end

"""
    MPI_Bcast_c(buffer, count, datatype, root, comm)

$(_doc_external(:MPI_Bcast_c))
"""
function MPI_Bcast_c(buffer, count, datatype, root, comm)
    @mpichk ccall((:MPI_Bcast_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm), buffer, count, datatype, root, comm)
end

"""
    MPI_Bcast_init_c(buffer, count, datatype, root, comm, info, request)

$(_doc_external(:MPI_Bcast_init_c))
"""
function MPI_Bcast_init_c(buffer, count, datatype, root, comm, info, request)
    @mpichk ccall((:MPI_Bcast_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), buffer, count, datatype, root, comm, info, request)
end

"""
    MPI_Exscan_c(sendbuf, recvbuf, count, datatype, op, comm)

$(_doc_external(:MPI_Exscan_c))
"""
function MPI_Exscan_c(sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk ccall((:MPI_Exscan_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

"""
    MPI_Exscan_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)

$(_doc_external(:MPI_Exscan_init_c))
"""
function MPI_Exscan_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk ccall((:MPI_Exscan_init_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

"""
    MPI_Gather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)

$(_doc_external(:MPI_Gather_c))
"""
function MPI_Gather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk ccall((:MPI_Gather_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

"""
    MPI_Gather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

$(_doc_external(:MPI_Gather_init_c))
"""
function MPI_Gather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk ccall((:MPI_Gather_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

"""
    MPI_Gatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)

$(_doc_external(:MPI_Gatherv_c))
"""
function MPI_Gatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
    @mpichk ccall((:MPI_Gatherv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
end

"""
    MPI_Gatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)

$(_doc_external(:MPI_Gatherv_init_c))
"""
function MPI_Gatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
    @mpichk ccall((:MPI_Gatherv_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
end

"""
    MPI_Iallgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:MPI_Iallgather_c))
"""
function MPI_Iallgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:MPI_Iallgather_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    MPI_Iallgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)

$(_doc_external(:MPI_Iallgatherv_c))
"""
function MPI_Iallgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    @mpichk ccall((:MPI_Iallgatherv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

"""
    MPI_Iallreduce_c(sendbuf, recvbuf, count, datatype, op, comm, request)

$(_doc_external(:MPI_Iallreduce_c))
"""
function MPI_Iallreduce_c(sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk ccall((:MPI_Iallreduce_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

"""
    MPI_Ialltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:MPI_Ialltoall_c))
"""
function MPI_Ialltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:MPI_Ialltoall_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    MPI_Ialltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)

$(_doc_external(:MPI_Ialltoallv_c))
"""
function MPI_Ialltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    @mpichk ccall((:MPI_Ialltoallv_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

"""
    MPI_Ialltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)

$(_doc_external(:MPI_Ialltoallw_c))
"""
function MPI_Ialltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    @mpichk ccall((:MPI_Ialltoallw_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

"""
    MPI_Ibcast_c(buffer, count, datatype, root, comm, request)

$(_doc_external(:MPI_Ibcast_c))
"""
function MPI_Ibcast_c(buffer, count, datatype, root, comm, request)
    @mpichk ccall((:MPI_Ibcast_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), buffer, count, datatype, root, comm, request)
end

"""
    MPI_Iexscan_c(sendbuf, recvbuf, count, datatype, op, comm, request)

$(_doc_external(:MPI_Iexscan_c))
"""
function MPI_Iexscan_c(sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk ccall((:MPI_Iexscan_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

"""
    MPI_Igather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

$(_doc_external(:MPI_Igather_c))
"""
function MPI_Igather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk ccall((:MPI_Igather_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

"""
    MPI_Igatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)

$(_doc_external(:MPI_Igatherv_c))
"""
function MPI_Igatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
    @mpichk ccall((:MPI_Igatherv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
end

"""
    MPI_Ineighbor_allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:MPI_Ineighbor_allgather_c))
"""
function MPI_Ineighbor_allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:MPI_Ineighbor_allgather_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    MPI_Ineighbor_allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)

$(_doc_external(:MPI_Ineighbor_allgatherv_c))
"""
function MPI_Ineighbor_allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    @mpichk ccall((:MPI_Ineighbor_allgatherv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

"""
    MPI_Ineighbor_alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:MPI_Ineighbor_alltoall_c))
"""
function MPI_Ineighbor_alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:MPI_Ineighbor_alltoall_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    MPI_Ineighbor_alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)

$(_doc_external(:MPI_Ineighbor_alltoallv_c))
"""
function MPI_Ineighbor_alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    @mpichk ccall((:MPI_Ineighbor_alltoallv_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

"""
    MPI_Ineighbor_alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)

$(_doc_external(:MPI_Ineighbor_alltoallw_c))
"""
function MPI_Ineighbor_alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    @mpichk ccall((:MPI_Ineighbor_alltoallw_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

"""
    MPI_Ireduce_c(sendbuf, recvbuf, count, datatype, op, root, comm, request)

$(_doc_external(:MPI_Ireduce_c))
"""
function MPI_Ireduce_c(sendbuf, recvbuf, count, datatype, op, root, comm, request)
    @mpichk ccall((:MPI_Ireduce_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, root, comm, request)
end

"""
    MPI_Ireduce_scatter_c(sendbuf, recvbuf, recvcounts, datatype, op, comm, request)

$(_doc_external(:MPI_Ireduce_scatter_c))
"""
function MPI_Ireduce_scatter_c(sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
    @mpichk ccall((:MPI_Ireduce_scatter_c, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{MPI_Count}, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
end

"""
    MPI_Ireduce_scatter_block_c(sendbuf, recvbuf, recvcount, datatype, op, comm, request)

$(_doc_external(:MPI_Ireduce_scatter_block_c))
"""
function MPI_Ireduce_scatter_block_c(sendbuf, recvbuf, recvcount, datatype, op, comm, request)
    @mpichk ccall((:MPI_Ireduce_scatter_block_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, recvcount, datatype, op, comm, request)
end

"""
    MPI_Iscan_c(sendbuf, recvbuf, count, datatype, op, comm, request)

$(_doc_external(:MPI_Iscan_c))
"""
function MPI_Iscan_c(sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk ccall((:MPI_Iscan_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

"""
    MPI_Iscatter_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

$(_doc_external(:MPI_Iscatter_c))
"""
function MPI_Iscatter_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk ccall((:MPI_Iscatter_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

"""
    MPI_Iscatterv_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

$(_doc_external(:MPI_Iscatterv_c))
"""
function MPI_Iscatterv_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk ccall((:MPI_Iscatterv_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

"""
    MPI_Neighbor_allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:MPI_Neighbor_allgather_c))
"""
function MPI_Neighbor_allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:MPI_Neighbor_allgather_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

"""
    MPI_Neighbor_allgather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:MPI_Neighbor_allgather_init_c))
"""
function MPI_Neighbor_allgather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Neighbor_allgather_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    MPI_Neighbor_allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)

$(_doc_external(:MPI_Neighbor_allgatherv_c))
"""
function MPI_Neighbor_allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    @mpichk ccall((:MPI_Neighbor_allgatherv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

"""
    MPI_Neighbor_allgatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)

$(_doc_external(:MPI_Neighbor_allgatherv_init_c))
"""
function MPI_Neighbor_allgatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Neighbor_allgatherv_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
end

"""
    MPI_Neighbor_alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:MPI_Neighbor_alltoall_c))
"""
function MPI_Neighbor_alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:MPI_Neighbor_alltoall_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

"""
    MPI_Neighbor_alltoall_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:MPI_Neighbor_alltoall_init_c))
"""
function MPI_Neighbor_alltoall_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Neighbor_alltoall_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    MPI_Neighbor_alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)

$(_doc_external(:MPI_Neighbor_alltoallv_c))
"""
function MPI_Neighbor_alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    @mpichk ccall((:MPI_Neighbor_alltoallv_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

"""
    MPI_Neighbor_alltoallv_init_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)

$(_doc_external(:MPI_Neighbor_alltoallv_init_c))
"""
function MPI_Neighbor_alltoallv_init_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Neighbor_alltoallv_init_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
end

"""
    MPI_Neighbor_alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)

$(_doc_external(:MPI_Neighbor_alltoallw_c))
"""
function MPI_Neighbor_alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    @mpichk ccall((:MPI_Neighbor_alltoallw_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

"""
    MPI_Neighbor_alltoallw_init_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)

$(_doc_external(:MPI_Neighbor_alltoallw_init_c))
"""
function MPI_Neighbor_alltoallw_init_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    @mpichk ccall((:MPI_Neighbor_alltoallw_init_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
end

"""
    MPI_Reduce_c(sendbuf, recvbuf, count, datatype, op, root, comm)

$(_doc_external(:MPI_Reduce_c))
"""
function MPI_Reduce_c(sendbuf, recvbuf, count, datatype, op, root, comm)
    @mpichk ccall((:MPI_Reduce_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, Cint, MPI_Comm), sendbuf, recvbuf, count, datatype, op, root, comm)
end

"""
    MPI_Reduce_init_c(sendbuf, recvbuf, count, datatype, op, root, comm, info, request)

$(_doc_external(:MPI_Reduce_init_c))
"""
function MPI_Reduce_init_c(sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
    @mpichk ccall((:MPI_Reduce_init_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
end

"""
    MPI_Reduce_local_c(inbuf, inoutbuf, count, datatype, op)

$(_doc_external(:MPI_Reduce_local_c))
"""
function MPI_Reduce_local_c(inbuf, inoutbuf, count, datatype, op)
    @mpichk ccall((:MPI_Reduce_local_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op), inbuf, inoutbuf, count, datatype, op)
end

"""
    MPI_Reduce_scatter_c(sendbuf, recvbuf, recvcounts, datatype, op, comm)

$(_doc_external(:MPI_Reduce_scatter_c))
"""
function MPI_Reduce_scatter_c(sendbuf, recvbuf, recvcounts, datatype, op, comm)
    @mpichk ccall((:MPI_Reduce_scatter_c, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{MPI_Count}, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, recvcounts, datatype, op, comm)
end

"""
    MPI_Reduce_scatter_block_c(sendbuf, recvbuf, recvcount, datatype, op, comm)

$(_doc_external(:MPI_Reduce_scatter_block_c))
"""
function MPI_Reduce_scatter_block_c(sendbuf, recvbuf, recvcount, datatype, op, comm)
    @mpichk ccall((:MPI_Reduce_scatter_block_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, recvcount, datatype, op, comm)
end

"""
    MPI_Reduce_scatter_block_init_c(sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)

$(_doc_external(:MPI_Reduce_scatter_block_init_c))
"""
function MPI_Reduce_scatter_block_init_c(sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
    @mpichk ccall((:MPI_Reduce_scatter_block_init_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
end

"""
    MPI_Reduce_scatter_init_c(sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)

$(_doc_external(:MPI_Reduce_scatter_init_c))
"""
function MPI_Reduce_scatter_init_c(sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
    @mpichk ccall((:MPI_Reduce_scatter_init_c, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{MPI_Count}, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
end

"""
    MPI_Scan_c(sendbuf, recvbuf, count, datatype, op, comm)

$(_doc_external(:MPI_Scan_c))
"""
function MPI_Scan_c(sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk ccall((:MPI_Scan_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

"""
    MPI_Scan_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)

$(_doc_external(:MPI_Scan_init_c))
"""
function MPI_Scan_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk ccall((:MPI_Scan_init_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

"""
    MPI_Scatter_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)

$(_doc_external(:MPI_Scatter_c))
"""
function MPI_Scatter_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk ccall((:MPI_Scatter_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

"""
    MPI_Scatter_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

$(_doc_external(:MPI_Scatter_init_c))
"""
function MPI_Scatter_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk ccall((:MPI_Scatter_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

"""
    MPI_Scatterv_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)

$(_doc_external(:MPI_Scatterv_c))
"""
function MPI_Scatterv_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk ccall((:MPI_Scatterv_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

"""
    MPI_Scatterv_init_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

$(_doc_external(:MPI_Scatterv_init_c))
"""
function MPI_Scatterv_init_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk ccall((:MPI_Scatterv_init_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

"""
    MPI_Get_count_c(status, datatype, count)

$(_doc_external(:MPI_Get_count_c))
"""
function MPI_Get_count_c(status, datatype, count)
    @mpichk ccall((:MPI_Get_count_c, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Ptr{MPI_Count}), status, datatype, count)
end

"""
    MPI_Get_elements_c(status, datatype, count)

$(_doc_external(:MPI_Get_elements_c))
"""
function MPI_Get_elements_c(status, datatype, count)
    @mpichk ccall((:MPI_Get_elements_c, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Ptr{MPI_Count}), status, datatype, count)
end

"""
    MPI_Pack_c(inbuf, incount, datatype, outbuf, outsize, position, comm)

$(_doc_external(:MPI_Pack_c))
"""
function MPI_Pack_c(inbuf, incount, datatype, outbuf, outsize, position, comm)
    @mpichk ccall((:MPI_Pack_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, Ptr{MPI_Count}, MPI_Comm), inbuf, incount, datatype, outbuf, outsize, position, comm)
end

"""
    MPI_Pack_external_c(datarep, inbuf, incount, datatype, outbuf, outsize, position)

$(_doc_external(:MPI_Pack_external_c))
"""
function MPI_Pack_external_c(datarep, inbuf, incount, datatype, outbuf, outsize, position)
    @mpichk ccall((:MPI_Pack_external_c, libmpi), Cint, (Ptr{Cchar}, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, Ptr{MPI_Count}), datarep, inbuf, incount, datatype, outbuf, outsize, position)
end

"""
    MPI_Pack_external_size_c(datarep, incount, datatype, size)

$(_doc_external(:MPI_Pack_external_size_c))
"""
function MPI_Pack_external_size_c(datarep, incount, datatype, size)
    @mpichk ccall((:MPI_Pack_external_size_c, libmpi), Cint, (Ptr{Cchar}, MPI_Count, MPI_Datatype, Ptr{MPI_Count}), datarep, incount, datatype, size)
end

"""
    MPI_Pack_size_c(incount, datatype, comm, size)

$(_doc_external(:MPI_Pack_size_c))
"""
function MPI_Pack_size_c(incount, datatype, comm, size)
    @mpichk ccall((:MPI_Pack_size_c, libmpi), Cint, (MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Count}), incount, datatype, comm, size)
end

"""
    MPI_Type_contiguous_c(count, oldtype, newtype)

$(_doc_external(:MPI_Type_contiguous_c))
"""
function MPI_Type_contiguous_c(count, oldtype, newtype)
    @mpichk ccall((:MPI_Type_contiguous_c, libmpi), Cint, (MPI_Count, MPI_Datatype, Ptr{MPI_Datatype}), count, oldtype, newtype)
end

"""
    MPI_Type_create_darray_c(size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)

$(_doc_external(:MPI_Type_create_darray_c))
"""
function MPI_Type_create_darray_c(size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
    @mpichk ccall((:MPI_Type_create_darray_c, libmpi), Cint, (Cint, Cint, Cint, Ptr{MPI_Count}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
end

"""
    MPI_Type_create_hindexed_c(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)

$(_doc_external(:MPI_Type_create_hindexed_c))
"""
function MPI_Type_create_hindexed_c(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:MPI_Type_create_hindexed_c, libmpi), Cint, (MPI_Count, Ptr{MPI_Count}, Ptr{MPI_Count}, MPI_Datatype, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

"""
    MPI_Type_create_hindexed_block_c(count, blocklength, array_of_displacements, oldtype, newtype)

$(_doc_external(:MPI_Type_create_hindexed_block_c))
"""
function MPI_Type_create_hindexed_block_c(count, blocklength, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:MPI_Type_create_hindexed_block_c, libmpi), Cint, (MPI_Count, MPI_Count, Ptr{MPI_Count}, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, array_of_displacements, oldtype, newtype)
end

"""
    MPI_Type_create_hvector_c(count, blocklength, stride, oldtype, newtype)

$(_doc_external(:MPI_Type_create_hvector_c))
"""
function MPI_Type_create_hvector_c(count, blocklength, stride, oldtype, newtype)
    @mpichk ccall((:MPI_Type_create_hvector_c, libmpi), Cint, (MPI_Count, MPI_Count, MPI_Count, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

"""
    MPI_Type_create_indexed_block_c(count, blocklength, array_of_displacements, oldtype, newtype)

$(_doc_external(:MPI_Type_create_indexed_block_c))
"""
function MPI_Type_create_indexed_block_c(count, blocklength, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:MPI_Type_create_indexed_block_c, libmpi), Cint, (MPI_Count, MPI_Count, Ptr{MPI_Count}, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, array_of_displacements, oldtype, newtype)
end

"""
    MPI_Type_create_resized_c(oldtype, lb, extent, newtype)

$(_doc_external(:MPI_Type_create_resized_c))
"""
function MPI_Type_create_resized_c(oldtype, lb, extent, newtype)
    @mpichk ccall((:MPI_Type_create_resized_c, libmpi), Cint, (MPI_Datatype, MPI_Count, MPI_Count, Ptr{MPI_Datatype}), oldtype, lb, extent, newtype)
end

"""
    MPI_Type_create_struct_c(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)

$(_doc_external(:MPI_Type_create_struct_c))
"""
function MPI_Type_create_struct_c(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
    @mpichk ccall((:MPI_Type_create_struct_c, libmpi), Cint, (MPI_Count, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
end

"""
    MPI_Type_create_subarray_c(ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)

$(_doc_external(:MPI_Type_create_subarray_c))
"""
function MPI_Type_create_subarray_c(ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
    @mpichk ccall((:MPI_Type_create_subarray_c, libmpi), Cint, (Cint, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Count}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
end

"""
    MPI_Type_get_contents_c(datatype, max_integers, max_addresses, max_large_counts, max_datatypes, array_of_integers, array_of_addresses, array_of_large_counts, array_of_datatypes)

$(_doc_external(:MPI_Type_get_contents_c))
"""
function MPI_Type_get_contents_c(datatype, max_integers, max_addresses, max_large_counts, max_datatypes, array_of_integers, array_of_addresses, array_of_large_counts, array_of_datatypes)
    @mpichk ccall((:MPI_Type_get_contents_c, libmpi), Cint, (MPI_Datatype, MPI_Count, MPI_Count, MPI_Count, MPI_Count, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Count}, Ptr{MPI_Datatype}), datatype, max_integers, max_addresses, max_large_counts, max_datatypes, array_of_integers, array_of_addresses, array_of_large_counts, array_of_datatypes)
end

"""
    MPI_Type_get_envelope_c(datatype, num_integers, num_addresses, num_large_counts, num_datatypes, combiner)

$(_doc_external(:MPI_Type_get_envelope_c))
"""
function MPI_Type_get_envelope_c(datatype, num_integers, num_addresses, num_large_counts, num_datatypes, combiner)
    @mpichk ccall((:MPI_Type_get_envelope_c, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{Cint}), datatype, num_integers, num_addresses, num_large_counts, num_datatypes, combiner)
end

"""
    MPI_Type_get_extent_c(datatype, lb, extent)

$(_doc_external(:MPI_Type_get_extent_c))
"""
function MPI_Type_get_extent_c(datatype, lb, extent)
    @mpichk ccall((:MPI_Type_get_extent_c, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), datatype, lb, extent)
end

"""
    MPI_Type_get_true_extent_c(datatype, true_lb, true_extent)

$(_doc_external(:MPI_Type_get_true_extent_c))
"""
function MPI_Type_get_true_extent_c(datatype, true_lb, true_extent)
    @mpichk ccall((:MPI_Type_get_true_extent_c, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), datatype, true_lb, true_extent)
end

"""
    MPI_Type_indexed_c(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)

$(_doc_external(:MPI_Type_indexed_c))
"""
function MPI_Type_indexed_c(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:MPI_Type_indexed_c, libmpi), Cint, (MPI_Count, Ptr{MPI_Count}, Ptr{MPI_Count}, MPI_Datatype, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

"""
    MPI_Type_size_c(datatype, size)

$(_doc_external(:MPI_Type_size_c))
"""
function MPI_Type_size_c(datatype, size)
    @mpichk ccall((:MPI_Type_size_c, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}), datatype, size)
end

"""
    MPI_Type_vector_c(count, blocklength, stride, oldtype, newtype)

$(_doc_external(:MPI_Type_vector_c))
"""
function MPI_Type_vector_c(count, blocklength, stride, oldtype, newtype)
    @mpichk ccall((:MPI_Type_vector_c, libmpi), Cint, (MPI_Count, MPI_Count, MPI_Count, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

"""
    MPI_Unpack_c(inbuf, insize, position, outbuf, outcount, datatype, comm)

$(_doc_external(:MPI_Unpack_c))
"""
function MPI_Unpack_c(inbuf, insize, position, outbuf, outcount, datatype, comm)
    @mpichk ccall((:MPI_Unpack_c, libmpi), Cint, (MPIPtr, MPI_Count, Ptr{MPI_Count}, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm), inbuf, insize, position, outbuf, outcount, datatype, comm)
end

"""
    MPI_Unpack_external_c(datarep, inbuf, insize, position, outbuf, outcount, datatype)

$(_doc_external(:MPI_Unpack_external_c))
"""
function MPI_Unpack_external_c(datarep, inbuf, insize, position, outbuf, outcount, datatype)
    @mpichk ccall((:MPI_Unpack_external_c, libmpi), Cint, (Ptr{Cchar}, MPIPtr, MPI_Count, Ptr{MPI_Count}, MPIPtr, MPI_Count, MPI_Datatype), datarep, inbuf, insize, position, outbuf, outcount, datatype)
end

"""
    MPI_Op_create_c(user_fn, commute, op)

$(_doc_external(:MPI_Op_create_c))
"""
function MPI_Op_create_c(user_fn, commute, op)
    @mpichk ccall((:MPI_Op_create_c, libmpi), Cint, (MPIPtr, Cint, Ptr{MPI_Op}), user_fn, commute, op)
end

"""
    MPI_Bsend_c(buf, count, datatype, dest, tag, comm)

$(_doc_external(:MPI_Bsend_c))
"""
function MPI_Bsend_c(buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:MPI_Bsend_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

"""
    MPI_Bsend_init_c(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Bsend_init_c))
"""
function MPI_Bsend_init_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Bsend_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Buffer_attach_c(buffer, size)

$(_doc_external(:MPI_Buffer_attach_c))
"""
function MPI_Buffer_attach_c(buffer, size)
    @mpichk ccall((:MPI_Buffer_attach_c, libmpi), Cint, (MPIPtr, MPI_Count), buffer, size)
end

"""
    MPI_Buffer_detach_c(buffer_addr, size)

$(_doc_external(:MPI_Buffer_detach_c))
"""
function MPI_Buffer_detach_c(buffer_addr, size)
    @mpichk ccall((:MPI_Buffer_detach_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}), buffer_addr, size)
end

"""
    MPI_Ibsend_c(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Ibsend_c))
"""
function MPI_Ibsend_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Ibsend_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Imrecv_c(buf, count, datatype, message, request)

$(_doc_external(:MPI_Imrecv_c))
"""
function MPI_Imrecv_c(buf, count, datatype, message, request)
    @mpichk ccall((:MPI_Imrecv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Request}), buf, count, datatype, message, request)
end

"""
    MPI_Irecv_c(buf, count, datatype, source, tag, comm, request)

$(_doc_external(:MPI_Irecv_c))
"""
function MPI_Irecv_c(buf, count, datatype, source, tag, comm, request)
    @mpichk ccall((:MPI_Irecv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, source, tag, comm, request)
end

"""
    MPI_Irsend_c(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Irsend_c))
"""
function MPI_Irsend_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Irsend_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Isend_c(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Isend_c))
"""
function MPI_Isend_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Isend_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Isendrecv_c(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)

$(_doc_external(:MPI_Isendrecv_c))
"""
function MPI_Isendrecv_c(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
    @mpichk ccall((:MPI_Isendrecv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
end

"""
    MPI_Isendrecv_replace_c(buf, count, datatype, dest, sendtag, source, recvtag, comm, request)

$(_doc_external(:MPI_Isendrecv_replace_c))
"""
function MPI_Isendrecv_replace_c(buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
    @mpichk ccall((:MPI_Isendrecv_replace_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
end

"""
    MPI_Issend_c(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Issend_c))
"""
function MPI_Issend_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Issend_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Mrecv_c(buf, count, datatype, message, status)

$(_doc_external(:MPI_Mrecv_c))
"""
function MPI_Mrecv_c(buf, count, datatype, message, status)
    @mpichk ccall((:MPI_Mrecv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Status}), buf, count, datatype, message, status)
end

"""
    MPI_Recv_c(buf, count, datatype, source, tag, comm, status)

$(_doc_external(:MPI_Recv_c))
"""
function MPI_Recv_c(buf, count, datatype, source, tag, comm, status)
    @mpichk ccall((:MPI_Recv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), buf, count, datatype, source, tag, comm, status)
end

"""
    MPI_Recv_init_c(buf, count, datatype, source, tag, comm, request)

$(_doc_external(:MPI_Recv_init_c))
"""
function MPI_Recv_init_c(buf, count, datatype, source, tag, comm, request)
    @mpichk ccall((:MPI_Recv_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, source, tag, comm, request)
end

"""
    MPI_Rsend_c(buf, count, datatype, dest, tag, comm)

$(_doc_external(:MPI_Rsend_c))
"""
function MPI_Rsend_c(buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:MPI_Rsend_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

"""
    MPI_Rsend_init_c(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Rsend_init_c))
"""
function MPI_Rsend_init_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Rsend_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Send_c(buf, count, datatype, dest, tag, comm)

$(_doc_external(:MPI_Send_c))
"""
function MPI_Send_c(buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:MPI_Send_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

"""
    MPI_Send_init_c(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Send_init_c))
"""
function MPI_Send_init_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Send_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Sendrecv_c(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)

$(_doc_external(:MPI_Sendrecv_c))
"""
function MPI_Sendrecv_c(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
    @mpichk ccall((:MPI_Sendrecv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
end

"""
    MPI_Sendrecv_replace_c(buf, count, datatype, dest, sendtag, source, recvtag, comm, status)

$(_doc_external(:MPI_Sendrecv_replace_c))
"""
function MPI_Sendrecv_replace_c(buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
    @mpichk ccall((:MPI_Sendrecv_replace_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
end

"""
    MPI_Ssend_c(buf, count, datatype, dest, tag, comm)

$(_doc_external(:MPI_Ssend_c))
"""
function MPI_Ssend_c(buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:MPI_Ssend_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

"""
    MPI_Ssend_init_c(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Ssend_init_c))
"""
function MPI_Ssend_init_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Ssend_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Accumulate_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)

$(_doc_external(:MPI_Accumulate_c))
"""
function MPI_Accumulate_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    @mpichk ccall((:MPI_Accumulate_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Op, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

"""
    MPI_Get_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)

$(_doc_external(:MPI_Get_c))
"""
function MPI_Get_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    @mpichk ccall((:MPI_Get_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

"""
    MPI_Get_accumulate_c(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)

$(_doc_external(:MPI_Get_accumulate_c))
"""
function MPI_Get_accumulate_c(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    @mpichk ccall((:MPI_Get_accumulate_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Op, MPI_Win), origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

"""
    MPI_Put_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)

$(_doc_external(:MPI_Put_c))
"""
function MPI_Put_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    @mpichk ccall((:MPI_Put_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

"""
    MPI_Raccumulate_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)

$(_doc_external(:MPI_Raccumulate_c))
"""
function MPI_Raccumulate_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    @mpichk ccall((:MPI_Raccumulate_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

"""
    MPI_Rget_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)

$(_doc_external(:MPI_Rget_c))
"""
function MPI_Rget_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    @mpichk ccall((:MPI_Rget_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

"""
    MPI_Rget_accumulate_c(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)

$(_doc_external(:MPI_Rget_accumulate_c))
"""
function MPI_Rget_accumulate_c(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    @mpichk ccall((:MPI_Rget_accumulate_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

"""
    MPI_Rput_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)

$(_doc_external(:MPI_Rput_c))
"""
function MPI_Rput_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    @mpichk ccall((:MPI_Rput_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

"""
    MPI_Win_allocate_c(size, disp_unit, info, comm, baseptr, win)

$(_doc_external(:MPI_Win_allocate_c))
"""
function MPI_Win_allocate_c(size, disp_unit, info, comm, baseptr, win)
    @mpichk ccall((:MPI_Win_allocate_c, libmpi), Cint, (MPI_Aint, MPI_Aint, MPI_Info, MPI_Comm, MPIPtr, Ptr{MPI_Win}), size, disp_unit, info, comm, baseptr, win)
end

"""
    MPI_Win_allocate_shared_c(size, disp_unit, info, comm, baseptr, win)

$(_doc_external(:MPI_Win_allocate_shared_c))
"""
function MPI_Win_allocate_shared_c(size, disp_unit, info, comm, baseptr, win)
    @mpichk ccall((:MPI_Win_allocate_shared_c, libmpi), Cint, (MPI_Aint, MPI_Aint, MPI_Info, MPI_Comm, MPIPtr, Ptr{MPI_Win}), size, disp_unit, info, comm, baseptr, win)
end

"""
    MPI_Win_create_c(base, size, disp_unit, info, comm, win)

$(_doc_external(:MPI_Win_create_c))
"""
function MPI_Win_create_c(base, size, disp_unit, info, comm, win)
    @mpichk ccall((:MPI_Win_create_c, libmpi), Cint, (MPIPtr, MPI_Aint, MPI_Aint, MPI_Info, MPI_Comm, Ptr{MPI_Win}), base, size, disp_unit, info, comm, win)
end

"""
    MPI_Win_shared_query_c(win, rank, size, disp_unit, baseptr)

$(_doc_external(:MPI_Win_shared_query_c))
"""
function MPI_Win_shared_query_c(win, rank, size, disp_unit, baseptr)
    @mpichk ccall((:MPI_Win_shared_query_c, libmpi), Cint, (MPI_Win, Cint, Ptr{MPI_Aint}, Ptr{MPI_Aint}, MPIPtr), win, rank, size, disp_unit, baseptr)
end

"""
    PMPI_Status_c2f(c_status, f_status)

$(_doc_external(:PMPI_Status_c2f))
"""
function PMPI_Status_c2f(c_status, f_status)
    @mpichk ccall((:PMPI_Status_c2f, libmpi), Cint, (Ptr{MPI_Status}, Ptr{MPI_Fint}), c_status, f_status)
end

"""
    PMPI_Status_f2c(f_status, c_status)

$(_doc_external(:PMPI_Status_f2c))
"""
function PMPI_Status_f2c(f_status, c_status)
    @mpichk ccall((:PMPI_Status_f2c, libmpi), Cint, (Ptr{MPI_Fint}, Ptr{MPI_Status}), f_status, c_status)
end

"""
    PMPI_Status_f082c(f08_status, c_status)

$(_doc_external(:PMPI_Status_f082c))
"""
function PMPI_Status_f082c(f08_status, c_status)
    @mpichk ccall((:PMPI_Status_f082c, libmpi), Cint, (Ptr{MPI_F08_status}, Ptr{MPI_Status}), f08_status, c_status)
end

"""
    PMPI_Status_c2f08(c_status, f08_status)

$(_doc_external(:PMPI_Status_c2f08))
"""
function PMPI_Status_c2f08(c_status, f08_status)
    @mpichk ccall((:PMPI_Status_c2f08, libmpi), Cint, (Ptr{MPI_Status}, Ptr{MPI_F08_status}), c_status, f08_status)
end

"""
    PMPI_Status_f082f(f08_status, f_status)

$(_doc_external(:PMPI_Status_f082f))
"""
function PMPI_Status_f082f(f08_status, f_status)
    @mpichk ccall((:PMPI_Status_f082f, libmpi), Cint, (Ptr{MPI_F08_status}, Ptr{MPI_Fint}), f08_status, f_status)
end

"""
    PMPI_Status_f2f08(f_status, f08_status)

$(_doc_external(:PMPI_Status_f2f08))
"""
function PMPI_Status_f2f08(f_status, f08_status)
    @mpichk ccall((:PMPI_Status_f2f08, libmpi), Cint, (Ptr{MPI_Fint}, Ptr{MPI_F08_status}), f_status, f08_status)
end

"""
    PMPI_Type_create_f90_integer(r, newtype)

$(_doc_external(:PMPI_Type_create_f90_integer))
"""
function PMPI_Type_create_f90_integer(r, newtype)
    @mpichk ccall((:PMPI_Type_create_f90_integer, libmpi), Cint, (Cint, Ptr{MPI_Datatype}), r, newtype)
end

"""
    PMPI_Type_create_f90_real(p, r, newtype)

$(_doc_external(:PMPI_Type_create_f90_real))
"""
function PMPI_Type_create_f90_real(p, r, newtype)
    @mpichk ccall((:PMPI_Type_create_f90_real, libmpi), Cint, (Cint, Cint, Ptr{MPI_Datatype}), p, r, newtype)
end

"""
    PMPI_Type_create_f90_complex(p, r, newtype)

$(_doc_external(:PMPI_Type_create_f90_complex))
"""
function PMPI_Type_create_f90_complex(p, r, newtype)
    @mpichk ccall((:PMPI_Type_create_f90_complex, libmpi), Cint, (Cint, Cint, Ptr{MPI_Datatype}), p, r, newtype)
end

"""
    PMPI_Attr_delete(comm, keyval)

$(_doc_external(:PMPI_Attr_delete))
"""
function PMPI_Attr_delete(comm, keyval)
    @mpichk ccall((:PMPI_Attr_delete, libmpi), Cint, (MPI_Comm, Cint), comm, keyval)
end

"""
    PMPI_Attr_get(comm, keyval, attribute_val, flag)

$(_doc_external(:PMPI_Attr_get))
"""
function PMPI_Attr_get(comm, keyval, attribute_val, flag)
    @mpichk ccall((:PMPI_Attr_get, libmpi), Cint, (MPI_Comm, Cint, MPIPtr, Ptr{Cint}), comm, keyval, attribute_val, flag)
end

"""
    PMPI_Attr_put(comm, keyval, attribute_val)

$(_doc_external(:PMPI_Attr_put))
"""
function PMPI_Attr_put(comm, keyval, attribute_val)
    @mpichk ccall((:PMPI_Attr_put, libmpi), Cint, (MPI_Comm, Cint, MPIPtr), comm, keyval, attribute_val)
end

"""
    PMPI_Comm_create_keyval(comm_copy_attr_fn, comm_delete_attr_fn, comm_keyval, extra_state)

$(_doc_external(:PMPI_Comm_create_keyval))
"""
function PMPI_Comm_create_keyval(comm_copy_attr_fn, comm_delete_attr_fn, comm_keyval, extra_state)
    @mpichk ccall((:PMPI_Comm_create_keyval, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{Cint}, MPIPtr), comm_copy_attr_fn, comm_delete_attr_fn, comm_keyval, extra_state)
end

"""
    PMPI_Comm_delete_attr(comm, comm_keyval)

$(_doc_external(:PMPI_Comm_delete_attr))
"""
function PMPI_Comm_delete_attr(comm, comm_keyval)
    @mpichk ccall((:PMPI_Comm_delete_attr, libmpi), Cint, (MPI_Comm, Cint), comm, comm_keyval)
end

"""
    PMPI_Comm_free_keyval(comm_keyval)

$(_doc_external(:PMPI_Comm_free_keyval))
"""
function PMPI_Comm_free_keyval(comm_keyval)
    @mpichk ccall((:PMPI_Comm_free_keyval, libmpi), Cint, (Ptr{Cint},), comm_keyval)
end

"""
    PMPI_Comm_get_attr(comm, comm_keyval, attribute_val, flag)

$(_doc_external(:PMPI_Comm_get_attr))
"""
function PMPI_Comm_get_attr(comm, comm_keyval, attribute_val, flag)
    @mpichk ccall((:PMPI_Comm_get_attr, libmpi), Cint, (MPI_Comm, Cint, MPIPtr, Ptr{Cint}), comm, comm_keyval, attribute_val, flag)
end

"""
    PMPI_Comm_set_attr(comm, comm_keyval, attribute_val)

$(_doc_external(:PMPI_Comm_set_attr))
"""
function PMPI_Comm_set_attr(comm, comm_keyval, attribute_val)
    @mpichk ccall((:PMPI_Comm_set_attr, libmpi), Cint, (MPI_Comm, Cint, MPIPtr), comm, comm_keyval, attribute_val)
end

"""
    PMPI_Keyval_create(copy_fn, delete_fn, keyval, extra_state)

$(_doc_external(:PMPI_Keyval_create))
"""
function PMPI_Keyval_create(copy_fn, delete_fn, keyval, extra_state)
    @mpichk ccall((:PMPI_Keyval_create, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{Cint}, MPIPtr), copy_fn, delete_fn, keyval, extra_state)
end

"""
    PMPI_Keyval_free(keyval)

$(_doc_external(:PMPI_Keyval_free))
"""
function PMPI_Keyval_free(keyval)
    @mpichk ccall((:PMPI_Keyval_free, libmpi), Cint, (Ptr{Cint},), keyval)
end

"""
    PMPI_Type_create_keyval(type_copy_attr_fn, type_delete_attr_fn, type_keyval, extra_state)

$(_doc_external(:PMPI_Type_create_keyval))
"""
function PMPI_Type_create_keyval(type_copy_attr_fn, type_delete_attr_fn, type_keyval, extra_state)
    @mpichk ccall((:PMPI_Type_create_keyval, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{Cint}, MPIPtr), type_copy_attr_fn, type_delete_attr_fn, type_keyval, extra_state)
end

"""
    PMPI_Type_delete_attr(datatype, type_keyval)

$(_doc_external(:PMPI_Type_delete_attr))
"""
function PMPI_Type_delete_attr(datatype, type_keyval)
    @mpichk ccall((:PMPI_Type_delete_attr, libmpi), Cint, (MPI_Datatype, Cint), datatype, type_keyval)
end

"""
    PMPI_Type_free_keyval(type_keyval)

$(_doc_external(:PMPI_Type_free_keyval))
"""
function PMPI_Type_free_keyval(type_keyval)
    @mpichk ccall((:PMPI_Type_free_keyval, libmpi), Cint, (Ptr{Cint},), type_keyval)
end

"""
    PMPI_Type_get_attr(datatype, type_keyval, attribute_val, flag)

$(_doc_external(:PMPI_Type_get_attr))
"""
function PMPI_Type_get_attr(datatype, type_keyval, attribute_val, flag)
    @mpichk ccall((:PMPI_Type_get_attr, libmpi), Cint, (MPI_Datatype, Cint, MPIPtr, Ptr{Cint}), datatype, type_keyval, attribute_val, flag)
end

"""
    PMPI_Type_set_attr(datatype, type_keyval, attribute_val)

$(_doc_external(:PMPI_Type_set_attr))
"""
function PMPI_Type_set_attr(datatype, type_keyval, attribute_val)
    @mpichk ccall((:PMPI_Type_set_attr, libmpi), Cint, (MPI_Datatype, Cint, MPIPtr), datatype, type_keyval, attribute_val)
end

"""
    PMPI_Win_create_keyval(win_copy_attr_fn, win_delete_attr_fn, win_keyval, extra_state)

$(_doc_external(:PMPI_Win_create_keyval))
"""
function PMPI_Win_create_keyval(win_copy_attr_fn, win_delete_attr_fn, win_keyval, extra_state)
    @mpichk ccall((:PMPI_Win_create_keyval, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{Cint}, MPIPtr), win_copy_attr_fn, win_delete_attr_fn, win_keyval, extra_state)
end

"""
    PMPI_Win_delete_attr(win, win_keyval)

$(_doc_external(:PMPI_Win_delete_attr))
"""
function PMPI_Win_delete_attr(win, win_keyval)
    @mpichk ccall((:PMPI_Win_delete_attr, libmpi), Cint, (MPI_Win, Cint), win, win_keyval)
end

"""
    PMPI_Win_free_keyval(win_keyval)

$(_doc_external(:PMPI_Win_free_keyval))
"""
function PMPI_Win_free_keyval(win_keyval)
    @mpichk ccall((:PMPI_Win_free_keyval, libmpi), Cint, (Ptr{Cint},), win_keyval)
end

"""
    PMPI_Win_get_attr(win, win_keyval, attribute_val, flag)

$(_doc_external(:PMPI_Win_get_attr))
"""
function PMPI_Win_get_attr(win, win_keyval, attribute_val, flag)
    @mpichk ccall((:PMPI_Win_get_attr, libmpi), Cint, (MPI_Win, Cint, MPIPtr, Ptr{Cint}), win, win_keyval, attribute_val, flag)
end

"""
    PMPI_Win_set_attr(win, win_keyval, attribute_val)

$(_doc_external(:PMPI_Win_set_attr))
"""
function PMPI_Win_set_attr(win, win_keyval, attribute_val)
    @mpichk ccall((:PMPI_Win_set_attr, libmpi), Cint, (MPI_Win, Cint, MPIPtr), win, win_keyval, attribute_val)
end

"""
    PMPI_Allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:PMPI_Allgather))
"""
function PMPI_Allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:PMPI_Allgather, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

"""
    PMPI_Allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:PMPI_Allgather_c))
"""
function PMPI_Allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:PMPI_Allgather_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

"""
    PMPI_Allgather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:PMPI_Allgather_init))
"""
function PMPI_Allgather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:PMPI_Allgather_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    PMPI_Allgather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:PMPI_Allgather_init_c))
"""
function PMPI_Allgather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:PMPI_Allgather_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    PMPI_Allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)

$(_doc_external(:PMPI_Allgatherv))
"""
function PMPI_Allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    @mpichk ccall((:PMPI_Allgatherv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

"""
    PMPI_Allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)

$(_doc_external(:PMPI_Allgatherv_c))
"""
function PMPI_Allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    @mpichk ccall((:PMPI_Allgatherv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

"""
    PMPI_Allgatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)

$(_doc_external(:PMPI_Allgatherv_init))
"""
function PMPI_Allgatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    @mpichk ccall((:PMPI_Allgatherv_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
end

"""
    PMPI_Allgatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)

$(_doc_external(:PMPI_Allgatherv_init_c))
"""
function PMPI_Allgatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    @mpichk ccall((:PMPI_Allgatherv_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
end

"""
    PMPI_Allreduce(sendbuf, recvbuf, count, datatype, op, comm)

$(_doc_external(:PMPI_Allreduce))
"""
function PMPI_Allreduce(sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk ccall((:PMPI_Allreduce, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

"""
    PMPI_Allreduce_c(sendbuf, recvbuf, count, datatype, op, comm)

$(_doc_external(:PMPI_Allreduce_c))
"""
function PMPI_Allreduce_c(sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk ccall((:PMPI_Allreduce_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

"""
    PMPI_Allreduce_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)

$(_doc_external(:PMPI_Allreduce_init))
"""
function PMPI_Allreduce_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk ccall((:PMPI_Allreduce_init, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

"""
    PMPI_Allreduce_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)

$(_doc_external(:PMPI_Allreduce_init_c))
"""
function PMPI_Allreduce_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk ccall((:PMPI_Allreduce_init_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

"""
    PMPI_Alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:PMPI_Alltoall))
"""
function PMPI_Alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:PMPI_Alltoall, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

"""
    PMPI_Alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:PMPI_Alltoall_c))
"""
function PMPI_Alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:PMPI_Alltoall_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

"""
    PMPI_Alltoall_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:PMPI_Alltoall_init))
"""
function PMPI_Alltoall_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:PMPI_Alltoall_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    PMPI_Alltoall_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:PMPI_Alltoall_init_c))
"""
function PMPI_Alltoall_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:PMPI_Alltoall_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    PMPI_Alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)

$(_doc_external(:PMPI_Alltoallv))
"""
function PMPI_Alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    @mpichk ccall((:PMPI_Alltoallv, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

"""
    PMPI_Alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)

$(_doc_external(:PMPI_Alltoallv_c))
"""
function PMPI_Alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    @mpichk ccall((:PMPI_Alltoallv_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

"""
    PMPI_Alltoallv_init(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)

$(_doc_external(:PMPI_Alltoallv_init))
"""
function PMPI_Alltoallv_init(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    @mpichk ccall((:PMPI_Alltoallv_init, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
end

"""
    PMPI_Alltoallv_init_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)

$(_doc_external(:PMPI_Alltoallv_init_c))
"""
function PMPI_Alltoallv_init_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    @mpichk ccall((:PMPI_Alltoallv_init_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
end

"""
    PMPI_Alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)

$(_doc_external(:PMPI_Alltoallw))
"""
function PMPI_Alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    @mpichk ccall((:PMPI_Alltoallw, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPI_Comm), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

"""
    PMPI_Alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)

$(_doc_external(:PMPI_Alltoallw_c))
"""
function PMPI_Alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    @mpichk ccall((:PMPI_Alltoallw_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

"""
    PMPI_Alltoallw_init(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)

$(_doc_external(:PMPI_Alltoallw_init))
"""
function PMPI_Alltoallw_init(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    @mpichk ccall((:PMPI_Alltoallw_init, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
end

"""
    PMPI_Alltoallw_init_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)

$(_doc_external(:PMPI_Alltoallw_init_c))
"""
function PMPI_Alltoallw_init_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    @mpichk ccall((:PMPI_Alltoallw_init_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
end

"""
    PMPI_Barrier(comm)

$(_doc_external(:PMPI_Barrier))
"""
function PMPI_Barrier(comm)
    @mpichk ccall((:PMPI_Barrier, libmpi), Cint, (MPI_Comm,), comm)
end

"""
    PMPI_Barrier_init(comm, info, request)

$(_doc_external(:PMPI_Barrier_init))
"""
function PMPI_Barrier_init(comm, info, request)
    @mpichk ccall((:PMPI_Barrier_init, libmpi), Cint, (MPI_Comm, MPI_Info, Ptr{MPI_Request}), comm, info, request)
end

"""
    PMPI_Bcast(buffer, count, datatype, root, comm)

$(_doc_external(:PMPI_Bcast))
"""
function PMPI_Bcast(buffer, count, datatype, root, comm)
    @mpichk ccall((:PMPI_Bcast, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm), buffer, count, datatype, root, comm)
end

"""
    PMPI_Bcast_c(buffer, count, datatype, root, comm)

$(_doc_external(:PMPI_Bcast_c))
"""
function PMPI_Bcast_c(buffer, count, datatype, root, comm)
    @mpichk ccall((:PMPI_Bcast_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm), buffer, count, datatype, root, comm)
end

"""
    PMPI_Bcast_init(buffer, count, datatype, root, comm, info, request)

$(_doc_external(:PMPI_Bcast_init))
"""
function PMPI_Bcast_init(buffer, count, datatype, root, comm, info, request)
    @mpichk ccall((:PMPI_Bcast_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), buffer, count, datatype, root, comm, info, request)
end

"""
    PMPI_Bcast_init_c(buffer, count, datatype, root, comm, info, request)

$(_doc_external(:PMPI_Bcast_init_c))
"""
function PMPI_Bcast_init_c(buffer, count, datatype, root, comm, info, request)
    @mpichk ccall((:PMPI_Bcast_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), buffer, count, datatype, root, comm, info, request)
end

"""
    PMPI_Exscan(sendbuf, recvbuf, count, datatype, op, comm)

$(_doc_external(:PMPI_Exscan))
"""
function PMPI_Exscan(sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk ccall((:PMPI_Exscan, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

"""
    PMPI_Exscan_c(sendbuf, recvbuf, count, datatype, op, comm)

$(_doc_external(:PMPI_Exscan_c))
"""
function PMPI_Exscan_c(sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk ccall((:PMPI_Exscan_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

"""
    PMPI_Exscan_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)

$(_doc_external(:PMPI_Exscan_init))
"""
function PMPI_Exscan_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk ccall((:PMPI_Exscan_init, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

"""
    PMPI_Exscan_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)

$(_doc_external(:PMPI_Exscan_init_c))
"""
function PMPI_Exscan_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk ccall((:PMPI_Exscan_init_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

"""
    PMPI_Gather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)

$(_doc_external(:PMPI_Gather))
"""
function PMPI_Gather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk ccall((:PMPI_Gather, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

"""
    PMPI_Gather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)

$(_doc_external(:PMPI_Gather_c))
"""
function PMPI_Gather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk ccall((:PMPI_Gather_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

"""
    PMPI_Gather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

$(_doc_external(:PMPI_Gather_init))
"""
function PMPI_Gather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk ccall((:PMPI_Gather_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

"""
    PMPI_Gather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

$(_doc_external(:PMPI_Gather_init_c))
"""
function PMPI_Gather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk ccall((:PMPI_Gather_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

"""
    PMPI_Gatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)

$(_doc_external(:PMPI_Gatherv))
"""
function PMPI_Gatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
    @mpichk ccall((:PMPI_Gatherv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
end

"""
    PMPI_Gatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)

$(_doc_external(:PMPI_Gatherv_c))
"""
function PMPI_Gatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
    @mpichk ccall((:PMPI_Gatherv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
end

"""
    PMPI_Gatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)

$(_doc_external(:PMPI_Gatherv_init))
"""
function PMPI_Gatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
    @mpichk ccall((:PMPI_Gatherv_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
end

"""
    PMPI_Gatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)

$(_doc_external(:PMPI_Gatherv_init_c))
"""
function PMPI_Gatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
    @mpichk ccall((:PMPI_Gatherv_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
end

"""
    PMPI_Iallgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:PMPI_Iallgather))
"""
function PMPI_Iallgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:PMPI_Iallgather, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    PMPI_Iallgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:PMPI_Iallgather_c))
"""
function PMPI_Iallgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:PMPI_Iallgather_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    PMPI_Iallgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)

$(_doc_external(:PMPI_Iallgatherv))
"""
function PMPI_Iallgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    @mpichk ccall((:PMPI_Iallgatherv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

"""
    PMPI_Iallgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)

$(_doc_external(:PMPI_Iallgatherv_c))
"""
function PMPI_Iallgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    @mpichk ccall((:PMPI_Iallgatherv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

"""
    PMPI_Iallreduce(sendbuf, recvbuf, count, datatype, op, comm, request)

$(_doc_external(:PMPI_Iallreduce))
"""
function PMPI_Iallreduce(sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk ccall((:PMPI_Iallreduce, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

"""
    PMPI_Iallreduce_c(sendbuf, recvbuf, count, datatype, op, comm, request)

$(_doc_external(:PMPI_Iallreduce_c))
"""
function PMPI_Iallreduce_c(sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk ccall((:PMPI_Iallreduce_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

"""
    PMPI_Ialltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:PMPI_Ialltoall))
"""
function PMPI_Ialltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:PMPI_Ialltoall, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    PMPI_Ialltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:PMPI_Ialltoall_c))
"""
function PMPI_Ialltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:PMPI_Ialltoall_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    PMPI_Ialltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)

$(_doc_external(:PMPI_Ialltoallv))
"""
function PMPI_Ialltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    @mpichk ccall((:PMPI_Ialltoallv, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

"""
    PMPI_Ialltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)

$(_doc_external(:PMPI_Ialltoallv_c))
"""
function PMPI_Ialltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    @mpichk ccall((:PMPI_Ialltoallv_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

"""
    PMPI_Ialltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)

$(_doc_external(:PMPI_Ialltoallw))
"""
function PMPI_Ialltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    @mpichk ccall((:PMPI_Ialltoallw, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

"""
    PMPI_Ialltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)

$(_doc_external(:PMPI_Ialltoallw_c))
"""
function PMPI_Ialltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    @mpichk ccall((:PMPI_Ialltoallw_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

"""
    PMPI_Ibarrier(comm, request)

$(_doc_external(:PMPI_Ibarrier))
"""
function PMPI_Ibarrier(comm, request)
    @mpichk ccall((:PMPI_Ibarrier, libmpi), Cint, (MPI_Comm, Ptr{MPI_Request}), comm, request)
end

"""
    PMPI_Ibcast(buffer, count, datatype, root, comm, request)

$(_doc_external(:PMPI_Ibcast))
"""
function PMPI_Ibcast(buffer, count, datatype, root, comm, request)
    @mpichk ccall((:PMPI_Ibcast, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), buffer, count, datatype, root, comm, request)
end

"""
    PMPI_Ibcast_c(buffer, count, datatype, root, comm, request)

$(_doc_external(:PMPI_Ibcast_c))
"""
function PMPI_Ibcast_c(buffer, count, datatype, root, comm, request)
    @mpichk ccall((:PMPI_Ibcast_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), buffer, count, datatype, root, comm, request)
end

"""
    PMPI_Iexscan(sendbuf, recvbuf, count, datatype, op, comm, request)

$(_doc_external(:PMPI_Iexscan))
"""
function PMPI_Iexscan(sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk ccall((:PMPI_Iexscan, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

"""
    PMPI_Iexscan_c(sendbuf, recvbuf, count, datatype, op, comm, request)

$(_doc_external(:PMPI_Iexscan_c))
"""
function PMPI_Iexscan_c(sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk ccall((:PMPI_Iexscan_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

"""
    PMPI_Igather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

$(_doc_external(:PMPI_Igather))
"""
function PMPI_Igather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk ccall((:PMPI_Igather, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

"""
    PMPI_Igather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

$(_doc_external(:PMPI_Igather_c))
"""
function PMPI_Igather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk ccall((:PMPI_Igather_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

"""
    PMPI_Igatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)

$(_doc_external(:PMPI_Igatherv))
"""
function PMPI_Igatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
    @mpichk ccall((:PMPI_Igatherv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
end

"""
    PMPI_Igatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)

$(_doc_external(:PMPI_Igatherv_c))
"""
function PMPI_Igatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
    @mpichk ccall((:PMPI_Igatherv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
end

"""
    PMPI_Ineighbor_allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:PMPI_Ineighbor_allgather))
"""
function PMPI_Ineighbor_allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:PMPI_Ineighbor_allgather, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    PMPI_Ineighbor_allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:PMPI_Ineighbor_allgather_c))
"""
function PMPI_Ineighbor_allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:PMPI_Ineighbor_allgather_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    PMPI_Ineighbor_allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)

$(_doc_external(:PMPI_Ineighbor_allgatherv))
"""
function PMPI_Ineighbor_allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    @mpichk ccall((:PMPI_Ineighbor_allgatherv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

"""
    PMPI_Ineighbor_allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)

$(_doc_external(:PMPI_Ineighbor_allgatherv_c))
"""
function PMPI_Ineighbor_allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    @mpichk ccall((:PMPI_Ineighbor_allgatherv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

"""
    PMPI_Ineighbor_alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:PMPI_Ineighbor_alltoall))
"""
function PMPI_Ineighbor_alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:PMPI_Ineighbor_alltoall, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    PMPI_Ineighbor_alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:PMPI_Ineighbor_alltoall_c))
"""
function PMPI_Ineighbor_alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:PMPI_Ineighbor_alltoall_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    PMPI_Ineighbor_alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)

$(_doc_external(:PMPI_Ineighbor_alltoallv))
"""
function PMPI_Ineighbor_alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    @mpichk ccall((:PMPI_Ineighbor_alltoallv, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

"""
    PMPI_Ineighbor_alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)

$(_doc_external(:PMPI_Ineighbor_alltoallv_c))
"""
function PMPI_Ineighbor_alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    @mpichk ccall((:PMPI_Ineighbor_alltoallv_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

"""
    PMPI_Ineighbor_alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)

$(_doc_external(:PMPI_Ineighbor_alltoallw))
"""
function PMPI_Ineighbor_alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    @mpichk ccall((:PMPI_Ineighbor_alltoallw, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

"""
    PMPI_Ineighbor_alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)

$(_doc_external(:PMPI_Ineighbor_alltoallw_c))
"""
function PMPI_Ineighbor_alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    @mpichk ccall((:PMPI_Ineighbor_alltoallw_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

"""
    PMPI_Ireduce(sendbuf, recvbuf, count, datatype, op, root, comm, request)

$(_doc_external(:PMPI_Ireduce))
"""
function PMPI_Ireduce(sendbuf, recvbuf, count, datatype, op, root, comm, request)
    @mpichk ccall((:PMPI_Ireduce, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, root, comm, request)
end

"""
    PMPI_Ireduce_c(sendbuf, recvbuf, count, datatype, op, root, comm, request)

$(_doc_external(:PMPI_Ireduce_c))
"""
function PMPI_Ireduce_c(sendbuf, recvbuf, count, datatype, op, root, comm, request)
    @mpichk ccall((:PMPI_Ireduce_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, root, comm, request)
end

"""
    PMPI_Ireduce_scatter(sendbuf, recvbuf, recvcounts, datatype, op, comm, request)

$(_doc_external(:PMPI_Ireduce_scatter))
"""
function PMPI_Ireduce_scatter(sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
    @mpichk ccall((:PMPI_Ireduce_scatter, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{Cint}, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
end

"""
    PMPI_Ireduce_scatter_c(sendbuf, recvbuf, recvcounts, datatype, op, comm, request)

$(_doc_external(:PMPI_Ireduce_scatter_c))
"""
function PMPI_Ireduce_scatter_c(sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
    @mpichk ccall((:PMPI_Ireduce_scatter_c, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{MPI_Count}, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
end

"""
    PMPI_Ireduce_scatter_block(sendbuf, recvbuf, recvcount, datatype, op, comm, request)

$(_doc_external(:PMPI_Ireduce_scatter_block))
"""
function PMPI_Ireduce_scatter_block(sendbuf, recvbuf, recvcount, datatype, op, comm, request)
    @mpichk ccall((:PMPI_Ireduce_scatter_block, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, recvcount, datatype, op, comm, request)
end

"""
    PMPI_Ireduce_scatter_block_c(sendbuf, recvbuf, recvcount, datatype, op, comm, request)

$(_doc_external(:PMPI_Ireduce_scatter_block_c))
"""
function PMPI_Ireduce_scatter_block_c(sendbuf, recvbuf, recvcount, datatype, op, comm, request)
    @mpichk ccall((:PMPI_Ireduce_scatter_block_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, recvcount, datatype, op, comm, request)
end

"""
    PMPI_Iscan(sendbuf, recvbuf, count, datatype, op, comm, request)

$(_doc_external(:PMPI_Iscan))
"""
function PMPI_Iscan(sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk ccall((:PMPI_Iscan, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

"""
    PMPI_Iscan_c(sendbuf, recvbuf, count, datatype, op, comm, request)

$(_doc_external(:PMPI_Iscan_c))
"""
function PMPI_Iscan_c(sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk ccall((:PMPI_Iscan_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

"""
    PMPI_Iscatter(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

$(_doc_external(:PMPI_Iscatter))
"""
function PMPI_Iscatter(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk ccall((:PMPI_Iscatter, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

"""
    PMPI_Iscatter_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

$(_doc_external(:PMPI_Iscatter_c))
"""
function PMPI_Iscatter_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk ccall((:PMPI_Iscatter_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

"""
    PMPI_Iscatterv(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

$(_doc_external(:PMPI_Iscatterv))
"""
function PMPI_Iscatterv(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk ccall((:PMPI_Iscatterv, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

"""
    PMPI_Iscatterv_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

$(_doc_external(:PMPI_Iscatterv_c))
"""
function PMPI_Iscatterv_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk ccall((:PMPI_Iscatterv_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

"""
    PMPI_Neighbor_allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:PMPI_Neighbor_allgather))
"""
function PMPI_Neighbor_allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:PMPI_Neighbor_allgather, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

"""
    PMPI_Neighbor_allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:PMPI_Neighbor_allgather_c))
"""
function PMPI_Neighbor_allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:PMPI_Neighbor_allgather_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

"""
    PMPI_Neighbor_allgather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:PMPI_Neighbor_allgather_init))
"""
function PMPI_Neighbor_allgather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:PMPI_Neighbor_allgather_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    PMPI_Neighbor_allgather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:PMPI_Neighbor_allgather_init_c))
"""
function PMPI_Neighbor_allgather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:PMPI_Neighbor_allgather_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    PMPI_Neighbor_allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)

$(_doc_external(:PMPI_Neighbor_allgatherv))
"""
function PMPI_Neighbor_allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    @mpichk ccall((:PMPI_Neighbor_allgatherv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

"""
    PMPI_Neighbor_allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)

$(_doc_external(:PMPI_Neighbor_allgatherv_c))
"""
function PMPI_Neighbor_allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    @mpichk ccall((:PMPI_Neighbor_allgatherv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

"""
    PMPI_Neighbor_allgatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)

$(_doc_external(:PMPI_Neighbor_allgatherv_init))
"""
function PMPI_Neighbor_allgatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    @mpichk ccall((:PMPI_Neighbor_allgatherv_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
end

"""
    PMPI_Neighbor_allgatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)

$(_doc_external(:PMPI_Neighbor_allgatherv_init_c))
"""
function PMPI_Neighbor_allgatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    @mpichk ccall((:PMPI_Neighbor_allgatherv_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
end

"""
    PMPI_Neighbor_alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:PMPI_Neighbor_alltoall))
"""
function PMPI_Neighbor_alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:PMPI_Neighbor_alltoall, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

"""
    PMPI_Neighbor_alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:PMPI_Neighbor_alltoall_c))
"""
function PMPI_Neighbor_alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:PMPI_Neighbor_alltoall_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

"""
    PMPI_Neighbor_alltoall_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:PMPI_Neighbor_alltoall_init))
"""
function PMPI_Neighbor_alltoall_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:PMPI_Neighbor_alltoall_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    PMPI_Neighbor_alltoall_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:PMPI_Neighbor_alltoall_init_c))
"""
function PMPI_Neighbor_alltoall_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:PMPI_Neighbor_alltoall_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    PMPI_Neighbor_alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)

$(_doc_external(:PMPI_Neighbor_alltoallv))
"""
function PMPI_Neighbor_alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    @mpichk ccall((:PMPI_Neighbor_alltoallv, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

"""
    PMPI_Neighbor_alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)

$(_doc_external(:PMPI_Neighbor_alltoallv_c))
"""
function PMPI_Neighbor_alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    @mpichk ccall((:PMPI_Neighbor_alltoallv_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

"""
    PMPI_Neighbor_alltoallv_init(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)

$(_doc_external(:PMPI_Neighbor_alltoallv_init))
"""
function PMPI_Neighbor_alltoallv_init(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    @mpichk ccall((:PMPI_Neighbor_alltoallv_init, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
end

"""
    PMPI_Neighbor_alltoallv_init_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)

$(_doc_external(:PMPI_Neighbor_alltoallv_init_c))
"""
function PMPI_Neighbor_alltoallv_init_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    @mpichk ccall((:PMPI_Neighbor_alltoallv_init_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
end

"""
    PMPI_Neighbor_alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)

$(_doc_external(:PMPI_Neighbor_alltoallw))
"""
function PMPI_Neighbor_alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    @mpichk ccall((:PMPI_Neighbor_alltoallw, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

"""
    PMPI_Neighbor_alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)

$(_doc_external(:PMPI_Neighbor_alltoallw_c))
"""
function PMPI_Neighbor_alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    @mpichk ccall((:PMPI_Neighbor_alltoallw_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

"""
    PMPI_Neighbor_alltoallw_init(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)

$(_doc_external(:PMPI_Neighbor_alltoallw_init))
"""
function PMPI_Neighbor_alltoallw_init(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    @mpichk ccall((:PMPI_Neighbor_alltoallw_init, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
end

"""
    PMPI_Neighbor_alltoallw_init_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)

$(_doc_external(:PMPI_Neighbor_alltoallw_init_c))
"""
function PMPI_Neighbor_alltoallw_init_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    @mpichk ccall((:PMPI_Neighbor_alltoallw_init_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
end

"""
    PMPI_Reduce(sendbuf, recvbuf, count, datatype, op, root, comm)

$(_doc_external(:PMPI_Reduce))
"""
function PMPI_Reduce(sendbuf, recvbuf, count, datatype, op, root, comm)
    @mpichk ccall((:PMPI_Reduce, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm), sendbuf, recvbuf, count, datatype, op, root, comm)
end

"""
    PMPI_Reduce_c(sendbuf, recvbuf, count, datatype, op, root, comm)

$(_doc_external(:PMPI_Reduce_c))
"""
function PMPI_Reduce_c(sendbuf, recvbuf, count, datatype, op, root, comm)
    @mpichk ccall((:PMPI_Reduce_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, Cint, MPI_Comm), sendbuf, recvbuf, count, datatype, op, root, comm)
end

"""
    PMPI_Reduce_init(sendbuf, recvbuf, count, datatype, op, root, comm, info, request)

$(_doc_external(:PMPI_Reduce_init))
"""
function PMPI_Reduce_init(sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
    @mpichk ccall((:PMPI_Reduce_init, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
end

"""
    PMPI_Reduce_init_c(sendbuf, recvbuf, count, datatype, op, root, comm, info, request)

$(_doc_external(:PMPI_Reduce_init_c))
"""
function PMPI_Reduce_init_c(sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
    @mpichk ccall((:PMPI_Reduce_init_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
end

"""
    PMPI_Reduce_local(inbuf, inoutbuf, count, datatype, op)

$(_doc_external(:PMPI_Reduce_local))
"""
function PMPI_Reduce_local(inbuf, inoutbuf, count, datatype, op)
    @mpichk ccall((:PMPI_Reduce_local, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op), inbuf, inoutbuf, count, datatype, op)
end

"""
    PMPI_Reduce_local_c(inbuf, inoutbuf, count, datatype, op)

$(_doc_external(:PMPI_Reduce_local_c))
"""
function PMPI_Reduce_local_c(inbuf, inoutbuf, count, datatype, op)
    @mpichk ccall((:PMPI_Reduce_local_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op), inbuf, inoutbuf, count, datatype, op)
end

"""
    PMPI_Reduce_scatter(sendbuf, recvbuf, recvcounts, datatype, op, comm)

$(_doc_external(:PMPI_Reduce_scatter))
"""
function PMPI_Reduce_scatter(sendbuf, recvbuf, recvcounts, datatype, op, comm)
    @mpichk ccall((:PMPI_Reduce_scatter, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{Cint}, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, recvcounts, datatype, op, comm)
end

"""
    PMPI_Reduce_scatter_c(sendbuf, recvbuf, recvcounts, datatype, op, comm)

$(_doc_external(:PMPI_Reduce_scatter_c))
"""
function PMPI_Reduce_scatter_c(sendbuf, recvbuf, recvcounts, datatype, op, comm)
    @mpichk ccall((:PMPI_Reduce_scatter_c, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{MPI_Count}, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, recvcounts, datatype, op, comm)
end

"""
    PMPI_Reduce_scatter_block(sendbuf, recvbuf, recvcount, datatype, op, comm)

$(_doc_external(:PMPI_Reduce_scatter_block))
"""
function PMPI_Reduce_scatter_block(sendbuf, recvbuf, recvcount, datatype, op, comm)
    @mpichk ccall((:PMPI_Reduce_scatter_block, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, recvcount, datatype, op, comm)
end

"""
    PMPI_Reduce_scatter_block_c(sendbuf, recvbuf, recvcount, datatype, op, comm)

$(_doc_external(:PMPI_Reduce_scatter_block_c))
"""
function PMPI_Reduce_scatter_block_c(sendbuf, recvbuf, recvcount, datatype, op, comm)
    @mpichk ccall((:PMPI_Reduce_scatter_block_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, recvcount, datatype, op, comm)
end

"""
    PMPI_Reduce_scatter_block_init(sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)

$(_doc_external(:PMPI_Reduce_scatter_block_init))
"""
function PMPI_Reduce_scatter_block_init(sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
    @mpichk ccall((:PMPI_Reduce_scatter_block_init, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
end

"""
    PMPI_Reduce_scatter_block_init_c(sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)

$(_doc_external(:PMPI_Reduce_scatter_block_init_c))
"""
function PMPI_Reduce_scatter_block_init_c(sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
    @mpichk ccall((:PMPI_Reduce_scatter_block_init_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
end

"""
    PMPI_Reduce_scatter_init(sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)

$(_doc_external(:PMPI_Reduce_scatter_init))
"""
function PMPI_Reduce_scatter_init(sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
    @mpichk ccall((:PMPI_Reduce_scatter_init, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{Cint}, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
end

"""
    PMPI_Reduce_scatter_init_c(sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)

$(_doc_external(:PMPI_Reduce_scatter_init_c))
"""
function PMPI_Reduce_scatter_init_c(sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
    @mpichk ccall((:PMPI_Reduce_scatter_init_c, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{MPI_Count}, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
end

"""
    PMPI_Scan(sendbuf, recvbuf, count, datatype, op, comm)

$(_doc_external(:PMPI_Scan))
"""
function PMPI_Scan(sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk ccall((:PMPI_Scan, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

"""
    PMPI_Scan_c(sendbuf, recvbuf, count, datatype, op, comm)

$(_doc_external(:PMPI_Scan_c))
"""
function PMPI_Scan_c(sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk ccall((:PMPI_Scan_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

"""
    PMPI_Scan_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)

$(_doc_external(:PMPI_Scan_init))
"""
function PMPI_Scan_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk ccall((:PMPI_Scan_init, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

"""
    PMPI_Scan_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)

$(_doc_external(:PMPI_Scan_init_c))
"""
function PMPI_Scan_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk ccall((:PMPI_Scan_init_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

"""
    PMPI_Scatter(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)

$(_doc_external(:PMPI_Scatter))
"""
function PMPI_Scatter(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk ccall((:PMPI_Scatter, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

"""
    PMPI_Scatter_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)

$(_doc_external(:PMPI_Scatter_c))
"""
function PMPI_Scatter_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk ccall((:PMPI_Scatter_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

"""
    PMPI_Scatter_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

$(_doc_external(:PMPI_Scatter_init))
"""
function PMPI_Scatter_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk ccall((:PMPI_Scatter_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

"""
    PMPI_Scatter_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

$(_doc_external(:PMPI_Scatter_init_c))
"""
function PMPI_Scatter_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk ccall((:PMPI_Scatter_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

"""
    PMPI_Scatterv(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)

$(_doc_external(:PMPI_Scatterv))
"""
function PMPI_Scatterv(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk ccall((:PMPI_Scatterv, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

"""
    PMPI_Scatterv_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)

$(_doc_external(:PMPI_Scatterv_c))
"""
function PMPI_Scatterv_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk ccall((:PMPI_Scatterv_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

"""
    PMPI_Scatterv_init(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

$(_doc_external(:PMPI_Scatterv_init))
"""
function PMPI_Scatterv_init(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk ccall((:PMPI_Scatterv_init, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

"""
    PMPI_Scatterv_init_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

$(_doc_external(:PMPI_Scatterv_init_c))
"""
function PMPI_Scatterv_init_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk ccall((:PMPI_Scatterv_init_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

"""
    PMPI_Comm_compare(comm1, comm2, result)

$(_doc_external(:PMPI_Comm_compare))
"""
function PMPI_Comm_compare(comm1, comm2, result)
    @mpichk ccall((:PMPI_Comm_compare, libmpi), Cint, (MPI_Comm, MPI_Comm, Ptr{Cint}), comm1, comm2, result)
end

"""
    PMPI_Comm_create(comm, group, newcomm)

$(_doc_external(:PMPI_Comm_create))
"""
function PMPI_Comm_create(comm, group, newcomm)
    @mpichk ccall((:PMPI_Comm_create, libmpi), Cint, (MPI_Comm, MPI_Group, Ptr{MPI_Comm}), comm, group, newcomm)
end

"""
    PMPI_Comm_create_group(comm, group, tag, newcomm)

$(_doc_external(:PMPI_Comm_create_group))
"""
function PMPI_Comm_create_group(comm, group, tag, newcomm)
    @mpichk ccall((:PMPI_Comm_create_group, libmpi), Cint, (MPI_Comm, MPI_Group, Cint, Ptr{MPI_Comm}), comm, group, tag, newcomm)
end

"""
    PMPI_Comm_dup(comm, newcomm)

$(_doc_external(:PMPI_Comm_dup))
"""
function PMPI_Comm_dup(comm, newcomm)
    @mpichk ccall((:PMPI_Comm_dup, libmpi), Cint, (MPI_Comm, Ptr{MPI_Comm}), comm, newcomm)
end

"""
    PMPI_Comm_dup_with_info(comm, info, newcomm)

$(_doc_external(:PMPI_Comm_dup_with_info))
"""
function PMPI_Comm_dup_with_info(comm, info, newcomm)
    @mpichk ccall((:PMPI_Comm_dup_with_info, libmpi), Cint, (MPI_Comm, MPI_Info, Ptr{MPI_Comm}), comm, info, newcomm)
end

"""
    PMPI_Comm_free(comm)

$(_doc_external(:PMPI_Comm_free))
"""
function PMPI_Comm_free(comm)
    @mpichk ccall((:PMPI_Comm_free, libmpi), Cint, (Ptr{MPI_Comm},), comm)
end

"""
    PMPI_Comm_get_info(comm, info_used)

$(_doc_external(:PMPI_Comm_get_info))
"""
function PMPI_Comm_get_info(comm, info_used)
    @mpichk ccall((:PMPI_Comm_get_info, libmpi), Cint, (MPI_Comm, Ptr{MPI_Info}), comm, info_used)
end

"""
    PMPI_Comm_get_name(comm, comm_name, resultlen)

$(_doc_external(:PMPI_Comm_get_name))
"""
function PMPI_Comm_get_name(comm, comm_name, resultlen)
    @mpichk ccall((:PMPI_Comm_get_name, libmpi), Cint, (MPI_Comm, Ptr{Cchar}, Ptr{Cint}), comm, comm_name, resultlen)
end

"""
    PMPI_Comm_group(comm, group)

$(_doc_external(:PMPI_Comm_group))
"""
function PMPI_Comm_group(comm, group)
    @mpichk ccall((:PMPI_Comm_group, libmpi), Cint, (MPI_Comm, Ptr{MPI_Group}), comm, group)
end

"""
    PMPI_Comm_idup(comm, newcomm, request)

$(_doc_external(:PMPI_Comm_idup))
"""
function PMPI_Comm_idup(comm, newcomm, request)
    @mpichk ccall((:PMPI_Comm_idup, libmpi), Cint, (MPI_Comm, Ptr{MPI_Comm}, Ptr{MPI_Request}), comm, newcomm, request)
end

"""
    PMPI_Comm_idup_with_info(comm, info, newcomm, request)

$(_doc_external(:PMPI_Comm_idup_with_info))
"""
function PMPI_Comm_idup_with_info(comm, info, newcomm, request)
    @mpichk ccall((:PMPI_Comm_idup_with_info, libmpi), Cint, (MPI_Comm, MPI_Info, Ptr{MPI_Comm}, Ptr{MPI_Request}), comm, info, newcomm, request)
end

"""
    PMPI_Comm_rank(comm, rank)

$(_doc_external(:PMPI_Comm_rank))
"""
function PMPI_Comm_rank(comm, rank)
    @mpichk ccall((:PMPI_Comm_rank, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, rank)
end

"""
    PMPI_Comm_remote_group(comm, group)

$(_doc_external(:PMPI_Comm_remote_group))
"""
function PMPI_Comm_remote_group(comm, group)
    @mpichk ccall((:PMPI_Comm_remote_group, libmpi), Cint, (MPI_Comm, Ptr{MPI_Group}), comm, group)
end

"""
    PMPI_Comm_remote_size(comm, size)

$(_doc_external(:PMPI_Comm_remote_size))
"""
function PMPI_Comm_remote_size(comm, size)
    @mpichk ccall((:PMPI_Comm_remote_size, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, size)
end

"""
    PMPI_Comm_set_info(comm, info)

$(_doc_external(:PMPI_Comm_set_info))
"""
function PMPI_Comm_set_info(comm, info)
    @mpichk ccall((:PMPI_Comm_set_info, libmpi), Cint, (MPI_Comm, MPI_Info), comm, info)
end

"""
    PMPI_Comm_set_name(comm, comm_name)

$(_doc_external(:PMPI_Comm_set_name))
"""
function PMPI_Comm_set_name(comm, comm_name)
    @mpichk ccall((:PMPI_Comm_set_name, libmpi), Cint, (MPI_Comm, Ptr{Cchar}), comm, comm_name)
end

"""
    PMPI_Comm_size(comm, size)

$(_doc_external(:PMPI_Comm_size))
"""
function PMPI_Comm_size(comm, size)
    @mpichk ccall((:PMPI_Comm_size, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, size)
end

"""
    PMPI_Comm_split(comm, color, key, newcomm)

$(_doc_external(:PMPI_Comm_split))
"""
function PMPI_Comm_split(comm, color, key, newcomm)
    @mpichk ccall((:PMPI_Comm_split, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{MPI_Comm}), comm, color, key, newcomm)
end

"""
    PMPI_Comm_split_type(comm, split_type, key, info, newcomm)

$(_doc_external(:PMPI_Comm_split_type))
"""
function PMPI_Comm_split_type(comm, split_type, key, info, newcomm)
    @mpichk ccall((:PMPI_Comm_split_type, libmpi), Cint, (MPI_Comm, Cint, Cint, MPI_Info, Ptr{MPI_Comm}), comm, split_type, key, info, newcomm)
end

"""
    PMPI_Comm_test_inter(comm, flag)

$(_doc_external(:PMPI_Comm_test_inter))
"""
function PMPI_Comm_test_inter(comm, flag)
    @mpichk ccall((:PMPI_Comm_test_inter, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, flag)
end

"""
    PMPI_Intercomm_create(local_comm, local_leader, peer_comm, remote_leader, tag, newintercomm)

$(_doc_external(:PMPI_Intercomm_create))
"""
function PMPI_Intercomm_create(local_comm, local_leader, peer_comm, remote_leader, tag, newintercomm)
    @mpichk ccall((:PMPI_Intercomm_create, libmpi), Cint, (MPI_Comm, Cint, MPI_Comm, Cint, Cint, Ptr{MPI_Comm}), local_comm, local_leader, peer_comm, remote_leader, tag, newintercomm)
end

"""
    PMPI_Intercomm_create_from_groups(local_group, local_leader, remote_group, remote_leader, stringtag, info, errhandler, newintercomm)

$(_doc_external(:PMPI_Intercomm_create_from_groups))
"""
function PMPI_Intercomm_create_from_groups(local_group, local_leader, remote_group, remote_leader, stringtag, info, errhandler, newintercomm)
    @mpichk ccall((:PMPI_Intercomm_create_from_groups, libmpi), Cint, (MPI_Group, Cint, MPI_Group, Cint, Ptr{Cchar}, MPI_Info, MPI_Errhandler, Ptr{MPI_Comm}), local_group, local_leader, remote_group, remote_leader, stringtag, info, errhandler, newintercomm)
end

"""
    PMPI_Intercomm_merge(intercomm, high, newintracomm)

$(_doc_external(:PMPI_Intercomm_merge))
"""
function PMPI_Intercomm_merge(intercomm, high, newintracomm)
    @mpichk ccall((:PMPI_Intercomm_merge, libmpi), Cint, (MPI_Comm, Cint, Ptr{MPI_Comm}), intercomm, high, newintracomm)
end

"""
    PMPIX_Comm_revoke(comm)

$(_doc_external(:PMPIX_Comm_revoke))
"""
function PMPIX_Comm_revoke(comm)
    @mpichk ccall((:PMPIX_Comm_revoke, libmpi), Cint, (MPI_Comm,), comm)
end

"""
    PMPIX_Comm_shrink(comm, newcomm)

$(_doc_external(:PMPIX_Comm_shrink))
"""
function PMPIX_Comm_shrink(comm, newcomm)
    @mpichk ccall((:PMPIX_Comm_shrink, libmpi), Cint, (MPI_Comm, Ptr{MPI_Comm}), comm, newcomm)
end

"""
    PMPIX_Comm_failure_ack(comm)

$(_doc_external(:PMPIX_Comm_failure_ack))
"""
function PMPIX_Comm_failure_ack(comm)
    @mpichk ccall((:PMPIX_Comm_failure_ack, libmpi), Cint, (MPI_Comm,), comm)
end

"""
    PMPIX_Comm_failure_get_acked(comm, failedgrp)

$(_doc_external(:PMPIX_Comm_failure_get_acked))
"""
function PMPIX_Comm_failure_get_acked(comm, failedgrp)
    @mpichk ccall((:PMPIX_Comm_failure_get_acked, libmpi), Cint, (MPI_Comm, Ptr{MPI_Group}), comm, failedgrp)
end

"""
    PMPIX_Comm_agree(comm, flag)

$(_doc_external(:PMPIX_Comm_agree))
"""
function PMPIX_Comm_agree(comm, flag)
    @mpichk ccall((:PMPIX_Comm_agree, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, flag)
end

"""
    PMPI_Get_address(location, address)

$(_doc_external(:PMPI_Get_address))
"""
function PMPI_Get_address(location, address)
    @mpichk ccall((:PMPI_Get_address, libmpi), Cint, (MPIPtr, Ptr{MPI_Aint}), location, address)
end

"""
    PMPI_Get_count(status, datatype, count)

$(_doc_external(:PMPI_Get_count))
"""
function PMPI_Get_count(status, datatype, count)
    @mpichk ccall((:PMPI_Get_count, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Ptr{Cint}), status, datatype, count)
end

"""
    PMPI_Get_count_c(status, datatype, count)

$(_doc_external(:PMPI_Get_count_c))
"""
function PMPI_Get_count_c(status, datatype, count)
    @mpichk ccall((:PMPI_Get_count_c, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Ptr{MPI_Count}), status, datatype, count)
end

"""
    PMPI_Get_elements(status, datatype, count)

$(_doc_external(:PMPI_Get_elements))
"""
function PMPI_Get_elements(status, datatype, count)
    @mpichk ccall((:PMPI_Get_elements, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Ptr{Cint}), status, datatype, count)
end

"""
    PMPI_Get_elements_c(status, datatype, count)

$(_doc_external(:PMPI_Get_elements_c))
"""
function PMPI_Get_elements_c(status, datatype, count)
    @mpichk ccall((:PMPI_Get_elements_c, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Ptr{MPI_Count}), status, datatype, count)
end

"""
    PMPI_Get_elements_x(status, datatype, count)

$(_doc_external(:PMPI_Get_elements_x))
"""
function PMPI_Get_elements_x(status, datatype, count)
    @mpichk ccall((:PMPI_Get_elements_x, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Ptr{MPI_Count}), status, datatype, count)
end

"""
    PMPI_Pack(inbuf, incount, datatype, outbuf, outsize, position, comm)

$(_doc_external(:PMPI_Pack))
"""
function PMPI_Pack(inbuf, incount, datatype, outbuf, outsize, position, comm)
    @mpichk ccall((:PMPI_Pack, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, Ptr{Cint}, MPI_Comm), inbuf, incount, datatype, outbuf, outsize, position, comm)
end

"""
    PMPI_Pack_c(inbuf, incount, datatype, outbuf, outsize, position, comm)

$(_doc_external(:PMPI_Pack_c))
"""
function PMPI_Pack_c(inbuf, incount, datatype, outbuf, outsize, position, comm)
    @mpichk ccall((:PMPI_Pack_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, Ptr{MPI_Count}, MPI_Comm), inbuf, incount, datatype, outbuf, outsize, position, comm)
end

"""
    PMPI_Pack_external(datarep, inbuf, incount, datatype, outbuf, outsize, position)

$(_doc_external(:PMPI_Pack_external))
"""
function PMPI_Pack_external(datarep, inbuf, incount, datatype, outbuf, outsize, position)
    @mpichk ccall((:PMPI_Pack_external, libmpi), Cint, (Ptr{Cchar}, MPIPtr, Cint, MPI_Datatype, MPIPtr, MPI_Aint, Ptr{MPI_Aint}), datarep, inbuf, incount, datatype, outbuf, outsize, position)
end

"""
    PMPI_Pack_external_c(datarep, inbuf, incount, datatype, outbuf, outsize, position)

$(_doc_external(:PMPI_Pack_external_c))
"""
function PMPI_Pack_external_c(datarep, inbuf, incount, datatype, outbuf, outsize, position)
    @mpichk ccall((:PMPI_Pack_external_c, libmpi), Cint, (Ptr{Cchar}, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, Ptr{MPI_Count}), datarep, inbuf, incount, datatype, outbuf, outsize, position)
end

"""
    PMPI_Pack_external_size(datarep, incount, datatype, size)

$(_doc_external(:PMPI_Pack_external_size))
"""
function PMPI_Pack_external_size(datarep, incount, datatype, size)
    @mpichk ccall((:PMPI_Pack_external_size, libmpi), Cint, (Ptr{Cchar}, Cint, MPI_Datatype, Ptr{MPI_Aint}), datarep, incount, datatype, size)
end

"""
    PMPI_Pack_external_size_c(datarep, incount, datatype, size)

$(_doc_external(:PMPI_Pack_external_size_c))
"""
function PMPI_Pack_external_size_c(datarep, incount, datatype, size)
    @mpichk ccall((:PMPI_Pack_external_size_c, libmpi), Cint, (Ptr{Cchar}, MPI_Count, MPI_Datatype, Ptr{MPI_Count}), datarep, incount, datatype, size)
end

"""
    PMPI_Pack_size(incount, datatype, comm, size)

$(_doc_external(:PMPI_Pack_size))
"""
function PMPI_Pack_size(incount, datatype, comm, size)
    @mpichk ccall((:PMPI_Pack_size, libmpi), Cint, (Cint, MPI_Datatype, MPI_Comm, Ptr{Cint}), incount, datatype, comm, size)
end

"""
    PMPI_Pack_size_c(incount, datatype, comm, size)

$(_doc_external(:PMPI_Pack_size_c))
"""
function PMPI_Pack_size_c(incount, datatype, comm, size)
    @mpichk ccall((:PMPI_Pack_size_c, libmpi), Cint, (MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Count}), incount, datatype, comm, size)
end

"""
    PMPI_Status_set_elements(status, datatype, count)

$(_doc_external(:PMPI_Status_set_elements))
"""
function PMPI_Status_set_elements(status, datatype, count)
    @mpichk ccall((:PMPI_Status_set_elements, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Cint), status, datatype, count)
end

"""
    PMPI_Status_set_elements_x(status, datatype, count)

$(_doc_external(:PMPI_Status_set_elements_x))
"""
function PMPI_Status_set_elements_x(status, datatype, count)
    @mpichk ccall((:PMPI_Status_set_elements_x, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, MPI_Count), status, datatype, count)
end

"""
    PMPI_Type_commit(datatype)

$(_doc_external(:PMPI_Type_commit))
"""
function PMPI_Type_commit(datatype)
    @mpichk ccall((:PMPI_Type_commit, libmpi), Cint, (Ptr{MPI_Datatype},), datatype)
end

"""
    PMPI_Type_contiguous(count, oldtype, newtype)

$(_doc_external(:PMPI_Type_contiguous))
"""
function PMPI_Type_contiguous(count, oldtype, newtype)
    @mpichk ccall((:PMPI_Type_contiguous, libmpi), Cint, (Cint, MPI_Datatype, Ptr{MPI_Datatype}), count, oldtype, newtype)
end

"""
    PMPI_Type_contiguous_c(count, oldtype, newtype)

$(_doc_external(:PMPI_Type_contiguous_c))
"""
function PMPI_Type_contiguous_c(count, oldtype, newtype)
    @mpichk ccall((:PMPI_Type_contiguous_c, libmpi), Cint, (MPI_Count, MPI_Datatype, Ptr{MPI_Datatype}), count, oldtype, newtype)
end

"""
    PMPI_Type_create_darray(size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)

$(_doc_external(:PMPI_Type_create_darray))
"""
function PMPI_Type_create_darray(size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
    @mpichk ccall((:PMPI_Type_create_darray, libmpi), Cint, (Cint, Cint, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
end

"""
    PMPI_Type_create_darray_c(size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)

$(_doc_external(:PMPI_Type_create_darray_c))
"""
function PMPI_Type_create_darray_c(size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
    @mpichk ccall((:PMPI_Type_create_darray_c, libmpi), Cint, (Cint, Cint, Cint, Ptr{MPI_Count}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
end

"""
    PMPI_Type_create_hindexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)

$(_doc_external(:PMPI_Type_create_hindexed))
"""
function PMPI_Type_create_hindexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:PMPI_Type_create_hindexed, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

"""
    PMPI_Type_create_hindexed_c(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)

$(_doc_external(:PMPI_Type_create_hindexed_c))
"""
function PMPI_Type_create_hindexed_c(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:PMPI_Type_create_hindexed_c, libmpi), Cint, (MPI_Count, Ptr{MPI_Count}, Ptr{MPI_Count}, MPI_Datatype, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

"""
    PMPI_Type_create_hindexed_block(count, blocklength, array_of_displacements, oldtype, newtype)

$(_doc_external(:PMPI_Type_create_hindexed_block))
"""
function PMPI_Type_create_hindexed_block(count, blocklength, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:PMPI_Type_create_hindexed_block, libmpi), Cint, (Cint, Cint, Ptr{MPI_Aint}, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, array_of_displacements, oldtype, newtype)
end

"""
    PMPI_Type_create_hindexed_block_c(count, blocklength, array_of_displacements, oldtype, newtype)

$(_doc_external(:PMPI_Type_create_hindexed_block_c))
"""
function PMPI_Type_create_hindexed_block_c(count, blocklength, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:PMPI_Type_create_hindexed_block_c, libmpi), Cint, (MPI_Count, MPI_Count, Ptr{MPI_Count}, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, array_of_displacements, oldtype, newtype)
end

"""
    PMPI_Type_create_hvector(count, blocklength, stride, oldtype, newtype)

$(_doc_external(:PMPI_Type_create_hvector))
"""
function PMPI_Type_create_hvector(count, blocklength, stride, oldtype, newtype)
    @mpichk ccall((:PMPI_Type_create_hvector, libmpi), Cint, (Cint, Cint, MPI_Aint, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

"""
    PMPI_Type_create_hvector_c(count, blocklength, stride, oldtype, newtype)

$(_doc_external(:PMPI_Type_create_hvector_c))
"""
function PMPI_Type_create_hvector_c(count, blocklength, stride, oldtype, newtype)
    @mpichk ccall((:PMPI_Type_create_hvector_c, libmpi), Cint, (MPI_Count, MPI_Count, MPI_Count, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

"""
    PMPI_Type_create_indexed_block(count, blocklength, array_of_displacements, oldtype, newtype)

$(_doc_external(:PMPI_Type_create_indexed_block))
"""
function PMPI_Type_create_indexed_block(count, blocklength, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:PMPI_Type_create_indexed_block, libmpi), Cint, (Cint, Cint, Ptr{Cint}, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, array_of_displacements, oldtype, newtype)
end

"""
    PMPI_Type_create_indexed_block_c(count, blocklength, array_of_displacements, oldtype, newtype)

$(_doc_external(:PMPI_Type_create_indexed_block_c))
"""
function PMPI_Type_create_indexed_block_c(count, blocklength, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:PMPI_Type_create_indexed_block_c, libmpi), Cint, (MPI_Count, MPI_Count, Ptr{MPI_Count}, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, array_of_displacements, oldtype, newtype)
end

"""
    PMPI_Type_create_resized(oldtype, lb, extent, newtype)

$(_doc_external(:PMPI_Type_create_resized))
"""
function PMPI_Type_create_resized(oldtype, lb, extent, newtype)
    @mpichk ccall((:PMPI_Type_create_resized, libmpi), Cint, (MPI_Datatype, MPI_Aint, MPI_Aint, Ptr{MPI_Datatype}), oldtype, lb, extent, newtype)
end

"""
    PMPI_Type_create_resized_c(oldtype, lb, extent, newtype)

$(_doc_external(:PMPI_Type_create_resized_c))
"""
function PMPI_Type_create_resized_c(oldtype, lb, extent, newtype)
    @mpichk ccall((:PMPI_Type_create_resized_c, libmpi), Cint, (MPI_Datatype, MPI_Count, MPI_Count, Ptr{MPI_Datatype}), oldtype, lb, extent, newtype)
end

"""
    PMPI_Type_create_struct(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)

$(_doc_external(:PMPI_Type_create_struct))
"""
function PMPI_Type_create_struct(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
    @mpichk ccall((:PMPI_Type_create_struct, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
end

"""
    PMPI_Type_create_struct_c(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)

$(_doc_external(:PMPI_Type_create_struct_c))
"""
function PMPI_Type_create_struct_c(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
    @mpichk ccall((:PMPI_Type_create_struct_c, libmpi), Cint, (MPI_Count, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
end

"""
    PMPI_Type_create_subarray(ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)

$(_doc_external(:PMPI_Type_create_subarray))
"""
function PMPI_Type_create_subarray(ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
    @mpichk ccall((:PMPI_Type_create_subarray, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
end

"""
    PMPI_Type_create_subarray_c(ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)

$(_doc_external(:PMPI_Type_create_subarray_c))
"""
function PMPI_Type_create_subarray_c(ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
    @mpichk ccall((:PMPI_Type_create_subarray_c, libmpi), Cint, (Cint, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Count}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
end

"""
    PMPI_Type_dup(oldtype, newtype)

$(_doc_external(:PMPI_Type_dup))
"""
function PMPI_Type_dup(oldtype, newtype)
    @mpichk ccall((:PMPI_Type_dup, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Datatype}), oldtype, newtype)
end

"""
    PMPI_Type_free(datatype)

$(_doc_external(:PMPI_Type_free))
"""
function PMPI_Type_free(datatype)
    @mpichk ccall((:PMPI_Type_free, libmpi), Cint, (Ptr{MPI_Datatype},), datatype)
end

"""
    PMPI_Type_get_contents(datatype, max_integers, max_addresses, max_datatypes, array_of_integers, array_of_addresses, array_of_datatypes)

$(_doc_external(:PMPI_Type_get_contents))
"""
function PMPI_Type_get_contents(datatype, max_integers, max_addresses, max_datatypes, array_of_integers, array_of_addresses, array_of_datatypes)
    @mpichk ccall((:PMPI_Type_get_contents, libmpi), Cint, (MPI_Datatype, Cint, Cint, Cint, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}), datatype, max_integers, max_addresses, max_datatypes, array_of_integers, array_of_addresses, array_of_datatypes)
end

"""
    PMPI_Type_get_contents_c(datatype, max_integers, max_addresses, max_large_counts, max_datatypes, array_of_integers, array_of_addresses, array_of_large_counts, array_of_datatypes)

$(_doc_external(:PMPI_Type_get_contents_c))
"""
function PMPI_Type_get_contents_c(datatype, max_integers, max_addresses, max_large_counts, max_datatypes, array_of_integers, array_of_addresses, array_of_large_counts, array_of_datatypes)
    @mpichk ccall((:PMPI_Type_get_contents_c, libmpi), Cint, (MPI_Datatype, MPI_Count, MPI_Count, MPI_Count, MPI_Count, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Count}, Ptr{MPI_Datatype}), datatype, max_integers, max_addresses, max_large_counts, max_datatypes, array_of_integers, array_of_addresses, array_of_large_counts, array_of_datatypes)
end

"""
    PMPI_Type_get_envelope(datatype, num_integers, num_addresses, num_datatypes, combiner)

$(_doc_external(:PMPI_Type_get_envelope))
"""
function PMPI_Type_get_envelope(datatype, num_integers, num_addresses, num_datatypes, combiner)
    @mpichk ccall((:PMPI_Type_get_envelope, libmpi), Cint, (MPI_Datatype, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), datatype, num_integers, num_addresses, num_datatypes, combiner)
end

"""
    PMPI_Type_get_envelope_c(datatype, num_integers, num_addresses, num_large_counts, num_datatypes, combiner)

$(_doc_external(:PMPI_Type_get_envelope_c))
"""
function PMPI_Type_get_envelope_c(datatype, num_integers, num_addresses, num_large_counts, num_datatypes, combiner)
    @mpichk ccall((:PMPI_Type_get_envelope_c, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{Cint}), datatype, num_integers, num_addresses, num_large_counts, num_datatypes, combiner)
end

"""
    PMPI_Type_get_extent(datatype, lb, extent)

$(_doc_external(:PMPI_Type_get_extent))
"""
function PMPI_Type_get_extent(datatype, lb, extent)
    @mpichk ccall((:PMPI_Type_get_extent, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Aint}, Ptr{MPI_Aint}), datatype, lb, extent)
end

"""
    PMPI_Type_get_extent_c(datatype, lb, extent)

$(_doc_external(:PMPI_Type_get_extent_c))
"""
function PMPI_Type_get_extent_c(datatype, lb, extent)
    @mpichk ccall((:PMPI_Type_get_extent_c, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), datatype, lb, extent)
end

"""
    PMPI_Type_get_extent_x(datatype, lb, extent)

$(_doc_external(:PMPI_Type_get_extent_x))
"""
function PMPI_Type_get_extent_x(datatype, lb, extent)
    @mpichk ccall((:PMPI_Type_get_extent_x, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), datatype, lb, extent)
end

"""
    PMPI_Type_get_name(datatype, type_name, resultlen)

$(_doc_external(:PMPI_Type_get_name))
"""
function PMPI_Type_get_name(datatype, type_name, resultlen)
    @mpichk ccall((:PMPI_Type_get_name, libmpi), Cint, (MPI_Datatype, Ptr{Cchar}, Ptr{Cint}), datatype, type_name, resultlen)
end

"""
    PMPI_Type_get_true_extent(datatype, true_lb, true_extent)

$(_doc_external(:PMPI_Type_get_true_extent))
"""
function PMPI_Type_get_true_extent(datatype, true_lb, true_extent)
    @mpichk ccall((:PMPI_Type_get_true_extent, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Aint}, Ptr{MPI_Aint}), datatype, true_lb, true_extent)
end

"""
    PMPI_Type_get_true_extent_c(datatype, true_lb, true_extent)

$(_doc_external(:PMPI_Type_get_true_extent_c))
"""
function PMPI_Type_get_true_extent_c(datatype, true_lb, true_extent)
    @mpichk ccall((:PMPI_Type_get_true_extent_c, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), datatype, true_lb, true_extent)
end

"""
    PMPI_Type_get_true_extent_x(datatype, true_lb, true_extent)

$(_doc_external(:PMPI_Type_get_true_extent_x))
"""
function PMPI_Type_get_true_extent_x(datatype, true_lb, true_extent)
    @mpichk ccall((:PMPI_Type_get_true_extent_x, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), datatype, true_lb, true_extent)
end

"""
    PMPI_Type_indexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)

$(_doc_external(:PMPI_Type_indexed))
"""
function PMPI_Type_indexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:PMPI_Type_indexed, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

"""
    PMPI_Type_indexed_c(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)

$(_doc_external(:PMPI_Type_indexed_c))
"""
function PMPI_Type_indexed_c(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:PMPI_Type_indexed_c, libmpi), Cint, (MPI_Count, Ptr{MPI_Count}, Ptr{MPI_Count}, MPI_Datatype, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

"""
    PMPI_Type_match_size(typeclass, size, datatype)

$(_doc_external(:PMPI_Type_match_size))
"""
function PMPI_Type_match_size(typeclass, size, datatype)
    @mpichk ccall((:PMPI_Type_match_size, libmpi), Cint, (Cint, Cint, Ptr{MPI_Datatype}), typeclass, size, datatype)
end

"""
    PMPI_Type_set_name(datatype, type_name)

$(_doc_external(:PMPI_Type_set_name))
"""
function PMPI_Type_set_name(datatype, type_name)
    @mpichk ccall((:PMPI_Type_set_name, libmpi), Cint, (MPI_Datatype, Ptr{Cchar}), datatype, type_name)
end

"""
    PMPI_Type_size(datatype, size)

$(_doc_external(:PMPI_Type_size))
"""
function PMPI_Type_size(datatype, size)
    @mpichk ccall((:PMPI_Type_size, libmpi), Cint, (MPI_Datatype, Ptr{Cint}), datatype, size)
end

"""
    PMPI_Type_size_c(datatype, size)

$(_doc_external(:PMPI_Type_size_c))
"""
function PMPI_Type_size_c(datatype, size)
    @mpichk ccall((:PMPI_Type_size_c, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}), datatype, size)
end

"""
    PMPI_Type_size_x(datatype, size)

$(_doc_external(:PMPI_Type_size_x))
"""
function PMPI_Type_size_x(datatype, size)
    @mpichk ccall((:PMPI_Type_size_x, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}), datatype, size)
end

"""
    PMPI_Type_vector(count, blocklength, stride, oldtype, newtype)

$(_doc_external(:PMPI_Type_vector))
"""
function PMPI_Type_vector(count, blocklength, stride, oldtype, newtype)
    @mpichk ccall((:PMPI_Type_vector, libmpi), Cint, (Cint, Cint, Cint, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

"""
    PMPI_Type_vector_c(count, blocklength, stride, oldtype, newtype)

$(_doc_external(:PMPI_Type_vector_c))
"""
function PMPI_Type_vector_c(count, blocklength, stride, oldtype, newtype)
    @mpichk ccall((:PMPI_Type_vector_c, libmpi), Cint, (MPI_Count, MPI_Count, MPI_Count, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

"""
    PMPI_Unpack(inbuf, insize, position, outbuf, outcount, datatype, comm)

$(_doc_external(:PMPI_Unpack))
"""
function PMPI_Unpack(inbuf, insize, position, outbuf, outcount, datatype, comm)
    @mpichk ccall((:PMPI_Unpack, libmpi), Cint, (MPIPtr, Cint, Ptr{Cint}, MPIPtr, Cint, MPI_Datatype, MPI_Comm), inbuf, insize, position, outbuf, outcount, datatype, comm)
end

"""
    PMPI_Unpack_c(inbuf, insize, position, outbuf, outcount, datatype, comm)

$(_doc_external(:PMPI_Unpack_c))
"""
function PMPI_Unpack_c(inbuf, insize, position, outbuf, outcount, datatype, comm)
    @mpichk ccall((:PMPI_Unpack_c, libmpi), Cint, (MPIPtr, MPI_Count, Ptr{MPI_Count}, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm), inbuf, insize, position, outbuf, outcount, datatype, comm)
end

"""
    PMPI_Unpack_external(datarep, inbuf, insize, position, outbuf, outcount, datatype)

$(_doc_external(:PMPI_Unpack_external))
"""
function PMPI_Unpack_external(datarep, inbuf, insize, position, outbuf, outcount, datatype)
    @mpichk ccall((:PMPI_Unpack_external, libmpi), Cint, (Ptr{Cchar}, MPIPtr, MPI_Aint, Ptr{MPI_Aint}, MPIPtr, Cint, MPI_Datatype), datarep, inbuf, insize, position, outbuf, outcount, datatype)
end

"""
    PMPI_Unpack_external_c(datarep, inbuf, insize, position, outbuf, outcount, datatype)

$(_doc_external(:PMPI_Unpack_external_c))
"""
function PMPI_Unpack_external_c(datarep, inbuf, insize, position, outbuf, outcount, datatype)
    @mpichk ccall((:PMPI_Unpack_external_c, libmpi), Cint, (Ptr{Cchar}, MPIPtr, MPI_Count, Ptr{MPI_Count}, MPIPtr, MPI_Count, MPI_Datatype), datarep, inbuf, insize, position, outbuf, outcount, datatype)
end

"""
    PMPI_Address(location, address)

$(_doc_external(:PMPI_Address))
"""
function PMPI_Address(location, address)
    @mpichk ccall((:PMPI_Address, libmpi), Cint, (MPIPtr, Ptr{MPI_Aint}), location, address)
end

"""
    PMPI_Type_extent(datatype, extent)

$(_doc_external(:PMPI_Type_extent))
"""
function PMPI_Type_extent(datatype, extent)
    @mpichk ccall((:PMPI_Type_extent, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Aint}), datatype, extent)
end

"""
    PMPI_Type_lb(datatype, displacement)

$(_doc_external(:PMPI_Type_lb))
"""
function PMPI_Type_lb(datatype, displacement)
    @mpichk ccall((:PMPI_Type_lb, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Aint}), datatype, displacement)
end

"""
    PMPI_Type_ub(datatype, displacement)

$(_doc_external(:PMPI_Type_ub))
"""
function PMPI_Type_ub(datatype, displacement)
    @mpichk ccall((:PMPI_Type_ub, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Aint}), datatype, displacement)
end

"""
    PMPI_Type_hindexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)

$(_doc_external(:PMPI_Type_hindexed))
"""
function PMPI_Type_hindexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:PMPI_Type_hindexed, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

"""
    PMPI_Type_hvector(count, blocklength, stride, oldtype, newtype)

$(_doc_external(:PMPI_Type_hvector))
"""
function PMPI_Type_hvector(count, blocklength, stride, oldtype, newtype)
    @mpichk ccall((:PMPI_Type_hvector, libmpi), Cint, (Cint, Cint, MPI_Aint, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

"""
    PMPI_Type_struct(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)

$(_doc_external(:PMPI_Type_struct))
"""
function PMPI_Type_struct(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
    @mpichk ccall((:PMPI_Type_struct, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
end

"""
    PMPI_Add_error_class(errorclass)

$(_doc_external(:PMPI_Add_error_class))
"""
function PMPI_Add_error_class(errorclass)
    @mpichk ccall((:PMPI_Add_error_class, libmpi), Cint, (Ptr{Cint},), errorclass)
end

"""
    PMPI_Add_error_code(errorclass, errorcode)

$(_doc_external(:PMPI_Add_error_code))
"""
function PMPI_Add_error_code(errorclass, errorcode)
    @mpichk ccall((:PMPI_Add_error_code, libmpi), Cint, (Cint, Ptr{Cint}), errorclass, errorcode)
end

"""
    PMPI_Add_error_string(errorcode, string)

$(_doc_external(:PMPI_Add_error_string))
"""
function PMPI_Add_error_string(errorcode, string)
    @mpichk ccall((:PMPI_Add_error_string, libmpi), Cint, (Cint, Ptr{Cchar}), errorcode, string)
end

"""
    PMPI_Comm_call_errhandler(comm, errorcode)

$(_doc_external(:PMPI_Comm_call_errhandler))
"""
function PMPI_Comm_call_errhandler(comm, errorcode)
    @mpichk ccall((:PMPI_Comm_call_errhandler, libmpi), Cint, (MPI_Comm, Cint), comm, errorcode)
end

"""
    PMPI_Comm_create_errhandler(comm_errhandler_fn, errhandler)

$(_doc_external(:PMPI_Comm_create_errhandler))
"""
function PMPI_Comm_create_errhandler(comm_errhandler_fn, errhandler)
    @mpichk ccall((:PMPI_Comm_create_errhandler, libmpi), Cint, (MPIPtr, Ptr{MPI_Errhandler}), comm_errhandler_fn, errhandler)
end

"""
    PMPI_Comm_get_errhandler(comm, errhandler)

$(_doc_external(:PMPI_Comm_get_errhandler))
"""
function PMPI_Comm_get_errhandler(comm, errhandler)
    @mpichk ccall((:PMPI_Comm_get_errhandler, libmpi), Cint, (MPI_Comm, Ptr{MPI_Errhandler}), comm, errhandler)
end

"""
    PMPI_Comm_set_errhandler(comm, errhandler)

$(_doc_external(:PMPI_Comm_set_errhandler))
"""
function PMPI_Comm_set_errhandler(comm, errhandler)
    @mpichk ccall((:PMPI_Comm_set_errhandler, libmpi), Cint, (MPI_Comm, MPI_Errhandler), comm, errhandler)
end

"""
    PMPI_Errhandler_free(errhandler)

$(_doc_external(:PMPI_Errhandler_free))
"""
function PMPI_Errhandler_free(errhandler)
    @mpichk ccall((:PMPI_Errhandler_free, libmpi), Cint, (Ptr{MPI_Errhandler},), errhandler)
end

"""
    PMPI_Error_class(errorcode, errorclass)

$(_doc_external(:PMPI_Error_class))
"""
function PMPI_Error_class(errorcode, errorclass)
    @mpichk ccall((:PMPI_Error_class, libmpi), Cint, (Cint, Ptr{Cint}), errorcode, errorclass)
end

"""
    PMPI_Error_string(errorcode, string, resultlen)

$(_doc_external(:PMPI_Error_string))
"""
function PMPI_Error_string(errorcode, string, resultlen)
    @mpichk ccall((:PMPI_Error_string, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}), errorcode, string, resultlen)
end

"""
    PMPI_File_call_errhandler(fh, errorcode)

$(_doc_external(:PMPI_File_call_errhandler))
"""
function PMPI_File_call_errhandler(fh, errorcode)
    @mpichk ccall((:PMPI_File_call_errhandler, libmpi), Cint, (MPI_File, Cint), fh, errorcode)
end

"""
    PMPI_File_create_errhandler(file_errhandler_fn, errhandler)

$(_doc_external(:PMPI_File_create_errhandler))
"""
function PMPI_File_create_errhandler(file_errhandler_fn, errhandler)
    @mpichk ccall((:PMPI_File_create_errhandler, libmpi), Cint, (MPIPtr, Ptr{MPI_Errhandler}), file_errhandler_fn, errhandler)
end

"""
    PMPI_File_get_errhandler(file, errhandler)

$(_doc_external(:PMPI_File_get_errhandler))
"""
function PMPI_File_get_errhandler(file, errhandler)
    @mpichk ccall((:PMPI_File_get_errhandler, libmpi), Cint, (MPI_File, Ptr{MPI_Errhandler}), file, errhandler)
end

"""
    PMPI_File_set_errhandler(file, errhandler)

$(_doc_external(:PMPI_File_set_errhandler))
"""
function PMPI_File_set_errhandler(file, errhandler)
    @mpichk ccall((:PMPI_File_set_errhandler, libmpi), Cint, (MPI_File, MPI_Errhandler), file, errhandler)
end

"""
    PMPI_Session_call_errhandler(session, errorcode)

$(_doc_external(:PMPI_Session_call_errhandler))
"""
function PMPI_Session_call_errhandler(session, errorcode)
    @mpichk ccall((:PMPI_Session_call_errhandler, libmpi), Cint, (MPI_Session, Cint), session, errorcode)
end

"""
    PMPI_Session_create_errhandler(session_errhandler_fn, errhandler)

$(_doc_external(:PMPI_Session_create_errhandler))
"""
function PMPI_Session_create_errhandler(session_errhandler_fn, errhandler)
    @mpichk ccall((:PMPI_Session_create_errhandler, libmpi), Cint, (MPIPtr, Ptr{MPI_Errhandler}), session_errhandler_fn, errhandler)
end

"""
    PMPI_Session_get_errhandler(session, errhandler)

$(_doc_external(:PMPI_Session_get_errhandler))
"""
function PMPI_Session_get_errhandler(session, errhandler)
    @mpichk ccall((:PMPI_Session_get_errhandler, libmpi), Cint, (MPI_Session, Ptr{MPI_Errhandler}), session, errhandler)
end

"""
    PMPI_Session_set_errhandler(session, errhandler)

$(_doc_external(:PMPI_Session_set_errhandler))
"""
function PMPI_Session_set_errhandler(session, errhandler)
    @mpichk ccall((:PMPI_Session_set_errhandler, libmpi), Cint, (MPI_Session, MPI_Errhandler), session, errhandler)
end

"""
    PMPI_Win_call_errhandler(win, errorcode)

$(_doc_external(:PMPI_Win_call_errhandler))
"""
function PMPI_Win_call_errhandler(win, errorcode)
    @mpichk ccall((:PMPI_Win_call_errhandler, libmpi), Cint, (MPI_Win, Cint), win, errorcode)
end

"""
    PMPI_Win_create_errhandler(win_errhandler_fn, errhandler)

$(_doc_external(:PMPI_Win_create_errhandler))
"""
function PMPI_Win_create_errhandler(win_errhandler_fn, errhandler)
    @mpichk ccall((:PMPI_Win_create_errhandler, libmpi), Cint, (MPIPtr, Ptr{MPI_Errhandler}), win_errhandler_fn, errhandler)
end

"""
    PMPI_Win_get_errhandler(win, errhandler)

$(_doc_external(:PMPI_Win_get_errhandler))
"""
function PMPI_Win_get_errhandler(win, errhandler)
    @mpichk ccall((:PMPI_Win_get_errhandler, libmpi), Cint, (MPI_Win, Ptr{MPI_Errhandler}), win, errhandler)
end

"""
    PMPI_Win_set_errhandler(win, errhandler)

$(_doc_external(:PMPI_Win_set_errhandler))
"""
function PMPI_Win_set_errhandler(win, errhandler)
    @mpichk ccall((:PMPI_Win_set_errhandler, libmpi), Cint, (MPI_Win, MPI_Errhandler), win, errhandler)
end

"""
    PMPIX_Delete_error_class(errorclass)

$(_doc_external(:PMPIX_Delete_error_class))
"""
function PMPIX_Delete_error_class(errorclass)
    @mpichk ccall((:PMPIX_Delete_error_class, libmpi), Cint, (Cint,), errorclass)
end

"""
    PMPIX_Delete_error_code(errorcode)

$(_doc_external(:PMPIX_Delete_error_code))
"""
function PMPIX_Delete_error_code(errorcode)
    @mpichk ccall((:PMPIX_Delete_error_code, libmpi), Cint, (Cint,), errorcode)
end

"""
    PMPIX_Delete_error_string(errorcode)

$(_doc_external(:PMPIX_Delete_error_string))
"""
function PMPIX_Delete_error_string(errorcode)
    @mpichk ccall((:PMPIX_Delete_error_string, libmpi), Cint, (Cint,), errorcode)
end

"""
    PMPI_Errhandler_create(comm_errhandler_fn, errhandler)

$(_doc_external(:PMPI_Errhandler_create))
"""
function PMPI_Errhandler_create(comm_errhandler_fn, errhandler)
    @mpichk ccall((:PMPI_Errhandler_create, libmpi), Cint, (MPIPtr, Ptr{MPI_Errhandler}), comm_errhandler_fn, errhandler)
end

"""
    PMPI_Errhandler_get(comm, errhandler)

$(_doc_external(:PMPI_Errhandler_get))
"""
function PMPI_Errhandler_get(comm, errhandler)
    @mpichk ccall((:PMPI_Errhandler_get, libmpi), Cint, (MPI_Comm, Ptr{MPI_Errhandler}), comm, errhandler)
end

"""
    PMPI_Errhandler_set(comm, errhandler)

$(_doc_external(:PMPI_Errhandler_set))
"""
function PMPI_Errhandler_set(comm, errhandler)
    @mpichk ccall((:PMPI_Errhandler_set, libmpi), Cint, (MPI_Comm, MPI_Errhandler), comm, errhandler)
end

"""
    PMPI_Group_compare(group1, group2, result)

$(_doc_external(:PMPI_Group_compare))
"""
function PMPI_Group_compare(group1, group2, result)
    @mpichk ccall((:PMPI_Group_compare, libmpi), Cint, (MPI_Group, MPI_Group, Ptr{Cint}), group1, group2, result)
end

"""
    PMPI_Group_difference(group1, group2, newgroup)

$(_doc_external(:PMPI_Group_difference))
"""
function PMPI_Group_difference(group1, group2, newgroup)
    @mpichk ccall((:PMPI_Group_difference, libmpi), Cint, (MPI_Group, MPI_Group, Ptr{MPI_Group}), group1, group2, newgroup)
end

"""
    PMPI_Group_excl(group, n, ranks, newgroup)

$(_doc_external(:PMPI_Group_excl))
"""
function PMPI_Group_excl(group, n, ranks, newgroup)
    @mpichk ccall((:PMPI_Group_excl, libmpi), Cint, (MPI_Group, Cint, Ptr{Cint}, Ptr{MPI_Group}), group, n, ranks, newgroup)
end

"""
    PMPI_Group_free(group)

$(_doc_external(:PMPI_Group_free))
"""
function PMPI_Group_free(group)
    @mpichk ccall((:PMPI_Group_free, libmpi), Cint, (Ptr{MPI_Group},), group)
end

"""
    PMPI_Group_incl(group, n, ranks, newgroup)

$(_doc_external(:PMPI_Group_incl))
"""
function PMPI_Group_incl(group, n, ranks, newgroup)
    @mpichk ccall((:PMPI_Group_incl, libmpi), Cint, (MPI_Group, Cint, Ptr{Cint}, Ptr{MPI_Group}), group, n, ranks, newgroup)
end

"""
    PMPI_Group_intersection(group1, group2, newgroup)

$(_doc_external(:PMPI_Group_intersection))
"""
function PMPI_Group_intersection(group1, group2, newgroup)
    @mpichk ccall((:PMPI_Group_intersection, libmpi), Cint, (MPI_Group, MPI_Group, Ptr{MPI_Group}), group1, group2, newgroup)
end

"""
    PMPI_Group_range_excl(group, n, ranges, newgroup)

$(_doc_external(:PMPI_Group_range_excl))
"""
function PMPI_Group_range_excl(group, n, ranges, newgroup)
    @mpichk ccall((:PMPI_Group_range_excl, libmpi), Cint, (MPI_Group, Cint, Ptr{NTuple{3, Cint}}, Ptr{MPI_Group}), group, n, ranges, newgroup)
end

"""
    PMPI_Group_range_incl(group, n, ranges, newgroup)

$(_doc_external(:PMPI_Group_range_incl))
"""
function PMPI_Group_range_incl(group, n, ranges, newgroup)
    @mpichk ccall((:PMPI_Group_range_incl, libmpi), Cint, (MPI_Group, Cint, Ptr{NTuple{3, Cint}}, Ptr{MPI_Group}), group, n, ranges, newgroup)
end

"""
    PMPI_Group_rank(group, rank)

$(_doc_external(:PMPI_Group_rank))
"""
function PMPI_Group_rank(group, rank)
    @mpichk ccall((:PMPI_Group_rank, libmpi), Cint, (MPI_Group, Ptr{Cint}), group, rank)
end

"""
    PMPI_Group_size(group, size)

$(_doc_external(:PMPI_Group_size))
"""
function PMPI_Group_size(group, size)
    @mpichk ccall((:PMPI_Group_size, libmpi), Cint, (MPI_Group, Ptr{Cint}), group, size)
end

"""
    PMPI_Group_translate_ranks(group1, n, ranks1, group2, ranks2)

$(_doc_external(:PMPI_Group_translate_ranks))
"""
function PMPI_Group_translate_ranks(group1, n, ranks1, group2, ranks2)
    @mpichk ccall((:PMPI_Group_translate_ranks, libmpi), Cint, (MPI_Group, Cint, Ptr{Cint}, MPI_Group, Ptr{Cint}), group1, n, ranks1, group2, ranks2)
end

"""
    PMPI_Group_union(group1, group2, newgroup)

$(_doc_external(:PMPI_Group_union))
"""
function PMPI_Group_union(group1, group2, newgroup)
    @mpichk ccall((:PMPI_Group_union, libmpi), Cint, (MPI_Group, MPI_Group, Ptr{MPI_Group}), group1, group2, newgroup)
end

"""
    PMPI_Info_create(info)

$(_doc_external(:PMPI_Info_create))
"""
function PMPI_Info_create(info)
    @mpichk ccall((:PMPI_Info_create, libmpi), Cint, (Ptr{MPI_Info},), info)
end

"""
    PMPI_Info_create_env(argc, argv, info)

$(_doc_external(:PMPI_Info_create_env))
"""
function PMPI_Info_create_env(argc, argv, info)
    @mpichk ccall((:PMPI_Info_create_env, libmpi), Cint, (Cint, Ptr{Ptr{Cchar}}, Ptr{MPI_Info}), argc, argv, info)
end

"""
    PMPI_Info_delete(info, key)

$(_doc_external(:PMPI_Info_delete))
"""
function PMPI_Info_delete(info, key)
    @mpichk ccall((:PMPI_Info_delete, libmpi), Cint, (MPI_Info, Ptr{Cchar}), info, key)
end

"""
    PMPI_Info_dup(info, newinfo)

$(_doc_external(:PMPI_Info_dup))
"""
function PMPI_Info_dup(info, newinfo)
    @mpichk ccall((:PMPI_Info_dup, libmpi), Cint, (MPI_Info, Ptr{MPI_Info}), info, newinfo)
end

"""
    PMPI_Info_free(info)

$(_doc_external(:PMPI_Info_free))
"""
function PMPI_Info_free(info)
    @mpichk ccall((:PMPI_Info_free, libmpi), Cint, (Ptr{MPI_Info},), info)
end

"""
    PMPI_Info_get(info, key, valuelen, value, flag)

$(_doc_external(:PMPI_Info_get))
"""
function PMPI_Info_get(info, key, valuelen, value, flag)
    @mpichk ccall((:PMPI_Info_get, libmpi), Cint, (MPI_Info, Ptr{Cchar}, Cint, Ptr{Cchar}, Ptr{Cint}), info, key, valuelen, value, flag)
end

"""
    PMPI_Info_get_nkeys(info, nkeys)

$(_doc_external(:PMPI_Info_get_nkeys))
"""
function PMPI_Info_get_nkeys(info, nkeys)
    @mpichk ccall((:PMPI_Info_get_nkeys, libmpi), Cint, (MPI_Info, Ptr{Cint}), info, nkeys)
end

"""
    PMPI_Info_get_nthkey(info, n, key)

$(_doc_external(:PMPI_Info_get_nthkey))
"""
function PMPI_Info_get_nthkey(info, n, key)
    @mpichk ccall((:PMPI_Info_get_nthkey, libmpi), Cint, (MPI_Info, Cint, Ptr{Cchar}), info, n, key)
end

"""
    PMPI_Info_get_string(info, key, buflen, value, flag)

$(_doc_external(:PMPI_Info_get_string))
"""
function PMPI_Info_get_string(info, key, buflen, value, flag)
    @mpichk ccall((:PMPI_Info_get_string, libmpi), Cint, (MPI_Info, Ptr{Cchar}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}), info, key, buflen, value, flag)
end

"""
    PMPI_Info_get_valuelen(info, key, valuelen, flag)

$(_doc_external(:PMPI_Info_get_valuelen))
"""
function PMPI_Info_get_valuelen(info, key, valuelen, flag)
    @mpichk ccall((:PMPI_Info_get_valuelen, libmpi), Cint, (MPI_Info, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}), info, key, valuelen, flag)
end

"""
    PMPI_Info_set(info, key, value)

$(_doc_external(:PMPI_Info_set))
"""
function PMPI_Info_set(info, key, value)
    @mpichk ccall((:PMPI_Info_set, libmpi), Cint, (MPI_Info, Ptr{Cchar}, Ptr{Cchar}), info, key, value)
end

"""
    PMPI_Abort(comm, errorcode)

$(_doc_external(:PMPI_Abort))
"""
function PMPI_Abort(comm, errorcode)
    @mpichk ccall((:PMPI_Abort, libmpi), Cint, (MPI_Comm, Cint), comm, errorcode)
end

"""
    PMPI_Comm_create_from_group(group, stringtag, info, errhandler, newcomm)

$(_doc_external(:PMPI_Comm_create_from_group))
"""
function PMPI_Comm_create_from_group(group, stringtag, info, errhandler, newcomm)
    @mpichk ccall((:PMPI_Comm_create_from_group, libmpi), Cint, (MPI_Group, Ptr{Cchar}, MPI_Info, MPI_Errhandler, Ptr{MPI_Comm}), group, stringtag, info, errhandler, newcomm)
end

"""
    PMPI_Finalize()

$(_doc_external(:PMPI_Finalize))
"""
function PMPI_Finalize()
    @mpichk ccall((:PMPI_Finalize, libmpi), Cint, ())
end

"""
    PMPI_Finalized(flag)

$(_doc_external(:PMPI_Finalized))
"""
function PMPI_Finalized(flag)
    @mpichk ccall((:PMPI_Finalized, libmpi), Cint, (Ptr{Cint},), flag)
end

"""
    PMPI_Group_from_session_pset(session, pset_name, newgroup)

$(_doc_external(:PMPI_Group_from_session_pset))
"""
function PMPI_Group_from_session_pset(session, pset_name, newgroup)
    @mpichk ccall((:PMPI_Group_from_session_pset, libmpi), Cint, (MPI_Session, Ptr{Cchar}, Ptr{MPI_Group}), session, pset_name, newgroup)
end

"""
    PMPI_Init(argc, argv)

$(_doc_external(:PMPI_Init))
"""
function PMPI_Init(argc, argv)
    @mpichk ccall((:PMPI_Init, libmpi), Cint, (Ptr{Cint}, Ptr{Ptr{Ptr{Cchar}}}), argc, argv)
end

"""
    PMPI_Init_thread(argc, argv, required, provided)

$(_doc_external(:PMPI_Init_thread))
"""
function PMPI_Init_thread(argc, argv, required, provided)
    @mpichk ccall((:PMPI_Init_thread, libmpi), Cint, (Ptr{Cint}, Ptr{Ptr{Ptr{Cchar}}}, Cint, Ptr{Cint}), argc, argv, required, provided)
end

"""
    PMPI_Initialized(flag)

$(_doc_external(:PMPI_Initialized))
"""
function PMPI_Initialized(flag)
    @mpichk ccall((:PMPI_Initialized, libmpi), Cint, (Ptr{Cint},), flag)
end

"""
    PMPI_Is_thread_main(flag)

$(_doc_external(:PMPI_Is_thread_main))
"""
function PMPI_Is_thread_main(flag)
    @mpichk ccall((:PMPI_Is_thread_main, libmpi), Cint, (Ptr{Cint},), flag)
end

"""
    PMPI_Query_thread(provided)

$(_doc_external(:PMPI_Query_thread))
"""
function PMPI_Query_thread(provided)
    @mpichk ccall((:PMPI_Query_thread, libmpi), Cint, (Ptr{Cint},), provided)
end

"""
    PMPI_Session_finalize(session)

$(_doc_external(:PMPI_Session_finalize))
"""
function PMPI_Session_finalize(session)
    @mpichk ccall((:PMPI_Session_finalize, libmpi), Cint, (Ptr{MPI_Session},), session)
end

"""
    PMPI_Session_get_info(session, info_used)

$(_doc_external(:PMPI_Session_get_info))
"""
function PMPI_Session_get_info(session, info_used)
    @mpichk ccall((:PMPI_Session_get_info, libmpi), Cint, (MPI_Session, Ptr{MPI_Info}), session, info_used)
end

"""
    PMPI_Session_get_nth_pset(session, info, n, pset_len, pset_name)

$(_doc_external(:PMPI_Session_get_nth_pset))
"""
function PMPI_Session_get_nth_pset(session, info, n, pset_len, pset_name)
    @mpichk ccall((:PMPI_Session_get_nth_pset, libmpi), Cint, (MPI_Session, MPI_Info, Cint, Ptr{Cint}, Ptr{Cchar}), session, info, n, pset_len, pset_name)
end

"""
    PMPI_Session_get_num_psets(session, info, npset_names)

$(_doc_external(:PMPI_Session_get_num_psets))
"""
function PMPI_Session_get_num_psets(session, info, npset_names)
    @mpichk ccall((:PMPI_Session_get_num_psets, libmpi), Cint, (MPI_Session, MPI_Info, Ptr{Cint}), session, info, npset_names)
end

"""
    PMPI_Session_get_pset_info(session, pset_name, info)

$(_doc_external(:PMPI_Session_get_pset_info))
"""
function PMPI_Session_get_pset_info(session, pset_name, info)
    @mpichk ccall((:PMPI_Session_get_pset_info, libmpi), Cint, (MPI_Session, Ptr{Cchar}, Ptr{MPI_Info}), session, pset_name, info)
end

"""
    PMPI_Session_init(info, errhandler, session)

$(_doc_external(:PMPI_Session_init))
"""
function PMPI_Session_init(info, errhandler, session)
    @mpichk ccall((:PMPI_Session_init, libmpi), Cint, (MPI_Info, MPI_Errhandler, Ptr{MPI_Session}), info, errhandler, session)
end

"""
    PMPI_Aint_add(base, disp)

$(_doc_external(:PMPI_Aint_add))
"""
function PMPI_Aint_add(base, disp)
    @mpichk ccall((:PMPI_Aint_add, libmpi), MPI_Aint, (MPI_Aint, MPI_Aint), base, disp)
end

"""
    PMPI_Aint_diff(addr1, addr2)

$(_doc_external(:PMPI_Aint_diff))
"""
function PMPI_Aint_diff(addr1, addr2)
    @mpichk ccall((:PMPI_Aint_diff, libmpi), MPI_Aint, (MPI_Aint, MPI_Aint), addr1, addr2)
end

"""
    PMPI_Get_library_version(version, resultlen)

$(_doc_external(:PMPI_Get_library_version))
"""
function PMPI_Get_library_version(version, resultlen)
    @mpichk ccall((:PMPI_Get_library_version, libmpi), Cint, (Ptr{Cchar}, Ptr{Cint}), version, resultlen)
end

"""
    PMPI_Get_processor_name(name, resultlen)

$(_doc_external(:PMPI_Get_processor_name))
"""
function PMPI_Get_processor_name(name, resultlen)
    @mpichk ccall((:PMPI_Get_processor_name, libmpi), Cint, (Ptr{Cchar}, Ptr{Cint}), name, resultlen)
end

"""
    PMPI_Get_version(version, subversion)

$(_doc_external(:PMPI_Get_version))
"""
function PMPI_Get_version(version, subversion)
    @mpichk ccall((:PMPI_Get_version, libmpi), Cint, (Ptr{Cint}, Ptr{Cint}), version, subversion)
end

"""
    PMPIX_GPU_query_support(gpu_type, is_supported)

$(_doc_external(:PMPIX_GPU_query_support))
"""
function PMPIX_GPU_query_support(gpu_type, is_supported)
    @mpichk ccall((:PMPIX_GPU_query_support, libmpi), Cint, (Cint, Ptr{Cint}), gpu_type, is_supported)
end

"""
    PMPIX_Query_cuda_support()

$(_doc_external(:PMPIX_Query_cuda_support))
"""
function PMPIX_Query_cuda_support()
    @mpichk ccall((:PMPIX_Query_cuda_support, libmpi), Cint, ())
end

"""
    PMPIX_Query_ze_support()

$(_doc_external(:PMPIX_Query_ze_support))
"""
function PMPIX_Query_ze_support()
    @mpichk ccall((:PMPIX_Query_ze_support, libmpi), Cint, ())
end

"""
    PMPIX_Query_hip_support()

$(_doc_external(:PMPIX_Query_hip_support))
"""
function PMPIX_Query_hip_support()
    @mpichk ccall((:PMPIX_Query_hip_support, libmpi), Cint, ())
end

"""
    PMPI_T_category_changed(update_number)

$(_doc_external(:PMPI_T_category_changed))
"""
function PMPI_T_category_changed(update_number)
    @mpichk ccall((:PMPI_T_category_changed, libmpi), Cint, (Ptr{Cint},), update_number)
end

"""
    PMPI_T_category_get_categories(cat_index, len, indices)

$(_doc_external(:PMPI_T_category_get_categories))
"""
function PMPI_T_category_get_categories(cat_index, len, indices)
    @mpichk ccall((:PMPI_T_category_get_categories, libmpi), Cint, (Cint, Cint, Ptr{Cint}), cat_index, len, indices)
end

"""
    PMPI_T_category_get_cvars(cat_index, len, indices)

$(_doc_external(:PMPI_T_category_get_cvars))
"""
function PMPI_T_category_get_cvars(cat_index, len, indices)
    @mpichk ccall((:PMPI_T_category_get_cvars, libmpi), Cint, (Cint, Cint, Ptr{Cint}), cat_index, len, indices)
end

"""
    PMPI_T_category_get_events(cat_index, len, indices)

$(_doc_external(:PMPI_T_category_get_events))
"""
function PMPI_T_category_get_events(cat_index, len, indices)
    @mpichk ccall((:PMPI_T_category_get_events, libmpi), Cint, (Cint, Cint, Ptr{Cint}), cat_index, len, indices)
end

"""
    PMPI_T_category_get_index(name, cat_index)

$(_doc_external(:PMPI_T_category_get_index))
"""
function PMPI_T_category_get_index(name, cat_index)
    @mpichk ccall((:PMPI_T_category_get_index, libmpi), Cint, (Ptr{Cchar}, Ptr{Cint}), name, cat_index)
end

"""
    PMPI_T_category_get_info(cat_index, name, name_len, desc, desc_len, num_cvars, num_pvars, num_categories)

$(_doc_external(:PMPI_T_category_get_info))
"""
function PMPI_T_category_get_info(cat_index, name, name_len, desc, desc_len, num_cvars, num_pvars, num_categories)
    @mpichk ccall((:PMPI_T_category_get_info, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), cat_index, name, name_len, desc, desc_len, num_cvars, num_pvars, num_categories)
end

"""
    PMPI_T_category_get_num(num_cat)

$(_doc_external(:PMPI_T_category_get_num))
"""
function PMPI_T_category_get_num(num_cat)
    @mpichk ccall((:PMPI_T_category_get_num, libmpi), Cint, (Ptr{Cint},), num_cat)
end

"""
    PMPI_T_category_get_num_events(cat_index, num_events)

$(_doc_external(:PMPI_T_category_get_num_events))
"""
function PMPI_T_category_get_num_events(cat_index, num_events)
    @mpichk ccall((:PMPI_T_category_get_num_events, libmpi), Cint, (Cint, Ptr{Cint}), cat_index, num_events)
end

"""
    PMPI_T_category_get_pvars(cat_index, len, indices)

$(_doc_external(:PMPI_T_category_get_pvars))
"""
function PMPI_T_category_get_pvars(cat_index, len, indices)
    @mpichk ccall((:PMPI_T_category_get_pvars, libmpi), Cint, (Cint, Cint, Ptr{Cint}), cat_index, len, indices)
end

"""
    PMPI_T_cvar_get_index(name, cvar_index)

$(_doc_external(:PMPI_T_cvar_get_index))
"""
function PMPI_T_cvar_get_index(name, cvar_index)
    @mpichk ccall((:PMPI_T_cvar_get_index, libmpi), Cint, (Ptr{Cchar}, Ptr{Cint}), name, cvar_index)
end

"""
    PMPI_T_cvar_get_info(cvar_index, name, name_len, verbosity, datatype, enumtype, desc, desc_len, bind, scope)

$(_doc_external(:PMPI_T_cvar_get_info))
"""
function PMPI_T_cvar_get_info(cvar_index, name, name_len, verbosity, datatype, enumtype, desc, desc_len, bind, scope)
    @mpichk ccall((:PMPI_T_cvar_get_info, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{MPI_T_enum}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), cvar_index, name, name_len, verbosity, datatype, enumtype, desc, desc_len, bind, scope)
end

"""
    PMPI_T_cvar_get_num(num_cvar)

$(_doc_external(:PMPI_T_cvar_get_num))
"""
function PMPI_T_cvar_get_num(num_cvar)
    @mpichk ccall((:PMPI_T_cvar_get_num, libmpi), Cint, (Ptr{Cint},), num_cvar)
end

"""
    PMPI_T_cvar_handle_alloc(cvar_index, obj_handle, handle, count)

$(_doc_external(:PMPI_T_cvar_handle_alloc))
"""
function PMPI_T_cvar_handle_alloc(cvar_index, obj_handle, handle, count)
    @mpichk ccall((:PMPI_T_cvar_handle_alloc, libmpi), Cint, (Cint, MPIPtr, Ptr{MPI_T_cvar_handle}, Ptr{Cint}), cvar_index, obj_handle, handle, count)
end

"""
    PMPI_T_cvar_handle_free(handle)

$(_doc_external(:PMPI_T_cvar_handle_free))
"""
function PMPI_T_cvar_handle_free(handle)
    @mpichk ccall((:PMPI_T_cvar_handle_free, libmpi), Cint, (Ptr{MPI_T_cvar_handle},), handle)
end

"""
    PMPI_T_cvar_read(handle, buf)

$(_doc_external(:PMPI_T_cvar_read))
"""
function PMPI_T_cvar_read(handle, buf)
    @mpichk ccall((:PMPI_T_cvar_read, libmpi), Cint, (MPI_T_cvar_handle, MPIPtr), handle, buf)
end

"""
    PMPI_T_cvar_write(handle, buf)

$(_doc_external(:PMPI_T_cvar_write))
"""
function PMPI_T_cvar_write(handle, buf)
    @mpichk ccall((:PMPI_T_cvar_write, libmpi), Cint, (MPI_T_cvar_handle, MPIPtr), handle, buf)
end

"""
    PMPI_T_enum_get_info(enumtype, num, name, name_len)

$(_doc_external(:PMPI_T_enum_get_info))
"""
function PMPI_T_enum_get_info(enumtype, num, name, name_len)
    @mpichk ccall((:PMPI_T_enum_get_info, libmpi), Cint, (MPI_T_enum, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}), enumtype, num, name, name_len)
end

"""
    PMPI_T_enum_get_item(enumtype, indx, value, name, name_len)

$(_doc_external(:PMPI_T_enum_get_item))
"""
function PMPI_T_enum_get_item(enumtype, indx, value, name, name_len)
    @mpichk ccall((:PMPI_T_enum_get_item, libmpi), Cint, (MPI_T_enum, Cint, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}), enumtype, indx, value, name, name_len)
end

"""
    PMPI_T_event_callback_get_info(event_registration, cb_safety, info_used)

$(_doc_external(:PMPI_T_event_callback_get_info))
"""
function PMPI_T_event_callback_get_info(event_registration, cb_safety, info_used)
    @mpichk ccall((:PMPI_T_event_callback_get_info, libmpi), Cint, (MPI_T_event_registration, MPI_T_cb_safety, Ptr{MPI_Info}), event_registration, cb_safety, info_used)
end

"""
    PMPI_T_event_callback_set_info(event_registration, cb_safety, info)

$(_doc_external(:PMPI_T_event_callback_set_info))
"""
function PMPI_T_event_callback_set_info(event_registration, cb_safety, info)
    @mpichk ccall((:PMPI_T_event_callback_set_info, libmpi), Cint, (MPI_T_event_registration, MPI_T_cb_safety, MPI_Info), event_registration, cb_safety, info)
end

"""
    PMPI_T_event_copy(event_instance, buffer)

$(_doc_external(:PMPI_T_event_copy))
"""
function PMPI_T_event_copy(event_instance, buffer)
    @mpichk ccall((:PMPI_T_event_copy, libmpi), Cint, (MPI_T_event_instance, MPIPtr), event_instance, buffer)
end

"""
    PMPI_T_event_get_index(name, event_index)

$(_doc_external(:PMPI_T_event_get_index))
"""
function PMPI_T_event_get_index(name, event_index)
    @mpichk ccall((:PMPI_T_event_get_index, libmpi), Cint, (Ptr{Cchar}, Ptr{Cint}), name, event_index)
end

"""
    PMPI_T_event_get_info(event_index, name, name_len, verbosity, array_of_datatypes, array_of_displacements, num_elements, enumtype, info, desc, desc_len, bind)

$(_doc_external(:PMPI_T_event_get_info))
"""
function PMPI_T_event_get_info(event_index, name, name_len, verbosity, array_of_datatypes, array_of_displacements, num_elements, enumtype, info, desc, desc_len, bind)
    @mpichk ccall((:PMPI_T_event_get_info, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{MPI_Aint}, Ptr{Cint}, Ptr{MPI_T_enum}, Ptr{MPI_Info}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}), event_index, name, name_len, verbosity, array_of_datatypes, array_of_displacements, num_elements, enumtype, info, desc, desc_len, bind)
end

"""
    PMPI_T_event_get_num(num_events)

$(_doc_external(:PMPI_T_event_get_num))
"""
function PMPI_T_event_get_num(num_events)
    @mpichk ccall((:PMPI_T_event_get_num, libmpi), Cint, (Ptr{Cint},), num_events)
end

"""
    PMPI_T_event_get_source(event_instance, source_index)

$(_doc_external(:PMPI_T_event_get_source))
"""
function PMPI_T_event_get_source(event_instance, source_index)
    @mpichk ccall((:PMPI_T_event_get_source, libmpi), Cint, (MPI_T_event_instance, Ptr{Cint}), event_instance, source_index)
end

"""
    PMPI_T_event_get_timestamp(event_instance, event_timestamp)

$(_doc_external(:PMPI_T_event_get_timestamp))
"""
function PMPI_T_event_get_timestamp(event_instance, event_timestamp)
    @mpichk ccall((:PMPI_T_event_get_timestamp, libmpi), Cint, (MPI_T_event_instance, Ptr{MPI_Count}), event_instance, event_timestamp)
end

"""
    PMPI_T_event_handle_alloc(event_index, obj_handle, info, event_registration)

$(_doc_external(:PMPI_T_event_handle_alloc))
"""
function PMPI_T_event_handle_alloc(event_index, obj_handle, info, event_registration)
    @mpichk ccall((:PMPI_T_event_handle_alloc, libmpi), Cint, (Cint, MPIPtr, MPI_Info, Ptr{MPI_T_event_registration}), event_index, obj_handle, info, event_registration)
end

"""
    PMPI_T_event_handle_free(event_registration, user_data, free_cb_function)

$(_doc_external(:PMPI_T_event_handle_free))
"""
function PMPI_T_event_handle_free(event_registration, user_data, free_cb_function)
    @mpichk ccall((:PMPI_T_event_handle_free, libmpi), Cint, (MPI_T_event_registration, MPIPtr, MPI_T_event_free_cb_function), event_registration, user_data, free_cb_function)
end

"""
    PMPI_T_event_handle_get_info(event_registration, info_used)

$(_doc_external(:PMPI_T_event_handle_get_info))
"""
function PMPI_T_event_handle_get_info(event_registration, info_used)
    @mpichk ccall((:PMPI_T_event_handle_get_info, libmpi), Cint, (MPI_T_event_registration, Ptr{MPI_Info}), event_registration, info_used)
end

"""
    PMPI_T_event_handle_set_info(event_registration, info)

$(_doc_external(:PMPI_T_event_handle_set_info))
"""
function PMPI_T_event_handle_set_info(event_registration, info)
    @mpichk ccall((:PMPI_T_event_handle_set_info, libmpi), Cint, (MPI_T_event_registration, MPI_Info), event_registration, info)
end

"""
    PMPI_T_event_read(event_instance, element_index, buffer)

$(_doc_external(:PMPI_T_event_read))
"""
function PMPI_T_event_read(event_instance, element_index, buffer)
    @mpichk ccall((:PMPI_T_event_read, libmpi), Cint, (MPI_T_event_instance, Cint, MPIPtr), event_instance, element_index, buffer)
end

"""
    PMPI_T_event_register_callback(event_registration, cb_safety, info, user_data, event_cb_function)

$(_doc_external(:PMPI_T_event_register_callback))
"""
function PMPI_T_event_register_callback(event_registration, cb_safety, info, user_data, event_cb_function)
    @mpichk ccall((:PMPI_T_event_register_callback, libmpi), Cint, (MPI_T_event_registration, MPI_T_cb_safety, MPI_Info, MPIPtr, MPI_T_event_cb_function), event_registration, cb_safety, info, user_data, event_cb_function)
end

"""
    PMPI_T_event_set_dropped_handler(event_registration, dropped_cb_function)

$(_doc_external(:PMPI_T_event_set_dropped_handler))
"""
function PMPI_T_event_set_dropped_handler(event_registration, dropped_cb_function)
    @mpichk ccall((:PMPI_T_event_set_dropped_handler, libmpi), Cint, (MPI_T_event_registration, MPI_T_event_dropped_cb_function), event_registration, dropped_cb_function)
end

"""
    PMPI_T_finalize()

$(_doc_external(:PMPI_T_finalize))
"""
function PMPI_T_finalize()
    @mpichk ccall((:PMPI_T_finalize, libmpi), Cint, ())
end

"""
    PMPI_T_init_thread(required, provided)

$(_doc_external(:PMPI_T_init_thread))
"""
function PMPI_T_init_thread(required, provided)
    @mpichk ccall((:PMPI_T_init_thread, libmpi), Cint, (Cint, Ptr{Cint}), required, provided)
end

"""
    PMPI_T_pvar_get_index(name, var_class, pvar_index)

$(_doc_external(:PMPI_T_pvar_get_index))
"""
function PMPI_T_pvar_get_index(name, var_class, pvar_index)
    @mpichk ccall((:PMPI_T_pvar_get_index, libmpi), Cint, (Ptr{Cchar}, Cint, Ptr{Cint}), name, var_class, pvar_index)
end

"""
    PMPI_T_pvar_get_info(pvar_index, name, name_len, verbosity, var_class, datatype, enumtype, desc, desc_len, bind, readonly, continuous, atomic)

$(_doc_external(:PMPI_T_pvar_get_info))
"""
function PMPI_T_pvar_get_info(pvar_index, name, name_len, verbosity, var_class, datatype, enumtype, desc, desc_len, bind, readonly, continuous, atomic)
    @mpichk ccall((:PMPI_T_pvar_get_info, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{MPI_T_enum}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), pvar_index, name, name_len, verbosity, var_class, datatype, enumtype, desc, desc_len, bind, readonly, continuous, atomic)
end

"""
    PMPI_T_pvar_get_num(num_pvar)

$(_doc_external(:PMPI_T_pvar_get_num))
"""
function PMPI_T_pvar_get_num(num_pvar)
    @mpichk ccall((:PMPI_T_pvar_get_num, libmpi), Cint, (Ptr{Cint},), num_pvar)
end

"""
    PMPI_T_pvar_handle_alloc(session, pvar_index, obj_handle, handle, count)

$(_doc_external(:PMPI_T_pvar_handle_alloc))
"""
function PMPI_T_pvar_handle_alloc(session, pvar_index, obj_handle, handle, count)
    @mpichk ccall((:PMPI_T_pvar_handle_alloc, libmpi), Cint, (MPI_T_pvar_session, Cint, MPIPtr, Ptr{MPI_T_pvar_handle}, Ptr{Cint}), session, pvar_index, obj_handle, handle, count)
end

"""
    PMPI_T_pvar_handle_free(session, handle)

$(_doc_external(:PMPI_T_pvar_handle_free))
"""
function PMPI_T_pvar_handle_free(session, handle)
    @mpichk ccall((:PMPI_T_pvar_handle_free, libmpi), Cint, (MPI_T_pvar_session, Ptr{MPI_T_pvar_handle}), session, handle)
end

"""
    PMPI_T_pvar_read(session, handle, buf)

$(_doc_external(:PMPI_T_pvar_read))
"""
function PMPI_T_pvar_read(session, handle, buf)
    @mpichk ccall((:PMPI_T_pvar_read, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle, MPIPtr), session, handle, buf)
end

"""
    PMPI_T_pvar_readreset(session, handle, buf)

$(_doc_external(:PMPI_T_pvar_readreset))
"""
function PMPI_T_pvar_readreset(session, handle, buf)
    @mpichk ccall((:PMPI_T_pvar_readreset, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle, MPIPtr), session, handle, buf)
end

"""
    PMPI_T_pvar_reset(session, handle)

$(_doc_external(:PMPI_T_pvar_reset))
"""
function PMPI_T_pvar_reset(session, handle)
    @mpichk ccall((:PMPI_T_pvar_reset, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle), session, handle)
end

"""
    PMPI_T_pvar_session_create(session)

$(_doc_external(:PMPI_T_pvar_session_create))
"""
function PMPI_T_pvar_session_create(session)
    @mpichk ccall((:PMPI_T_pvar_session_create, libmpi), Cint, (Ptr{MPI_T_pvar_session},), session)
end

"""
    PMPI_T_pvar_session_free(session)

$(_doc_external(:PMPI_T_pvar_session_free))
"""
function PMPI_T_pvar_session_free(session)
    @mpichk ccall((:PMPI_T_pvar_session_free, libmpi), Cint, (Ptr{MPI_T_pvar_session},), session)
end

"""
    PMPI_T_pvar_start(session, handle)

$(_doc_external(:PMPI_T_pvar_start))
"""
function PMPI_T_pvar_start(session, handle)
    @mpichk ccall((:PMPI_T_pvar_start, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle), session, handle)
end

"""
    PMPI_T_pvar_stop(session, handle)

$(_doc_external(:PMPI_T_pvar_stop))
"""
function PMPI_T_pvar_stop(session, handle)
    @mpichk ccall((:PMPI_T_pvar_stop, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle), session, handle)
end

"""
    PMPI_T_pvar_write(session, handle, buf)

$(_doc_external(:PMPI_T_pvar_write))
"""
function PMPI_T_pvar_write(session, handle, buf)
    @mpichk ccall((:PMPI_T_pvar_write, libmpi), Cint, (MPI_T_pvar_session, MPI_T_pvar_handle, MPIPtr), session, handle, buf)
end

"""
    PMPI_T_source_get_info(source_index, name, name_len, desc, desc_len, ordering, ticks_per_second, max_ticks, info)

$(_doc_external(:PMPI_T_source_get_info))
"""
function PMPI_T_source_get_info(source_index, name, name_len, desc, desc_len, ordering, ticks_per_second, max_ticks, info)
    @mpichk ccall((:PMPI_T_source_get_info, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}, Ptr{MPI_T_source_order}, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Info}), source_index, name, name_len, desc, desc_len, ordering, ticks_per_second, max_ticks, info)
end

"""
    PMPI_T_source_get_num(num_sources)

$(_doc_external(:PMPI_T_source_get_num))
"""
function PMPI_T_source_get_num(num_sources)
    @mpichk ccall((:PMPI_T_source_get_num, libmpi), Cint, (Ptr{Cint},), num_sources)
end

"""
    PMPI_T_source_get_timestamp(source_index, timestamp)

$(_doc_external(:PMPI_T_source_get_timestamp))
"""
function PMPI_T_source_get_timestamp(source_index, timestamp)
    @mpichk ccall((:PMPI_T_source_get_timestamp, libmpi), Cint, (Cint, Ptr{MPI_Count}), source_index, timestamp)
end

"""
    PMPI_Op_commutative(op, commute)

$(_doc_external(:PMPI_Op_commutative))
"""
function PMPI_Op_commutative(op, commute)
    @mpichk ccall((:PMPI_Op_commutative, libmpi), Cint, (MPI_Op, Ptr{Cint}), op, commute)
end

"""
    PMPI_Op_create(user_fn, commute, op)

$(_doc_external(:PMPI_Op_create))
"""
function PMPI_Op_create(user_fn, commute, op)
    @mpichk ccall((:PMPI_Op_create, libmpi), Cint, (MPIPtr, Cint, Ptr{MPI_Op}), user_fn, commute, op)
end

"""
    PMPI_Op_create_c(user_fn, commute, op)

$(_doc_external(:PMPI_Op_create_c))
"""
function PMPI_Op_create_c(user_fn, commute, op)
    @mpichk ccall((:PMPI_Op_create_c, libmpi), Cint, (MPIPtr, Cint, Ptr{MPI_Op}), user_fn, commute, op)
end

"""
    PMPI_Op_free(op)

$(_doc_external(:PMPI_Op_free))
"""
function PMPI_Op_free(op)
    @mpichk ccall((:PMPI_Op_free, libmpi), Cint, (Ptr{MPI_Op},), op)
end

"""
    PMPI_Parrived(request, partition, flag)

$(_doc_external(:PMPI_Parrived))
"""
function PMPI_Parrived(request, partition, flag)
    @mpichk ccall((:PMPI_Parrived, libmpi), Cint, (MPI_Request, Cint, Ptr{Cint}), request, partition, flag)
end

"""
    PMPI_Pready(partition, request)

$(_doc_external(:PMPI_Pready))
"""
function PMPI_Pready(partition, request)
    @mpichk ccall((:PMPI_Pready, libmpi), Cint, (Cint, MPI_Request), partition, request)
end

"""
    PMPI_Pready_list(length, array_of_partitions, request)

$(_doc_external(:PMPI_Pready_list))
"""
function PMPI_Pready_list(length, array_of_partitions, request)
    @mpichk ccall((:PMPI_Pready_list, libmpi), Cint, (Cint, Ptr{Cint}, MPI_Request), length, array_of_partitions, request)
end

"""
    PMPI_Pready_range(partition_low, partition_high, request)

$(_doc_external(:PMPI_Pready_range))
"""
function PMPI_Pready_range(partition_low, partition_high, request)
    @mpichk ccall((:PMPI_Pready_range, libmpi), Cint, (Cint, Cint, MPI_Request), partition_low, partition_high, request)
end

"""
    PMPI_Precv_init(buf, partitions, count, datatype, dest, tag, comm, info, request)

$(_doc_external(:PMPI_Precv_init))
"""
function PMPI_Precv_init(buf, partitions, count, datatype, dest, tag, comm, info, request)
    @mpichk ccall((:PMPI_Precv_init, libmpi), Cint, (MPIPtr, Cint, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), buf, partitions, count, datatype, dest, tag, comm, info, request)
end

"""
    PMPI_Psend_init(buf, partitions, count, datatype, dest, tag, comm, info, request)

$(_doc_external(:PMPI_Psend_init))
"""
function PMPI_Psend_init(buf, partitions, count, datatype, dest, tag, comm, info, request)
    @mpichk ccall((:PMPI_Psend_init, libmpi), Cint, (MPIPtr, Cint, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), buf, partitions, count, datatype, dest, tag, comm, info, request)
end

"""
    PMPI_Bsend(buf, count, datatype, dest, tag, comm)

$(_doc_external(:PMPI_Bsend))
"""
function PMPI_Bsend(buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:PMPI_Bsend, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

"""
    PMPI_Bsend_c(buf, count, datatype, dest, tag, comm)

$(_doc_external(:PMPI_Bsend_c))
"""
function PMPI_Bsend_c(buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:PMPI_Bsend_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

"""
    PMPI_Bsend_init(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:PMPI_Bsend_init))
"""
function PMPI_Bsend_init(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:PMPI_Bsend_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    PMPI_Bsend_init_c(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:PMPI_Bsend_init_c))
"""
function PMPI_Bsend_init_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:PMPI_Bsend_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    PMPI_Buffer_attach(buffer, size)

$(_doc_external(:PMPI_Buffer_attach))
"""
function PMPI_Buffer_attach(buffer, size)
    @mpichk ccall((:PMPI_Buffer_attach, libmpi), Cint, (MPIPtr, Cint), buffer, size)
end

"""
    PMPI_Buffer_attach_c(buffer, size)

$(_doc_external(:PMPI_Buffer_attach_c))
"""
function PMPI_Buffer_attach_c(buffer, size)
    @mpichk ccall((:PMPI_Buffer_attach_c, libmpi), Cint, (MPIPtr, MPI_Count), buffer, size)
end

"""
    PMPI_Buffer_detach(buffer_addr, size)

$(_doc_external(:PMPI_Buffer_detach))
"""
function PMPI_Buffer_detach(buffer_addr, size)
    @mpichk ccall((:PMPI_Buffer_detach, libmpi), Cint, (MPIPtr, Ptr{Cint}), buffer_addr, size)
end

"""
    PMPI_Buffer_detach_c(buffer_addr, size)

$(_doc_external(:PMPI_Buffer_detach_c))
"""
function PMPI_Buffer_detach_c(buffer_addr, size)
    @mpichk ccall((:PMPI_Buffer_detach_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}), buffer_addr, size)
end

"""
    PMPI_Ibsend(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:PMPI_Ibsend))
"""
function PMPI_Ibsend(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:PMPI_Ibsend, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    PMPI_Ibsend_c(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:PMPI_Ibsend_c))
"""
function PMPI_Ibsend_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:PMPI_Ibsend_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    PMPI_Improbe(source, tag, comm, flag, message, status)

$(_doc_external(:PMPI_Improbe))
"""
function PMPI_Improbe(source, tag, comm, flag, message, status)
    @mpichk ccall((:PMPI_Improbe, libmpi), Cint, (Cint, Cint, MPI_Comm, Ptr{Cint}, Ptr{MPI_Message}, Ptr{MPI_Status}), source, tag, comm, flag, message, status)
end

"""
    PMPI_Imrecv(buf, count, datatype, message, request)

$(_doc_external(:PMPI_Imrecv))
"""
function PMPI_Imrecv(buf, count, datatype, message, request)
    @mpichk ccall((:PMPI_Imrecv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Request}), buf, count, datatype, message, request)
end

"""
    PMPI_Imrecv_c(buf, count, datatype, message, request)

$(_doc_external(:PMPI_Imrecv_c))
"""
function PMPI_Imrecv_c(buf, count, datatype, message, request)
    @mpichk ccall((:PMPI_Imrecv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Request}), buf, count, datatype, message, request)
end

"""
    PMPI_Iprobe(source, tag, comm, flag, status)

$(_doc_external(:PMPI_Iprobe))
"""
function PMPI_Iprobe(source, tag, comm, flag, status)
    @mpichk ccall((:PMPI_Iprobe, libmpi), Cint, (Cint, Cint, MPI_Comm, Ptr{Cint}, Ptr{MPI_Status}), source, tag, comm, flag, status)
end

"""
    PMPI_Irecv(buf, count, datatype, source, tag, comm, request)

$(_doc_external(:PMPI_Irecv))
"""
function PMPI_Irecv(buf, count, datatype, source, tag, comm, request)
    @mpichk ccall((:PMPI_Irecv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, source, tag, comm, request)
end

"""
    PMPI_Irecv_c(buf, count, datatype, source, tag, comm, request)

$(_doc_external(:PMPI_Irecv_c))
"""
function PMPI_Irecv_c(buf, count, datatype, source, tag, comm, request)
    @mpichk ccall((:PMPI_Irecv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, source, tag, comm, request)
end

"""
    PMPI_Irsend(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:PMPI_Irsend))
"""
function PMPI_Irsend(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:PMPI_Irsend, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    PMPI_Irsend_c(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:PMPI_Irsend_c))
"""
function PMPI_Irsend_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:PMPI_Irsend_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    PMPI_Isend(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:PMPI_Isend))
"""
function PMPI_Isend(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:PMPI_Isend, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    PMPI_Isend_c(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:PMPI_Isend_c))
"""
function PMPI_Isend_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:PMPI_Isend_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    PMPI_Isendrecv(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)

$(_doc_external(:PMPI_Isendrecv))
"""
function PMPI_Isendrecv(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
    @mpichk ccall((:PMPI_Isendrecv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
end

"""
    PMPI_Isendrecv_c(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)

$(_doc_external(:PMPI_Isendrecv_c))
"""
function PMPI_Isendrecv_c(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
    @mpichk ccall((:PMPI_Isendrecv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
end

"""
    PMPI_Isendrecv_replace(buf, count, datatype, dest, sendtag, source, recvtag, comm, request)

$(_doc_external(:PMPI_Isendrecv_replace))
"""
function PMPI_Isendrecv_replace(buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
    @mpichk ccall((:PMPI_Isendrecv_replace, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
end

"""
    PMPI_Isendrecv_replace_c(buf, count, datatype, dest, sendtag, source, recvtag, comm, request)

$(_doc_external(:PMPI_Isendrecv_replace_c))
"""
function PMPI_Isendrecv_replace_c(buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
    @mpichk ccall((:PMPI_Isendrecv_replace_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
end

"""
    PMPI_Issend(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:PMPI_Issend))
"""
function PMPI_Issend(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:PMPI_Issend, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    PMPI_Issend_c(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:PMPI_Issend_c))
"""
function PMPI_Issend_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:PMPI_Issend_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    PMPI_Mprobe(source, tag, comm, message, status)

$(_doc_external(:PMPI_Mprobe))
"""
function PMPI_Mprobe(source, tag, comm, message, status)
    @mpichk ccall((:PMPI_Mprobe, libmpi), Cint, (Cint, Cint, MPI_Comm, Ptr{MPI_Message}, Ptr{MPI_Status}), source, tag, comm, message, status)
end

"""
    PMPI_Mrecv(buf, count, datatype, message, status)

$(_doc_external(:PMPI_Mrecv))
"""
function PMPI_Mrecv(buf, count, datatype, message, status)
    @mpichk ccall((:PMPI_Mrecv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Status}), buf, count, datatype, message, status)
end

"""
    PMPI_Mrecv_c(buf, count, datatype, message, status)

$(_doc_external(:PMPI_Mrecv_c))
"""
function PMPI_Mrecv_c(buf, count, datatype, message, status)
    @mpichk ccall((:PMPI_Mrecv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Status}), buf, count, datatype, message, status)
end

"""
    PMPI_Probe(source, tag, comm, status)

$(_doc_external(:PMPI_Probe))
"""
function PMPI_Probe(source, tag, comm, status)
    @mpichk ccall((:PMPI_Probe, libmpi), Cint, (Cint, Cint, MPI_Comm, Ptr{MPI_Status}), source, tag, comm, status)
end

"""
    PMPI_Recv(buf, count, datatype, source, tag, comm, status)

$(_doc_external(:PMPI_Recv))
"""
function PMPI_Recv(buf, count, datatype, source, tag, comm, status)
    @mpichk ccall((:PMPI_Recv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), buf, count, datatype, source, tag, comm, status)
end

"""
    PMPI_Recv_c(buf, count, datatype, source, tag, comm, status)

$(_doc_external(:PMPI_Recv_c))
"""
function PMPI_Recv_c(buf, count, datatype, source, tag, comm, status)
    @mpichk ccall((:PMPI_Recv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), buf, count, datatype, source, tag, comm, status)
end

"""
    PMPI_Recv_init(buf, count, datatype, source, tag, comm, request)

$(_doc_external(:PMPI_Recv_init))
"""
function PMPI_Recv_init(buf, count, datatype, source, tag, comm, request)
    @mpichk ccall((:PMPI_Recv_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, source, tag, comm, request)
end

"""
    PMPI_Recv_init_c(buf, count, datatype, source, tag, comm, request)

$(_doc_external(:PMPI_Recv_init_c))
"""
function PMPI_Recv_init_c(buf, count, datatype, source, tag, comm, request)
    @mpichk ccall((:PMPI_Recv_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, source, tag, comm, request)
end

"""
    PMPI_Rsend(buf, count, datatype, dest, tag, comm)

$(_doc_external(:PMPI_Rsend))
"""
function PMPI_Rsend(buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:PMPI_Rsend, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

"""
    PMPI_Rsend_c(buf, count, datatype, dest, tag, comm)

$(_doc_external(:PMPI_Rsend_c))
"""
function PMPI_Rsend_c(buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:PMPI_Rsend_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

"""
    PMPI_Rsend_init(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:PMPI_Rsend_init))
"""
function PMPI_Rsend_init(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:PMPI_Rsend_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    PMPI_Rsend_init_c(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:PMPI_Rsend_init_c))
"""
function PMPI_Rsend_init_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:PMPI_Rsend_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    PMPI_Send(buf, count, datatype, dest, tag, comm)

$(_doc_external(:PMPI_Send))
"""
function PMPI_Send(buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:PMPI_Send, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

"""
    PMPI_Send_c(buf, count, datatype, dest, tag, comm)

$(_doc_external(:PMPI_Send_c))
"""
function PMPI_Send_c(buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:PMPI_Send_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

"""
    PMPI_Send_init(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:PMPI_Send_init))
"""
function PMPI_Send_init(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:PMPI_Send_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    PMPI_Send_init_c(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:PMPI_Send_init_c))
"""
function PMPI_Send_init_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:PMPI_Send_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    PMPI_Sendrecv(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)

$(_doc_external(:PMPI_Sendrecv))
"""
function PMPI_Sendrecv(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
    @mpichk ccall((:PMPI_Sendrecv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
end

"""
    PMPI_Sendrecv_c(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)

$(_doc_external(:PMPI_Sendrecv_c))
"""
function PMPI_Sendrecv_c(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
    @mpichk ccall((:PMPI_Sendrecv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
end

"""
    PMPI_Sendrecv_replace(buf, count, datatype, dest, sendtag, source, recvtag, comm, status)

$(_doc_external(:PMPI_Sendrecv_replace))
"""
function PMPI_Sendrecv_replace(buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
    @mpichk ccall((:PMPI_Sendrecv_replace, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
end

"""
    PMPI_Sendrecv_replace_c(buf, count, datatype, dest, sendtag, source, recvtag, comm, status)

$(_doc_external(:PMPI_Sendrecv_replace_c))
"""
function PMPI_Sendrecv_replace_c(buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
    @mpichk ccall((:PMPI_Sendrecv_replace_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
end

"""
    PMPI_Ssend(buf, count, datatype, dest, tag, comm)

$(_doc_external(:PMPI_Ssend))
"""
function PMPI_Ssend(buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:PMPI_Ssend, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

"""
    PMPI_Ssend_c(buf, count, datatype, dest, tag, comm)

$(_doc_external(:PMPI_Ssend_c))
"""
function PMPI_Ssend_c(buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:PMPI_Ssend_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

"""
    PMPI_Ssend_init(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:PMPI_Ssend_init))
"""
function PMPI_Ssend_init(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:PMPI_Ssend_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    PMPI_Ssend_init_c(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:PMPI_Ssend_init_c))
"""
function PMPI_Ssend_init_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:PMPI_Ssend_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    PMPI_Cancel(request)

$(_doc_external(:PMPI_Cancel))
"""
function PMPI_Cancel(request)
    @mpichk ccall((:PMPI_Cancel, libmpi), Cint, (Ptr{MPI_Request},), request)
end

"""
    PMPI_Grequest_complete(request)

$(_doc_external(:PMPI_Grequest_complete))
"""
function PMPI_Grequest_complete(request)
    @mpichk ccall((:PMPI_Grequest_complete, libmpi), Cint, (MPI_Request,), request)
end

"""
    PMPI_Grequest_start(query_fn, free_fn, cancel_fn, extra_state, request)

$(_doc_external(:PMPI_Grequest_start))
"""
function PMPI_Grequest_start(query_fn, free_fn, cancel_fn, extra_state, request)
    @mpichk ccall((:PMPI_Grequest_start, libmpi), Cint, (MPIPtr, MPIPtr, MPIPtr, MPIPtr, Ptr{MPI_Request}), query_fn, free_fn, cancel_fn, extra_state, request)
end

"""
    PMPI_Request_free(request)

$(_doc_external(:PMPI_Request_free))
"""
function PMPI_Request_free(request)
    @mpichk ccall((:PMPI_Request_free, libmpi), Cint, (Ptr{MPI_Request},), request)
end

"""
    PMPI_Request_get_status(request, flag, status)

$(_doc_external(:PMPI_Request_get_status))
"""
function PMPI_Request_get_status(request, flag, status)
    @mpichk ccall((:PMPI_Request_get_status, libmpi), Cint, (MPI_Request, Ptr{Cint}, Ptr{MPI_Status}), request, flag, status)
end

"""
    PMPI_Start(request)

$(_doc_external(:PMPI_Start))
"""
function PMPI_Start(request)
    @mpichk ccall((:PMPI_Start, libmpi), Cint, (Ptr{MPI_Request},), request)
end

"""
    PMPI_Startall(count, array_of_requests)

$(_doc_external(:PMPI_Startall))
"""
function PMPI_Startall(count, array_of_requests)
    @mpichk ccall((:PMPI_Startall, libmpi), Cint, (Cint, Ptr{MPI_Request}), count, array_of_requests)
end

"""
    PMPI_Status_set_cancelled(status, flag)

$(_doc_external(:PMPI_Status_set_cancelled))
"""
function PMPI_Status_set_cancelled(status, flag)
    @mpichk ccall((:PMPI_Status_set_cancelled, libmpi), Cint, (Ptr{MPI_Status}, Cint), status, flag)
end

"""
    PMPI_Test_cancelled(status, flag)

$(_doc_external(:PMPI_Test_cancelled))
"""
function PMPI_Test_cancelled(status, flag)
    @mpichk ccall((:PMPI_Test_cancelled, libmpi), Cint, (Ptr{MPI_Status}, Ptr{Cint}), status, flag)
end

"""
    PMPI_Testall(count, array_of_requests, flag, array_of_statuses)

$(_doc_external(:PMPI_Testall))
"""
function PMPI_Testall(count, array_of_requests, flag, array_of_statuses)
    @mpichk ccall((:PMPI_Testall, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{MPI_Status}), count, array_of_requests, flag, array_of_statuses)
end

"""
    PMPI_Testany(count, array_of_requests, indx, flag, status)

$(_doc_external(:PMPI_Testany))
"""
function PMPI_Testany(count, array_of_requests, indx, flag, status)
    @mpichk ccall((:PMPI_Testany, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Status}), count, array_of_requests, indx, flag, status)
end

"""
    PMPI_Testsome(incount, array_of_requests, outcount, array_of_indices, array_of_statuses)

$(_doc_external(:PMPI_Testsome))
"""
function PMPI_Testsome(incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
    @mpichk ccall((:PMPI_Testsome, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Status}), incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
end

"""
    PMPI_Waitall(count, array_of_requests, array_of_statuses)

$(_doc_external(:PMPI_Waitall))
"""
function PMPI_Waitall(count, array_of_requests, array_of_statuses)
    @mpichk ccall((:PMPI_Waitall, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{MPI_Status}), count, array_of_requests, array_of_statuses)
end

"""
    PMPI_Waitany(count, array_of_requests, indx, status)

$(_doc_external(:PMPI_Waitany))
"""
function PMPI_Waitany(count, array_of_requests, indx, status)
    @mpichk ccall((:PMPI_Waitany, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{MPI_Status}), count, array_of_requests, indx, status)
end

"""
    PMPI_Waitsome(incount, array_of_requests, outcount, array_of_indices, array_of_statuses)

$(_doc_external(:PMPI_Waitsome))
"""
function PMPI_Waitsome(incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
    @mpichk ccall((:PMPI_Waitsome, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Status}), incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
end

"""
    PMPIX_Grequest_start(query_fn, free_fn, cancel_fn, poll_fn, wait_fn, extra_state, request)

$(_doc_external(:PMPIX_Grequest_start))
"""
function PMPIX_Grequest_start(query_fn, free_fn, cancel_fn, poll_fn, wait_fn, extra_state, request)
    @mpichk ccall((:PMPIX_Grequest_start, libmpi), Cint, (MPIPtr, MPIPtr, MPIPtr, MPIPtr, MPIPtr, MPIPtr, Ptr{MPI_Request}), query_fn, free_fn, cancel_fn, poll_fn, wait_fn, extra_state, request)
end

"""
    PMPIX_Grequest_class_create(query_fn, free_fn, cancel_fn, poll_fn, wait_fn, greq_class)

$(_doc_external(:PMPIX_Grequest_class_create))
"""
function PMPIX_Grequest_class_create(query_fn, free_fn, cancel_fn, poll_fn, wait_fn, greq_class)
    @mpichk ccall((:PMPIX_Grequest_class_create, libmpi), Cint, (MPIPtr, MPIPtr, MPIPtr, MPIPtr, MPIPtr, Ptr{MPIX_Grequest_class}), query_fn, free_fn, cancel_fn, poll_fn, wait_fn, greq_class)
end

"""
    PMPIX_Grequest_class_allocate(greq_class, extra_state, request)

$(_doc_external(:PMPIX_Grequest_class_allocate))
"""
function PMPIX_Grequest_class_allocate(greq_class, extra_state, request)
    @mpichk ccall((:PMPIX_Grequest_class_allocate, libmpi), Cint, (MPIX_Grequest_class, MPIPtr, Ptr{MPI_Request}), greq_class, extra_state, request)
end

"""
    PMPI_Accumulate(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)

$(_doc_external(:PMPI_Accumulate))
"""
function PMPI_Accumulate(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    @mpichk ccall((:PMPI_Accumulate, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

"""
    PMPI_Accumulate_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)

$(_doc_external(:PMPI_Accumulate_c))
"""
function PMPI_Accumulate_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    @mpichk ccall((:PMPI_Accumulate_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Op, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

"""
    PMPI_Alloc_mem(size, info, baseptr)

$(_doc_external(:PMPI_Alloc_mem))
"""
function PMPI_Alloc_mem(size, info, baseptr)
    @mpichk ccall((:PMPI_Alloc_mem, libmpi), Cint, (MPI_Aint, MPI_Info, MPIPtr), size, info, baseptr)
end

"""
    PMPI_Compare_and_swap(origin_addr, compare_addr, result_addr, datatype, target_rank, target_disp, win)

$(_doc_external(:PMPI_Compare_and_swap))
"""
function PMPI_Compare_and_swap(origin_addr, compare_addr, result_addr, datatype, target_rank, target_disp, win)
    @mpichk ccall((:PMPI_Compare_and_swap, libmpi), Cint, (MPIPtr, MPIPtr, MPIPtr, MPI_Datatype, Cint, MPI_Aint, MPI_Win), origin_addr, compare_addr, result_addr, datatype, target_rank, target_disp, win)
end

"""
    PMPI_Fetch_and_op(origin_addr, result_addr, datatype, target_rank, target_disp, op, win)

$(_doc_external(:PMPI_Fetch_and_op))
"""
function PMPI_Fetch_and_op(origin_addr, result_addr, datatype, target_rank, target_disp, op, win)
    @mpichk ccall((:PMPI_Fetch_and_op, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Datatype, Cint, MPI_Aint, MPI_Op, MPI_Win), origin_addr, result_addr, datatype, target_rank, target_disp, op, win)
end

"""
    PMPI_Free_mem(base)

$(_doc_external(:PMPI_Free_mem))
"""
function PMPI_Free_mem(base)
    @mpichk ccall((:PMPI_Free_mem, libmpi), Cint, (MPIPtr,), base)
end

"""
    PMPI_Get(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)

$(_doc_external(:PMPI_Get))
"""
function PMPI_Get(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    @mpichk ccall((:PMPI_Get, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

"""
    PMPI_Get_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)

$(_doc_external(:PMPI_Get_c))
"""
function PMPI_Get_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    @mpichk ccall((:PMPI_Get_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

"""
    PMPI_Get_accumulate(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)

$(_doc_external(:PMPI_Get_accumulate))
"""
function PMPI_Get_accumulate(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    @mpichk ccall((:PMPI_Get_accumulate, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win), origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

"""
    PMPI_Get_accumulate_c(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)

$(_doc_external(:PMPI_Get_accumulate_c))
"""
function PMPI_Get_accumulate_c(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    @mpichk ccall((:PMPI_Get_accumulate_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Op, MPI_Win), origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

"""
    PMPI_Put(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)

$(_doc_external(:PMPI_Put))
"""
function PMPI_Put(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    @mpichk ccall((:PMPI_Put, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

"""
    PMPI_Put_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)

$(_doc_external(:PMPI_Put_c))
"""
function PMPI_Put_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    @mpichk ccall((:PMPI_Put_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

"""
    PMPI_Raccumulate(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)

$(_doc_external(:PMPI_Raccumulate))
"""
function PMPI_Raccumulate(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    @mpichk ccall((:PMPI_Raccumulate, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

"""
    PMPI_Raccumulate_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)

$(_doc_external(:PMPI_Raccumulate_c))
"""
function PMPI_Raccumulate_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    @mpichk ccall((:PMPI_Raccumulate_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

"""
    PMPI_Rget(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)

$(_doc_external(:PMPI_Rget))
"""
function PMPI_Rget(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    @mpichk ccall((:PMPI_Rget, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

"""
    PMPI_Rget_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)

$(_doc_external(:PMPI_Rget_c))
"""
function PMPI_Rget_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    @mpichk ccall((:PMPI_Rget_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

"""
    PMPI_Rget_accumulate(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)

$(_doc_external(:PMPI_Rget_accumulate))
"""
function PMPI_Rget_accumulate(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    @mpichk ccall((:PMPI_Rget_accumulate, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

"""
    PMPI_Rget_accumulate_c(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)

$(_doc_external(:PMPI_Rget_accumulate_c))
"""
function PMPI_Rget_accumulate_c(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    @mpichk ccall((:PMPI_Rget_accumulate_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

"""
    PMPI_Rput(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)

$(_doc_external(:PMPI_Rput))
"""
function PMPI_Rput(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    @mpichk ccall((:PMPI_Rput, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

"""
    PMPI_Rput_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)

$(_doc_external(:PMPI_Rput_c))
"""
function PMPI_Rput_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    @mpichk ccall((:PMPI_Rput_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

"""
    PMPI_Win_allocate(size, disp_unit, info, comm, baseptr, win)

$(_doc_external(:PMPI_Win_allocate))
"""
function PMPI_Win_allocate(size, disp_unit, info, comm, baseptr, win)
    @mpichk ccall((:PMPI_Win_allocate, libmpi), Cint, (MPI_Aint, Cint, MPI_Info, MPI_Comm, MPIPtr, Ptr{MPI_Win}), size, disp_unit, info, comm, baseptr, win)
end

"""
    PMPI_Win_allocate_c(size, disp_unit, info, comm, baseptr, win)

$(_doc_external(:PMPI_Win_allocate_c))
"""
function PMPI_Win_allocate_c(size, disp_unit, info, comm, baseptr, win)
    @mpichk ccall((:PMPI_Win_allocate_c, libmpi), Cint, (MPI_Aint, MPI_Aint, MPI_Info, MPI_Comm, MPIPtr, Ptr{MPI_Win}), size, disp_unit, info, comm, baseptr, win)
end

"""
    PMPI_Win_allocate_shared(size, disp_unit, info, comm, baseptr, win)

$(_doc_external(:PMPI_Win_allocate_shared))
"""
function PMPI_Win_allocate_shared(size, disp_unit, info, comm, baseptr, win)
    @mpichk ccall((:PMPI_Win_allocate_shared, libmpi), Cint, (MPI_Aint, Cint, MPI_Info, MPI_Comm, MPIPtr, Ptr{MPI_Win}), size, disp_unit, info, comm, baseptr, win)
end

"""
    PMPI_Win_allocate_shared_c(size, disp_unit, info, comm, baseptr, win)

$(_doc_external(:PMPI_Win_allocate_shared_c))
"""
function PMPI_Win_allocate_shared_c(size, disp_unit, info, comm, baseptr, win)
    @mpichk ccall((:PMPI_Win_allocate_shared_c, libmpi), Cint, (MPI_Aint, MPI_Aint, MPI_Info, MPI_Comm, MPIPtr, Ptr{MPI_Win}), size, disp_unit, info, comm, baseptr, win)
end

"""
    PMPI_Win_attach(win, base, size)

$(_doc_external(:PMPI_Win_attach))
"""
function PMPI_Win_attach(win, base, size)
    @mpichk ccall((:PMPI_Win_attach, libmpi), Cint, (MPI_Win, MPIPtr, MPI_Aint), win, base, size)
end

"""
    PMPI_Win_complete(win)

$(_doc_external(:PMPI_Win_complete))
"""
function PMPI_Win_complete(win)
    @mpichk ccall((:PMPI_Win_complete, libmpi), Cint, (MPI_Win,), win)
end

"""
    PMPI_Win_create(base, size, disp_unit, info, comm, win)

$(_doc_external(:PMPI_Win_create))
"""
function PMPI_Win_create(base, size, disp_unit, info, comm, win)
    @mpichk ccall((:PMPI_Win_create, libmpi), Cint, (MPIPtr, MPI_Aint, Cint, MPI_Info, MPI_Comm, Ptr{MPI_Win}), base, size, disp_unit, info, comm, win)
end

"""
    PMPI_Win_create_c(base, size, disp_unit, info, comm, win)

$(_doc_external(:PMPI_Win_create_c))
"""
function PMPI_Win_create_c(base, size, disp_unit, info, comm, win)
    @mpichk ccall((:PMPI_Win_create_c, libmpi), Cint, (MPIPtr, MPI_Aint, MPI_Aint, MPI_Info, MPI_Comm, Ptr{MPI_Win}), base, size, disp_unit, info, comm, win)
end

"""
    PMPI_Win_create_dynamic(info, comm, win)

$(_doc_external(:PMPI_Win_create_dynamic))
"""
function PMPI_Win_create_dynamic(info, comm, win)
    @mpichk ccall((:PMPI_Win_create_dynamic, libmpi), Cint, (MPI_Info, MPI_Comm, Ptr{MPI_Win}), info, comm, win)
end

"""
    PMPI_Win_detach(win, base)

$(_doc_external(:PMPI_Win_detach))
"""
function PMPI_Win_detach(win, base)
    @mpichk ccall((:PMPI_Win_detach, libmpi), Cint, (MPI_Win, MPIPtr), win, base)
end

"""
    PMPI_Win_fence(assert, win)

$(_doc_external(:PMPI_Win_fence))
"""
function PMPI_Win_fence(assert, win)
    @mpichk ccall((:PMPI_Win_fence, libmpi), Cint, (Cint, MPI_Win), assert, win)
end

"""
    PMPI_Win_flush(rank, win)

$(_doc_external(:PMPI_Win_flush))
"""
function PMPI_Win_flush(rank, win)
    @mpichk ccall((:PMPI_Win_flush, libmpi), Cint, (Cint, MPI_Win), rank, win)
end

"""
    PMPI_Win_flush_all(win)

$(_doc_external(:PMPI_Win_flush_all))
"""
function PMPI_Win_flush_all(win)
    @mpichk ccall((:PMPI_Win_flush_all, libmpi), Cint, (MPI_Win,), win)
end

"""
    PMPI_Win_flush_local(rank, win)

$(_doc_external(:PMPI_Win_flush_local))
"""
function PMPI_Win_flush_local(rank, win)
    @mpichk ccall((:PMPI_Win_flush_local, libmpi), Cint, (Cint, MPI_Win), rank, win)
end

"""
    PMPI_Win_flush_local_all(win)

$(_doc_external(:PMPI_Win_flush_local_all))
"""
function PMPI_Win_flush_local_all(win)
    @mpichk ccall((:PMPI_Win_flush_local_all, libmpi), Cint, (MPI_Win,), win)
end

"""
    PMPI_Win_free(win)

$(_doc_external(:PMPI_Win_free))
"""
function PMPI_Win_free(win)
    @mpichk ccall((:PMPI_Win_free, libmpi), Cint, (Ptr{MPI_Win},), win)
end

"""
    PMPI_Win_get_group(win, group)

$(_doc_external(:PMPI_Win_get_group))
"""
function PMPI_Win_get_group(win, group)
    @mpichk ccall((:PMPI_Win_get_group, libmpi), Cint, (MPI_Win, Ptr{MPI_Group}), win, group)
end

"""
    PMPI_Win_get_info(win, info_used)

$(_doc_external(:PMPI_Win_get_info))
"""
function PMPI_Win_get_info(win, info_used)
    @mpichk ccall((:PMPI_Win_get_info, libmpi), Cint, (MPI_Win, Ptr{MPI_Info}), win, info_used)
end

"""
    PMPI_Win_get_name(win, win_name, resultlen)

$(_doc_external(:PMPI_Win_get_name))
"""
function PMPI_Win_get_name(win, win_name, resultlen)
    @mpichk ccall((:PMPI_Win_get_name, libmpi), Cint, (MPI_Win, Ptr{Cchar}, Ptr{Cint}), win, win_name, resultlen)
end

"""
    PMPI_Win_lock(lock_type, rank, assert, win)

$(_doc_external(:PMPI_Win_lock))
"""
function PMPI_Win_lock(lock_type, rank, assert, win)
    @mpichk ccall((:PMPI_Win_lock, libmpi), Cint, (Cint, Cint, Cint, MPI_Win), lock_type, rank, assert, win)
end

"""
    PMPI_Win_lock_all(assert, win)

$(_doc_external(:PMPI_Win_lock_all))
"""
function PMPI_Win_lock_all(assert, win)
    @mpichk ccall((:PMPI_Win_lock_all, libmpi), Cint, (Cint, MPI_Win), assert, win)
end

"""
    PMPI_Win_post(group, assert, win)

$(_doc_external(:PMPI_Win_post))
"""
function PMPI_Win_post(group, assert, win)
    @mpichk ccall((:PMPI_Win_post, libmpi), Cint, (MPI_Group, Cint, MPI_Win), group, assert, win)
end

"""
    PMPI_Win_set_info(win, info)

$(_doc_external(:PMPI_Win_set_info))
"""
function PMPI_Win_set_info(win, info)
    @mpichk ccall((:PMPI_Win_set_info, libmpi), Cint, (MPI_Win, MPI_Info), win, info)
end

"""
    PMPI_Win_set_name(win, win_name)

$(_doc_external(:PMPI_Win_set_name))
"""
function PMPI_Win_set_name(win, win_name)
    @mpichk ccall((:PMPI_Win_set_name, libmpi), Cint, (MPI_Win, Ptr{Cchar}), win, win_name)
end

"""
    PMPI_Win_shared_query(win, rank, size, disp_unit, baseptr)

$(_doc_external(:PMPI_Win_shared_query))
"""
function PMPI_Win_shared_query(win, rank, size, disp_unit, baseptr)
    @mpichk ccall((:PMPI_Win_shared_query, libmpi), Cint, (MPI_Win, Cint, Ptr{MPI_Aint}, Ptr{Cint}, MPIPtr), win, rank, size, disp_unit, baseptr)
end

"""
    PMPI_Win_shared_query_c(win, rank, size, disp_unit, baseptr)

$(_doc_external(:PMPI_Win_shared_query_c))
"""
function PMPI_Win_shared_query_c(win, rank, size, disp_unit, baseptr)
    @mpichk ccall((:PMPI_Win_shared_query_c, libmpi), Cint, (MPI_Win, Cint, Ptr{MPI_Aint}, Ptr{MPI_Aint}, MPIPtr), win, rank, size, disp_unit, baseptr)
end

"""
    PMPI_Win_start(group, assert, win)

$(_doc_external(:PMPI_Win_start))
"""
function PMPI_Win_start(group, assert, win)
    @mpichk ccall((:PMPI_Win_start, libmpi), Cint, (MPI_Group, Cint, MPI_Win), group, assert, win)
end

"""
    PMPI_Win_sync(win)

$(_doc_external(:PMPI_Win_sync))
"""
function PMPI_Win_sync(win)
    @mpichk ccall((:PMPI_Win_sync, libmpi), Cint, (MPI_Win,), win)
end

"""
    PMPI_Win_test(win, flag)

$(_doc_external(:PMPI_Win_test))
"""
function PMPI_Win_test(win, flag)
    @mpichk ccall((:PMPI_Win_test, libmpi), Cint, (MPI_Win, Ptr{Cint}), win, flag)
end

"""
    PMPI_Win_unlock(rank, win)

$(_doc_external(:PMPI_Win_unlock))
"""
function PMPI_Win_unlock(rank, win)
    @mpichk ccall((:PMPI_Win_unlock, libmpi), Cint, (Cint, MPI_Win), rank, win)
end

"""
    PMPI_Win_unlock_all(win)

$(_doc_external(:PMPI_Win_unlock_all))
"""
function PMPI_Win_unlock_all(win)
    @mpichk ccall((:PMPI_Win_unlock_all, libmpi), Cint, (MPI_Win,), win)
end

"""
    PMPI_Win_wait(win)

$(_doc_external(:PMPI_Win_wait))
"""
function PMPI_Win_wait(win)
    @mpichk ccall((:PMPI_Win_wait, libmpi), Cint, (MPI_Win,), win)
end

"""
    PMPI_Close_port(port_name)

$(_doc_external(:PMPI_Close_port))
"""
function PMPI_Close_port(port_name)
    @mpichk ccall((:PMPI_Close_port, libmpi), Cint, (Ptr{Cchar},), port_name)
end

"""
    PMPI_Comm_accept(port_name, info, root, comm, newcomm)

$(_doc_external(:PMPI_Comm_accept))
"""
function PMPI_Comm_accept(port_name, info, root, comm, newcomm)
    @mpichk ccall((:PMPI_Comm_accept, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Cint, MPI_Comm, Ptr{MPI_Comm}), port_name, info, root, comm, newcomm)
end

"""
    PMPI_Comm_connect(port_name, info, root, comm, newcomm)

$(_doc_external(:PMPI_Comm_connect))
"""
function PMPI_Comm_connect(port_name, info, root, comm, newcomm)
    @mpichk ccall((:PMPI_Comm_connect, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Cint, MPI_Comm, Ptr{MPI_Comm}), port_name, info, root, comm, newcomm)
end

"""
    PMPI_Comm_disconnect(comm)

$(_doc_external(:PMPI_Comm_disconnect))
"""
function PMPI_Comm_disconnect(comm)
    @mpichk ccall((:PMPI_Comm_disconnect, libmpi), Cint, (Ptr{MPI_Comm},), comm)
end

"""
    PMPI_Comm_get_parent(parent)

$(_doc_external(:PMPI_Comm_get_parent))
"""
function PMPI_Comm_get_parent(parent)
    @mpichk ccall((:PMPI_Comm_get_parent, libmpi), Cint, (Ptr{MPI_Comm},), parent)
end

"""
    PMPI_Comm_join(fd, intercomm)

$(_doc_external(:PMPI_Comm_join))
"""
function PMPI_Comm_join(fd, intercomm)
    @mpichk ccall((:PMPI_Comm_join, libmpi), Cint, (Cint, Ptr{MPI_Comm}), fd, intercomm)
end

"""
    PMPI_Comm_spawn(command, argv, maxprocs, info, root, comm, intercomm, array_of_errcodes)

$(_doc_external(:PMPI_Comm_spawn))
"""
function PMPI_Comm_spawn(command, argv, maxprocs, info, root, comm, intercomm, array_of_errcodes)
    @mpichk ccall((:PMPI_Comm_spawn, libmpi), Cint, (Ptr{Cchar}, Ptr{Ptr{Cchar}}, Cint, MPI_Info, Cint, MPI_Comm, Ptr{MPI_Comm}, Ptr{Cint}), command, argv, maxprocs, info, root, comm, intercomm, array_of_errcodes)
end

"""
    PMPI_Comm_spawn_multiple(count, array_of_commands, array_of_argv, array_of_maxprocs, array_of_info, root, comm, intercomm, array_of_errcodes)

$(_doc_external(:PMPI_Comm_spawn_multiple))
"""
function PMPI_Comm_spawn_multiple(count, array_of_commands, array_of_argv, array_of_maxprocs, array_of_info, root, comm, intercomm, array_of_errcodes)
    @mpichk ccall((:PMPI_Comm_spawn_multiple, libmpi), Cint, (Cint, Ptr{Ptr{Cchar}}, Ptr{Ptr{Ptr{Cchar}}}, Ptr{Cint}, Ptr{MPI_Info}, Cint, MPI_Comm, Ptr{MPI_Comm}, Ptr{Cint}), count, array_of_commands, array_of_argv, array_of_maxprocs, array_of_info, root, comm, intercomm, array_of_errcodes)
end

"""
    PMPI_Lookup_name(service_name, info, port_name)

$(_doc_external(:PMPI_Lookup_name))
"""
function PMPI_Lookup_name(service_name, info, port_name)
    @mpichk ccall((:PMPI_Lookup_name, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Ptr{Cchar}), service_name, info, port_name)
end

"""
    PMPI_Open_port(info, port_name)

$(_doc_external(:PMPI_Open_port))
"""
function PMPI_Open_port(info, port_name)
    @mpichk ccall((:PMPI_Open_port, libmpi), Cint, (MPI_Info, Ptr{Cchar}), info, port_name)
end

"""
    PMPI_Publish_name(service_name, info, port_name)

$(_doc_external(:PMPI_Publish_name))
"""
function PMPI_Publish_name(service_name, info, port_name)
    @mpichk ccall((:PMPI_Publish_name, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Ptr{Cchar}), service_name, info, port_name)
end

"""
    PMPI_Unpublish_name(service_name, info, port_name)

$(_doc_external(:PMPI_Unpublish_name))
"""
function PMPI_Unpublish_name(service_name, info, port_name)
    @mpichk ccall((:PMPI_Unpublish_name, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Ptr{Cchar}), service_name, info, port_name)
end

"""
    PMPI_Wtick()

$(_doc_external(:PMPI_Wtick))
"""
function PMPI_Wtick()
    @mpichk ccall((:PMPI_Wtick, libmpi), Cdouble, ())
end

"""
    PMPI_Wtime()

$(_doc_external(:PMPI_Wtime))
"""
function PMPI_Wtime()
    @mpichk ccall((:PMPI_Wtime, libmpi), Cdouble, ())
end

"""
    PMPI_Cart_coords(comm, rank, maxdims, coords)

$(_doc_external(:PMPI_Cart_coords))
"""
function PMPI_Cart_coords(comm, rank, maxdims, coords)
    @mpichk ccall((:PMPI_Cart_coords, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{Cint}), comm, rank, maxdims, coords)
end

"""
    PMPI_Cart_create(comm_old, ndims, dims, periods, reorder, comm_cart)

$(_doc_external(:PMPI_Cart_create))
"""
function PMPI_Cart_create(comm_old, ndims, dims, periods, reorder, comm_cart)
    @mpichk ccall((:PMPI_Cart_create, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{MPI_Comm}), comm_old, ndims, dims, periods, reorder, comm_cart)
end

"""
    PMPI_Cart_get(comm, maxdims, dims, periods, coords)

$(_doc_external(:PMPI_Cart_get))
"""
function PMPI_Cart_get(comm, maxdims, dims, periods, coords)
    @mpichk ccall((:PMPI_Cart_get, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), comm, maxdims, dims, periods, coords)
end

"""
    PMPI_Cart_map(comm, ndims, dims, periods, newrank)

$(_doc_external(:PMPI_Cart_map))
"""
function PMPI_Cart_map(comm, ndims, dims, periods, newrank)
    @mpichk ccall((:PMPI_Cart_map, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), comm, ndims, dims, periods, newrank)
end

"""
    PMPI_Cart_rank(comm, coords, rank)

$(_doc_external(:PMPI_Cart_rank))
"""
function PMPI_Cart_rank(comm, coords, rank)
    @mpichk ccall((:PMPI_Cart_rank, libmpi), Cint, (MPI_Comm, Ptr{Cint}, Ptr{Cint}), comm, coords, rank)
end

"""
    PMPI_Cart_shift(comm, direction, disp, rank_source, rank_dest)

$(_doc_external(:PMPI_Cart_shift))
"""
function PMPI_Cart_shift(comm, direction, disp, rank_source, rank_dest)
    @mpichk ccall((:PMPI_Cart_shift, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{Cint}, Ptr{Cint}), comm, direction, disp, rank_source, rank_dest)
end

"""
    PMPI_Cart_sub(comm, remain_dims, newcomm)

$(_doc_external(:PMPI_Cart_sub))
"""
function PMPI_Cart_sub(comm, remain_dims, newcomm)
    @mpichk ccall((:PMPI_Cart_sub, libmpi), Cint, (MPI_Comm, Ptr{Cint}, Ptr{MPI_Comm}), comm, remain_dims, newcomm)
end

"""
    PMPI_Cartdim_get(comm, ndims)

$(_doc_external(:PMPI_Cartdim_get))
"""
function PMPI_Cartdim_get(comm, ndims)
    @mpichk ccall((:PMPI_Cartdim_get, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, ndims)
end

"""
    PMPI_Dims_create(nnodes, ndims, dims)

$(_doc_external(:PMPI_Dims_create))
"""
function PMPI_Dims_create(nnodes, ndims, dims)
    @mpichk ccall((:PMPI_Dims_create, libmpi), Cint, (Cint, Cint, Ptr{Cint}), nnodes, ndims, dims)
end

"""
    PMPI_Dist_graph_create(comm_old, n, sources, degrees, destinations, weights, info, reorder, comm_dist_graph)

$(_doc_external(:PMPI_Dist_graph_create))
"""
function PMPI_Dist_graph_create(comm_old, n, sources, degrees, destinations, weights, info, reorder, comm_dist_graph)
    @mpichk ccall((:PMPI_Dist_graph_create, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, MPI_Info, Cint, Ptr{MPI_Comm}), comm_old, n, sources, degrees, destinations, weights, info, reorder, comm_dist_graph)
end

"""
    PMPI_Dist_graph_create_adjacent(comm_old, indegree, sources, sourceweights, outdegree, destinations, destweights, info, reorder, comm_dist_graph)

$(_doc_external(:PMPI_Dist_graph_create_adjacent))
"""
function PMPI_Dist_graph_create_adjacent(comm_old, indegree, sources, sourceweights, outdegree, destinations, destweights, info, reorder, comm_dist_graph)
    @mpichk ccall((:PMPI_Dist_graph_create_adjacent, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{Cint}, Ptr{Cint}, MPI_Info, Cint, Ptr{MPI_Comm}), comm_old, indegree, sources, sourceweights, outdegree, destinations, destweights, info, reorder, comm_dist_graph)
end

"""
    PMPI_Dist_graph_neighbors(comm, maxindegree, sources, sourceweights, maxoutdegree, destinations, destweights)

$(_doc_external(:PMPI_Dist_graph_neighbors))
"""
function PMPI_Dist_graph_neighbors(comm, maxindegree, sources, sourceweights, maxoutdegree, destinations, destweights)
    @mpichk ccall((:PMPI_Dist_graph_neighbors, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{Cint}, Ptr{Cint}), comm, maxindegree, sources, sourceweights, maxoutdegree, destinations, destweights)
end

"""
    PMPI_Dist_graph_neighbors_count(comm, indegree, outdegree, weighted)

$(_doc_external(:PMPI_Dist_graph_neighbors_count))
"""
function PMPI_Dist_graph_neighbors_count(comm, indegree, outdegree, weighted)
    @mpichk ccall((:PMPI_Dist_graph_neighbors_count, libmpi), Cint, (MPI_Comm, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), comm, indegree, outdegree, weighted)
end

"""
    PMPI_Graph_create(comm_old, nnodes, indx, edges, reorder, comm_graph)

$(_doc_external(:PMPI_Graph_create))
"""
function PMPI_Graph_create(comm_old, nnodes, indx, edges, reorder, comm_graph)
    @mpichk ccall((:PMPI_Graph_create, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{MPI_Comm}), comm_old, nnodes, indx, edges, reorder, comm_graph)
end

"""
    PMPI_Graph_get(comm, maxindex, maxedges, indx, edges)

$(_doc_external(:PMPI_Graph_get))
"""
function PMPI_Graph_get(comm, maxindex, maxedges, indx, edges)
    @mpichk ccall((:PMPI_Graph_get, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{Cint}, Ptr{Cint}), comm, maxindex, maxedges, indx, edges)
end

"""
    PMPI_Graph_map(comm, nnodes, indx, edges, newrank)

$(_doc_external(:PMPI_Graph_map))
"""
function PMPI_Graph_map(comm, nnodes, indx, edges, newrank)
    @mpichk ccall((:PMPI_Graph_map, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), comm, nnodes, indx, edges, newrank)
end

"""
    PMPI_Graph_neighbors(comm, rank, maxneighbors, neighbors)

$(_doc_external(:PMPI_Graph_neighbors))
"""
function PMPI_Graph_neighbors(comm, rank, maxneighbors, neighbors)
    @mpichk ccall((:PMPI_Graph_neighbors, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{Cint}), comm, rank, maxneighbors, neighbors)
end

"""
    PMPI_Graph_neighbors_count(comm, rank, nneighbors)

$(_doc_external(:PMPI_Graph_neighbors_count))
"""
function PMPI_Graph_neighbors_count(comm, rank, nneighbors)
    @mpichk ccall((:PMPI_Graph_neighbors_count, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}), comm, rank, nneighbors)
end

"""
    PMPI_Graphdims_get(comm, nnodes, nedges)

$(_doc_external(:PMPI_Graphdims_get))
"""
function PMPI_Graphdims_get(comm, nnodes, nedges)
    @mpichk ccall((:PMPI_Graphdims_get, libmpi), Cint, (MPI_Comm, Ptr{Cint}, Ptr{Cint}), comm, nnodes, nedges)
end

"""
    PMPI_Topo_test(comm, status)

$(_doc_external(:PMPI_Topo_test))
"""
function PMPI_Topo_test(comm, status)
    @mpichk ccall((:PMPI_Topo_test, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, status)
end

"""
    QMPI_Attr_delete(context, tool_id, comm, keyval)

$(_doc_external(:QMPI_Attr_delete))
"""
function QMPI_Attr_delete(context, tool_id, comm, keyval)
    @mpichk ccall((:QMPI_Attr_delete, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint), context, tool_id, comm, keyval)
end

"""
    QMPI_Attr_get(context, tool_id, comm, keyval, attribute_val, flag)

$(_doc_external(:QMPI_Attr_get))
"""
function QMPI_Attr_get(context, tool_id, comm, keyval, attribute_val, flag)
    @mpichk ccall((:QMPI_Attr_get, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, MPIPtr, Ptr{Cint}), context, tool_id, comm, keyval, attribute_val, flag)
end

"""
    QMPI_Attr_put(context, tool_id, comm, keyval, attribute_val)

$(_doc_external(:QMPI_Attr_put))
"""
function QMPI_Attr_put(context, tool_id, comm, keyval, attribute_val)
    @mpichk ccall((:QMPI_Attr_put, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, MPIPtr), context, tool_id, comm, keyval, attribute_val)
end

"""
    QMPI_Comm_create_keyval(context, tool_id, comm_copy_attr_fn, comm_delete_attr_fn, comm_keyval, extra_state)

$(_doc_external(:QMPI_Comm_create_keyval))
"""
function QMPI_Comm_create_keyval(context, tool_id, comm_copy_attr_fn, comm_delete_attr_fn, comm_keyval, extra_state)
    @mpichk ccall((:QMPI_Comm_create_keyval, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, Ptr{Cint}, MPIPtr), context, tool_id, comm_copy_attr_fn, comm_delete_attr_fn, comm_keyval, extra_state)
end

"""
    QMPI_Comm_delete_attr(context, tool_id, comm, comm_keyval)

$(_doc_external(:QMPI_Comm_delete_attr))
"""
function QMPI_Comm_delete_attr(context, tool_id, comm, comm_keyval)
    @mpichk ccall((:QMPI_Comm_delete_attr, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint), context, tool_id, comm, comm_keyval)
end

"""
    QMPI_Comm_free_keyval(context, tool_id, comm_keyval)

$(_doc_external(:QMPI_Comm_free_keyval))
"""
function QMPI_Comm_free_keyval(context, tool_id, comm_keyval)
    @mpichk ccall((:QMPI_Comm_free_keyval, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, comm_keyval)
end

"""
    QMPI_Comm_get_attr(context, tool_id, comm, comm_keyval, attribute_val, flag)

$(_doc_external(:QMPI_Comm_get_attr))
"""
function QMPI_Comm_get_attr(context, tool_id, comm, comm_keyval, attribute_val, flag)
    @mpichk ccall((:QMPI_Comm_get_attr, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, MPIPtr, Ptr{Cint}), context, tool_id, comm, comm_keyval, attribute_val, flag)
end

"""
    QMPI_Comm_set_attr(context, tool_id, comm, comm_keyval, attribute_val)

$(_doc_external(:QMPI_Comm_set_attr))
"""
function QMPI_Comm_set_attr(context, tool_id, comm, comm_keyval, attribute_val)
    @mpichk ccall((:QMPI_Comm_set_attr, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, MPIPtr), context, tool_id, comm, comm_keyval, attribute_val)
end

"""
    QMPI_Keyval_create(context, tool_id, copy_fn, delete_fn, keyval, extra_state)

$(_doc_external(:QMPI_Keyval_create))
"""
function QMPI_Keyval_create(context, tool_id, copy_fn, delete_fn, keyval, extra_state)
    @mpichk ccall((:QMPI_Keyval_create, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, Ptr{Cint}, MPIPtr), context, tool_id, copy_fn, delete_fn, keyval, extra_state)
end

"""
    QMPI_Keyval_free(context, tool_id, keyval)

$(_doc_external(:QMPI_Keyval_free))
"""
function QMPI_Keyval_free(context, tool_id, keyval)
    @mpichk ccall((:QMPI_Keyval_free, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, keyval)
end

"""
    QMPI_Type_create_keyval(context, tool_id, type_copy_attr_fn, type_delete_attr_fn, type_keyval, extra_state)

$(_doc_external(:QMPI_Type_create_keyval))
"""
function QMPI_Type_create_keyval(context, tool_id, type_copy_attr_fn, type_delete_attr_fn, type_keyval, extra_state)
    @mpichk ccall((:QMPI_Type_create_keyval, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, Ptr{Cint}, MPIPtr), context, tool_id, type_copy_attr_fn, type_delete_attr_fn, type_keyval, extra_state)
end

"""
    QMPI_Type_delete_attr(context, tool_id, datatype, type_keyval)

$(_doc_external(:QMPI_Type_delete_attr))
"""
function QMPI_Type_delete_attr(context, tool_id, datatype, type_keyval)
    @mpichk ccall((:QMPI_Type_delete_attr, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Cint), context, tool_id, datatype, type_keyval)
end

"""
    QMPI_Type_free_keyval(context, tool_id, type_keyval)

$(_doc_external(:QMPI_Type_free_keyval))
"""
function QMPI_Type_free_keyval(context, tool_id, type_keyval)
    @mpichk ccall((:QMPI_Type_free_keyval, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, type_keyval)
end

"""
    QMPI_Type_get_attr(context, tool_id, datatype, type_keyval, attribute_val, flag)

$(_doc_external(:QMPI_Type_get_attr))
"""
function QMPI_Type_get_attr(context, tool_id, datatype, type_keyval, attribute_val, flag)
    @mpichk ccall((:QMPI_Type_get_attr, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Cint, MPIPtr, Ptr{Cint}), context, tool_id, datatype, type_keyval, attribute_val, flag)
end

"""
    QMPI_Type_set_attr(context, tool_id, datatype, type_keyval, attribute_val)

$(_doc_external(:QMPI_Type_set_attr))
"""
function QMPI_Type_set_attr(context, tool_id, datatype, type_keyval, attribute_val)
    @mpichk ccall((:QMPI_Type_set_attr, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Cint, MPIPtr), context, tool_id, datatype, type_keyval, attribute_val)
end

"""
    QMPI_Win_create_keyval(context, tool_id, win_copy_attr_fn, win_delete_attr_fn, win_keyval, extra_state)

$(_doc_external(:QMPI_Win_create_keyval))
"""
function QMPI_Win_create_keyval(context, tool_id, win_copy_attr_fn, win_delete_attr_fn, win_keyval, extra_state)
    @mpichk ccall((:QMPI_Win_create_keyval, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, Ptr{Cint}, MPIPtr), context, tool_id, win_copy_attr_fn, win_delete_attr_fn, win_keyval, extra_state)
end

"""
    QMPI_Win_delete_attr(context, tool_id, win, win_keyval)

$(_doc_external(:QMPI_Win_delete_attr))
"""
function QMPI_Win_delete_attr(context, tool_id, win, win_keyval)
    @mpichk ccall((:QMPI_Win_delete_attr, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, Cint), context, tool_id, win, win_keyval)
end

"""
    QMPI_Win_free_keyval(context, tool_id, win_keyval)

$(_doc_external(:QMPI_Win_free_keyval))
"""
function QMPI_Win_free_keyval(context, tool_id, win_keyval)
    @mpichk ccall((:QMPI_Win_free_keyval, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, win_keyval)
end

"""
    QMPI_Win_get_attr(context, tool_id, win, win_keyval, attribute_val, flag)

$(_doc_external(:QMPI_Win_get_attr))
"""
function QMPI_Win_get_attr(context, tool_id, win, win_keyval, attribute_val, flag)
    @mpichk ccall((:QMPI_Win_get_attr, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, Cint, MPIPtr, Ptr{Cint}), context, tool_id, win, win_keyval, attribute_val, flag)
end

"""
    QMPI_Win_set_attr(context, tool_id, win, win_keyval, attribute_val)

$(_doc_external(:QMPI_Win_set_attr))
"""
function QMPI_Win_set_attr(context, tool_id, win, win_keyval, attribute_val)
    @mpichk ccall((:QMPI_Win_set_attr, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, Cint, MPIPtr), context, tool_id, win, win_keyval, attribute_val)
end

"""
    QMPI_Allgather(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:QMPI_Allgather))
"""
function QMPI_Allgather(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:QMPI_Allgather, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

"""
    QMPI_Allgather_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:QMPI_Allgather_c))
"""
function QMPI_Allgather_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:QMPI_Allgather_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

"""
    QMPI_Allgather_init(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:QMPI_Allgather_init))
"""
function QMPI_Allgather_init(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:QMPI_Allgather_init, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    QMPI_Allgather_init_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:QMPI_Allgather_init_c))
"""
function QMPI_Allgather_init_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:QMPI_Allgather_init_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    QMPI_Allgatherv(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)

$(_doc_external(:QMPI_Allgatherv))
"""
function QMPI_Allgatherv(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    @mpichk ccall((:QMPI_Allgatherv, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

"""
    QMPI_Allgatherv_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)

$(_doc_external(:QMPI_Allgatherv_c))
"""
function QMPI_Allgatherv_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    @mpichk ccall((:QMPI_Allgatherv_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

"""
    QMPI_Allgatherv_init(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)

$(_doc_external(:QMPI_Allgatherv_init))
"""
function QMPI_Allgatherv_init(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    @mpichk ccall((:QMPI_Allgatherv_init, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
end

"""
    QMPI_Allgatherv_init_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)

$(_doc_external(:QMPI_Allgatherv_init_c))
"""
function QMPI_Allgatherv_init_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    @mpichk ccall((:QMPI_Allgatherv_init_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
end

"""
    QMPI_Allreduce(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)

$(_doc_external(:QMPI_Allreduce))
"""
function QMPI_Allreduce(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk ccall((:QMPI_Allreduce, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)
end

"""
    QMPI_Allreduce_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)

$(_doc_external(:QMPI_Allreduce_c))
"""
function QMPI_Allreduce_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk ccall((:QMPI_Allreduce_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)
end

"""
    QMPI_Allreduce_init(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)

$(_doc_external(:QMPI_Allreduce_init))
"""
function QMPI_Allreduce_init(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk ccall((:QMPI_Allreduce_init, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

"""
    QMPI_Allreduce_init_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)

$(_doc_external(:QMPI_Allreduce_init_c))
"""
function QMPI_Allreduce_init_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk ccall((:QMPI_Allreduce_init_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

"""
    QMPI_Alltoall(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:QMPI_Alltoall))
"""
function QMPI_Alltoall(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:QMPI_Alltoall, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

"""
    QMPI_Alltoall_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:QMPI_Alltoall_c))
"""
function QMPI_Alltoall_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:QMPI_Alltoall_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

"""
    QMPI_Alltoall_init(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:QMPI_Alltoall_init))
"""
function QMPI_Alltoall_init(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:QMPI_Alltoall_init, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    QMPI_Alltoall_init_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:QMPI_Alltoall_init_c))
"""
function QMPI_Alltoall_init_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:QMPI_Alltoall_init_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    QMPI_Alltoallv(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)

$(_doc_external(:QMPI_Alltoallv))
"""
function QMPI_Alltoallv(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    @mpichk ccall((:QMPI_Alltoallv, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

"""
    QMPI_Alltoallv_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)

$(_doc_external(:QMPI_Alltoallv_c))
"""
function QMPI_Alltoallv_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    @mpichk ccall((:QMPI_Alltoallv_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

"""
    QMPI_Alltoallv_init(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)

$(_doc_external(:QMPI_Alltoallv_init))
"""
function QMPI_Alltoallv_init(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    @mpichk ccall((:QMPI_Alltoallv_init, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
end

"""
    QMPI_Alltoallv_init_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)

$(_doc_external(:QMPI_Alltoallv_init_c))
"""
function QMPI_Alltoallv_init_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    @mpichk ccall((:QMPI_Alltoallv_init_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
end

"""
    QMPI_Alltoallw(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)

$(_doc_external(:QMPI_Alltoallw))
"""
function QMPI_Alltoallw(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    @mpichk ccall((:QMPI_Alltoallw, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPI_Comm), context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

"""
    QMPI_Alltoallw_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)

$(_doc_external(:QMPI_Alltoallw_c))
"""
function QMPI_Alltoallw_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    @mpichk ccall((:QMPI_Alltoallw_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm), context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

"""
    QMPI_Alltoallw_init(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)

$(_doc_external(:QMPI_Alltoallw_init))
"""
function QMPI_Alltoallw_init(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    @mpichk ccall((:QMPI_Alltoallw_init, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
end

"""
    QMPI_Alltoallw_init_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)

$(_doc_external(:QMPI_Alltoallw_init_c))
"""
function QMPI_Alltoallw_init_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    @mpichk ccall((:QMPI_Alltoallw_init_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
end

"""
    QMPI_Barrier(context, tool_id, comm)

$(_doc_external(:QMPI_Barrier))
"""
function QMPI_Barrier(context, tool_id, comm)
    @mpichk ccall((:QMPI_Barrier, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm), context, tool_id, comm)
end

"""
    QMPI_Barrier_init(context, tool_id, comm, info, request)

$(_doc_external(:QMPI_Barrier_init))
"""
function QMPI_Barrier_init(context, tool_id, comm, info, request)
    @mpichk ccall((:QMPI_Barrier_init, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, comm, info, request)
end

"""
    QMPI_Bcast(context, tool_id, buffer, count, datatype, root, comm)

$(_doc_external(:QMPI_Bcast))
"""
function QMPI_Bcast(context, tool_id, buffer, count, datatype, root, comm)
    @mpichk ccall((:QMPI_Bcast, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm), context, tool_id, buffer, count, datatype, root, comm)
end

"""
    QMPI_Bcast_c(context, tool_id, buffer, count, datatype, root, comm)

$(_doc_external(:QMPI_Bcast_c))
"""
function QMPI_Bcast_c(context, tool_id, buffer, count, datatype, root, comm)
    @mpichk ccall((:QMPI_Bcast_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm), context, tool_id, buffer, count, datatype, root, comm)
end

"""
    QMPI_Bcast_init(context, tool_id, buffer, count, datatype, root, comm, info, request)

$(_doc_external(:QMPI_Bcast_init))
"""
function QMPI_Bcast_init(context, tool_id, buffer, count, datatype, root, comm, info, request)
    @mpichk ccall((:QMPI_Bcast_init, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, buffer, count, datatype, root, comm, info, request)
end

"""
    QMPI_Bcast_init_c(context, tool_id, buffer, count, datatype, root, comm, info, request)

$(_doc_external(:QMPI_Bcast_init_c))
"""
function QMPI_Bcast_init_c(context, tool_id, buffer, count, datatype, root, comm, info, request)
    @mpichk ccall((:QMPI_Bcast_init_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, buffer, count, datatype, root, comm, info, request)
end

"""
    QMPI_Exscan(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)

$(_doc_external(:QMPI_Exscan))
"""
function QMPI_Exscan(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk ccall((:QMPI_Exscan, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)
end

"""
    QMPI_Exscan_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)

$(_doc_external(:QMPI_Exscan_c))
"""
function QMPI_Exscan_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk ccall((:QMPI_Exscan_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)
end

"""
    QMPI_Exscan_init(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)

$(_doc_external(:QMPI_Exscan_init))
"""
function QMPI_Exscan_init(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk ccall((:QMPI_Exscan_init, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

"""
    QMPI_Exscan_init_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)

$(_doc_external(:QMPI_Exscan_init_c))
"""
function QMPI_Exscan_init_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk ccall((:QMPI_Exscan_init_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

"""
    QMPI_Gather(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)

$(_doc_external(:QMPI_Gather))
"""
function QMPI_Gather(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk ccall((:QMPI_Gather, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

"""
    QMPI_Gather_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)

$(_doc_external(:QMPI_Gather_c))
"""
function QMPI_Gather_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk ccall((:QMPI_Gather_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

"""
    QMPI_Gather_init(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

$(_doc_external(:QMPI_Gather_init))
"""
function QMPI_Gather_init(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk ccall((:QMPI_Gather_init, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

"""
    QMPI_Gather_init_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

$(_doc_external(:QMPI_Gather_init_c))
"""
function QMPI_Gather_init_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk ccall((:QMPI_Gather_init_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

"""
    QMPI_Gatherv(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)

$(_doc_external(:QMPI_Gatherv))
"""
function QMPI_Gatherv(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
    @mpichk ccall((:QMPI_Gatherv, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
end

"""
    QMPI_Gatherv_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)

$(_doc_external(:QMPI_Gatherv_c))
"""
function QMPI_Gatherv_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
    @mpichk ccall((:QMPI_Gatherv_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Cint, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
end

"""
    QMPI_Gatherv_init(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)

$(_doc_external(:QMPI_Gatherv_init))
"""
function QMPI_Gatherv_init(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
    @mpichk ccall((:QMPI_Gatherv_init, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
end

"""
    QMPI_Gatherv_init_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)

$(_doc_external(:QMPI_Gatherv_init_c))
"""
function QMPI_Gatherv_init_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
    @mpichk ccall((:QMPI_Gatherv_init_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
end

"""
    QMPI_Iallgather(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:QMPI_Iallgather))
"""
function QMPI_Iallgather(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:QMPI_Iallgather, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    QMPI_Iallgather_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:QMPI_Iallgather_c))
"""
function QMPI_Iallgather_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:QMPI_Iallgather_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    QMPI_Iallgatherv(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)

$(_doc_external(:QMPI_Iallgatherv))
"""
function QMPI_Iallgatherv(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    @mpichk ccall((:QMPI_Iallgatherv, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

"""
    QMPI_Iallgatherv_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)

$(_doc_external(:QMPI_Iallgatherv_c))
"""
function QMPI_Iallgatherv_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    @mpichk ccall((:QMPI_Iallgatherv_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

"""
    QMPI_Iallreduce(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)

$(_doc_external(:QMPI_Iallreduce))
"""
function QMPI_Iallreduce(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk ccall((:QMPI_Iallreduce, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)
end

"""
    QMPI_Iallreduce_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)

$(_doc_external(:QMPI_Iallreduce_c))
"""
function QMPI_Iallreduce_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk ccall((:QMPI_Iallreduce_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)
end

"""
    QMPI_Ialltoall(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:QMPI_Ialltoall))
"""
function QMPI_Ialltoall(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:QMPI_Ialltoall, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    QMPI_Ialltoall_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:QMPI_Ialltoall_c))
"""
function QMPI_Ialltoall_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:QMPI_Ialltoall_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    QMPI_Ialltoallv(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)

$(_doc_external(:QMPI_Ialltoallv))
"""
function QMPI_Ialltoallv(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    @mpichk ccall((:QMPI_Ialltoallv, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

"""
    QMPI_Ialltoallv_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)

$(_doc_external(:QMPI_Ialltoallv_c))
"""
function QMPI_Ialltoallv_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    @mpichk ccall((:QMPI_Ialltoallv_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

"""
    QMPI_Ialltoallw(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)

$(_doc_external(:QMPI_Ialltoallw))
"""
function QMPI_Ialltoallw(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    @mpichk ccall((:QMPI_Ialltoallw, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

"""
    QMPI_Ialltoallw_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)

$(_doc_external(:QMPI_Ialltoallw_c))
"""
function QMPI_Ialltoallw_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    @mpichk ccall((:QMPI_Ialltoallw_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

"""
    QMPI_Ibarrier(context, tool_id, comm, request)

$(_doc_external(:QMPI_Ibarrier))
"""
function QMPI_Ibarrier(context, tool_id, comm, request)
    @mpichk ccall((:QMPI_Ibarrier, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, comm, request)
end

"""
    QMPI_Ibcast(context, tool_id, buffer, count, datatype, root, comm, request)

$(_doc_external(:QMPI_Ibcast))
"""
function QMPI_Ibcast(context, tool_id, buffer, count, datatype, root, comm, request)
    @mpichk ccall((:QMPI_Ibcast, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buffer, count, datatype, root, comm, request)
end

"""
    QMPI_Ibcast_c(context, tool_id, buffer, count, datatype, root, comm, request)

$(_doc_external(:QMPI_Ibcast_c))
"""
function QMPI_Ibcast_c(context, tool_id, buffer, count, datatype, root, comm, request)
    @mpichk ccall((:QMPI_Ibcast_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buffer, count, datatype, root, comm, request)
end

"""
    QMPI_Iexscan(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)

$(_doc_external(:QMPI_Iexscan))
"""
function QMPI_Iexscan(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk ccall((:QMPI_Iexscan, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)
end

"""
    QMPI_Iexscan_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)

$(_doc_external(:QMPI_Iexscan_c))
"""
function QMPI_Iexscan_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk ccall((:QMPI_Iexscan_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)
end

"""
    QMPI_Igather(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

$(_doc_external(:QMPI_Igather))
"""
function QMPI_Igather(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk ccall((:QMPI_Igather, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

"""
    QMPI_Igather_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

$(_doc_external(:QMPI_Igather_c))
"""
function QMPI_Igather_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk ccall((:QMPI_Igather_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

"""
    QMPI_Igatherv(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)

$(_doc_external(:QMPI_Igatherv))
"""
function QMPI_Igatherv(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
    @mpichk ccall((:QMPI_Igatherv, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
end

"""
    QMPI_Igatherv_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)

$(_doc_external(:QMPI_Igatherv_c))
"""
function QMPI_Igatherv_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
    @mpichk ccall((:QMPI_Igatherv_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
end

"""
    QMPI_Ineighbor_allgather(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:QMPI_Ineighbor_allgather))
"""
function QMPI_Ineighbor_allgather(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:QMPI_Ineighbor_allgather, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    QMPI_Ineighbor_allgather_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:QMPI_Ineighbor_allgather_c))
"""
function QMPI_Ineighbor_allgather_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:QMPI_Ineighbor_allgather_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    QMPI_Ineighbor_allgatherv(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)

$(_doc_external(:QMPI_Ineighbor_allgatherv))
"""
function QMPI_Ineighbor_allgatherv(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    @mpichk ccall((:QMPI_Ineighbor_allgatherv, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

"""
    QMPI_Ineighbor_allgatherv_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)

$(_doc_external(:QMPI_Ineighbor_allgatherv_c))
"""
function QMPI_Ineighbor_allgatherv_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    @mpichk ccall((:QMPI_Ineighbor_allgatherv_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

"""
    QMPI_Ineighbor_alltoall(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:QMPI_Ineighbor_alltoall))
"""
function QMPI_Ineighbor_alltoall(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:QMPI_Ineighbor_alltoall, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    QMPI_Ineighbor_alltoall_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:QMPI_Ineighbor_alltoall_c))
"""
function QMPI_Ineighbor_alltoall_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:QMPI_Ineighbor_alltoall_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    QMPI_Ineighbor_alltoallv(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)

$(_doc_external(:QMPI_Ineighbor_alltoallv))
"""
function QMPI_Ineighbor_alltoallv(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    @mpichk ccall((:QMPI_Ineighbor_alltoallv, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

"""
    QMPI_Ineighbor_alltoallv_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)

$(_doc_external(:QMPI_Ineighbor_alltoallv_c))
"""
function QMPI_Ineighbor_alltoallv_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    @mpichk ccall((:QMPI_Ineighbor_alltoallv_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

"""
    QMPI_Ineighbor_alltoallw(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)

$(_doc_external(:QMPI_Ineighbor_alltoallw))
"""
function QMPI_Ineighbor_alltoallw(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    @mpichk ccall((:QMPI_Ineighbor_alltoallw, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

"""
    QMPI_Ineighbor_alltoallw_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)

$(_doc_external(:QMPI_Ineighbor_alltoallw_c))
"""
function QMPI_Ineighbor_alltoallw_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    @mpichk ccall((:QMPI_Ineighbor_alltoallw_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

"""
    QMPI_Ireduce(context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm, request)

$(_doc_external(:QMPI_Ireduce))
"""
function QMPI_Ireduce(context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm, request)
    @mpichk ccall((:QMPI_Ireduce, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm, request)
end

"""
    QMPI_Ireduce_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm, request)

$(_doc_external(:QMPI_Ireduce_c))
"""
function QMPI_Ireduce_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm, request)
    @mpichk ccall((:QMPI_Ireduce_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm, request)
end

"""
    QMPI_Ireduce_scatter(context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm, request)

$(_doc_external(:QMPI_Ireduce_scatter))
"""
function QMPI_Ireduce_scatter(context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
    @mpichk ccall((:QMPI_Ireduce_scatter, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, Ptr{Cint}, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
end

"""
    QMPI_Ireduce_scatter_c(context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm, request)

$(_doc_external(:QMPI_Ireduce_scatter_c))
"""
function QMPI_Ireduce_scatter_c(context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
    @mpichk ccall((:QMPI_Ireduce_scatter_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, Ptr{MPI_Count}, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
end

"""
    QMPI_Ireduce_scatter_block(context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm, request)

$(_doc_external(:QMPI_Ireduce_scatter_block))
"""
function QMPI_Ireduce_scatter_block(context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm, request)
    @mpichk ccall((:QMPI_Ireduce_scatter_block, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm, request)
end

"""
    QMPI_Ireduce_scatter_block_c(context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm, request)

$(_doc_external(:QMPI_Ireduce_scatter_block_c))
"""
function QMPI_Ireduce_scatter_block_c(context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm, request)
    @mpichk ccall((:QMPI_Ireduce_scatter_block_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm, request)
end

"""
    QMPI_Iscan(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)

$(_doc_external(:QMPI_Iscan))
"""
function QMPI_Iscan(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk ccall((:QMPI_Iscan, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)
end

"""
    QMPI_Iscan_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)

$(_doc_external(:QMPI_Iscan_c))
"""
function QMPI_Iscan_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk ccall((:QMPI_Iscan_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, request)
end

"""
    QMPI_Iscatter(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

$(_doc_external(:QMPI_Iscatter))
"""
function QMPI_Iscatter(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk ccall((:QMPI_Iscatter, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

"""
    QMPI_Iscatter_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

$(_doc_external(:QMPI_Iscatter_c))
"""
function QMPI_Iscatter_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk ccall((:QMPI_Iscatter_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

"""
    QMPI_Iscatterv(context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

$(_doc_external(:QMPI_Iscatterv))
"""
function QMPI_Iscatterv(context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk ccall((:QMPI_Iscatterv, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

"""
    QMPI_Iscatterv_c(context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

$(_doc_external(:QMPI_Iscatterv_c))
"""
function QMPI_Iscatterv_c(context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk ccall((:QMPI_Iscatterv_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

"""
    QMPI_Neighbor_allgather(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:QMPI_Neighbor_allgather))
"""
function QMPI_Neighbor_allgather(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:QMPI_Neighbor_allgather, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

"""
    QMPI_Neighbor_allgather_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:QMPI_Neighbor_allgather_c))
"""
function QMPI_Neighbor_allgather_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:QMPI_Neighbor_allgather_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

"""
    QMPI_Neighbor_allgather_init(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:QMPI_Neighbor_allgather_init))
"""
function QMPI_Neighbor_allgather_init(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:QMPI_Neighbor_allgather_init, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    QMPI_Neighbor_allgather_init_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:QMPI_Neighbor_allgather_init_c))
"""
function QMPI_Neighbor_allgather_init_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:QMPI_Neighbor_allgather_init_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    QMPI_Neighbor_allgatherv(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)

$(_doc_external(:QMPI_Neighbor_allgatherv))
"""
function QMPI_Neighbor_allgatherv(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    @mpichk ccall((:QMPI_Neighbor_allgatherv, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

"""
    QMPI_Neighbor_allgatherv_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)

$(_doc_external(:QMPI_Neighbor_allgatherv_c))
"""
function QMPI_Neighbor_allgatherv_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    @mpichk ccall((:QMPI_Neighbor_allgatherv_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

"""
    QMPI_Neighbor_allgatherv_init(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)

$(_doc_external(:QMPI_Neighbor_allgatherv_init))
"""
function QMPI_Neighbor_allgatherv_init(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    @mpichk ccall((:QMPI_Neighbor_allgatherv_init, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
end

"""
    QMPI_Neighbor_allgatherv_init_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)

$(_doc_external(:QMPI_Neighbor_allgatherv_init_c))
"""
function QMPI_Neighbor_allgatherv_init_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    @mpichk ccall((:QMPI_Neighbor_allgatherv_init_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
end

"""
    QMPI_Neighbor_alltoall(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:QMPI_Neighbor_alltoall))
"""
function QMPI_Neighbor_alltoall(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:QMPI_Neighbor_alltoall, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

"""
    QMPI_Neighbor_alltoall_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:QMPI_Neighbor_alltoall_c))
"""
function QMPI_Neighbor_alltoall_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:QMPI_Neighbor_alltoall_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

"""
    QMPI_Neighbor_alltoall_init(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:QMPI_Neighbor_alltoall_init))
"""
function QMPI_Neighbor_alltoall_init(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:QMPI_Neighbor_alltoall_init, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    QMPI_Neighbor_alltoall_init_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:QMPI_Neighbor_alltoall_init_c))
"""
function QMPI_Neighbor_alltoall_init_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:QMPI_Neighbor_alltoall_init_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    QMPI_Neighbor_alltoallv(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)

$(_doc_external(:QMPI_Neighbor_alltoallv))
"""
function QMPI_Neighbor_alltoallv(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    @mpichk ccall((:QMPI_Neighbor_alltoallv, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

"""
    QMPI_Neighbor_alltoallv_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)

$(_doc_external(:QMPI_Neighbor_alltoallv_c))
"""
function QMPI_Neighbor_alltoallv_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    @mpichk ccall((:QMPI_Neighbor_alltoallv_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm), context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

"""
    QMPI_Neighbor_alltoallv_init(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)

$(_doc_external(:QMPI_Neighbor_alltoallv_init))
"""
function QMPI_Neighbor_alltoallv_init(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    @mpichk ccall((:QMPI_Neighbor_alltoallv_init, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
end

"""
    QMPI_Neighbor_alltoallv_init_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)

$(_doc_external(:QMPI_Neighbor_alltoallv_init_c))
"""
function QMPI_Neighbor_alltoallv_init_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    @mpichk ccall((:QMPI_Neighbor_alltoallv_init_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
end

"""
    QMPI_Neighbor_alltoallw(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)

$(_doc_external(:QMPI_Neighbor_alltoallw))
"""
function QMPI_Neighbor_alltoallw(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    @mpichk ccall((:QMPI_Neighbor_alltoallw, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm), context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

"""
    QMPI_Neighbor_alltoallw_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)

$(_doc_external(:QMPI_Neighbor_alltoallw_c))
"""
function QMPI_Neighbor_alltoallw_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    @mpichk ccall((:QMPI_Neighbor_alltoallw_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm), context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

"""
    QMPI_Neighbor_alltoallw_init(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)

$(_doc_external(:QMPI_Neighbor_alltoallw_init))
"""
function QMPI_Neighbor_alltoallw_init(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    @mpichk ccall((:QMPI_Neighbor_alltoallw_init, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
end

"""
    QMPI_Neighbor_alltoallw_init_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)

$(_doc_external(:QMPI_Neighbor_alltoallw_init_c))
"""
function QMPI_Neighbor_alltoallw_init_c(context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    @mpichk ccall((:QMPI_Neighbor_alltoallw_init_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
end

"""
    QMPI_Reduce(context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm)

$(_doc_external(:QMPI_Reduce))
"""
function QMPI_Reduce(context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm)
    @mpichk ccall((:QMPI_Reduce, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm), context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm)
end

"""
    QMPI_Reduce_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm)

$(_doc_external(:QMPI_Reduce_c))
"""
function QMPI_Reduce_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm)
    @mpichk ccall((:QMPI_Reduce_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, Cint, MPI_Comm), context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm)
end

"""
    QMPI_Reduce_init(context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm, info, request)

$(_doc_external(:QMPI_Reduce_init))
"""
function QMPI_Reduce_init(context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
    @mpichk ccall((:QMPI_Reduce_init, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
end

"""
    QMPI_Reduce_init_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm, info, request)

$(_doc_external(:QMPI_Reduce_init_c))
"""
function QMPI_Reduce_init_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
    @mpichk ccall((:QMPI_Reduce_init_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
end

"""
    QMPI_Reduce_local(context, tool_id, inbuf, inoutbuf, count, datatype, op)

$(_doc_external(:QMPI_Reduce_local))
"""
function QMPI_Reduce_local(context, tool_id, inbuf, inoutbuf, count, datatype, op)
    @mpichk ccall((:QMPI_Reduce_local, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op), context, tool_id, inbuf, inoutbuf, count, datatype, op)
end

"""
    QMPI_Reduce_local_c(context, tool_id, inbuf, inoutbuf, count, datatype, op)

$(_doc_external(:QMPI_Reduce_local_c))
"""
function QMPI_Reduce_local_c(context, tool_id, inbuf, inoutbuf, count, datatype, op)
    @mpichk ccall((:QMPI_Reduce_local_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op), context, tool_id, inbuf, inoutbuf, count, datatype, op)
end

"""
    QMPI_Reduce_scatter(context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm)

$(_doc_external(:QMPI_Reduce_scatter))
"""
function QMPI_Reduce_scatter(context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm)
    @mpichk ccall((:QMPI_Reduce_scatter, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, Ptr{Cint}, MPI_Datatype, MPI_Op, MPI_Comm), context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm)
end

"""
    QMPI_Reduce_scatter_c(context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm)

$(_doc_external(:QMPI_Reduce_scatter_c))
"""
function QMPI_Reduce_scatter_c(context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm)
    @mpichk ccall((:QMPI_Reduce_scatter_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, Ptr{MPI_Count}, MPI_Datatype, MPI_Op, MPI_Comm), context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm)
end

"""
    QMPI_Reduce_scatter_block(context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm)

$(_doc_external(:QMPI_Reduce_scatter_block))
"""
function QMPI_Reduce_scatter_block(context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm)
    @mpichk ccall((:QMPI_Reduce_scatter_block, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm), context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm)
end

"""
    QMPI_Reduce_scatter_block_c(context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm)

$(_doc_external(:QMPI_Reduce_scatter_block_c))
"""
function QMPI_Reduce_scatter_block_c(context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm)
    @mpichk ccall((:QMPI_Reduce_scatter_block_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm), context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm)
end

"""
    QMPI_Reduce_scatter_block_init(context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)

$(_doc_external(:QMPI_Reduce_scatter_block_init))
"""
function QMPI_Reduce_scatter_block_init(context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
    @mpichk ccall((:QMPI_Reduce_scatter_block_init, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
end

"""
    QMPI_Reduce_scatter_block_init_c(context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)

$(_doc_external(:QMPI_Reduce_scatter_block_init_c))
"""
function QMPI_Reduce_scatter_block_init_c(context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
    @mpichk ccall((:QMPI_Reduce_scatter_block_init_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
end

"""
    QMPI_Reduce_scatter_init(context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)

$(_doc_external(:QMPI_Reduce_scatter_init))
"""
function QMPI_Reduce_scatter_init(context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
    @mpichk ccall((:QMPI_Reduce_scatter_init, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, Ptr{Cint}, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
end

"""
    QMPI_Reduce_scatter_init_c(context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)

$(_doc_external(:QMPI_Reduce_scatter_init_c))
"""
function QMPI_Reduce_scatter_init_c(context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
    @mpichk ccall((:QMPI_Reduce_scatter_init_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, Ptr{MPI_Count}, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
end

"""
    QMPI_Scan(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)

$(_doc_external(:QMPI_Scan))
"""
function QMPI_Scan(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk ccall((:QMPI_Scan, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)
end

"""
    QMPI_Scan_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)

$(_doc_external(:QMPI_Scan_c))
"""
function QMPI_Scan_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk ccall((:QMPI_Scan_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm)
end

"""
    QMPI_Scan_init(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)

$(_doc_external(:QMPI_Scan_init))
"""
function QMPI_Scan_init(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk ccall((:QMPI_Scan_init, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

"""
    QMPI_Scan_init_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)

$(_doc_external(:QMPI_Scan_init_c))
"""
function QMPI_Scan_init_c(context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk ccall((:QMPI_Scan_init_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

"""
    QMPI_Scatter(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)

$(_doc_external(:QMPI_Scatter))
"""
function QMPI_Scatter(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk ccall((:QMPI_Scatter, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

"""
    QMPI_Scatter_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)

$(_doc_external(:QMPI_Scatter_c))
"""
function QMPI_Scatter_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk ccall((:QMPI_Scatter_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

"""
    QMPI_Scatter_init(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

$(_doc_external(:QMPI_Scatter_init))
"""
function QMPI_Scatter_init(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk ccall((:QMPI_Scatter_init, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

"""
    QMPI_Scatter_init_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

$(_doc_external(:QMPI_Scatter_init_c))
"""
function QMPI_Scatter_init_c(context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk ccall((:QMPI_Scatter_init_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

"""
    QMPI_Scatterv(context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)

$(_doc_external(:QMPI_Scatterv))
"""
function QMPI_Scatterv(context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk ccall((:QMPI_Scatterv, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm), context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

"""
    QMPI_Scatterv_c(context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)

$(_doc_external(:QMPI_Scatterv_c))
"""
function QMPI_Scatterv_c(context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk ccall((:QMPI_Scatterv_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm), context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

"""
    QMPI_Scatterv_init(context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

$(_doc_external(:QMPI_Scatterv_init))
"""
function QMPI_Scatterv_init(context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk ccall((:QMPI_Scatterv_init, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

"""
    QMPI_Scatterv_init_c(context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

$(_doc_external(:QMPI_Scatterv_init_c))
"""
function QMPI_Scatterv_init_c(context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk ccall((:QMPI_Scatterv_init_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

"""
    QMPI_Comm_compare(context, tool_id, comm1, comm2, result)

$(_doc_external(:QMPI_Comm_compare))
"""
function QMPI_Comm_compare(context, tool_id, comm1, comm2, result)
    @mpichk ccall((:QMPI_Comm_compare, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, MPI_Comm, Ptr{Cint}), context, tool_id, comm1, comm2, result)
end

"""
    QMPI_Comm_create(context, tool_id, comm, group, newcomm)

$(_doc_external(:QMPI_Comm_create))
"""
function QMPI_Comm_create(context, tool_id, comm, group, newcomm)
    @mpichk ccall((:QMPI_Comm_create, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, MPI_Group, Ptr{MPI_Comm}), context, tool_id, comm, group, newcomm)
end

"""
    QMPI_Comm_create_group(context, tool_id, comm, group, tag, newcomm)

$(_doc_external(:QMPI_Comm_create_group))
"""
function QMPI_Comm_create_group(context, tool_id, comm, group, tag, newcomm)
    @mpichk ccall((:QMPI_Comm_create_group, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, MPI_Group, Cint, Ptr{MPI_Comm}), context, tool_id, comm, group, tag, newcomm)
end

"""
    QMPI_Comm_dup(context, tool_id, comm, newcomm)

$(_doc_external(:QMPI_Comm_dup))
"""
function QMPI_Comm_dup(context, tool_id, comm, newcomm)
    @mpichk ccall((:QMPI_Comm_dup, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{MPI_Comm}), context, tool_id, comm, newcomm)
end

"""
    QMPI_Comm_dup_with_info(context, tool_id, comm, info, newcomm)

$(_doc_external(:QMPI_Comm_dup_with_info))
"""
function QMPI_Comm_dup_with_info(context, tool_id, comm, info, newcomm)
    @mpichk ccall((:QMPI_Comm_dup_with_info, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Comm}), context, tool_id, comm, info, newcomm)
end

"""
    QMPI_Comm_free(context, tool_id, comm)

$(_doc_external(:QMPI_Comm_free))
"""
function QMPI_Comm_free(context, tool_id, comm)
    @mpichk ccall((:QMPI_Comm_free, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Comm}), context, tool_id, comm)
end

"""
    QMPI_Comm_get_info(context, tool_id, comm, info_used)

$(_doc_external(:QMPI_Comm_get_info))
"""
function QMPI_Comm_get_info(context, tool_id, comm, info_used)
    @mpichk ccall((:QMPI_Comm_get_info, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{MPI_Info}), context, tool_id, comm, info_used)
end

"""
    QMPI_Comm_get_name(context, tool_id, comm, comm_name, resultlen)

$(_doc_external(:QMPI_Comm_get_name))
"""
function QMPI_Comm_get_name(context, tool_id, comm, comm_name, resultlen)
    @mpichk ccall((:QMPI_Comm_get_name, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{Cchar}, Ptr{Cint}), context, tool_id, comm, comm_name, resultlen)
end

"""
    QMPI_Comm_group(context, tool_id, comm, group)

$(_doc_external(:QMPI_Comm_group))
"""
function QMPI_Comm_group(context, tool_id, comm, group)
    @mpichk ccall((:QMPI_Comm_group, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{MPI_Group}), context, tool_id, comm, group)
end

"""
    QMPI_Comm_idup(context, tool_id, comm, newcomm, request)

$(_doc_external(:QMPI_Comm_idup))
"""
function QMPI_Comm_idup(context, tool_id, comm, newcomm, request)
    @mpichk ccall((:QMPI_Comm_idup, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{MPI_Comm}, Ptr{MPI_Request}), context, tool_id, comm, newcomm, request)
end

"""
    QMPI_Comm_idup_with_info(context, tool_id, comm, info, newcomm, request)

$(_doc_external(:QMPI_Comm_idup_with_info))
"""
function QMPI_Comm_idup_with_info(context, tool_id, comm, info, newcomm, request)
    @mpichk ccall((:QMPI_Comm_idup_with_info, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Comm}, Ptr{MPI_Request}), context, tool_id, comm, info, newcomm, request)
end

"""
    QMPI_Comm_rank(context, tool_id, comm, rank)

$(_doc_external(:QMPI_Comm_rank))
"""
function QMPI_Comm_rank(context, tool_id, comm, rank)
    @mpichk ccall((:QMPI_Comm_rank, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{Cint}), context, tool_id, comm, rank)
end

"""
    QMPI_Comm_remote_group(context, tool_id, comm, group)

$(_doc_external(:QMPI_Comm_remote_group))
"""
function QMPI_Comm_remote_group(context, tool_id, comm, group)
    @mpichk ccall((:QMPI_Comm_remote_group, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{MPI_Group}), context, tool_id, comm, group)
end

"""
    QMPI_Comm_remote_size(context, tool_id, comm, size)

$(_doc_external(:QMPI_Comm_remote_size))
"""
function QMPI_Comm_remote_size(context, tool_id, comm, size)
    @mpichk ccall((:QMPI_Comm_remote_size, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{Cint}), context, tool_id, comm, size)
end

"""
    QMPI_Comm_set_info(context, tool_id, comm, info)

$(_doc_external(:QMPI_Comm_set_info))
"""
function QMPI_Comm_set_info(context, tool_id, comm, info)
    @mpichk ccall((:QMPI_Comm_set_info, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, MPI_Info), context, tool_id, comm, info)
end

"""
    QMPI_Comm_set_name(context, tool_id, comm, comm_name)

$(_doc_external(:QMPI_Comm_set_name))
"""
function QMPI_Comm_set_name(context, tool_id, comm, comm_name)
    @mpichk ccall((:QMPI_Comm_set_name, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{Cchar}), context, tool_id, comm, comm_name)
end

"""
    QMPI_Comm_size(context, tool_id, comm, size)

$(_doc_external(:QMPI_Comm_size))
"""
function QMPI_Comm_size(context, tool_id, comm, size)
    @mpichk ccall((:QMPI_Comm_size, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{Cint}), context, tool_id, comm, size)
end

"""
    QMPI_Comm_split(context, tool_id, comm, color, key, newcomm)

$(_doc_external(:QMPI_Comm_split))
"""
function QMPI_Comm_split(context, tool_id, comm, color, key, newcomm)
    @mpichk ccall((:QMPI_Comm_split, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Cint, Ptr{MPI_Comm}), context, tool_id, comm, color, key, newcomm)
end

"""
    QMPI_Comm_split_type(context, tool_id, comm, split_type, key, info, newcomm)

$(_doc_external(:QMPI_Comm_split_type))
"""
function QMPI_Comm_split_type(context, tool_id, comm, split_type, key, info, newcomm)
    @mpichk ccall((:QMPI_Comm_split_type, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Cint, MPI_Info, Ptr{MPI_Comm}), context, tool_id, comm, split_type, key, info, newcomm)
end

"""
    QMPI_Comm_test_inter(context, tool_id, comm, flag)

$(_doc_external(:QMPI_Comm_test_inter))
"""
function QMPI_Comm_test_inter(context, tool_id, comm, flag)
    @mpichk ccall((:QMPI_Comm_test_inter, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{Cint}), context, tool_id, comm, flag)
end

"""
    QMPI_Intercomm_create(context, tool_id, local_comm, local_leader, peer_comm, remote_leader, tag, newintercomm)

$(_doc_external(:QMPI_Intercomm_create))
"""
function QMPI_Intercomm_create(context, tool_id, local_comm, local_leader, peer_comm, remote_leader, tag, newintercomm)
    @mpichk ccall((:QMPI_Intercomm_create, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, MPI_Comm, Cint, Cint, Ptr{MPI_Comm}), context, tool_id, local_comm, local_leader, peer_comm, remote_leader, tag, newintercomm)
end

"""
    QMPI_Intercomm_create_from_groups(context, tool_id, local_group, local_leader, remote_group, remote_leader, stringtag, info, errhandler, newintercomm)

$(_doc_external(:QMPI_Intercomm_create_from_groups))
"""
function QMPI_Intercomm_create_from_groups(context, tool_id, local_group, local_leader, remote_group, remote_leader, stringtag, info, errhandler, newintercomm)
    @mpichk ccall((:QMPI_Intercomm_create_from_groups, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, Cint, MPI_Group, Cint, Ptr{Cchar}, MPI_Info, MPI_Errhandler, Ptr{MPI_Comm}), context, tool_id, local_group, local_leader, remote_group, remote_leader, stringtag, info, errhandler, newintercomm)
end

"""
    QMPI_Intercomm_merge(context, tool_id, intercomm, high, newintracomm)

$(_doc_external(:QMPI_Intercomm_merge))
"""
function QMPI_Intercomm_merge(context, tool_id, intercomm, high, newintracomm)
    @mpichk ccall((:QMPI_Intercomm_merge, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Ptr{MPI_Comm}), context, tool_id, intercomm, high, newintracomm)
end

"""
    QMPIX_Comm_revoke(context, tool_id, comm)

$(_doc_external(:QMPIX_Comm_revoke))
"""
function QMPIX_Comm_revoke(context, tool_id, comm)
    @mpichk ccall((:QMPIX_Comm_revoke, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm), context, tool_id, comm)
end

"""
    QMPIX_Comm_shrink(context, tool_id, comm, newcomm)

$(_doc_external(:QMPIX_Comm_shrink))
"""
function QMPIX_Comm_shrink(context, tool_id, comm, newcomm)
    @mpichk ccall((:QMPIX_Comm_shrink, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{MPI_Comm}), context, tool_id, comm, newcomm)
end

"""
    QMPIX_Comm_failure_ack(context, tool_id, comm)

$(_doc_external(:QMPIX_Comm_failure_ack))
"""
function QMPIX_Comm_failure_ack(context, tool_id, comm)
    @mpichk ccall((:QMPIX_Comm_failure_ack, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm), context, tool_id, comm)
end

"""
    QMPIX_Comm_failure_get_acked(context, tool_id, comm, failedgrp)

$(_doc_external(:QMPIX_Comm_failure_get_acked))
"""
function QMPIX_Comm_failure_get_acked(context, tool_id, comm, failedgrp)
    @mpichk ccall((:QMPIX_Comm_failure_get_acked, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{MPI_Group}), context, tool_id, comm, failedgrp)
end

"""
    QMPIX_Comm_agree(context, tool_id, comm, flag)

$(_doc_external(:QMPIX_Comm_agree))
"""
function QMPIX_Comm_agree(context, tool_id, comm, flag)
    @mpichk ccall((:QMPIX_Comm_agree, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{Cint}), context, tool_id, comm, flag)
end

"""
    QMPI_Get_address(context, tool_id, location, address)

$(_doc_external(:QMPI_Get_address))
"""
function QMPI_Get_address(context, tool_id, location, address)
    @mpichk ccall((:QMPI_Get_address, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{MPI_Aint}), context, tool_id, location, address)
end

"""
    QMPI_Get_count(context, tool_id, status, datatype, count)

$(_doc_external(:QMPI_Get_count))
"""
function QMPI_Get_count(context, tool_id, status, datatype, count)
    @mpichk ccall((:QMPI_Get_count, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Status}, MPI_Datatype, Ptr{Cint}), context, tool_id, status, datatype, count)
end

"""
    QMPI_Get_count_c(context, tool_id, status, datatype, count)

$(_doc_external(:QMPI_Get_count_c))
"""
function QMPI_Get_count_c(context, tool_id, status, datatype, count)
    @mpichk ccall((:QMPI_Get_count_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Status}, MPI_Datatype, Ptr{MPI_Count}), context, tool_id, status, datatype, count)
end

"""
    QMPI_Get_elements(context, tool_id, status, datatype, count)

$(_doc_external(:QMPI_Get_elements))
"""
function QMPI_Get_elements(context, tool_id, status, datatype, count)
    @mpichk ccall((:QMPI_Get_elements, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Status}, MPI_Datatype, Ptr{Cint}), context, tool_id, status, datatype, count)
end

"""
    QMPI_Get_elements_c(context, tool_id, status, datatype, count)

$(_doc_external(:QMPI_Get_elements_c))
"""
function QMPI_Get_elements_c(context, tool_id, status, datatype, count)
    @mpichk ccall((:QMPI_Get_elements_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Status}, MPI_Datatype, Ptr{MPI_Count}), context, tool_id, status, datatype, count)
end

"""
    QMPI_Get_elements_x(context, tool_id, status, datatype, count)

$(_doc_external(:QMPI_Get_elements_x))
"""
function QMPI_Get_elements_x(context, tool_id, status, datatype, count)
    @mpichk ccall((:QMPI_Get_elements_x, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Status}, MPI_Datatype, Ptr{MPI_Count}), context, tool_id, status, datatype, count)
end

"""
    QMPI_Pack(context, tool_id, inbuf, incount, datatype, outbuf, outsize, position, comm)

$(_doc_external(:QMPI_Pack))
"""
function QMPI_Pack(context, tool_id, inbuf, incount, datatype, outbuf, outsize, position, comm)
    @mpichk ccall((:QMPI_Pack, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, Ptr{Cint}, MPI_Comm), context, tool_id, inbuf, incount, datatype, outbuf, outsize, position, comm)
end

"""
    QMPI_Pack_c(context, tool_id, inbuf, incount, datatype, outbuf, outsize, position, comm)

$(_doc_external(:QMPI_Pack_c))
"""
function QMPI_Pack_c(context, tool_id, inbuf, incount, datatype, outbuf, outsize, position, comm)
    @mpichk ccall((:QMPI_Pack_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, Ptr{MPI_Count}, MPI_Comm), context, tool_id, inbuf, incount, datatype, outbuf, outsize, position, comm)
end

"""
    QMPI_Pack_external(context, tool_id, datarep, inbuf, incount, datatype, outbuf, outsize, position)

$(_doc_external(:QMPI_Pack_external))
"""
function QMPI_Pack_external(context, tool_id, datarep, inbuf, incount, datatype, outbuf, outsize, position)
    @mpichk ccall((:QMPI_Pack_external, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, MPIPtr, Cint, MPI_Datatype, MPIPtr, MPI_Aint, Ptr{MPI_Aint}), context, tool_id, datarep, inbuf, incount, datatype, outbuf, outsize, position)
end

"""
    QMPI_Pack_external_c(context, tool_id, datarep, inbuf, incount, datatype, outbuf, outsize, position)

$(_doc_external(:QMPI_Pack_external_c))
"""
function QMPI_Pack_external_c(context, tool_id, datarep, inbuf, incount, datatype, outbuf, outsize, position)
    @mpichk ccall((:QMPI_Pack_external_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, Ptr{MPI_Count}), context, tool_id, datarep, inbuf, incount, datatype, outbuf, outsize, position)
end

"""
    QMPI_Pack_external_size(context, tool_id, datarep, incount, datatype, size)

$(_doc_external(:QMPI_Pack_external_size))
"""
function QMPI_Pack_external_size(context, tool_id, datarep, incount, datatype, size)
    @mpichk ccall((:QMPI_Pack_external_size, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, Cint, MPI_Datatype, Ptr{MPI_Aint}), context, tool_id, datarep, incount, datatype, size)
end

"""
    QMPI_Pack_external_size_c(context, tool_id, datarep, incount, datatype, size)

$(_doc_external(:QMPI_Pack_external_size_c))
"""
function QMPI_Pack_external_size_c(context, tool_id, datarep, incount, datatype, size)
    @mpichk ccall((:QMPI_Pack_external_size_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, MPI_Count, MPI_Datatype, Ptr{MPI_Count}), context, tool_id, datarep, incount, datatype, size)
end

"""
    QMPI_Pack_size(context, tool_id, incount, datatype, comm, size)

$(_doc_external(:QMPI_Pack_size))
"""
function QMPI_Pack_size(context, tool_id, incount, datatype, comm, size)
    @mpichk ccall((:QMPI_Pack_size, libmpi), Cint, (QMPI_Context, Cint, Cint, MPI_Datatype, MPI_Comm, Ptr{Cint}), context, tool_id, incount, datatype, comm, size)
end

"""
    QMPI_Pack_size_c(context, tool_id, incount, datatype, comm, size)

$(_doc_external(:QMPI_Pack_size_c))
"""
function QMPI_Pack_size_c(context, tool_id, incount, datatype, comm, size)
    @mpichk ccall((:QMPI_Pack_size_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Count}), context, tool_id, incount, datatype, comm, size)
end

"""
    QMPI_Status_set_elements(context, tool_id, status, datatype, count)

$(_doc_external(:QMPI_Status_set_elements))
"""
function QMPI_Status_set_elements(context, tool_id, status, datatype, count)
    @mpichk ccall((:QMPI_Status_set_elements, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Status}, MPI_Datatype, Cint), context, tool_id, status, datatype, count)
end

"""
    QMPI_Status_set_elements_x(context, tool_id, status, datatype, count)

$(_doc_external(:QMPI_Status_set_elements_x))
"""
function QMPI_Status_set_elements_x(context, tool_id, status, datatype, count)
    @mpichk ccall((:QMPI_Status_set_elements_x, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Status}, MPI_Datatype, MPI_Count), context, tool_id, status, datatype, count)
end

"""
    QMPI_Type_commit(context, tool_id, datatype)

$(_doc_external(:QMPI_Type_commit))
"""
function QMPI_Type_commit(context, tool_id, datatype)
    @mpichk ccall((:QMPI_Type_commit, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Datatype}), context, tool_id, datatype)
end

"""
    QMPI_Type_contiguous(context, tool_id, count, oldtype, newtype)

$(_doc_external(:QMPI_Type_contiguous))
"""
function QMPI_Type_contiguous(context, tool_id, count, oldtype, newtype)
    @mpichk ccall((:QMPI_Type_contiguous, libmpi), Cint, (QMPI_Context, Cint, Cint, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, oldtype, newtype)
end

"""
    QMPI_Type_contiguous_c(context, tool_id, count, oldtype, newtype)

$(_doc_external(:QMPI_Type_contiguous_c))
"""
function QMPI_Type_contiguous_c(context, tool_id, count, oldtype, newtype)
    @mpichk ccall((:QMPI_Type_contiguous_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Count, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, oldtype, newtype)
end

"""
    QMPI_Type_create_darray(context, tool_id, size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)

$(_doc_external(:QMPI_Type_create_darray))
"""
function QMPI_Type_create_darray(context, tool_id, size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
    @mpichk ccall((:QMPI_Type_create_darray, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
end

"""
    QMPI_Type_create_darray_c(context, tool_id, size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)

$(_doc_external(:QMPI_Type_create_darray_c))
"""
function QMPI_Type_create_darray_c(context, tool_id, size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
    @mpichk ccall((:QMPI_Type_create_darray_c, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, Cint, Ptr{MPI_Count}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
end

"""
    QMPI_Type_create_hindexed(context, tool_id, count, array_of_blocklengths, array_of_displacements, oldtype, newtype)

$(_doc_external(:QMPI_Type_create_hindexed))
"""
function QMPI_Type_create_hindexed(context, tool_id, count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:QMPI_Type_create_hindexed, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cint}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

"""
    QMPI_Type_create_hindexed_c(context, tool_id, count, array_of_blocklengths, array_of_displacements, oldtype, newtype)

$(_doc_external(:QMPI_Type_create_hindexed_c))
"""
function QMPI_Type_create_hindexed_c(context, tool_id, count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:QMPI_Type_create_hindexed_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Count, Ptr{MPI_Count}, Ptr{MPI_Count}, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

"""
    QMPI_Type_create_hindexed_block(context, tool_id, count, blocklength, array_of_displacements, oldtype, newtype)

$(_doc_external(:QMPI_Type_create_hindexed_block))
"""
function QMPI_Type_create_hindexed_block(context, tool_id, count, blocklength, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:QMPI_Type_create_hindexed_block, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, Ptr{MPI_Aint}, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, blocklength, array_of_displacements, oldtype, newtype)
end

"""
    QMPI_Type_create_hindexed_block_c(context, tool_id, count, blocklength, array_of_displacements, oldtype, newtype)

$(_doc_external(:QMPI_Type_create_hindexed_block_c))
"""
function QMPI_Type_create_hindexed_block_c(context, tool_id, count, blocklength, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:QMPI_Type_create_hindexed_block_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Count, MPI_Count, Ptr{MPI_Count}, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, blocklength, array_of_displacements, oldtype, newtype)
end

"""
    QMPI_Type_create_hvector(context, tool_id, count, blocklength, stride, oldtype, newtype)

$(_doc_external(:QMPI_Type_create_hvector))
"""
function QMPI_Type_create_hvector(context, tool_id, count, blocklength, stride, oldtype, newtype)
    @mpichk ccall((:QMPI_Type_create_hvector, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, MPI_Aint, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, blocklength, stride, oldtype, newtype)
end

"""
    QMPI_Type_create_hvector_c(context, tool_id, count, blocklength, stride, oldtype, newtype)

$(_doc_external(:QMPI_Type_create_hvector_c))
"""
function QMPI_Type_create_hvector_c(context, tool_id, count, blocklength, stride, oldtype, newtype)
    @mpichk ccall((:QMPI_Type_create_hvector_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Count, MPI_Count, MPI_Count, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, blocklength, stride, oldtype, newtype)
end

"""
    QMPI_Type_create_indexed_block(context, tool_id, count, blocklength, array_of_displacements, oldtype, newtype)

$(_doc_external(:QMPI_Type_create_indexed_block))
"""
function QMPI_Type_create_indexed_block(context, tool_id, count, blocklength, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:QMPI_Type_create_indexed_block, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, Ptr{Cint}, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, blocklength, array_of_displacements, oldtype, newtype)
end

"""
    QMPI_Type_create_indexed_block_c(context, tool_id, count, blocklength, array_of_displacements, oldtype, newtype)

$(_doc_external(:QMPI_Type_create_indexed_block_c))
"""
function QMPI_Type_create_indexed_block_c(context, tool_id, count, blocklength, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:QMPI_Type_create_indexed_block_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Count, MPI_Count, Ptr{MPI_Count}, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, blocklength, array_of_displacements, oldtype, newtype)
end

"""
    QMPI_Type_create_resized(context, tool_id, oldtype, lb, extent, newtype)

$(_doc_external(:QMPI_Type_create_resized))
"""
function QMPI_Type_create_resized(context, tool_id, oldtype, lb, extent, newtype)
    @mpichk ccall((:QMPI_Type_create_resized, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, MPI_Aint, MPI_Aint, Ptr{MPI_Datatype}), context, tool_id, oldtype, lb, extent, newtype)
end

"""
    QMPI_Type_create_resized_c(context, tool_id, oldtype, lb, extent, newtype)

$(_doc_external(:QMPI_Type_create_resized_c))
"""
function QMPI_Type_create_resized_c(context, tool_id, oldtype, lb, extent, newtype)
    @mpichk ccall((:QMPI_Type_create_resized_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, MPI_Count, MPI_Count, Ptr{MPI_Datatype}), context, tool_id, oldtype, lb, extent, newtype)
end

"""
    QMPI_Type_create_struct(context, tool_id, count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)

$(_doc_external(:QMPI_Type_create_struct))
"""
function QMPI_Type_create_struct(context, tool_id, count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
    @mpichk ccall((:QMPI_Type_create_struct, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}), context, tool_id, count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
end

"""
    QMPI_Type_create_struct_c(context, tool_id, count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)

$(_doc_external(:QMPI_Type_create_struct_c))
"""
function QMPI_Type_create_struct_c(context, tool_id, count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
    @mpichk ccall((:QMPI_Type_create_struct_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Count, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}), context, tool_id, count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
end

"""
    QMPI_Type_create_subarray(context, tool_id, ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)

$(_doc_external(:QMPI_Type_create_subarray))
"""
function QMPI_Type_create_subarray(context, tool_id, ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
    @mpichk ccall((:QMPI_Type_create_subarray, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
end

"""
    QMPI_Type_create_subarray_c(context, tool_id, ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)

$(_doc_external(:QMPI_Type_create_subarray_c))
"""
function QMPI_Type_create_subarray_c(context, tool_id, ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
    @mpichk ccall((:QMPI_Type_create_subarray_c, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Count}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
end

"""
    QMPI_Type_dup(context, tool_id, oldtype, newtype)

$(_doc_external(:QMPI_Type_dup))
"""
function QMPI_Type_dup(context, tool_id, oldtype, newtype)
    @mpichk ccall((:QMPI_Type_dup, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, oldtype, newtype)
end

"""
    QMPI_Type_free(context, tool_id, datatype)

$(_doc_external(:QMPI_Type_free))
"""
function QMPI_Type_free(context, tool_id, datatype)
    @mpichk ccall((:QMPI_Type_free, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Datatype}), context, tool_id, datatype)
end

"""
    QMPI_Type_get_contents(context, tool_id, datatype, max_integers, max_addresses, max_datatypes, array_of_integers, array_of_addresses, array_of_datatypes)

$(_doc_external(:QMPI_Type_get_contents))
"""
function QMPI_Type_get_contents(context, tool_id, datatype, max_integers, max_addresses, max_datatypes, array_of_integers, array_of_addresses, array_of_datatypes)
    @mpichk ccall((:QMPI_Type_get_contents, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Cint, Cint, Cint, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}), context, tool_id, datatype, max_integers, max_addresses, max_datatypes, array_of_integers, array_of_addresses, array_of_datatypes)
end

"""
    QMPI_Type_get_contents_c(context, tool_id, datatype, max_integers, max_addresses, max_large_counts, max_datatypes, array_of_integers, array_of_addresses, array_of_large_counts, array_of_datatypes)

$(_doc_external(:QMPI_Type_get_contents_c))
"""
function QMPI_Type_get_contents_c(context, tool_id, datatype, max_integers, max_addresses, max_large_counts, max_datatypes, array_of_integers, array_of_addresses, array_of_large_counts, array_of_datatypes)
    @mpichk ccall((:QMPI_Type_get_contents_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, MPI_Count, MPI_Count, MPI_Count, MPI_Count, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Count}, Ptr{MPI_Datatype}), context, tool_id, datatype, max_integers, max_addresses, max_large_counts, max_datatypes, array_of_integers, array_of_addresses, array_of_large_counts, array_of_datatypes)
end

"""
    QMPI_Type_get_envelope(context, tool_id, datatype, num_integers, num_addresses, num_datatypes, combiner)

$(_doc_external(:QMPI_Type_get_envelope))
"""
function QMPI_Type_get_envelope(context, tool_id, datatype, num_integers, num_addresses, num_datatypes, combiner)
    @mpichk ccall((:QMPI_Type_get_envelope, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), context, tool_id, datatype, num_integers, num_addresses, num_datatypes, combiner)
end

"""
    QMPI_Type_get_envelope_c(context, tool_id, datatype, num_integers, num_addresses, num_large_counts, num_datatypes, combiner)

$(_doc_external(:QMPI_Type_get_envelope_c))
"""
function QMPI_Type_get_envelope_c(context, tool_id, datatype, num_integers, num_addresses, num_large_counts, num_datatypes, combiner)
    @mpichk ccall((:QMPI_Type_get_envelope_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{Cint}), context, tool_id, datatype, num_integers, num_addresses, num_large_counts, num_datatypes, combiner)
end

"""
    QMPI_Type_get_extent(context, tool_id, datatype, lb, extent)

$(_doc_external(:QMPI_Type_get_extent))
"""
function QMPI_Type_get_extent(context, tool_id, datatype, lb, extent)
    @mpichk ccall((:QMPI_Type_get_extent, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{MPI_Aint}, Ptr{MPI_Aint}), context, tool_id, datatype, lb, extent)
end

"""
    QMPI_Type_get_extent_c(context, tool_id, datatype, lb, extent)

$(_doc_external(:QMPI_Type_get_extent_c))
"""
function QMPI_Type_get_extent_c(context, tool_id, datatype, lb, extent)
    @mpichk ccall((:QMPI_Type_get_extent_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), context, tool_id, datatype, lb, extent)
end

"""
    QMPI_Type_get_extent_x(context, tool_id, datatype, lb, extent)

$(_doc_external(:QMPI_Type_get_extent_x))
"""
function QMPI_Type_get_extent_x(context, tool_id, datatype, lb, extent)
    @mpichk ccall((:QMPI_Type_get_extent_x, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), context, tool_id, datatype, lb, extent)
end

"""
    QMPI_Type_get_name(context, tool_id, datatype, type_name, resultlen)

$(_doc_external(:QMPI_Type_get_name))
"""
function QMPI_Type_get_name(context, tool_id, datatype, type_name, resultlen)
    @mpichk ccall((:QMPI_Type_get_name, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{Cchar}, Ptr{Cint}), context, tool_id, datatype, type_name, resultlen)
end

"""
    QMPI_Type_get_true_extent(context, tool_id, datatype, true_lb, true_extent)

$(_doc_external(:QMPI_Type_get_true_extent))
"""
function QMPI_Type_get_true_extent(context, tool_id, datatype, true_lb, true_extent)
    @mpichk ccall((:QMPI_Type_get_true_extent, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{MPI_Aint}, Ptr{MPI_Aint}), context, tool_id, datatype, true_lb, true_extent)
end

"""
    QMPI_Type_get_true_extent_c(context, tool_id, datatype, true_lb, true_extent)

$(_doc_external(:QMPI_Type_get_true_extent_c))
"""
function QMPI_Type_get_true_extent_c(context, tool_id, datatype, true_lb, true_extent)
    @mpichk ccall((:QMPI_Type_get_true_extent_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), context, tool_id, datatype, true_lb, true_extent)
end

"""
    QMPI_Type_get_true_extent_x(context, tool_id, datatype, true_lb, true_extent)

$(_doc_external(:QMPI_Type_get_true_extent_x))
"""
function QMPI_Type_get_true_extent_x(context, tool_id, datatype, true_lb, true_extent)
    @mpichk ccall((:QMPI_Type_get_true_extent_x, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), context, tool_id, datatype, true_lb, true_extent)
end

"""
    QMPI_Type_indexed(context, tool_id, count, array_of_blocklengths, array_of_displacements, oldtype, newtype)

$(_doc_external(:QMPI_Type_indexed))
"""
function QMPI_Type_indexed(context, tool_id, count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:QMPI_Type_indexed, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

"""
    QMPI_Type_indexed_c(context, tool_id, count, array_of_blocklengths, array_of_displacements, oldtype, newtype)

$(_doc_external(:QMPI_Type_indexed_c))
"""
function QMPI_Type_indexed_c(context, tool_id, count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:QMPI_Type_indexed_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Count, Ptr{MPI_Count}, Ptr{MPI_Count}, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

"""
    QMPI_Type_match_size(context, tool_id, typeclass, size, datatype)

$(_doc_external(:QMPI_Type_match_size))
"""
function QMPI_Type_match_size(context, tool_id, typeclass, size, datatype)
    @mpichk ccall((:QMPI_Type_match_size, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, Ptr{MPI_Datatype}), context, tool_id, typeclass, size, datatype)
end

"""
    QMPI_Type_set_name(context, tool_id, datatype, type_name)

$(_doc_external(:QMPI_Type_set_name))
"""
function QMPI_Type_set_name(context, tool_id, datatype, type_name)
    @mpichk ccall((:QMPI_Type_set_name, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{Cchar}), context, tool_id, datatype, type_name)
end

"""
    QMPI_Type_size(context, tool_id, datatype, size)

$(_doc_external(:QMPI_Type_size))
"""
function QMPI_Type_size(context, tool_id, datatype, size)
    @mpichk ccall((:QMPI_Type_size, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{Cint}), context, tool_id, datatype, size)
end

"""
    QMPI_Type_size_c(context, tool_id, datatype, size)

$(_doc_external(:QMPI_Type_size_c))
"""
function QMPI_Type_size_c(context, tool_id, datatype, size)
    @mpichk ccall((:QMPI_Type_size_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{MPI_Count}), context, tool_id, datatype, size)
end

"""
    QMPI_Type_size_x(context, tool_id, datatype, size)

$(_doc_external(:QMPI_Type_size_x))
"""
function QMPI_Type_size_x(context, tool_id, datatype, size)
    @mpichk ccall((:QMPI_Type_size_x, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{MPI_Count}), context, tool_id, datatype, size)
end

"""
    QMPI_Type_vector(context, tool_id, count, blocklength, stride, oldtype, newtype)

$(_doc_external(:QMPI_Type_vector))
"""
function QMPI_Type_vector(context, tool_id, count, blocklength, stride, oldtype, newtype)
    @mpichk ccall((:QMPI_Type_vector, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, Cint, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, blocklength, stride, oldtype, newtype)
end

"""
    QMPI_Type_vector_c(context, tool_id, count, blocklength, stride, oldtype, newtype)

$(_doc_external(:QMPI_Type_vector_c))
"""
function QMPI_Type_vector_c(context, tool_id, count, blocklength, stride, oldtype, newtype)
    @mpichk ccall((:QMPI_Type_vector_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Count, MPI_Count, MPI_Count, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, blocklength, stride, oldtype, newtype)
end

"""
    QMPI_Unpack(context, tool_id, inbuf, insize, position, outbuf, outcount, datatype, comm)

$(_doc_external(:QMPI_Unpack))
"""
function QMPI_Unpack(context, tool_id, inbuf, insize, position, outbuf, outcount, datatype, comm)
    @mpichk ccall((:QMPI_Unpack, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, Ptr{Cint}, MPIPtr, Cint, MPI_Datatype, MPI_Comm), context, tool_id, inbuf, insize, position, outbuf, outcount, datatype, comm)
end

"""
    QMPI_Unpack_c(context, tool_id, inbuf, insize, position, outbuf, outcount, datatype, comm)

$(_doc_external(:QMPI_Unpack_c))
"""
function QMPI_Unpack_c(context, tool_id, inbuf, insize, position, outbuf, outcount, datatype, comm)
    @mpichk ccall((:QMPI_Unpack_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, Ptr{MPI_Count}, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm), context, tool_id, inbuf, insize, position, outbuf, outcount, datatype, comm)
end

"""
    QMPI_Unpack_external(context, tool_id, datarep, inbuf, insize, position, outbuf, outcount, datatype)

$(_doc_external(:QMPI_Unpack_external))
"""
function QMPI_Unpack_external(context, tool_id, datarep, inbuf, insize, position, outbuf, outcount, datatype)
    @mpichk ccall((:QMPI_Unpack_external, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, MPIPtr, MPI_Aint, Ptr{MPI_Aint}, MPIPtr, Cint, MPI_Datatype), context, tool_id, datarep, inbuf, insize, position, outbuf, outcount, datatype)
end

"""
    QMPI_Unpack_external_c(context, tool_id, datarep, inbuf, insize, position, outbuf, outcount, datatype)

$(_doc_external(:QMPI_Unpack_external_c))
"""
function QMPI_Unpack_external_c(context, tool_id, datarep, inbuf, insize, position, outbuf, outcount, datatype)
    @mpichk ccall((:QMPI_Unpack_external_c, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, MPIPtr, MPI_Count, Ptr{MPI_Count}, MPIPtr, MPI_Count, MPI_Datatype), context, tool_id, datarep, inbuf, insize, position, outbuf, outcount, datatype)
end

"""
    QMPI_Address(context, tool_id, location, address)

$(_doc_external(:QMPI_Address))
"""
function QMPI_Address(context, tool_id, location, address)
    @mpichk ccall((:QMPI_Address, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{MPI_Aint}), context, tool_id, location, address)
end

"""
    QMPI_Type_extent(context, tool_id, datatype, extent)

$(_doc_external(:QMPI_Type_extent))
"""
function QMPI_Type_extent(context, tool_id, datatype, extent)
    @mpichk ccall((:QMPI_Type_extent, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{MPI_Aint}), context, tool_id, datatype, extent)
end

"""
    QMPI_Type_lb(context, tool_id, datatype, displacement)

$(_doc_external(:QMPI_Type_lb))
"""
function QMPI_Type_lb(context, tool_id, datatype, displacement)
    @mpichk ccall((:QMPI_Type_lb, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{MPI_Aint}), context, tool_id, datatype, displacement)
end

"""
    QMPI_Type_ub(context, tool_id, datatype, displacement)

$(_doc_external(:QMPI_Type_ub))
"""
function QMPI_Type_ub(context, tool_id, datatype, displacement)
    @mpichk ccall((:QMPI_Type_ub, libmpi), Cint, (QMPI_Context, Cint, MPI_Datatype, Ptr{MPI_Aint}), context, tool_id, datatype, displacement)
end

"""
    QMPI_Type_hindexed(context, tool_id, count, array_of_blocklengths, array_of_displacements, oldtype, newtype)

$(_doc_external(:QMPI_Type_hindexed))
"""
function QMPI_Type_hindexed(context, tool_id, count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:QMPI_Type_hindexed, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cint}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

"""
    QMPI_Type_hvector(context, tool_id, count, blocklength, stride, oldtype, newtype)

$(_doc_external(:QMPI_Type_hvector))
"""
function QMPI_Type_hvector(context, tool_id, count, blocklength, stride, oldtype, newtype)
    @mpichk ccall((:QMPI_Type_hvector, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, MPI_Aint, MPI_Datatype, Ptr{MPI_Datatype}), context, tool_id, count, blocklength, stride, oldtype, newtype)
end

"""
    QMPI_Type_struct(context, tool_id, count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)

$(_doc_external(:QMPI_Type_struct))
"""
function QMPI_Type_struct(context, tool_id, count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
    @mpichk ccall((:QMPI_Type_struct, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}), context, tool_id, count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
end

"""
    QMPI_Add_error_class(context, tool_id, errorclass)

$(_doc_external(:QMPI_Add_error_class))
"""
function QMPI_Add_error_class(context, tool_id, errorclass)
    @mpichk ccall((:QMPI_Add_error_class, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, errorclass)
end

"""
    QMPI_Add_error_code(context, tool_id, errorclass, errorcode)

$(_doc_external(:QMPI_Add_error_code))
"""
function QMPI_Add_error_code(context, tool_id, errorclass, errorcode)
    @mpichk ccall((:QMPI_Add_error_code, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cint}), context, tool_id, errorclass, errorcode)
end

"""
    QMPI_Add_error_string(context, tool_id, errorcode, string)

$(_doc_external(:QMPI_Add_error_string))
"""
function QMPI_Add_error_string(context, tool_id, errorcode, string)
    @mpichk ccall((:QMPI_Add_error_string, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cchar}), context, tool_id, errorcode, string)
end

"""
    QMPI_Comm_call_errhandler(context, tool_id, comm, errorcode)

$(_doc_external(:QMPI_Comm_call_errhandler))
"""
function QMPI_Comm_call_errhandler(context, tool_id, comm, errorcode)
    @mpichk ccall((:QMPI_Comm_call_errhandler, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint), context, tool_id, comm, errorcode)
end

"""
    QMPI_Comm_create_errhandler(context, tool_id, comm_errhandler_fn, errhandler)

$(_doc_external(:QMPI_Comm_create_errhandler))
"""
function QMPI_Comm_create_errhandler(context, tool_id, comm_errhandler_fn, errhandler)
    @mpichk ccall((:QMPI_Comm_create_errhandler, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{MPI_Errhandler}), context, tool_id, comm_errhandler_fn, errhandler)
end

"""
    QMPI_Comm_get_errhandler(context, tool_id, comm, errhandler)

$(_doc_external(:QMPI_Comm_get_errhandler))
"""
function QMPI_Comm_get_errhandler(context, tool_id, comm, errhandler)
    @mpichk ccall((:QMPI_Comm_get_errhandler, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{MPI_Errhandler}), context, tool_id, comm, errhandler)
end

"""
    QMPI_Comm_set_errhandler(context, tool_id, comm, errhandler)

$(_doc_external(:QMPI_Comm_set_errhandler))
"""
function QMPI_Comm_set_errhandler(context, tool_id, comm, errhandler)
    @mpichk ccall((:QMPI_Comm_set_errhandler, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, MPI_Errhandler), context, tool_id, comm, errhandler)
end

"""
    QMPI_Errhandler_free(context, tool_id, errhandler)

$(_doc_external(:QMPI_Errhandler_free))
"""
function QMPI_Errhandler_free(context, tool_id, errhandler)
    @mpichk ccall((:QMPI_Errhandler_free, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Errhandler}), context, tool_id, errhandler)
end

"""
    QMPI_Error_class(context, tool_id, errorcode, errorclass)

$(_doc_external(:QMPI_Error_class))
"""
function QMPI_Error_class(context, tool_id, errorcode, errorclass)
    @mpichk ccall((:QMPI_Error_class, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cint}), context, tool_id, errorcode, errorclass)
end

"""
    QMPI_Error_string(context, tool_id, errorcode, string, resultlen)

$(_doc_external(:QMPI_Error_string))
"""
function QMPI_Error_string(context, tool_id, errorcode, string, resultlen)
    @mpichk ccall((:QMPI_Error_string, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cchar}, Ptr{Cint}), context, tool_id, errorcode, string, resultlen)
end

"""
    QMPI_File_call_errhandler(context, tool_id, fh, errorcode)

$(_doc_external(:QMPI_File_call_errhandler))
"""
function QMPI_File_call_errhandler(context, tool_id, fh, errorcode)
    @mpichk ccall((:QMPI_File_call_errhandler, libmpi), Cint, (QMPI_Context, Cint, MPI_File, Cint), context, tool_id, fh, errorcode)
end

"""
    QMPI_File_create_errhandler(context, tool_id, file_errhandler_fn, errhandler)

$(_doc_external(:QMPI_File_create_errhandler))
"""
function QMPI_File_create_errhandler(context, tool_id, file_errhandler_fn, errhandler)
    @mpichk ccall((:QMPI_File_create_errhandler, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{MPI_Errhandler}), context, tool_id, file_errhandler_fn, errhandler)
end

"""
    QMPI_File_get_errhandler(context, tool_id, file, errhandler)

$(_doc_external(:QMPI_File_get_errhandler))
"""
function QMPI_File_get_errhandler(context, tool_id, file, errhandler)
    @mpichk ccall((:QMPI_File_get_errhandler, libmpi), Cint, (QMPI_Context, Cint, MPI_File, Ptr{MPI_Errhandler}), context, tool_id, file, errhandler)
end

"""
    QMPI_File_set_errhandler(context, tool_id, file, errhandler)

$(_doc_external(:QMPI_File_set_errhandler))
"""
function QMPI_File_set_errhandler(context, tool_id, file, errhandler)
    @mpichk ccall((:QMPI_File_set_errhandler, libmpi), Cint, (QMPI_Context, Cint, MPI_File, MPI_Errhandler), context, tool_id, file, errhandler)
end

"""
    QMPI_Session_call_errhandler(context, tool_id, session, errorcode)

$(_doc_external(:QMPI_Session_call_errhandler))
"""
function QMPI_Session_call_errhandler(context, tool_id, session, errorcode)
    @mpichk ccall((:QMPI_Session_call_errhandler, libmpi), Cint, (QMPI_Context, Cint, MPI_Session, Cint), context, tool_id, session, errorcode)
end

"""
    QMPI_Session_create_errhandler(context, tool_id, session_errhandler_fn, errhandler)

$(_doc_external(:QMPI_Session_create_errhandler))
"""
function QMPI_Session_create_errhandler(context, tool_id, session_errhandler_fn, errhandler)
    @mpichk ccall((:QMPI_Session_create_errhandler, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{MPI_Errhandler}), context, tool_id, session_errhandler_fn, errhandler)
end

"""
    QMPI_Session_get_errhandler(context, tool_id, session, errhandler)

$(_doc_external(:QMPI_Session_get_errhandler))
"""
function QMPI_Session_get_errhandler(context, tool_id, session, errhandler)
    @mpichk ccall((:QMPI_Session_get_errhandler, libmpi), Cint, (QMPI_Context, Cint, MPI_Session, Ptr{MPI_Errhandler}), context, tool_id, session, errhandler)
end

"""
    QMPI_Session_set_errhandler(context, tool_id, session, errhandler)

$(_doc_external(:QMPI_Session_set_errhandler))
"""
function QMPI_Session_set_errhandler(context, tool_id, session, errhandler)
    @mpichk ccall((:QMPI_Session_set_errhandler, libmpi), Cint, (QMPI_Context, Cint, MPI_Session, MPI_Errhandler), context, tool_id, session, errhandler)
end

"""
    QMPI_Win_call_errhandler(context, tool_id, win, errorcode)

$(_doc_external(:QMPI_Win_call_errhandler))
"""
function QMPI_Win_call_errhandler(context, tool_id, win, errorcode)
    @mpichk ccall((:QMPI_Win_call_errhandler, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, Cint), context, tool_id, win, errorcode)
end

"""
    QMPI_Win_create_errhandler(context, tool_id, win_errhandler_fn, errhandler)

$(_doc_external(:QMPI_Win_create_errhandler))
"""
function QMPI_Win_create_errhandler(context, tool_id, win_errhandler_fn, errhandler)
    @mpichk ccall((:QMPI_Win_create_errhandler, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{MPI_Errhandler}), context, tool_id, win_errhandler_fn, errhandler)
end

"""
    QMPI_Win_get_errhandler(context, tool_id, win, errhandler)

$(_doc_external(:QMPI_Win_get_errhandler))
"""
function QMPI_Win_get_errhandler(context, tool_id, win, errhandler)
    @mpichk ccall((:QMPI_Win_get_errhandler, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, Ptr{MPI_Errhandler}), context, tool_id, win, errhandler)
end

"""
    QMPI_Win_set_errhandler(context, tool_id, win, errhandler)

$(_doc_external(:QMPI_Win_set_errhandler))
"""
function QMPI_Win_set_errhandler(context, tool_id, win, errhandler)
    @mpichk ccall((:QMPI_Win_set_errhandler, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, MPI_Errhandler), context, tool_id, win, errhandler)
end

"""
    QMPIX_Delete_error_class(context, tool_id, errorclass)

$(_doc_external(:QMPIX_Delete_error_class))
"""
function QMPIX_Delete_error_class(context, tool_id, errorclass)
    @mpichk ccall((:QMPIX_Delete_error_class, libmpi), Cint, (QMPI_Context, Cint, Cint), context, tool_id, errorclass)
end

"""
    QMPIX_Delete_error_code(context, tool_id, errorcode)

$(_doc_external(:QMPIX_Delete_error_code))
"""
function QMPIX_Delete_error_code(context, tool_id, errorcode)
    @mpichk ccall((:QMPIX_Delete_error_code, libmpi), Cint, (QMPI_Context, Cint, Cint), context, tool_id, errorcode)
end

"""
    QMPIX_Delete_error_string(context, tool_id, errorcode)

$(_doc_external(:QMPIX_Delete_error_string))
"""
function QMPIX_Delete_error_string(context, tool_id, errorcode)
    @mpichk ccall((:QMPIX_Delete_error_string, libmpi), Cint, (QMPI_Context, Cint, Cint), context, tool_id, errorcode)
end

"""
    QMPI_Errhandler_create(context, tool_id, comm_errhandler_fn, errhandler)

$(_doc_external(:QMPI_Errhandler_create))
"""
function QMPI_Errhandler_create(context, tool_id, comm_errhandler_fn, errhandler)
    @mpichk ccall((:QMPI_Errhandler_create, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{MPI_Errhandler}), context, tool_id, comm_errhandler_fn, errhandler)
end

"""
    QMPI_Errhandler_get(context, tool_id, comm, errhandler)

$(_doc_external(:QMPI_Errhandler_get))
"""
function QMPI_Errhandler_get(context, tool_id, comm, errhandler)
    @mpichk ccall((:QMPI_Errhandler_get, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{MPI_Errhandler}), context, tool_id, comm, errhandler)
end

"""
    QMPI_Errhandler_set(context, tool_id, comm, errhandler)

$(_doc_external(:QMPI_Errhandler_set))
"""
function QMPI_Errhandler_set(context, tool_id, comm, errhandler)
    @mpichk ccall((:QMPI_Errhandler_set, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, MPI_Errhandler), context, tool_id, comm, errhandler)
end

"""
    QMPI_Group_compare(context, tool_id, group1, group2, result)

$(_doc_external(:QMPI_Group_compare))
"""
function QMPI_Group_compare(context, tool_id, group1, group2, result)
    @mpichk ccall((:QMPI_Group_compare, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, MPI_Group, Ptr{Cint}), context, tool_id, group1, group2, result)
end

"""
    QMPI_Group_difference(context, tool_id, group1, group2, newgroup)

$(_doc_external(:QMPI_Group_difference))
"""
function QMPI_Group_difference(context, tool_id, group1, group2, newgroup)
    @mpichk ccall((:QMPI_Group_difference, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, MPI_Group, Ptr{MPI_Group}), context, tool_id, group1, group2, newgroup)
end

"""
    QMPI_Group_excl(context, tool_id, group, n, ranks, newgroup)

$(_doc_external(:QMPI_Group_excl))
"""
function QMPI_Group_excl(context, tool_id, group, n, ranks, newgroup)
    @mpichk ccall((:QMPI_Group_excl, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, Cint, Ptr{Cint}, Ptr{MPI_Group}), context, tool_id, group, n, ranks, newgroup)
end

"""
    QMPI_Group_free(context, tool_id, group)

$(_doc_external(:QMPI_Group_free))
"""
function QMPI_Group_free(context, tool_id, group)
    @mpichk ccall((:QMPI_Group_free, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Group}), context, tool_id, group)
end

"""
    QMPI_Group_incl(context, tool_id, group, n, ranks, newgroup)

$(_doc_external(:QMPI_Group_incl))
"""
function QMPI_Group_incl(context, tool_id, group, n, ranks, newgroup)
    @mpichk ccall((:QMPI_Group_incl, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, Cint, Ptr{Cint}, Ptr{MPI_Group}), context, tool_id, group, n, ranks, newgroup)
end

"""
    QMPI_Group_intersection(context, tool_id, group1, group2, newgroup)

$(_doc_external(:QMPI_Group_intersection))
"""
function QMPI_Group_intersection(context, tool_id, group1, group2, newgroup)
    @mpichk ccall((:QMPI_Group_intersection, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, MPI_Group, Ptr{MPI_Group}), context, tool_id, group1, group2, newgroup)
end

"""
    QMPI_Group_range_excl(context, tool_id, group, n, ranges, newgroup)

$(_doc_external(:QMPI_Group_range_excl))
"""
function QMPI_Group_range_excl(context, tool_id, group, n, ranges, newgroup)
    @mpichk ccall((:QMPI_Group_range_excl, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, Cint, Ptr{NTuple{3, Cint}}, Ptr{MPI_Group}), context, tool_id, group, n, ranges, newgroup)
end

"""
    QMPI_Group_range_incl(context, tool_id, group, n, ranges, newgroup)

$(_doc_external(:QMPI_Group_range_incl))
"""
function QMPI_Group_range_incl(context, tool_id, group, n, ranges, newgroup)
    @mpichk ccall((:QMPI_Group_range_incl, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, Cint, Ptr{NTuple{3, Cint}}, Ptr{MPI_Group}), context, tool_id, group, n, ranges, newgroup)
end

"""
    QMPI_Group_rank(context, tool_id, group, rank)

$(_doc_external(:QMPI_Group_rank))
"""
function QMPI_Group_rank(context, tool_id, group, rank)
    @mpichk ccall((:QMPI_Group_rank, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, Ptr{Cint}), context, tool_id, group, rank)
end

"""
    QMPI_Group_size(context, tool_id, group, size)

$(_doc_external(:QMPI_Group_size))
"""
function QMPI_Group_size(context, tool_id, group, size)
    @mpichk ccall((:QMPI_Group_size, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, Ptr{Cint}), context, tool_id, group, size)
end

"""
    QMPI_Group_translate_ranks(context, tool_id, group1, n, ranks1, group2, ranks2)

$(_doc_external(:QMPI_Group_translate_ranks))
"""
function QMPI_Group_translate_ranks(context, tool_id, group1, n, ranks1, group2, ranks2)
    @mpichk ccall((:QMPI_Group_translate_ranks, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, Cint, Ptr{Cint}, MPI_Group, Ptr{Cint}), context, tool_id, group1, n, ranks1, group2, ranks2)
end

"""
    QMPI_Group_union(context, tool_id, group1, group2, newgroup)

$(_doc_external(:QMPI_Group_union))
"""
function QMPI_Group_union(context, tool_id, group1, group2, newgroup)
    @mpichk ccall((:QMPI_Group_union, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, MPI_Group, Ptr{MPI_Group}), context, tool_id, group1, group2, newgroup)
end

"""
    QMPI_Info_create(context, tool_id, info)

$(_doc_external(:QMPI_Info_create))
"""
function QMPI_Info_create(context, tool_id, info)
    @mpichk ccall((:QMPI_Info_create, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Info}), context, tool_id, info)
end

"""
    QMPI_Info_create_env(context, tool_id, argc, argv, info)

$(_doc_external(:QMPI_Info_create_env))
"""
function QMPI_Info_create_env(context, tool_id, argc, argv, info)
    @mpichk ccall((:QMPI_Info_create_env, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Ptr{Cchar}}, Ptr{MPI_Info}), context, tool_id, argc, argv, info)
end

"""
    QMPI_Info_delete(context, tool_id, info, key)

$(_doc_external(:QMPI_Info_delete))
"""
function QMPI_Info_delete(context, tool_id, info, key)
    @mpichk ccall((:QMPI_Info_delete, libmpi), Cint, (QMPI_Context, Cint, MPI_Info, Ptr{Cchar}), context, tool_id, info, key)
end

"""
    QMPI_Info_dup(context, tool_id, info, newinfo)

$(_doc_external(:QMPI_Info_dup))
"""
function QMPI_Info_dup(context, tool_id, info, newinfo)
    @mpichk ccall((:QMPI_Info_dup, libmpi), Cint, (QMPI_Context, Cint, MPI_Info, Ptr{MPI_Info}), context, tool_id, info, newinfo)
end

"""
    QMPI_Info_free(context, tool_id, info)

$(_doc_external(:QMPI_Info_free))
"""
function QMPI_Info_free(context, tool_id, info)
    @mpichk ccall((:QMPI_Info_free, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Info}), context, tool_id, info)
end

"""
    QMPI_Info_get(context, tool_id, info, key, valuelen, value, flag)

$(_doc_external(:QMPI_Info_get))
"""
function QMPI_Info_get(context, tool_id, info, key, valuelen, value, flag)
    @mpichk ccall((:QMPI_Info_get, libmpi), Cint, (QMPI_Context, Cint, MPI_Info, Ptr{Cchar}, Cint, Ptr{Cchar}, Ptr{Cint}), context, tool_id, info, key, valuelen, value, flag)
end

"""
    QMPI_Info_get_nkeys(context, tool_id, info, nkeys)

$(_doc_external(:QMPI_Info_get_nkeys))
"""
function QMPI_Info_get_nkeys(context, tool_id, info, nkeys)
    @mpichk ccall((:QMPI_Info_get_nkeys, libmpi), Cint, (QMPI_Context, Cint, MPI_Info, Ptr{Cint}), context, tool_id, info, nkeys)
end

"""
    QMPI_Info_get_nthkey(context, tool_id, info, n, key)

$(_doc_external(:QMPI_Info_get_nthkey))
"""
function QMPI_Info_get_nthkey(context, tool_id, info, n, key)
    @mpichk ccall((:QMPI_Info_get_nthkey, libmpi), Cint, (QMPI_Context, Cint, MPI_Info, Cint, Ptr{Cchar}), context, tool_id, info, n, key)
end

"""
    QMPI_Info_get_string(context, tool_id, info, key, buflen, value, flag)

$(_doc_external(:QMPI_Info_get_string))
"""
function QMPI_Info_get_string(context, tool_id, info, key, buflen, value, flag)
    @mpichk ccall((:QMPI_Info_get_string, libmpi), Cint, (QMPI_Context, Cint, MPI_Info, Ptr{Cchar}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}), context, tool_id, info, key, buflen, value, flag)
end

"""
    QMPI_Info_get_valuelen(context, tool_id, info, key, valuelen, flag)

$(_doc_external(:QMPI_Info_get_valuelen))
"""
function QMPI_Info_get_valuelen(context, tool_id, info, key, valuelen, flag)
    @mpichk ccall((:QMPI_Info_get_valuelen, libmpi), Cint, (QMPI_Context, Cint, MPI_Info, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}), context, tool_id, info, key, valuelen, flag)
end

"""
    QMPI_Info_set(context, tool_id, info, key, value)

$(_doc_external(:QMPI_Info_set))
"""
function QMPI_Info_set(context, tool_id, info, key, value)
    @mpichk ccall((:QMPI_Info_set, libmpi), Cint, (QMPI_Context, Cint, MPI_Info, Ptr{Cchar}, Ptr{Cchar}), context, tool_id, info, key, value)
end

"""
    QMPI_Abort(context, tool_id, comm, errorcode)

$(_doc_external(:QMPI_Abort))
"""
function QMPI_Abort(context, tool_id, comm, errorcode)
    @mpichk ccall((:QMPI_Abort, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint), context, tool_id, comm, errorcode)
end

"""
    QMPI_Comm_create_from_group(context, tool_id, group, stringtag, info, errhandler, newcomm)

$(_doc_external(:QMPI_Comm_create_from_group))
"""
function QMPI_Comm_create_from_group(context, tool_id, group, stringtag, info, errhandler, newcomm)
    @mpichk ccall((:QMPI_Comm_create_from_group, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, Ptr{Cchar}, MPI_Info, MPI_Errhandler, Ptr{MPI_Comm}), context, tool_id, group, stringtag, info, errhandler, newcomm)
end

"""
    QMPI_Finalize(context, tool_id)

$(_doc_external(:QMPI_Finalize))
"""
function QMPI_Finalize(context, tool_id)
    @mpichk ccall((:QMPI_Finalize, libmpi), Cint, (QMPI_Context, Cint), context, tool_id)
end

"""
    QMPI_Finalized(context, tool_id, flag)

$(_doc_external(:QMPI_Finalized))
"""
function QMPI_Finalized(context, tool_id, flag)
    @mpichk ccall((:QMPI_Finalized, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, flag)
end

"""
    QMPI_Group_from_session_pset(context, tool_id, session, pset_name, newgroup)

$(_doc_external(:QMPI_Group_from_session_pset))
"""
function QMPI_Group_from_session_pset(context, tool_id, session, pset_name, newgroup)
    @mpichk ccall((:QMPI_Group_from_session_pset, libmpi), Cint, (QMPI_Context, Cint, MPI_Session, Ptr{Cchar}, Ptr{MPI_Group}), context, tool_id, session, pset_name, newgroup)
end

"""
    QMPI_Init(context, tool_id, argc, argv)

$(_doc_external(:QMPI_Init))
"""
function QMPI_Init(context, tool_id, argc, argv)
    @mpichk ccall((:QMPI_Init, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}, Ptr{Ptr{Ptr{Cchar}}}), context, tool_id, argc, argv)
end

"""
    QMPI_Init_thread(context, tool_id, argc, argv, required, provided)

$(_doc_external(:QMPI_Init_thread))
"""
function QMPI_Init_thread(context, tool_id, argc, argv, required, provided)
    @mpichk ccall((:QMPI_Init_thread, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}, Ptr{Ptr{Ptr{Cchar}}}, Cint, Ptr{Cint}), context, tool_id, argc, argv, required, provided)
end

"""
    QMPI_Initialized(context, tool_id, flag)

$(_doc_external(:QMPI_Initialized))
"""
function QMPI_Initialized(context, tool_id, flag)
    @mpichk ccall((:QMPI_Initialized, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, flag)
end

"""
    QMPI_Is_thread_main(context, tool_id, flag)

$(_doc_external(:QMPI_Is_thread_main))
"""
function QMPI_Is_thread_main(context, tool_id, flag)
    @mpichk ccall((:QMPI_Is_thread_main, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, flag)
end

"""
    QMPI_Query_thread(context, tool_id, provided)

$(_doc_external(:QMPI_Query_thread))
"""
function QMPI_Query_thread(context, tool_id, provided)
    @mpichk ccall((:QMPI_Query_thread, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, provided)
end

"""
    QMPI_Session_finalize(context, tool_id, session)

$(_doc_external(:QMPI_Session_finalize))
"""
function QMPI_Session_finalize(context, tool_id, session)
    @mpichk ccall((:QMPI_Session_finalize, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Session}), context, tool_id, session)
end

"""
    QMPI_Session_get_info(context, tool_id, session, info_used)

$(_doc_external(:QMPI_Session_get_info))
"""
function QMPI_Session_get_info(context, tool_id, session, info_used)
    @mpichk ccall((:QMPI_Session_get_info, libmpi), Cint, (QMPI_Context, Cint, MPI_Session, Ptr{MPI_Info}), context, tool_id, session, info_used)
end

"""
    QMPI_Session_get_nth_pset(context, tool_id, session, info, n, pset_len, pset_name)

$(_doc_external(:QMPI_Session_get_nth_pset))
"""
function QMPI_Session_get_nth_pset(context, tool_id, session, info, n, pset_len, pset_name)
    @mpichk ccall((:QMPI_Session_get_nth_pset, libmpi), Cint, (QMPI_Context, Cint, MPI_Session, MPI_Info, Cint, Ptr{Cint}, Ptr{Cchar}), context, tool_id, session, info, n, pset_len, pset_name)
end

"""
    QMPI_Session_get_num_psets(context, tool_id, session, info, npset_names)

$(_doc_external(:QMPI_Session_get_num_psets))
"""
function QMPI_Session_get_num_psets(context, tool_id, session, info, npset_names)
    @mpichk ccall((:QMPI_Session_get_num_psets, libmpi), Cint, (QMPI_Context, Cint, MPI_Session, MPI_Info, Ptr{Cint}), context, tool_id, session, info, npset_names)
end

"""
    QMPI_Session_get_pset_info(context, tool_id, session, pset_name, info)

$(_doc_external(:QMPI_Session_get_pset_info))
"""
function QMPI_Session_get_pset_info(context, tool_id, session, pset_name, info)
    @mpichk ccall((:QMPI_Session_get_pset_info, libmpi), Cint, (QMPI_Context, Cint, MPI_Session, Ptr{Cchar}, Ptr{MPI_Info}), context, tool_id, session, pset_name, info)
end

"""
    QMPI_Session_init(context, tool_id, info, errhandler, session)

$(_doc_external(:QMPI_Session_init))
"""
function QMPI_Session_init(context, tool_id, info, errhandler, session)
    @mpichk ccall((:QMPI_Session_init, libmpi), Cint, (QMPI_Context, Cint, MPI_Info, MPI_Errhandler, Ptr{MPI_Session}), context, tool_id, info, errhandler, session)
end

"""
    QMPI_Aint_add(context, tool_id, base, disp)

$(_doc_external(:QMPI_Aint_add))
"""
function QMPI_Aint_add(context, tool_id, base, disp)
    @mpichk ccall((:QMPI_Aint_add, libmpi), MPI_Aint, (QMPI_Context, Cint, MPI_Aint, MPI_Aint), context, tool_id, base, disp)
end

"""
    QMPI_Aint_diff(context, tool_id, addr1, addr2)

$(_doc_external(:QMPI_Aint_diff))
"""
function QMPI_Aint_diff(context, tool_id, addr1, addr2)
    @mpichk ccall((:QMPI_Aint_diff, libmpi), MPI_Aint, (QMPI_Context, Cint, MPI_Aint, MPI_Aint), context, tool_id, addr1, addr2)
end

"""
    QMPI_Get_library_version(context, tool_id, version, resultlen)

$(_doc_external(:QMPI_Get_library_version))
"""
function QMPI_Get_library_version(context, tool_id, version, resultlen)
    @mpichk ccall((:QMPI_Get_library_version, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, Ptr{Cint}), context, tool_id, version, resultlen)
end

"""
    QMPI_Get_processor_name(context, tool_id, name, resultlen)

$(_doc_external(:QMPI_Get_processor_name))
"""
function QMPI_Get_processor_name(context, tool_id, name, resultlen)
    @mpichk ccall((:QMPI_Get_processor_name, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, Ptr{Cint}), context, tool_id, name, resultlen)
end

"""
    QMPI_Get_version(context, tool_id, version, subversion)

$(_doc_external(:QMPI_Get_version))
"""
function QMPI_Get_version(context, tool_id, version, subversion)
    @mpichk ccall((:QMPI_Get_version, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}, Ptr{Cint}), context, tool_id, version, subversion)
end

"""
    QMPIX_GPU_query_support(context, tool_id, gpu_type, is_supported)

$(_doc_external(:QMPIX_GPU_query_support))
"""
function QMPIX_GPU_query_support(context, tool_id, gpu_type, is_supported)
    @mpichk ccall((:QMPIX_GPU_query_support, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cint}), context, tool_id, gpu_type, is_supported)
end

"""
    QMPIX_Query_cuda_support(context, tool_id)

$(_doc_external(:QMPIX_Query_cuda_support))
"""
function QMPIX_Query_cuda_support(context, tool_id)
    @mpichk ccall((:QMPIX_Query_cuda_support, libmpi), Cint, (QMPI_Context, Cint), context, tool_id)
end

"""
    QMPIX_Query_ze_support(context, tool_id)

$(_doc_external(:QMPIX_Query_ze_support))
"""
function QMPIX_Query_ze_support(context, tool_id)
    @mpichk ccall((:QMPIX_Query_ze_support, libmpi), Cint, (QMPI_Context, Cint), context, tool_id)
end

"""
    QMPIX_Query_hip_support(context, tool_id)

$(_doc_external(:QMPIX_Query_hip_support))
"""
function QMPIX_Query_hip_support(context, tool_id)
    @mpichk ccall((:QMPIX_Query_hip_support, libmpi), Cint, (QMPI_Context, Cint), context, tool_id)
end

"""
    QMPI_T_category_changed(context, tool_id, update_number)

$(_doc_external(:QMPI_T_category_changed))
"""
function QMPI_T_category_changed(context, tool_id, update_number)
    @mpichk ccall((:QMPI_T_category_changed, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, update_number)
end

"""
    QMPI_T_category_get_categories(context, tool_id, cat_index, len, indices)

$(_doc_external(:QMPI_T_category_get_categories))
"""
function QMPI_T_category_get_categories(context, tool_id, cat_index, len, indices)
    @mpichk ccall((:QMPI_T_category_get_categories, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, Ptr{Cint}), context, tool_id, cat_index, len, indices)
end

"""
    QMPI_T_category_get_cvars(context, tool_id, cat_index, len, indices)

$(_doc_external(:QMPI_T_category_get_cvars))
"""
function QMPI_T_category_get_cvars(context, tool_id, cat_index, len, indices)
    @mpichk ccall((:QMPI_T_category_get_cvars, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, Ptr{Cint}), context, tool_id, cat_index, len, indices)
end

"""
    QMPI_T_category_get_events(context, tool_id, cat_index, len, indices)

$(_doc_external(:QMPI_T_category_get_events))
"""
function QMPI_T_category_get_events(context, tool_id, cat_index, len, indices)
    @mpichk ccall((:QMPI_T_category_get_events, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, Ptr{Cint}), context, tool_id, cat_index, len, indices)
end

"""
    QMPI_T_category_get_index(context, tool_id, name, cat_index)

$(_doc_external(:QMPI_T_category_get_index))
"""
function QMPI_T_category_get_index(context, tool_id, name, cat_index)
    @mpichk ccall((:QMPI_T_category_get_index, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, Ptr{Cint}), context, tool_id, name, cat_index)
end

"""
    QMPI_T_category_get_info(context, tool_id, cat_index, name, name_len, desc, desc_len, num_cvars, num_pvars, num_categories)

$(_doc_external(:QMPI_T_category_get_info))
"""
function QMPI_T_category_get_info(context, tool_id, cat_index, name, name_len, desc, desc_len, num_cvars, num_pvars, num_categories)
    @mpichk ccall((:QMPI_T_category_get_info, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), context, tool_id, cat_index, name, name_len, desc, desc_len, num_cvars, num_pvars, num_categories)
end

"""
    QMPI_T_category_get_num(context, tool_id, num_cat)

$(_doc_external(:QMPI_T_category_get_num))
"""
function QMPI_T_category_get_num(context, tool_id, num_cat)
    @mpichk ccall((:QMPI_T_category_get_num, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, num_cat)
end

"""
    QMPI_T_category_get_num_events(context, tool_id, cat_index, num_events)

$(_doc_external(:QMPI_T_category_get_num_events))
"""
function QMPI_T_category_get_num_events(context, tool_id, cat_index, num_events)
    @mpichk ccall((:QMPI_T_category_get_num_events, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cint}), context, tool_id, cat_index, num_events)
end

"""
    QMPI_T_category_get_pvars(context, tool_id, cat_index, len, indices)

$(_doc_external(:QMPI_T_category_get_pvars))
"""
function QMPI_T_category_get_pvars(context, tool_id, cat_index, len, indices)
    @mpichk ccall((:QMPI_T_category_get_pvars, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, Ptr{Cint}), context, tool_id, cat_index, len, indices)
end

"""
    QMPI_T_cvar_get_index(context, tool_id, name, cvar_index)

$(_doc_external(:QMPI_T_cvar_get_index))
"""
function QMPI_T_cvar_get_index(context, tool_id, name, cvar_index)
    @mpichk ccall((:QMPI_T_cvar_get_index, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, Ptr{Cint}), context, tool_id, name, cvar_index)
end

"""
    QMPI_T_cvar_get_info(context, tool_id, cvar_index, name, name_len, verbosity, datatype, enumtype, desc, desc_len, bind, scope)

$(_doc_external(:QMPI_T_cvar_get_info))
"""
function QMPI_T_cvar_get_info(context, tool_id, cvar_index, name, name_len, verbosity, datatype, enumtype, desc, desc_len, bind, scope)
    @mpichk ccall((:QMPI_T_cvar_get_info, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{MPI_T_enum}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), context, tool_id, cvar_index, name, name_len, verbosity, datatype, enumtype, desc, desc_len, bind, scope)
end

"""
    QMPI_T_cvar_get_num(context, tool_id, num_cvar)

$(_doc_external(:QMPI_T_cvar_get_num))
"""
function QMPI_T_cvar_get_num(context, tool_id, num_cvar)
    @mpichk ccall((:QMPI_T_cvar_get_num, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, num_cvar)
end

"""
    QMPI_T_cvar_handle_alloc(context, tool_id, cvar_index, obj_handle, handle, count)

$(_doc_external(:QMPI_T_cvar_handle_alloc))
"""
function QMPI_T_cvar_handle_alloc(context, tool_id, cvar_index, obj_handle, handle, count)
    @mpichk ccall((:QMPI_T_cvar_handle_alloc, libmpi), Cint, (QMPI_Context, Cint, Cint, MPIPtr, Ptr{MPI_T_cvar_handle}, Ptr{Cint}), context, tool_id, cvar_index, obj_handle, handle, count)
end

"""
    QMPI_T_cvar_handle_free(context, tool_id, handle)

$(_doc_external(:QMPI_T_cvar_handle_free))
"""
function QMPI_T_cvar_handle_free(context, tool_id, handle)
    @mpichk ccall((:QMPI_T_cvar_handle_free, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_T_cvar_handle}), context, tool_id, handle)
end

"""
    QMPI_T_cvar_read(context, tool_id, handle, buf)

$(_doc_external(:QMPI_T_cvar_read))
"""
function QMPI_T_cvar_read(context, tool_id, handle, buf)
    @mpichk ccall((:QMPI_T_cvar_read, libmpi), Cint, (QMPI_Context, Cint, MPI_T_cvar_handle, MPIPtr), context, tool_id, handle, buf)
end

"""
    QMPI_T_cvar_write(context, tool_id, handle, buf)

$(_doc_external(:QMPI_T_cvar_write))
"""
function QMPI_T_cvar_write(context, tool_id, handle, buf)
    @mpichk ccall((:QMPI_T_cvar_write, libmpi), Cint, (QMPI_Context, Cint, MPI_T_cvar_handle, MPIPtr), context, tool_id, handle, buf)
end

"""
    QMPI_T_enum_get_info(context, tool_id, enumtype, num, name, name_len)

$(_doc_external(:QMPI_T_enum_get_info))
"""
function QMPI_T_enum_get_info(context, tool_id, enumtype, num, name, name_len)
    @mpichk ccall((:QMPI_T_enum_get_info, libmpi), Cint, (QMPI_Context, Cint, MPI_T_enum, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}), context, tool_id, enumtype, num, name, name_len)
end

"""
    QMPI_T_enum_get_item(context, tool_id, enumtype, indx, value, name, name_len)

$(_doc_external(:QMPI_T_enum_get_item))
"""
function QMPI_T_enum_get_item(context, tool_id, enumtype, indx, value, name, name_len)
    @mpichk ccall((:QMPI_T_enum_get_item, libmpi), Cint, (QMPI_Context, Cint, MPI_T_enum, Cint, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}), context, tool_id, enumtype, indx, value, name, name_len)
end

"""
    QMPI_T_event_callback_get_info(context, tool_id, event_registration, cb_safety, info_used)

$(_doc_external(:QMPI_T_event_callback_get_info))
"""
function QMPI_T_event_callback_get_info(context, tool_id, event_registration, cb_safety, info_used)
    @mpichk ccall((:QMPI_T_event_callback_get_info, libmpi), Cint, (QMPI_Context, Cint, MPI_T_event_registration, MPI_T_cb_safety, Ptr{MPI_Info}), context, tool_id, event_registration, cb_safety, info_used)
end

"""
    QMPI_T_event_callback_set_info(context, tool_id, event_registration, cb_safety, info)

$(_doc_external(:QMPI_T_event_callback_set_info))
"""
function QMPI_T_event_callback_set_info(context, tool_id, event_registration, cb_safety, info)
    @mpichk ccall((:QMPI_T_event_callback_set_info, libmpi), Cint, (QMPI_Context, Cint, MPI_T_event_registration, MPI_T_cb_safety, MPI_Info), context, tool_id, event_registration, cb_safety, info)
end

"""
    QMPI_T_event_copy(context, tool_id, event_instance, buffer)

$(_doc_external(:QMPI_T_event_copy))
"""
function QMPI_T_event_copy(context, tool_id, event_instance, buffer)
    @mpichk ccall((:QMPI_T_event_copy, libmpi), Cint, (QMPI_Context, Cint, MPI_T_event_instance, MPIPtr), context, tool_id, event_instance, buffer)
end

"""
    QMPI_T_event_get_index(context, tool_id, name, event_index)

$(_doc_external(:QMPI_T_event_get_index))
"""
function QMPI_T_event_get_index(context, tool_id, name, event_index)
    @mpichk ccall((:QMPI_T_event_get_index, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, Ptr{Cint}), context, tool_id, name, event_index)
end

"""
    QMPI_T_event_get_info(context, tool_id, event_index, name, name_len, verbosity, array_of_datatypes, array_of_displacements, num_elements, enumtype, info, desc, desc_len, bind)

$(_doc_external(:QMPI_T_event_get_info))
"""
function QMPI_T_event_get_info(context, tool_id, event_index, name, name_len, verbosity, array_of_datatypes, array_of_displacements, num_elements, enumtype, info, desc, desc_len, bind)
    @mpichk ccall((:QMPI_T_event_get_info, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{MPI_Aint}, Ptr{Cint}, Ptr{MPI_T_enum}, Ptr{MPI_Info}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}), context, tool_id, event_index, name, name_len, verbosity, array_of_datatypes, array_of_displacements, num_elements, enumtype, info, desc, desc_len, bind)
end

"""
    QMPI_T_event_get_num(context, tool_id, num_events)

$(_doc_external(:QMPI_T_event_get_num))
"""
function QMPI_T_event_get_num(context, tool_id, num_events)
    @mpichk ccall((:QMPI_T_event_get_num, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, num_events)
end

"""
    QMPI_T_event_get_source(context, tool_id, event_instance, source_index)

$(_doc_external(:QMPI_T_event_get_source))
"""
function QMPI_T_event_get_source(context, tool_id, event_instance, source_index)
    @mpichk ccall((:QMPI_T_event_get_source, libmpi), Cint, (QMPI_Context, Cint, MPI_T_event_instance, Ptr{Cint}), context, tool_id, event_instance, source_index)
end

"""
    QMPI_T_event_get_timestamp(context, tool_id, event_instance, event_timestamp)

$(_doc_external(:QMPI_T_event_get_timestamp))
"""
function QMPI_T_event_get_timestamp(context, tool_id, event_instance, event_timestamp)
    @mpichk ccall((:QMPI_T_event_get_timestamp, libmpi), Cint, (QMPI_Context, Cint, MPI_T_event_instance, Ptr{MPI_Count}), context, tool_id, event_instance, event_timestamp)
end

"""
    QMPI_T_event_handle_alloc(context, tool_id, event_index, obj_handle, info, event_registration)

$(_doc_external(:QMPI_T_event_handle_alloc))
"""
function QMPI_T_event_handle_alloc(context, tool_id, event_index, obj_handle, info, event_registration)
    @mpichk ccall((:QMPI_T_event_handle_alloc, libmpi), Cint, (QMPI_Context, Cint, Cint, MPIPtr, MPI_Info, Ptr{MPI_T_event_registration}), context, tool_id, event_index, obj_handle, info, event_registration)
end

"""
    QMPI_T_event_handle_free(context, tool_id, event_registration, user_data, free_cb_function)

$(_doc_external(:QMPI_T_event_handle_free))
"""
function QMPI_T_event_handle_free(context, tool_id, event_registration, user_data, free_cb_function)
    @mpichk ccall((:QMPI_T_event_handle_free, libmpi), Cint, (QMPI_Context, Cint, MPI_T_event_registration, MPIPtr, MPI_T_event_free_cb_function), context, tool_id, event_registration, user_data, free_cb_function)
end

"""
    QMPI_T_event_handle_get_info(context, tool_id, event_registration, info_used)

$(_doc_external(:QMPI_T_event_handle_get_info))
"""
function QMPI_T_event_handle_get_info(context, tool_id, event_registration, info_used)
    @mpichk ccall((:QMPI_T_event_handle_get_info, libmpi), Cint, (QMPI_Context, Cint, MPI_T_event_registration, Ptr{MPI_Info}), context, tool_id, event_registration, info_used)
end

"""
    QMPI_T_event_handle_set_info(context, tool_id, event_registration, info)

$(_doc_external(:QMPI_T_event_handle_set_info))
"""
function QMPI_T_event_handle_set_info(context, tool_id, event_registration, info)
    @mpichk ccall((:QMPI_T_event_handle_set_info, libmpi), Cint, (QMPI_Context, Cint, MPI_T_event_registration, MPI_Info), context, tool_id, event_registration, info)
end

"""
    QMPI_T_event_read(context, tool_id, event_instance, element_index, buffer)

$(_doc_external(:QMPI_T_event_read))
"""
function QMPI_T_event_read(context, tool_id, event_instance, element_index, buffer)
    @mpichk ccall((:QMPI_T_event_read, libmpi), Cint, (QMPI_Context, Cint, MPI_T_event_instance, Cint, MPIPtr), context, tool_id, event_instance, element_index, buffer)
end

"""
    QMPI_T_event_register_callback(context, tool_id, event_registration, cb_safety, info, user_data, event_cb_function)

$(_doc_external(:QMPI_T_event_register_callback))
"""
function QMPI_T_event_register_callback(context, tool_id, event_registration, cb_safety, info, user_data, event_cb_function)
    @mpichk ccall((:QMPI_T_event_register_callback, libmpi), Cint, (QMPI_Context, Cint, MPI_T_event_registration, MPI_T_cb_safety, MPI_Info, MPIPtr, MPI_T_event_cb_function), context, tool_id, event_registration, cb_safety, info, user_data, event_cb_function)
end

"""
    QMPI_T_event_set_dropped_handler(context, tool_id, event_registration, dropped_cb_function)

$(_doc_external(:QMPI_T_event_set_dropped_handler))
"""
function QMPI_T_event_set_dropped_handler(context, tool_id, event_registration, dropped_cb_function)
    @mpichk ccall((:QMPI_T_event_set_dropped_handler, libmpi), Cint, (QMPI_Context, Cint, MPI_T_event_registration, MPI_T_event_dropped_cb_function), context, tool_id, event_registration, dropped_cb_function)
end

"""
    QMPI_T_finalize(context, tool_id)

$(_doc_external(:QMPI_T_finalize))
"""
function QMPI_T_finalize(context, tool_id)
    @mpichk ccall((:QMPI_T_finalize, libmpi), Cint, (QMPI_Context, Cint), context, tool_id)
end

"""
    QMPI_T_init_thread(context, tool_id, required, provided)

$(_doc_external(:QMPI_T_init_thread))
"""
function QMPI_T_init_thread(context, tool_id, required, provided)
    @mpichk ccall((:QMPI_T_init_thread, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cint}), context, tool_id, required, provided)
end

"""
    QMPI_T_pvar_get_index(context, tool_id, name, var_class, pvar_index)

$(_doc_external(:QMPI_T_pvar_get_index))
"""
function QMPI_T_pvar_get_index(context, tool_id, name, var_class, pvar_index)
    @mpichk ccall((:QMPI_T_pvar_get_index, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, Cint, Ptr{Cint}), context, tool_id, name, var_class, pvar_index)
end

"""
    QMPI_T_pvar_get_info(context, tool_id, pvar_index, name, name_len, verbosity, var_class, datatype, enumtype, desc, desc_len, bind, readonly, continuous, atomic)

$(_doc_external(:QMPI_T_pvar_get_info))
"""
function QMPI_T_pvar_get_info(context, tool_id, pvar_index, name, name_len, verbosity, var_class, datatype, enumtype, desc, desc_len, bind, readonly, continuous, atomic)
    @mpichk ccall((:QMPI_T_pvar_get_info, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, Ptr{MPI_T_enum}, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), context, tool_id, pvar_index, name, name_len, verbosity, var_class, datatype, enumtype, desc, desc_len, bind, readonly, continuous, atomic)
end

"""
    QMPI_T_pvar_get_num(context, tool_id, num_pvar)

$(_doc_external(:QMPI_T_pvar_get_num))
"""
function QMPI_T_pvar_get_num(context, tool_id, num_pvar)
    @mpichk ccall((:QMPI_T_pvar_get_num, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, num_pvar)
end

"""
    QMPI_T_pvar_handle_alloc(context, tool_id, session, pvar_index, obj_handle, handle, count)

$(_doc_external(:QMPI_T_pvar_handle_alloc))
"""
function QMPI_T_pvar_handle_alloc(context, tool_id, session, pvar_index, obj_handle, handle, count)
    @mpichk ccall((:QMPI_T_pvar_handle_alloc, libmpi), Cint, (QMPI_Context, Cint, MPI_T_pvar_session, Cint, MPIPtr, Ptr{MPI_T_pvar_handle}, Ptr{Cint}), context, tool_id, session, pvar_index, obj_handle, handle, count)
end

"""
    QMPI_T_pvar_handle_free(context, tool_id, session, handle)

$(_doc_external(:QMPI_T_pvar_handle_free))
"""
function QMPI_T_pvar_handle_free(context, tool_id, session, handle)
    @mpichk ccall((:QMPI_T_pvar_handle_free, libmpi), Cint, (QMPI_Context, Cint, MPI_T_pvar_session, Ptr{MPI_T_pvar_handle}), context, tool_id, session, handle)
end

"""
    QMPI_T_pvar_read(context, tool_id, session, handle, buf)

$(_doc_external(:QMPI_T_pvar_read))
"""
function QMPI_T_pvar_read(context, tool_id, session, handle, buf)
    @mpichk ccall((:QMPI_T_pvar_read, libmpi), Cint, (QMPI_Context, Cint, MPI_T_pvar_session, MPI_T_pvar_handle, MPIPtr), context, tool_id, session, handle, buf)
end

"""
    QMPI_T_pvar_readreset(context, tool_id, session, handle, buf)

$(_doc_external(:QMPI_T_pvar_readreset))
"""
function QMPI_T_pvar_readreset(context, tool_id, session, handle, buf)
    @mpichk ccall((:QMPI_T_pvar_readreset, libmpi), Cint, (QMPI_Context, Cint, MPI_T_pvar_session, MPI_T_pvar_handle, MPIPtr), context, tool_id, session, handle, buf)
end

"""
    QMPI_T_pvar_reset(context, tool_id, session, handle)

$(_doc_external(:QMPI_T_pvar_reset))
"""
function QMPI_T_pvar_reset(context, tool_id, session, handle)
    @mpichk ccall((:QMPI_T_pvar_reset, libmpi), Cint, (QMPI_Context, Cint, MPI_T_pvar_session, MPI_T_pvar_handle), context, tool_id, session, handle)
end

"""
    QMPI_T_pvar_session_create(context, tool_id, session)

$(_doc_external(:QMPI_T_pvar_session_create))
"""
function QMPI_T_pvar_session_create(context, tool_id, session)
    @mpichk ccall((:QMPI_T_pvar_session_create, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_T_pvar_session}), context, tool_id, session)
end

"""
    QMPI_T_pvar_session_free(context, tool_id, session)

$(_doc_external(:QMPI_T_pvar_session_free))
"""
function QMPI_T_pvar_session_free(context, tool_id, session)
    @mpichk ccall((:QMPI_T_pvar_session_free, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_T_pvar_session}), context, tool_id, session)
end

"""
    QMPI_T_pvar_start(context, tool_id, session, handle)

$(_doc_external(:QMPI_T_pvar_start))
"""
function QMPI_T_pvar_start(context, tool_id, session, handle)
    @mpichk ccall((:QMPI_T_pvar_start, libmpi), Cint, (QMPI_Context, Cint, MPI_T_pvar_session, MPI_T_pvar_handle), context, tool_id, session, handle)
end

"""
    QMPI_T_pvar_stop(context, tool_id, session, handle)

$(_doc_external(:QMPI_T_pvar_stop))
"""
function QMPI_T_pvar_stop(context, tool_id, session, handle)
    @mpichk ccall((:QMPI_T_pvar_stop, libmpi), Cint, (QMPI_Context, Cint, MPI_T_pvar_session, MPI_T_pvar_handle), context, tool_id, session, handle)
end

"""
    QMPI_T_pvar_write(context, tool_id, session, handle, buf)

$(_doc_external(:QMPI_T_pvar_write))
"""
function QMPI_T_pvar_write(context, tool_id, session, handle, buf)
    @mpichk ccall((:QMPI_T_pvar_write, libmpi), Cint, (QMPI_Context, Cint, MPI_T_pvar_session, MPI_T_pvar_handle, MPIPtr), context, tool_id, session, handle, buf)
end

"""
    QMPI_T_source_get_info(context, tool_id, source_index, name, name_len, desc, desc_len, ordering, ticks_per_second, max_ticks, info)

$(_doc_external(:QMPI_T_source_get_info))
"""
function QMPI_T_source_get_info(context, tool_id, source_index, name, name_len, desc, desc_len, ordering, ticks_per_second, max_ticks, info)
    @mpichk ccall((:QMPI_T_source_get_info, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cchar}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}, Ptr{MPI_T_source_order}, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Info}), context, tool_id, source_index, name, name_len, desc, desc_len, ordering, ticks_per_second, max_ticks, info)
end

"""
    QMPI_T_source_get_num(context, tool_id, num_sources)

$(_doc_external(:QMPI_T_source_get_num))
"""
function QMPI_T_source_get_num(context, tool_id, num_sources)
    @mpichk ccall((:QMPI_T_source_get_num, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cint}), context, tool_id, num_sources)
end

"""
    QMPI_T_source_get_timestamp(context, tool_id, source_index, timestamp)

$(_doc_external(:QMPI_T_source_get_timestamp))
"""
function QMPI_T_source_get_timestamp(context, tool_id, source_index, timestamp)
    @mpichk ccall((:QMPI_T_source_get_timestamp, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{MPI_Count}), context, tool_id, source_index, timestamp)
end

"""
    QMPI_Op_commutative(context, tool_id, op, commute)

$(_doc_external(:QMPI_Op_commutative))
"""
function QMPI_Op_commutative(context, tool_id, op, commute)
    @mpichk ccall((:QMPI_Op_commutative, libmpi), Cint, (QMPI_Context, Cint, MPI_Op, Ptr{Cint}), context, tool_id, op, commute)
end

"""
    QMPI_Op_create(context, tool_id, user_fn, commute, op)

$(_doc_external(:QMPI_Op_create))
"""
function QMPI_Op_create(context, tool_id, user_fn, commute, op)
    @mpichk ccall((:QMPI_Op_create, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, Ptr{MPI_Op}), context, tool_id, user_fn, commute, op)
end

"""
    QMPI_Op_create_c(context, tool_id, user_fn, commute, op)

$(_doc_external(:QMPI_Op_create_c))
"""
function QMPI_Op_create_c(context, tool_id, user_fn, commute, op)
    @mpichk ccall((:QMPI_Op_create_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, Ptr{MPI_Op}), context, tool_id, user_fn, commute, op)
end

"""
    QMPI_Op_free(context, tool_id, op)

$(_doc_external(:QMPI_Op_free))
"""
function QMPI_Op_free(context, tool_id, op)
    @mpichk ccall((:QMPI_Op_free, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Op}), context, tool_id, op)
end

"""
    QMPI_Parrived(context, tool_id, request, partition, flag)

$(_doc_external(:QMPI_Parrived))
"""
function QMPI_Parrived(context, tool_id, request, partition, flag)
    @mpichk ccall((:QMPI_Parrived, libmpi), Cint, (QMPI_Context, Cint, MPI_Request, Cint, Ptr{Cint}), context, tool_id, request, partition, flag)
end

"""
    QMPI_Pready(context, tool_id, partition, request)

$(_doc_external(:QMPI_Pready))
"""
function QMPI_Pready(context, tool_id, partition, request)
    @mpichk ccall((:QMPI_Pready, libmpi), Cint, (QMPI_Context, Cint, Cint, MPI_Request), context, tool_id, partition, request)
end

"""
    QMPI_Pready_list(context, tool_id, length, array_of_partitions, request)

$(_doc_external(:QMPI_Pready_list))
"""
function QMPI_Pready_list(context, tool_id, length, array_of_partitions, request)
    @mpichk ccall((:QMPI_Pready_list, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Cint}, MPI_Request), context, tool_id, length, array_of_partitions, request)
end

"""
    QMPI_Pready_range(context, tool_id, partition_low, partition_high, request)

$(_doc_external(:QMPI_Pready_range))
"""
function QMPI_Pready_range(context, tool_id, partition_low, partition_high, request)
    @mpichk ccall((:QMPI_Pready_range, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, MPI_Request), context, tool_id, partition_low, partition_high, request)
end

"""
    QMPI_Precv_init(context, tool_id, buf, partitions, count, datatype, dest, tag, comm, info, request)

$(_doc_external(:QMPI_Precv_init))
"""
function QMPI_Precv_init(context, tool_id, buf, partitions, count, datatype, dest, tag, comm, info, request)
    @mpichk ccall((:QMPI_Precv_init, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, buf, partitions, count, datatype, dest, tag, comm, info, request)
end

"""
    QMPI_Psend_init(context, tool_id, buf, partitions, count, datatype, dest, tag, comm, info, request)

$(_doc_external(:QMPI_Psend_init))
"""
function QMPI_Psend_init(context, tool_id, buf, partitions, count, datatype, dest, tag, comm, info, request)
    @mpichk ccall((:QMPI_Psend_init, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), context, tool_id, buf, partitions, count, datatype, dest, tag, comm, info, request)
end

"""
    QMPI_Bsend(context, tool_id, buf, count, datatype, dest, tag, comm)

$(_doc_external(:QMPI_Bsend))
"""
function QMPI_Bsend(context, tool_id, buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:QMPI_Bsend, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), context, tool_id, buf, count, datatype, dest, tag, comm)
end

"""
    QMPI_Bsend_c(context, tool_id, buf, count, datatype, dest, tag, comm)

$(_doc_external(:QMPI_Bsend_c))
"""
function QMPI_Bsend_c(context, tool_id, buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:QMPI_Bsend_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm), context, tool_id, buf, count, datatype, dest, tag, comm)
end

"""
    QMPI_Bsend_init(context, tool_id, buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:QMPI_Bsend_init))
"""
function QMPI_Bsend_init(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:QMPI_Bsend_init, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

"""
    QMPI_Bsend_init_c(context, tool_id, buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:QMPI_Bsend_init_c))
"""
function QMPI_Bsend_init_c(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:QMPI_Bsend_init_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

"""
    QMPI_Buffer_attach(context, tool_id, buffer, size)

$(_doc_external(:QMPI_Buffer_attach))
"""
function QMPI_Buffer_attach(context, tool_id, buffer, size)
    @mpichk ccall((:QMPI_Buffer_attach, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint), context, tool_id, buffer, size)
end

"""
    QMPI_Buffer_attach_c(context, tool_id, buffer, size)

$(_doc_external(:QMPI_Buffer_attach_c))
"""
function QMPI_Buffer_attach_c(context, tool_id, buffer, size)
    @mpichk ccall((:QMPI_Buffer_attach_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count), context, tool_id, buffer, size)
end

"""
    QMPI_Buffer_detach(context, tool_id, buffer_addr, size)

$(_doc_external(:QMPI_Buffer_detach))
"""
function QMPI_Buffer_detach(context, tool_id, buffer_addr, size)
    @mpichk ccall((:QMPI_Buffer_detach, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{Cint}), context, tool_id, buffer_addr, size)
end

"""
    QMPI_Buffer_detach_c(context, tool_id, buffer_addr, size)

$(_doc_external(:QMPI_Buffer_detach_c))
"""
function QMPI_Buffer_detach_c(context, tool_id, buffer_addr, size)
    @mpichk ccall((:QMPI_Buffer_detach_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Ptr{MPI_Count}), context, tool_id, buffer_addr, size)
end

"""
    QMPI_Ibsend(context, tool_id, buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:QMPI_Ibsend))
"""
function QMPI_Ibsend(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:QMPI_Ibsend, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

"""
    QMPI_Ibsend_c(context, tool_id, buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:QMPI_Ibsend_c))
"""
function QMPI_Ibsend_c(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:QMPI_Ibsend_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

"""
    QMPI_Improbe(context, tool_id, source, tag, comm, flag, message, status)

$(_doc_external(:QMPI_Improbe))
"""
function QMPI_Improbe(context, tool_id, source, tag, comm, flag, message, status)
    @mpichk ccall((:QMPI_Improbe, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, MPI_Comm, Ptr{Cint}, Ptr{MPI_Message}, Ptr{MPI_Status}), context, tool_id, source, tag, comm, flag, message, status)
end

"""
    QMPI_Imrecv(context, tool_id, buf, count, datatype, message, request)

$(_doc_external(:QMPI_Imrecv))
"""
function QMPI_Imrecv(context, tool_id, buf, count, datatype, message, request)
    @mpichk ccall((:QMPI_Imrecv, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, message, request)
end

"""
    QMPI_Imrecv_c(context, tool_id, buf, count, datatype, message, request)

$(_doc_external(:QMPI_Imrecv_c))
"""
function QMPI_Imrecv_c(context, tool_id, buf, count, datatype, message, request)
    @mpichk ccall((:QMPI_Imrecv_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, message, request)
end

"""
    QMPI_Iprobe(context, tool_id, source, tag, comm, flag, status)

$(_doc_external(:QMPI_Iprobe))
"""
function QMPI_Iprobe(context, tool_id, source, tag, comm, flag, status)
    @mpichk ccall((:QMPI_Iprobe, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, MPI_Comm, Ptr{Cint}, Ptr{MPI_Status}), context, tool_id, source, tag, comm, flag, status)
end

"""
    QMPI_Irecv(context, tool_id, buf, count, datatype, source, tag, comm, request)

$(_doc_external(:QMPI_Irecv))
"""
function QMPI_Irecv(context, tool_id, buf, count, datatype, source, tag, comm, request)
    @mpichk ccall((:QMPI_Irecv, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, source, tag, comm, request)
end

"""
    QMPI_Irecv_c(context, tool_id, buf, count, datatype, source, tag, comm, request)

$(_doc_external(:QMPI_Irecv_c))
"""
function QMPI_Irecv_c(context, tool_id, buf, count, datatype, source, tag, comm, request)
    @mpichk ccall((:QMPI_Irecv_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, source, tag, comm, request)
end

"""
    QMPI_Irsend(context, tool_id, buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:QMPI_Irsend))
"""
function QMPI_Irsend(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:QMPI_Irsend, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

"""
    QMPI_Irsend_c(context, tool_id, buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:QMPI_Irsend_c))
"""
function QMPI_Irsend_c(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:QMPI_Irsend_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

"""
    QMPI_Isend(context, tool_id, buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:QMPI_Isend))
"""
function QMPI_Isend(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:QMPI_Isend, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

"""
    QMPI_Isend_c(context, tool_id, buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:QMPI_Isend_c))
"""
function QMPI_Isend_c(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:QMPI_Isend_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

"""
    QMPI_Isendrecv(context, tool_id, sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)

$(_doc_external(:QMPI_Isendrecv))
"""
function QMPI_Isendrecv(context, tool_id, sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
    @mpichk ccall((:QMPI_Isendrecv, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
end

"""
    QMPI_Isendrecv_c(context, tool_id, sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)

$(_doc_external(:QMPI_Isendrecv_c))
"""
function QMPI_Isendrecv_c(context, tool_id, sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
    @mpichk ccall((:QMPI_Isendrecv_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
end

"""
    QMPI_Isendrecv_replace(context, tool_id, buf, count, datatype, dest, sendtag, source, recvtag, comm, request)

$(_doc_external(:QMPI_Isendrecv_replace))
"""
function QMPI_Isendrecv_replace(context, tool_id, buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
    @mpichk ccall((:QMPI_Isendrecv_replace, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
end

"""
    QMPI_Isendrecv_replace_c(context, tool_id, buf, count, datatype, dest, sendtag, source, recvtag, comm, request)

$(_doc_external(:QMPI_Isendrecv_replace_c))
"""
function QMPI_Isendrecv_replace_c(context, tool_id, buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
    @mpichk ccall((:QMPI_Isendrecv_replace_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
end

"""
    QMPI_Issend(context, tool_id, buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:QMPI_Issend))
"""
function QMPI_Issend(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:QMPI_Issend, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

"""
    QMPI_Issend_c(context, tool_id, buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:QMPI_Issend_c))
"""
function QMPI_Issend_c(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:QMPI_Issend_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

"""
    QMPI_Mprobe(context, tool_id, source, tag, comm, message, status)

$(_doc_external(:QMPI_Mprobe))
"""
function QMPI_Mprobe(context, tool_id, source, tag, comm, message, status)
    @mpichk ccall((:QMPI_Mprobe, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Message}, Ptr{MPI_Status}), context, tool_id, source, tag, comm, message, status)
end

"""
    QMPI_Mrecv(context, tool_id, buf, count, datatype, message, status)

$(_doc_external(:QMPI_Mrecv))
"""
function QMPI_Mrecv(context, tool_id, buf, count, datatype, message, status)
    @mpichk ccall((:QMPI_Mrecv, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Status}), context, tool_id, buf, count, datatype, message, status)
end

"""
    QMPI_Mrecv_c(context, tool_id, buf, count, datatype, message, status)

$(_doc_external(:QMPI_Mrecv_c))
"""
function QMPI_Mrecv_c(context, tool_id, buf, count, datatype, message, status)
    @mpichk ccall((:QMPI_Mrecv_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Status}), context, tool_id, buf, count, datatype, message, status)
end

"""
    QMPI_Probe(context, tool_id, source, tag, comm, status)

$(_doc_external(:QMPI_Probe))
"""
function QMPI_Probe(context, tool_id, source, tag, comm, status)
    @mpichk ccall((:QMPI_Probe, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), context, tool_id, source, tag, comm, status)
end

"""
    QMPI_Recv(context, tool_id, buf, count, datatype, source, tag, comm, status)

$(_doc_external(:QMPI_Recv))
"""
function QMPI_Recv(context, tool_id, buf, count, datatype, source, tag, comm, status)
    @mpichk ccall((:QMPI_Recv, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), context, tool_id, buf, count, datatype, source, tag, comm, status)
end

"""
    QMPI_Recv_c(context, tool_id, buf, count, datatype, source, tag, comm, status)

$(_doc_external(:QMPI_Recv_c))
"""
function QMPI_Recv_c(context, tool_id, buf, count, datatype, source, tag, comm, status)
    @mpichk ccall((:QMPI_Recv_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), context, tool_id, buf, count, datatype, source, tag, comm, status)
end

"""
    QMPI_Recv_init(context, tool_id, buf, count, datatype, source, tag, comm, request)

$(_doc_external(:QMPI_Recv_init))
"""
function QMPI_Recv_init(context, tool_id, buf, count, datatype, source, tag, comm, request)
    @mpichk ccall((:QMPI_Recv_init, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, source, tag, comm, request)
end

"""
    QMPI_Recv_init_c(context, tool_id, buf, count, datatype, source, tag, comm, request)

$(_doc_external(:QMPI_Recv_init_c))
"""
function QMPI_Recv_init_c(context, tool_id, buf, count, datatype, source, tag, comm, request)
    @mpichk ccall((:QMPI_Recv_init_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, source, tag, comm, request)
end

"""
    QMPI_Rsend(context, tool_id, buf, count, datatype, dest, tag, comm)

$(_doc_external(:QMPI_Rsend))
"""
function QMPI_Rsend(context, tool_id, buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:QMPI_Rsend, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), context, tool_id, buf, count, datatype, dest, tag, comm)
end

"""
    QMPI_Rsend_c(context, tool_id, buf, count, datatype, dest, tag, comm)

$(_doc_external(:QMPI_Rsend_c))
"""
function QMPI_Rsend_c(context, tool_id, buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:QMPI_Rsend_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm), context, tool_id, buf, count, datatype, dest, tag, comm)
end

"""
    QMPI_Rsend_init(context, tool_id, buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:QMPI_Rsend_init))
"""
function QMPI_Rsend_init(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:QMPI_Rsend_init, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

"""
    QMPI_Rsend_init_c(context, tool_id, buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:QMPI_Rsend_init_c))
"""
function QMPI_Rsend_init_c(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:QMPI_Rsend_init_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

"""
    QMPI_Send(context, tool_id, buf, count, datatype, dest, tag, comm)

$(_doc_external(:QMPI_Send))
"""
function QMPI_Send(context, tool_id, buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:QMPI_Send, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), context, tool_id, buf, count, datatype, dest, tag, comm)
end

"""
    QMPI_Send_c(context, tool_id, buf, count, datatype, dest, tag, comm)

$(_doc_external(:QMPI_Send_c))
"""
function QMPI_Send_c(context, tool_id, buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:QMPI_Send_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm), context, tool_id, buf, count, datatype, dest, tag, comm)
end

"""
    QMPI_Send_init(context, tool_id, buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:QMPI_Send_init))
"""
function QMPI_Send_init(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:QMPI_Send_init, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

"""
    QMPI_Send_init_c(context, tool_id, buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:QMPI_Send_init_c))
"""
function QMPI_Send_init_c(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:QMPI_Send_init_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

"""
    QMPI_Sendrecv(context, tool_id, sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)

$(_doc_external(:QMPI_Sendrecv))
"""
function QMPI_Sendrecv(context, tool_id, sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
    @mpichk ccall((:QMPI_Sendrecv, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), context, tool_id, sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
end

"""
    QMPI_Sendrecv_c(context, tool_id, sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)

$(_doc_external(:QMPI_Sendrecv_c))
"""
function QMPI_Sendrecv_c(context, tool_id, sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
    @mpichk ccall((:QMPI_Sendrecv_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), context, tool_id, sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
end

"""
    QMPI_Sendrecv_replace(context, tool_id, buf, count, datatype, dest, sendtag, source, recvtag, comm, status)

$(_doc_external(:QMPI_Sendrecv_replace))
"""
function QMPI_Sendrecv_replace(context, tool_id, buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
    @mpichk ccall((:QMPI_Sendrecv_replace, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), context, tool_id, buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
end

"""
    QMPI_Sendrecv_replace_c(context, tool_id, buf, count, datatype, dest, sendtag, source, recvtag, comm, status)

$(_doc_external(:QMPI_Sendrecv_replace_c))
"""
function QMPI_Sendrecv_replace_c(context, tool_id, buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
    @mpichk ccall((:QMPI_Sendrecv_replace_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), context, tool_id, buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
end

"""
    QMPI_Ssend(context, tool_id, buf, count, datatype, dest, tag, comm)

$(_doc_external(:QMPI_Ssend))
"""
function QMPI_Ssend(context, tool_id, buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:QMPI_Ssend, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), context, tool_id, buf, count, datatype, dest, tag, comm)
end

"""
    QMPI_Ssend_c(context, tool_id, buf, count, datatype, dest, tag, comm)

$(_doc_external(:QMPI_Ssend_c))
"""
function QMPI_Ssend_c(context, tool_id, buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:QMPI_Ssend_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm), context, tool_id, buf, count, datatype, dest, tag, comm)
end

"""
    QMPI_Ssend_init(context, tool_id, buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:QMPI_Ssend_init))
"""
function QMPI_Ssend_init(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:QMPI_Ssend_init, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

"""
    QMPI_Ssend_init_c(context, tool_id, buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:QMPI_Ssend_init_c))
"""
function QMPI_Ssend_init_c(context, tool_id, buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:QMPI_Ssend_init_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), context, tool_id, buf, count, datatype, dest, tag, comm, request)
end

"""
    QMPI_Cancel(context, tool_id, request)

$(_doc_external(:QMPI_Cancel))
"""
function QMPI_Cancel(context, tool_id, request)
    @mpichk ccall((:QMPI_Cancel, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Request}), context, tool_id, request)
end

"""
    QMPI_Grequest_complete(context, tool_id, request)

$(_doc_external(:QMPI_Grequest_complete))
"""
function QMPI_Grequest_complete(context, tool_id, request)
    @mpichk ccall((:QMPI_Grequest_complete, libmpi), Cint, (QMPI_Context, Cint, MPI_Request), context, tool_id, request)
end

"""
    QMPI_Grequest_start(context, tool_id, query_fn, free_fn, cancel_fn, extra_state, request)

$(_doc_external(:QMPI_Grequest_start))
"""
function QMPI_Grequest_start(context, tool_id, query_fn, free_fn, cancel_fn, extra_state, request)
    @mpichk ccall((:QMPI_Grequest_start, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, MPIPtr, MPIPtr, Ptr{MPI_Request}), context, tool_id, query_fn, free_fn, cancel_fn, extra_state, request)
end

"""
    QMPI_Request_free(context, tool_id, request)

$(_doc_external(:QMPI_Request_free))
"""
function QMPI_Request_free(context, tool_id, request)
    @mpichk ccall((:QMPI_Request_free, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Request}), context, tool_id, request)
end

"""
    QMPI_Request_get_status(context, tool_id, request, flag, status)

$(_doc_external(:QMPI_Request_get_status))
"""
function QMPI_Request_get_status(context, tool_id, request, flag, status)
    @mpichk ccall((:QMPI_Request_get_status, libmpi), Cint, (QMPI_Context, Cint, MPI_Request, Ptr{Cint}, Ptr{MPI_Status}), context, tool_id, request, flag, status)
end

"""
    QMPI_Start(context, tool_id, request)

$(_doc_external(:QMPI_Start))
"""
function QMPI_Start(context, tool_id, request)
    @mpichk ccall((:QMPI_Start, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Request}), context, tool_id, request)
end

"""
    QMPI_Startall(context, tool_id, count, array_of_requests)

$(_doc_external(:QMPI_Startall))
"""
function QMPI_Startall(context, tool_id, count, array_of_requests)
    @mpichk ccall((:QMPI_Startall, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{MPI_Request}), context, tool_id, count, array_of_requests)
end

"""
    QMPI_Status_set_cancelled(context, tool_id, status, flag)

$(_doc_external(:QMPI_Status_set_cancelled))
"""
function QMPI_Status_set_cancelled(context, tool_id, status, flag)
    @mpichk ccall((:QMPI_Status_set_cancelled, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Status}, Cint), context, tool_id, status, flag)
end

"""
    QMPI_Test(context, tool_id, request, flag, status)

$(_doc_external(:QMPI_Test))
"""
function QMPI_Test(context, tool_id, request, flag, status)
    @mpichk ccall((:QMPI_Test, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{MPI_Status}), context, tool_id, request, flag, status)
end

"""
    QMPI_Test_cancelled(context, tool_id, status, flag)

$(_doc_external(:QMPI_Test_cancelled))
"""
function QMPI_Test_cancelled(context, tool_id, status, flag)
    @mpichk ccall((:QMPI_Test_cancelled, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Status}, Ptr{Cint}), context, tool_id, status, flag)
end

"""
    QMPI_Testall(context, tool_id, count, array_of_requests, flag, array_of_statuses)

$(_doc_external(:QMPI_Testall))
"""
function QMPI_Testall(context, tool_id, count, array_of_requests, flag, array_of_statuses)
    @mpichk ccall((:QMPI_Testall, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{MPI_Status}), context, tool_id, count, array_of_requests, flag, array_of_statuses)
end

"""
    QMPI_Testany(context, tool_id, count, array_of_requests, indx, flag, status)

$(_doc_external(:QMPI_Testany))
"""
function QMPI_Testany(context, tool_id, count, array_of_requests, indx, flag, status)
    @mpichk ccall((:QMPI_Testany, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Status}), context, tool_id, count, array_of_requests, indx, flag, status)
end

"""
    QMPI_Testsome(context, tool_id, incount, array_of_requests, outcount, array_of_indices, array_of_statuses)

$(_doc_external(:QMPI_Testsome))
"""
function QMPI_Testsome(context, tool_id, incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
    @mpichk ccall((:QMPI_Testsome, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Status}), context, tool_id, incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
end

"""
    QMPI_Wait(context, tool_id, request, status)

$(_doc_external(:QMPI_Wait))
"""
function QMPI_Wait(context, tool_id, request, status)
    @mpichk ccall((:QMPI_Wait, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Request}, Ptr{MPI_Status}), context, tool_id, request, status)
end

"""
    QMPI_Waitall(context, tool_id, count, array_of_requests, array_of_statuses)

$(_doc_external(:QMPI_Waitall))
"""
function QMPI_Waitall(context, tool_id, count, array_of_requests, array_of_statuses)
    @mpichk ccall((:QMPI_Waitall, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{MPI_Request}, Ptr{MPI_Status}), context, tool_id, count, array_of_requests, array_of_statuses)
end

"""
    QMPI_Waitany(context, tool_id, count, array_of_requests, indx, status)

$(_doc_external(:QMPI_Waitany))
"""
function QMPI_Waitany(context, tool_id, count, array_of_requests, indx, status)
    @mpichk ccall((:QMPI_Waitany, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{MPI_Status}), context, tool_id, count, array_of_requests, indx, status)
end

"""
    QMPI_Waitsome(context, tool_id, incount, array_of_requests, outcount, array_of_indices, array_of_statuses)

$(_doc_external(:QMPI_Waitsome))
"""
function QMPI_Waitsome(context, tool_id, incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
    @mpichk ccall((:QMPI_Waitsome, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Status}), context, tool_id, incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
end

"""
    QMPIX_Grequest_start(context, tool_id, query_fn, free_fn, cancel_fn, poll_fn, wait_fn, extra_state, request)

$(_doc_external(:QMPIX_Grequest_start))
"""
function QMPIX_Grequest_start(context, tool_id, query_fn, free_fn, cancel_fn, poll_fn, wait_fn, extra_state, request)
    @mpichk ccall((:QMPIX_Grequest_start, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, MPIPtr, MPIPtr, MPIPtr, MPIPtr, Ptr{MPI_Request}), context, tool_id, query_fn, free_fn, cancel_fn, poll_fn, wait_fn, extra_state, request)
end

"""
    QMPIX_Grequest_class_create(context, tool_id, query_fn, free_fn, cancel_fn, poll_fn, wait_fn, greq_class)

$(_doc_external(:QMPIX_Grequest_class_create))
"""
function QMPIX_Grequest_class_create(context, tool_id, query_fn, free_fn, cancel_fn, poll_fn, wait_fn, greq_class)
    @mpichk ccall((:QMPIX_Grequest_class_create, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, MPIPtr, MPIPtr, MPIPtr, Ptr{MPIX_Grequest_class}), context, tool_id, query_fn, free_fn, cancel_fn, poll_fn, wait_fn, greq_class)
end

"""
    QMPIX_Grequest_class_allocate(context, tool_id, greq_class, extra_state, request)

$(_doc_external(:QMPIX_Grequest_class_allocate))
"""
function QMPIX_Grequest_class_allocate(context, tool_id, greq_class, extra_state, request)
    @mpichk ccall((:QMPIX_Grequest_class_allocate, libmpi), Cint, (QMPI_Context, Cint, MPIX_Grequest_class, MPIPtr, Ptr{MPI_Request}), context, tool_id, greq_class, extra_state, request)
end

"""
    QMPI_Accumulate(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)

$(_doc_external(:QMPI_Accumulate))
"""
function QMPI_Accumulate(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    @mpichk ccall((:QMPI_Accumulate, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win), context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

"""
    QMPI_Accumulate_c(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)

$(_doc_external(:QMPI_Accumulate_c))
"""
function QMPI_Accumulate_c(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    @mpichk ccall((:QMPI_Accumulate_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Op, MPI_Win), context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

"""
    QMPI_Alloc_mem(context, tool_id, size, info, baseptr)

$(_doc_external(:QMPI_Alloc_mem))
"""
function QMPI_Alloc_mem(context, tool_id, size, info, baseptr)
    @mpichk ccall((:QMPI_Alloc_mem, libmpi), Cint, (QMPI_Context, Cint, MPI_Aint, MPI_Info, MPIPtr), context, tool_id, size, info, baseptr)
end

"""
    QMPI_Compare_and_swap(context, tool_id, origin_addr, compare_addr, result_addr, datatype, target_rank, target_disp, win)

$(_doc_external(:QMPI_Compare_and_swap))
"""
function QMPI_Compare_and_swap(context, tool_id, origin_addr, compare_addr, result_addr, datatype, target_rank, target_disp, win)
    @mpichk ccall((:QMPI_Compare_and_swap, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, MPIPtr, MPI_Datatype, Cint, MPI_Aint, MPI_Win), context, tool_id, origin_addr, compare_addr, result_addr, datatype, target_rank, target_disp, win)
end

"""
    QMPI_Fetch_and_op(context, tool_id, origin_addr, result_addr, datatype, target_rank, target_disp, op, win)

$(_doc_external(:QMPI_Fetch_and_op))
"""
function QMPI_Fetch_and_op(context, tool_id, origin_addr, result_addr, datatype, target_rank, target_disp, op, win)
    @mpichk ccall((:QMPI_Fetch_and_op, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPIPtr, MPI_Datatype, Cint, MPI_Aint, MPI_Op, MPI_Win), context, tool_id, origin_addr, result_addr, datatype, target_rank, target_disp, op, win)
end

"""
    QMPI_Free_mem(context, tool_id, base)

$(_doc_external(:QMPI_Free_mem))
"""
function QMPI_Free_mem(context, tool_id, base)
    @mpichk ccall((:QMPI_Free_mem, libmpi), Cint, (QMPI_Context, Cint, MPIPtr), context, tool_id, base)
end

"""
    QMPI_Get(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)

$(_doc_external(:QMPI_Get))
"""
function QMPI_Get(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    @mpichk ccall((:QMPI_Get, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win), context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

"""
    QMPI_Get_c(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)

$(_doc_external(:QMPI_Get_c))
"""
function QMPI_Get_c(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    @mpichk ccall((:QMPI_Get_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Win), context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

"""
    QMPI_Get_accumulate(context, tool_id, origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)

$(_doc_external(:QMPI_Get_accumulate))
"""
function QMPI_Get_accumulate(context, tool_id, origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    @mpichk ccall((:QMPI_Get_accumulate, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win), context, tool_id, origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

"""
    QMPI_Get_accumulate_c(context, tool_id, origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)

$(_doc_external(:QMPI_Get_accumulate_c))
"""
function QMPI_Get_accumulate_c(context, tool_id, origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    @mpichk ccall((:QMPI_Get_accumulate_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Op, MPI_Win), context, tool_id, origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

"""
    QMPI_Put(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)

$(_doc_external(:QMPI_Put))
"""
function QMPI_Put(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    @mpichk ccall((:QMPI_Put, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win), context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

"""
    QMPI_Put_c(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)

$(_doc_external(:QMPI_Put_c))
"""
function QMPI_Put_c(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    @mpichk ccall((:QMPI_Put_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Win), context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

"""
    QMPI_Raccumulate(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)

$(_doc_external(:QMPI_Raccumulate))
"""
function QMPI_Raccumulate(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    @mpichk ccall((:QMPI_Raccumulate, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

"""
    QMPI_Raccumulate_c(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)

$(_doc_external(:QMPI_Raccumulate_c))
"""
function QMPI_Raccumulate_c(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    @mpichk ccall((:QMPI_Raccumulate_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

"""
    QMPI_Rget(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)

$(_doc_external(:QMPI_Rget))
"""
function QMPI_Rget(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    @mpichk ccall((:QMPI_Rget, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

"""
    QMPI_Rget_c(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)

$(_doc_external(:QMPI_Rget_c))
"""
function QMPI_Rget_c(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    @mpichk ccall((:QMPI_Rget_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

"""
    QMPI_Rget_accumulate(context, tool_id, origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)

$(_doc_external(:QMPI_Rget_accumulate))
"""
function QMPI_Rget_accumulate(context, tool_id, origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    @mpichk ccall((:QMPI_Rget_accumulate, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), context, tool_id, origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

"""
    QMPI_Rget_accumulate_c(context, tool_id, origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)

$(_doc_external(:QMPI_Rget_accumulate_c))
"""
function QMPI_Rget_accumulate_c(context, tool_id, origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    @mpichk ccall((:QMPI_Rget_accumulate_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), context, tool_id, origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

"""
    QMPI_Rput(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)

$(_doc_external(:QMPI_Rput))
"""
function QMPI_Rput(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    @mpichk ccall((:QMPI_Rput, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

"""
    QMPI_Rput_c(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)

$(_doc_external(:QMPI_Rput_c))
"""
function QMPI_Rput_c(context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    @mpichk ccall((:QMPI_Rput_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), context, tool_id, origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

"""
    QMPI_Win_allocate(context, tool_id, size, disp_unit, info, comm, baseptr, win)

$(_doc_external(:QMPI_Win_allocate))
"""
function QMPI_Win_allocate(context, tool_id, size, disp_unit, info, comm, baseptr, win)
    @mpichk ccall((:QMPI_Win_allocate, libmpi), Cint, (QMPI_Context, Cint, MPI_Aint, Cint, MPI_Info, MPI_Comm, MPIPtr, Ptr{MPI_Win}), context, tool_id, size, disp_unit, info, comm, baseptr, win)
end

"""
    QMPI_Win_allocate_c(context, tool_id, size, disp_unit, info, comm, baseptr, win)

$(_doc_external(:QMPI_Win_allocate_c))
"""
function QMPI_Win_allocate_c(context, tool_id, size, disp_unit, info, comm, baseptr, win)
    @mpichk ccall((:QMPI_Win_allocate_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Aint, MPI_Aint, MPI_Info, MPI_Comm, MPIPtr, Ptr{MPI_Win}), context, tool_id, size, disp_unit, info, comm, baseptr, win)
end

"""
    QMPI_Win_allocate_shared(context, tool_id, size, disp_unit, info, comm, baseptr, win)

$(_doc_external(:QMPI_Win_allocate_shared))
"""
function QMPI_Win_allocate_shared(context, tool_id, size, disp_unit, info, comm, baseptr, win)
    @mpichk ccall((:QMPI_Win_allocate_shared, libmpi), Cint, (QMPI_Context, Cint, MPI_Aint, Cint, MPI_Info, MPI_Comm, MPIPtr, Ptr{MPI_Win}), context, tool_id, size, disp_unit, info, comm, baseptr, win)
end

"""
    QMPI_Win_allocate_shared_c(context, tool_id, size, disp_unit, info, comm, baseptr, win)

$(_doc_external(:QMPI_Win_allocate_shared_c))
"""
function QMPI_Win_allocate_shared_c(context, tool_id, size, disp_unit, info, comm, baseptr, win)
    @mpichk ccall((:QMPI_Win_allocate_shared_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Aint, MPI_Aint, MPI_Info, MPI_Comm, MPIPtr, Ptr{MPI_Win}), context, tool_id, size, disp_unit, info, comm, baseptr, win)
end

"""
    QMPI_Win_attach(context, tool_id, win, base, size)

$(_doc_external(:QMPI_Win_attach))
"""
function QMPI_Win_attach(context, tool_id, win, base, size)
    @mpichk ccall((:QMPI_Win_attach, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, MPIPtr, MPI_Aint), context, tool_id, win, base, size)
end

"""
    QMPI_Win_complete(context, tool_id, win)

$(_doc_external(:QMPI_Win_complete))
"""
function QMPI_Win_complete(context, tool_id, win)
    @mpichk ccall((:QMPI_Win_complete, libmpi), Cint, (QMPI_Context, Cint, MPI_Win), context, tool_id, win)
end

"""
    QMPI_Win_create(context, tool_id, base, size, disp_unit, info, comm, win)

$(_doc_external(:QMPI_Win_create))
"""
function QMPI_Win_create(context, tool_id, base, size, disp_unit, info, comm, win)
    @mpichk ccall((:QMPI_Win_create, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Aint, Cint, MPI_Info, MPI_Comm, Ptr{MPI_Win}), context, tool_id, base, size, disp_unit, info, comm, win)
end

"""
    QMPI_Win_create_c(context, tool_id, base, size, disp_unit, info, comm, win)

$(_doc_external(:QMPI_Win_create_c))
"""
function QMPI_Win_create_c(context, tool_id, base, size, disp_unit, info, comm, win)
    @mpichk ccall((:QMPI_Win_create_c, libmpi), Cint, (QMPI_Context, Cint, MPIPtr, MPI_Aint, MPI_Aint, MPI_Info, MPI_Comm, Ptr{MPI_Win}), context, tool_id, base, size, disp_unit, info, comm, win)
end

"""
    QMPI_Win_create_dynamic(context, tool_id, info, comm, win)

$(_doc_external(:QMPI_Win_create_dynamic))
"""
function QMPI_Win_create_dynamic(context, tool_id, info, comm, win)
    @mpichk ccall((:QMPI_Win_create_dynamic, libmpi), Cint, (QMPI_Context, Cint, MPI_Info, MPI_Comm, Ptr{MPI_Win}), context, tool_id, info, comm, win)
end

"""
    QMPI_Win_detach(context, tool_id, win, base)

$(_doc_external(:QMPI_Win_detach))
"""
function QMPI_Win_detach(context, tool_id, win, base)
    @mpichk ccall((:QMPI_Win_detach, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, MPIPtr), context, tool_id, win, base)
end

"""
    QMPI_Win_fence(context, tool_id, assert, win)

$(_doc_external(:QMPI_Win_fence))
"""
function QMPI_Win_fence(context, tool_id, assert, win)
    @mpichk ccall((:QMPI_Win_fence, libmpi), Cint, (QMPI_Context, Cint, Cint, MPI_Win), context, tool_id, assert, win)
end

"""
    QMPI_Win_flush(context, tool_id, rank, win)

$(_doc_external(:QMPI_Win_flush))
"""
function QMPI_Win_flush(context, tool_id, rank, win)
    @mpichk ccall((:QMPI_Win_flush, libmpi), Cint, (QMPI_Context, Cint, Cint, MPI_Win), context, tool_id, rank, win)
end

"""
    QMPI_Win_flush_all(context, tool_id, win)

$(_doc_external(:QMPI_Win_flush_all))
"""
function QMPI_Win_flush_all(context, tool_id, win)
    @mpichk ccall((:QMPI_Win_flush_all, libmpi), Cint, (QMPI_Context, Cint, MPI_Win), context, tool_id, win)
end

"""
    QMPI_Win_flush_local(context, tool_id, rank, win)

$(_doc_external(:QMPI_Win_flush_local))
"""
function QMPI_Win_flush_local(context, tool_id, rank, win)
    @mpichk ccall((:QMPI_Win_flush_local, libmpi), Cint, (QMPI_Context, Cint, Cint, MPI_Win), context, tool_id, rank, win)
end

"""
    QMPI_Win_flush_local_all(context, tool_id, win)

$(_doc_external(:QMPI_Win_flush_local_all))
"""
function QMPI_Win_flush_local_all(context, tool_id, win)
    @mpichk ccall((:QMPI_Win_flush_local_all, libmpi), Cint, (QMPI_Context, Cint, MPI_Win), context, tool_id, win)
end

"""
    QMPI_Win_free(context, tool_id, win)

$(_doc_external(:QMPI_Win_free))
"""
function QMPI_Win_free(context, tool_id, win)
    @mpichk ccall((:QMPI_Win_free, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Win}), context, tool_id, win)
end

"""
    QMPI_Win_get_group(context, tool_id, win, group)

$(_doc_external(:QMPI_Win_get_group))
"""
function QMPI_Win_get_group(context, tool_id, win, group)
    @mpichk ccall((:QMPI_Win_get_group, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, Ptr{MPI_Group}), context, tool_id, win, group)
end

"""
    QMPI_Win_get_info(context, tool_id, win, info_used)

$(_doc_external(:QMPI_Win_get_info))
"""
function QMPI_Win_get_info(context, tool_id, win, info_used)
    @mpichk ccall((:QMPI_Win_get_info, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, Ptr{MPI_Info}), context, tool_id, win, info_used)
end

"""
    QMPI_Win_get_name(context, tool_id, win, win_name, resultlen)

$(_doc_external(:QMPI_Win_get_name))
"""
function QMPI_Win_get_name(context, tool_id, win, win_name, resultlen)
    @mpichk ccall((:QMPI_Win_get_name, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, Ptr{Cchar}, Ptr{Cint}), context, tool_id, win, win_name, resultlen)
end

"""
    QMPI_Win_lock(context, tool_id, lock_type, rank, assert, win)

$(_doc_external(:QMPI_Win_lock))
"""
function QMPI_Win_lock(context, tool_id, lock_type, rank, assert, win)
    @mpichk ccall((:QMPI_Win_lock, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, Cint, MPI_Win), context, tool_id, lock_type, rank, assert, win)
end

"""
    QMPI_Win_lock_all(context, tool_id, assert, win)

$(_doc_external(:QMPI_Win_lock_all))
"""
function QMPI_Win_lock_all(context, tool_id, assert, win)
    @mpichk ccall((:QMPI_Win_lock_all, libmpi), Cint, (QMPI_Context, Cint, Cint, MPI_Win), context, tool_id, assert, win)
end

"""
    QMPI_Win_post(context, tool_id, group, assert, win)

$(_doc_external(:QMPI_Win_post))
"""
function QMPI_Win_post(context, tool_id, group, assert, win)
    @mpichk ccall((:QMPI_Win_post, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, Cint, MPI_Win), context, tool_id, group, assert, win)
end

"""
    QMPI_Win_set_info(context, tool_id, win, info)

$(_doc_external(:QMPI_Win_set_info))
"""
function QMPI_Win_set_info(context, tool_id, win, info)
    @mpichk ccall((:QMPI_Win_set_info, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, MPI_Info), context, tool_id, win, info)
end

"""
    QMPI_Win_set_name(context, tool_id, win, win_name)

$(_doc_external(:QMPI_Win_set_name))
"""
function QMPI_Win_set_name(context, tool_id, win, win_name)
    @mpichk ccall((:QMPI_Win_set_name, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, Ptr{Cchar}), context, tool_id, win, win_name)
end

"""
    QMPI_Win_shared_query(context, tool_id, win, rank, size, disp_unit, baseptr)

$(_doc_external(:QMPI_Win_shared_query))
"""
function QMPI_Win_shared_query(context, tool_id, win, rank, size, disp_unit, baseptr)
    @mpichk ccall((:QMPI_Win_shared_query, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, Cint, Ptr{MPI_Aint}, Ptr{Cint}, MPIPtr), context, tool_id, win, rank, size, disp_unit, baseptr)
end

"""
    QMPI_Win_shared_query_c(context, tool_id, win, rank, size, disp_unit, baseptr)

$(_doc_external(:QMPI_Win_shared_query_c))
"""
function QMPI_Win_shared_query_c(context, tool_id, win, rank, size, disp_unit, baseptr)
    @mpichk ccall((:QMPI_Win_shared_query_c, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, Cint, Ptr{MPI_Aint}, Ptr{MPI_Aint}, MPIPtr), context, tool_id, win, rank, size, disp_unit, baseptr)
end

"""
    QMPI_Win_start(context, tool_id, group, assert, win)

$(_doc_external(:QMPI_Win_start))
"""
function QMPI_Win_start(context, tool_id, group, assert, win)
    @mpichk ccall((:QMPI_Win_start, libmpi), Cint, (QMPI_Context, Cint, MPI_Group, Cint, MPI_Win), context, tool_id, group, assert, win)
end

"""
    QMPI_Win_sync(context, tool_id, win)

$(_doc_external(:QMPI_Win_sync))
"""
function QMPI_Win_sync(context, tool_id, win)
    @mpichk ccall((:QMPI_Win_sync, libmpi), Cint, (QMPI_Context, Cint, MPI_Win), context, tool_id, win)
end

"""
    QMPI_Win_test(context, tool_id, win, flag)

$(_doc_external(:QMPI_Win_test))
"""
function QMPI_Win_test(context, tool_id, win, flag)
    @mpichk ccall((:QMPI_Win_test, libmpi), Cint, (QMPI_Context, Cint, MPI_Win, Ptr{Cint}), context, tool_id, win, flag)
end

"""
    QMPI_Win_unlock(context, tool_id, rank, win)

$(_doc_external(:QMPI_Win_unlock))
"""
function QMPI_Win_unlock(context, tool_id, rank, win)
    @mpichk ccall((:QMPI_Win_unlock, libmpi), Cint, (QMPI_Context, Cint, Cint, MPI_Win), context, tool_id, rank, win)
end

"""
    QMPI_Win_unlock_all(context, tool_id, win)

$(_doc_external(:QMPI_Win_unlock_all))
"""
function QMPI_Win_unlock_all(context, tool_id, win)
    @mpichk ccall((:QMPI_Win_unlock_all, libmpi), Cint, (QMPI_Context, Cint, MPI_Win), context, tool_id, win)
end

"""
    QMPI_Win_wait(context, tool_id, win)

$(_doc_external(:QMPI_Win_wait))
"""
function QMPI_Win_wait(context, tool_id, win)
    @mpichk ccall((:QMPI_Win_wait, libmpi), Cint, (QMPI_Context, Cint, MPI_Win), context, tool_id, win)
end

"""
    QMPI_Close_port(context, tool_id, port_name)

$(_doc_external(:QMPI_Close_port))
"""
function QMPI_Close_port(context, tool_id, port_name)
    @mpichk ccall((:QMPI_Close_port, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}), context, tool_id, port_name)
end

"""
    QMPI_Comm_accept(context, tool_id, port_name, info, root, comm, newcomm)

$(_doc_external(:QMPI_Comm_accept))
"""
function QMPI_Comm_accept(context, tool_id, port_name, info, root, comm, newcomm)
    @mpichk ccall((:QMPI_Comm_accept, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, MPI_Info, Cint, MPI_Comm, Ptr{MPI_Comm}), context, tool_id, port_name, info, root, comm, newcomm)
end

"""
    QMPI_Comm_connect(context, tool_id, port_name, info, root, comm, newcomm)

$(_doc_external(:QMPI_Comm_connect))
"""
function QMPI_Comm_connect(context, tool_id, port_name, info, root, comm, newcomm)
    @mpichk ccall((:QMPI_Comm_connect, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, MPI_Info, Cint, MPI_Comm, Ptr{MPI_Comm}), context, tool_id, port_name, info, root, comm, newcomm)
end

"""
    QMPI_Comm_disconnect(context, tool_id, comm)

$(_doc_external(:QMPI_Comm_disconnect))
"""
function QMPI_Comm_disconnect(context, tool_id, comm)
    @mpichk ccall((:QMPI_Comm_disconnect, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Comm}), context, tool_id, comm)
end

"""
    QMPI_Comm_get_parent(context, tool_id, parent)

$(_doc_external(:QMPI_Comm_get_parent))
"""
function QMPI_Comm_get_parent(context, tool_id, parent)
    @mpichk ccall((:QMPI_Comm_get_parent, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPI_Comm}), context, tool_id, parent)
end

"""
    QMPI_Comm_join(context, tool_id, fd, intercomm)

$(_doc_external(:QMPI_Comm_join))
"""
function QMPI_Comm_join(context, tool_id, fd, intercomm)
    @mpichk ccall((:QMPI_Comm_join, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{MPI_Comm}), context, tool_id, fd, intercomm)
end

"""
    QMPI_Comm_spawn(context, tool_id, command, argv, maxprocs, info, root, comm, intercomm, array_of_errcodes)

$(_doc_external(:QMPI_Comm_spawn))
"""
function QMPI_Comm_spawn(context, tool_id, command, argv, maxprocs, info, root, comm, intercomm, array_of_errcodes)
    @mpichk ccall((:QMPI_Comm_spawn, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, Ptr{Ptr{Cchar}}, Cint, MPI_Info, Cint, MPI_Comm, Ptr{MPI_Comm}, Ptr{Cint}), context, tool_id, command, argv, maxprocs, info, root, comm, intercomm, array_of_errcodes)
end

"""
    QMPI_Comm_spawn_multiple(context, tool_id, count, array_of_commands, array_of_argv, array_of_maxprocs, array_of_info, root, comm, intercomm, array_of_errcodes)

$(_doc_external(:QMPI_Comm_spawn_multiple))
"""
function QMPI_Comm_spawn_multiple(context, tool_id, count, array_of_commands, array_of_argv, array_of_maxprocs, array_of_info, root, comm, intercomm, array_of_errcodes)
    @mpichk ccall((:QMPI_Comm_spawn_multiple, libmpi), Cint, (QMPI_Context, Cint, Cint, Ptr{Ptr{Cchar}}, Ptr{Ptr{Ptr{Cchar}}}, Ptr{Cint}, Ptr{MPI_Info}, Cint, MPI_Comm, Ptr{MPI_Comm}, Ptr{Cint}), context, tool_id, count, array_of_commands, array_of_argv, array_of_maxprocs, array_of_info, root, comm, intercomm, array_of_errcodes)
end

"""
    QMPI_Lookup_name(context, tool_id, service_name, info, port_name)

$(_doc_external(:QMPI_Lookup_name))
"""
function QMPI_Lookup_name(context, tool_id, service_name, info, port_name)
    @mpichk ccall((:QMPI_Lookup_name, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, MPI_Info, Ptr{Cchar}), context, tool_id, service_name, info, port_name)
end

"""
    QMPI_Open_port(context, tool_id, info, port_name)

$(_doc_external(:QMPI_Open_port))
"""
function QMPI_Open_port(context, tool_id, info, port_name)
    @mpichk ccall((:QMPI_Open_port, libmpi), Cint, (QMPI_Context, Cint, MPI_Info, Ptr{Cchar}), context, tool_id, info, port_name)
end

"""
    QMPI_Publish_name(context, tool_id, service_name, info, port_name)

$(_doc_external(:QMPI_Publish_name))
"""
function QMPI_Publish_name(context, tool_id, service_name, info, port_name)
    @mpichk ccall((:QMPI_Publish_name, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, MPI_Info, Ptr{Cchar}), context, tool_id, service_name, info, port_name)
end

"""
    QMPI_Unpublish_name(context, tool_id, service_name, info, port_name)

$(_doc_external(:QMPI_Unpublish_name))
"""
function QMPI_Unpublish_name(context, tool_id, service_name, info, port_name)
    @mpichk ccall((:QMPI_Unpublish_name, libmpi), Cint, (QMPI_Context, Cint, Ptr{Cchar}, MPI_Info, Ptr{Cchar}), context, tool_id, service_name, info, port_name)
end

"""
    QMPI_Wtick(context, tool_id)

$(_doc_external(:QMPI_Wtick))
"""
function QMPI_Wtick(context, tool_id)
    @mpichk ccall((:QMPI_Wtick, libmpi), Cdouble, (QMPI_Context, Cint), context, tool_id)
end

"""
    QMPI_Wtime(context, tool_id)

$(_doc_external(:QMPI_Wtime))
"""
function QMPI_Wtime(context, tool_id)
    @mpichk ccall((:QMPI_Wtime, libmpi), Cdouble, (QMPI_Context, Cint), context, tool_id)
end

"""
    QMPI_Cart_coords(context, tool_id, comm, rank, maxdims, coords)

$(_doc_external(:QMPI_Cart_coords))
"""
function QMPI_Cart_coords(context, tool_id, comm, rank, maxdims, coords)
    @mpichk ccall((:QMPI_Cart_coords, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Cint, Ptr{Cint}), context, tool_id, comm, rank, maxdims, coords)
end

"""
    QMPI_Cart_create(context, tool_id, comm_old, ndims, dims, periods, reorder, comm_cart)

$(_doc_external(:QMPI_Cart_create))
"""
function QMPI_Cart_create(context, tool_id, comm_old, ndims, dims, periods, reorder, comm_cart)
    @mpichk ccall((:QMPI_Cart_create, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{MPI_Comm}), context, tool_id, comm_old, ndims, dims, periods, reorder, comm_cart)
end

"""
    QMPI_Cart_get(context, tool_id, comm, maxdims, dims, periods, coords)

$(_doc_external(:QMPI_Cart_get))
"""
function QMPI_Cart_get(context, tool_id, comm, maxdims, dims, periods, coords)
    @mpichk ccall((:QMPI_Cart_get, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), context, tool_id, comm, maxdims, dims, periods, coords)
end

"""
    QMPI_Cart_map(context, tool_id, comm, ndims, dims, periods, newrank)

$(_doc_external(:QMPI_Cart_map))
"""
function QMPI_Cart_map(context, tool_id, comm, ndims, dims, periods, newrank)
    @mpichk ccall((:QMPI_Cart_map, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), context, tool_id, comm, ndims, dims, periods, newrank)
end

"""
    QMPI_Cart_rank(context, tool_id, comm, coords, rank)

$(_doc_external(:QMPI_Cart_rank))
"""
function QMPI_Cart_rank(context, tool_id, comm, coords, rank)
    @mpichk ccall((:QMPI_Cart_rank, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{Cint}, Ptr{Cint}), context, tool_id, comm, coords, rank)
end

"""
    QMPI_Cart_shift(context, tool_id, comm, direction, disp, rank_source, rank_dest)

$(_doc_external(:QMPI_Cart_shift))
"""
function QMPI_Cart_shift(context, tool_id, comm, direction, disp, rank_source, rank_dest)
    @mpichk ccall((:QMPI_Cart_shift, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Cint, Ptr{Cint}, Ptr{Cint}), context, tool_id, comm, direction, disp, rank_source, rank_dest)
end

"""
    QMPI_Cart_sub(context, tool_id, comm, remain_dims, newcomm)

$(_doc_external(:QMPI_Cart_sub))
"""
function QMPI_Cart_sub(context, tool_id, comm, remain_dims, newcomm)
    @mpichk ccall((:QMPI_Cart_sub, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{Cint}, Ptr{MPI_Comm}), context, tool_id, comm, remain_dims, newcomm)
end

"""
    QMPI_Cartdim_get(context, tool_id, comm, ndims)

$(_doc_external(:QMPI_Cartdim_get))
"""
function QMPI_Cartdim_get(context, tool_id, comm, ndims)
    @mpichk ccall((:QMPI_Cartdim_get, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{Cint}), context, tool_id, comm, ndims)
end

"""
    QMPI_Dims_create(context, tool_id, nnodes, ndims, dims)

$(_doc_external(:QMPI_Dims_create))
"""
function QMPI_Dims_create(context, tool_id, nnodes, ndims, dims)
    @mpichk ccall((:QMPI_Dims_create, libmpi), Cint, (QMPI_Context, Cint, Cint, Cint, Ptr{Cint}), context, tool_id, nnodes, ndims, dims)
end

"""
    QMPI_Dist_graph_create(context, tool_id, comm_old, n, sources, degrees, destinations, weights, info, reorder, comm_dist_graph)

$(_doc_external(:QMPI_Dist_graph_create))
"""
function QMPI_Dist_graph_create(context, tool_id, comm_old, n, sources, degrees, destinations, weights, info, reorder, comm_dist_graph)
    @mpichk ccall((:QMPI_Dist_graph_create, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, MPI_Info, Cint, Ptr{MPI_Comm}), context, tool_id, comm_old, n, sources, degrees, destinations, weights, info, reorder, comm_dist_graph)
end

"""
    QMPI_Dist_graph_create_adjacent(context, tool_id, comm_old, indegree, sources, sourceweights, outdegree, destinations, destweights, info, reorder, comm_dist_graph)

$(_doc_external(:QMPI_Dist_graph_create_adjacent))
"""
function QMPI_Dist_graph_create_adjacent(context, tool_id, comm_old, indegree, sources, sourceweights, outdegree, destinations, destweights, info, reorder, comm_dist_graph)
    @mpichk ccall((:QMPI_Dist_graph_create_adjacent, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{Cint}, Ptr{Cint}, MPI_Info, Cint, Ptr{MPI_Comm}), context, tool_id, comm_old, indegree, sources, sourceweights, outdegree, destinations, destweights, info, reorder, comm_dist_graph)
end

"""
    QMPI_Dist_graph_neighbors(context, tool_id, comm, maxindegree, sources, sourceweights, maxoutdegree, destinations, destweights)

$(_doc_external(:QMPI_Dist_graph_neighbors))
"""
function QMPI_Dist_graph_neighbors(context, tool_id, comm, maxindegree, sources, sourceweights, maxoutdegree, destinations, destweights)
    @mpichk ccall((:QMPI_Dist_graph_neighbors, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{Cint}, Ptr{Cint}), context, tool_id, comm, maxindegree, sources, sourceweights, maxoutdegree, destinations, destweights)
end

"""
    QMPI_Dist_graph_neighbors_count(context, tool_id, comm, indegree, outdegree, weighted)

$(_doc_external(:QMPI_Dist_graph_neighbors_count))
"""
function QMPI_Dist_graph_neighbors_count(context, tool_id, comm, indegree, outdegree, weighted)
    @mpichk ccall((:QMPI_Dist_graph_neighbors_count, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), context, tool_id, comm, indegree, outdegree, weighted)
end

"""
    QMPI_Graph_create(context, tool_id, comm_old, nnodes, indx, edges, reorder, comm_graph)

$(_doc_external(:QMPI_Graph_create))
"""
function QMPI_Graph_create(context, tool_id, comm_old, nnodes, indx, edges, reorder, comm_graph)
    @mpichk ccall((:QMPI_Graph_create, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{MPI_Comm}), context, tool_id, comm_old, nnodes, indx, edges, reorder, comm_graph)
end

"""
    QMPI_Graph_get(context, tool_id, comm, maxindex, maxedges, indx, edges)

$(_doc_external(:QMPI_Graph_get))
"""
function QMPI_Graph_get(context, tool_id, comm, maxindex, maxedges, indx, edges)
    @mpichk ccall((:QMPI_Graph_get, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Cint, Ptr{Cint}, Ptr{Cint}), context, tool_id, comm, maxindex, maxedges, indx, edges)
end

"""
    QMPI_Graph_map(context, tool_id, comm, nnodes, indx, edges, newrank)

$(_doc_external(:QMPI_Graph_map))
"""
function QMPI_Graph_map(context, tool_id, comm, nnodes, indx, edges, newrank)
    @mpichk ccall((:QMPI_Graph_map, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), context, tool_id, comm, nnodes, indx, edges, newrank)
end

"""
    QMPI_Graph_neighbors(context, tool_id, comm, rank, maxneighbors, neighbors)

$(_doc_external(:QMPI_Graph_neighbors))
"""
function QMPI_Graph_neighbors(context, tool_id, comm, rank, maxneighbors, neighbors)
    @mpichk ccall((:QMPI_Graph_neighbors, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Cint, Ptr{Cint}), context, tool_id, comm, rank, maxneighbors, neighbors)
end

"""
    QMPI_Graph_neighbors_count(context, tool_id, comm, rank, nneighbors)

$(_doc_external(:QMPI_Graph_neighbors_count))
"""
function QMPI_Graph_neighbors_count(context, tool_id, comm, rank, nneighbors)
    @mpichk ccall((:QMPI_Graph_neighbors_count, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Cint, Ptr{Cint}), context, tool_id, comm, rank, nneighbors)
end

"""
    QMPI_Graphdims_get(context, tool_id, comm, nnodes, nedges)

$(_doc_external(:QMPI_Graphdims_get))
"""
function QMPI_Graphdims_get(context, tool_id, comm, nnodes, nedges)
    @mpichk ccall((:QMPI_Graphdims_get, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{Cint}, Ptr{Cint}), context, tool_id, comm, nnodes, nedges)
end

"""
    QMPI_Topo_test(context, tool_id, comm, status)

$(_doc_external(:QMPI_Topo_test))
"""
function QMPI_Topo_test(context, tool_id, comm, status)
    @mpichk ccall((:QMPI_Topo_test, libmpi), Cint, (QMPI_Context, Cint, MPI_Comm, Ptr{Cint}), context, tool_id, comm, status)
end

"""
    QMPI_Register_tool_name(tool_name, init_function_ptr)

$(_doc_external(:QMPI_Register_tool_name))
"""
function QMPI_Register_tool_name(tool_name, init_function_ptr)
    @mpichk ccall((:QMPI_Register_tool_name, libmpi), Cint, (Ptr{Cchar}, MPIPtr), tool_name, init_function_ptr)
end

"""
    QMPI_Register_tool_storage(tool_id, tool_storage)

$(_doc_external(:QMPI_Register_tool_storage))
"""
function QMPI_Register_tool_storage(tool_id, tool_storage)
    @mpichk ccall((:QMPI_Register_tool_storage, libmpi), Cint, (Cint, MPIPtr), tool_id, tool_storage)
end

"""
    QMPI_Register_function(calling_tool_id, function_enum, function_ptr)

$(_doc_external(:QMPI_Register_function))
"""
function QMPI_Register_function(calling_tool_id, function_enum, function_ptr)
    @mpichk ccall((:QMPI_Register_function, libmpi), Cint, (Cint, QMPI_Functions_enum, MPIPtr), calling_tool_id, function_enum, function_ptr)
end

"""
    QMPI_Get_function(calling_tool_id, function_enum, function_ptr, next_tool_id)

$(_doc_external(:QMPI_Get_function))
"""
function QMPI_Get_function(calling_tool_id, function_enum, function_ptr, next_tool_id)
    @mpichk ccall((:QMPI_Get_function, libmpi), Cint, (Cint, QMPI_Functions_enum, Ptr{MPIPtr}, Ptr{Cint}), calling_tool_id, function_enum, function_ptr, next_tool_id)
end

"""
    QMPI_Get_tool_storage(context, tool_id, storage)

$(_doc_external(:QMPI_Get_tool_storage))
"""
function QMPI_Get_tool_storage(context, tool_id, storage)
    @mpichk ccall((:QMPI_Get_tool_storage, libmpi), Cint, (QMPI_Context, Cint, Ptr{MPIPtr}), context, tool_id, storage)
end

"""
    QMPI_Get_calling_address(context, address)

$(_doc_external(:QMPI_Get_calling_address))
"""
function QMPI_Get_calling_address(context, address)
    @mpichk ccall((:QMPI_Get_calling_address, libmpi), Cint, (QMPI_Context, Ptr{MPIPtr}), context, address)
end

"""
    MPI_File_open(comm, filename, amode, info, fh)

$(_doc_external(:MPI_File_open))
"""
function MPI_File_open(comm, filename, amode, info, fh)
    @mpichk ccall((:MPI_File_open, libmpi), Cint, (MPI_Comm, Ptr{Cchar}, Cint, MPI_Info, Ptr{MPI_File}), comm, filename, amode, info, fh)
end

"""
    MPI_File_close(fh)

$(_doc_external(:MPI_File_close))
"""
function MPI_File_close(fh)
    @mpichk ccall((:MPI_File_close, libmpi), Cint, (Ptr{MPI_File},), fh)
end

"""
    MPI_File_delete(filename, info)

$(_doc_external(:MPI_File_delete))
"""
function MPI_File_delete(filename, info)
    @mpichk ccall((:MPI_File_delete, libmpi), Cint, (Ptr{Cchar}, MPI_Info), filename, info)
end

"""
    MPI_File_set_size(fh, size)

$(_doc_external(:MPI_File_set_size))
"""
function MPI_File_set_size(fh, size)
    @mpichk ccall((:MPI_File_set_size, libmpi), Cint, (MPI_File, MPI_Offset), fh, size)
end

"""
    MPI_File_preallocate(fh, size)

$(_doc_external(:MPI_File_preallocate))
"""
function MPI_File_preallocate(fh, size)
    @mpichk ccall((:MPI_File_preallocate, libmpi), Cint, (MPI_File, MPI_Offset), fh, size)
end

"""
    MPI_File_get_size(fh, size)

$(_doc_external(:MPI_File_get_size))
"""
function MPI_File_get_size(fh, size)
    @mpichk ccall((:MPI_File_get_size, libmpi), Cint, (MPI_File, Ptr{MPI_Offset}), fh, size)
end

"""
    MPI_File_get_group(fh, group)

$(_doc_external(:MPI_File_get_group))
"""
function MPI_File_get_group(fh, group)
    @mpichk ccall((:MPI_File_get_group, libmpi), Cint, (MPI_File, Ptr{MPI_Group}), fh, group)
end

"""
    MPI_File_get_amode(fh, amode)

$(_doc_external(:MPI_File_get_amode))
"""
function MPI_File_get_amode(fh, amode)
    @mpichk ccall((:MPI_File_get_amode, libmpi), Cint, (MPI_File, Ptr{Cint}), fh, amode)
end

"""
    MPI_File_set_info(fh, info)

$(_doc_external(:MPI_File_set_info))
"""
function MPI_File_set_info(fh, info)
    @mpichk ccall((:MPI_File_set_info, libmpi), Cint, (MPI_File, MPI_Info), fh, info)
end

"""
    MPI_File_get_info(fh, info_used)

$(_doc_external(:MPI_File_get_info))
"""
function MPI_File_get_info(fh, info_used)
    @mpichk ccall((:MPI_File_get_info, libmpi), Cint, (MPI_File, Ptr{MPI_Info}), fh, info_used)
end

"""
    MPI_File_set_view(fh, disp, etype, filetype, datarep, info)

$(_doc_external(:MPI_File_set_view))
"""
function MPI_File_set_view(fh, disp, etype, filetype, datarep, info)
    @mpichk ccall((:MPI_File_set_view, libmpi), Cint, (MPI_File, MPI_Offset, MPI_Datatype, MPI_Datatype, Ptr{Cchar}, MPI_Info), fh, disp, etype, filetype, datarep, info)
end

"""
    MPI_File_get_view(fh, disp, etype, filetype, datarep)

$(_doc_external(:MPI_File_get_view))
"""
function MPI_File_get_view(fh, disp, etype, filetype, datarep)
    @mpichk ccall((:MPI_File_get_view, libmpi), Cint, (MPI_File, Ptr{MPI_Offset}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}, Ptr{Cchar}), fh, disp, etype, filetype, datarep)
end

"""
    MPI_File_read_at(fh, offset, buf, count, datatype, status)

$(_doc_external(:MPI_File_read_at))
"""
function MPI_File_read_at(fh, offset, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_read_at, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

"""
    MPI_File_read_at_all(fh, offset, buf, count, datatype, status)

$(_doc_external(:MPI_File_read_at_all))
"""
function MPI_File_read_at_all(fh, offset, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_read_at_all, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

"""
    MPI_File_write_at(fh, offset, buf, count, datatype, status)

$(_doc_external(:MPI_File_write_at))
"""
function MPI_File_write_at(fh, offset, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_write_at, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

"""
    MPI_File_write_at_all(fh, offset, buf, count, datatype, status)

$(_doc_external(:MPI_File_write_at_all))
"""
function MPI_File_write_at_all(fh, offset, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_write_at_all, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

"""
    MPI_File_iread_at(fh, offset, buf, count, datatype, request)

$(_doc_external(:MPI_File_iread_at))
"""
function MPI_File_iread_at(fh, offset, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iread_at, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

"""
    MPI_File_iwrite_at(fh, offset, buf, count, datatype, request)

$(_doc_external(:MPI_File_iwrite_at))
"""
function MPI_File_iwrite_at(fh, offset, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iwrite_at, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

"""
    MPI_File_read(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_read))
"""
function MPI_File_read(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_read, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_read_all(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_read_all))
"""
function MPI_File_read_all(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_read_all, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_write(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_write))
"""
function MPI_File_write(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_write, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_write_all(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_write_all))
"""
function MPI_File_write_all(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_write_all, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_iread(fh, buf, count, datatype, request)

$(_doc_external(:MPI_File_iread))
"""
function MPI_File_iread(fh, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iread, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    MPI_File_iwrite(fh, buf, count, datatype, request)

$(_doc_external(:MPI_File_iwrite))
"""
function MPI_File_iwrite(fh, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iwrite, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    MPI_File_seek(fh, offset, whence)

$(_doc_external(:MPI_File_seek))
"""
function MPI_File_seek(fh, offset, whence)
    @mpichk ccall((:MPI_File_seek, libmpi), Cint, (MPI_File, MPI_Offset, Cint), fh, offset, whence)
end

"""
    MPI_File_get_position(fh, offset)

$(_doc_external(:MPI_File_get_position))
"""
function MPI_File_get_position(fh, offset)
    @mpichk ccall((:MPI_File_get_position, libmpi), Cint, (MPI_File, Ptr{MPI_Offset}), fh, offset)
end

"""
    MPI_File_get_byte_offset(fh, offset, disp)

$(_doc_external(:MPI_File_get_byte_offset))
"""
function MPI_File_get_byte_offset(fh, offset, disp)
    @mpichk ccall((:MPI_File_get_byte_offset, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{MPI_Offset}), fh, offset, disp)
end

"""
    MPI_File_read_shared(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_read_shared))
"""
function MPI_File_read_shared(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_read_shared, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_write_shared(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_write_shared))
"""
function MPI_File_write_shared(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_write_shared, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_iread_shared(fh, buf, count, datatype, request)

$(_doc_external(:MPI_File_iread_shared))
"""
function MPI_File_iread_shared(fh, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iread_shared, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    MPI_File_iwrite_shared(fh, buf, count, datatype, request)

$(_doc_external(:MPI_File_iwrite_shared))
"""
function MPI_File_iwrite_shared(fh, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iwrite_shared, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    MPI_File_read_ordered(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_read_ordered))
"""
function MPI_File_read_ordered(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_read_ordered, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_write_ordered(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_write_ordered))
"""
function MPI_File_write_ordered(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_write_ordered, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_seek_shared(fh, offset, whence)

$(_doc_external(:MPI_File_seek_shared))
"""
function MPI_File_seek_shared(fh, offset, whence)
    @mpichk ccall((:MPI_File_seek_shared, libmpi), Cint, (MPI_File, MPI_Offset, Cint), fh, offset, whence)
end

"""
    MPI_File_get_position_shared(fh, offset)

$(_doc_external(:MPI_File_get_position_shared))
"""
function MPI_File_get_position_shared(fh, offset)
    @mpichk ccall((:MPI_File_get_position_shared, libmpi), Cint, (MPI_File, Ptr{MPI_Offset}), fh, offset)
end

"""
    MPI_File_read_at_all_begin(fh, offset, buf, count, datatype)

$(_doc_external(:MPI_File_read_at_all_begin))
"""
function MPI_File_read_at_all_begin(fh, offset, buf, count, datatype)
    @mpichk ccall((:MPI_File_read_at_all_begin, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype), fh, offset, buf, count, datatype)
end

"""
    MPI_File_read_at_all_end(fh, buf, status)

$(_doc_external(:MPI_File_read_at_all_end))
"""
function MPI_File_read_at_all_end(fh, buf, status)
    @mpichk ccall((:MPI_File_read_at_all_end, libmpi), Cint, (MPI_File, MPIPtr, Ptr{MPI_Status}), fh, buf, status)
end

"""
    MPI_File_write_at_all_begin(fh, offset, buf, count, datatype)

$(_doc_external(:MPI_File_write_at_all_begin))
"""
function MPI_File_write_at_all_begin(fh, offset, buf, count, datatype)
    @mpichk ccall((:MPI_File_write_at_all_begin, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype), fh, offset, buf, count, datatype)
end

"""
    MPI_File_write_at_all_end(fh, buf, status)

$(_doc_external(:MPI_File_write_at_all_end))
"""
function MPI_File_write_at_all_end(fh, buf, status)
    @mpichk ccall((:MPI_File_write_at_all_end, libmpi), Cint, (MPI_File, MPIPtr, Ptr{MPI_Status}), fh, buf, status)
end

"""
    MPI_File_read_all_begin(fh, buf, count, datatype)

$(_doc_external(:MPI_File_read_all_begin))
"""
function MPI_File_read_all_begin(fh, buf, count, datatype)
    @mpichk ccall((:MPI_File_read_all_begin, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype), fh, buf, count, datatype)
end

"""
    MPI_File_read_all_end(fh, buf, status)

$(_doc_external(:MPI_File_read_all_end))
"""
function MPI_File_read_all_end(fh, buf, status)
    @mpichk ccall((:MPI_File_read_all_end, libmpi), Cint, (MPI_File, MPIPtr, Ptr{MPI_Status}), fh, buf, status)
end

"""
    MPI_File_write_all_begin(fh, buf, count, datatype)

$(_doc_external(:MPI_File_write_all_begin))
"""
function MPI_File_write_all_begin(fh, buf, count, datatype)
    @mpichk ccall((:MPI_File_write_all_begin, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype), fh, buf, count, datatype)
end

"""
    MPI_File_write_all_end(fh, buf, status)

$(_doc_external(:MPI_File_write_all_end))
"""
function MPI_File_write_all_end(fh, buf, status)
    @mpichk ccall((:MPI_File_write_all_end, libmpi), Cint, (MPI_File, MPIPtr, Ptr{MPI_Status}), fh, buf, status)
end

"""
    MPI_File_read_ordered_begin(fh, buf, count, datatype)

$(_doc_external(:MPI_File_read_ordered_begin))
"""
function MPI_File_read_ordered_begin(fh, buf, count, datatype)
    @mpichk ccall((:MPI_File_read_ordered_begin, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype), fh, buf, count, datatype)
end

"""
    MPI_File_read_ordered_end(fh, buf, status)

$(_doc_external(:MPI_File_read_ordered_end))
"""
function MPI_File_read_ordered_end(fh, buf, status)
    @mpichk ccall((:MPI_File_read_ordered_end, libmpi), Cint, (MPI_File, MPIPtr, Ptr{MPI_Status}), fh, buf, status)
end

"""
    MPI_File_write_ordered_begin(fh, buf, count, datatype)

$(_doc_external(:MPI_File_write_ordered_begin))
"""
function MPI_File_write_ordered_begin(fh, buf, count, datatype)
    @mpichk ccall((:MPI_File_write_ordered_begin, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype), fh, buf, count, datatype)
end

"""
    MPI_File_write_ordered_end(fh, buf, status)

$(_doc_external(:MPI_File_write_ordered_end))
"""
function MPI_File_write_ordered_end(fh, buf, status)
    @mpichk ccall((:MPI_File_write_ordered_end, libmpi), Cint, (MPI_File, MPIPtr, Ptr{MPI_Status}), fh, buf, status)
end

"""
    MPI_File_get_type_extent(fh, datatype, extent)

$(_doc_external(:MPI_File_get_type_extent))
"""
function MPI_File_get_type_extent(fh, datatype, extent)
    @mpichk ccall((:MPI_File_get_type_extent, libmpi), Cint, (MPI_File, MPI_Datatype, Ptr{MPI_Aint}), fh, datatype, extent)
end

"""
    MPI_Register_datarep(datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)

$(_doc_external(:MPI_Register_datarep))
"""
function MPI_Register_datarep(datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)
    @mpichk ccall((:MPI_Register_datarep, libmpi), Cint, (Ptr{Cchar}, MPIPtr, MPIPtr, MPIPtr, MPIPtr), datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)
end

"""
    MPI_File_set_atomicity(fh, flag)

$(_doc_external(:MPI_File_set_atomicity))
"""
function MPI_File_set_atomicity(fh, flag)
    @mpichk ccall((:MPI_File_set_atomicity, libmpi), Cint, (MPI_File, Cint), fh, flag)
end

"""
    MPI_File_get_atomicity(fh, flag)

$(_doc_external(:MPI_File_get_atomicity))
"""
function MPI_File_get_atomicity(fh, flag)
    @mpichk ccall((:MPI_File_get_atomicity, libmpi), Cint, (MPI_File, Ptr{Cint}), fh, flag)
end

"""
    MPI_File_sync(fh)

$(_doc_external(:MPI_File_sync))
"""
function MPI_File_sync(fh)
    @mpichk ccall((:MPI_File_sync, libmpi), Cint, (MPI_File,), fh)
end

"""
    MPI_File_iread_at_all(fh, offset, buf, count, datatype, request)

$(_doc_external(:MPI_File_iread_at_all))
"""
function MPI_File_iread_at_all(fh, offset, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iread_at_all, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

"""
    MPI_File_iwrite_at_all(fh, offset, buf, count, datatype, request)

$(_doc_external(:MPI_File_iwrite_at_all))
"""
function MPI_File_iwrite_at_all(fh, offset, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iwrite_at_all, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

"""
    MPI_File_iread_all(fh, buf, count, datatype, request)

$(_doc_external(:MPI_File_iread_all))
"""
function MPI_File_iread_all(fh, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iread_all, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    MPI_File_iwrite_all(fh, buf, count, datatype, request)

$(_doc_external(:MPI_File_iwrite_all))
"""
function MPI_File_iwrite_all(fh, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iwrite_all, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    MPI_File_read_c(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_read_c))
"""
function MPI_File_read_c(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_read_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_read_all_c(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_read_all_c))
"""
function MPI_File_read_all_c(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_read_all_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_read_all_begin_c(fh, buf, count, datatype)

$(_doc_external(:MPI_File_read_all_begin_c))
"""
function MPI_File_read_all_begin_c(fh, buf, count, datatype)
    @mpichk ccall((:MPI_File_read_all_begin_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype), fh, buf, count, datatype)
end

"""
    MPI_File_read_at_c(fh, offset, buf, count, datatype, status)

$(_doc_external(:MPI_File_read_at_c))
"""
function MPI_File_read_at_c(fh, offset, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_read_at_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

"""
    MPI_File_read_at_all_c(fh, offset, buf, count, datatype, status)

$(_doc_external(:MPI_File_read_at_all_c))
"""
function MPI_File_read_at_all_c(fh, offset, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_read_at_all_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

"""
    MPI_File_read_at_all_begin_c(fh, offset, buf, count, datatype)

$(_doc_external(:MPI_File_read_at_all_begin_c))
"""
function MPI_File_read_at_all_begin_c(fh, offset, buf, count, datatype)
    @mpichk ccall((:MPI_File_read_at_all_begin_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype), fh, offset, buf, count, datatype)
end

"""
    MPI_File_read_ordered_c(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_read_ordered_c))
"""
function MPI_File_read_ordered_c(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_read_ordered_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_read_ordered_begin_c(fh, buf, count, datatype)

$(_doc_external(:MPI_File_read_ordered_begin_c))
"""
function MPI_File_read_ordered_begin_c(fh, buf, count, datatype)
    @mpichk ccall((:MPI_File_read_ordered_begin_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype), fh, buf, count, datatype)
end

"""
    MPI_File_read_shared_c(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_read_shared_c))
"""
function MPI_File_read_shared_c(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_read_shared_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_write_c(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_write_c))
"""
function MPI_File_write_c(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_write_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_write_all_c(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_write_all_c))
"""
function MPI_File_write_all_c(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_write_all_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_write_all_begin_c(fh, buf, count, datatype)

$(_doc_external(:MPI_File_write_all_begin_c))
"""
function MPI_File_write_all_begin_c(fh, buf, count, datatype)
    @mpichk ccall((:MPI_File_write_all_begin_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype), fh, buf, count, datatype)
end

"""
    MPI_File_write_at_c(fh, offset, buf, count, datatype, status)

$(_doc_external(:MPI_File_write_at_c))
"""
function MPI_File_write_at_c(fh, offset, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_write_at_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

"""
    MPI_File_write_at_all_c(fh, offset, buf, count, datatype, status)

$(_doc_external(:MPI_File_write_at_all_c))
"""
function MPI_File_write_at_all_c(fh, offset, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_write_at_all_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

"""
    MPI_File_write_at_all_begin_c(fh, offset, buf, count, datatype)

$(_doc_external(:MPI_File_write_at_all_begin_c))
"""
function MPI_File_write_at_all_begin_c(fh, offset, buf, count, datatype)
    @mpichk ccall((:MPI_File_write_at_all_begin_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype), fh, offset, buf, count, datatype)
end

"""
    MPI_File_write_ordered_c(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_write_ordered_c))
"""
function MPI_File_write_ordered_c(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_write_ordered_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_write_ordered_begin_c(fh, buf, count, datatype)

$(_doc_external(:MPI_File_write_ordered_begin_c))
"""
function MPI_File_write_ordered_begin_c(fh, buf, count, datatype)
    @mpichk ccall((:MPI_File_write_ordered_begin_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype), fh, buf, count, datatype)
end

"""
    MPI_File_write_shared_c(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_write_shared_c))
"""
function MPI_File_write_shared_c(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_write_shared_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_iread_c(fh, buf, count, datatype, request)

$(_doc_external(:MPI_File_iread_c))
"""
function MPI_File_iread_c(fh, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iread_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    MPI_File_iread_all_c(fh, buf, count, datatype, request)

$(_doc_external(:MPI_File_iread_all_c))
"""
function MPI_File_iread_all_c(fh, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iread_all_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    MPI_File_iread_at_c(fh, offset, buf, count, datatype, request)

$(_doc_external(:MPI_File_iread_at_c))
"""
function MPI_File_iread_at_c(fh, offset, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iread_at_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

"""
    MPI_File_iread_at_all_c(fh, offset, buf, count, datatype, request)

$(_doc_external(:MPI_File_iread_at_all_c))
"""
function MPI_File_iread_at_all_c(fh, offset, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iread_at_all_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

"""
    MPI_File_iread_shared_c(fh, buf, count, datatype, request)

$(_doc_external(:MPI_File_iread_shared_c))
"""
function MPI_File_iread_shared_c(fh, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iread_shared_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    MPI_File_iwrite_c(fh, buf, count, datatype, request)

$(_doc_external(:MPI_File_iwrite_c))
"""
function MPI_File_iwrite_c(fh, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iwrite_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    MPI_File_iwrite_all_c(fh, buf, count, datatype, request)

$(_doc_external(:MPI_File_iwrite_all_c))
"""
function MPI_File_iwrite_all_c(fh, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iwrite_all_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    MPI_File_iwrite_at_c(fh, offset, buf, count, datatype, request)

$(_doc_external(:MPI_File_iwrite_at_c))
"""
function MPI_File_iwrite_at_c(fh, offset, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iwrite_at_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

"""
    MPI_File_iwrite_at_all_c(fh, offset, buf, count, datatype, request)

$(_doc_external(:MPI_File_iwrite_at_all_c))
"""
function MPI_File_iwrite_at_all_c(fh, offset, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iwrite_at_all_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

"""
    MPI_File_iwrite_shared_c(fh, buf, count, datatype, request)

$(_doc_external(:MPI_File_iwrite_shared_c))
"""
function MPI_File_iwrite_shared_c(fh, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iwrite_shared_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    MPI_File_get_type_extent_c(fh, datatype, extent)

$(_doc_external(:MPI_File_get_type_extent_c))
"""
function MPI_File_get_type_extent_c(fh, datatype, extent)
    @mpichk ccall((:MPI_File_get_type_extent_c, libmpi), Cint, (MPI_File, MPI_Datatype, Ptr{MPI_Count}), fh, datatype, extent)
end

"""
    MPI_Register_datarep_c(datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)

$(_doc_external(:MPI_Register_datarep_c))
"""
function MPI_Register_datarep_c(datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)
    @mpichk ccall((:MPI_Register_datarep_c, libmpi), Cint, (Ptr{Cchar}, MPIPtr, MPIPtr, MPIPtr, MPIPtr), datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)
end

"""
    MPI_File_f2c(file)

$(_doc_external(:MPI_File_f2c))
"""
function MPI_File_f2c(file)
    @mpichk ccall((:MPI_File_f2c, libmpi), MPI_File, (MPI_Fint,), file)
end

"""
    MPI_File_c2f(file)

$(_doc_external(:MPI_File_c2f))
"""
function MPI_File_c2f(file)
    @mpichk ccall((:MPI_File_c2f, libmpi), MPI_Fint, (MPI_File,), file)
end

"""
    PMPI_File_open(arg1, arg2, arg3, arg4, arg5)

$(_doc_external(:PMPI_File_open))
"""
function PMPI_File_open(arg1, arg2, arg3, arg4, arg5)
    @mpichk ccall((:PMPI_File_open, libmpi), Cint, (MPI_Comm, Ptr{Cchar}, Cint, MPI_Info, Ptr{MPI_File}), arg1, arg2, arg3, arg4, arg5)
end

"""
    PMPI_File_close(arg1)

$(_doc_external(:PMPI_File_close))
"""
function PMPI_File_close(arg1)
    @mpichk ccall((:PMPI_File_close, libmpi), Cint, (Ptr{MPI_File},), arg1)
end

"""
    PMPI_File_delete(arg1, arg2)

$(_doc_external(:PMPI_File_delete))
"""
function PMPI_File_delete(arg1, arg2)
    @mpichk ccall((:PMPI_File_delete, libmpi), Cint, (Ptr{Cchar}, MPI_Info), arg1, arg2)
end

"""
    PMPI_File_set_size(arg1, arg2)

$(_doc_external(:PMPI_File_set_size))
"""
function PMPI_File_set_size(arg1, arg2)
    @mpichk ccall((:PMPI_File_set_size, libmpi), Cint, (MPI_File, MPI_Offset), arg1, arg2)
end

"""
    PMPI_File_preallocate(arg1, arg2)

$(_doc_external(:PMPI_File_preallocate))
"""
function PMPI_File_preallocate(arg1, arg2)
    @mpichk ccall((:PMPI_File_preallocate, libmpi), Cint, (MPI_File, MPI_Offset), arg1, arg2)
end

"""
    PMPI_File_get_size(arg1, arg2)

$(_doc_external(:PMPI_File_get_size))
"""
function PMPI_File_get_size(arg1, arg2)
    @mpichk ccall((:PMPI_File_get_size, libmpi), Cint, (MPI_File, Ptr{MPI_Offset}), arg1, arg2)
end

"""
    PMPI_File_get_group(arg1, arg2)

$(_doc_external(:PMPI_File_get_group))
"""
function PMPI_File_get_group(arg1, arg2)
    @mpichk ccall((:PMPI_File_get_group, libmpi), Cint, (MPI_File, Ptr{MPI_Group}), arg1, arg2)
end

"""
    PMPI_File_get_amode(arg1, arg2)

$(_doc_external(:PMPI_File_get_amode))
"""
function PMPI_File_get_amode(arg1, arg2)
    @mpichk ccall((:PMPI_File_get_amode, libmpi), Cint, (MPI_File, Ptr{Cint}), arg1, arg2)
end

"""
    PMPI_File_set_info(arg1, arg2)

$(_doc_external(:PMPI_File_set_info))
"""
function PMPI_File_set_info(arg1, arg2)
    @mpichk ccall((:PMPI_File_set_info, libmpi), Cint, (MPI_File, MPI_Info), arg1, arg2)
end

"""
    PMPI_File_get_info(arg1, arg2)

$(_doc_external(:PMPI_File_get_info))
"""
function PMPI_File_get_info(arg1, arg2)
    @mpichk ccall((:PMPI_File_get_info, libmpi), Cint, (MPI_File, Ptr{MPI_Info}), arg1, arg2)
end

"""
    PMPI_File_set_view(arg1, arg2, arg3, arg4, arg5, arg6)

$(_doc_external(:PMPI_File_set_view))
"""
function PMPI_File_set_view(arg1, arg2, arg3, arg4, arg5, arg6)
    @mpichk ccall((:PMPI_File_set_view, libmpi), Cint, (MPI_File, MPI_Offset, MPI_Datatype, MPI_Datatype, Ptr{Cchar}, MPI_Info), arg1, arg2, arg3, arg4, arg5, arg6)
end

"""
    PMPI_File_get_view(arg1, arg2, arg3, arg4, arg5)

$(_doc_external(:PMPI_File_get_view))
"""
function PMPI_File_get_view(arg1, arg2, arg3, arg4, arg5)
    @mpichk ccall((:PMPI_File_get_view, libmpi), Cint, (MPI_File, Ptr{MPI_Offset}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}, Ptr{Cchar}), arg1, arg2, arg3, arg4, arg5)
end

"""
    PMPI_File_read_at(arg1, arg2, arg3, arg4, arg5, arg6)

$(_doc_external(:PMPI_File_read_at))
"""
function PMPI_File_read_at(arg1, arg2, arg3, arg4, arg5, arg6)
    @mpichk ccall((:PMPI_File_read_at, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), arg1, arg2, arg3, arg4, arg5, arg6)
end

"""
    PMPI_File_read_at_all(arg1, arg2, arg3, arg4, arg5, arg6)

$(_doc_external(:PMPI_File_read_at_all))
"""
function PMPI_File_read_at_all(arg1, arg2, arg3, arg4, arg5, arg6)
    @mpichk ccall((:PMPI_File_read_at_all, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), arg1, arg2, arg3, arg4, arg5, arg6)
end

"""
    PMPI_File_write_at(arg1, arg2, arg3, arg4, arg5, arg6)

$(_doc_external(:PMPI_File_write_at))
"""
function PMPI_File_write_at(arg1, arg2, arg3, arg4, arg5, arg6)
    @mpichk ccall((:PMPI_File_write_at, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), arg1, arg2, arg3, arg4, arg5, arg6)
end

"""
    PMPI_File_write_at_all(arg1, arg2, arg3, arg4, arg5, arg6)

$(_doc_external(:PMPI_File_write_at_all))
"""
function PMPI_File_write_at_all(arg1, arg2, arg3, arg4, arg5, arg6)
    @mpichk ccall((:PMPI_File_write_at_all, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), arg1, arg2, arg3, arg4, arg5, arg6)
end

"""
    PMPI_File_iread_at(arg1, arg2, arg3, arg4, arg5, arg6)

$(_doc_external(:PMPI_File_iread_at))
"""
function PMPI_File_iread_at(arg1, arg2, arg3, arg4, arg5, arg6)
    @mpichk ccall((:PMPI_File_iread_at, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), arg1, arg2, arg3, arg4, arg5, arg6)
end

"""
    PMPI_File_iwrite_at(arg1, arg2, arg3, arg4, arg5, arg6)

$(_doc_external(:PMPI_File_iwrite_at))
"""
function PMPI_File_iwrite_at(arg1, arg2, arg3, arg4, arg5, arg6)
    @mpichk ccall((:PMPI_File_iwrite_at, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), arg1, arg2, arg3, arg4, arg5, arg6)
end

"""
    PMPI_File_read(arg1, arg2, arg3, arg4, arg5)

$(_doc_external(:PMPI_File_read))
"""
function PMPI_File_read(arg1, arg2, arg3, arg4, arg5)
    @mpichk ccall((:PMPI_File_read, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), arg1, arg2, arg3, arg4, arg5)
end

"""
    PMPI_File_read_all(arg1, arg2, arg3, arg4, arg5)

$(_doc_external(:PMPI_File_read_all))
"""
function PMPI_File_read_all(arg1, arg2, arg3, arg4, arg5)
    @mpichk ccall((:PMPI_File_read_all, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), arg1, arg2, arg3, arg4, arg5)
end

"""
    PMPI_File_write(arg1, arg2, arg3, arg4, arg5)

$(_doc_external(:PMPI_File_write))
"""
function PMPI_File_write(arg1, arg2, arg3, arg4, arg5)
    @mpichk ccall((:PMPI_File_write, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), arg1, arg2, arg3, arg4, arg5)
end

"""
    PMPI_File_write_all(arg1, arg2, arg3, arg4, arg5)

$(_doc_external(:PMPI_File_write_all))
"""
function PMPI_File_write_all(arg1, arg2, arg3, arg4, arg5)
    @mpichk ccall((:PMPI_File_write_all, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), arg1, arg2, arg3, arg4, arg5)
end

"""
    PMPI_File_iread(arg1, arg2, arg3, arg4, arg5)

$(_doc_external(:PMPI_File_iread))
"""
function PMPI_File_iread(arg1, arg2, arg3, arg4, arg5)
    @mpichk ccall((:PMPI_File_iread, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), arg1, arg2, arg3, arg4, arg5)
end

"""
    PMPI_File_iwrite(arg1, arg2, arg3, arg4, arg5)

$(_doc_external(:PMPI_File_iwrite))
"""
function PMPI_File_iwrite(arg1, arg2, arg3, arg4, arg5)
    @mpichk ccall((:PMPI_File_iwrite, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), arg1, arg2, arg3, arg4, arg5)
end

"""
    PMPI_File_seek(arg1, arg2, arg3)

$(_doc_external(:PMPI_File_seek))
"""
function PMPI_File_seek(arg1, arg2, arg3)
    @mpichk ccall((:PMPI_File_seek, libmpi), Cint, (MPI_File, MPI_Offset, Cint), arg1, arg2, arg3)
end

"""
    PMPI_File_get_position(arg1, arg2)

$(_doc_external(:PMPI_File_get_position))
"""
function PMPI_File_get_position(arg1, arg2)
    @mpichk ccall((:PMPI_File_get_position, libmpi), Cint, (MPI_File, Ptr{MPI_Offset}), arg1, arg2)
end

"""
    PMPI_File_get_byte_offset(arg1, arg2, arg3)

$(_doc_external(:PMPI_File_get_byte_offset))
"""
function PMPI_File_get_byte_offset(arg1, arg2, arg3)
    @mpichk ccall((:PMPI_File_get_byte_offset, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{MPI_Offset}), arg1, arg2, arg3)
end

"""
    PMPI_File_read_shared(arg1, arg2, arg3, arg4, arg5)

$(_doc_external(:PMPI_File_read_shared))
"""
function PMPI_File_read_shared(arg1, arg2, arg3, arg4, arg5)
    @mpichk ccall((:PMPI_File_read_shared, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), arg1, arg2, arg3, arg4, arg5)
end

"""
    PMPI_File_write_shared(arg1, arg2, arg3, arg4, arg5)

$(_doc_external(:PMPI_File_write_shared))
"""
function PMPI_File_write_shared(arg1, arg2, arg3, arg4, arg5)
    @mpichk ccall((:PMPI_File_write_shared, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), arg1, arg2, arg3, arg4, arg5)
end

"""
    PMPI_File_iread_shared(arg1, arg2, arg3, arg4, arg5)

$(_doc_external(:PMPI_File_iread_shared))
"""
function PMPI_File_iread_shared(arg1, arg2, arg3, arg4, arg5)
    @mpichk ccall((:PMPI_File_iread_shared, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), arg1, arg2, arg3, arg4, arg5)
end

"""
    PMPI_File_iwrite_shared(arg1, arg2, arg3, arg4, arg5)

$(_doc_external(:PMPI_File_iwrite_shared))
"""
function PMPI_File_iwrite_shared(arg1, arg2, arg3, arg4, arg5)
    @mpichk ccall((:PMPI_File_iwrite_shared, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), arg1, arg2, arg3, arg4, arg5)
end

"""
    PMPI_File_read_ordered(arg1, arg2, arg3, arg4, arg5)

$(_doc_external(:PMPI_File_read_ordered))
"""
function PMPI_File_read_ordered(arg1, arg2, arg3, arg4, arg5)
    @mpichk ccall((:PMPI_File_read_ordered, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), arg1, arg2, arg3, arg4, arg5)
end

"""
    PMPI_File_write_ordered(arg1, arg2, arg3, arg4, arg5)

$(_doc_external(:PMPI_File_write_ordered))
"""
function PMPI_File_write_ordered(arg1, arg2, arg3, arg4, arg5)
    @mpichk ccall((:PMPI_File_write_ordered, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), arg1, arg2, arg3, arg4, arg5)
end

"""
    PMPI_File_seek_shared(arg1, arg2, arg3)

$(_doc_external(:PMPI_File_seek_shared))
"""
function PMPI_File_seek_shared(arg1, arg2, arg3)
    @mpichk ccall((:PMPI_File_seek_shared, libmpi), Cint, (MPI_File, MPI_Offset, Cint), arg1, arg2, arg3)
end

"""
    PMPI_File_get_position_shared(arg1, arg2)

$(_doc_external(:PMPI_File_get_position_shared))
"""
function PMPI_File_get_position_shared(arg1, arg2)
    @mpichk ccall((:PMPI_File_get_position_shared, libmpi), Cint, (MPI_File, Ptr{MPI_Offset}), arg1, arg2)
end

"""
    PMPI_File_read_at_all_begin(arg1, arg2, arg3, arg4, arg5)

$(_doc_external(:PMPI_File_read_at_all_begin))
"""
function PMPI_File_read_at_all_begin(arg1, arg2, arg3, arg4, arg5)
    @mpichk ccall((:PMPI_File_read_at_all_begin, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype), arg1, arg2, arg3, arg4, arg5)
end

"""
    PMPI_File_read_at_all_end(arg1, arg2, arg3)

$(_doc_external(:PMPI_File_read_at_all_end))
"""
function PMPI_File_read_at_all_end(arg1, arg2, arg3)
    @mpichk ccall((:PMPI_File_read_at_all_end, libmpi), Cint, (MPI_File, MPIPtr, Ptr{MPI_Status}), arg1, arg2, arg3)
end

"""
    PMPI_File_write_at_all_begin(arg1, arg2, arg3, arg4, arg5)

$(_doc_external(:PMPI_File_write_at_all_begin))
"""
function PMPI_File_write_at_all_begin(arg1, arg2, arg3, arg4, arg5)
    @mpichk ccall((:PMPI_File_write_at_all_begin, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype), arg1, arg2, arg3, arg4, arg5)
end

"""
    PMPI_File_write_at_all_end(arg1, arg2, arg3)

$(_doc_external(:PMPI_File_write_at_all_end))
"""
function PMPI_File_write_at_all_end(arg1, arg2, arg3)
    @mpichk ccall((:PMPI_File_write_at_all_end, libmpi), Cint, (MPI_File, MPIPtr, Ptr{MPI_Status}), arg1, arg2, arg3)
end

"""
    PMPI_File_read_all_begin(arg1, arg2, arg3, arg4)

$(_doc_external(:PMPI_File_read_all_begin))
"""
function PMPI_File_read_all_begin(arg1, arg2, arg3, arg4)
    @mpichk ccall((:PMPI_File_read_all_begin, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype), arg1, arg2, arg3, arg4)
end

"""
    PMPI_File_read_all_end(arg1, arg2, arg3)

$(_doc_external(:PMPI_File_read_all_end))
"""
function PMPI_File_read_all_end(arg1, arg2, arg3)
    @mpichk ccall((:PMPI_File_read_all_end, libmpi), Cint, (MPI_File, MPIPtr, Ptr{MPI_Status}), arg1, arg2, arg3)
end

"""
    PMPI_File_write_all_begin(arg1, arg2, arg3, arg4)

$(_doc_external(:PMPI_File_write_all_begin))
"""
function PMPI_File_write_all_begin(arg1, arg2, arg3, arg4)
    @mpichk ccall((:PMPI_File_write_all_begin, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype), arg1, arg2, arg3, arg4)
end

"""
    PMPI_File_write_all_end(arg1, arg2, arg3)

$(_doc_external(:PMPI_File_write_all_end))
"""
function PMPI_File_write_all_end(arg1, arg2, arg3)
    @mpichk ccall((:PMPI_File_write_all_end, libmpi), Cint, (MPI_File, MPIPtr, Ptr{MPI_Status}), arg1, arg2, arg3)
end

"""
    PMPI_File_read_ordered_begin(arg1, arg2, arg3, arg4)

$(_doc_external(:PMPI_File_read_ordered_begin))
"""
function PMPI_File_read_ordered_begin(arg1, arg2, arg3, arg4)
    @mpichk ccall((:PMPI_File_read_ordered_begin, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype), arg1, arg2, arg3, arg4)
end

"""
    PMPI_File_read_ordered_end(arg1, arg2, arg3)

$(_doc_external(:PMPI_File_read_ordered_end))
"""
function PMPI_File_read_ordered_end(arg1, arg2, arg3)
    @mpichk ccall((:PMPI_File_read_ordered_end, libmpi), Cint, (MPI_File, MPIPtr, Ptr{MPI_Status}), arg1, arg2, arg3)
end

"""
    PMPI_File_write_ordered_begin(arg1, arg2, arg3, arg4)

$(_doc_external(:PMPI_File_write_ordered_begin))
"""
function PMPI_File_write_ordered_begin(arg1, arg2, arg3, arg4)
    @mpichk ccall((:PMPI_File_write_ordered_begin, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype), arg1, arg2, arg3, arg4)
end

"""
    PMPI_File_write_ordered_end(arg1, arg2, arg3)

$(_doc_external(:PMPI_File_write_ordered_end))
"""
function PMPI_File_write_ordered_end(arg1, arg2, arg3)
    @mpichk ccall((:PMPI_File_write_ordered_end, libmpi), Cint, (MPI_File, MPIPtr, Ptr{MPI_Status}), arg1, arg2, arg3)
end

"""
    PMPI_File_get_type_extent(arg1, arg2, arg3)

$(_doc_external(:PMPI_File_get_type_extent))
"""
function PMPI_File_get_type_extent(arg1, arg2, arg3)
    @mpichk ccall((:PMPI_File_get_type_extent, libmpi), Cint, (MPI_File, MPI_Datatype, Ptr{MPI_Aint}), arg1, arg2, arg3)
end

"""
    PMPI_Register_datarep(arg1, arg2, arg3, arg4, arg5)

$(_doc_external(:PMPI_Register_datarep))
"""
function PMPI_Register_datarep(arg1, arg2, arg3, arg4, arg5)
    @mpichk ccall((:PMPI_Register_datarep, libmpi), Cint, (Ptr{Cchar}, MPIPtr, MPIPtr, MPIPtr, MPIPtr), arg1, arg2, arg3, arg4, arg5)
end

"""
    PMPI_File_set_atomicity(arg1, arg2)

$(_doc_external(:PMPI_File_set_atomicity))
"""
function PMPI_File_set_atomicity(arg1, arg2)
    @mpichk ccall((:PMPI_File_set_atomicity, libmpi), Cint, (MPI_File, Cint), arg1, arg2)
end

"""
    PMPI_File_get_atomicity(arg1, arg2)

$(_doc_external(:PMPI_File_get_atomicity))
"""
function PMPI_File_get_atomicity(arg1, arg2)
    @mpichk ccall((:PMPI_File_get_atomicity, libmpi), Cint, (MPI_File, Ptr{Cint}), arg1, arg2)
end

"""
    PMPI_File_sync(arg1)

$(_doc_external(:PMPI_File_sync))
"""
function PMPI_File_sync(arg1)
    @mpichk ccall((:PMPI_File_sync, libmpi), Cint, (MPI_File,), arg1)
end

"""
    PMPI_File_iread_at_all(fh, offset, buf, count, datatype, request)

$(_doc_external(:PMPI_File_iread_at_all))
"""
function PMPI_File_iread_at_all(fh, offset, buf, count, datatype, request)
    @mpichk ccall((:PMPI_File_iread_at_all, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

"""
    PMPI_File_iwrite_at_all(fh, offset, buf, count, datatype, request)

$(_doc_external(:PMPI_File_iwrite_at_all))
"""
function PMPI_File_iwrite_at_all(fh, offset, buf, count, datatype, request)
    @mpichk ccall((:PMPI_File_iwrite_at_all, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

"""
    PMPI_File_iread_all(fh, buf, count, datatype, request)

$(_doc_external(:PMPI_File_iread_all))
"""
function PMPI_File_iread_all(fh, buf, count, datatype, request)
    @mpichk ccall((:PMPI_File_iread_all, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    PMPI_File_iwrite_all(fh, buf, count, datatype, request)

$(_doc_external(:PMPI_File_iwrite_all))
"""
function PMPI_File_iwrite_all(fh, buf, count, datatype, request)
    @mpichk ccall((:PMPI_File_iwrite_all, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    PMPI_File_read_c(fh, buf, count, datatype, status)

$(_doc_external(:PMPI_File_read_c))
"""
function PMPI_File_read_c(fh, buf, count, datatype, status)
    @mpichk ccall((:PMPI_File_read_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    PMPI_File_read_all_c(fh, buf, count, datatype, status)

$(_doc_external(:PMPI_File_read_all_c))
"""
function PMPI_File_read_all_c(fh, buf, count, datatype, status)
    @mpichk ccall((:PMPI_File_read_all_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    PMPI_File_read_all_begin_c(fh, buf, count, datatype)

$(_doc_external(:PMPI_File_read_all_begin_c))
"""
function PMPI_File_read_all_begin_c(fh, buf, count, datatype)
    @mpichk ccall((:PMPI_File_read_all_begin_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype), fh, buf, count, datatype)
end

"""
    PMPI_File_read_at_c(fh, offset, buf, count, datatype, status)

$(_doc_external(:PMPI_File_read_at_c))
"""
function PMPI_File_read_at_c(fh, offset, buf, count, datatype, status)
    @mpichk ccall((:PMPI_File_read_at_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

"""
    PMPI_File_read_at_all_c(fh, offset, buf, count, datatype, status)

$(_doc_external(:PMPI_File_read_at_all_c))
"""
function PMPI_File_read_at_all_c(fh, offset, buf, count, datatype, status)
    @mpichk ccall((:PMPI_File_read_at_all_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

"""
    PMPI_File_read_at_all_begin_c(fh, offset, buf, count, datatype)

$(_doc_external(:PMPI_File_read_at_all_begin_c))
"""
function PMPI_File_read_at_all_begin_c(fh, offset, buf, count, datatype)
    @mpichk ccall((:PMPI_File_read_at_all_begin_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype), fh, offset, buf, count, datatype)
end

"""
    PMPI_File_read_ordered_c(fh, buf, count, datatype, status)

$(_doc_external(:PMPI_File_read_ordered_c))
"""
function PMPI_File_read_ordered_c(fh, buf, count, datatype, status)
    @mpichk ccall((:PMPI_File_read_ordered_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    PMPI_File_read_ordered_begin_c(fh, buf, count, datatype)

$(_doc_external(:PMPI_File_read_ordered_begin_c))
"""
function PMPI_File_read_ordered_begin_c(fh, buf, count, datatype)
    @mpichk ccall((:PMPI_File_read_ordered_begin_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype), fh, buf, count, datatype)
end

"""
    PMPI_File_read_shared_c(fh, buf, count, datatype, status)

$(_doc_external(:PMPI_File_read_shared_c))
"""
function PMPI_File_read_shared_c(fh, buf, count, datatype, status)
    @mpichk ccall((:PMPI_File_read_shared_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    PMPI_File_write_c(fh, buf, count, datatype, status)

$(_doc_external(:PMPI_File_write_c))
"""
function PMPI_File_write_c(fh, buf, count, datatype, status)
    @mpichk ccall((:PMPI_File_write_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    PMPI_File_write_all_c(fh, buf, count, datatype, status)

$(_doc_external(:PMPI_File_write_all_c))
"""
function PMPI_File_write_all_c(fh, buf, count, datatype, status)
    @mpichk ccall((:PMPI_File_write_all_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    PMPI_File_write_all_begin_c(fh, buf, count, datatype)

$(_doc_external(:PMPI_File_write_all_begin_c))
"""
function PMPI_File_write_all_begin_c(fh, buf, count, datatype)
    @mpichk ccall((:PMPI_File_write_all_begin_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype), fh, buf, count, datatype)
end

"""
    PMPI_File_write_at_c(fh, offset, buf, count, datatype, status)

$(_doc_external(:PMPI_File_write_at_c))
"""
function PMPI_File_write_at_c(fh, offset, buf, count, datatype, status)
    @mpichk ccall((:PMPI_File_write_at_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

"""
    PMPI_File_write_at_all_c(fh, offset, buf, count, datatype, status)

$(_doc_external(:PMPI_File_write_at_all_c))
"""
function PMPI_File_write_at_all_c(fh, offset, buf, count, datatype, status)
    @mpichk ccall((:PMPI_File_write_at_all_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

"""
    PMPI_File_write_at_all_begin_c(fh, offset, buf, count, datatype)

$(_doc_external(:PMPI_File_write_at_all_begin_c))
"""
function PMPI_File_write_at_all_begin_c(fh, offset, buf, count, datatype)
    @mpichk ccall((:PMPI_File_write_at_all_begin_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype), fh, offset, buf, count, datatype)
end

"""
    PMPI_File_write_ordered_c(fh, buf, count, datatype, status)

$(_doc_external(:PMPI_File_write_ordered_c))
"""
function PMPI_File_write_ordered_c(fh, buf, count, datatype, status)
    @mpichk ccall((:PMPI_File_write_ordered_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    PMPI_File_write_ordered_begin_c(fh, buf, count, datatype)

$(_doc_external(:PMPI_File_write_ordered_begin_c))
"""
function PMPI_File_write_ordered_begin_c(fh, buf, count, datatype)
    @mpichk ccall((:PMPI_File_write_ordered_begin_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype), fh, buf, count, datatype)
end

"""
    PMPI_File_write_shared_c(fh, buf, count, datatype, status)

$(_doc_external(:PMPI_File_write_shared_c))
"""
function PMPI_File_write_shared_c(fh, buf, count, datatype, status)
    @mpichk ccall((:PMPI_File_write_shared_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    PMPI_File_iread_c(fh, buf, count, datatype, request)

$(_doc_external(:PMPI_File_iread_c))
"""
function PMPI_File_iread_c(fh, buf, count, datatype, request)
    @mpichk ccall((:PMPI_File_iread_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    PMPI_File_iread_all_c(fh, buf, count, datatype, request)

$(_doc_external(:PMPI_File_iread_all_c))
"""
function PMPI_File_iread_all_c(fh, buf, count, datatype, request)
    @mpichk ccall((:PMPI_File_iread_all_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    PMPI_File_iread_at_c(fh, offset, buf, count, datatype, request)

$(_doc_external(:PMPI_File_iread_at_c))
"""
function PMPI_File_iread_at_c(fh, offset, buf, count, datatype, request)
    @mpichk ccall((:PMPI_File_iread_at_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

"""
    PMPI_File_iread_at_all_c(fh, offset, buf, count, datatype, request)

$(_doc_external(:PMPI_File_iread_at_all_c))
"""
function PMPI_File_iread_at_all_c(fh, offset, buf, count, datatype, request)
    @mpichk ccall((:PMPI_File_iread_at_all_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

"""
    PMPI_File_iread_shared_c(fh, buf, count, datatype, request)

$(_doc_external(:PMPI_File_iread_shared_c))
"""
function PMPI_File_iread_shared_c(fh, buf, count, datatype, request)
    @mpichk ccall((:PMPI_File_iread_shared_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    PMPI_File_iwrite_c(fh, buf, count, datatype, request)

$(_doc_external(:PMPI_File_iwrite_c))
"""
function PMPI_File_iwrite_c(fh, buf, count, datatype, request)
    @mpichk ccall((:PMPI_File_iwrite_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    PMPI_File_iwrite_all_c(fh, buf, count, datatype, request)

$(_doc_external(:PMPI_File_iwrite_all_c))
"""
function PMPI_File_iwrite_all_c(fh, buf, count, datatype, request)
    @mpichk ccall((:PMPI_File_iwrite_all_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    PMPI_File_iwrite_at_c(fh, offset, buf, count, datatype, request)

$(_doc_external(:PMPI_File_iwrite_at_c))
"""
function PMPI_File_iwrite_at_c(fh, offset, buf, count, datatype, request)
    @mpichk ccall((:PMPI_File_iwrite_at_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

"""
    PMPI_File_iwrite_at_all_c(fh, offset, buf, count, datatype, request)

$(_doc_external(:PMPI_File_iwrite_at_all_c))
"""
function PMPI_File_iwrite_at_all_c(fh, offset, buf, count, datatype, request)
    @mpichk ccall((:PMPI_File_iwrite_at_all_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

"""
    PMPI_File_iwrite_shared_c(fh, buf, count, datatype, request)

$(_doc_external(:PMPI_File_iwrite_shared_c))
"""
function PMPI_File_iwrite_shared_c(fh, buf, count, datatype, request)
    @mpichk ccall((:PMPI_File_iwrite_shared_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    PMPI_File_get_type_extent_c(fh, datatype, extent)

$(_doc_external(:PMPI_File_get_type_extent_c))
"""
function PMPI_File_get_type_extent_c(fh, datatype, extent)
    @mpichk ccall((:PMPI_File_get_type_extent_c, libmpi), Cint, (MPI_File, MPI_Datatype, Ptr{MPI_Count}), fh, datatype, extent)
end

"""
    PMPI_Register_datarep_c(datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)

$(_doc_external(:PMPI_Register_datarep_c))
"""
function PMPI_Register_datarep_c(datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)
    @mpichk ccall((:PMPI_Register_datarep_c, libmpi), Cint, (Ptr{Cchar}, MPIPtr, MPIPtr, MPIPtr, MPIPtr), datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)
end

"""
    PMPI_File_f2c(arg1)

$(_doc_external(:PMPI_File_f2c))
"""
function PMPI_File_f2c(arg1)
    @mpichk ccall((:PMPI_File_f2c, libmpi), MPI_File, (MPI_Fint,), arg1)
end

"""
    PMPI_File_c2f(arg1)

$(_doc_external(:PMPI_File_c2f))
"""
function PMPI_File_c2f(arg1)
    @mpichk ccall((:PMPI_File_c2f, libmpi), MPI_Fint, (MPI_File,), arg1)
end
