# WARNING: this signature file for MPICH_jll has been auto-generated, please edit MPI.jl/gen/src/MPIgenerator.jl instead !

"""
    MPIR_Dup_fn(oldcomm, keyval, extra_state, attribute_val_in, attribute_val_out, flag)

- `MPIR_Dup_fn` man page `https://www.mpich.org/static/docs/latest/www3/MPIR_Dup_fn.html`
"""
function MPIR_Dup_fn(oldcomm, keyval, extra_state, attribute_val_in, attribute_val_out, flag)
    @mpichk ccall((:MPIR_Dup_fn, libmpi), Cint, (MPI_Comm, Cint, MPIPtr, MPIPtr, MPIPtr, Ptr{Cint}), oldcomm, keyval, extra_state, attribute_val_in, attribute_val_out, flag)
end

"""
    MPI_Wait(request, status)

- `MPI_Wait` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Wait.html`
"""
function MPI_Wait(request, status)
    @mpichk ccall((:MPI_Wait, libmpi), Cint, (Ptr{MPI_Request}, Ptr{MPI_Status}), request, status)
end

"""
    MPI_Test(request, flag, status)

- `MPI_Test` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Test.html`
"""
function MPI_Test(request, flag, status)
    @mpichk ccall((:MPI_Test, libmpi), Cint, (Ptr{MPI_Request}, Ptr{Cint}, Ptr{MPI_Status}), request, flag, status)
end

"""
    MPI_Status_c2f(c_status, f_status)

- `MPI_Status_c2f` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Status_c2f.html`
"""
function MPI_Status_c2f(c_status, f_status)
    @mpichk ccall((:MPI_Status_c2f, libmpi), Cint, (Ptr{MPI_Status}, Ptr{MPI_Fint}), c_status, f_status)
end

"""
    MPI_Status_f2c(f_status, c_status)

- `MPI_Status_f2c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Status_f2c.html`
"""
function MPI_Status_f2c(f_status, c_status)
    @mpichk ccall((:MPI_Status_f2c, libmpi), Cint, (Ptr{MPI_Fint}, Ptr{MPI_Status}), f_status, c_status)
end

"""
    MPI_Type_create_f90_integer(r, newtype)

- `MPI_Type_create_f90_integer` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_create_f90_integer.html`
"""
function MPI_Type_create_f90_integer(r, newtype)
    @mpichk ccall((:MPI_Type_create_f90_integer, libmpi), Cint, (Cint, Ptr{MPI_Datatype}), r, newtype)
end

"""
    MPI_Type_create_f90_real(p, r, newtype)

- `MPI_Type_create_f90_real` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_create_f90_real.html`
"""
function MPI_Type_create_f90_real(p, r, newtype)
    @mpichk ccall((:MPI_Type_create_f90_real, libmpi), Cint, (Cint, Cint, Ptr{MPI_Datatype}), p, r, newtype)
end

"""
    MPI_Type_create_f90_complex(p, r, newtype)

- `MPI_Type_create_f90_complex` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_create_f90_complex.html`
"""
function MPI_Type_create_f90_complex(p, r, newtype)
    @mpichk ccall((:MPI_Type_create_f90_complex, libmpi), Cint, (Cint, Cint, Ptr{MPI_Datatype}), p, r, newtype)
end

"""
    MPI_Attr_delete(comm, keyval)

- `MPI_Attr_delete` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Attr_delete.html`
"""
function MPI_Attr_delete(comm, keyval)
    @mpichk ccall((:MPI_Attr_delete, libmpi), Cint, (MPI_Comm, Cint), comm, keyval)
end

"""
    MPI_Attr_get(comm, keyval, attribute_val, flag)

- `MPI_Attr_get` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Attr_get.html`
"""
function MPI_Attr_get(comm, keyval, attribute_val, flag)
    @mpichk ccall((:MPI_Attr_get, libmpi), Cint, (MPI_Comm, Cint, MPIPtr, Ptr{Cint}), comm, keyval, attribute_val, flag)
end

"""
    MPI_Attr_put(comm, keyval, attribute_val)

- `MPI_Attr_put` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Attr_put.html`
"""
function MPI_Attr_put(comm, keyval, attribute_val)
    @mpichk ccall((:MPI_Attr_put, libmpi), Cint, (MPI_Comm, Cint, MPIPtr), comm, keyval, attribute_val)
end

"""
    MPI_Comm_create_keyval(comm_copy_attr_fn, comm_delete_attr_fn, comm_keyval, extra_state)

- `MPI_Comm_create_keyval` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_create_keyval.html`
"""
function MPI_Comm_create_keyval(comm_copy_attr_fn, comm_delete_attr_fn, comm_keyval, extra_state)
    @mpichk ccall((:MPI_Comm_create_keyval, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{Cint}, MPIPtr), comm_copy_attr_fn, comm_delete_attr_fn, comm_keyval, extra_state)
end

"""
    MPI_Comm_delete_attr(comm, comm_keyval)

- `MPI_Comm_delete_attr` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_delete_attr.html`
"""
function MPI_Comm_delete_attr(comm, comm_keyval)
    @mpichk ccall((:MPI_Comm_delete_attr, libmpi), Cint, (MPI_Comm, Cint), comm, comm_keyval)
end

"""
    MPI_Comm_free_keyval(comm_keyval)

- `MPI_Comm_free_keyval` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_free_keyval.html`
"""
function MPI_Comm_free_keyval(comm_keyval)
    @mpichk ccall((:MPI_Comm_free_keyval, libmpi), Cint, (Ptr{Cint},), comm_keyval)
end

"""
    MPI_Comm_get_attr(comm, comm_keyval, attribute_val, flag)

- `MPI_Comm_get_attr` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_get_attr.html`
"""
function MPI_Comm_get_attr(comm, comm_keyval, attribute_val, flag)
    @mpichk ccall((:MPI_Comm_get_attr, libmpi), Cint, (MPI_Comm, Cint, MPIPtr, Ptr{Cint}), comm, comm_keyval, attribute_val, flag)
end

"""
    MPI_Comm_set_attr(comm, comm_keyval, attribute_val)

- `MPI_Comm_set_attr` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_set_attr.html`
"""
function MPI_Comm_set_attr(comm, comm_keyval, attribute_val)
    @mpichk ccall((:MPI_Comm_set_attr, libmpi), Cint, (MPI_Comm, Cint, MPIPtr), comm, comm_keyval, attribute_val)
end

"""
    MPI_Keyval_create(copy_fn, delete_fn, keyval, extra_state)

- `MPI_Keyval_create` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Keyval_create.html`
"""
function MPI_Keyval_create(copy_fn, delete_fn, keyval, extra_state)
    @mpichk ccall((:MPI_Keyval_create, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{Cint}, MPIPtr), copy_fn, delete_fn, keyval, extra_state)
end

"""
    MPI_Keyval_free(keyval)

- `MPI_Keyval_free` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Keyval_free.html`
"""
function MPI_Keyval_free(keyval)
    @mpichk ccall((:MPI_Keyval_free, libmpi), Cint, (Ptr{Cint},), keyval)
end

"""
    MPI_Type_create_keyval(type_copy_attr_fn, type_delete_attr_fn, type_keyval, extra_state)

- `MPI_Type_create_keyval` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_create_keyval.html`
"""
function MPI_Type_create_keyval(type_copy_attr_fn, type_delete_attr_fn, type_keyval, extra_state)
    @mpichk ccall((:MPI_Type_create_keyval, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{Cint}, MPIPtr), type_copy_attr_fn, type_delete_attr_fn, type_keyval, extra_state)
end

"""
    MPI_Type_delete_attr(datatype, type_keyval)

- `MPI_Type_delete_attr` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_delete_attr.html`
"""
function MPI_Type_delete_attr(datatype, type_keyval)
    @mpichk ccall((:MPI_Type_delete_attr, libmpi), Cint, (MPI_Datatype, Cint), datatype, type_keyval)
end

"""
    MPI_Type_free_keyval(type_keyval)

- `MPI_Type_free_keyval` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_free_keyval.html`
"""
function MPI_Type_free_keyval(type_keyval)
    @mpichk ccall((:MPI_Type_free_keyval, libmpi), Cint, (Ptr{Cint},), type_keyval)
end

"""
    MPI_Type_get_attr(datatype, type_keyval, attribute_val, flag)

- `MPI_Type_get_attr` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_get_attr.html`
"""
function MPI_Type_get_attr(datatype, type_keyval, attribute_val, flag)
    @mpichk ccall((:MPI_Type_get_attr, libmpi), Cint, (MPI_Datatype, Cint, MPIPtr, Ptr{Cint}), datatype, type_keyval, attribute_val, flag)
end

"""
    MPI_Type_set_attr(datatype, type_keyval, attribute_val)

- `MPI_Type_set_attr` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_set_attr.html`
"""
function MPI_Type_set_attr(datatype, type_keyval, attribute_val)
    @mpichk ccall((:MPI_Type_set_attr, libmpi), Cint, (MPI_Datatype, Cint, MPIPtr), datatype, type_keyval, attribute_val)
end

"""
    MPI_Win_create_keyval(win_copy_attr_fn, win_delete_attr_fn, win_keyval, extra_state)

- `MPI_Win_create_keyval` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_create_keyval.html`
"""
function MPI_Win_create_keyval(win_copy_attr_fn, win_delete_attr_fn, win_keyval, extra_state)
    @mpichk ccall((:MPI_Win_create_keyval, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{Cint}, MPIPtr), win_copy_attr_fn, win_delete_attr_fn, win_keyval, extra_state)
end

"""
    MPI_Win_delete_attr(win, win_keyval)

- `MPI_Win_delete_attr` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_delete_attr.html`
"""
function MPI_Win_delete_attr(win, win_keyval)
    @mpichk ccall((:MPI_Win_delete_attr, libmpi), Cint, (MPI_Win, Cint), win, win_keyval)
end

"""
    MPI_Win_free_keyval(win_keyval)

- `MPI_Win_free_keyval` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_free_keyval.html`
"""
function MPI_Win_free_keyval(win_keyval)
    @mpichk ccall((:MPI_Win_free_keyval, libmpi), Cint, (Ptr{Cint},), win_keyval)
end

"""
    MPI_Win_get_attr(win, win_keyval, attribute_val, flag)

- `MPI_Win_get_attr` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_get_attr.html`
"""
function MPI_Win_get_attr(win, win_keyval, attribute_val, flag)
    @mpichk ccall((:MPI_Win_get_attr, libmpi), Cint, (MPI_Win, Cint, MPIPtr, Ptr{Cint}), win, win_keyval, attribute_val, flag)
end

"""
    MPI_Win_set_attr(win, win_keyval, attribute_val)

- `MPI_Win_set_attr` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_set_attr.html`
"""
function MPI_Win_set_attr(win, win_keyval, attribute_val)
    @mpichk ccall((:MPI_Win_set_attr, libmpi), Cint, (MPI_Win, Cint, MPIPtr), win, win_keyval, attribute_val)
end

"""
    MPI_Allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

- `MPI_Allgather` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Allgather.html`
"""
function MPI_Allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:MPI_Allgather, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

"""
    MPI_Allgather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

- `MPI_Allgather_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Allgather_init.html`
"""
function MPI_Allgather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Allgather_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    MPI_Allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)

- `MPI_Allgatherv` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Allgatherv.html`
"""
function MPI_Allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    @mpichk ccall((:MPI_Allgatherv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

"""
    MPI_Allgatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)

- `MPI_Allgatherv_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Allgatherv_init.html`
"""
function MPI_Allgatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Allgatherv_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
end

"""
    MPI_Allreduce(sendbuf, recvbuf, count, datatype, op, comm)

- `MPI_Allreduce` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Allreduce.html`
"""
function MPI_Allreduce(sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk ccall((:MPI_Allreduce, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

"""
    MPI_Allreduce_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)

- `MPI_Allreduce_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Allreduce_init.html`
"""
function MPI_Allreduce_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk ccall((:MPI_Allreduce_init, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

"""
    MPI_Alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

- `MPI_Alltoall` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Alltoall.html`
"""
function MPI_Alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:MPI_Alltoall, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

"""
    MPI_Alltoall_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

- `MPI_Alltoall_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Alltoall_init.html`
"""
function MPI_Alltoall_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Alltoall_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    MPI_Alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)

- `MPI_Alltoallv` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Alltoallv.html`
"""
function MPI_Alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    @mpichk ccall((:MPI_Alltoallv, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

"""
    MPI_Alltoallv_init(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)

- `MPI_Alltoallv_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Alltoallv_init.html`
"""
function MPI_Alltoallv_init(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Alltoallv_init, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
end

"""
    MPI_Alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)

- `MPI_Alltoallw` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Alltoallw.html`
"""
function MPI_Alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    @mpichk ccall((:MPI_Alltoallw, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPI_Comm), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

"""
    MPI_Alltoallw_init(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)

- `MPI_Alltoallw_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Alltoallw_init.html`
"""
function MPI_Alltoallw_init(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    @mpichk ccall((:MPI_Alltoallw_init, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
end

"""
    MPI_Barrier(comm)

- `MPI_Barrier` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Barrier.html`
"""
function MPI_Barrier(comm)
    @mpichk ccall((:MPI_Barrier, libmpi), Cint, (MPI_Comm,), comm)
end

"""
    MPI_Barrier_init(comm, info, request)

- `MPI_Barrier_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Barrier_init.html`
"""
function MPI_Barrier_init(comm, info, request)
    @mpichk ccall((:MPI_Barrier_init, libmpi), Cint, (MPI_Comm, MPI_Info, Ptr{MPI_Request}), comm, info, request)
end

"""
    MPI_Bcast(buffer, count, datatype, root, comm)

- `MPI_Bcast` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Bcast.html`
"""
function MPI_Bcast(buffer, count, datatype, root, comm)
    @mpichk ccall((:MPI_Bcast, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm), buffer, count, datatype, root, comm)
end

"""
    MPI_Bcast_init(buffer, count, datatype, root, comm, info, request)

- `MPI_Bcast_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Bcast_init.html`
"""
function MPI_Bcast_init(buffer, count, datatype, root, comm, info, request)
    @mpichk ccall((:MPI_Bcast_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), buffer, count, datatype, root, comm, info, request)
end

"""
    MPI_Exscan(sendbuf, recvbuf, count, datatype, op, comm)

- `MPI_Exscan` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Exscan.html`
"""
function MPI_Exscan(sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk ccall((:MPI_Exscan, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

"""
    MPI_Exscan_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)

- `MPI_Exscan_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Exscan_init.html`
"""
function MPI_Exscan_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk ccall((:MPI_Exscan_init, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

"""
    MPI_Gather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)

- `MPI_Gather` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Gather.html`
"""
function MPI_Gather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk ccall((:MPI_Gather, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

"""
    MPI_Gather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

- `MPI_Gather_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Gather_init.html`
"""
function MPI_Gather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk ccall((:MPI_Gather_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

"""
    MPI_Gatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)

- `MPI_Gatherv` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Gatherv.html`
"""
function MPI_Gatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
    @mpichk ccall((:MPI_Gatherv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
end

"""
    MPI_Gatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)

- `MPI_Gatherv_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Gatherv_init.html`
"""
function MPI_Gatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
    @mpichk ccall((:MPI_Gatherv_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
end

"""
    MPI_Iallgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

- `MPI_Iallgather` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Iallgather.html`
"""
function MPI_Iallgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:MPI_Iallgather, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    MPI_Iallgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)

- `MPI_Iallgatherv` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Iallgatherv.html`
"""
function MPI_Iallgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    @mpichk ccall((:MPI_Iallgatherv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

"""
    MPI_Iallreduce(sendbuf, recvbuf, count, datatype, op, comm, request)

