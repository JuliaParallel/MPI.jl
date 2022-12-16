# WARNING: this signature file for MPICH_jll has been auto-generated, please edit MPI.jl/gen/src/MPIgenerator.jl instead !

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
    @mpichk ccall((:MPI_Type_create_keyval, libmpi), Cint, (MPI_Type_copy_attr_function, MPI_Type_delete_attr_function, Ptr{Cint}, MPIPtr), type_copy_attr_fn, type_delete_attr_fn, type_keyval, extra_state)
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