- `MPI_Iallreduce` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Iallreduce.html`
"""
function MPI_Iallreduce(sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk ccall((:MPI_Iallreduce, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

"""
    MPI_Ialltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

- `MPI_Ialltoall` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ialltoall.html`
"""
function MPI_Ialltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:MPI_Ialltoall, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    MPI_Ialltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)

- `MPI_Ialltoallv` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ialltoallv.html`
"""
function MPI_Ialltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    @mpichk ccall((:MPI_Ialltoallv, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

"""
    MPI_Ialltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)

- `MPI_Ialltoallw` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ialltoallw.html`
"""
function MPI_Ialltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    @mpichk ccall((:MPI_Ialltoallw, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

"""
    MPI_Ibarrier(comm, request)

- `MPI_Ibarrier` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ibarrier.html`
"""
function MPI_Ibarrier(comm, request)
    @mpichk ccall((:MPI_Ibarrier, libmpi), Cint, (MPI_Comm, Ptr{MPI_Request}), comm, request)
end

"""
    MPI_Ibcast(buffer, count, datatype, root, comm, request)

- `MPI_Ibcast` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ibcast.html`
"""
function MPI_Ibcast(buffer, count, datatype, root, comm, request)
    @mpichk ccall((:MPI_Ibcast, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), buffer, count, datatype, root, comm, request)
end

"""
    MPI_Iexscan(sendbuf, recvbuf, count, datatype, op, comm, request)

- `MPI_Iexscan` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Iexscan.html`
"""
function MPI_Iexscan(sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk ccall((:MPI_Iexscan, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

"""
    MPI_Igather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

- `MPI_Igather` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Igather.html`
"""
function MPI_Igather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk ccall((:MPI_Igather, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

"""
    MPI_Igatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)

- `MPI_Igatherv` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Igatherv.html`
"""
function MPI_Igatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
    @mpichk ccall((:MPI_Igatherv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
end

"""
    MPI_Ineighbor_allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

- `MPI_Ineighbor_allgather` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ineighbor_allgather.html`
"""
function MPI_Ineighbor_allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:MPI_Ineighbor_allgather, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    MPI_Ineighbor_allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)

- `MPI_Ineighbor_allgatherv` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ineighbor_allgatherv.html`
"""
function MPI_Ineighbor_allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    @mpichk ccall((:MPI_Ineighbor_allgatherv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

"""
    MPI_Ineighbor_alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

- `MPI_Ineighbor_alltoall` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ineighbor_alltoall.html`
"""
function MPI_Ineighbor_alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:MPI_Ineighbor_alltoall, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    MPI_Ineighbor_alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)

- `MPI_Ineighbor_alltoallv` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ineighbor_alltoallv.html`
"""
function MPI_Ineighbor_alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    @mpichk ccall((:MPI_Ineighbor_alltoallv, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

"""
    MPI_Ineighbor_alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)

- `MPI_Ineighbor_alltoallw` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ineighbor_alltoallw.html`
"""
function MPI_Ineighbor_alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    @mpichk ccall((:MPI_Ineighbor_alltoallw, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

"""
    MPI_Ireduce(sendbuf, recvbuf, count, datatype, op, root, comm, request)

- `MPI_Ireduce` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ireduce.html`
"""
function MPI_Ireduce(sendbuf, recvbuf, count, datatype, op, root, comm, request)
    @mpichk ccall((:MPI_Ireduce, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, root, comm, request)
end

"""
    MPI_Ireduce_scatter(sendbuf, recvbuf, recvcounts, datatype, op, comm, request)

- `MPI_Ireduce_scatter` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ireduce_scatter.html`
"""
function MPI_Ireduce_scatter(sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
    @mpichk ccall((:MPI_Ireduce_scatter, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{Cint}, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
end

"""
    MPI_Ireduce_scatter_block(sendbuf, recvbuf, recvcount, datatype, op, comm, request)

- `MPI_Ireduce_scatter_block` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ireduce_scatter_block.html`
"""
function MPI_Ireduce_scatter_block(sendbuf, recvbuf, recvcount, datatype, op, comm, request)
    @mpichk ccall((:MPI_Ireduce_scatter_block, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, recvcount, datatype, op, comm, request)
end

"""
    MPI_Iscan(sendbuf, recvbuf, count, datatype, op, comm, request)

- `MPI_Iscan` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Iscan.html`
"""
function MPI_Iscan(sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk ccall((:MPI_Iscan, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

"""
    MPI_Iscatter(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

- `MPI_Iscatter` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Iscatter.html`
"""
function MPI_Iscatter(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk ccall((:MPI_Iscatter, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

"""
    MPI_Iscatterv(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

- `MPI_Iscatterv` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Iscatterv.html`
"""
function MPI_Iscatterv(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk ccall((:MPI_Iscatterv, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

"""
    MPI_Neighbor_allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

- `MPI_Neighbor_allgather` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Neighbor_allgather.html`
"""
function MPI_Neighbor_allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:MPI_Neighbor_allgather, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm) v"3.0.0"
end

"""
    MPI_Neighbor_allgather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

- `MPI_Neighbor_allgather_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Neighbor_allgather_init.html`
"""
function MPI_Neighbor_allgather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Neighbor_allgather_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    MPI_Neighbor_allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)

- `MPI_Neighbor_allgatherv` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Neighbor_allgatherv.html`
"""
function MPI_Neighbor_allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    @mpichk ccall((:MPI_Neighbor_allgatherv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm) v"3.0.0"
end

"""
    MPI_Neighbor_allgatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)

- `MPI_Neighbor_allgatherv_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Neighbor_allgatherv_init.html`
"""
function MPI_Neighbor_allgatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Neighbor_allgatherv_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
end

"""
    MPI_Neighbor_alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

- `MPI_Neighbor_alltoall` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Neighbor_alltoall.html`
"""
function MPI_Neighbor_alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:MPI_Neighbor_alltoall, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm) v"3.0.0"
end

"""
    MPI_Neighbor_alltoall_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

- `MPI_Neighbor_alltoall_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Neighbor_alltoall_init.html`
"""
function MPI_Neighbor_alltoall_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Neighbor_alltoall_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    MPI_Neighbor_alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)

- `MPI_Neighbor_alltoallv` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Neighbor_alltoallv.html`
"""
function MPI_Neighbor_alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    @mpichk ccall((:MPI_Neighbor_alltoallv, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm) v"3.0.0"
end

"""
    MPI_Neighbor_alltoallv_init(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)

- `MPI_Neighbor_alltoallv_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Neighbor_alltoallv_init.html`
"""
function MPI_Neighbor_alltoallv_init(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Neighbor_alltoallv_init, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
end

"""
    MPI_Neighbor_alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)

- `MPI_Neighbor_alltoallw` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Neighbor_alltoallw.html`
"""
function MPI_Neighbor_alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    @mpichk ccall((:MPI_Neighbor_alltoallw, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

"""
    MPI_Neighbor_alltoallw_init(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)

- `MPI_Neighbor_alltoallw_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Neighbor_alltoallw_init.html`
"""
function MPI_Neighbor_alltoallw_init(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    @mpichk ccall((:MPI_Neighbor_alltoallw_init, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
end

"""
    MPI_Reduce(sendbuf, recvbuf, count, datatype, op, root, comm)

- `MPI_Reduce` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Reduce.html`
"""
function MPI_Reduce(sendbuf, recvbuf, count, datatype, op, root, comm)
    @mpichk ccall((:MPI_Reduce, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm), sendbuf, recvbuf, count, datatype, op, root, comm)
end

"""
    MPI_Reduce_init(sendbuf, recvbuf, count, datatype, op, root, comm, info, request)

- `MPI_Reduce_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Reduce_init.html`
"""
function MPI_Reduce_init(sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
    @mpichk ccall((:MPI_Reduce_init, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
end

"""
    MPI_Reduce_local(inbuf, inoutbuf, count, datatype, op)

- `MPI_Reduce_local` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Reduce_local.html`
"""
function MPI_Reduce_local(inbuf, inoutbuf, count, datatype, op)
    @mpichk ccall((:MPI_Reduce_local, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op), inbuf, inoutbuf, count, datatype, op)
end

"""
    MPI_Reduce_scatter(sendbuf, recvbuf, recvcounts, datatype, op, comm)

- `MPI_Reduce_scatter` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Reduce_scatter.html`
"""
function MPI_Reduce_scatter(sendbuf, recvbuf, recvcounts, datatype, op, comm)
    @mpichk ccall((:MPI_Reduce_scatter, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{Cint}, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, recvcounts, datatype, op, comm)
end

"""
    MPI_Reduce_scatter_block(sendbuf, recvbuf, recvcount, datatype, op, comm)

- `MPI_Reduce_scatter_block` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Reduce_scatter_block.html`
"""
function MPI_Reduce_scatter_block(sendbuf, recvbuf, recvcount, datatype, op, comm)
    @mpichk ccall((:MPI_Reduce_scatter_block, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, recvcount, datatype, op, comm)
end

"""
    MPI_Reduce_scatter_block_init(sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)

- `MPI_Reduce_scatter_block_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Reduce_scatter_block_init.html`
"""
function MPI_Reduce_scatter_block_init(sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
    @mpichk ccall((:MPI_Reduce_scatter_block_init, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
end

"""
    MPI_Reduce_scatter_init(sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)

- `MPI_Reduce_scatter_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Reduce_scatter_init.html`
"""
function MPI_Reduce_scatter_init(sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
    @mpichk ccall((:MPI_Reduce_scatter_init, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{Cint}, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
end

"""
    MPI_Scan(sendbuf, recvbuf, count, datatype, op, comm)

- `MPI_Scan` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Scan.html`
"""
function MPI_Scan(sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk ccall((:MPI_Scan, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

"""
    MPI_Scan_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)

- `MPI_Scan_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Scan_init.html`
"""
function MPI_Scan_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk ccall((:MPI_Scan_init, libmpi), Cint, (MPIPtr, MPIPtr, Cint, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

"""
    MPI_Scatter(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)

- `MPI_Scatter` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Scatter.html`
"""
function MPI_Scatter(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk ccall((:MPI_Scatter, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

"""
    MPI_Scatter_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

- `MPI_Scatter_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Scatter_init.html`
"""
function MPI_Scatter_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk ccall((:MPI_Scatter_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

"""
    MPI_Scatterv(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)

- `MPI_Scatterv` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Scatterv.html`
"""
function MPI_Scatterv(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk ccall((:MPI_Scatterv, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

"""
    MPI_Scatterv_init(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

- `MPI_Scatterv_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Scatterv_init.html`
"""
function MPI_Scatterv_init(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk ccall((:MPI_Scatterv_init, libmpi), Cint, (MPIPtr, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

"""
    MPI_Comm_compare(comm1, comm2, result)

- `MPI_Comm_compare` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_compare.html`
"""
function MPI_Comm_compare(comm1, comm2, result)
    @mpichk ccall((:MPI_Comm_compare, libmpi), Cint, (MPI_Comm, MPI_Comm, Ptr{Cint}), comm1, comm2, result)
end

"""
    MPI_Comm_create(comm, group, newcomm)

- `MPI_Comm_create` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_create.html`
"""
function MPI_Comm_create(comm, group, newcomm)
    @mpichk ccall((:MPI_Comm_create, libmpi), Cint, (MPI_Comm, MPI_Group, Ptr{MPI_Comm}), comm, group, newcomm)
end

"""
    MPI_Comm_create_group(comm, group, tag, newcomm)

- `MPI_Comm_create_group` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_create_group.html`
"""
function MPI_Comm_create_group(comm, group, tag, newcomm)
    @mpichk ccall((:MPI_Comm_create_group, libmpi), Cint, (MPI_Comm, MPI_Group, Cint, Ptr{MPI_Comm}), comm, group, tag, newcomm)
end

"""
    MPI_Comm_dup(comm, newcomm)

- `MPI_Comm_dup` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_dup.html`
"""
function MPI_Comm_dup(comm, newcomm)
    @mpichk ccall((:MPI_Comm_dup, libmpi), Cint, (MPI_Comm, Ptr{MPI_Comm}), comm, newcomm)
end

"""
    MPI_Comm_dup_with_info(comm, info, newcomm)

- `MPI_Comm_dup_with_info` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_dup_with_info.html`
"""
function MPI_Comm_dup_with_info(comm, info, newcomm)
    @mpichk ccall((:MPI_Comm_dup_with_info, libmpi), Cint, (MPI_Comm, MPI_Info, Ptr{MPI_Comm}), comm, info, newcomm)
end

"""
    MPI_Comm_free(comm)

- `MPI_Comm_free` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_free.html`
"""
function MPI_Comm_free(comm)
    @mpichk ccall((:MPI_Comm_free, libmpi), Cint, (Ptr{MPI_Comm},), comm)
end

"""
    MPI_Comm_get_info(comm, info_used)

- `MPI_Comm_get_info` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_get_info.html`
"""
function MPI_Comm_get_info(comm, info_used)
    @mpichk ccall((:MPI_Comm_get_info, libmpi), Cint, (MPI_Comm, Ptr{MPI_Info}), comm, info_used)
end

"""
    MPI_Comm_get_name(comm, comm_name, resultlen)

- `MPI_Comm_get_name` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_get_name.html`
"""
function MPI_Comm_get_name(comm, comm_name, resultlen)
    @mpichk ccall((:MPI_Comm_get_name, libmpi), Cint, (MPI_Comm, Ptr{Cchar}, Ptr{Cint}), comm, comm_name, resultlen)
end

"""
    MPI_Comm_group(comm, group)

- `MPI_Comm_group` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_group.html`
"""
function MPI_Comm_group(comm, group)
    @mpichk ccall((:MPI_Comm_group, libmpi), Cint, (MPI_Comm, Ptr{MPI_Group}), comm, group)
end

"""
    MPI_Comm_idup(comm, newcomm, request)

- `MPI_Comm_idup` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_idup.html`
"""
function MPI_Comm_idup(comm, newcomm, request)
    @mpichk ccall((:MPI_Comm_idup, libmpi), Cint, (MPI_Comm, Ptr{MPI_Comm}, Ptr{MPI_Request}), comm, newcomm, request)
end

"""
    MPI_Comm_idup_with_info(comm, info, newcomm, request)

- `MPI_Comm_idup_with_info` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_idup_with_info.html`
"""
function MPI_Comm_idup_with_info(comm, info, newcomm, request)
    @mpichk ccall((:MPI_Comm_idup_with_info, libmpi), Cint, (MPI_Comm, MPI_Info, Ptr{MPI_Comm}, Ptr{MPI_Request}), comm, info, newcomm, request)
end

"""
    MPI_Comm_rank(comm, rank)

- `MPI_Comm_rank` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_rank.html`
"""
function MPI_Comm_rank(comm, rank)
    @mpichk ccall((:MPI_Comm_rank, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, rank)
end

"""
    MPI_Comm_remote_group(comm, group)

- `MPI_Comm_remote_group` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_remote_group.html`
"""
function MPI_Comm_remote_group(comm, group)
    @mpichk ccall((:MPI_Comm_remote_group, libmpi), Cint, (MPI_Comm, Ptr{MPI_Group}), comm, group)
end

"""
    MPI_Comm_remote_size(comm, size)

- `MPI_Comm_remote_size` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_remote_size.html`
"""
function MPI_Comm_remote_size(comm, size)
    @mpichk ccall((:MPI_Comm_remote_size, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, size)
end

"""
    MPI_Comm_set_info(comm, info)

- `MPI_Comm_set_info` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_set_info.html`
"""
function MPI_Comm_set_info(comm, info)
    @mpichk ccall((:MPI_Comm_set_info, libmpi), Cint, (MPI_Comm, MPI_Info), comm, info)
end

"""
    MPI_Comm_set_name(comm, comm_name)

- `MPI_Comm_set_name` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_set_name.html`
"""
function MPI_Comm_set_name(comm, comm_name)
    @mpichk ccall((:MPI_Comm_set_name, libmpi), Cint, (MPI_Comm, Ptr{Cchar}), comm, comm_name)
end

"""
    MPI_Comm_size(comm, size)

- `MPI_Comm_size` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_size.html`
"""
function MPI_Comm_size(comm, size)
    @mpichk ccall((:MPI_Comm_size, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, size)
end

"""
    MPI_Comm_split(comm, color, key, newcomm)

- `MPI_Comm_split` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_split.html`
"""
function MPI_Comm_split(comm, color, key, newcomm)
    @mpichk ccall((:MPI_Comm_split, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{MPI_Comm}), comm, color, key, newcomm)
end

"""
    MPI_Comm_split_type(comm, split_type, key, info, newcomm)

- `MPI_Comm_split_type` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_split_type.html`
"""
function MPI_Comm_split_type(comm, split_type, key, info, newcomm)
    @mpichk ccall((:MPI_Comm_split_type, libmpi), Cint, (MPI_Comm, Cint, Cint, MPI_Info, Ptr{MPI_Comm}), comm, split_type, key, info, newcomm)
end

"""
    MPI_Comm_test_inter(comm, flag)

- `MPI_Comm_test_inter` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_test_inter.html`
"""
function MPI_Comm_test_inter(comm, flag)
    @mpichk ccall((:MPI_Comm_test_inter, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, flag)
end

"""
    MPI_Intercomm_create(local_comm, local_leader, peer_comm, remote_leader, tag, newintercomm)

- `MPI_Intercomm_create` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Intercomm_create.html`
"""
function MPI_Intercomm_create(local_comm, local_leader, peer_comm, remote_leader, tag, newintercomm)
    @mpichk ccall((:MPI_Intercomm_create, libmpi), Cint, (MPI_Comm, Cint, MPI_Comm, Cint, Cint, Ptr{MPI_Comm}), local_comm, local_leader, peer_comm, remote_leader, tag, newintercomm)
end

"""
    MPI_Intercomm_create_from_groups(local_group, local_leader, remote_group, remote_leader, stringtag, info, errhandler, newintercomm)

- `MPI_Intercomm_create_from_groups` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Intercomm_create_from_groups.html`
"""
function MPI_Intercomm_create_from_groups(local_group, local_leader, remote_group, remote_leader, stringtag, info, errhandler, newintercomm)
    @mpichk ccall((:MPI_Intercomm_create_from_groups, libmpi), Cint, (MPI_Group, Cint, MPI_Group, Cint, Ptr{Cchar}, MPI_Info, MPI_Errhandler, Ptr{MPI_Comm}), local_group, local_leader, remote_group, remote_leader, stringtag, info, errhandler, newintercomm)
end

"""
    MPI_Intercomm_merge(intercomm, high, newintracomm)

- `MPI_Intercomm_merge` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Intercomm_merge.html`
"""
function MPI_Intercomm_merge(intercomm, high, newintracomm)
    @mpichk ccall((:MPI_Intercomm_merge, libmpi), Cint, (MPI_Comm, Cint, Ptr{MPI_Comm}), intercomm, high, newintracomm)
end

"""
    MPI_Get_address(location, address)

- `MPI_Get_address` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Get_address.html`
"""
function MPI_Get_address(location, address)
    @mpichk ccall((:MPI_Get_address, libmpi), Cint, (MPIPtr, Ptr{MPI_Aint}), location, address)
end

"""
    MPI_Get_count(status, datatype, count)

- `MPI_Get_count` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Get_count.html`
"""
function MPI_Get_count(status, datatype, count)
    @mpichk ccall((:MPI_Get_count, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Ptr{Cint}), status, datatype, count)
end

"""
    MPI_Get_elements(status, datatype, count)

- `MPI_Get_elements` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Get_elements.html`
"""
function MPI_Get_elements(status, datatype, count)
    @mpichk ccall((:MPI_Get_elements, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Ptr{Cint}), status, datatype, count)
end

"""
    MPI_Get_elements_x(status, datatype, count)

- `MPI_Get_elements_x` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Get_elements_x.html`
"""
function MPI_Get_elements_x(status, datatype, count)
    @mpichk ccall((:MPI_Get_elements_x, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Ptr{MPI_Count}), status, datatype, count)
end

"""
    MPI_Pack(inbuf, incount, datatype, outbuf, outsize, position, comm)

- `MPI_Pack` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Pack.html`
"""
function MPI_Pack(inbuf, incount, datatype, outbuf, outsize, position, comm)
    @mpichk ccall((:MPI_Pack, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, Ptr{Cint}, MPI_Comm), inbuf, incount, datatype, outbuf, outsize, position, comm)
end

"""
    MPI_Pack_external(datarep, inbuf, incount, datatype, outbuf, outsize, position)

- `MPI_Pack_external` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Pack_external.html`
"""
function MPI_Pack_external(datarep, inbuf, incount, datatype, outbuf, outsize, position)
    @mpichk ccall((:MPI_Pack_external, libmpi), Cint, (Ptr{Cchar}, MPIPtr, Cint, MPI_Datatype, MPIPtr, MPI_Aint, Ptr{MPI_Aint}), datarep, inbuf, incount, datatype, outbuf, outsize, position)
end

"""
    MPI_Pack_external_size(datarep, incount, datatype, size)

- `MPI_Pack_external_size` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Pack_external_size.html`
"""
function MPI_Pack_external_size(datarep, incount, datatype, size)
    @mpichk ccall((:MPI_Pack_external_size, libmpi), Cint, (Ptr{Cchar}, Cint, MPI_Datatype, Ptr{MPI_Aint}), datarep, incount, datatype, size)
end

"""
    MPI_Pack_size(incount, datatype, comm, size)

- `MPI_Pack_size` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Pack_size.html`
"""
function MPI_Pack_size(incount, datatype, comm, size)
    @mpichk ccall((:MPI_Pack_size, libmpi), Cint, (Cint, MPI_Datatype, MPI_Comm, Ptr{Cint}), incount, datatype, comm, size)
end

"""
    MPI_Status_set_elements(status, datatype, count)

- `MPI_Status_set_elements` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Status_set_elements.html`
"""
function MPI_Status_set_elements(status, datatype, count)
    @mpichk ccall((:MPI_Status_set_elements, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Cint), status, datatype, count)
end

"""
    MPI_Status_set_elements_x(status, datatype, count)

- `MPI_Status_set_elements_x` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Status_set_elements_x.html`
"""
function MPI_Status_set_elements_x(status, datatype, count)
    @mpichk ccall((:MPI_Status_set_elements_x, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, MPI_Count), status, datatype, count)
end

"""
    MPI_Type_commit(datatype)

- `MPI_Type_commit` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_commit.html`
"""
function MPI_Type_commit(datatype)
    @mpichk ccall((:MPI_Type_commit, libmpi), Cint, (Ptr{MPI_Datatype},), datatype)
end

"""
    MPI_Type_contiguous(count, oldtype, newtype)

- `MPI_Type_contiguous` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_contiguous.html`
"""
function MPI_Type_contiguous(count, oldtype, newtype)
    @mpichk ccall((:MPI_Type_contiguous, libmpi), Cint, (Cint, MPI_Datatype, Ptr{MPI_Datatype}), count, oldtype, newtype)
end

"""
    MPI_Type_create_darray(size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)

- `MPI_Type_create_darray` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_create_darray.html`
"""
function MPI_Type_create_darray(size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
    @mpichk ccall((:MPI_Type_create_darray, libmpi), Cint, (Cint, Cint, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
end

"""
    MPI_Type_create_hindexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)

- `MPI_Type_create_hindexed` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_create_hindexed.html`
"""
function MPI_Type_create_hindexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:MPI_Type_create_hindexed, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

"""
    MPI_Type_create_hindexed_block(count, blocklength, array_of_displacements, oldtype, newtype)

- `MPI_Type_create_hindexed_block` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_create_hindexed_block.html`
"""
function MPI_Type_create_hindexed_block(count, blocklength, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:MPI_Type_create_hindexed_block, libmpi), Cint, (Cint, Cint, Ptr{MPI_Aint}, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, array_of_displacements, oldtype, newtype)
end

"""
    MPI_Type_create_hvector(count, blocklength, stride, oldtype, newtype)

- `MPI_Type_create_hvector` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_create_hvector.html`
"""
function MPI_Type_create_hvector(count, blocklength, stride, oldtype, newtype)
    @mpichk ccall((:MPI_Type_create_hvector, libmpi), Cint, (Cint, Cint, MPI_Aint, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

"""
    MPI_Type_create_indexed_block(count, blocklength, array_of_displacements, oldtype, newtype)

- `MPI_Type_create_indexed_block` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_create_indexed_block.html`
"""
function MPI_Type_create_indexed_block(count, blocklength, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:MPI_Type_create_indexed_block, libmpi), Cint, (Cint, Cint, Ptr{Cint}, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, array_of_displacements, oldtype, newtype)
end

"""
    MPI_Type_create_resized(oldtype, lb, extent, newtype)

- `MPI_Type_create_resized` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_create_resized.html`
"""
function MPI_Type_create_resized(oldtype, lb, extent, newtype)
    @mpichk ccall((:MPI_Type_create_resized, libmpi), Cint, (MPI_Datatype, MPI_Aint, MPI_Aint, Ptr{MPI_Datatype}), oldtype, lb, extent, newtype)
end

"""
    MPI_Type_create_struct(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)

- `MPI_Type_create_struct` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_create_struct.html`
"""
function MPI_Type_create_struct(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
    @mpichk ccall((:MPI_Type_create_struct, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
end

"""
    MPI_Type_create_subarray(ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)

- `MPI_Type_create_subarray` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_create_subarray.html`
"""
function MPI_Type_create_subarray(ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
    @mpichk ccall((:MPI_Type_create_subarray, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
end

"""
    MPI_Type_dup(oldtype, newtype)

- `MPI_Type_dup` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_dup.html`
"""
function MPI_Type_dup(oldtype, newtype)
    @mpichk ccall((:MPI_Type_dup, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Datatype}), oldtype, newtype)
end

"""
    MPI_Type_free(datatype)

- `MPI_Type_free` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_free.html`
"""
function MPI_Type_free(datatype)
    @mpichk ccall((:MPI_Type_free, libmpi), Cint, (Ptr{MPI_Datatype},), datatype)
end

"""
    MPI_Type_get_contents(datatype, max_integers, max_addresses, max_datatypes, array_of_integers, array_of_addresses, array_of_datatypes)

- `MPI_Type_get_contents` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_get_contents.html`
"""
function MPI_Type_get_contents(datatype, max_integers, max_addresses, max_datatypes, array_of_integers, array_of_addresses, array_of_datatypes)
    @mpichk ccall((:MPI_Type_get_contents, libmpi), Cint, (MPI_Datatype, Cint, Cint, Cint, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}), datatype, max_integers, max_addresses, max_datatypes, array_of_integers, array_of_addresses, array_of_datatypes)
end

"""
    MPI_Type_get_envelope(datatype, num_integers, num_addresses, num_datatypes, combiner)

- `MPI_Type_get_envelope` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_get_envelope.html`
"""
function MPI_Type_get_envelope(datatype, num_integers, num_addresses, num_datatypes, combiner)
    @mpichk ccall((:MPI_Type_get_envelope, libmpi), Cint, (MPI_Datatype, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), datatype, num_integers, num_addresses, num_datatypes, combiner)
end

"""
    MPI_Type_get_extent(datatype, lb, extent)

- `MPI_Type_get_extent` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_get_extent.html`
"""
function MPI_Type_get_extent(datatype, lb, extent)
    @mpichk ccall((:MPI_Type_get_extent, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Aint}, Ptr{MPI_Aint}), datatype, lb, extent)
end

"""
    MPI_Type_get_extent_x(datatype, lb, extent)

- `MPI_Type_get_extent_x` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_get_extent_x.html`
"""
function MPI_Type_get_extent_x(datatype, lb, extent)
    @mpichk ccall((:MPI_Type_get_extent_x, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), datatype, lb, extent)
end

"""
    MPI_Type_get_name(datatype, type_name, resultlen)

- `MPI_Type_get_name` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_get_name.html`
"""
function MPI_Type_get_name(datatype, type_name, resultlen)
    @mpichk ccall((:MPI_Type_get_name, libmpi), Cint, (MPI_Datatype, Ptr{Cchar}, Ptr{Cint}), datatype, type_name, resultlen)
end

"""
    MPI_Type_get_true_extent(datatype, true_lb, true_extent)

- `MPI_Type_get_true_extent` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_get_true_extent.html`
"""
function MPI_Type_get_true_extent(datatype, true_lb, true_extent)
    @mpichk ccall((:MPI_Type_get_true_extent, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Aint}, Ptr{MPI_Aint}), datatype, true_lb, true_extent)
end

"""
    MPI_Type_get_true_extent_x(datatype, true_lb, true_extent)

- `MPI_Type_get_true_extent_x` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_get_true_extent_x.html`
"""
function MPI_Type_get_true_extent_x(datatype, true_lb, true_extent)
    @mpichk ccall((:MPI_Type_get_true_extent_x, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), datatype, true_lb, true_extent)
end

"""
    MPI_Type_indexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)

- `MPI_Type_indexed` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_indexed.html`
"""
function MPI_Type_indexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:MPI_Type_indexed, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{Cint}, MPI_Datatype, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

"""
    MPI_Type_match_size(typeclass, size, datatype)

- `MPI_Type_match_size` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_match_size.html`
"""
function MPI_Type_match_size(typeclass, size, datatype)
    @mpichk ccall((:MPI_Type_match_size, libmpi), Cint, (Cint, Cint, Ptr{MPI_Datatype}), typeclass, size, datatype)
end

"""
    MPI_Type_set_name(datatype, type_name)

- `MPI_Type_set_name` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_set_name.html`
"""
function MPI_Type_set_name(datatype, type_name)
    @mpichk ccall((:MPI_Type_set_name, libmpi), Cint, (MPI_Datatype, Ptr{Cchar}), datatype, type_name)
end

"""
    MPI_Type_size(datatype, size)

- `MPI_Type_size` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_size.html`
"""
function MPI_Type_size(datatype, size)
    @mpichk ccall((:MPI_Type_size, libmpi), Cint, (MPI_Datatype, Ptr{Cint}), datatype, size)
end

"""
    MPI_Type_size_x(datatype, size)

- `MPI_Type_size_x` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_size_x.html`
"""
function MPI_Type_size_x(datatype, size)
    @mpichk ccall((:MPI_Type_size_x, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}), datatype, size)
end

"""
    MPI_Type_vector(count, blocklength, stride, oldtype, newtype)

- `MPI_Type_vector` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_vector.html`
"""
function MPI_Type_vector(count, blocklength, stride, oldtype, newtype)
    @mpichk ccall((:MPI_Type_vector, libmpi), Cint, (Cint, Cint, Cint, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

"""
    MPI_Unpack(inbuf, insize, position, outbuf, outcount, datatype, comm)

- `MPI_Unpack` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Unpack.html`
"""
function MPI_Unpack(inbuf, insize, position, outbuf, outcount, datatype, comm)
    @mpichk ccall((:MPI_Unpack, libmpi), Cint, (MPIPtr, Cint, Ptr{Cint}, MPIPtr, Cint, MPI_Datatype, MPI_Comm), inbuf, insize, position, outbuf, outcount, datatype, comm)
end

"""
    MPI_Unpack_external(datarep, inbuf, insize, position, outbuf, outcount, datatype)

- `MPI_Unpack_external` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Unpack_external.html`
"""
function MPI_Unpack_external(datarep, inbuf, insize, position, outbuf, outcount, datatype)
    @mpichk ccall((:MPI_Unpack_external, libmpi), Cint, (Ptr{Cchar}, MPIPtr, MPI_Aint, Ptr{MPI_Aint}, MPIPtr, Cint, MPI_Datatype), datarep, inbuf, insize, position, outbuf, outcount, datatype)
end

"""
    MPI_Address(location, address)

- `MPI_Address` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Address.html`
"""
function MPI_Address(location, address)
    @mpichk ccall((:MPI_Address, libmpi), Cint, (MPIPtr, Ptr{MPI_Aint}), location, address)
end

"""
    MPI_Type_extent(datatype, extent)

- `MPI_Type_extent` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_extent.html`
"""
function MPI_Type_extent(datatype, extent)
    @mpichk ccall((:MPI_Type_extent, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Aint}), datatype, extent)
end

"""
    MPI_Type_lb(datatype, displacement)

- `MPI_Type_lb` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_lb.html`
"""
function MPI_Type_lb(datatype, displacement)
    @mpichk ccall((:MPI_Type_lb, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Aint}), datatype, displacement)
end

"""
    MPI_Type_ub(datatype, displacement)

- `MPI_Type_ub` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_ub.html`
"""
function MPI_Type_ub(datatype, displacement)
    @mpichk ccall((:MPI_Type_ub, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Aint}), datatype, displacement)
end

"""
    MPI_Type_hindexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)

- `MPI_Type_hindexed` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_hindexed.html`
"""
function MPI_Type_hindexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:MPI_Type_hindexed, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{MPI_Aint}, MPI_Datatype, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

"""
    MPI_Type_hvector(count, blocklength, stride, oldtype, newtype)

- `MPI_Type_hvector` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_hvector.html`
"""
function MPI_Type_hvector(count, blocklength, stride, oldtype, newtype)
    @mpichk ccall((:MPI_Type_hvector, libmpi), Cint, (Cint, Cint, MPI_Aint, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

"""
    MPI_Type_struct(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)

- `MPI_Type_struct` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_struct.html`
"""
function MPI_Type_struct(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
    @mpichk ccall((:MPI_Type_struct, libmpi), Cint, (Cint, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
end

"""
    MPI_Add_error_class(errorclass)

- `MPI_Add_error_class` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Add_error_class.html`
"""
function MPI_Add_error_class(errorclass)
    @mpichk ccall((:MPI_Add_error_class, libmpi), Cint, (Ptr{Cint},), errorclass)
end

"""
    MPI_Add_error_code(errorclass, errorcode)

- `MPI_Add_error_code` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Add_error_code.html`
"""
function MPI_Add_error_code(errorclass, errorcode)
    @mpichk ccall((:MPI_Add_error_code, libmpi), Cint, (Cint, Ptr{Cint}), errorclass, errorcode)
end

"""
    MPI_Add_error_string(errorcode, string)

- `MPI_Add_error_string` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Add_error_string.html`
"""
function MPI_Add_error_string(errorcode, string)
    @mpichk ccall((:MPI_Add_error_string, libmpi), Cint, (Cint, Ptr{Cchar}), errorcode, string)
end

"""
    MPI_Comm_call_errhandler(comm, errorcode)

- `MPI_Comm_call_errhandler` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_call_errhandler.html`
"""
function MPI_Comm_call_errhandler(comm, errorcode)
    @mpichk ccall((:MPI_Comm_call_errhandler, libmpi), Cint, (MPI_Comm, Cint), comm, errorcode)
end

"""
    MPI_Comm_create_errhandler(comm_errhandler_fn, errhandler)

- `MPI_Comm_create_errhandler` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_create_errhandler.html`
"""
function MPI_Comm_create_errhandler(comm_errhandler_fn, errhandler)
    @mpichk ccall((:MPI_Comm_create_errhandler, libmpi), Cint, (MPIPtr, Ptr{MPI_Errhandler}), comm_errhandler_fn, errhandler)
end

"""
    MPI_Comm_get_errhandler(comm, errhandler)

- `MPI_Comm_get_errhandler` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_get_errhandler.html`
"""
function MPI_Comm_get_errhandler(comm, errhandler)
    @mpichk ccall((:MPI_Comm_get_errhandler, libmpi), Cint, (MPI_Comm, Ptr{MPI_Errhandler}), comm, errhandler)
end

"""
    MPI_Comm_set_errhandler(comm, errhandler)

- `MPI_Comm_set_errhandler` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_set_errhandler.html`
"""
function MPI_Comm_set_errhandler(comm, errhandler)
    @mpichk ccall((:MPI_Comm_set_errhandler, libmpi), Cint, (MPI_Comm, MPI_Errhandler), comm, errhandler)
end

"""
    MPI_Errhandler_free(errhandler)

- `MPI_Errhandler_free` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Errhandler_free.html`
"""
function MPI_Errhandler_free(errhandler)
    @mpichk ccall((:MPI_Errhandler_free, libmpi), Cint, (Ptr{MPI_Errhandler},), errhandler)
end

"""
    MPI_Error_class(errorcode, errorclass)

- `MPI_Error_class` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Error_class.html`
"""
function MPI_Error_class(errorcode, errorclass)
    @mpichk ccall((:MPI_Error_class, libmpi), Cint, (Cint, Ptr{Cint}), errorcode, errorclass)
end

"""
    MPI_Error_string(errorcode, string, resultlen)

- `MPI_Error_string` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Error_string.html`
"""
function MPI_Error_string(errorcode, string, resultlen)
    @mpichk ccall((:MPI_Error_string, libmpi), Cint, (Cint, Ptr{Cchar}, Ptr{Cint}), errorcode, string, resultlen)
end

"""
    MPI_File_call_errhandler(fh, errorcode)

- `MPI_File_call_errhandler` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_call_errhandler.html`
"""
function MPI_File_call_errhandler(fh, errorcode)
    @mpichk ccall((:MPI_File_call_errhandler, libmpi), Cint, (MPI_File, Cint), fh, errorcode)
end

"""
    MPI_File_create_errhandler(file_errhandler_fn, errhandler)

- `MPI_File_create_errhandler` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_create_errhandler.html`
"""
function MPI_File_create_errhandler(file_errhandler_fn, errhandler)
    @mpichk ccall((:MPI_File_create_errhandler, libmpi), Cint, (MPIPtr, Ptr{MPI_Errhandler}), file_errhandler_fn, errhandler)
end

"""
    MPI_File_get_errhandler(file, errhandler)

- `MPI_File_get_errhandler` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_get_errhandler.html`
"""
function MPI_File_get_errhandler(file, errhandler)
    @mpichk ccall((:MPI_File_get_errhandler, libmpi), Cint, (MPI_File, Ptr{MPI_Errhandler}), file, errhandler)
end

"""
    MPI_File_set_errhandler(file, errhandler)

- `MPI_File_set_errhandler` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_set_errhandler.html`
"""
function MPI_File_set_errhandler(file, errhandler)
    @mpichk ccall((:MPI_File_set_errhandler, libmpi), Cint, (MPI_File, MPI_Errhandler), file, errhandler)
end

"""
    MPI_Win_call_errhandler(win, errorcode)

- `MPI_Win_call_errhandler` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_call_errhandler.html`
"""
function MPI_Win_call_errhandler(win, errorcode)
    @mpichk ccall((:MPI_Win_call_errhandler, libmpi), Cint, (MPI_Win, Cint), win, errorcode)
end

"""
    MPI_Win_create_errhandler(win_errhandler_fn, errhandler)

- `MPI_Win_create_errhandler` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_create_errhandler.html`
"""
function MPI_Win_create_errhandler(win_errhandler_fn, errhandler)
    @mpichk ccall((:MPI_Win_create_errhandler, libmpi), Cint, (MPIPtr, Ptr{MPI_Errhandler}), win_errhandler_fn, errhandler)
end

"""
    MPI_Win_get_errhandler(win, errhandler)

- `MPI_Win_get_errhandler` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_get_errhandler.html`
"""
function MPI_Win_get_errhandler(win, errhandler)
    @mpichk ccall((:MPI_Win_get_errhandler, libmpi), Cint, (MPI_Win, Ptr{MPI_Errhandler}), win, errhandler)
end

"""
    MPI_Win_set_errhandler(win, errhandler)

- `MPI_Win_set_errhandler` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_set_errhandler.html`
"""
function MPI_Win_set_errhandler(win, errhandler)
    @mpichk ccall((:MPI_Win_set_errhandler, libmpi), Cint, (MPI_Win, MPI_Errhandler), win, errhandler)
end

"""
    MPI_Errhandler_create(comm_errhandler_fn, errhandler)

- `MPI_Errhandler_create` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Errhandler_create.html`
"""
function MPI_Errhandler_create(comm_errhandler_fn, errhandler)
    @mpichk ccall((:MPI_Errhandler_create, libmpi), Cint, (MPIPtr, Ptr{MPI_Errhandler}), comm_errhandler_fn, errhandler)
end

"""
    MPI_Errhandler_get(comm, errhandler)

- `MPI_Errhandler_get` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Errhandler_get.html`
"""
function MPI_Errhandler_get(comm, errhandler)
    @mpichk ccall((:MPI_Errhandler_get, libmpi), Cint, (MPI_Comm, Ptr{MPI_Errhandler}), comm, errhandler)
end

"""
    MPI_Errhandler_set(comm, errhandler)

- `MPI_Errhandler_set` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Errhandler_set.html`
"""
function MPI_Errhandler_set(comm, errhandler)
    @mpichk ccall((:MPI_Errhandler_set, libmpi), Cint, (MPI_Comm, MPI_Errhandler), comm, errhandler)
end

"""
    MPI_Group_compare(group1, group2, result)

- `MPI_Group_compare` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Group_compare.html`
"""
function MPI_Group_compare(group1, group2, result)
    @mpichk ccall((:MPI_Group_compare, libmpi), Cint, (MPI_Group, MPI_Group, Ptr{Cint}), group1, group2, result)
end

"""
    MPI_Group_difference(group1, group2, newgroup)

- `MPI_Group_difference` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Group_difference.html`
"""
function MPI_Group_difference(group1, group2, newgroup)
    @mpichk ccall((:MPI_Group_difference, libmpi), Cint, (MPI_Group, MPI_Group, Ptr{MPI_Group}), group1, group2, newgroup)
end

"""
    MPI_Group_excl(group, n, ranks, newgroup)

- `MPI_Group_excl` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Group_excl.html`
"""
function MPI_Group_excl(group, n, ranks, newgroup)
    @mpichk ccall((:MPI_Group_excl, libmpi), Cint, (MPI_Group, Cint, Ptr{Cint}, Ptr{MPI_Group}), group, n, ranks, newgroup)
end

"""
    MPI_Group_free(group)

- `MPI_Group_free` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Group_free.html`
"""
function MPI_Group_free(group)
    @mpichk ccall((:MPI_Group_free, libmpi), Cint, (Ptr{MPI_Group},), group)
end

"""
    MPI_Group_incl(group, n, ranks, newgroup)

- `MPI_Group_incl` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Group_incl.html`
"""
function MPI_Group_incl(group, n, ranks, newgroup)
    @mpichk ccall((:MPI_Group_incl, libmpi), Cint, (MPI_Group, Cint, Ptr{Cint}, Ptr{MPI_Group}), group, n, ranks, newgroup)
end

"""
    MPI_Group_intersection(group1, group2, newgroup)

- `MPI_Group_intersection` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Group_intersection.html`
"""
function MPI_Group_intersection(group1, group2, newgroup)
    @mpichk ccall((:MPI_Group_intersection, libmpi), Cint, (MPI_Group, MPI_Group, Ptr{MPI_Group}), group1, group2, newgroup)
end

"""
    MPI_Group_range_excl(group, n, ranges, newgroup)

- `MPI_Group_range_excl` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Group_range_excl.html`
"""
function MPI_Group_range_excl(group, n, ranges, newgroup)
    @mpichk ccall((:MPI_Group_range_excl, libmpi), Cint, (MPI_Group, Cint, Ptr{NTuple{3, Cint}}, Ptr{MPI_Group}), group, n, ranges, newgroup)
end

"""
    MPI_Group_range_incl(group, n, ranges, newgroup)

- `MPI_Group_range_incl` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Group_range_incl.html`
"""
function MPI_Group_range_incl(group, n, ranges, newgroup)
    @mpichk ccall((:MPI_Group_range_incl, libmpi), Cint, (MPI_Group, Cint, Ptr{NTuple{3, Cint}}, Ptr{MPI_Group}), group, n, ranges, newgroup)
end

"""
    MPI_Group_rank(group, rank)

- `MPI_Group_rank` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Group_rank.html`
"""
function MPI_Group_rank(group, rank)
    @mpichk ccall((:MPI_Group_rank, libmpi), Cint, (MPI_Group, Ptr{Cint}), group, rank)
end

"""
    MPI_Group_size(group, size)

- `MPI_Group_size` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Group_size.html`
"""
function MPI_Group_size(group, size)
    @mpichk ccall((:MPI_Group_size, libmpi), Cint, (MPI_Group, Ptr{Cint}), group, size)
end

"""
    MPI_Group_translate_ranks(group1, n, ranks1, group2, ranks2)

- `MPI_Group_translate_ranks` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Group_translate_ranks.html`
"""
function MPI_Group_translate_ranks(group1, n, ranks1, group2, ranks2)
    @mpichk ccall((:MPI_Group_translate_ranks, libmpi), Cint, (MPI_Group, Cint, Ptr{Cint}, MPI_Group, Ptr{Cint}), group1, n, ranks1, group2, ranks2)
end

"""
    MPI_Group_union(group1, group2, newgroup)

- `MPI_Group_union` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Group_union.html`
"""
function MPI_Group_union(group1, group2, newgroup)
    @mpichk ccall((:MPI_Group_union, libmpi), Cint, (MPI_Group, MPI_Group, Ptr{MPI_Group}), group1, group2, newgroup)
end

"""
    MPI_Info_create(info)

- `MPI_Info_create` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Info_create.html`
"""
function MPI_Info_create(info)
    @mpichk ccall((:MPI_Info_create, libmpi), Cint, (Ptr{MPI_Info},), info)
end

"""
    MPI_Info_create_env(argc, argv, info)

- `MPI_Info_create_env` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Info_create_env.html`
"""
function MPI_Info_create_env(argc, argv, info)
    @mpichk ccall((:MPI_Info_create_env, libmpi), Cint, (Cint, Ptr{Ptr{Cchar}}, Ptr{MPI_Info}), argc, argv, info)
end

"""
    MPI_Info_delete(info, key)

- `MPI_Info_delete` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Info_delete.html`
"""
function MPI_Info_delete(info, key)
    @mpichk ccall((:MPI_Info_delete, libmpi), Cint, (MPI_Info, Ptr{Cchar}), info, key)
end

"""
    MPI_Info_dup(info, newinfo)

- `MPI_Info_dup` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Info_dup.html`
"""
function MPI_Info_dup(info, newinfo)
    @mpichk ccall((:MPI_Info_dup, libmpi), Cint, (MPI_Info, Ptr{MPI_Info}), info, newinfo)
end

"""
    MPI_Info_free(info)

- `MPI_Info_free` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Info_free.html`
"""
function MPI_Info_free(info)
    @mpichk ccall((:MPI_Info_free, libmpi), Cint, (Ptr{MPI_Info},), info)
end

"""
    MPI_Info_get(info, key, valuelen, value, flag)

- `MPI_Info_get` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Info_get.html`
"""
function MPI_Info_get(info, key, valuelen, value, flag)
    @mpichk ccall((:MPI_Info_get, libmpi), Cint, (MPI_Info, Ptr{Cchar}, Cint, Ptr{Cchar}, Ptr{Cint}), info, key, valuelen, value, flag)
end

"""
    MPI_Info_get_nkeys(info, nkeys)

- `MPI_Info_get_nkeys` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Info_get_nkeys.html`
"""
function MPI_Info_get_nkeys(info, nkeys)
    @mpichk ccall((:MPI_Info_get_nkeys, libmpi), Cint, (MPI_Info, Ptr{Cint}), info, nkeys)
end

"""
    MPI_Info_get_nthkey(info, n, key)

- `MPI_Info_get_nthkey` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Info_get_nthkey.html`
"""
function MPI_Info_get_nthkey(info, n, key)
    @mpichk ccall((:MPI_Info_get_nthkey, libmpi), Cint, (MPI_Info, Cint, Ptr{Cchar}), info, n, key)
end

"""
    MPI_Info_get_string(info, key, buflen, value, flag)

- `MPI_Info_get_string` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Info_get_string.html`
"""
function MPI_Info_get_string(info, key, buflen, value, flag)
    @mpichk ccall((:MPI_Info_get_string, libmpi), Cint, (MPI_Info, Ptr{Cchar}, Ptr{Cint}, Ptr{Cchar}, Ptr{Cint}), info, key, buflen, value, flag)
end

"""
    MPI_Info_get_valuelen(info, key, valuelen, flag)

- `MPI_Info_get_valuelen` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Info_get_valuelen.html`
"""
function MPI_Info_get_valuelen(info, key, valuelen, flag)
    @mpichk ccall((:MPI_Info_get_valuelen, libmpi), Cint, (MPI_Info, Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}), info, key, valuelen, flag)
end

"""
    MPI_Info_set(info, key, value)

- `MPI_Info_set` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Info_set.html`
"""
function MPI_Info_set(info, key, value)
    @mpichk ccall((:MPI_Info_set, libmpi), Cint, (MPI_Info, Ptr{Cchar}, Ptr{Cchar}), info, key, value)
end

"""
    MPI_Abort(comm, errorcode)

- `MPI_Abort` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Abort.html`
"""
function MPI_Abort(comm, errorcode)
    @mpichk ccall((:MPI_Abort, libmpi), Cint, (MPI_Comm, Cint), comm, errorcode)
end

"""
    MPI_Comm_create_from_group(group, stringtag, info, errhandler, newcomm)

- `MPI_Comm_create_from_group` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_create_from_group.html`
"""
function MPI_Comm_create_from_group(group, stringtag, info, errhandler, newcomm)
    @mpichk ccall((:MPI_Comm_create_from_group, libmpi), Cint, (MPI_Group, Ptr{Cchar}, MPI_Info, MPI_Errhandler, Ptr{MPI_Comm}), group, stringtag, info, errhandler, newcomm)
end

"""
    MPI_Finalize()

- `MPI_Finalize` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Finalize.html`
"""
function MPI_Finalize()
    @mpichk ccall((:MPI_Finalize, libmpi), Cint, ())
end

"""
    MPI_Finalized(flag)

- `MPI_Finalized` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Finalized.html`
"""
function MPI_Finalized(flag)
    @mpichk ccall((:MPI_Finalized, libmpi), Cint, (Ptr{Cint},), flag)
end

"""
    MPI_Init(argc, argv)

- `MPI_Init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Init.html`
"""
function MPI_Init(argc, argv)
    @mpichk ccall((:MPI_Init, libmpi), Cint, (Ptr{Cint}, Ptr{Ptr{Ptr{Cchar}}}), argc, argv)
end

"""
    MPI_Init_thread(argc, argv, required, provided)

- `MPI_Init_thread` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Init_thread.html`
"""
function MPI_Init_thread(argc, argv, required, provided)
    @mpichk ccall((:MPI_Init_thread, libmpi), Cint, (Ptr{Cint}, Ptr{Ptr{Ptr{Cchar}}}, Cint, Ptr{Cint}), argc, argv, required, provided)
end

"""
    MPI_Initialized(flag)

- `MPI_Initialized` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Initialized.html`
"""
function MPI_Initialized(flag)
    @mpichk ccall((:MPI_Initialized, libmpi), Cint, (Ptr{Cint},), flag)
end

"""
    MPI_Is_thread_main(flag)

- `MPI_Is_thread_main` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Is_thread_main.html`
"""
function MPI_Is_thread_main(flag)
    @mpichk ccall((:MPI_Is_thread_main, libmpi), Cint, (Ptr{Cint},), flag)
end

"""
    MPI_Query_thread(provided)

- `MPI_Query_thread` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Query_thread.html`
"""
function MPI_Query_thread(provided)
    @mpichk ccall((:MPI_Query_thread, libmpi), Cint, (Ptr{Cint},), provided)
end

"""
    MPI_Aint_add(base, disp)

- `MPI_Aint_add` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Aint_add.html`
"""
function MPI_Aint_add(base, disp)
    @mpichk ccall((:MPI_Aint_add, libmpi), MPI_Aint, (MPI_Aint, MPI_Aint), base, disp)
end

"""
    MPI_Aint_diff(addr1, addr2)

- `MPI_Aint_diff` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Aint_diff.html`
"""
function MPI_Aint_diff(addr1, addr2)
    @mpichk ccall((:MPI_Aint_diff, libmpi), MPI_Aint, (MPI_Aint, MPI_Aint), addr1, addr2)
end

"""
    MPI_Get_library_version(version, resultlen)

- `MPI_Get_library_version` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Get_library_version.html`
"""
function MPI_Get_library_version(version, resultlen)
    @mpicall ccall((:MPI_Get_library_version, libmpi), Cint, (Ptr{Cchar}, Ptr{Cint}), version, resultlen)
end

"""
    MPI_Get_processor_name(name, resultlen)

- `MPI_Get_processor_name` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Get_processor_name.html`
"""
function MPI_Get_processor_name(name, resultlen)
    @mpicall ccall((:MPI_Get_processor_name, libmpi), Cint, (Ptr{Cchar}, Ptr{Cint}), name, resultlen)
end

"""
    MPI_Get_version(version, subversion)

- `MPI_Get_version` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Get_version.html`
"""
function MPI_Get_version(version, subversion)
    @mpicall ccall((:MPI_Get_version, libmpi), Cint, (Ptr{Cint}, Ptr{Cint}), version, subversion)
end

"""
    MPI_Op_commutative(op, commute)

- `MPI_Op_commutative` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Op_commutative.html`
"""
function MPI_Op_commutative(op, commute)
    @mpichk ccall((:MPI_Op_commutative, libmpi), Cint, (MPI_Op, Ptr{Cint}), op, commute)
end

"""
    MPI_Op_create(user_fn, commute, op)

- `MPI_Op_create` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Op_create.html`
"""
function MPI_Op_create(user_fn, commute, op)
    @mpichk ccall((:MPI_Op_create, libmpi), Cint, (MPIPtr, Cint, Ptr{MPI_Op}), user_fn, commute, op)
end

"""
    MPI_Op_free(op)

- `MPI_Op_free` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Op_free.html`
"""
function MPI_Op_free(op)
    @mpichk ccall((:MPI_Op_free, libmpi), Cint, (Ptr{MPI_Op},), op)
end

"""
    MPI_Parrived(request, partition, flag)

- `MPI_Parrived` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Parrived.html`
"""
function MPI_Parrived(request, partition, flag)
    @mpichk ccall((:MPI_Parrived, libmpi), Cint, (MPI_Request, Cint, Ptr{Cint}), request, partition, flag)
end

"""
    MPI_Pready(partition, request)

- `MPI_Pready` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Pready.html`
"""
function MPI_Pready(partition, request)
    @mpichk ccall((:MPI_Pready, libmpi), Cint, (Cint, MPI_Request), partition, request)
end

"""
    MPI_Pready_list(length, array_of_partitions, request)

- `MPI_Pready_list` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Pready_list.html`
"""
function MPI_Pready_list(length, array_of_partitions, request)
    @mpichk ccall((:MPI_Pready_list, libmpi), Cint, (Cint, Ptr{Cint}, MPI_Request), length, array_of_partitions, request)
end

"""
    MPI_Pready_range(partition_low, partition_high, request)

- `MPI_Pready_range` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Pready_range.html`
"""
function MPI_Pready_range(partition_low, partition_high, request)
    @mpichk ccall((:MPI_Pready_range, libmpi), Cint, (Cint, Cint, MPI_Request), partition_low, partition_high, request)
end

"""
    MPI_Precv_init(buf, partitions, count, datatype, dest, tag, comm, info, request)

- `MPI_Precv_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Precv_init.html`
"""
function MPI_Precv_init(buf, partitions, count, datatype, dest, tag, comm, info, request)
    @mpichk ccall((:MPI_Precv_init, libmpi), Cint, (MPIPtr, Cint, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), buf, partitions, count, datatype, dest, tag, comm, info, request)
end

"""
    MPI_Psend_init(buf, partitions, count, datatype, dest, tag, comm, info, request)

- `MPI_Psend_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Psend_init.html`
"""
function MPI_Psend_init(buf, partitions, count, datatype, dest, tag, comm, info, request)
    @mpichk ccall((:MPI_Psend_init, libmpi), Cint, (MPIPtr, Cint, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), buf, partitions, count, datatype, dest, tag, comm, info, request)
end

"""
    MPI_Bsend(buf, count, datatype, dest, tag, comm)

- `MPI_Bsend` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Bsend.html`
"""
function MPI_Bsend(buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:MPI_Bsend, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

"""
    MPI_Bsend_init(buf, count, datatype, dest, tag, comm, request)

- `MPI_Bsend_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Bsend_init.html`
"""
function MPI_Bsend_init(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Bsend_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Buffer_attach(buffer, size)

- `MPI_Buffer_attach` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Buffer_attach.html`
"""
function MPI_Buffer_attach(buffer, size)
    @mpichk ccall((:MPI_Buffer_attach, libmpi), Cint, (MPIPtr, Cint), buffer, size)
end

"""
    MPI_Buffer_detach(buffer_addr, size)

- `MPI_Buffer_detach` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Buffer_detach.html`
"""
function MPI_Buffer_detach(buffer_addr, size)
    @mpichk ccall((:MPI_Buffer_detach, libmpi), Cint, (MPIPtr, Ptr{Cint}), buffer_addr, size)
end

"""
    MPI_Ibsend(buf, count, datatype, dest, tag, comm, request)

- `MPI_Ibsend` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ibsend.html`
"""
function MPI_Ibsend(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Ibsend, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Improbe(source, tag, comm, flag, message, status)

- `MPI_Improbe` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Improbe.html`
"""
function MPI_Improbe(source, tag, comm, flag, message, status)
    @mpichk ccall((:MPI_Improbe, libmpi), Cint, (Cint, Cint, MPI_Comm, Ptr{Cint}, Ptr{MPI_Message}, Ptr{MPI_Status}), source, tag, comm, flag, message, status)
end

"""
    MPI_Imrecv(buf, count, datatype, message, request)

- `MPI_Imrecv` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Imrecv.html`
"""
function MPI_Imrecv(buf, count, datatype, message, request)
    @mpichk ccall((:MPI_Imrecv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Request}), buf, count, datatype, message, request)
end

"""
    MPI_Iprobe(source, tag, comm, flag, status)

- `MPI_Iprobe` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Iprobe.html`
"""
function MPI_Iprobe(source, tag, comm, flag, status)
    @mpichk ccall((:MPI_Iprobe, libmpi), Cint, (Cint, Cint, MPI_Comm, Ptr{Cint}, Ptr{MPI_Status}), source, tag, comm, flag, status)
end

"""
    MPI_Irecv(buf, count, datatype, source, tag, comm, request)

- `MPI_Irecv` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Irecv.html`
"""
function MPI_Irecv(buf, count, datatype, source, tag, comm, request)
    @mpichk ccall((:MPI_Irecv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, source, tag, comm, request)
end

"""
    MPI_Irsend(buf, count, datatype, dest, tag, comm, request)

- `MPI_Irsend` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Irsend.html`
"""
function MPI_Irsend(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Irsend, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Isend(buf, count, datatype, dest, tag, comm, request)

- `MPI_Isend` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Isend.html`
"""
function MPI_Isend(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Isend, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Isendrecv(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)

- `MPI_Isendrecv` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Isendrecv.html`
"""
function MPI_Isendrecv(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
    @mpichk ccall((:MPI_Isendrecv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
end

"""
    MPI_Isendrecv_replace(buf, count, datatype, dest, sendtag, source, recvtag, comm, request)

- `MPI_Isendrecv_replace` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Isendrecv_replace.html`
"""
function MPI_Isendrecv_replace(buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
    @mpichk ccall((:MPI_Isendrecv_replace, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
end

"""
    MPI_Issend(buf, count, datatype, dest, tag, comm, request)

- `MPI_Issend` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Issend.html`
"""
function MPI_Issend(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Issend, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Mprobe(source, tag, comm, message, status)

- `MPI_Mprobe` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Mprobe.html`
"""
function MPI_Mprobe(source, tag, comm, message, status)
    @mpichk ccall((:MPI_Mprobe, libmpi), Cint, (Cint, Cint, MPI_Comm, Ptr{MPI_Message}, Ptr{MPI_Status}), source, tag, comm, message, status)
end

"""
    MPI_Mrecv(buf, count, datatype, message, status)

- `MPI_Mrecv` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Mrecv.html`
"""
function MPI_Mrecv(buf, count, datatype, message, status)
    @mpichk ccall((:MPI_Mrecv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Status}), buf, count, datatype, message, status)
end

"""
    MPI_Probe(source, tag, comm, status)

- `MPI_Probe` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Probe.html`
"""
function MPI_Probe(source, tag, comm, status)
    @mpichk ccall((:MPI_Probe, libmpi), Cint, (Cint, Cint, MPI_Comm, Ptr{MPI_Status}), source, tag, comm, status)
end

"""
    MPI_Recv(buf, count, datatype, source, tag, comm, status)

- `MPI_Recv` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Recv.html`
"""
function MPI_Recv(buf, count, datatype, source, tag, comm, status)
    @mpichk ccall((:MPI_Recv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), buf, count, datatype, source, tag, comm, status)
end

"""
    MPI_Recv_init(buf, count, datatype, source, tag, comm, request)

- `MPI_Recv_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Recv_init.html`
"""
function MPI_Recv_init(buf, count, datatype, source, tag, comm, request)
    @mpichk ccall((:MPI_Recv_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, source, tag, comm, request)
end

"""
    MPI_Rsend(buf, count, datatype, dest, tag, comm)

- `MPI_Rsend` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Rsend.html`
"""
function MPI_Rsend(buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:MPI_Rsend, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

"""
    MPI_Rsend_init(buf, count, datatype, dest, tag, comm, request)

- `MPI_Rsend_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Rsend_init.html`
"""
function MPI_Rsend_init(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Rsend_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Send(buf, count, datatype, dest, tag, comm)

- `MPI_Send` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Send.html`
"""
function MPI_Send(buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:MPI_Send, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

"""
    MPI_Send_init(buf, count, datatype, dest, tag, comm, request)

- `MPI_Send_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Send_init.html`
"""
function MPI_Send_init(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Send_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Sendrecv(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)

- `MPI_Sendrecv` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Sendrecv.html`
"""
function MPI_Sendrecv(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
    @mpichk ccall((:MPI_Sendrecv, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
end

"""
    MPI_Sendrecv_replace(buf, count, datatype, dest, sendtag, source, recvtag, comm, status)

- `MPI_Sendrecv_replace` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Sendrecv_replace.html`
"""
function MPI_Sendrecv_replace(buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
    @mpichk ccall((:MPI_Sendrecv_replace, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
end

"""
    MPI_Ssend(buf, count, datatype, dest, tag, comm)

- `MPI_Ssend` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ssend.html`
"""
function MPI_Ssend(buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:MPI_Ssend, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

"""
    MPI_Ssend_init(buf, count, datatype, dest, tag, comm, request)

- `MPI_Ssend_init` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ssend_init.html`
"""
function MPI_Ssend_init(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Ssend_init, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Cancel(request)

- `MPI_Cancel` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Cancel.html`
"""
function MPI_Cancel(request)
    @mpichk ccall((:MPI_Cancel, libmpi), Cint, (Ptr{MPI_Request},), request)
end

"""
    MPI_Grequest_complete(request)

- `MPI_Grequest_complete` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Grequest_complete.html`
"""
function MPI_Grequest_complete(request)
    @mpichk ccall((:MPI_Grequest_complete, libmpi), Cint, (MPI_Request,), request)
end

"""
    MPI_Grequest_start(query_fn, free_fn, cancel_fn, extra_state, request)

- `MPI_Grequest_start` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Grequest_start.html`
"""
function MPI_Grequest_start(query_fn, free_fn, cancel_fn, extra_state, request)
    @mpichk ccall((:MPI_Grequest_start, libmpi), Cint, (MPIPtr, MPIPtr, MPIPtr, MPIPtr, Ptr{MPI_Request}), query_fn, free_fn, cancel_fn, extra_state, request)
end

"""
    MPI_Request_free(request)

- `MPI_Request_free` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Request_free.html`
"""
function MPI_Request_free(request)
    @mpichk ccall((:MPI_Request_free, libmpi), Cint, (Ptr{MPI_Request},), request)
end

"""
    MPI_Request_get_status(request, flag, status)

- `MPI_Request_get_status` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Request_get_status.html`
"""
function MPI_Request_get_status(request, flag, status)
    @mpichk ccall((:MPI_Request_get_status, libmpi), Cint, (MPI_Request, Ptr{Cint}, Ptr{MPI_Status}), request, flag, status)
end

"""
    MPI_Start(request)

- `MPI_Start` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Start.html`
"""
function MPI_Start(request)
    @mpichk ccall((:MPI_Start, libmpi), Cint, (Ptr{MPI_Request},), request)
end

"""
    MPI_Startall(count, array_of_requests)

- `MPI_Startall` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Startall.html`
"""
function MPI_Startall(count, array_of_requests)
    @mpichk ccall((:MPI_Startall, libmpi), Cint, (Cint, Ptr{MPI_Request}), count, array_of_requests)
end

"""
    MPI_Status_set_cancelled(status, flag)

- `MPI_Status_set_cancelled` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Status_set_cancelled.html`
"""
function MPI_Status_set_cancelled(status, flag)
    @mpichk ccall((:MPI_Status_set_cancelled, libmpi), Cint, (Ptr{MPI_Status}, Cint), status, flag)
end

"""
    MPI_Test_cancelled(status, flag)

- `MPI_Test_cancelled` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Test_cancelled.html`
"""
function MPI_Test_cancelled(status, flag)
    @mpichk ccall((:MPI_Test_cancelled, libmpi), Cint, (Ptr{MPI_Status}, Ptr{Cint}), status, flag)
end

"""
    MPI_Testall(count, array_of_requests, flag, array_of_statuses)

- `MPI_Testall` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Testall.html`
"""
function MPI_Testall(count, array_of_requests, flag, array_of_statuses)
    @mpichk ccall((:MPI_Testall, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{MPI_Status}), count, array_of_requests, flag, array_of_statuses)
end

"""
    MPI_Testany(count, array_of_requests, indx, flag, status)

- `MPI_Testany` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Testany.html`
"""
function MPI_Testany(count, array_of_requests, indx, flag, status)
    @mpichk ccall((:MPI_Testany, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Status}), count, array_of_requests, indx, flag, status)
end

"""
    MPI_Testsome(incount, array_of_requests, outcount, array_of_indices, array_of_statuses)

- `MPI_Testsome` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Testsome.html`
"""
function MPI_Testsome(incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
    @mpichk ccall((:MPI_Testsome, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Status}), incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
end

"""
    MPI_Waitall(count, array_of_requests, array_of_statuses)

- `MPI_Waitall` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Waitall.html`
"""
function MPI_Waitall(count, array_of_requests, array_of_statuses)
    @mpichk ccall((:MPI_Waitall, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{MPI_Status}), count, array_of_requests, array_of_statuses)
end

"""
    MPI_Waitany(count, array_of_requests, indx, status)

- `MPI_Waitany` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Waitany.html`
"""
function MPI_Waitany(count, array_of_requests, indx, status)
    @mpichk ccall((:MPI_Waitany, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{MPI_Status}), count, array_of_requests, indx, status)
end

"""
    MPI_Waitsome(incount, array_of_requests, outcount, array_of_indices, array_of_statuses)

- `MPI_Waitsome` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Waitsome.html`
"""
function MPI_Waitsome(incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
    @mpichk ccall((:MPI_Waitsome, libmpi), Cint, (Cint, Ptr{MPI_Request}, Ptr{Cint}, Ptr{Cint}, Ptr{MPI_Status}), incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
end

"""
    MPI_Accumulate(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)

- `MPI_Accumulate` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Accumulate.html`
"""
function MPI_Accumulate(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    @mpichk ccall((:MPI_Accumulate, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

"""
    MPI_Alloc_mem(size, info, baseptr)

- `MPI_Alloc_mem` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Alloc_mem.html`
"""
function MPI_Alloc_mem(size, info, baseptr)
    @mpichk ccall((:MPI_Alloc_mem, libmpi), Cint, (MPI_Aint, MPI_Info, MPIPtr), size, info, baseptr)
end

"""
    MPI_Compare_and_swap(origin_addr, compare_addr, result_addr, datatype, target_rank, target_disp, win)

- `MPI_Compare_and_swap` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Compare_and_swap.html`
"""
function MPI_Compare_and_swap(origin_addr, compare_addr, result_addr, datatype, target_rank, target_disp, win)
    @mpichk ccall((:MPI_Compare_and_swap, libmpi), Cint, (MPIPtr, MPIPtr, MPIPtr, MPI_Datatype, Cint, MPI_Aint, MPI_Win), origin_addr, compare_addr, result_addr, datatype, target_rank, target_disp, win)
end

"""
    MPI_Fetch_and_op(origin_addr, result_addr, datatype, target_rank, target_disp, op, win)

- `MPI_Fetch_and_op` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Fetch_and_op.html`
"""
function MPI_Fetch_and_op(origin_addr, result_addr, datatype, target_rank, target_disp, op, win)
    @mpichk ccall((:MPI_Fetch_and_op, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Datatype, Cint, MPI_Aint, MPI_Op, MPI_Win), origin_addr, result_addr, datatype, target_rank, target_disp, op, win)
end

"""
    MPI_Free_mem(base)

- `MPI_Free_mem` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Free_mem.html`
"""
function MPI_Free_mem(base)
    @mpichk ccall((:MPI_Free_mem, libmpi), Cint, (MPIPtr,), base)
end

"""
    MPI_Get(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)

- `MPI_Get` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Get.html`
"""
function MPI_Get(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    @mpichk ccall((:MPI_Get, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

"""
    MPI_Get_accumulate(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)

- `MPI_Get_accumulate` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Get_accumulate.html`
"""
function MPI_Get_accumulate(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    @mpichk ccall((:MPI_Get_accumulate, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win), origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

"""
    MPI_Put(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)

- `MPI_Put` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Put.html`
"""
function MPI_Put(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    @mpichk ccall((:MPI_Put, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

"""
    MPI_Raccumulate(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)

- `MPI_Raccumulate` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Raccumulate.html`
"""
function MPI_Raccumulate(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    @mpichk ccall((:MPI_Raccumulate, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

"""
    MPI_Rget(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)

- `MPI_Rget` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Rget.html`
"""
function MPI_Rget(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    @mpichk ccall((:MPI_Rget, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

"""
    MPI_Rget_accumulate(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)

- `MPI_Rget_accumulate` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Rget_accumulate.html`
"""
function MPI_Rget_accumulate(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    @mpichk ccall((:MPI_Rget_accumulate, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

"""
    MPI_Rput(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)

- `MPI_Rput` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Rput.html`
"""
function MPI_Rput(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    @mpichk ccall((:MPI_Rput, libmpi), Cint, (MPIPtr, Cint, MPI_Datatype, Cint, MPI_Aint, Cint, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

"""
    MPI_Win_allocate(size, disp_unit, info, comm, baseptr, win)

- `MPI_Win_allocate` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_allocate.html`
"""
function MPI_Win_allocate(size, disp_unit, info, comm, baseptr, win)
    @mpichk ccall((:MPI_Win_allocate, libmpi), Cint, (MPI_Aint, Cint, MPI_Info, MPI_Comm, MPIPtr, Ptr{MPI_Win}), size, disp_unit, info, comm, baseptr, win)
end

"""
    MPI_Win_allocate_shared(size, disp_unit, info, comm, baseptr, win)

- `MPI_Win_allocate_shared` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_allocate_shared.html`
"""
function MPI_Win_allocate_shared(size, disp_unit, info, comm, baseptr, win)
    @mpichk ccall((:MPI_Win_allocate_shared, libmpi), Cint, (MPI_Aint, Cint, MPI_Info, MPI_Comm, MPIPtr, Ptr{MPI_Win}), size, disp_unit, info, comm, baseptr, win)
end

"""
    MPI_Win_attach(win, base, size)

- `MPI_Win_attach` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_attach.html`
"""
function MPI_Win_attach(win, base, size)
    @mpichk ccall((:MPI_Win_attach, libmpi), Cint, (MPI_Win, MPIPtr, MPI_Aint), win, base, size)
end

"""
    MPI_Win_complete(win)

- `MPI_Win_complete` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_complete.html`
"""
function MPI_Win_complete(win)
    @mpichk ccall((:MPI_Win_complete, libmpi), Cint, (MPI_Win,), win)
end

"""
    MPI_Win_create(base, size, disp_unit, info, comm, win)

- `MPI_Win_create` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_create.html`
"""
function MPI_Win_create(base, size, disp_unit, info, comm, win)
    @mpichk ccall((:MPI_Win_create, libmpi), Cint, (MPIPtr, MPI_Aint, Cint, MPI_Info, MPI_Comm, Ptr{MPI_Win}), base, size, disp_unit, info, comm, win)
end

"""
    MPI_Win_create_dynamic(info, comm, win)

- `MPI_Win_create_dynamic` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_create_dynamic.html`
"""
function MPI_Win_create_dynamic(info, comm, win)
    @mpichk ccall((:MPI_Win_create_dynamic, libmpi), Cint, (MPI_Info, MPI_Comm, Ptr{MPI_Win}), info, comm, win)
end

"""
    MPI_Win_detach(win, base)

- `MPI_Win_detach` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_detach.html`
"""
function MPI_Win_detach(win, base)
    @mpichk ccall((:MPI_Win_detach, libmpi), Cint, (MPI_Win, MPIPtr), win, base)
end

"""
    MPI_Win_fence(assert, win)

- `MPI_Win_fence` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_fence.html`
"""
function MPI_Win_fence(assert, win)
    @mpichk ccall((:MPI_Win_fence, libmpi), Cint, (Cint, MPI_Win), assert, win)
end

"""
    MPI_Win_flush(rank, win)

- `MPI_Win_flush` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_flush.html`
"""
function MPI_Win_flush(rank, win)
    @mpichk ccall((:MPI_Win_flush, libmpi), Cint, (Cint, MPI_Win), rank, win)
end

"""
    MPI_Win_flush_all(win)

- `MPI_Win_flush_all` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_flush_all.html`
"""
function MPI_Win_flush_all(win)
    @mpichk ccall((:MPI_Win_flush_all, libmpi), Cint, (MPI_Win,), win)
end

"""
    MPI_Win_flush_local(rank, win)

- `MPI_Win_flush_local` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_flush_local.html`
"""
function MPI_Win_flush_local(rank, win)
    @mpichk ccall((:MPI_Win_flush_local, libmpi), Cint, (Cint, MPI_Win), rank, win)
end

"""
    MPI_Win_flush_local_all(win)

- `MPI_Win_flush_local_all` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_flush_local_all.html`
"""
function MPI_Win_flush_local_all(win)
    @mpichk ccall((:MPI_Win_flush_local_all, libmpi), Cint, (MPI_Win,), win)
end

"""
    MPI_Win_free(win)

- `MPI_Win_free` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_free.html`
"""
function MPI_Win_free(win)
    @mpichk ccall((:MPI_Win_free, libmpi), Cint, (Ptr{MPI_Win},), win)
end

"""
    MPI_Win_get_group(win, group)

- `MPI_Win_get_group` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_get_group.html`
"""
function MPI_Win_get_group(win, group)
    @mpichk ccall((:MPI_Win_get_group, libmpi), Cint, (MPI_Win, Ptr{MPI_Group}), win, group)
end

"""
    MPI_Win_get_info(win, info_used)

- `MPI_Win_get_info` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_get_info.html`
"""
function MPI_Win_get_info(win, info_used)
    @mpichk ccall((:MPI_Win_get_info, libmpi), Cint, (MPI_Win, Ptr{MPI_Info}), win, info_used)
end

"""
    MPI_Win_get_name(win, win_name, resultlen)

- `MPI_Win_get_name` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_get_name.html`
"""
function MPI_Win_get_name(win, win_name, resultlen)
    @mpichk ccall((:MPI_Win_get_name, libmpi), Cint, (MPI_Win, Ptr{Cchar}, Ptr{Cint}), win, win_name, resultlen)
end

"""
    MPI_Win_lock(lock_type, rank, assert, win)

- `MPI_Win_lock` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_lock.html`
"""
function MPI_Win_lock(lock_type, rank, assert, win)
    @mpichk ccall((:MPI_Win_lock, libmpi), Cint, (Cint, Cint, Cint, MPI_Win), lock_type, rank, assert, win)
end

"""
    MPI_Win_lock_all(assert, win)

- `MPI_Win_lock_all` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_lock_all.html`
"""
function MPI_Win_lock_all(assert, win)
    @mpichk ccall((:MPI_Win_lock_all, libmpi), Cint, (Cint, MPI_Win), assert, win)
end

"""
    MPI_Win_post(group, assert, win)

- `MPI_Win_post` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_post.html`
"""
function MPI_Win_post(group, assert, win)
    @mpichk ccall((:MPI_Win_post, libmpi), Cint, (MPI_Group, Cint, MPI_Win), group, assert, win)
end

"""
    MPI_Win_set_info(win, info)

- `MPI_Win_set_info` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_set_info.html`
"""
function MPI_Win_set_info(win, info)
    @mpichk ccall((:MPI_Win_set_info, libmpi), Cint, (MPI_Win, MPI_Info), win, info)
end

"""
    MPI_Win_set_name(win, win_name)

- `MPI_Win_set_name` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_set_name.html`
"""
function MPI_Win_set_name(win, win_name)
    @mpichk ccall((:MPI_Win_set_name, libmpi), Cint, (MPI_Win, Ptr{Cchar}), win, win_name)
end

"""
    MPI_Win_shared_query(win, rank, size, disp_unit, baseptr)

- `MPI_Win_shared_query` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_shared_query.html`
"""
function MPI_Win_shared_query(win, rank, size, disp_unit, baseptr)
    @mpichk ccall((:MPI_Win_shared_query, libmpi), Cint, (MPI_Win, Cint, Ptr{MPI_Aint}, Ptr{Cint}, MPIPtr), win, rank, size, disp_unit, baseptr)
end

"""
    MPI_Win_start(group, assert, win)

- `MPI_Win_start` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_start.html`
"""
function MPI_Win_start(group, assert, win)
    @mpichk ccall((:MPI_Win_start, libmpi), Cint, (MPI_Group, Cint, MPI_Win), group, assert, win)
end

"""
    MPI_Win_sync(win)

- `MPI_Win_sync` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_sync.html`
"""
function MPI_Win_sync(win)
    @mpichk ccall((:MPI_Win_sync, libmpi), Cint, (MPI_Win,), win)
end

"""
    MPI_Win_test(win, flag)

- `MPI_Win_test` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_test.html`
"""
function MPI_Win_test(win, flag)
    @mpichk ccall((:MPI_Win_test, libmpi), Cint, (MPI_Win, Ptr{Cint}), win, flag)
end

"""
    MPI_Win_unlock(rank, win)

- `MPI_Win_unlock` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_unlock.html`
"""
function MPI_Win_unlock(rank, win)
    @mpichk ccall((:MPI_Win_unlock, libmpi), Cint, (Cint, MPI_Win), rank, win)
end

"""
    MPI_Win_unlock_all(win)

- `MPI_Win_unlock_all` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_unlock_all.html`
"""
function MPI_Win_unlock_all(win)
    @mpichk ccall((:MPI_Win_unlock_all, libmpi), Cint, (MPI_Win,), win)
end

"""
    MPI_Win_wait(win)

- `MPI_Win_wait` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_wait.html`
"""
function MPI_Win_wait(win)
    @mpichk ccall((:MPI_Win_wait, libmpi), Cint, (MPI_Win,), win)
end

"""
    MPI_Close_port(port_name)

- `MPI_Close_port` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Close_port.html`
"""
function MPI_Close_port(port_name)
    @mpichk ccall((:MPI_Close_port, libmpi), Cint, (Ptr{Cchar},), port_name)
end

"""
    MPI_Comm_accept(port_name, info, root, comm, newcomm)

- `MPI_Comm_accept` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_accept.html`
"""
function MPI_Comm_accept(port_name, info, root, comm, newcomm)
    @mpichk ccall((:MPI_Comm_accept, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Cint, MPI_Comm, Ptr{MPI_Comm}), port_name, info, root, comm, newcomm)
end

"""
    MPI_Comm_connect(port_name, info, root, comm, newcomm)

- `MPI_Comm_connect` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_connect.html`
"""
function MPI_Comm_connect(port_name, info, root, comm, newcomm)
    @mpichk ccall((:MPI_Comm_connect, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Cint, MPI_Comm, Ptr{MPI_Comm}), port_name, info, root, comm, newcomm)
end

"""
    MPI_Comm_disconnect(comm)

- `MPI_Comm_disconnect` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_disconnect.html`
"""
function MPI_Comm_disconnect(comm)
    @mpichk ccall((:MPI_Comm_disconnect, libmpi), Cint, (Ptr{MPI_Comm},), comm)
end

"""
    MPI_Comm_get_parent(parent)

- `MPI_Comm_get_parent` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_get_parent.html`
"""
function MPI_Comm_get_parent(parent)
    @mpichk ccall((:MPI_Comm_get_parent, libmpi), Cint, (Ptr{MPI_Comm},), parent)
end

"""
    MPI_Comm_join(fd, intercomm)

- `MPI_Comm_join` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_join.html`
"""
function MPI_Comm_join(fd, intercomm)
    @mpichk ccall((:MPI_Comm_join, libmpi), Cint, (Cint, Ptr{MPI_Comm}), fd, intercomm)
end

"""
    MPI_Comm_spawn(command, argv, maxprocs, info, root, comm, intercomm, array_of_errcodes)

- `MPI_Comm_spawn` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_spawn.html`
"""
function MPI_Comm_spawn(command, argv, maxprocs, info, root, comm, intercomm, array_of_errcodes)
    @mpichk ccall((:MPI_Comm_spawn, libmpi), Cint, (Ptr{Cchar}, Ptr{Ptr{Cchar}}, Cint, MPI_Info, Cint, MPI_Comm, Ptr{MPI_Comm}, Ptr{Cint}), command, argv, maxprocs, info, root, comm, intercomm, array_of_errcodes)
end

"""
    MPI_Comm_spawn_multiple(count, array_of_commands, array_of_argv, array_of_maxprocs, array_of_info, root, comm, intercomm, array_of_errcodes)

- `MPI_Comm_spawn_multiple` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Comm_spawn_multiple.html`
"""
function MPI_Comm_spawn_multiple(count, array_of_commands, array_of_argv, array_of_maxprocs, array_of_info, root, comm, intercomm, array_of_errcodes)
    @mpichk ccall((:MPI_Comm_spawn_multiple, libmpi), Cint, (Cint, Ptr{Ptr{Cchar}}, Ptr{Ptr{Ptr{Cchar}}}, Ptr{Cint}, Ptr{MPI_Info}, Cint, MPI_Comm, Ptr{MPI_Comm}, Ptr{Cint}), count, array_of_commands, array_of_argv, array_of_maxprocs, array_of_info, root, comm, intercomm, array_of_errcodes)
end

"""
    MPI_Lookup_name(service_name, info, port_name)

- `MPI_Lookup_name` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Lookup_name.html`
"""
function MPI_Lookup_name(service_name, info, port_name)
    @mpichk ccall((:MPI_Lookup_name, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Ptr{Cchar}), service_name, info, port_name)
end

"""
    MPI_Open_port(info, port_name)

- `MPI_Open_port` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Open_port.html`
"""
function MPI_Open_port(info, port_name)
    @mpichk ccall((:MPI_Open_port, libmpi), Cint, (MPI_Info, Ptr{Cchar}), info, port_name)
end

"""
    MPI_Publish_name(service_name, info, port_name)

- `MPI_Publish_name` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Publish_name.html`
"""
function MPI_Publish_name(service_name, info, port_name)
    @mpichk ccall((:MPI_Publish_name, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Ptr{Cchar}), service_name, info, port_name)
end

"""
    MPI_Unpublish_name(service_name, info, port_name)

- `MPI_Unpublish_name` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Unpublish_name.html`
"""
function MPI_Unpublish_name(service_name, info, port_name)
    @mpichk ccall((:MPI_Unpublish_name, libmpi), Cint, (Ptr{Cchar}, MPI_Info, Ptr{Cchar}), service_name, info, port_name)
end

"""
    MPI_Wtick()

- `MPI_Wtick` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Wtick.html`
"""
function MPI_Wtick()
    @mpicall ccall((:MPI_Wtick, libmpi), Cdouble, ())
end

"""
    MPI_Wtime()

- `MPI_Wtime` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Wtime.html`
"""
function MPI_Wtime()
    @mpicall ccall((:MPI_Wtime, libmpi), Cdouble, ())
end

"""
    MPI_Cart_coords(comm, rank, maxdims, coords)

- `MPI_Cart_coords` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Cart_coords.html`
"""
function MPI_Cart_coords(comm, rank, maxdims, coords)
    @mpichk ccall((:MPI_Cart_coords, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{Cint}), comm, rank, maxdims, coords)
end

"""
    MPI_Cart_create(comm_old, ndims, dims, periods, reorder, comm_cart)

- `MPI_Cart_create` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Cart_create.html`
"""
function MPI_Cart_create(comm_old, ndims, dims, periods, reorder, comm_cart)
    @mpichk ccall((:MPI_Cart_create, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{MPI_Comm}), comm_old, ndims, dims, periods, reorder, comm_cart)
end

"""
    MPI_Cart_get(comm, maxdims, dims, periods, coords)

- `MPI_Cart_get` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Cart_get.html`
"""
function MPI_Cart_get(comm, maxdims, dims, periods, coords)
    @mpichk ccall((:MPI_Cart_get, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), comm, maxdims, dims, periods, coords)
end

"""
    MPI_Cart_map(comm, ndims, dims, periods, newrank)

- `MPI_Cart_map` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Cart_map.html`
"""
function MPI_Cart_map(comm, ndims, dims, periods, newrank)
    @mpichk ccall((:MPI_Cart_map, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), comm, ndims, dims, periods, newrank)
end

"""
    MPI_Cart_rank(comm, coords, rank)

- `MPI_Cart_rank` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Cart_rank.html`
"""
function MPI_Cart_rank(comm, coords, rank)
    @mpichk ccall((:MPI_Cart_rank, libmpi), Cint, (MPI_Comm, Ptr{Cint}, Ptr{Cint}), comm, coords, rank)
end

"""
    MPI_Cart_shift(comm, direction, disp, rank_source, rank_dest)

- `MPI_Cart_shift` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Cart_shift.html`
"""
function MPI_Cart_shift(comm, direction, disp, rank_source, rank_dest)
    @mpichk ccall((:MPI_Cart_shift, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{Cint}, Ptr{Cint}), comm, direction, disp, rank_source, rank_dest)
end

"""
    MPI_Cart_sub(comm, remain_dims, newcomm)

- `MPI_Cart_sub` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Cart_sub.html`
"""
function MPI_Cart_sub(comm, remain_dims, newcomm)
    @mpichk ccall((:MPI_Cart_sub, libmpi), Cint, (MPI_Comm, Ptr{Cint}, Ptr{MPI_Comm}), comm, remain_dims, newcomm)
end

"""
    MPI_Cartdim_get(comm, ndims)

- `MPI_Cartdim_get` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Cartdim_get.html`
"""
function MPI_Cartdim_get(comm, ndims)
    @mpichk ccall((:MPI_Cartdim_get, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, ndims)
end

"""
    MPI_Dims_create(nnodes, ndims, dims)

- `MPI_Dims_create` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Dims_create.html`
"""
function MPI_Dims_create(nnodes, ndims, dims)
    @mpichk ccall((:MPI_Dims_create, libmpi), Cint, (Cint, Cint, Ptr{Cint}), nnodes, ndims, dims)
end

"""
    MPI_Dist_graph_create(comm_old, n, sources, degrees, destinations, weights, info, reorder, comm_dist_graph)

- `MPI_Dist_graph_create` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Dist_graph_create.html`
"""
function MPI_Dist_graph_create(comm_old, n, sources, degrees, destinations, weights, info, reorder, comm_dist_graph)
    @mpichk ccall((:MPI_Dist_graph_create, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, MPI_Info, Cint, Ptr{MPI_Comm}), comm_old, n, sources, degrees, destinations, weights, info, reorder, comm_dist_graph) v"2.2.0"
end

"""
    MPI_Dist_graph_create_adjacent(comm_old, indegree, sources, sourceweights, outdegree, destinations, destweights, info, reorder, comm_dist_graph)

- `MPI_Dist_graph_create_adjacent` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Dist_graph_create_adjacent.html`
"""
function MPI_Dist_graph_create_adjacent(comm_old, indegree, sources, sourceweights, outdegree, destinations, destweights, info, reorder, comm_dist_graph)
    @mpichk ccall((:MPI_Dist_graph_create_adjacent, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{Cint}, Ptr{Cint}, MPI_Info, Cint, Ptr{MPI_Comm}), comm_old, indegree, sources, sourceweights, outdegree, destinations, destweights, info, reorder, comm_dist_graph) v"2.2.0"
end

"""
    MPI_Dist_graph_neighbors(comm, maxindegree, sources, sourceweights, maxoutdegree, destinations, destweights)

- `MPI_Dist_graph_neighbors` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Dist_graph_neighbors.html`
"""
function MPI_Dist_graph_neighbors(comm, maxindegree, sources, sourceweights, maxoutdegree, destinations, destweights)
    @mpichk ccall((:MPI_Dist_graph_neighbors, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{Cint}, Ptr{Cint}), comm, maxindegree, sources, sourceweights, maxoutdegree, destinations, destweights) v"2.2.0"
end

"""
    MPI_Dist_graph_neighbors_count(comm, indegree, outdegree, weighted)

- `MPI_Dist_graph_neighbors_count` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Dist_graph_neighbors_count.html`
"""
function MPI_Dist_graph_neighbors_count(comm, indegree, outdegree, weighted)
    @mpichk ccall((:MPI_Dist_graph_neighbors_count, libmpi), Cint, (MPI_Comm, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), comm, indegree, outdegree, weighted) v"2.2.0"
end

"""
    MPI_Graph_create(comm_old, nnodes, indx, edges, reorder, comm_graph)

- `MPI_Graph_create` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Graph_create.html`
"""
function MPI_Graph_create(comm_old, nnodes, indx, edges, reorder, comm_graph)
    @mpichk ccall((:MPI_Graph_create, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{MPI_Comm}), comm_old, nnodes, indx, edges, reorder, comm_graph)
end

"""
    MPI_Graph_get(comm, maxindex, maxedges, indx, edges)

- `MPI_Graph_get` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Graph_get.html`
"""
function MPI_Graph_get(comm, maxindex, maxedges, indx, edges)
    @mpichk ccall((:MPI_Graph_get, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{Cint}, Ptr{Cint}), comm, maxindex, maxedges, indx, edges)
end

"""
    MPI_Graph_map(comm, nnodes, indx, edges, newrank)

- `MPI_Graph_map` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Graph_map.html`
"""
function MPI_Graph_map(comm, nnodes, indx, edges, newrank)
    @mpichk ccall((:MPI_Graph_map, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), comm, nnodes, indx, edges, newrank)
end

"""
    MPI_Graph_neighbors(comm, rank, maxneighbors, neighbors)

- `MPI_Graph_neighbors` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Graph_neighbors.html`
"""
function MPI_Graph_neighbors(comm, rank, maxneighbors, neighbors)
    @mpichk ccall((:MPI_Graph_neighbors, libmpi), Cint, (MPI_Comm, Cint, Cint, Ptr{Cint}), comm, rank, maxneighbors, neighbors)
end

"""
    MPI_Graph_neighbors_count(comm, rank, nneighbors)

- `MPI_Graph_neighbors_count` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Graph_neighbors_count.html`
"""
function MPI_Graph_neighbors_count(comm, rank, nneighbors)
    @mpichk ccall((:MPI_Graph_neighbors_count, libmpi), Cint, (MPI_Comm, Cint, Ptr{Cint}), comm, rank, nneighbors)
end

"""
    MPI_Graphdims_get(comm, nnodes, nedges)

- `MPI_Graphdims_get` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Graphdims_get.html`
"""
function MPI_Graphdims_get(comm, nnodes, nedges)
    @mpichk ccall((:MPI_Graphdims_get, libmpi), Cint, (MPI_Comm, Ptr{Cint}, Ptr{Cint}), comm, nnodes, nedges)
end

"""
    MPI_Topo_test(comm, status)

- `MPI_Topo_test` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Topo_test.html`
"""
function MPI_Topo_test(comm, status)
    @mpichk ccall((:MPI_Topo_test, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, status)
end

"""
    MPI_Allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

- `MPI_Allgather_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Allgather_c.html`
"""
function MPI_Allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:MPI_Allgather_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

"""
    MPI_Allgather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

- `MPI_Allgather_init_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Allgather_init_c.html`
"""
function MPI_Allgather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Allgather_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    MPI_Allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)

- `MPI_Allgatherv_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Allgatherv_c.html`
"""
function MPI_Allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    @mpichk ccall((:MPI_Allgatherv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

"""
    MPI_Allgatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)

- `MPI_Allgatherv_init_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Allgatherv_init_c.html`
"""
function MPI_Allgatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Allgatherv_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
end

"""
    MPI_Allreduce_c(sendbuf, recvbuf, count, datatype, op, comm)

- `MPI_Allreduce_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Allreduce_c.html`
"""
function MPI_Allreduce_c(sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk ccall((:MPI_Allreduce_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

"""
    MPI_Allreduce_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)

- `MPI_Allreduce_init_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Allreduce_init_c.html`
"""
function MPI_Allreduce_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk ccall((:MPI_Allreduce_init_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

"""
    MPI_Alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

- `MPI_Alltoall_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Alltoall_c.html`
"""
function MPI_Alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:MPI_Alltoall_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

"""
    MPI_Alltoall_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

- `MPI_Alltoall_init_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Alltoall_init_c.html`
"""
function MPI_Alltoall_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Alltoall_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    MPI_Alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)

- `MPI_Alltoallv_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Alltoallv_c.html`
"""
function MPI_Alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    @mpichk ccall((:MPI_Alltoallv_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

"""
    MPI_Alltoallv_init_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)

- `MPI_Alltoallv_init_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Alltoallv_init_c.html`
"""
function MPI_Alltoallv_init_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Alltoallv_init_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
end

"""
    MPI_Alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)

- `MPI_Alltoallw_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Alltoallw_c.html`
"""
function MPI_Alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    @mpichk ccall((:MPI_Alltoallw_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

"""
    MPI_Alltoallw_init_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)

- `MPI_Alltoallw_init_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Alltoallw_init_c.html`
"""
function MPI_Alltoallw_init_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    @mpichk ccall((:MPI_Alltoallw_init_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
end

"""
    MPI_Bcast_c(buffer, count, datatype, root, comm)

- `MPI_Bcast_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Bcast_c.html`
"""
function MPI_Bcast_c(buffer, count, datatype, root, comm)
    @mpichk ccall((:MPI_Bcast_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm), buffer, count, datatype, root, comm)
end

"""
    MPI_Bcast_init_c(buffer, count, datatype, root, comm, info, request)

- `MPI_Bcast_init_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Bcast_init_c.html`
"""
function MPI_Bcast_init_c(buffer, count, datatype, root, comm, info, request)
    @mpichk ccall((:MPI_Bcast_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), buffer, count, datatype, root, comm, info, request)
end

"""
    MPI_Exscan_c(sendbuf, recvbuf, count, datatype, op, comm)

- `MPI_Exscan_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Exscan_c.html`
"""
function MPI_Exscan_c(sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk ccall((:MPI_Exscan_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

"""
    MPI_Exscan_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)

- `MPI_Exscan_init_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Exscan_init_c.html`
"""
function MPI_Exscan_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk ccall((:MPI_Exscan_init_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

"""
    MPI_Gather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)

- `MPI_Gather_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Gather_c.html`
"""
function MPI_Gather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk ccall((:MPI_Gather_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

"""
    MPI_Gather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

- `MPI_Gather_init_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Gather_init_c.html`
"""
function MPI_Gather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk ccall((:MPI_Gather_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

"""
    MPI_Gatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)

- `MPI_Gatherv_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Gatherv_c.html`
"""
function MPI_Gatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
    @mpichk ccall((:MPI_Gatherv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
end

"""
    MPI_Gatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)

- `MPI_Gatherv_init_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Gatherv_init_c.html`
"""
function MPI_Gatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
    @mpichk ccall((:MPI_Gatherv_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
end

"""
    MPI_Iallgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

- `MPI_Iallgather_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Iallgather_c.html`
"""
function MPI_Iallgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:MPI_Iallgather_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    MPI_Iallgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)

- `MPI_Iallgatherv_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Iallgatherv_c.html`
"""
function MPI_Iallgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    @mpichk ccall((:MPI_Iallgatherv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

"""
    MPI_Iallreduce_c(sendbuf, recvbuf, count, datatype, op, comm, request)

- `MPI_Iallreduce_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Iallreduce_c.html`
"""
function MPI_Iallreduce_c(sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk ccall((:MPI_Iallreduce_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

"""
    MPI_Ialltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

- `MPI_Ialltoall_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ialltoall_c.html`
"""
function MPI_Ialltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:MPI_Ialltoall_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    MPI_Ialltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)

- `MPI_Ialltoallv_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ialltoallv_c.html`
"""
function MPI_Ialltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    @mpichk ccall((:MPI_Ialltoallv_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

"""
    MPI_Ialltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)

- `MPI_Ialltoallw_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ialltoallw_c.html`
"""
function MPI_Ialltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    @mpichk ccall((:MPI_Ialltoallw_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

"""
    MPI_Ibcast_c(buffer, count, datatype, root, comm, request)

- `MPI_Ibcast_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ibcast_c.html`
"""
function MPI_Ibcast_c(buffer, count, datatype, root, comm, request)
    @mpichk ccall((:MPI_Ibcast_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), buffer, count, datatype, root, comm, request)
end

"""
    MPI_Iexscan_c(sendbuf, recvbuf, count, datatype, op, comm, request)

- `MPI_Iexscan_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Iexscan_c.html`
"""
function MPI_Iexscan_c(sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk ccall((:MPI_Iexscan_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

"""
    MPI_Igather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

- `MPI_Igather_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Igather_c.html`
"""
function MPI_Igather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk ccall((:MPI_Igather_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

"""
    MPI_Igatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)

- `MPI_Igatherv_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Igatherv_c.html`
"""
function MPI_Igatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
    @mpichk ccall((:MPI_Igatherv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
end

"""
    MPI_Ineighbor_allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

- `MPI_Ineighbor_allgather_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ineighbor_allgather_c.html`
"""
function MPI_Ineighbor_allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:MPI_Ineighbor_allgather_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    MPI_Ineighbor_allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)

- `MPI_Ineighbor_allgatherv_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ineighbor_allgatherv_c.html`
"""
function MPI_Ineighbor_allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    @mpichk ccall((:MPI_Ineighbor_allgatherv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
end

"""
    MPI_Ineighbor_alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

- `MPI_Ineighbor_alltoall_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ineighbor_alltoall_c.html`
"""
function MPI_Ineighbor_alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk ccall((:MPI_Ineighbor_alltoall_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
end

"""
    MPI_Ineighbor_alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)

- `MPI_Ineighbor_alltoallv_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ineighbor_alltoallv_c.html`
"""
function MPI_Ineighbor_alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    @mpichk ccall((:MPI_Ineighbor_alltoallv_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
end

"""
    MPI_Ineighbor_alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)

- `MPI_Ineighbor_alltoallw_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ineighbor_alltoallw_c.html`
"""
function MPI_Ineighbor_alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    @mpichk ccall((:MPI_Ineighbor_alltoallw_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
end

"""
    MPI_Ireduce_c(sendbuf, recvbuf, count, datatype, op, root, comm, request)

- `MPI_Ireduce_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ireduce_c.html`
"""
function MPI_Ireduce_c(sendbuf, recvbuf, count, datatype, op, root, comm, request)
    @mpichk ccall((:MPI_Ireduce_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, root, comm, request)
end

"""
    MPI_Ireduce_scatter_c(sendbuf, recvbuf, recvcounts, datatype, op, comm, request)

- `MPI_Ireduce_scatter_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ireduce_scatter_c.html`
"""
function MPI_Ireduce_scatter_c(sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
    @mpichk ccall((:MPI_Ireduce_scatter_c, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{MPI_Count}, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
end

"""
    MPI_Ireduce_scatter_block_c(sendbuf, recvbuf, recvcount, datatype, op, comm, request)

- `MPI_Ireduce_scatter_block_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ireduce_scatter_block_c.html`
"""
function MPI_Ireduce_scatter_block_c(sendbuf, recvbuf, recvcount, datatype, op, comm, request)
    @mpichk ccall((:MPI_Ireduce_scatter_block_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, recvcount, datatype, op, comm, request)
end

"""
    MPI_Iscan_c(sendbuf, recvbuf, count, datatype, op, comm, request)

- `MPI_Iscan_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Iscan_c.html`
"""
function MPI_Iscan_c(sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk ccall((:MPI_Iscan_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, request)
end

"""
    MPI_Iscatter_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

- `MPI_Iscatter_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Iscatter_c.html`
"""
function MPI_Iscatter_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk ccall((:MPI_Iscatter_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

"""
    MPI_Iscatterv_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

- `MPI_Iscatterv_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Iscatterv_c.html`
"""
function MPI_Iscatterv_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk ccall((:MPI_Iscatterv_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
end

"""
    MPI_Neighbor_allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

- `MPI_Neighbor_allgather_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Neighbor_allgather_c.html`
"""
function MPI_Neighbor_allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:MPI_Neighbor_allgather_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

"""
    MPI_Neighbor_allgather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

- `MPI_Neighbor_allgather_init_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Neighbor_allgather_init_c.html`
"""
function MPI_Neighbor_allgather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Neighbor_allgather_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    MPI_Neighbor_allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)

- `MPI_Neighbor_allgatherv_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Neighbor_allgatherv_c.html`
"""
function MPI_Neighbor_allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    @mpichk ccall((:MPI_Neighbor_allgatherv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
end

"""
    MPI_Neighbor_allgatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)

- `MPI_Neighbor_allgatherv_init_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Neighbor_allgatherv_init_c.html`
"""
function MPI_Neighbor_allgatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Neighbor_allgatherv_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
end

"""
    MPI_Neighbor_alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

- `MPI_Neighbor_alltoall_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Neighbor_alltoall_c.html`
"""
function MPI_Neighbor_alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk ccall((:MPI_Neighbor_alltoall_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
end

"""
    MPI_Neighbor_alltoall_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

- `MPI_Neighbor_alltoall_init_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Neighbor_alltoall_init_c.html`
"""
function MPI_Neighbor_alltoall_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Neighbor_alltoall_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
end

"""
    MPI_Neighbor_alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)

- `MPI_Neighbor_alltoallv_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Neighbor_alltoallv_c.html`
"""
function MPI_Neighbor_alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    @mpichk ccall((:MPI_Neighbor_alltoallv_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
end

"""
    MPI_Neighbor_alltoallv_init_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)

- `MPI_Neighbor_alltoallv_init_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Neighbor_alltoallv_init_c.html`
"""
function MPI_Neighbor_alltoallv_init_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    @mpichk ccall((:MPI_Neighbor_alltoallv_init_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
end

"""
    MPI_Neighbor_alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)

- `MPI_Neighbor_alltoallw_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Neighbor_alltoallw_c.html`
"""
function MPI_Neighbor_alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    @mpichk ccall((:MPI_Neighbor_alltoallw_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
end

"""
    MPI_Neighbor_alltoallw_init_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)

- `MPI_Neighbor_alltoallw_init_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Neighbor_alltoallw_init_c.html`
"""
function MPI_Neighbor_alltoallw_init_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    @mpichk ccall((:MPI_Neighbor_alltoallw_init_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, Ptr{MPI_Datatype}, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
end

"""
    MPI_Reduce_c(sendbuf, recvbuf, count, datatype, op, root, comm)

- `MPI_Reduce_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Reduce_c.html`
"""
function MPI_Reduce_c(sendbuf, recvbuf, count, datatype, op, root, comm)
    @mpichk ccall((:MPI_Reduce_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, Cint, MPI_Comm), sendbuf, recvbuf, count, datatype, op, root, comm)
end

"""
    MPI_Reduce_init_c(sendbuf, recvbuf, count, datatype, op, root, comm, info, request)

- `MPI_Reduce_init_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Reduce_init_c.html`
"""
function MPI_Reduce_init_c(sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
    @mpichk ccall((:MPI_Reduce_init_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
end

"""
    MPI_Reduce_local_c(inbuf, inoutbuf, count, datatype, op)

- `MPI_Reduce_local_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Reduce_local_c.html`
"""
function MPI_Reduce_local_c(inbuf, inoutbuf, count, datatype, op)
    @mpichk ccall((:MPI_Reduce_local_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op), inbuf, inoutbuf, count, datatype, op)
end

"""
    MPI_Reduce_scatter_c(sendbuf, recvbuf, recvcounts, datatype, op, comm)

- `MPI_Reduce_scatter_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Reduce_scatter_c.html`
"""
function MPI_Reduce_scatter_c(sendbuf, recvbuf, recvcounts, datatype, op, comm)
    @mpichk ccall((:MPI_Reduce_scatter_c, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{MPI_Count}, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, recvcounts, datatype, op, comm)
end

"""
    MPI_Reduce_scatter_block_c(sendbuf, recvbuf, recvcount, datatype, op, comm)

- `MPI_Reduce_scatter_block_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Reduce_scatter_block_c.html`
"""
function MPI_Reduce_scatter_block_c(sendbuf, recvbuf, recvcount, datatype, op, comm)
    @mpichk ccall((:MPI_Reduce_scatter_block_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, recvcount, datatype, op, comm)
end

"""
    MPI_Reduce_scatter_block_init_c(sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)

- `MPI_Reduce_scatter_block_init_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Reduce_scatter_block_init_c.html`
"""
function MPI_Reduce_scatter_block_init_c(sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
    @mpichk ccall((:MPI_Reduce_scatter_block_init_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
end

"""
    MPI_Reduce_scatter_init_c(sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)

- `MPI_Reduce_scatter_init_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Reduce_scatter_init_c.html`
"""
function MPI_Reduce_scatter_init_c(sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
    @mpichk ccall((:MPI_Reduce_scatter_init_c, libmpi), Cint, (MPIPtr, MPIPtr, Ptr{MPI_Count}, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
end

"""
    MPI_Scan_c(sendbuf, recvbuf, count, datatype, op, comm)

- `MPI_Scan_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Scan_c.html`
"""
function MPI_Scan_c(sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk ccall((:MPI_Scan_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm), sendbuf, recvbuf, count, datatype, op, comm)
end

"""
    MPI_Scan_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)

- `MPI_Scan_init_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Scan_init_c.html`
"""
function MPI_Scan_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk ccall((:MPI_Scan_init_c, libmpi), Cint, (MPIPtr, MPIPtr, MPI_Count, MPI_Datatype, MPI_Op, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, recvbuf, count, datatype, op, comm, info, request)
end

"""
    MPI_Scatter_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)

- `MPI_Scatter_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Scatter_c.html`
"""
function MPI_Scatter_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk ccall((:MPI_Scatter_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

"""
    MPI_Scatter_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

- `MPI_Scatter_init_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Scatter_init_c.html`
"""
function MPI_Scatter_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk ccall((:MPI_Scatter_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

"""
    MPI_Scatterv_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)

- `MPI_Scatterv_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Scatterv_c.html`
"""
function MPI_Scatterv_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk ccall((:MPI_Scatterv_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
end

"""
    MPI_Scatterv_init_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

- `MPI_Scatterv_init_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Scatterv_init_c.html`
"""
function MPI_Scatterv_init_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk ccall((:MPI_Scatterv_init_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}, Ptr{MPI_Aint}, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Comm, MPI_Info, Ptr{MPI_Request}), sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
end

"""
    MPI_Get_count_c(status, datatype, count)

- `MPI_Get_count_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Get_count_c.html`
"""
function MPI_Get_count_c(status, datatype, count)
    @mpichk ccall((:MPI_Get_count_c, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Ptr{MPI_Count}), status, datatype, count)
end

"""
    MPI_Get_elements_c(status, datatype, count)

- `MPI_Get_elements_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Get_elements_c.html`
"""
function MPI_Get_elements_c(status, datatype, count)
    @mpichk ccall((:MPI_Get_elements_c, libmpi), Cint, (Ptr{MPI_Status}, MPI_Datatype, Ptr{MPI_Count}), status, datatype, count)
end

"""
    MPI_Pack_c(inbuf, incount, datatype, outbuf, outsize, position, comm)

- `MPI_Pack_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Pack_c.html`
"""
function MPI_Pack_c(inbuf, incount, datatype, outbuf, outsize, position, comm)
    @mpichk ccall((:MPI_Pack_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, Ptr{MPI_Count}, MPI_Comm), inbuf, incount, datatype, outbuf, outsize, position, comm)
end

"""
    MPI_Pack_external_c(datarep, inbuf, incount, datatype, outbuf, outsize, position)

- `MPI_Pack_external_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Pack_external_c.html`
"""
function MPI_Pack_external_c(datarep, inbuf, incount, datatype, outbuf, outsize, position)
    @mpichk ccall((:MPI_Pack_external_c, libmpi), Cint, (Ptr{Cchar}, MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, Ptr{MPI_Count}), datarep, inbuf, incount, datatype, outbuf, outsize, position)
end

"""
    MPI_Pack_external_size_c(datarep, incount, datatype, size)

- `MPI_Pack_external_size_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Pack_external_size_c.html`
"""
function MPI_Pack_external_size_c(datarep, incount, datatype, size)
    @mpichk ccall((:MPI_Pack_external_size_c, libmpi), Cint, (Ptr{Cchar}, MPI_Count, MPI_Datatype, Ptr{MPI_Count}), datarep, incount, datatype, size)
end

"""
    MPI_Pack_size_c(incount, datatype, comm, size)

- `MPI_Pack_size_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Pack_size_c.html`
"""
function MPI_Pack_size_c(incount, datatype, comm, size)
    @mpichk ccall((:MPI_Pack_size_c, libmpi), Cint, (MPI_Count, MPI_Datatype, MPI_Comm, Ptr{MPI_Count}), incount, datatype, comm, size)
end

"""
    MPI_Type_contiguous_c(count, oldtype, newtype)

- `MPI_Type_contiguous_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_contiguous_c.html`
"""
function MPI_Type_contiguous_c(count, oldtype, newtype)
    @mpichk ccall((:MPI_Type_contiguous_c, libmpi), Cint, (MPI_Count, MPI_Datatype, Ptr{MPI_Datatype}), count, oldtype, newtype)
end

"""
    MPI_Type_create_darray_c(size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)

- `MPI_Type_create_darray_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_create_darray_c.html`
"""
function MPI_Type_create_darray_c(size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
    @mpichk ccall((:MPI_Type_create_darray_c, libmpi), Cint, (Cint, Cint, Cint, Ptr{MPI_Count}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
end

"""
    MPI_Type_create_hindexed_c(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)

- `MPI_Type_create_hindexed_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_create_hindexed_c.html`
"""
function MPI_Type_create_hindexed_c(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:MPI_Type_create_hindexed_c, libmpi), Cint, (MPI_Count, Ptr{MPI_Count}, Ptr{MPI_Count}, MPI_Datatype, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

"""
    MPI_Type_create_hindexed_block_c(count, blocklength, array_of_displacements, oldtype, newtype)

- `MPI_Type_create_hindexed_block_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_create_hindexed_block_c.html`
"""
function MPI_Type_create_hindexed_block_c(count, blocklength, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:MPI_Type_create_hindexed_block_c, libmpi), Cint, (MPI_Count, MPI_Count, Ptr{MPI_Count}, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, array_of_displacements, oldtype, newtype)
end

"""
    MPI_Type_create_hvector_c(count, blocklength, stride, oldtype, newtype)

- `MPI_Type_create_hvector_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_create_hvector_c.html`
"""
function MPI_Type_create_hvector_c(count, blocklength, stride, oldtype, newtype)
    @mpichk ccall((:MPI_Type_create_hvector_c, libmpi), Cint, (MPI_Count, MPI_Count, MPI_Count, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

"""
    MPI_Type_create_indexed_block_c(count, blocklength, array_of_displacements, oldtype, newtype)

- `MPI_Type_create_indexed_block_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_create_indexed_block_c.html`
"""
function MPI_Type_create_indexed_block_c(count, blocklength, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:MPI_Type_create_indexed_block_c, libmpi), Cint, (MPI_Count, MPI_Count, Ptr{MPI_Count}, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, array_of_displacements, oldtype, newtype)
end

"""
    MPI_Type_create_resized_c(oldtype, lb, extent, newtype)

- `MPI_Type_create_resized_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_create_resized_c.html`
"""
function MPI_Type_create_resized_c(oldtype, lb, extent, newtype)
    @mpichk ccall((:MPI_Type_create_resized_c, libmpi), Cint, (MPI_Datatype, MPI_Count, MPI_Count, Ptr{MPI_Datatype}), oldtype, lb, extent, newtype)
end

"""
    MPI_Type_create_struct_c(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)

- `MPI_Type_create_struct_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_create_struct_c.html`
"""
function MPI_Type_create_struct_c(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
    @mpichk ccall((:MPI_Type_create_struct_c, libmpi), Cint, (MPI_Count, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
end

"""
    MPI_Type_create_subarray_c(ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)

- `MPI_Type_create_subarray_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_create_subarray_c.html`
"""
function MPI_Type_create_subarray_c(ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
    @mpichk ccall((:MPI_Type_create_subarray_c, libmpi), Cint, (Cint, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Count}, Cint, MPI_Datatype, Ptr{MPI_Datatype}), ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
end

"""
    MPI_Type_get_contents_c(datatype, max_integers, max_addresses, max_large_counts, max_datatypes, array_of_integers, array_of_addresses, array_of_large_counts, array_of_datatypes)

- `MPI_Type_get_contents_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_get_contents_c.html`
"""
function MPI_Type_get_contents_c(datatype, max_integers, max_addresses, max_large_counts, max_datatypes, array_of_integers, array_of_addresses, array_of_large_counts, array_of_datatypes)
    @mpichk ccall((:MPI_Type_get_contents_c, libmpi), Cint, (MPI_Datatype, MPI_Count, MPI_Count, MPI_Count, MPI_Count, Ptr{Cint}, Ptr{MPI_Aint}, Ptr{MPI_Count}, Ptr{MPI_Datatype}), datatype, max_integers, max_addresses, max_large_counts, max_datatypes, array_of_integers, array_of_addresses, array_of_large_counts, array_of_datatypes)
end

"""
    MPI_Type_get_envelope_c(datatype, num_integers, num_addresses, num_large_counts, num_datatypes, combiner)

- `MPI_Type_get_envelope_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_get_envelope_c.html`
"""
function MPI_Type_get_envelope_c(datatype, num_integers, num_addresses, num_large_counts, num_datatypes, combiner)
    @mpichk ccall((:MPI_Type_get_envelope_c, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{MPI_Count}, Ptr{Cint}), datatype, num_integers, num_addresses, num_large_counts, num_datatypes, combiner)
end

"""
    MPI_Type_get_extent_c(datatype, lb, extent)

- `MPI_Type_get_extent_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_get_extent_c.html`
"""
function MPI_Type_get_extent_c(datatype, lb, extent)
    @mpichk ccall((:MPI_Type_get_extent_c, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), datatype, lb, extent)
end

"""
    MPI_Type_get_true_extent_c(datatype, true_lb, true_extent)

- `MPI_Type_get_true_extent_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_get_true_extent_c.html`
"""
function MPI_Type_get_true_extent_c(datatype, true_lb, true_extent)
    @mpichk ccall((:MPI_Type_get_true_extent_c, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}, Ptr{MPI_Count}), datatype, true_lb, true_extent)
end

"""
    MPI_Type_indexed_c(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)

- `MPI_Type_indexed_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_indexed_c.html`
"""
function MPI_Type_indexed_c(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    @mpichk ccall((:MPI_Type_indexed_c, libmpi), Cint, (MPI_Count, Ptr{MPI_Count}, Ptr{MPI_Count}, MPI_Datatype, Ptr{MPI_Datatype}), count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
end

"""
    MPI_Type_size_c(datatype, size)

- `MPI_Type_size_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_size_c.html`
"""
function MPI_Type_size_c(datatype, size)
    @mpichk ccall((:MPI_Type_size_c, libmpi), Cint, (MPI_Datatype, Ptr{MPI_Count}), datatype, size)
end

"""
    MPI_Type_vector_c(count, blocklength, stride, oldtype, newtype)

- `MPI_Type_vector_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Type_vector_c.html`
"""
function MPI_Type_vector_c(count, blocklength, stride, oldtype, newtype)
    @mpichk ccall((:MPI_Type_vector_c, libmpi), Cint, (MPI_Count, MPI_Count, MPI_Count, MPI_Datatype, Ptr{MPI_Datatype}), count, blocklength, stride, oldtype, newtype)
end

"""
    MPI_Unpack_c(inbuf, insize, position, outbuf, outcount, datatype, comm)

- `MPI_Unpack_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Unpack_c.html`
"""
function MPI_Unpack_c(inbuf, insize, position, outbuf, outcount, datatype, comm)
    @mpichk ccall((:MPI_Unpack_c, libmpi), Cint, (MPIPtr, MPI_Count, Ptr{MPI_Count}, MPIPtr, MPI_Count, MPI_Datatype, MPI_Comm), inbuf, insize, position, outbuf, outcount, datatype, comm)
end

"""
    MPI_Unpack_external_c(datarep, inbuf, insize, position, outbuf, outcount, datatype)

- `MPI_Unpack_external_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Unpack_external_c.html`
"""
function MPI_Unpack_external_c(datarep, inbuf, insize, position, outbuf, outcount, datatype)
    @mpichk ccall((:MPI_Unpack_external_c, libmpi), Cint, (Ptr{Cchar}, MPIPtr, MPI_Count, Ptr{MPI_Count}, MPIPtr, MPI_Count, MPI_Datatype), datarep, inbuf, insize, position, outbuf, outcount, datatype)
end

"""
    MPI_Op_create_c(user_fn, commute, op)

- `MPI_Op_create_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Op_create_c.html`
"""
function MPI_Op_create_c(user_fn, commute, op)
    @mpichk ccall((:MPI_Op_create_c, libmpi), Cint, (MPIPtr, Cint, Ptr{MPI_Op}), user_fn, commute, op)
end

"""
    MPI_Bsend_c(buf, count, datatype, dest, tag, comm)

- `MPI_Bsend_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Bsend_c.html`
"""
function MPI_Bsend_c(buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:MPI_Bsend_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

"""
    MPI_Bsend_init_c(buf, count, datatype, dest, tag, comm, request)

- `MPI_Bsend_init_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Bsend_init_c.html`
"""
function MPI_Bsend_init_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Bsend_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Buffer_attach_c(buffer, size)

- `MPI_Buffer_attach_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Buffer_attach_c.html`
"""
function MPI_Buffer_attach_c(buffer, size)
    @mpichk ccall((:MPI_Buffer_attach_c, libmpi), Cint, (MPIPtr, MPI_Count), buffer, size)
end

"""
    MPI_Buffer_detach_c(buffer_addr, size)

- `MPI_Buffer_detach_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Buffer_detach_c.html`
"""
function MPI_Buffer_detach_c(buffer_addr, size)
    @mpichk ccall((:MPI_Buffer_detach_c, libmpi), Cint, (MPIPtr, Ptr{MPI_Count}), buffer_addr, size)
end

"""
    MPI_Ibsend_c(buf, count, datatype, dest, tag, comm, request)

- `MPI_Ibsend_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ibsend_c.html`
"""
function MPI_Ibsend_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Ibsend_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Imrecv_c(buf, count, datatype, message, request)

- `MPI_Imrecv_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Imrecv_c.html`
"""
function MPI_Imrecv_c(buf, count, datatype, message, request)
    @mpichk ccall((:MPI_Imrecv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Request}), buf, count, datatype, message, request)
end

"""
    MPI_Irecv_c(buf, count, datatype, source, tag, comm, request)

- `MPI_Irecv_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Irecv_c.html`
"""
function MPI_Irecv_c(buf, count, datatype, source, tag, comm, request)
    @mpichk ccall((:MPI_Irecv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, source, tag, comm, request)
end

"""
    MPI_Irsend_c(buf, count, datatype, dest, tag, comm, request)

- `MPI_Irsend_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Irsend_c.html`
"""
function MPI_Irsend_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Irsend_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Isend_c(buf, count, datatype, dest, tag, comm, request)

- `MPI_Isend_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Isend_c.html`
"""
function MPI_Isend_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Isend_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Isendrecv_c(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)

- `MPI_Isendrecv_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Isendrecv_c.html`
"""
function MPI_Isendrecv_c(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
    @mpichk ccall((:MPI_Isendrecv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
end

"""
    MPI_Isendrecv_replace_c(buf, count, datatype, dest, sendtag, source, recvtag, comm, request)

- `MPI_Isendrecv_replace_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Isendrecv_replace_c.html`
"""
function MPI_Isendrecv_replace_c(buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
    @mpichk ccall((:MPI_Isendrecv_replace_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
end

"""
    MPI_Issend_c(buf, count, datatype, dest, tag, comm, request)

- `MPI_Issend_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Issend_c.html`
"""
function MPI_Issend_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Issend_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Mrecv_c(buf, count, datatype, message, status)

- `MPI_Mrecv_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Mrecv_c.html`
"""
function MPI_Mrecv_c(buf, count, datatype, message, status)
    @mpichk ccall((:MPI_Mrecv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Message}, Ptr{MPI_Status}), buf, count, datatype, message, status)
end

"""
    MPI_Recv_c(buf, count, datatype, source, tag, comm, status)

- `MPI_Recv_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Recv_c.html`
"""
function MPI_Recv_c(buf, count, datatype, source, tag, comm, status)
    @mpichk ccall((:MPI_Recv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), buf, count, datatype, source, tag, comm, status)
end

"""
    MPI_Recv_init_c(buf, count, datatype, source, tag, comm, request)

- `MPI_Recv_init_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Recv_init_c.html`
"""
function MPI_Recv_init_c(buf, count, datatype, source, tag, comm, request)
    @mpichk ccall((:MPI_Recv_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, source, tag, comm, request)
end

"""
    MPI_Rsend_c(buf, count, datatype, dest, tag, comm)

- `MPI_Rsend_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Rsend_c.html`
"""
function MPI_Rsend_c(buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:MPI_Rsend_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

"""
    MPI_Rsend_init_c(buf, count, datatype, dest, tag, comm, request)

- `MPI_Rsend_init_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Rsend_init_c.html`
"""
function MPI_Rsend_init_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Rsend_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Send_c(buf, count, datatype, dest, tag, comm)

- `MPI_Send_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Send_c.html`
"""
function MPI_Send_c(buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:MPI_Send_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

"""
    MPI_Send_init_c(buf, count, datatype, dest, tag, comm, request)

- `MPI_Send_init_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Send_init_c.html`
"""
function MPI_Send_init_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Send_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Sendrecv_c(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)

- `MPI_Sendrecv_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Sendrecv_c.html`
"""
function MPI_Sendrecv_c(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
    @mpichk ccall((:MPI_Sendrecv_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
end

"""
    MPI_Sendrecv_replace_c(buf, count, datatype, dest, sendtag, source, recvtag, comm, status)

- `MPI_Sendrecv_replace_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Sendrecv_replace_c.html`
"""
function MPI_Sendrecv_replace_c(buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
    @mpichk ccall((:MPI_Sendrecv_replace_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, Cint, Cint, MPI_Comm, Ptr{MPI_Status}), buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
end

"""
    MPI_Ssend_c(buf, count, datatype, dest, tag, comm)

- `MPI_Ssend_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ssend_c.html`
"""
function MPI_Ssend_c(buf, count, datatype, dest, tag, comm)
    @mpichk ccall((:MPI_Ssend_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm), buf, count, datatype, dest, tag, comm)
end

"""
    MPI_Ssend_init_c(buf, count, datatype, dest, tag, comm, request)

- `MPI_Ssend_init_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Ssend_init_c.html`
"""
function MPI_Ssend_init_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk ccall((:MPI_Ssend_init_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, Cint, MPI_Comm, Ptr{MPI_Request}), buf, count, datatype, dest, tag, comm, request)
end

"""
    MPI_Accumulate_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)

- `MPI_Accumulate_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Accumulate_c.html`
"""
function MPI_Accumulate_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    @mpichk ccall((:MPI_Accumulate_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Op, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

"""
    MPI_Get_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)

- `MPI_Get_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Get_c.html`
"""
function MPI_Get_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    @mpichk ccall((:MPI_Get_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

"""
    MPI_Get_accumulate_c(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)

- `MPI_Get_accumulate_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Get_accumulate_c.html`
"""
function MPI_Get_accumulate_c(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    @mpichk ccall((:MPI_Get_accumulate_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Op, MPI_Win), origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
end

"""
    MPI_Put_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)

- `MPI_Put_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Put_c.html`
"""
function MPI_Put_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    @mpichk ccall((:MPI_Put_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Win), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
end

"""
    MPI_Raccumulate_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)

- `MPI_Raccumulate_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Raccumulate_c.html`
"""
function MPI_Raccumulate_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    @mpichk ccall((:MPI_Raccumulate_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

"""
    MPI_Rget_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)

- `MPI_Rget_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Rget_c.html`
"""
function MPI_Rget_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    @mpichk ccall((:MPI_Rget_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

"""
    MPI_Rget_accumulate_c(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)

- `MPI_Rget_accumulate_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Rget_accumulate_c.html`
"""
function MPI_Rget_accumulate_c(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    @mpichk ccall((:MPI_Rget_accumulate_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Op, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
end

"""
    MPI_Rput_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)

- `MPI_Rput_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Rput_c.html`
"""
function MPI_Rput_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    @mpichk ccall((:MPI_Rput_c, libmpi), Cint, (MPIPtr, MPI_Count, MPI_Datatype, Cint, MPI_Aint, MPI_Count, MPI_Datatype, MPI_Win, Ptr{MPI_Request}), origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
end

"""
    MPI_Win_allocate_c(size, disp_unit, info, comm, baseptr, win)

- `MPI_Win_allocate_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_allocate_c.html`
"""
function MPI_Win_allocate_c(size, disp_unit, info, comm, baseptr, win)
    @mpichk ccall((:MPI_Win_allocate_c, libmpi), Cint, (MPI_Aint, MPI_Aint, MPI_Info, MPI_Comm, MPIPtr, Ptr{MPI_Win}), size, disp_unit, info, comm, baseptr, win)
end

"""
    MPI_Win_allocate_shared_c(size, disp_unit, info, comm, baseptr, win)

- `MPI_Win_allocate_shared_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_allocate_shared_c.html`
"""
function MPI_Win_allocate_shared_c(size, disp_unit, info, comm, baseptr, win)
    @mpichk ccall((:MPI_Win_allocate_shared_c, libmpi), Cint, (MPI_Aint, MPI_Aint, MPI_Info, MPI_Comm, MPIPtr, Ptr{MPI_Win}), size, disp_unit, info, comm, baseptr, win)
end

"""
    MPI_Win_create_c(base, size, disp_unit, info, comm, win)

- `MPI_Win_create_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_create_c.html`
"""
function MPI_Win_create_c(base, size, disp_unit, info, comm, win)
    @mpichk ccall((:MPI_Win_create_c, libmpi), Cint, (MPIPtr, MPI_Aint, MPI_Aint, MPI_Info, MPI_Comm, Ptr{MPI_Win}), base, size, disp_unit, info, comm, win)
end

"""
    MPI_Win_shared_query_c(win, rank, size, disp_unit, baseptr)

- `MPI_Win_shared_query_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Win_shared_query_c.html`
"""
function MPI_Win_shared_query_c(win, rank, size, disp_unit, baseptr)
    @mpichk ccall((:MPI_Win_shared_query_c, libmpi), Cint, (MPI_Win, Cint, Ptr{MPI_Aint}, Ptr{MPI_Aint}, MPIPtr), win, rank, size, disp_unit, baseptr)
end

"""
    MPI_File_open(comm, filename, amode, info, fh)

- `MPI_File_open` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_open.html`
"""
function MPI_File_open(comm, filename, amode, info, fh)
    @mpichk ccall((:MPI_File_open, libmpi), Cint, (MPI_Comm, Ptr{Cchar}, Cint, MPI_Info, Ptr{MPI_File}), comm, filename, amode, info, fh)
end

"""
    MPI_File_close(fh)

- `MPI_File_close` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_close.html`
"""
function MPI_File_close(fh)
    @mpichk ccall((:MPI_File_close, libmpi), Cint, (Ptr{MPI_File},), fh)
end

"""
    MPI_File_delete(filename, info)

- `MPI_File_delete` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_delete.html`
"""
function MPI_File_delete(filename, info)
    @mpichk ccall((:MPI_File_delete, libmpi), Cint, (Ptr{Cchar}, MPI_Info), filename, info)
end

"""
    MPI_File_set_size(fh, size)

- `MPI_File_set_size` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_set_size.html`
"""
function MPI_File_set_size(fh, size)
    @mpichk ccall((:MPI_File_set_size, libmpi), Cint, (MPI_File, MPI_Offset), fh, size)
end

"""
    MPI_File_preallocate(fh, size)

- `MPI_File_preallocate` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_preallocate.html`
"""
function MPI_File_preallocate(fh, size)
    @mpichk ccall((:MPI_File_preallocate, libmpi), Cint, (MPI_File, MPI_Offset), fh, size)
end

"""
    MPI_File_get_size(fh, size)

- `MPI_File_get_size` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_get_size.html`
"""
function MPI_File_get_size(fh, size)
    @mpichk ccall((:MPI_File_get_size, libmpi), Cint, (MPI_File, Ptr{MPI_Offset}), fh, size)
end

"""
    MPI_File_get_group(fh, group)

- `MPI_File_get_group` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_get_group.html`
"""
function MPI_File_get_group(fh, group)
    @mpichk ccall((:MPI_File_get_group, libmpi), Cint, (MPI_File, Ptr{MPI_Group}), fh, group)
end

"""
    MPI_File_get_amode(fh, amode)

- `MPI_File_get_amode` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_get_amode.html`
"""
function MPI_File_get_amode(fh, amode)
    @mpichk ccall((:MPI_File_get_amode, libmpi), Cint, (MPI_File, Ptr{Cint}), fh, amode)
end

"""
    MPI_File_set_info(fh, info)

- `MPI_File_set_info` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_set_info.html`
"""
function MPI_File_set_info(fh, info)
    @mpichk ccall((:MPI_File_set_info, libmpi), Cint, (MPI_File, MPI_Info), fh, info)
end

"""
    MPI_File_get_info(fh, info_used)

- `MPI_File_get_info` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_get_info.html`
"""
function MPI_File_get_info(fh, info_used)
    @mpichk ccall((:MPI_File_get_info, libmpi), Cint, (MPI_File, Ptr{MPI_Info}), fh, info_used)
end

"""
    MPI_File_set_view(fh, disp, etype, filetype, datarep, info)

- `MPI_File_set_view` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_set_view.html`
"""
function MPI_File_set_view(fh, disp, etype, filetype, datarep, info)
    @mpichk ccall((:MPI_File_set_view, libmpi), Cint, (MPI_File, MPI_Offset, MPI_Datatype, MPI_Datatype, Ptr{Cchar}, MPI_Info), fh, disp, etype, filetype, datarep, info)
end

"""
    MPI_File_get_view(fh, disp, etype, filetype, datarep)

- `MPI_File_get_view` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_get_view.html`
"""
function MPI_File_get_view(fh, disp, etype, filetype, datarep)
    @mpichk ccall((:MPI_File_get_view, libmpi), Cint, (MPI_File, Ptr{MPI_Offset}, Ptr{MPI_Datatype}, Ptr{MPI_Datatype}, Ptr{Cchar}), fh, disp, etype, filetype, datarep)
end

"""
    MPI_File_read_at(fh, offset, buf, count, datatype, status)

- `MPI_File_read_at` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_read_at.html`
"""
function MPI_File_read_at(fh, offset, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_read_at, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

"""
    MPI_File_read_at_all(fh, offset, buf, count, datatype, status)

- `MPI_File_read_at_all` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_read_at_all.html`
"""
function MPI_File_read_at_all(fh, offset, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_read_at_all, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

"""
    MPI_File_write_at(fh, offset, buf, count, datatype, status)

- `MPI_File_write_at` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_write_at.html`
"""
function MPI_File_write_at(fh, offset, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_write_at, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

"""
    MPI_File_write_at_all(fh, offset, buf, count, datatype, status)

- `MPI_File_write_at_all` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_write_at_all.html`
"""
function MPI_File_write_at_all(fh, offset, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_write_at_all, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

"""
    MPI_File_iread_at(fh, offset, buf, count, datatype, request)

- `MPI_File_iread_at` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_iread_at.html`
"""
function MPI_File_iread_at(fh, offset, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iread_at, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

"""
    MPI_File_iwrite_at(fh, offset, buf, count, datatype, request)

- `MPI_File_iwrite_at` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_iwrite_at.html`
"""
function MPI_File_iwrite_at(fh, offset, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iwrite_at, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

"""
    MPI_File_read(fh, buf, count, datatype, status)

- `MPI_File_read` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_read.html`
"""
function MPI_File_read(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_read, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_read_all(fh, buf, count, datatype, status)

- `MPI_File_read_all` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_read_all.html`
"""
function MPI_File_read_all(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_read_all, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_write(fh, buf, count, datatype, status)

- `MPI_File_write` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_write.html`
"""
function MPI_File_write(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_write, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_write_all(fh, buf, count, datatype, status)

- `MPI_File_write_all` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_write_all.html`
"""
function MPI_File_write_all(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_write_all, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_iread(fh, buf, count, datatype, request)

- `MPI_File_iread` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_iread.html`
"""
function MPI_File_iread(fh, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iread, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    MPI_File_iwrite(fh, buf, count, datatype, request)

- `MPI_File_iwrite` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_iwrite.html`
"""
function MPI_File_iwrite(fh, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iwrite, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    MPI_File_seek(fh, offset, whence)

- `MPI_File_seek` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_seek.html`
"""
function MPI_File_seek(fh, offset, whence)
    @mpichk ccall((:MPI_File_seek, libmpi), Cint, (MPI_File, MPI_Offset, Cint), fh, offset, whence)
end

"""
    MPI_File_get_position(fh, offset)

- `MPI_File_get_position` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_get_position.html`
"""
function MPI_File_get_position(fh, offset)
    @mpichk ccall((:MPI_File_get_position, libmpi), Cint, (MPI_File, Ptr{MPI_Offset}), fh, offset)
end

"""
    MPI_File_get_byte_offset(fh, offset, disp)

- `MPI_File_get_byte_offset` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_get_byte_offset.html`
"""
function MPI_File_get_byte_offset(fh, offset, disp)
    @mpichk ccall((:MPI_File_get_byte_offset, libmpi), Cint, (MPI_File, MPI_Offset, Ptr{MPI_Offset}), fh, offset, disp)
end

"""
    MPI_File_read_shared(fh, buf, count, datatype, status)

- `MPI_File_read_shared` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_read_shared.html`
"""
function MPI_File_read_shared(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_read_shared, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_write_shared(fh, buf, count, datatype, status)

- `MPI_File_write_shared` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_write_shared.html`
"""
function MPI_File_write_shared(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_write_shared, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_iread_shared(fh, buf, count, datatype, request)

- `MPI_File_iread_shared` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_iread_shared.html`
"""
function MPI_File_iread_shared(fh, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iread_shared, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    MPI_File_iwrite_shared(fh, buf, count, datatype, request)

- `MPI_File_iwrite_shared` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_iwrite_shared.html`
"""
function MPI_File_iwrite_shared(fh, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iwrite_shared, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    MPI_File_read_ordered(fh, buf, count, datatype, status)

- `MPI_File_read_ordered` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_read_ordered.html`
"""
function MPI_File_read_ordered(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_read_ordered, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_write_ordered(fh, buf, count, datatype, status)

- `MPI_File_write_ordered` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_write_ordered.html`
"""
function MPI_File_write_ordered(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_write_ordered, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_seek_shared(fh, offset, whence)

- `MPI_File_seek_shared` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_seek_shared.html`
"""
function MPI_File_seek_shared(fh, offset, whence)
    @mpichk ccall((:MPI_File_seek_shared, libmpi), Cint, (MPI_File, MPI_Offset, Cint), fh, offset, whence)
end

"""
    MPI_File_get_position_shared(fh, offset)

- `MPI_File_get_position_shared` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_get_position_shared.html`
"""
function MPI_File_get_position_shared(fh, offset)
    @mpichk ccall((:MPI_File_get_position_shared, libmpi), Cint, (MPI_File, Ptr{MPI_Offset}), fh, offset)
end

"""
    MPI_File_read_at_all_begin(fh, offset, buf, count, datatype)

- `MPI_File_read_at_all_begin` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_read_at_all_begin.html`
"""
function MPI_File_read_at_all_begin(fh, offset, buf, count, datatype)
    @mpichk ccall((:MPI_File_read_at_all_begin, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype), fh, offset, buf, count, datatype)
end

"""
    MPI_File_read_at_all_end(fh, buf, status)

- `MPI_File_read_at_all_end` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_read_at_all_end.html`
"""
function MPI_File_read_at_all_end(fh, buf, status)
    @mpichk ccall((:MPI_File_read_at_all_end, libmpi), Cint, (MPI_File, MPIPtr, Ptr{MPI_Status}), fh, buf, status)
end

"""
    MPI_File_write_at_all_begin(fh, offset, buf, count, datatype)

- `MPI_File_write_at_all_begin` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_write_at_all_begin.html`
"""
function MPI_File_write_at_all_begin(fh, offset, buf, count, datatype)
    @mpichk ccall((:MPI_File_write_at_all_begin, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype), fh, offset, buf, count, datatype)
end

"""
    MPI_File_write_at_all_end(fh, buf, status)

- `MPI_File_write_at_all_end` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_write_at_all_end.html`
"""
function MPI_File_write_at_all_end(fh, buf, status)
    @mpichk ccall((:MPI_File_write_at_all_end, libmpi), Cint, (MPI_File, MPIPtr, Ptr{MPI_Status}), fh, buf, status)
end

"""
    MPI_File_read_all_begin(fh, buf, count, datatype)

- `MPI_File_read_all_begin` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_read_all_begin.html`
"""
function MPI_File_read_all_begin(fh, buf, count, datatype)
    @mpichk ccall((:MPI_File_read_all_begin, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype), fh, buf, count, datatype)
end

"""
    MPI_File_read_all_end(fh, buf, status)

- `MPI_File_read_all_end` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_read_all_end.html`
"""
function MPI_File_read_all_end(fh, buf, status)
    @mpichk ccall((:MPI_File_read_all_end, libmpi), Cint, (MPI_File, MPIPtr, Ptr{MPI_Status}), fh, buf, status)
end

"""
    MPI_File_write_all_begin(fh, buf, count, datatype)

- `MPI_File_write_all_begin` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_write_all_begin.html`
"""
function MPI_File_write_all_begin(fh, buf, count, datatype)
    @mpichk ccall((:MPI_File_write_all_begin, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype), fh, buf, count, datatype)
end

"""
    MPI_File_write_all_end(fh, buf, status)

- `MPI_File_write_all_end` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_write_all_end.html`
"""
function MPI_File_write_all_end(fh, buf, status)
    @mpichk ccall((:MPI_File_write_all_end, libmpi), Cint, (MPI_File, MPIPtr, Ptr{MPI_Status}), fh, buf, status)
end

"""
    MPI_File_read_ordered_begin(fh, buf, count, datatype)

- `MPI_File_read_ordered_begin` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_read_ordered_begin.html`
"""
function MPI_File_read_ordered_begin(fh, buf, count, datatype)
    @mpichk ccall((:MPI_File_read_ordered_begin, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype), fh, buf, count, datatype)
end

"""
    MPI_File_read_ordered_end(fh, buf, status)

- `MPI_File_read_ordered_end` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_read_ordered_end.html`
"""
function MPI_File_read_ordered_end(fh, buf, status)
    @mpichk ccall((:MPI_File_read_ordered_end, libmpi), Cint, (MPI_File, MPIPtr, Ptr{MPI_Status}), fh, buf, status)
end

"""
    MPI_File_write_ordered_begin(fh, buf, count, datatype)

- `MPI_File_write_ordered_begin` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_write_ordered_begin.html`
"""
function MPI_File_write_ordered_begin(fh, buf, count, datatype)
    @mpichk ccall((:MPI_File_write_ordered_begin, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype), fh, buf, count, datatype)
end

"""
    MPI_File_write_ordered_end(fh, buf, status)

- `MPI_File_write_ordered_end` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_write_ordered_end.html`
"""
function MPI_File_write_ordered_end(fh, buf, status)
    @mpichk ccall((:MPI_File_write_ordered_end, libmpi), Cint, (MPI_File, MPIPtr, Ptr{MPI_Status}), fh, buf, status)
end

"""
    MPI_File_get_type_extent(fh, datatype, extent)

- `MPI_File_get_type_extent` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_get_type_extent.html`
"""
function MPI_File_get_type_extent(fh, datatype, extent)
    @mpichk ccall((:MPI_File_get_type_extent, libmpi), Cint, (MPI_File, MPI_Datatype, Ptr{MPI_Aint}), fh, datatype, extent)
end

"""
    MPI_Register_datarep(datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)

- `MPI_Register_datarep` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Register_datarep.html`
"""
function MPI_Register_datarep(datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)
    @mpichk ccall((:MPI_Register_datarep, libmpi), Cint, (Ptr{Cchar}, MPIPtr, MPIPtr, MPIPtr, MPIPtr), datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)
end

"""
    MPI_File_set_atomicity(fh, flag)

- `MPI_File_set_atomicity` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_set_atomicity.html`
"""
function MPI_File_set_atomicity(fh, flag)
    @mpichk ccall((:MPI_File_set_atomicity, libmpi), Cint, (MPI_File, Cint), fh, flag)
end

"""
    MPI_File_get_atomicity(fh, flag)

- `MPI_File_get_atomicity` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_get_atomicity.html`
"""
function MPI_File_get_atomicity(fh, flag)
    @mpichk ccall((:MPI_File_get_atomicity, libmpi), Cint, (MPI_File, Ptr{Cint}), fh, flag)
end

"""
    MPI_File_sync(fh)

- `MPI_File_sync` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_sync.html`
"""
function MPI_File_sync(fh)
    @mpichk ccall((:MPI_File_sync, libmpi), Cint, (MPI_File,), fh)
end

"""
    MPI_File_iread_at_all(fh, offset, buf, count, datatype, request)

- `MPI_File_iread_at_all` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_iread_at_all.html`
"""
function MPI_File_iread_at_all(fh, offset, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iread_at_all, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

"""
    MPI_File_iwrite_at_all(fh, offset, buf, count, datatype, request)

- `MPI_File_iwrite_at_all` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_iwrite_at_all.html`
"""
function MPI_File_iwrite_at_all(fh, offset, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iwrite_at_all, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

"""
    MPI_File_iread_all(fh, buf, count, datatype, request)

- `MPI_File_iread_all` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_iread_all.html`
"""
function MPI_File_iread_all(fh, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iread_all, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    MPI_File_iwrite_all(fh, buf, count, datatype, request)

- `MPI_File_iwrite_all` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_iwrite_all.html`
"""
function MPI_File_iwrite_all(fh, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iwrite_all, libmpi), Cint, (MPI_File, MPIPtr, Cint, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    MPI_File_read_c(fh, buf, count, datatype, status)

- `MPI_File_read_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_read_c.html`
"""
function MPI_File_read_c(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_read_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_read_all_c(fh, buf, count, datatype, status)

- `MPI_File_read_all_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_read_all_c.html`
"""
function MPI_File_read_all_c(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_read_all_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_read_all_begin_c(fh, buf, count, datatype)

- `MPI_File_read_all_begin_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_read_all_begin_c.html`
"""
function MPI_File_read_all_begin_c(fh, buf, count, datatype)
    @mpichk ccall((:MPI_File_read_all_begin_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype), fh, buf, count, datatype)
end

"""
    MPI_File_read_at_c(fh, offset, buf, count, datatype, status)

- `MPI_File_read_at_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_read_at_c.html`
"""
function MPI_File_read_at_c(fh, offset, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_read_at_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

"""
    MPI_File_read_at_all_c(fh, offset, buf, count, datatype, status)

- `MPI_File_read_at_all_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_read_at_all_c.html`
"""
function MPI_File_read_at_all_c(fh, offset, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_read_at_all_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

"""
    MPI_File_read_at_all_begin_c(fh, offset, buf, count, datatype)

- `MPI_File_read_at_all_begin_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_read_at_all_begin_c.html`
"""
function MPI_File_read_at_all_begin_c(fh, offset, buf, count, datatype)
    @mpichk ccall((:MPI_File_read_at_all_begin_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype), fh, offset, buf, count, datatype)
end

"""
    MPI_File_read_ordered_c(fh, buf, count, datatype, status)

- `MPI_File_read_ordered_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_read_ordered_c.html`
"""
function MPI_File_read_ordered_c(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_read_ordered_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_read_ordered_begin_c(fh, buf, count, datatype)

- `MPI_File_read_ordered_begin_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_read_ordered_begin_c.html`
"""
function MPI_File_read_ordered_begin_c(fh, buf, count, datatype)
    @mpichk ccall((:MPI_File_read_ordered_begin_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype), fh, buf, count, datatype)
end

"""
    MPI_File_read_shared_c(fh, buf, count, datatype, status)

- `MPI_File_read_shared_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_read_shared_c.html`
"""
function MPI_File_read_shared_c(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_read_shared_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_write_c(fh, buf, count, datatype, status)

- `MPI_File_write_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_write_c.html`
"""
function MPI_File_write_c(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_write_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_write_all_c(fh, buf, count, datatype, status)

- `MPI_File_write_all_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_write_all_c.html`
"""
function MPI_File_write_all_c(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_write_all_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_write_all_begin_c(fh, buf, count, datatype)

- `MPI_File_write_all_begin_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_write_all_begin_c.html`
"""
function MPI_File_write_all_begin_c(fh, buf, count, datatype)
    @mpichk ccall((:MPI_File_write_all_begin_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype), fh, buf, count, datatype)
end

"""
    MPI_File_write_at_c(fh, offset, buf, count, datatype, status)

- `MPI_File_write_at_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_write_at_c.html`
"""
function MPI_File_write_at_c(fh, offset, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_write_at_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

"""
    MPI_File_write_at_all_c(fh, offset, buf, count, datatype, status)

- `MPI_File_write_at_all_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_write_at_all_c.html`
"""
function MPI_File_write_at_all_c(fh, offset, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_write_at_all_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, offset, buf, count, datatype, status)
end

"""
    MPI_File_write_at_all_begin_c(fh, offset, buf, count, datatype)

- `MPI_File_write_at_all_begin_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_write_at_all_begin_c.html`
"""
function MPI_File_write_at_all_begin_c(fh, offset, buf, count, datatype)
    @mpichk ccall((:MPI_File_write_at_all_begin_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype), fh, offset, buf, count, datatype)
end

"""
    MPI_File_write_ordered_c(fh, buf, count, datatype, status)

- `MPI_File_write_ordered_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_write_ordered_c.html`
"""
function MPI_File_write_ordered_c(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_write_ordered_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_write_ordered_begin_c(fh, buf, count, datatype)

- `MPI_File_write_ordered_begin_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_write_ordered_begin_c.html`
"""
function MPI_File_write_ordered_begin_c(fh, buf, count, datatype)
    @mpichk ccall((:MPI_File_write_ordered_begin_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype), fh, buf, count, datatype)
end

"""
    MPI_File_write_shared_c(fh, buf, count, datatype, status)

- `MPI_File_write_shared_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_write_shared_c.html`
"""
function MPI_File_write_shared_c(fh, buf, count, datatype, status)
    @mpichk ccall((:MPI_File_write_shared_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Status}), fh, buf, count, datatype, status)
end

"""
    MPI_File_iread_c(fh, buf, count, datatype, request)

- `MPI_File_iread_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_iread_c.html`
"""
function MPI_File_iread_c(fh, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iread_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    MPI_File_iread_all_c(fh, buf, count, datatype, request)

- `MPI_File_iread_all_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_iread_all_c.html`
"""
function MPI_File_iread_all_c(fh, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iread_all_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    MPI_File_iread_at_c(fh, offset, buf, count, datatype, request)

- `MPI_File_iread_at_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_iread_at_c.html`
"""
function MPI_File_iread_at_c(fh, offset, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iread_at_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

"""
    MPI_File_iread_at_all_c(fh, offset, buf, count, datatype, request)

- `MPI_File_iread_at_all_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_iread_at_all_c.html`
"""
function MPI_File_iread_at_all_c(fh, offset, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iread_at_all_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

"""
    MPI_File_iread_shared_c(fh, buf, count, datatype, request)

- `MPI_File_iread_shared_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_iread_shared_c.html`
"""
function MPI_File_iread_shared_c(fh, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iread_shared_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    MPI_File_iwrite_c(fh, buf, count, datatype, request)

- `MPI_File_iwrite_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_iwrite_c.html`
"""
function MPI_File_iwrite_c(fh, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iwrite_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    MPI_File_iwrite_all_c(fh, buf, count, datatype, request)

- `MPI_File_iwrite_all_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_iwrite_all_c.html`
"""
function MPI_File_iwrite_all_c(fh, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iwrite_all_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    MPI_File_iwrite_at_c(fh, offset, buf, count, datatype, request)

- `MPI_File_iwrite_at_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_iwrite_at_c.html`
"""
function MPI_File_iwrite_at_c(fh, offset, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iwrite_at_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

"""
    MPI_File_iwrite_at_all_c(fh, offset, buf, count, datatype, request)

- `MPI_File_iwrite_at_all_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_iwrite_at_all_c.html`
"""
function MPI_File_iwrite_at_all_c(fh, offset, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iwrite_at_all_c, libmpi), Cint, (MPI_File, MPI_Offset, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, offset, buf, count, datatype, request)
end

"""
    MPI_File_iwrite_shared_c(fh, buf, count, datatype, request)

- `MPI_File_iwrite_shared_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_iwrite_shared_c.html`
"""
function MPI_File_iwrite_shared_c(fh, buf, count, datatype, request)
    @mpichk ccall((:MPI_File_iwrite_shared_c, libmpi), Cint, (MPI_File, MPIPtr, MPI_Count, MPI_Datatype, Ptr{MPI_Request}), fh, buf, count, datatype, request)
end

"""
    MPI_File_get_type_extent_c(fh, datatype, extent)

- `MPI_File_get_type_extent_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_get_type_extent_c.html`
"""
function MPI_File_get_type_extent_c(fh, datatype, extent)
    @mpichk ccall((:MPI_File_get_type_extent_c, libmpi), Cint, (MPI_File, MPI_Datatype, Ptr{MPI_Count}), fh, datatype, extent)
end

"""
    MPI_Register_datarep_c(datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)

- `MPI_Register_datarep_c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_Register_datarep_c.html`
"""
function MPI_Register_datarep_c(datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)
    @mpichk ccall((:MPI_Register_datarep_c, libmpi), Cint, (Ptr{Cchar}, MPIPtr, MPIPtr, MPIPtr, MPIPtr), datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)
end

"""
    MPI_File_f2c(file)

- `MPI_File_f2c` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_f2c.html`
"""
function MPI_File_f2c(file)
    @mpichk ccall((:MPI_File_f2c, libmpi), MPI_File, (MPI_Fint,), file)
end

"""
    MPI_File_c2f(file)

- `MPI_File_c2f` man page `https://www.mpich.org/static/docs/latest/www3/MPI_File_c2f.html`
"""
function MPI_File_c2f(file)
    @mpichk ccall((:MPI_File_c2f, libmpi), MPI_Fint, (MPI_File,), file)
end
