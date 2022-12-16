# WARNING: this signature file for MPICH_jll has been auto-generated, please edit ../../gen/src/MPIgenerator.jl instead!

"""
    MPI_Wait(request, status)

$(_doc_external(:MPI_Wait))
"""
function MPI_Wait(request, status)
    @mpichk @ccall libmpi.MPI_Wait(request::Ptr{MPI_Request}, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_Test(request, flag, status)

$(_doc_external(:MPI_Test))
"""
function MPI_Test(request, flag, status)
    @mpichk @ccall libmpi.MPI_Test(request::Ptr{MPI_Request}, flag::Ptr{Cint}, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_Status_c2f(c_status, f_status)

$(_doc_external(:MPI_Status_c2f))
"""
function MPI_Status_c2f(c_status, f_status)
    @mpichk @ccall libmpi.MPI_Status_c2f(c_status::Ptr{MPI_Status}, f_status::Ptr{MPI_Fint})::Cint
end

"""
    MPI_Status_f2c(f_status, c_status)

$(_doc_external(:MPI_Status_f2c))
"""
function MPI_Status_f2c(f_status, c_status)
    @mpichk @ccall libmpi.MPI_Status_f2c(f_status::Ptr{MPI_Fint}, c_status::Ptr{MPI_Status})::Cint
end

"""
    MPI_Type_create_f90_integer(r, newtype)

$(_doc_external(:MPI_Type_create_f90_integer))
"""
function MPI_Type_create_f90_integer(r, newtype)
    @mpichk @ccall libmpi.MPI_Type_create_f90_integer(r::Cint, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_create_f90_real(p, r, newtype)

$(_doc_external(:MPI_Type_create_f90_real))
"""
function MPI_Type_create_f90_real(p, r, newtype)
    @mpichk @ccall libmpi.MPI_Type_create_f90_real(p::Cint, r::Cint, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_create_f90_complex(p, r, newtype)

$(_doc_external(:MPI_Type_create_f90_complex))
"""
function MPI_Type_create_f90_complex(p, r, newtype)
    @mpichk @ccall libmpi.MPI_Type_create_f90_complex(p::Cint, r::Cint, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Attr_delete(comm, keyval)

$(_doc_external(:MPI_Attr_delete))
"""
function MPI_Attr_delete(comm, keyval)
    @mpichk @ccall libmpi.MPI_Attr_delete(comm::MPI_Comm, keyval::Cint)::Cint
end

"""
    MPI_Attr_get(comm, keyval, attribute_val, flag)

$(_doc_external(:MPI_Attr_get))
"""
function MPI_Attr_get(comm, keyval, attribute_val, flag)
    @mpichk @ccall libmpi.MPI_Attr_get(comm::MPI_Comm, keyval::Cint, attribute_val::MPIPtr, flag::Ptr{Cint})::Cint
end

"""
    MPI_Attr_put(comm, keyval, attribute_val)

$(_doc_external(:MPI_Attr_put))
"""
function MPI_Attr_put(comm, keyval, attribute_val)
    @mpichk @ccall libmpi.MPI_Attr_put(comm::MPI_Comm, keyval::Cint, attribute_val::MPIPtr)::Cint
end

"""
    MPI_Comm_create_keyval(comm_copy_attr_fn, comm_delete_attr_fn, comm_keyval, extra_state)

$(_doc_external(:MPI_Comm_create_keyval))
"""
function MPI_Comm_create_keyval(comm_copy_attr_fn, comm_delete_attr_fn, comm_keyval, extra_state)
    @mpichk @ccall libmpi.MPI_Comm_create_keyval(comm_copy_attr_fn::MPIPtr, comm_delete_attr_fn::MPIPtr, comm_keyval::Ptr{Cint}, extra_state::MPIPtr)::Cint
end

"""
    MPI_Comm_delete_attr(comm, comm_keyval)

$(_doc_external(:MPI_Comm_delete_attr))
"""
function MPI_Comm_delete_attr(comm, comm_keyval)
    @mpichk @ccall libmpi.MPI_Comm_delete_attr(comm::MPI_Comm, comm_keyval::Cint)::Cint
end

"""
    MPI_Comm_free_keyval(comm_keyval)

$(_doc_external(:MPI_Comm_free_keyval))
"""
function MPI_Comm_free_keyval(comm_keyval)
    @mpichk @ccall libmpi.MPI_Comm_free_keyval(comm_keyval::Ptr{Cint})::Cint
end

"""
    MPI_Comm_get_attr(comm, comm_keyval, attribute_val, flag)

$(_doc_external(:MPI_Comm_get_attr))
"""
function MPI_Comm_get_attr(comm, comm_keyval, attribute_val, flag)
    @mpichk @ccall libmpi.MPI_Comm_get_attr(comm::MPI_Comm, comm_keyval::Cint, attribute_val::MPIPtr, flag::Ptr{Cint})::Cint
end

"""
    MPI_Comm_set_attr(comm, comm_keyval, attribute_val)

$(_doc_external(:MPI_Comm_set_attr))
"""
function MPI_Comm_set_attr(comm, comm_keyval, attribute_val)
    @mpichk @ccall libmpi.MPI_Comm_set_attr(comm::MPI_Comm, comm_keyval::Cint, attribute_val::MPIPtr)::Cint
end

"""
    MPI_Keyval_create(copy_fn, delete_fn, keyval, extra_state)

$(_doc_external(:MPI_Keyval_create))
"""
function MPI_Keyval_create(copy_fn, delete_fn, keyval, extra_state)
    @mpichk @ccall libmpi.MPI_Keyval_create(copy_fn::MPIPtr, delete_fn::MPIPtr, keyval::Ptr{Cint}, extra_state::MPIPtr)::Cint
end

"""
    MPI_Keyval_free(keyval)

$(_doc_external(:MPI_Keyval_free))
"""
function MPI_Keyval_free(keyval)
    @mpichk @ccall libmpi.MPI_Keyval_free(keyval::Ptr{Cint})::Cint
end

"""
    MPI_Type_create_keyval(type_copy_attr_fn, type_delete_attr_fn, type_keyval, extra_state)

$(_doc_external(:MPI_Type_create_keyval))
"""
function MPI_Type_create_keyval(type_copy_attr_fn, type_delete_attr_fn, type_keyval, extra_state)
    @mpichk @ccall libmpi.MPI_Type_create_keyval(type_copy_attr_fn::MPIPtr, type_delete_attr_fn::MPIPtr, type_keyval::Ptr{Cint}, extra_state::MPIPtr)::Cint
end

"""
    MPI_Type_delete_attr(datatype, type_keyval)

$(_doc_external(:MPI_Type_delete_attr))
"""
function MPI_Type_delete_attr(datatype, type_keyval)
    @mpichk @ccall libmpi.MPI_Type_delete_attr(datatype::MPI_Datatype, type_keyval::Cint)::Cint
end

"""
    MPI_Type_free_keyval(type_keyval)

$(_doc_external(:MPI_Type_free_keyval))
"""
function MPI_Type_free_keyval(type_keyval)
    @mpichk @ccall libmpi.MPI_Type_free_keyval(type_keyval::Ptr{Cint})::Cint
end

"""
    MPI_Type_get_attr(datatype, type_keyval, attribute_val, flag)

$(_doc_external(:MPI_Type_get_attr))
"""
function MPI_Type_get_attr(datatype, type_keyval, attribute_val, flag)
    @mpichk @ccall libmpi.MPI_Type_get_attr(datatype::MPI_Datatype, type_keyval::Cint, attribute_val::MPIPtr, flag::Ptr{Cint})::Cint
end

"""
    MPI_Type_set_attr(datatype, type_keyval, attribute_val)

$(_doc_external(:MPI_Type_set_attr))
"""
function MPI_Type_set_attr(datatype, type_keyval, attribute_val)
    @mpichk @ccall libmpi.MPI_Type_set_attr(datatype::MPI_Datatype, type_keyval::Cint, attribute_val::MPIPtr)::Cint
end

"""
    MPI_Win_create_keyval(win_copy_attr_fn, win_delete_attr_fn, win_keyval, extra_state)

$(_doc_external(:MPI_Win_create_keyval))
"""
function MPI_Win_create_keyval(win_copy_attr_fn, win_delete_attr_fn, win_keyval, extra_state)
    @mpichk @ccall libmpi.MPI_Win_create_keyval(win_copy_attr_fn::MPIPtr, win_delete_attr_fn::MPIPtr, win_keyval::Ptr{Cint}, extra_state::MPIPtr)::Cint
end

"""
    MPI_Win_delete_attr(win, win_keyval)

$(_doc_external(:MPI_Win_delete_attr))
"""
function MPI_Win_delete_attr(win, win_keyval)
    @mpichk @ccall libmpi.MPI_Win_delete_attr(win::MPI_Win, win_keyval::Cint)::Cint
end

"""
    MPI_Win_free_keyval(win_keyval)

$(_doc_external(:MPI_Win_free_keyval))
"""
function MPI_Win_free_keyval(win_keyval)
    @mpichk @ccall libmpi.MPI_Win_free_keyval(win_keyval::Ptr{Cint})::Cint
end

"""
    MPI_Win_get_attr(win, win_keyval, attribute_val, flag)

$(_doc_external(:MPI_Win_get_attr))
"""
function MPI_Win_get_attr(win, win_keyval, attribute_val, flag)
    @mpichk @ccall libmpi.MPI_Win_get_attr(win::MPI_Win, win_keyval::Cint, attribute_val::MPIPtr, flag::Ptr{Cint})::Cint
end

"""
    MPI_Win_set_attr(win, win_keyval, attribute_val)

$(_doc_external(:MPI_Win_set_attr))
"""
function MPI_Win_set_attr(win, win_keyval, attribute_val)
    @mpichk @ccall libmpi.MPI_Win_set_attr(win::MPI_Win, win_keyval::Cint, attribute_val::MPIPtr)::Cint
end

"""
    MPI_Allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:MPI_Allgather))
"""
function MPI_Allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk @ccall libmpi.MPI_Allgather(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::Cint, recvtype::MPI_Datatype, comm::MPI_Comm)::Cint
end

"""
    MPI_Allgather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:MPI_Allgather_init))
"""
function MPI_Allgather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk @ccall libmpi.MPI_Allgather_init(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::Cint, recvtype::MPI_Datatype, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)

$(_doc_external(:MPI_Allgatherv))
"""
function MPI_Allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    @mpichk @ccall libmpi.MPI_Allgatherv(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{Cint}, displs::Ptr{Cint}, recvtype::MPI_Datatype, comm::MPI_Comm)::Cint
end

"""
    MPI_Allgatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)

$(_doc_external(:MPI_Allgatherv_init))
"""
function MPI_Allgatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    @mpichk @ccall libmpi.MPI_Allgatherv_init(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{Cint}, displs::Ptr{Cint}, recvtype::MPI_Datatype, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Allreduce(sendbuf, recvbuf, count, datatype, op, comm)

$(_doc_external(:MPI_Allreduce))
"""
function MPI_Allreduce(sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk @ccall libmpi.MPI_Allreduce(sendbuf::MPIPtr, recvbuf::MPIPtr, count::Cint, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm)::Cint
end

"""
    MPI_Allreduce_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)

$(_doc_external(:MPI_Allreduce_init))
"""
function MPI_Allreduce_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk @ccall libmpi.MPI_Allreduce_init(sendbuf::MPIPtr, recvbuf::MPIPtr, count::Cint, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:MPI_Alltoall))
"""
function MPI_Alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk @ccall libmpi.MPI_Alltoall(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::Cint, recvtype::MPI_Datatype, comm::MPI_Comm)::Cint
end

"""
    MPI_Alltoall_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:MPI_Alltoall_init))
"""
function MPI_Alltoall_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk @ccall libmpi.MPI_Alltoall_init(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::Cint, recvtype::MPI_Datatype, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)

$(_doc_external(:MPI_Alltoallv))
"""
function MPI_Alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    @mpichk @ccall libmpi.MPI_Alltoallv(sendbuf::MPIPtr, sendcounts::Ptr{Cint}, sdispls::Ptr{Cint}, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{Cint}, rdispls::Ptr{Cint}, recvtype::MPI_Datatype, comm::MPI_Comm)::Cint
end

"""
    MPI_Alltoallv_init(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)

$(_doc_external(:MPI_Alltoallv_init))
"""
function MPI_Alltoallv_init(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    @mpichk @ccall libmpi.MPI_Alltoallv_init(sendbuf::MPIPtr, sendcounts::Ptr{Cint}, sdispls::Ptr{Cint}, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{Cint}, rdispls::Ptr{Cint}, recvtype::MPI_Datatype, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)

$(_doc_external(:MPI_Alltoallw))
"""
function MPI_Alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    @mpichk @ccall libmpi.MPI_Alltoallw(sendbuf::MPIPtr, sendcounts::Ptr{Cint}, sdispls::Ptr{Cint}, sendtypes::Ptr{MPI_Datatype}, recvbuf::MPIPtr, recvcounts::Ptr{Cint}, rdispls::Ptr{Cint}, recvtypes::Ptr{MPI_Datatype}, comm::MPI_Comm)::Cint
end

"""
    MPI_Alltoallw_init(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)

$(_doc_external(:MPI_Alltoallw_init))
"""
function MPI_Alltoallw_init(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    @mpichk @ccall libmpi.MPI_Alltoallw_init(sendbuf::MPIPtr, sendcounts::Ptr{Cint}, sdispls::Ptr{Cint}, sendtypes::Ptr{MPI_Datatype}, recvbuf::MPIPtr, recvcounts::Ptr{Cint}, rdispls::Ptr{Cint}, recvtypes::Ptr{MPI_Datatype}, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Barrier(comm)

$(_doc_external(:MPI_Barrier))
"""
function MPI_Barrier(comm)
    @mpichk @ccall libmpi.MPI_Barrier(comm::MPI_Comm)::Cint
end

"""
    MPI_Barrier_init(comm, info, request)

$(_doc_external(:MPI_Barrier_init))
"""
function MPI_Barrier_init(comm, info, request)
    @mpichk @ccall libmpi.MPI_Barrier_init(comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Bcast(buffer, count, datatype, root, comm)

$(_doc_external(:MPI_Bcast))
"""
function MPI_Bcast(buffer, count, datatype, root, comm)
    @mpichk @ccall libmpi.MPI_Bcast(buffer::MPIPtr, count::Cint, datatype::MPI_Datatype, root::Cint, comm::MPI_Comm)::Cint
end

"""
    MPI_Bcast_init(buffer, count, datatype, root, comm, info, request)

$(_doc_external(:MPI_Bcast_init))
"""
function MPI_Bcast_init(buffer, count, datatype, root, comm, info, request)
    @mpichk @ccall libmpi.MPI_Bcast_init(buffer::MPIPtr, count::Cint, datatype::MPI_Datatype, root::Cint, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Exscan(sendbuf, recvbuf, count, datatype, op, comm)

$(_doc_external(:MPI_Exscan))
"""
function MPI_Exscan(sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk @ccall libmpi.MPI_Exscan(sendbuf::MPIPtr, recvbuf::MPIPtr, count::Cint, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm)::Cint
end

"""
    MPI_Exscan_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)

$(_doc_external(:MPI_Exscan_init))
"""
function MPI_Exscan_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk @ccall libmpi.MPI_Exscan_init(sendbuf::MPIPtr, recvbuf::MPIPtr, count::Cint, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Gather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)

$(_doc_external(:MPI_Gather))
"""
function MPI_Gather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk @ccall libmpi.MPI_Gather(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::Cint, recvtype::MPI_Datatype, root::Cint, comm::MPI_Comm)::Cint
end

"""
    MPI_Gather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

$(_doc_external(:MPI_Gather_init))
"""
function MPI_Gather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk @ccall libmpi.MPI_Gather_init(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::Cint, recvtype::MPI_Datatype, root::Cint, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Gatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)

$(_doc_external(:MPI_Gatherv))
"""
function MPI_Gatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
    @mpichk @ccall libmpi.MPI_Gatherv(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{Cint}, displs::Ptr{Cint}, recvtype::MPI_Datatype, root::Cint, comm::MPI_Comm)::Cint
end

"""
    MPI_Gatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)

$(_doc_external(:MPI_Gatherv_init))
"""
function MPI_Gatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
    @mpichk @ccall libmpi.MPI_Gatherv_init(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{Cint}, displs::Ptr{Cint}, recvtype::MPI_Datatype, root::Cint, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Iallgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:MPI_Iallgather))
"""
function MPI_Iallgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk @ccall libmpi.MPI_Iallgather(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::Cint, recvtype::MPI_Datatype, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Iallgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)

$(_doc_external(:MPI_Iallgatherv))
"""
function MPI_Iallgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    @mpichk @ccall libmpi.MPI_Iallgatherv(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{Cint}, displs::Ptr{Cint}, recvtype::MPI_Datatype, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Iallreduce(sendbuf, recvbuf, count, datatype, op, comm, request)

$(_doc_external(:MPI_Iallreduce))
"""
function MPI_Iallreduce(sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk @ccall libmpi.MPI_Iallreduce(sendbuf::MPIPtr, recvbuf::MPIPtr, count::Cint, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Ialltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:MPI_Ialltoall))
"""
function MPI_Ialltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk @ccall libmpi.MPI_Ialltoall(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::Cint, recvtype::MPI_Datatype, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Ialltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)

$(_doc_external(:MPI_Ialltoallv))
"""
function MPI_Ialltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    @mpichk @ccall libmpi.MPI_Ialltoallv(sendbuf::MPIPtr, sendcounts::Ptr{Cint}, sdispls::Ptr{Cint}, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{Cint}, rdispls::Ptr{Cint}, recvtype::MPI_Datatype, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Ialltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)

$(_doc_external(:MPI_Ialltoallw))
"""
function MPI_Ialltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    @mpichk @ccall libmpi.MPI_Ialltoallw(sendbuf::MPIPtr, sendcounts::Ptr{Cint}, sdispls::Ptr{Cint}, sendtypes::Ptr{MPI_Datatype}, recvbuf::MPIPtr, recvcounts::Ptr{Cint}, rdispls::Ptr{Cint}, recvtypes::Ptr{MPI_Datatype}, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Ibarrier(comm, request)

$(_doc_external(:MPI_Ibarrier))
"""
function MPI_Ibarrier(comm, request)
    @mpichk @ccall libmpi.MPI_Ibarrier(comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Ibcast(buffer, count, datatype, root, comm, request)

$(_doc_external(:MPI_Ibcast))
"""
function MPI_Ibcast(buffer, count, datatype, root, comm, request)
    @mpichk @ccall libmpi.MPI_Ibcast(buffer::MPIPtr, count::Cint, datatype::MPI_Datatype, root::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Iexscan(sendbuf, recvbuf, count, datatype, op, comm, request)

$(_doc_external(:MPI_Iexscan))
"""
function MPI_Iexscan(sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk @ccall libmpi.MPI_Iexscan(sendbuf::MPIPtr, recvbuf::MPIPtr, count::Cint, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Igather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

$(_doc_external(:MPI_Igather))
"""
function MPI_Igather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk @ccall libmpi.MPI_Igather(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::Cint, recvtype::MPI_Datatype, root::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Igatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)

$(_doc_external(:MPI_Igatherv))
"""
function MPI_Igatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
    @mpichk @ccall libmpi.MPI_Igatherv(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{Cint}, displs::Ptr{Cint}, recvtype::MPI_Datatype, root::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Ineighbor_allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:MPI_Ineighbor_allgather))
"""
function MPI_Ineighbor_allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk @ccall libmpi.MPI_Ineighbor_allgather(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::Cint, recvtype::MPI_Datatype, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Ineighbor_allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)

$(_doc_external(:MPI_Ineighbor_allgatherv))
"""
function MPI_Ineighbor_allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    @mpichk @ccall libmpi.MPI_Ineighbor_allgatherv(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{Cint}, displs::Ptr{Cint}, recvtype::MPI_Datatype, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Ineighbor_alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:MPI_Ineighbor_alltoall))
"""
function MPI_Ineighbor_alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk @ccall libmpi.MPI_Ineighbor_alltoall(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::Cint, recvtype::MPI_Datatype, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Ineighbor_alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)

$(_doc_external(:MPI_Ineighbor_alltoallv))
"""
function MPI_Ineighbor_alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    @mpichk @ccall libmpi.MPI_Ineighbor_alltoallv(sendbuf::MPIPtr, sendcounts::Ptr{Cint}, sdispls::Ptr{Cint}, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{Cint}, rdispls::Ptr{Cint}, recvtype::MPI_Datatype, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Ineighbor_alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)

$(_doc_external(:MPI_Ineighbor_alltoallw))
"""
function MPI_Ineighbor_alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    @mpichk @ccall libmpi.MPI_Ineighbor_alltoallw(sendbuf::MPIPtr, sendcounts::Ptr{Cint}, sdispls::Ptr{MPI_Aint}, sendtypes::Ptr{MPI_Datatype}, recvbuf::MPIPtr, recvcounts::Ptr{Cint}, rdispls::Ptr{MPI_Aint}, recvtypes::Ptr{MPI_Datatype}, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Ireduce(sendbuf, recvbuf, count, datatype, op, root, comm, request)

$(_doc_external(:MPI_Ireduce))
"""
function MPI_Ireduce(sendbuf, recvbuf, count, datatype, op, root, comm, request)
    @mpichk @ccall libmpi.MPI_Ireduce(sendbuf::MPIPtr, recvbuf::MPIPtr, count::Cint, datatype::MPI_Datatype, op::MPI_Op, root::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Ireduce_scatter(sendbuf, recvbuf, recvcounts, datatype, op, comm, request)

$(_doc_external(:MPI_Ireduce_scatter))
"""
function MPI_Ireduce_scatter(sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
    @mpichk @ccall libmpi.MPI_Ireduce_scatter(sendbuf::MPIPtr, recvbuf::MPIPtr, recvcounts::Ptr{Cint}, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Ireduce_scatter_block(sendbuf, recvbuf, recvcount, datatype, op, comm, request)

$(_doc_external(:MPI_Ireduce_scatter_block))
"""
function MPI_Ireduce_scatter_block(sendbuf, recvbuf, recvcount, datatype, op, comm, request)
    @mpichk @ccall libmpi.MPI_Ireduce_scatter_block(sendbuf::MPIPtr, recvbuf::MPIPtr, recvcount::Cint, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Iscan(sendbuf, recvbuf, count, datatype, op, comm, request)

$(_doc_external(:MPI_Iscan))
"""
function MPI_Iscan(sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk @ccall libmpi.MPI_Iscan(sendbuf::MPIPtr, recvbuf::MPIPtr, count::Cint, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Iscatter(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

$(_doc_external(:MPI_Iscatter))
"""
function MPI_Iscatter(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk @ccall libmpi.MPI_Iscatter(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::Cint, recvtype::MPI_Datatype, root::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Iscatterv(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

$(_doc_external(:MPI_Iscatterv))
"""
function MPI_Iscatterv(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk @ccall libmpi.MPI_Iscatterv(sendbuf::MPIPtr, sendcounts::Ptr{Cint}, displs::Ptr{Cint}, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::Cint, recvtype::MPI_Datatype, root::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Neighbor_allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:MPI_Neighbor_allgather))
"""
function MPI_Neighbor_allgather(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk @ccall libmpi.MPI_Neighbor_allgather(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::Cint, recvtype::MPI_Datatype, comm::MPI_Comm)::Cint
end

"""
    MPI_Neighbor_allgather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:MPI_Neighbor_allgather_init))
"""
function MPI_Neighbor_allgather_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk @ccall libmpi.MPI_Neighbor_allgather_init(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::Cint, recvtype::MPI_Datatype, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Neighbor_allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)

$(_doc_external(:MPI_Neighbor_allgatherv))
"""
function MPI_Neighbor_allgatherv(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    @mpichk @ccall libmpi.MPI_Neighbor_allgatherv(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{Cint}, displs::Ptr{Cint}, recvtype::MPI_Datatype, comm::MPI_Comm)::Cint
end

"""
    MPI_Neighbor_allgatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)

$(_doc_external(:MPI_Neighbor_allgatherv_init))
"""
function MPI_Neighbor_allgatherv_init(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    @mpichk @ccall libmpi.MPI_Neighbor_allgatherv_init(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{Cint}, displs::Ptr{Cint}, recvtype::MPI_Datatype, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Neighbor_alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:MPI_Neighbor_alltoall))
"""
function MPI_Neighbor_alltoall(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk @ccall libmpi.MPI_Neighbor_alltoall(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::Cint, recvtype::MPI_Datatype, comm::MPI_Comm)::Cint
end

"""
    MPI_Neighbor_alltoall_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:MPI_Neighbor_alltoall_init))
"""
function MPI_Neighbor_alltoall_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk @ccall libmpi.MPI_Neighbor_alltoall_init(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::Cint, recvtype::MPI_Datatype, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Neighbor_alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)

$(_doc_external(:MPI_Neighbor_alltoallv))
"""
function MPI_Neighbor_alltoallv(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    @mpichk @ccall libmpi.MPI_Neighbor_alltoallv(sendbuf::MPIPtr, sendcounts::Ptr{Cint}, sdispls::Ptr{Cint}, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{Cint}, rdispls::Ptr{Cint}, recvtype::MPI_Datatype, comm::MPI_Comm)::Cint
end

"""
    MPI_Neighbor_alltoallv_init(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)

$(_doc_external(:MPI_Neighbor_alltoallv_init))
"""
function MPI_Neighbor_alltoallv_init(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    @mpichk @ccall libmpi.MPI_Neighbor_alltoallv_init(sendbuf::MPIPtr, sendcounts::Ptr{Cint}, sdispls::Ptr{Cint}, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{Cint}, rdispls::Ptr{Cint}, recvtype::MPI_Datatype, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Neighbor_alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)

$(_doc_external(:MPI_Neighbor_alltoallw))
"""
function MPI_Neighbor_alltoallw(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    @mpichk @ccall libmpi.MPI_Neighbor_alltoallw(sendbuf::MPIPtr, sendcounts::Ptr{Cint}, sdispls::Ptr{MPI_Aint}, sendtypes::Ptr{MPI_Datatype}, recvbuf::MPIPtr, recvcounts::Ptr{Cint}, rdispls::Ptr{MPI_Aint}, recvtypes::Ptr{MPI_Datatype}, comm::MPI_Comm)::Cint
end

"""
    MPI_Neighbor_alltoallw_init(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)

$(_doc_external(:MPI_Neighbor_alltoallw_init))
"""
function MPI_Neighbor_alltoallw_init(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    @mpichk @ccall libmpi.MPI_Neighbor_alltoallw_init(sendbuf::MPIPtr, sendcounts::Ptr{Cint}, sdispls::Ptr{MPI_Aint}, sendtypes::Ptr{MPI_Datatype}, recvbuf::MPIPtr, recvcounts::Ptr{Cint}, rdispls::Ptr{MPI_Aint}, recvtypes::Ptr{MPI_Datatype}, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Reduce(sendbuf, recvbuf, count, datatype, op, root, comm)

$(_doc_external(:MPI_Reduce))
"""
function MPI_Reduce(sendbuf, recvbuf, count, datatype, op, root, comm)
    @mpichk @ccall libmpi.MPI_Reduce(sendbuf::MPIPtr, recvbuf::MPIPtr, count::Cint, datatype::MPI_Datatype, op::MPI_Op, root::Cint, comm::MPI_Comm)::Cint
end

"""
    MPI_Reduce_init(sendbuf, recvbuf, count, datatype, op, root, comm, info, request)

$(_doc_external(:MPI_Reduce_init))
"""
function MPI_Reduce_init(sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
    @mpichk @ccall libmpi.MPI_Reduce_init(sendbuf::MPIPtr, recvbuf::MPIPtr, count::Cint, datatype::MPI_Datatype, op::MPI_Op, root::Cint, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Reduce_local(inbuf, inoutbuf, count, datatype, op)

$(_doc_external(:MPI_Reduce_local))
"""
function MPI_Reduce_local(inbuf, inoutbuf, count, datatype, op)
    @mpichk @ccall libmpi.MPI_Reduce_local(inbuf::MPIPtr, inoutbuf::MPIPtr, count::Cint, datatype::MPI_Datatype, op::MPI_Op)::Cint
end

"""
    MPI_Reduce_scatter(sendbuf, recvbuf, recvcounts, datatype, op, comm)

$(_doc_external(:MPI_Reduce_scatter))
"""
function MPI_Reduce_scatter(sendbuf, recvbuf, recvcounts, datatype, op, comm)
    @mpichk @ccall libmpi.MPI_Reduce_scatter(sendbuf::MPIPtr, recvbuf::MPIPtr, recvcounts::Ptr{Cint}, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm)::Cint
end

"""
    MPI_Reduce_scatter_block(sendbuf, recvbuf, recvcount, datatype, op, comm)

$(_doc_external(:MPI_Reduce_scatter_block))
"""
function MPI_Reduce_scatter_block(sendbuf, recvbuf, recvcount, datatype, op, comm)
    @mpichk @ccall libmpi.MPI_Reduce_scatter_block(sendbuf::MPIPtr, recvbuf::MPIPtr, recvcount::Cint, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm)::Cint
end

"""
    MPI_Reduce_scatter_block_init(sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)

$(_doc_external(:MPI_Reduce_scatter_block_init))
"""
function MPI_Reduce_scatter_block_init(sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
    @mpichk @ccall libmpi.MPI_Reduce_scatter_block_init(sendbuf::MPIPtr, recvbuf::MPIPtr, recvcount::Cint, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Reduce_scatter_init(sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)

$(_doc_external(:MPI_Reduce_scatter_init))
"""
function MPI_Reduce_scatter_init(sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
    @mpichk @ccall libmpi.MPI_Reduce_scatter_init(sendbuf::MPIPtr, recvbuf::MPIPtr, recvcounts::Ptr{Cint}, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Scan(sendbuf, recvbuf, count, datatype, op, comm)

$(_doc_external(:MPI_Scan))
"""
function MPI_Scan(sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk @ccall libmpi.MPI_Scan(sendbuf::MPIPtr, recvbuf::MPIPtr, count::Cint, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm)::Cint
end

"""
    MPI_Scan_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)

$(_doc_external(:MPI_Scan_init))
"""
function MPI_Scan_init(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk @ccall libmpi.MPI_Scan_init(sendbuf::MPIPtr, recvbuf::MPIPtr, count::Cint, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Scatter(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)

$(_doc_external(:MPI_Scatter))
"""
function MPI_Scatter(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk @ccall libmpi.MPI_Scatter(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::Cint, recvtype::MPI_Datatype, root::Cint, comm::MPI_Comm)::Cint
end

"""
    MPI_Scatter_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

$(_doc_external(:MPI_Scatter_init))
"""
function MPI_Scatter_init(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk @ccall libmpi.MPI_Scatter_init(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::Cint, recvtype::MPI_Datatype, root::Cint, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Scatterv(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)

$(_doc_external(:MPI_Scatterv))
"""
function MPI_Scatterv(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk @ccall libmpi.MPI_Scatterv(sendbuf::MPIPtr, sendcounts::Ptr{Cint}, displs::Ptr{Cint}, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::Cint, recvtype::MPI_Datatype, root::Cint, comm::MPI_Comm)::Cint
end

"""
    MPI_Scatterv_init(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

$(_doc_external(:MPI_Scatterv_init))
"""
function MPI_Scatterv_init(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk @ccall libmpi.MPI_Scatterv_init(sendbuf::MPIPtr, sendcounts::Ptr{Cint}, displs::Ptr{Cint}, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::Cint, recvtype::MPI_Datatype, root::Cint, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Comm_compare(comm1, comm2, result)

$(_doc_external(:MPI_Comm_compare))
"""
function MPI_Comm_compare(comm1, comm2, result)
    @mpichk @ccall libmpi.MPI_Comm_compare(comm1::MPI_Comm, comm2::MPI_Comm, result::Ptr{Cint})::Cint
end

"""
    MPI_Comm_create(comm, group, newcomm)

$(_doc_external(:MPI_Comm_create))
"""
function MPI_Comm_create(comm, group, newcomm)
    @mpichk @ccall libmpi.MPI_Comm_create(comm::MPI_Comm, group::MPI_Group, newcomm::Ptr{MPI_Comm})::Cint
end

"""
    MPI_Comm_create_group(comm, group, tag, newcomm)

$(_doc_external(:MPI_Comm_create_group))
"""
function MPI_Comm_create_group(comm, group, tag, newcomm)
    @mpichk @ccall libmpi.MPI_Comm_create_group(comm::MPI_Comm, group::MPI_Group, tag::Cint, newcomm::Ptr{MPI_Comm})::Cint
end

"""
    MPI_Comm_dup(comm, newcomm)

$(_doc_external(:MPI_Comm_dup))
"""
function MPI_Comm_dup(comm, newcomm)
    @mpichk @ccall libmpi.MPI_Comm_dup(comm::MPI_Comm, newcomm::Ptr{MPI_Comm})::Cint
end

"""
    MPI_Comm_dup_with_info(comm, info, newcomm)

$(_doc_external(:MPI_Comm_dup_with_info))
"""
function MPI_Comm_dup_with_info(comm, info, newcomm)
    @mpichk @ccall libmpi.MPI_Comm_dup_with_info(comm::MPI_Comm, info::MPI_Info, newcomm::Ptr{MPI_Comm})::Cint
end

"""
    MPI_Comm_free(comm)

$(_doc_external(:MPI_Comm_free))
"""
function MPI_Comm_free(comm)
    @mpichk @ccall libmpi.MPI_Comm_free(comm::Ptr{MPI_Comm})::Cint
end

"""
    MPI_Comm_get_info(comm, info_used)

$(_doc_external(:MPI_Comm_get_info))
"""
function MPI_Comm_get_info(comm, info_used)
    @mpichk @ccall libmpi.MPI_Comm_get_info(comm::MPI_Comm, info_used::Ptr{MPI_Info})::Cint
end

"""
    MPI_Comm_get_name(comm, comm_name, resultlen)

$(_doc_external(:MPI_Comm_get_name))
"""
function MPI_Comm_get_name(comm, comm_name, resultlen)
    @mpichk @ccall libmpi.MPI_Comm_get_name(comm::MPI_Comm, comm_name::Ptr{Cchar}, resultlen::Ptr{Cint})::Cint
end

"""
    MPI_Comm_group(comm, group)

$(_doc_external(:MPI_Comm_group))
"""
function MPI_Comm_group(comm, group)
    @mpichk @ccall libmpi.MPI_Comm_group(comm::MPI_Comm, group::Ptr{MPI_Group})::Cint
end

"""
    MPI_Comm_idup(comm, newcomm, request)

$(_doc_external(:MPI_Comm_idup))
"""
function MPI_Comm_idup(comm, newcomm, request)
    @mpichk @ccall libmpi.MPI_Comm_idup(comm::MPI_Comm, newcomm::Ptr{MPI_Comm}, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Comm_idup_with_info(comm, info, newcomm, request)

$(_doc_external(:MPI_Comm_idup_with_info))
"""
function MPI_Comm_idup_with_info(comm, info, newcomm, request)
    @mpichk @ccall libmpi.MPI_Comm_idup_with_info(comm::MPI_Comm, info::MPI_Info, newcomm::Ptr{MPI_Comm}, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Comm_rank(comm, rank)

$(_doc_external(:MPI_Comm_rank))
"""
function MPI_Comm_rank(comm, rank)
    @mpichk @ccall libmpi.MPI_Comm_rank(comm::MPI_Comm, rank::Ptr{Cint})::Cint
end

"""
    MPI_Comm_remote_group(comm, group)

$(_doc_external(:MPI_Comm_remote_group))
"""
function MPI_Comm_remote_group(comm, group)
    @mpichk @ccall libmpi.MPI_Comm_remote_group(comm::MPI_Comm, group::Ptr{MPI_Group})::Cint
end

"""
    MPI_Comm_remote_size(comm, size)

$(_doc_external(:MPI_Comm_remote_size))
"""
function MPI_Comm_remote_size(comm, size)
    @mpichk @ccall libmpi.MPI_Comm_remote_size(comm::MPI_Comm, size::Ptr{Cint})::Cint
end

"""
    MPI_Comm_set_info(comm, info)

$(_doc_external(:MPI_Comm_set_info))
"""
function MPI_Comm_set_info(comm, info)
    @mpichk @ccall libmpi.MPI_Comm_set_info(comm::MPI_Comm, info::MPI_Info)::Cint
end

"""
    MPI_Comm_set_name(comm, comm_name)

$(_doc_external(:MPI_Comm_set_name))
"""
function MPI_Comm_set_name(comm, comm_name)
    @mpichk @ccall libmpi.MPI_Comm_set_name(comm::MPI_Comm, comm_name::Ptr{Cchar})::Cint
end

"""
    MPI_Comm_size(comm, size)

$(_doc_external(:MPI_Comm_size))
"""
function MPI_Comm_size(comm, size)
    @mpichk @ccall libmpi.MPI_Comm_size(comm::MPI_Comm, size::Ptr{Cint})::Cint
end

"""
    MPI_Comm_split(comm, color, key, newcomm)

$(_doc_external(:MPI_Comm_split))
"""
function MPI_Comm_split(comm, color, key, newcomm)
    @mpichk @ccall libmpi.MPI_Comm_split(comm::MPI_Comm, color::Cint, key::Cint, newcomm::Ptr{MPI_Comm})::Cint
end

"""
    MPI_Comm_split_type(comm, split_type, key, info, newcomm)

$(_doc_external(:MPI_Comm_split_type))
"""
function MPI_Comm_split_type(comm, split_type, key, info, newcomm)
    @mpichk @ccall libmpi.MPI_Comm_split_type(comm::MPI_Comm, split_type::Cint, key::Cint, info::MPI_Info, newcomm::Ptr{MPI_Comm})::Cint
end

"""
    MPI_Comm_test_inter(comm, flag)

$(_doc_external(:MPI_Comm_test_inter))
"""
function MPI_Comm_test_inter(comm, flag)
    @mpichk @ccall libmpi.MPI_Comm_test_inter(comm::MPI_Comm, flag::Ptr{Cint})::Cint
end

"""
    MPI_Intercomm_create(local_comm, local_leader, peer_comm, remote_leader, tag, newintercomm)

$(_doc_external(:MPI_Intercomm_create))
"""
function MPI_Intercomm_create(local_comm, local_leader, peer_comm, remote_leader, tag, newintercomm)
    @mpichk @ccall libmpi.MPI_Intercomm_create(local_comm::MPI_Comm, local_leader::Cint, peer_comm::MPI_Comm, remote_leader::Cint, tag::Cint, newintercomm::Ptr{MPI_Comm})::Cint
end

"""
    MPI_Intercomm_create_from_groups(local_group, local_leader, remote_group, remote_leader, stringtag, info, errhandler, newintercomm)

$(_doc_external(:MPI_Intercomm_create_from_groups))
"""
function MPI_Intercomm_create_from_groups(local_group, local_leader, remote_group, remote_leader, stringtag, info, errhandler, newintercomm)
    @mpichk @ccall libmpi.MPI_Intercomm_create_from_groups(local_group::MPI_Group, local_leader::Cint, remote_group::MPI_Group, remote_leader::Cint, stringtag::Ptr{Cchar}, info::MPI_Info, errhandler::MPI_Errhandler, newintercomm::Ptr{MPI_Comm})::Cint
end

"""
    MPI_Intercomm_merge(intercomm, high, newintracomm)

$(_doc_external(:MPI_Intercomm_merge))
"""
function MPI_Intercomm_merge(intercomm, high, newintracomm)
    @mpichk @ccall libmpi.MPI_Intercomm_merge(intercomm::MPI_Comm, high::Cint, newintracomm::Ptr{MPI_Comm})::Cint
end

"""
    MPI_Get_address(location, address)

$(_doc_external(:MPI_Get_address))
"""
function MPI_Get_address(location, address)
    @mpichk @ccall libmpi.MPI_Get_address(location::MPIPtr, address::Ptr{MPI_Aint})::Cint
end

"""
    MPI_Get_count(status, datatype, count)

$(_doc_external(:MPI_Get_count))
"""
function MPI_Get_count(status, datatype, count)
    @mpichk @ccall libmpi.MPI_Get_count(status::Ptr{MPI_Status}, datatype::MPI_Datatype, count::Ptr{Cint})::Cint
end

"""
    MPI_Get_elements(status, datatype, count)

$(_doc_external(:MPI_Get_elements))
"""
function MPI_Get_elements(status, datatype, count)
    @mpichk @ccall libmpi.MPI_Get_elements(status::Ptr{MPI_Status}, datatype::MPI_Datatype, count::Ptr{Cint})::Cint
end

"""
    MPI_Get_elements_x(status, datatype, count)

$(_doc_external(:MPI_Get_elements_x))
"""
function MPI_Get_elements_x(status, datatype, count)
    @mpichk @ccall libmpi.MPI_Get_elements_x(status::Ptr{MPI_Status}, datatype::MPI_Datatype, count::Ptr{MPI_Count})::Cint
end

"""
    MPI_Pack(inbuf, incount, datatype, outbuf, outsize, position, comm)

$(_doc_external(:MPI_Pack))
"""
function MPI_Pack(inbuf, incount, datatype, outbuf, outsize, position, comm)
    @mpichk @ccall libmpi.MPI_Pack(inbuf::MPIPtr, incount::Cint, datatype::MPI_Datatype, outbuf::MPIPtr, outsize::Cint, position::Ptr{Cint}, comm::MPI_Comm)::Cint
end

"""
    MPI_Pack_external(datarep, inbuf, incount, datatype, outbuf, outsize, position)

$(_doc_external(:MPI_Pack_external))
"""
function MPI_Pack_external(datarep, inbuf, incount, datatype, outbuf, outsize, position)
    @mpichk @ccall libmpi.MPI_Pack_external(datarep::Ptr{Cchar}, inbuf::MPIPtr, incount::Cint, datatype::MPI_Datatype, outbuf::MPIPtr, outsize::MPI_Aint, position::Ptr{MPI_Aint})::Cint
end

"""
    MPI_Pack_external_size(datarep, incount, datatype, size)

$(_doc_external(:MPI_Pack_external_size))
"""
function MPI_Pack_external_size(datarep, incount, datatype, size)
    @mpichk @ccall libmpi.MPI_Pack_external_size(datarep::Ptr{Cchar}, incount::Cint, datatype::MPI_Datatype, size::Ptr{MPI_Aint})::Cint
end

"""
    MPI_Pack_size(incount, datatype, comm, size)

$(_doc_external(:MPI_Pack_size))
"""
function MPI_Pack_size(incount, datatype, comm, size)
    @mpichk @ccall libmpi.MPI_Pack_size(incount::Cint, datatype::MPI_Datatype, comm::MPI_Comm, size::Ptr{Cint})::Cint
end

"""
    MPI_Status_set_elements(status, datatype, count)

$(_doc_external(:MPI_Status_set_elements))
"""
function MPI_Status_set_elements(status, datatype, count)
    @mpichk @ccall libmpi.MPI_Status_set_elements(status::Ptr{MPI_Status}, datatype::MPI_Datatype, count::Cint)::Cint
end

"""
    MPI_Status_set_elements_x(status, datatype, count)

$(_doc_external(:MPI_Status_set_elements_x))
"""
function MPI_Status_set_elements_x(status, datatype, count)
    @mpichk @ccall libmpi.MPI_Status_set_elements_x(status::Ptr{MPI_Status}, datatype::MPI_Datatype, count::MPI_Count)::Cint
end

"""
    MPI_Type_commit(datatype)

$(_doc_external(:MPI_Type_commit))
"""
function MPI_Type_commit(datatype)
    @mpichk @ccall libmpi.MPI_Type_commit(datatype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_contiguous(count, oldtype, newtype)

$(_doc_external(:MPI_Type_contiguous))
"""
function MPI_Type_contiguous(count, oldtype, newtype)
    @mpichk @ccall libmpi.MPI_Type_contiguous(count::Cint, oldtype::MPI_Datatype, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_create_darray(size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)

$(_doc_external(:MPI_Type_create_darray))
"""
function MPI_Type_create_darray(size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
    @mpichk @ccall libmpi.MPI_Type_create_darray(size::Cint, rank::Cint, ndims::Cint, array_of_gsizes::Ptr{Cint}, array_of_distribs::Ptr{Cint}, array_of_dargs::Ptr{Cint}, array_of_psizes::Ptr{Cint}, order::Cint, oldtype::MPI_Datatype, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_create_hindexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)

$(_doc_external(:MPI_Type_create_hindexed))
"""
function MPI_Type_create_hindexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    @mpichk @ccall libmpi.MPI_Type_create_hindexed(count::Cint, array_of_blocklengths::Ptr{Cint}, array_of_displacements::Ptr{MPI_Aint}, oldtype::MPI_Datatype, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_create_hindexed_block(count, blocklength, array_of_displacements, oldtype, newtype)

$(_doc_external(:MPI_Type_create_hindexed_block))
"""
function MPI_Type_create_hindexed_block(count, blocklength, array_of_displacements, oldtype, newtype)
    @mpichk @ccall libmpi.MPI_Type_create_hindexed_block(count::Cint, blocklength::Cint, array_of_displacements::Ptr{MPI_Aint}, oldtype::MPI_Datatype, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_create_hvector(count, blocklength, stride, oldtype, newtype)

$(_doc_external(:MPI_Type_create_hvector))
"""
function MPI_Type_create_hvector(count, blocklength, stride, oldtype, newtype)
    @mpichk @ccall libmpi.MPI_Type_create_hvector(count::Cint, blocklength::Cint, stride::MPI_Aint, oldtype::MPI_Datatype, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_create_indexed_block(count, blocklength, array_of_displacements, oldtype, newtype)

$(_doc_external(:MPI_Type_create_indexed_block))
"""
function MPI_Type_create_indexed_block(count, blocklength, array_of_displacements, oldtype, newtype)
    @mpichk @ccall libmpi.MPI_Type_create_indexed_block(count::Cint, blocklength::Cint, array_of_displacements::Ptr{Cint}, oldtype::MPI_Datatype, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_create_resized(oldtype, lb, extent, newtype)

$(_doc_external(:MPI_Type_create_resized))
"""
function MPI_Type_create_resized(oldtype, lb, extent, newtype)
    @mpichk @ccall libmpi.MPI_Type_create_resized(oldtype::MPI_Datatype, lb::MPI_Aint, extent::MPI_Aint, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_create_struct(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)

$(_doc_external(:MPI_Type_create_struct))
"""
function MPI_Type_create_struct(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
    @mpichk @ccall libmpi.MPI_Type_create_struct(count::Cint, array_of_blocklengths::Ptr{Cint}, array_of_displacements::Ptr{MPI_Aint}, array_of_types::Ptr{MPI_Datatype}, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_create_subarray(ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)

$(_doc_external(:MPI_Type_create_subarray))
"""
function MPI_Type_create_subarray(ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
    @mpichk @ccall libmpi.MPI_Type_create_subarray(ndims::Cint, array_of_sizes::Ptr{Cint}, array_of_subsizes::Ptr{Cint}, array_of_starts::Ptr{Cint}, order::Cint, oldtype::MPI_Datatype, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_dup(oldtype, newtype)

$(_doc_external(:MPI_Type_dup))
"""
function MPI_Type_dup(oldtype, newtype)
    @mpichk @ccall libmpi.MPI_Type_dup(oldtype::MPI_Datatype, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_free(datatype)

$(_doc_external(:MPI_Type_free))
"""
function MPI_Type_free(datatype)
    @mpichk @ccall libmpi.MPI_Type_free(datatype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_get_contents(datatype, max_integers, max_addresses, max_datatypes, array_of_integers, array_of_addresses, array_of_datatypes)

$(_doc_external(:MPI_Type_get_contents))
"""
function MPI_Type_get_contents(datatype, max_integers, max_addresses, max_datatypes, array_of_integers, array_of_addresses, array_of_datatypes)
    @mpichk @ccall libmpi.MPI_Type_get_contents(datatype::MPI_Datatype, max_integers::Cint, max_addresses::Cint, max_datatypes::Cint, array_of_integers::Ptr{Cint}, array_of_addresses::Ptr{MPI_Aint}, array_of_datatypes::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_get_envelope(datatype, num_integers, num_addresses, num_datatypes, combiner)

$(_doc_external(:MPI_Type_get_envelope))
"""
function MPI_Type_get_envelope(datatype, num_integers, num_addresses, num_datatypes, combiner)
    @mpichk @ccall libmpi.MPI_Type_get_envelope(datatype::MPI_Datatype, num_integers::Ptr{Cint}, num_addresses::Ptr{Cint}, num_datatypes::Ptr{Cint}, combiner::Ptr{Cint})::Cint
end

"""
    MPI_Type_get_extent(datatype, lb, extent)

$(_doc_external(:MPI_Type_get_extent))
"""
function MPI_Type_get_extent(datatype, lb, extent)
    @mpichk @ccall libmpi.MPI_Type_get_extent(datatype::MPI_Datatype, lb::Ptr{MPI_Aint}, extent::Ptr{MPI_Aint})::Cint
end

"""
    MPI_Type_get_extent_x(datatype, lb, extent)

$(_doc_external(:MPI_Type_get_extent_x))
"""
function MPI_Type_get_extent_x(datatype, lb, extent)
    @mpichk @ccall libmpi.MPI_Type_get_extent_x(datatype::MPI_Datatype, lb::Ptr{MPI_Count}, extent::Ptr{MPI_Count})::Cint
end

"""
    MPI_Type_get_name(datatype, type_name, resultlen)

$(_doc_external(:MPI_Type_get_name))
"""
function MPI_Type_get_name(datatype, type_name, resultlen)
    @mpichk @ccall libmpi.MPI_Type_get_name(datatype::MPI_Datatype, type_name::Ptr{Cchar}, resultlen::Ptr{Cint})::Cint
end

"""
    MPI_Type_get_true_extent(datatype, true_lb, true_extent)

$(_doc_external(:MPI_Type_get_true_extent))
"""
function MPI_Type_get_true_extent(datatype, true_lb, true_extent)
    @mpichk @ccall libmpi.MPI_Type_get_true_extent(datatype::MPI_Datatype, true_lb::Ptr{MPI_Aint}, true_extent::Ptr{MPI_Aint})::Cint
end

"""
    MPI_Type_get_true_extent_x(datatype, true_lb, true_extent)

$(_doc_external(:MPI_Type_get_true_extent_x))
"""
function MPI_Type_get_true_extent_x(datatype, true_lb, true_extent)
    @mpichk @ccall libmpi.MPI_Type_get_true_extent_x(datatype::MPI_Datatype, true_lb::Ptr{MPI_Count}, true_extent::Ptr{MPI_Count})::Cint
end

"""
    MPI_Type_indexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)

$(_doc_external(:MPI_Type_indexed))
"""
function MPI_Type_indexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    @mpichk @ccall libmpi.MPI_Type_indexed(count::Cint, array_of_blocklengths::Ptr{Cint}, array_of_displacements::Ptr{Cint}, oldtype::MPI_Datatype, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_match_size(typeclass, size, datatype)

$(_doc_external(:MPI_Type_match_size))
"""
function MPI_Type_match_size(typeclass, size, datatype)
    @mpichk @ccall libmpi.MPI_Type_match_size(typeclass::Cint, size::Cint, datatype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_set_name(datatype, type_name)

$(_doc_external(:MPI_Type_set_name))
"""
function MPI_Type_set_name(datatype, type_name)
    @mpichk @ccall libmpi.MPI_Type_set_name(datatype::MPI_Datatype, type_name::Ptr{Cchar})::Cint
end

"""
    MPI_Type_size(datatype, size)

$(_doc_external(:MPI_Type_size))
"""
function MPI_Type_size(datatype, size)
    @mpichk @ccall libmpi.MPI_Type_size(datatype::MPI_Datatype, size::Ptr{Cint})::Cint
end

"""
    MPI_Type_size_x(datatype, size)

$(_doc_external(:MPI_Type_size_x))
"""
function MPI_Type_size_x(datatype, size)
    @mpichk @ccall libmpi.MPI_Type_size_x(datatype::MPI_Datatype, size::Ptr{MPI_Count})::Cint
end

"""
    MPI_Type_vector(count, blocklength, stride, oldtype, newtype)

$(_doc_external(:MPI_Type_vector))
"""
function MPI_Type_vector(count, blocklength, stride, oldtype, newtype)
    @mpichk @ccall libmpi.MPI_Type_vector(count::Cint, blocklength::Cint, stride::Cint, oldtype::MPI_Datatype, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Unpack(inbuf, insize, position, outbuf, outcount, datatype, comm)

$(_doc_external(:MPI_Unpack))
"""
function MPI_Unpack(inbuf, insize, position, outbuf, outcount, datatype, comm)
    @mpichk @ccall libmpi.MPI_Unpack(inbuf::MPIPtr, insize::Cint, position::Ptr{Cint}, outbuf::MPIPtr, outcount::Cint, datatype::MPI_Datatype, comm::MPI_Comm)::Cint
end

"""
    MPI_Unpack_external(datarep, inbuf, insize, position, outbuf, outcount, datatype)

$(_doc_external(:MPI_Unpack_external))
"""
function MPI_Unpack_external(datarep, inbuf, insize, position, outbuf, outcount, datatype)
    @mpichk @ccall libmpi.MPI_Unpack_external(datarep::Ptr{Cchar}, inbuf::MPIPtr, insize::MPI_Aint, position::Ptr{MPI_Aint}, outbuf::MPIPtr, outcount::Cint, datatype::MPI_Datatype)::Cint
end

"""
    MPI_Address(location, address)

$(_doc_external(:MPI_Address))
"""
function MPI_Address(location, address)
    @mpichk @ccall libmpi.MPI_Address(location::MPIPtr, address::Ptr{MPI_Aint})::Cint
end

"""
    MPI_Type_extent(datatype, extent)

$(_doc_external(:MPI_Type_extent))
"""
function MPI_Type_extent(datatype, extent)
    @mpichk @ccall libmpi.MPI_Type_extent(datatype::MPI_Datatype, extent::Ptr{MPI_Aint})::Cint
end

"""
    MPI_Type_lb(datatype, displacement)

$(_doc_external(:MPI_Type_lb))
"""
function MPI_Type_lb(datatype, displacement)
    @mpichk @ccall libmpi.MPI_Type_lb(datatype::MPI_Datatype, displacement::Ptr{MPI_Aint})::Cint
end

"""
    MPI_Type_ub(datatype, displacement)

$(_doc_external(:MPI_Type_ub))
"""
function MPI_Type_ub(datatype, displacement)
    @mpichk @ccall libmpi.MPI_Type_ub(datatype::MPI_Datatype, displacement::Ptr{MPI_Aint})::Cint
end

"""
    MPI_Type_hindexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)

$(_doc_external(:MPI_Type_hindexed))
"""
function MPI_Type_hindexed(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    @mpichk @ccall libmpi.MPI_Type_hindexed(count::Cint, array_of_blocklengths::Ptr{Cint}, array_of_displacements::Ptr{MPI_Aint}, oldtype::MPI_Datatype, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_hvector(count, blocklength, stride, oldtype, newtype)

$(_doc_external(:MPI_Type_hvector))
"""
function MPI_Type_hvector(count, blocklength, stride, oldtype, newtype)
    @mpichk @ccall libmpi.MPI_Type_hvector(count::Cint, blocklength::Cint, stride::MPI_Aint, oldtype::MPI_Datatype, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_struct(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)

$(_doc_external(:MPI_Type_struct))
"""
function MPI_Type_struct(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
    @mpichk @ccall libmpi.MPI_Type_struct(count::Cint, array_of_blocklengths::Ptr{Cint}, array_of_displacements::Ptr{MPI_Aint}, array_of_types::Ptr{MPI_Datatype}, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Add_error_class(errorclass)

$(_doc_external(:MPI_Add_error_class))
"""
function MPI_Add_error_class(errorclass)
    @mpichk @ccall libmpi.MPI_Add_error_class(errorclass::Ptr{Cint})::Cint
end

"""
    MPI_Add_error_code(errorclass, errorcode)

$(_doc_external(:MPI_Add_error_code))
"""
function MPI_Add_error_code(errorclass, errorcode)
    @mpichk @ccall libmpi.MPI_Add_error_code(errorclass::Cint, errorcode::Ptr{Cint})::Cint
end

"""
    MPI_Add_error_string(errorcode, string)

$(_doc_external(:MPI_Add_error_string))
"""
function MPI_Add_error_string(errorcode, string)
    @mpichk @ccall libmpi.MPI_Add_error_string(errorcode::Cint, string::Ptr{Cchar})::Cint
end

"""
    MPI_Comm_call_errhandler(comm, errorcode)

$(_doc_external(:MPI_Comm_call_errhandler))
"""
function MPI_Comm_call_errhandler(comm, errorcode)
    @mpichk @ccall libmpi.MPI_Comm_call_errhandler(comm::MPI_Comm, errorcode::Cint)::Cint
end

"""
    MPI_Comm_create_errhandler(comm_errhandler_fn, errhandler)

$(_doc_external(:MPI_Comm_create_errhandler))
"""
function MPI_Comm_create_errhandler(comm_errhandler_fn, errhandler)
    @mpichk @ccall libmpi.MPI_Comm_create_errhandler(comm_errhandler_fn::MPIPtr, errhandler::Ptr{MPI_Errhandler})::Cint
end

"""
    MPI_Comm_get_errhandler(comm, errhandler)

$(_doc_external(:MPI_Comm_get_errhandler))
"""
function MPI_Comm_get_errhandler(comm, errhandler)
    @mpichk @ccall libmpi.MPI_Comm_get_errhandler(comm::MPI_Comm, errhandler::Ptr{MPI_Errhandler})::Cint
end

"""
    MPI_Comm_set_errhandler(comm, errhandler)

$(_doc_external(:MPI_Comm_set_errhandler))
"""
function MPI_Comm_set_errhandler(comm, errhandler)
    @mpichk @ccall libmpi.MPI_Comm_set_errhandler(comm::MPI_Comm, errhandler::MPI_Errhandler)::Cint
end

"""
    MPI_Errhandler_free(errhandler)

$(_doc_external(:MPI_Errhandler_free))
"""
function MPI_Errhandler_free(errhandler)
    @mpichk @ccall libmpi.MPI_Errhandler_free(errhandler::Ptr{MPI_Errhandler})::Cint
end

"""
    MPI_Error_class(errorcode, errorclass)

$(_doc_external(:MPI_Error_class))
"""
function MPI_Error_class(errorcode, errorclass)
    @mpichk @ccall libmpi.MPI_Error_class(errorcode::Cint, errorclass::Ptr{Cint})::Cint
end

"""
    MPI_Error_string(errorcode, string, resultlen)

$(_doc_external(:MPI_Error_string))
"""
function MPI_Error_string(errorcode, string, resultlen)
    @mpichk @ccall libmpi.MPI_Error_string(errorcode::Cint, string::Ptr{Cchar}, resultlen::Ptr{Cint})::Cint
end

"""
    MPI_File_call_errhandler(fh, errorcode)

$(_doc_external(:MPI_File_call_errhandler))
"""
function MPI_File_call_errhandler(fh, errorcode)
    @mpichk @ccall libmpi.MPI_File_call_errhandler(fh::MPI_File, errorcode::Cint)::Cint
end

"""
    MPI_File_create_errhandler(file_errhandler_fn, errhandler)

$(_doc_external(:MPI_File_create_errhandler))
"""
function MPI_File_create_errhandler(file_errhandler_fn, errhandler)
    @mpichk @ccall libmpi.MPI_File_create_errhandler(file_errhandler_fn::MPIPtr, errhandler::Ptr{MPI_Errhandler})::Cint
end

"""
    MPI_File_get_errhandler(file, errhandler)

$(_doc_external(:MPI_File_get_errhandler))
"""
function MPI_File_get_errhandler(file, errhandler)
    @mpichk @ccall libmpi.MPI_File_get_errhandler(file::MPI_File, errhandler::Ptr{MPI_Errhandler})::Cint
end

"""
    MPI_File_set_errhandler(file, errhandler)

$(_doc_external(:MPI_File_set_errhandler))
"""
function MPI_File_set_errhandler(file, errhandler)
    @mpichk @ccall libmpi.MPI_File_set_errhandler(file::MPI_File, errhandler::MPI_Errhandler)::Cint
end

"""
    MPI_Win_call_errhandler(win, errorcode)

$(_doc_external(:MPI_Win_call_errhandler))
"""
function MPI_Win_call_errhandler(win, errorcode)
    @mpichk @ccall libmpi.MPI_Win_call_errhandler(win::MPI_Win, errorcode::Cint)::Cint
end

"""
    MPI_Win_create_errhandler(win_errhandler_fn, errhandler)

$(_doc_external(:MPI_Win_create_errhandler))
"""
function MPI_Win_create_errhandler(win_errhandler_fn, errhandler)
    @mpichk @ccall libmpi.MPI_Win_create_errhandler(win_errhandler_fn::MPIPtr, errhandler::Ptr{MPI_Errhandler})::Cint
end

"""
    MPI_Win_get_errhandler(win, errhandler)

$(_doc_external(:MPI_Win_get_errhandler))
"""
function MPI_Win_get_errhandler(win, errhandler)
    @mpichk @ccall libmpi.MPI_Win_get_errhandler(win::MPI_Win, errhandler::Ptr{MPI_Errhandler})::Cint
end

"""
    MPI_Win_set_errhandler(win, errhandler)

$(_doc_external(:MPI_Win_set_errhandler))
"""
function MPI_Win_set_errhandler(win, errhandler)
    @mpichk @ccall libmpi.MPI_Win_set_errhandler(win::MPI_Win, errhandler::MPI_Errhandler)::Cint
end

"""
    MPI_Errhandler_create(comm_errhandler_fn, errhandler)

$(_doc_external(:MPI_Errhandler_create))
"""
function MPI_Errhandler_create(comm_errhandler_fn, errhandler)
    @mpichk @ccall libmpi.MPI_Errhandler_create(comm_errhandler_fn::MPIPtr, errhandler::Ptr{MPI_Errhandler})::Cint
end

"""
    MPI_Errhandler_get(comm, errhandler)

$(_doc_external(:MPI_Errhandler_get))
"""
function MPI_Errhandler_get(comm, errhandler)
    @mpichk @ccall libmpi.MPI_Errhandler_get(comm::MPI_Comm, errhandler::Ptr{MPI_Errhandler})::Cint
end

"""
    MPI_Errhandler_set(comm, errhandler)

$(_doc_external(:MPI_Errhandler_set))
"""
function MPI_Errhandler_set(comm, errhandler)
    @mpichk @ccall libmpi.MPI_Errhandler_set(comm::MPI_Comm, errhandler::MPI_Errhandler)::Cint
end

"""
    MPI_Group_compare(group1, group2, result)

$(_doc_external(:MPI_Group_compare))
"""
function MPI_Group_compare(group1, group2, result)
    @mpichk @ccall libmpi.MPI_Group_compare(group1::MPI_Group, group2::MPI_Group, result::Ptr{Cint})::Cint
end

"""
    MPI_Group_difference(group1, group2, newgroup)

$(_doc_external(:MPI_Group_difference))
"""
function MPI_Group_difference(group1, group2, newgroup)
    @mpichk @ccall libmpi.MPI_Group_difference(group1::MPI_Group, group2::MPI_Group, newgroup::Ptr{MPI_Group})::Cint
end

"""
    MPI_Group_excl(group, n, ranks, newgroup)

$(_doc_external(:MPI_Group_excl))
"""
function MPI_Group_excl(group, n, ranks, newgroup)
    @mpichk @ccall libmpi.MPI_Group_excl(group::MPI_Group, n::Cint, ranks::Ptr{Cint}, newgroup::Ptr{MPI_Group})::Cint
end

"""
    MPI_Group_free(group)

$(_doc_external(:MPI_Group_free))
"""
function MPI_Group_free(group)
    @mpichk @ccall libmpi.MPI_Group_free(group::Ptr{MPI_Group})::Cint
end

"""
    MPI_Group_incl(group, n, ranks, newgroup)

$(_doc_external(:MPI_Group_incl))
"""
function MPI_Group_incl(group, n, ranks, newgroup)
    @mpichk @ccall libmpi.MPI_Group_incl(group::MPI_Group, n::Cint, ranks::Ptr{Cint}, newgroup::Ptr{MPI_Group})::Cint
end

"""
    MPI_Group_intersection(group1, group2, newgroup)

$(_doc_external(:MPI_Group_intersection))
"""
function MPI_Group_intersection(group1, group2, newgroup)
    @mpichk @ccall libmpi.MPI_Group_intersection(group1::MPI_Group, group2::MPI_Group, newgroup::Ptr{MPI_Group})::Cint
end

"""
    MPI_Group_range_excl(group, n, ranges, newgroup)

$(_doc_external(:MPI_Group_range_excl))
"""
function MPI_Group_range_excl(group, n, ranges, newgroup)
    @mpichk @ccall libmpi.MPI_Group_range_excl(group::MPI_Group, n::Cint, ranges::Ptr{NTuple{3, Cint}}, newgroup::Ptr{MPI_Group})::Cint
end

"""
    MPI_Group_range_incl(group, n, ranges, newgroup)

$(_doc_external(:MPI_Group_range_incl))
"""
function MPI_Group_range_incl(group, n, ranges, newgroup)
    @mpichk @ccall libmpi.MPI_Group_range_incl(group::MPI_Group, n::Cint, ranges::Ptr{NTuple{3, Cint}}, newgroup::Ptr{MPI_Group})::Cint
end

"""
    MPI_Group_rank(group, rank)

$(_doc_external(:MPI_Group_rank))
"""
function MPI_Group_rank(group, rank)
    @mpichk @ccall libmpi.MPI_Group_rank(group::MPI_Group, rank::Ptr{Cint})::Cint
end

"""
    MPI_Group_size(group, size)

$(_doc_external(:MPI_Group_size))
"""
function MPI_Group_size(group, size)
    @mpichk @ccall libmpi.MPI_Group_size(group::MPI_Group, size::Ptr{Cint})::Cint
end

"""
    MPI_Group_translate_ranks(group1, n, ranks1, group2, ranks2)

$(_doc_external(:MPI_Group_translate_ranks))
"""
function MPI_Group_translate_ranks(group1, n, ranks1, group2, ranks2)
    @mpichk @ccall libmpi.MPI_Group_translate_ranks(group1::MPI_Group, n::Cint, ranks1::Ptr{Cint}, group2::MPI_Group, ranks2::Ptr{Cint})::Cint
end

"""
    MPI_Group_union(group1, group2, newgroup)

$(_doc_external(:MPI_Group_union))
"""
function MPI_Group_union(group1, group2, newgroup)
    @mpichk @ccall libmpi.MPI_Group_union(group1::MPI_Group, group2::MPI_Group, newgroup::Ptr{MPI_Group})::Cint
end

"""
    MPI_Info_create(info)

$(_doc_external(:MPI_Info_create))
"""
function MPI_Info_create(info)
    @mpichk @ccall libmpi.MPI_Info_create(info::Ptr{MPI_Info})::Cint
end

"""
    MPI_Info_create_env(argc, argv, info)

$(_doc_external(:MPI_Info_create_env))
"""
function MPI_Info_create_env(argc, argv, info)
    @mpichk @ccall libmpi.MPI_Info_create_env(argc::Cint, argv::Ptr{Ptr{Cchar}}, info::Ptr{MPI_Info})::Cint
end

"""
    MPI_Info_delete(info, key)

$(_doc_external(:MPI_Info_delete))
"""
function MPI_Info_delete(info, key)
    @mpichk @ccall libmpi.MPI_Info_delete(info::MPI_Info, key::Ptr{Cchar})::Cint
end

"""
    MPI_Info_dup(info, newinfo)

$(_doc_external(:MPI_Info_dup))
"""
function MPI_Info_dup(info, newinfo)
    @mpichk @ccall libmpi.MPI_Info_dup(info::MPI_Info, newinfo::Ptr{MPI_Info})::Cint
end

"""
    MPI_Info_free(info)

$(_doc_external(:MPI_Info_free))
"""
function MPI_Info_free(info)
    @mpichk @ccall libmpi.MPI_Info_free(info::Ptr{MPI_Info})::Cint
end

"""
    MPI_Info_get(info, key, valuelen, value, flag)

$(_doc_external(:MPI_Info_get))
"""
function MPI_Info_get(info, key, valuelen, value, flag)
    @mpichk @ccall libmpi.MPI_Info_get(info::MPI_Info, key::Ptr{Cchar}, valuelen::Cint, value::Ptr{Cchar}, flag::Ptr{Cint})::Cint
end

"""
    MPI_Info_get_nkeys(info, nkeys)

$(_doc_external(:MPI_Info_get_nkeys))
"""
function MPI_Info_get_nkeys(info, nkeys)
    @mpichk @ccall libmpi.MPI_Info_get_nkeys(info::MPI_Info, nkeys::Ptr{Cint})::Cint
end

"""
    MPI_Info_get_nthkey(info, n, key)

$(_doc_external(:MPI_Info_get_nthkey))
"""
function MPI_Info_get_nthkey(info, n, key)
    @mpichk @ccall libmpi.MPI_Info_get_nthkey(info::MPI_Info, n::Cint, key::Ptr{Cchar})::Cint
end

"""
    MPI_Info_get_string(info, key, buflen, value, flag)

$(_doc_external(:MPI_Info_get_string))
"""
function MPI_Info_get_string(info, key, buflen, value, flag)
    @mpichk @ccall libmpi.MPI_Info_get_string(info::MPI_Info, key::Ptr{Cchar}, buflen::Ptr{Cint}, value::Ptr{Cchar}, flag::Ptr{Cint})::Cint
end

"""
    MPI_Info_get_valuelen(info, key, valuelen, flag)

$(_doc_external(:MPI_Info_get_valuelen))
"""
function MPI_Info_get_valuelen(info, key, valuelen, flag)
    @mpichk @ccall libmpi.MPI_Info_get_valuelen(info::MPI_Info, key::Ptr{Cchar}, valuelen::Ptr{Cint}, flag::Ptr{Cint})::Cint
end

"""
    MPI_Info_set(info, key, value)

$(_doc_external(:MPI_Info_set))
"""
function MPI_Info_set(info, key, value)
    @mpichk @ccall libmpi.MPI_Info_set(info::MPI_Info, key::Ptr{Cchar}, value::Ptr{Cchar})::Cint
end

"""
    MPI_Abort(comm, errorcode)

$(_doc_external(:MPI_Abort))
"""
function MPI_Abort(comm, errorcode)
    @mpichk @ccall libmpi.MPI_Abort(comm::MPI_Comm, errorcode::Cint)::Cint
end

"""
    MPI_Comm_create_from_group(group, stringtag, info, errhandler, newcomm)

$(_doc_external(:MPI_Comm_create_from_group))
"""
function MPI_Comm_create_from_group(group, stringtag, info, errhandler, newcomm)
    @mpichk @ccall libmpi.MPI_Comm_create_from_group(group::MPI_Group, stringtag::Ptr{Cchar}, info::MPI_Info, errhandler::MPI_Errhandler, newcomm::Ptr{MPI_Comm})::Cint
end

"""
    MPI_Finalize()

$(_doc_external(:MPI_Finalize))
"""
function MPI_Finalize()
    @mpichk @ccall libmpi.MPI_Finalize()::Cint
end

"""
    MPI_Finalized(flag)

$(_doc_external(:MPI_Finalized))
"""
function MPI_Finalized(flag)
    @mpichk @ccall libmpi.MPI_Finalized(flag::Ptr{Cint})::Cint
end

"""
    MPI_Init(argc, argv)

$(_doc_external(:MPI_Init))
"""
function MPI_Init(argc, argv)
    @mpichk @ccall libmpi.MPI_Init(argc::Ptr{Cint}, argv::Ptr{Ptr{Ptr{Cchar}}})::Cint
end

"""
    MPI_Init_thread(argc, argv, required, provided)

$(_doc_external(:MPI_Init_thread))
"""
function MPI_Init_thread(argc, argv, required, provided)
    @mpichk @ccall libmpi.MPI_Init_thread(argc::Ptr{Cint}, argv::Ptr{Ptr{Ptr{Cchar}}}, required::Cint, provided::Ptr{Cint})::Cint
end

"""
    MPI_Initialized(flag)

$(_doc_external(:MPI_Initialized))
"""
function MPI_Initialized(flag)
    @mpichk @ccall libmpi.MPI_Initialized(flag::Ptr{Cint})::Cint
end

"""
    MPI_Is_thread_main(flag)

$(_doc_external(:MPI_Is_thread_main))
"""
function MPI_Is_thread_main(flag)
    @mpichk @ccall libmpi.MPI_Is_thread_main(flag::Ptr{Cint})::Cint
end

"""
    MPI_Query_thread(provided)

$(_doc_external(:MPI_Query_thread))
"""
function MPI_Query_thread(provided)
    @mpichk @ccall libmpi.MPI_Query_thread(provided::Ptr{Cint})::Cint
end

"""
    MPI_Aint_add(base, disp)

$(_doc_external(:MPI_Aint_add))
"""
function MPI_Aint_add(base, disp)
    @mpichk @ccall libmpi.MPI_Aint_add(base::MPI_Aint, disp::MPI_Aint)::MPI_Aint
end

"""
    MPI_Aint_diff(addr1, addr2)

$(_doc_external(:MPI_Aint_diff))
"""
function MPI_Aint_diff(addr1, addr2)
    @mpichk @ccall libmpi.MPI_Aint_diff(addr1::MPI_Aint, addr2::MPI_Aint)::MPI_Aint
end

"""
    MPI_Get_library_version(version, resultlen)

$(_doc_external(:MPI_Get_library_version))
"""
function MPI_Get_library_version(version, resultlen)
    @mpichk @ccall libmpi.MPI_Get_library_version(version::Ptr{Cchar}, resultlen::Ptr{Cint})::Cint
end

"""
    MPI_Get_processor_name(name, resultlen)

$(_doc_external(:MPI_Get_processor_name))
"""
function MPI_Get_processor_name(name, resultlen)
    @mpichk @ccall libmpi.MPI_Get_processor_name(name::Ptr{Cchar}, resultlen::Ptr{Cint})::Cint
end

"""
    MPI_Get_version(version, subversion)

$(_doc_external(:MPI_Get_version))
"""
function MPI_Get_version(version, subversion)
    @mpichk @ccall libmpi.MPI_Get_version(version::Ptr{Cint}, subversion::Ptr{Cint})::Cint
end

"""
    MPI_Op_commutative(op, commute)

$(_doc_external(:MPI_Op_commutative))
"""
function MPI_Op_commutative(op, commute)
    @mpichk @ccall libmpi.MPI_Op_commutative(op::MPI_Op, commute::Ptr{Cint})::Cint
end

"""
    MPI_Op_create(user_fn, commute, op)

$(_doc_external(:MPI_Op_create))
"""
function MPI_Op_create(user_fn, commute, op)
    @mpichk @ccall libmpi.MPI_Op_create(user_fn::MPIPtr, commute::Cint, op::Ptr{MPI_Op})::Cint
end

"""
    MPI_Op_free(op)

$(_doc_external(:MPI_Op_free))
"""
function MPI_Op_free(op)
    @mpichk @ccall libmpi.MPI_Op_free(op::Ptr{MPI_Op})::Cint
end

"""
    MPI_Parrived(request, partition, flag)

$(_doc_external(:MPI_Parrived))
"""
function MPI_Parrived(request, partition, flag)
    @mpichk @ccall libmpi.MPI_Parrived(request::MPI_Request, partition::Cint, flag::Ptr{Cint})::Cint
end

"""
    MPI_Pready(partition, request)

$(_doc_external(:MPI_Pready))
"""
function MPI_Pready(partition, request)
    @mpichk @ccall libmpi.MPI_Pready(partition::Cint, request::MPI_Request)::Cint
end

"""
    MPI_Pready_list(length, array_of_partitions, request)

$(_doc_external(:MPI_Pready_list))
"""
function MPI_Pready_list(length, array_of_partitions, request)
    @mpichk @ccall libmpi.MPI_Pready_list(length::Cint, array_of_partitions::Ptr{Cint}, request::MPI_Request)::Cint
end

"""
    MPI_Pready_range(partition_low, partition_high, request)

$(_doc_external(:MPI_Pready_range))
"""
function MPI_Pready_range(partition_low, partition_high, request)
    @mpichk @ccall libmpi.MPI_Pready_range(partition_low::Cint, partition_high::Cint, request::MPI_Request)::Cint
end

"""
    MPI_Precv_init(buf, partitions, count, datatype, dest, tag, comm, info, request)

$(_doc_external(:MPI_Precv_init))
"""
function MPI_Precv_init(buf, partitions, count, datatype, dest, tag, comm, info, request)
    @mpichk @ccall libmpi.MPI_Precv_init(buf::MPIPtr, partitions::Cint, count::MPI_Count, datatype::MPI_Datatype, dest::Cint, tag::Cint, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Psend_init(buf, partitions, count, datatype, dest, tag, comm, info, request)

$(_doc_external(:MPI_Psend_init))
"""
function MPI_Psend_init(buf, partitions, count, datatype, dest, tag, comm, info, request)
    @mpichk @ccall libmpi.MPI_Psend_init(buf::MPIPtr, partitions::Cint, count::MPI_Count, datatype::MPI_Datatype, dest::Cint, tag::Cint, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Bsend(buf, count, datatype, dest, tag, comm)

$(_doc_external(:MPI_Bsend))
"""
function MPI_Bsend(buf, count, datatype, dest, tag, comm)
    @mpichk @ccall libmpi.MPI_Bsend(buf::MPIPtr, count::Cint, datatype::MPI_Datatype, dest::Cint, tag::Cint, comm::MPI_Comm)::Cint
end

"""
    MPI_Bsend_init(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Bsend_init))
"""
function MPI_Bsend_init(buf, count, datatype, dest, tag, comm, request)
    @mpichk @ccall libmpi.MPI_Bsend_init(buf::MPIPtr, count::Cint, datatype::MPI_Datatype, dest::Cint, tag::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Buffer_attach(buffer, size)

$(_doc_external(:MPI_Buffer_attach))
"""
function MPI_Buffer_attach(buffer, size)
    @mpichk @ccall libmpi.MPI_Buffer_attach(buffer::MPIPtr, size::Cint)::Cint
end

"""
    MPI_Buffer_detach(buffer_addr, size)

$(_doc_external(:MPI_Buffer_detach))
"""
function MPI_Buffer_detach(buffer_addr, size)
    @mpichk @ccall libmpi.MPI_Buffer_detach(buffer_addr::MPIPtr, size::Ptr{Cint})::Cint
end

"""
    MPI_Ibsend(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Ibsend))
"""
function MPI_Ibsend(buf, count, datatype, dest, tag, comm, request)
    @mpichk @ccall libmpi.MPI_Ibsend(buf::MPIPtr, count::Cint, datatype::MPI_Datatype, dest::Cint, tag::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Improbe(source, tag, comm, flag, message, status)

$(_doc_external(:MPI_Improbe))
"""
function MPI_Improbe(source, tag, comm, flag, message, status)
    @mpichk @ccall libmpi.MPI_Improbe(source::Cint, tag::Cint, comm::MPI_Comm, flag::Ptr{Cint}, message::Ptr{MPI_Message}, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_Imrecv(buf, count, datatype, message, request)

$(_doc_external(:MPI_Imrecv))
"""
function MPI_Imrecv(buf, count, datatype, message, request)
    @mpichk @ccall libmpi.MPI_Imrecv(buf::MPIPtr, count::Cint, datatype::MPI_Datatype, message::Ptr{MPI_Message}, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Iprobe(source, tag, comm, flag, status)

$(_doc_external(:MPI_Iprobe))
"""
function MPI_Iprobe(source, tag, comm, flag, status)
    @mpichk @ccall libmpi.MPI_Iprobe(source::Cint, tag::Cint, comm::MPI_Comm, flag::Ptr{Cint}, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_Irecv(buf, count, datatype, source, tag, comm, request)

$(_doc_external(:MPI_Irecv))
"""
function MPI_Irecv(buf, count, datatype, source, tag, comm, request)
    @mpichk @ccall libmpi.MPI_Irecv(buf::MPIPtr, count::Cint, datatype::MPI_Datatype, source::Cint, tag::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Irsend(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Irsend))
"""
function MPI_Irsend(buf, count, datatype, dest, tag, comm, request)
    @mpichk @ccall libmpi.MPI_Irsend(buf::MPIPtr, count::Cint, datatype::MPI_Datatype, dest::Cint, tag::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Isend(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Isend))
"""
function MPI_Isend(buf, count, datatype, dest, tag, comm, request)
    @mpichk @ccall libmpi.MPI_Isend(buf::MPIPtr, count::Cint, datatype::MPI_Datatype, dest::Cint, tag::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Isendrecv(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)

$(_doc_external(:MPI_Isendrecv))
"""
function MPI_Isendrecv(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
    @mpichk @ccall libmpi.MPI_Isendrecv(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, dest::Cint, sendtag::Cint, recvbuf::MPIPtr, recvcount::Cint, recvtype::MPI_Datatype, source::Cint, recvtag::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Isendrecv_replace(buf, count, datatype, dest, sendtag, source, recvtag, comm, request)

$(_doc_external(:MPI_Isendrecv_replace))
"""
function MPI_Isendrecv_replace(buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
    @mpichk @ccall libmpi.MPI_Isendrecv_replace(buf::MPIPtr, count::Cint, datatype::MPI_Datatype, dest::Cint, sendtag::Cint, source::Cint, recvtag::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Issend(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Issend))
"""
function MPI_Issend(buf, count, datatype, dest, tag, comm, request)
    @mpichk @ccall libmpi.MPI_Issend(buf::MPIPtr, count::Cint, datatype::MPI_Datatype, dest::Cint, tag::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Mprobe(source, tag, comm, message, status)

$(_doc_external(:MPI_Mprobe))
"""
function MPI_Mprobe(source, tag, comm, message, status)
    @mpichk @ccall libmpi.MPI_Mprobe(source::Cint, tag::Cint, comm::MPI_Comm, message::Ptr{MPI_Message}, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_Mrecv(buf, count, datatype, message, status)

$(_doc_external(:MPI_Mrecv))
"""
function MPI_Mrecv(buf, count, datatype, message, status)
    @mpichk @ccall libmpi.MPI_Mrecv(buf::MPIPtr, count::Cint, datatype::MPI_Datatype, message::Ptr{MPI_Message}, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_Probe(source, tag, comm, status)

$(_doc_external(:MPI_Probe))
"""
function MPI_Probe(source, tag, comm, status)
    @mpichk @ccall libmpi.MPI_Probe(source::Cint, tag::Cint, comm::MPI_Comm, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_Recv(buf, count, datatype, source, tag, comm, status)

$(_doc_external(:MPI_Recv))
"""
function MPI_Recv(buf, count, datatype, source, tag, comm, status)
    @mpichk @ccall libmpi.MPI_Recv(buf::MPIPtr, count::Cint, datatype::MPI_Datatype, source::Cint, tag::Cint, comm::MPI_Comm, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_Recv_init(buf, count, datatype, source, tag, comm, request)

$(_doc_external(:MPI_Recv_init))
"""
function MPI_Recv_init(buf, count, datatype, source, tag, comm, request)
    @mpichk @ccall libmpi.MPI_Recv_init(buf::MPIPtr, count::Cint, datatype::MPI_Datatype, source::Cint, tag::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Rsend(buf, count, datatype, dest, tag, comm)

$(_doc_external(:MPI_Rsend))
"""
function MPI_Rsend(buf, count, datatype, dest, tag, comm)
    @mpichk @ccall libmpi.MPI_Rsend(buf::MPIPtr, count::Cint, datatype::MPI_Datatype, dest::Cint, tag::Cint, comm::MPI_Comm)::Cint
end

"""
    MPI_Rsend_init(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Rsend_init))
"""
function MPI_Rsend_init(buf, count, datatype, dest, tag, comm, request)
    @mpichk @ccall libmpi.MPI_Rsend_init(buf::MPIPtr, count::Cint, datatype::MPI_Datatype, dest::Cint, tag::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Send(buf, count, datatype, dest, tag, comm)

$(_doc_external(:MPI_Send))
"""
function MPI_Send(buf, count, datatype, dest, tag, comm)
    @mpichk @ccall libmpi.MPI_Send(buf::MPIPtr, count::Cint, datatype::MPI_Datatype, dest::Cint, tag::Cint, comm::MPI_Comm)::Cint
end

"""
    MPI_Send_init(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Send_init))
"""
function MPI_Send_init(buf, count, datatype, dest, tag, comm, request)
    @mpichk @ccall libmpi.MPI_Send_init(buf::MPIPtr, count::Cint, datatype::MPI_Datatype, dest::Cint, tag::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Sendrecv(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)

$(_doc_external(:MPI_Sendrecv))
"""
function MPI_Sendrecv(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
    @mpichk @ccall libmpi.MPI_Sendrecv(sendbuf::MPIPtr, sendcount::Cint, sendtype::MPI_Datatype, dest::Cint, sendtag::Cint, recvbuf::MPIPtr, recvcount::Cint, recvtype::MPI_Datatype, source::Cint, recvtag::Cint, comm::MPI_Comm, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_Sendrecv_replace(buf, count, datatype, dest, sendtag, source, recvtag, comm, status)

$(_doc_external(:MPI_Sendrecv_replace))
"""
function MPI_Sendrecv_replace(buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
    @mpichk @ccall libmpi.MPI_Sendrecv_replace(buf::MPIPtr, count::Cint, datatype::MPI_Datatype, dest::Cint, sendtag::Cint, source::Cint, recvtag::Cint, comm::MPI_Comm, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_Ssend(buf, count, datatype, dest, tag, comm)

$(_doc_external(:MPI_Ssend))
"""
function MPI_Ssend(buf, count, datatype, dest, tag, comm)
    @mpichk @ccall libmpi.MPI_Ssend(buf::MPIPtr, count::Cint, datatype::MPI_Datatype, dest::Cint, tag::Cint, comm::MPI_Comm)::Cint
end

"""
    MPI_Ssend_init(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Ssend_init))
"""
function MPI_Ssend_init(buf, count, datatype, dest, tag, comm, request)
    @mpichk @ccall libmpi.MPI_Ssend_init(buf::MPIPtr, count::Cint, datatype::MPI_Datatype, dest::Cint, tag::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Cancel(request)

$(_doc_external(:MPI_Cancel))
"""
function MPI_Cancel(request)
    @mpichk @ccall libmpi.MPI_Cancel(request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Grequest_complete(request)

$(_doc_external(:MPI_Grequest_complete))
"""
function MPI_Grequest_complete(request)
    @mpichk @ccall libmpi.MPI_Grequest_complete(request::MPI_Request)::Cint
end

"""
    MPI_Grequest_start(query_fn, free_fn, cancel_fn, extra_state, request)

$(_doc_external(:MPI_Grequest_start))
"""
function MPI_Grequest_start(query_fn, free_fn, cancel_fn, extra_state, request)
    @mpichk @ccall libmpi.MPI_Grequest_start(query_fn::MPIPtr, free_fn::MPIPtr, cancel_fn::MPIPtr, extra_state::MPIPtr, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Request_free(request)

$(_doc_external(:MPI_Request_free))
"""
function MPI_Request_free(request)
    @mpichk @ccall libmpi.MPI_Request_free(request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Request_get_status(request, flag, status)

$(_doc_external(:MPI_Request_get_status))
"""
function MPI_Request_get_status(request, flag, status)
    @mpichk @ccall libmpi.MPI_Request_get_status(request::MPI_Request, flag::Ptr{Cint}, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_Start(request)

$(_doc_external(:MPI_Start))
"""
function MPI_Start(request)
    @mpichk @ccall libmpi.MPI_Start(request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Startall(count, array_of_requests)

$(_doc_external(:MPI_Startall))
"""
function MPI_Startall(count, array_of_requests)
    @mpichk @ccall libmpi.MPI_Startall(count::Cint, array_of_requests::Ptr{MPI_Request})::Cint
end

"""
    MPI_Status_set_cancelled(status, flag)

$(_doc_external(:MPI_Status_set_cancelled))
"""
function MPI_Status_set_cancelled(status, flag)
    @mpichk @ccall libmpi.MPI_Status_set_cancelled(status::Ptr{MPI_Status}, flag::Cint)::Cint
end

"""
    MPI_Test_cancelled(status, flag)

$(_doc_external(:MPI_Test_cancelled))
"""
function MPI_Test_cancelled(status, flag)
    @mpichk @ccall libmpi.MPI_Test_cancelled(status::Ptr{MPI_Status}, flag::Ptr{Cint})::Cint
end

"""
    MPI_Testall(count, array_of_requests, flag, array_of_statuses)

$(_doc_external(:MPI_Testall))
"""
function MPI_Testall(count, array_of_requests, flag, array_of_statuses)
    @mpichk @ccall libmpi.MPI_Testall(count::Cint, array_of_requests::Ptr{MPI_Request}, flag::Ptr{Cint}, array_of_statuses::Ptr{MPI_Status})::Cint
end

"""
    MPI_Testany(count, array_of_requests, indx, flag, status)

$(_doc_external(:MPI_Testany))
"""
function MPI_Testany(count, array_of_requests, indx, flag, status)
    @mpichk @ccall libmpi.MPI_Testany(count::Cint, array_of_requests::Ptr{MPI_Request}, indx::Ptr{Cint}, flag::Ptr{Cint}, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_Testsome(incount, array_of_requests, outcount, array_of_indices, array_of_statuses)

$(_doc_external(:MPI_Testsome))
"""
function MPI_Testsome(incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
    @mpichk @ccall libmpi.MPI_Testsome(incount::Cint, array_of_requests::Ptr{MPI_Request}, outcount::Ptr{Cint}, array_of_indices::Ptr{Cint}, array_of_statuses::Ptr{MPI_Status})::Cint
end

"""
    MPI_Waitall(count, array_of_requests, array_of_statuses)

$(_doc_external(:MPI_Waitall))
"""
function MPI_Waitall(count, array_of_requests, array_of_statuses)
    @mpichk @ccall libmpi.MPI_Waitall(count::Cint, array_of_requests::Ptr{MPI_Request}, array_of_statuses::Ptr{MPI_Status})::Cint
end

"""
    MPI_Waitany(count, array_of_requests, indx, status)

$(_doc_external(:MPI_Waitany))
"""
function MPI_Waitany(count, array_of_requests, indx, status)
    @mpichk @ccall libmpi.MPI_Waitany(count::Cint, array_of_requests::Ptr{MPI_Request}, indx::Ptr{Cint}, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_Waitsome(incount, array_of_requests, outcount, array_of_indices, array_of_statuses)

$(_doc_external(:MPI_Waitsome))
"""
function MPI_Waitsome(incount, array_of_requests, outcount, array_of_indices, array_of_statuses)
    @mpichk @ccall libmpi.MPI_Waitsome(incount::Cint, array_of_requests::Ptr{MPI_Request}, outcount::Ptr{Cint}, array_of_indices::Ptr{Cint}, array_of_statuses::Ptr{MPI_Status})::Cint
end

"""
    MPI_Accumulate(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)

$(_doc_external(:MPI_Accumulate))
"""
function MPI_Accumulate(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    @mpichk @ccall libmpi.MPI_Accumulate(origin_addr::MPIPtr, origin_count::Cint, origin_datatype::MPI_Datatype, target_rank::Cint, target_disp::MPI_Aint, target_count::Cint, target_datatype::MPI_Datatype, op::MPI_Op, win::MPI_Win)::Cint
end

"""
    MPI_Alloc_mem(size, info, baseptr)

$(_doc_external(:MPI_Alloc_mem))
"""
function MPI_Alloc_mem(size, info, baseptr)
    @mpichk @ccall libmpi.MPI_Alloc_mem(size::MPI_Aint, info::MPI_Info, baseptr::MPIPtr)::Cint
end

"""
    MPI_Compare_and_swap(origin_addr, compare_addr, result_addr, datatype, target_rank, target_disp, win)

$(_doc_external(:MPI_Compare_and_swap))
"""
function MPI_Compare_and_swap(origin_addr, compare_addr, result_addr, datatype, target_rank, target_disp, win)
    @mpichk @ccall libmpi.MPI_Compare_and_swap(origin_addr::MPIPtr, compare_addr::MPIPtr, result_addr::MPIPtr, datatype::MPI_Datatype, target_rank::Cint, target_disp::MPI_Aint, win::MPI_Win)::Cint
end

"""
    MPI_Fetch_and_op(origin_addr, result_addr, datatype, target_rank, target_disp, op, win)

$(_doc_external(:MPI_Fetch_and_op))
"""
function MPI_Fetch_and_op(origin_addr, result_addr, datatype, target_rank, target_disp, op, win)
    @mpichk @ccall libmpi.MPI_Fetch_and_op(origin_addr::MPIPtr, result_addr::MPIPtr, datatype::MPI_Datatype, target_rank::Cint, target_disp::MPI_Aint, op::MPI_Op, win::MPI_Win)::Cint
end

"""
    MPI_Free_mem(base)

$(_doc_external(:MPI_Free_mem))
"""
function MPI_Free_mem(base)
    @mpichk @ccall libmpi.MPI_Free_mem(base::MPIPtr)::Cint
end

"""
    MPI_Get(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)

$(_doc_external(:MPI_Get))
"""
function MPI_Get(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    @mpichk @ccall libmpi.MPI_Get(origin_addr::MPIPtr, origin_count::Cint, origin_datatype::MPI_Datatype, target_rank::Cint, target_disp::MPI_Aint, target_count::Cint, target_datatype::MPI_Datatype, win::MPI_Win)::Cint
end

"""
    MPI_Get_accumulate(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)

$(_doc_external(:MPI_Get_accumulate))
"""
function MPI_Get_accumulate(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    @mpichk @ccall libmpi.MPI_Get_accumulate(origin_addr::MPIPtr, origin_count::Cint, origin_datatype::MPI_Datatype, result_addr::MPIPtr, result_count::Cint, result_datatype::MPI_Datatype, target_rank::Cint, target_disp::MPI_Aint, target_count::Cint, target_datatype::MPI_Datatype, op::MPI_Op, win::MPI_Win)::Cint
end

"""
    MPI_Put(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)

$(_doc_external(:MPI_Put))
"""
function MPI_Put(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    @mpichk @ccall libmpi.MPI_Put(origin_addr::MPIPtr, origin_count::Cint, origin_datatype::MPI_Datatype, target_rank::Cint, target_disp::MPI_Aint, target_count::Cint, target_datatype::MPI_Datatype, win::MPI_Win)::Cint
end

"""
    MPI_Raccumulate(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)

$(_doc_external(:MPI_Raccumulate))
"""
function MPI_Raccumulate(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    @mpichk @ccall libmpi.MPI_Raccumulate(origin_addr::MPIPtr, origin_count::Cint, origin_datatype::MPI_Datatype, target_rank::Cint, target_disp::MPI_Aint, target_count::Cint, target_datatype::MPI_Datatype, op::MPI_Op, win::MPI_Win, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Rget(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)

$(_doc_external(:MPI_Rget))
"""
function MPI_Rget(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    @mpichk @ccall libmpi.MPI_Rget(origin_addr::MPIPtr, origin_count::Cint, origin_datatype::MPI_Datatype, target_rank::Cint, target_disp::MPI_Aint, target_count::Cint, target_datatype::MPI_Datatype, win::MPI_Win, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Rget_accumulate(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)

$(_doc_external(:MPI_Rget_accumulate))
"""
function MPI_Rget_accumulate(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    @mpichk @ccall libmpi.MPI_Rget_accumulate(origin_addr::MPIPtr, origin_count::Cint, origin_datatype::MPI_Datatype, result_addr::MPIPtr, result_count::Cint, result_datatype::MPI_Datatype, target_rank::Cint, target_disp::MPI_Aint, target_count::Cint, target_datatype::MPI_Datatype, op::MPI_Op, win::MPI_Win, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Rput(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)

$(_doc_external(:MPI_Rput))
"""
function MPI_Rput(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    @mpichk @ccall libmpi.MPI_Rput(origin_addr::MPIPtr, origin_count::Cint, origin_datatype::MPI_Datatype, target_rank::Cint, target_disp::MPI_Aint, target_count::Cint, target_datatype::MPI_Datatype, win::MPI_Win, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Win_allocate(size, disp_unit, info, comm, baseptr, win)

$(_doc_external(:MPI_Win_allocate))
"""
function MPI_Win_allocate(size, disp_unit, info, comm, baseptr, win)
    @mpichk @ccall libmpi.MPI_Win_allocate(size::MPI_Aint, disp_unit::Cint, info::MPI_Info, comm::MPI_Comm, baseptr::MPIPtr, win::Ptr{MPI_Win})::Cint
end

"""
    MPI_Win_allocate_shared(size, disp_unit, info, comm, baseptr, win)

$(_doc_external(:MPI_Win_allocate_shared))
"""
function MPI_Win_allocate_shared(size, disp_unit, info, comm, baseptr, win)
    @mpichk @ccall libmpi.MPI_Win_allocate_shared(size::MPI_Aint, disp_unit::Cint, info::MPI_Info, comm::MPI_Comm, baseptr::MPIPtr, win::Ptr{MPI_Win})::Cint
end

"""
    MPI_Win_attach(win, base, size)

$(_doc_external(:MPI_Win_attach))
"""
function MPI_Win_attach(win, base, size)
    @mpichk @ccall libmpi.MPI_Win_attach(win::MPI_Win, base::MPIPtr, size::MPI_Aint)::Cint
end

"""
    MPI_Win_complete(win)

$(_doc_external(:MPI_Win_complete))
"""
function MPI_Win_complete(win)
    @mpichk @ccall libmpi.MPI_Win_complete(win::MPI_Win)::Cint
end

"""
    MPI_Win_create(base, size, disp_unit, info, comm, win)

$(_doc_external(:MPI_Win_create))
"""
function MPI_Win_create(base, size, disp_unit, info, comm, win)
    @mpichk @ccall libmpi.MPI_Win_create(base::MPIPtr, size::MPI_Aint, disp_unit::Cint, info::MPI_Info, comm::MPI_Comm, win::Ptr{MPI_Win})::Cint
end

"""
    MPI_Win_create_dynamic(info, comm, win)

$(_doc_external(:MPI_Win_create_dynamic))
"""
function MPI_Win_create_dynamic(info, comm, win)
    @mpichk @ccall libmpi.MPI_Win_create_dynamic(info::MPI_Info, comm::MPI_Comm, win::Ptr{MPI_Win})::Cint
end

"""
    MPI_Win_detach(win, base)

$(_doc_external(:MPI_Win_detach))
"""
function MPI_Win_detach(win, base)
    @mpichk @ccall libmpi.MPI_Win_detach(win::MPI_Win, base::MPIPtr)::Cint
end

"""
    MPI_Win_fence(assert, win)

$(_doc_external(:MPI_Win_fence))
"""
function MPI_Win_fence(assert, win)
    @mpichk @ccall libmpi.MPI_Win_fence(assert::Cint, win::MPI_Win)::Cint
end

"""
    MPI_Win_flush(rank, win)

$(_doc_external(:MPI_Win_flush))
"""
function MPI_Win_flush(rank, win)
    @mpichk @ccall libmpi.MPI_Win_flush(rank::Cint, win::MPI_Win)::Cint
end

"""
    MPI_Win_flush_all(win)

$(_doc_external(:MPI_Win_flush_all))
"""
function MPI_Win_flush_all(win)
    @mpichk @ccall libmpi.MPI_Win_flush_all(win::MPI_Win)::Cint
end

"""
    MPI_Win_flush_local(rank, win)

$(_doc_external(:MPI_Win_flush_local))
"""
function MPI_Win_flush_local(rank, win)
    @mpichk @ccall libmpi.MPI_Win_flush_local(rank::Cint, win::MPI_Win)::Cint
end

"""
    MPI_Win_flush_local_all(win)

$(_doc_external(:MPI_Win_flush_local_all))
"""
function MPI_Win_flush_local_all(win)
    @mpichk @ccall libmpi.MPI_Win_flush_local_all(win::MPI_Win)::Cint
end

"""
    MPI_Win_free(win)

$(_doc_external(:MPI_Win_free))
"""
function MPI_Win_free(win)
    @mpichk @ccall libmpi.MPI_Win_free(win::Ptr{MPI_Win})::Cint
end

"""
    MPI_Win_get_group(win, group)

$(_doc_external(:MPI_Win_get_group))
"""
function MPI_Win_get_group(win, group)
    @mpichk @ccall libmpi.MPI_Win_get_group(win::MPI_Win, group::Ptr{MPI_Group})::Cint
end

"""
    MPI_Win_get_info(win, info_used)

$(_doc_external(:MPI_Win_get_info))
"""
function MPI_Win_get_info(win, info_used)
    @mpichk @ccall libmpi.MPI_Win_get_info(win::MPI_Win, info_used::Ptr{MPI_Info})::Cint
end

"""
    MPI_Win_get_name(win, win_name, resultlen)

$(_doc_external(:MPI_Win_get_name))
"""
function MPI_Win_get_name(win, win_name, resultlen)
    @mpichk @ccall libmpi.MPI_Win_get_name(win::MPI_Win, win_name::Ptr{Cchar}, resultlen::Ptr{Cint})::Cint
end

"""
    MPI_Win_lock(lock_type, rank, assert, win)

$(_doc_external(:MPI_Win_lock))
"""
function MPI_Win_lock(lock_type, rank, assert, win)
    @mpichk @ccall libmpi.MPI_Win_lock(lock_type::Cint, rank::Cint, assert::Cint, win::MPI_Win)::Cint
end

"""
    MPI_Win_lock_all(assert, win)

$(_doc_external(:MPI_Win_lock_all))
"""
function MPI_Win_lock_all(assert, win)
    @mpichk @ccall libmpi.MPI_Win_lock_all(assert::Cint, win::MPI_Win)::Cint
end

"""
    MPI_Win_post(group, assert, win)

$(_doc_external(:MPI_Win_post))
"""
function MPI_Win_post(group, assert, win)
    @mpichk @ccall libmpi.MPI_Win_post(group::MPI_Group, assert::Cint, win::MPI_Win)::Cint
end

"""
    MPI_Win_set_info(win, info)

$(_doc_external(:MPI_Win_set_info))
"""
function MPI_Win_set_info(win, info)
    @mpichk @ccall libmpi.MPI_Win_set_info(win::MPI_Win, info::MPI_Info)::Cint
end

"""
    MPI_Win_set_name(win, win_name)

$(_doc_external(:MPI_Win_set_name))
"""
function MPI_Win_set_name(win, win_name)
    @mpichk @ccall libmpi.MPI_Win_set_name(win::MPI_Win, win_name::Ptr{Cchar})::Cint
end

"""
    MPI_Win_shared_query(win, rank, size, disp_unit, baseptr)

$(_doc_external(:MPI_Win_shared_query))
"""
function MPI_Win_shared_query(win, rank, size, disp_unit, baseptr)
    @mpichk @ccall libmpi.MPI_Win_shared_query(win::MPI_Win, rank::Cint, size::Ptr{MPI_Aint}, disp_unit::Ptr{Cint}, baseptr::MPIPtr)::Cint
end

"""
    MPI_Win_start(group, assert, win)

$(_doc_external(:MPI_Win_start))
"""
function MPI_Win_start(group, assert, win)
    @mpichk @ccall libmpi.MPI_Win_start(group::MPI_Group, assert::Cint, win::MPI_Win)::Cint
end

"""
    MPI_Win_sync(win)

$(_doc_external(:MPI_Win_sync))
"""
function MPI_Win_sync(win)
    @mpichk @ccall libmpi.MPI_Win_sync(win::MPI_Win)::Cint
end

"""
    MPI_Win_test(win, flag)

$(_doc_external(:MPI_Win_test))
"""
function MPI_Win_test(win, flag)
    @mpichk @ccall libmpi.MPI_Win_test(win::MPI_Win, flag::Ptr{Cint})::Cint
end

"""
    MPI_Win_unlock(rank, win)

$(_doc_external(:MPI_Win_unlock))
"""
function MPI_Win_unlock(rank, win)
    @mpichk @ccall libmpi.MPI_Win_unlock(rank::Cint, win::MPI_Win)::Cint
end

"""
    MPI_Win_unlock_all(win)

$(_doc_external(:MPI_Win_unlock_all))
"""
function MPI_Win_unlock_all(win)
    @mpichk @ccall libmpi.MPI_Win_unlock_all(win::MPI_Win)::Cint
end

"""
    MPI_Win_wait(win)

$(_doc_external(:MPI_Win_wait))
"""
function MPI_Win_wait(win)
    @mpichk @ccall libmpi.MPI_Win_wait(win::MPI_Win)::Cint
end

"""
    MPI_Close_port(port_name)

$(_doc_external(:MPI_Close_port))
"""
function MPI_Close_port(port_name)
    @mpichk @ccall libmpi.MPI_Close_port(port_name::Ptr{Cchar})::Cint
end

"""
    MPI_Comm_accept(port_name, info, root, comm, newcomm)

$(_doc_external(:MPI_Comm_accept))
"""
function MPI_Comm_accept(port_name, info, root, comm, newcomm)
    @mpichk @ccall libmpi.MPI_Comm_accept(port_name::Ptr{Cchar}, info::MPI_Info, root::Cint, comm::MPI_Comm, newcomm::Ptr{MPI_Comm})::Cint
end

"""
    MPI_Comm_connect(port_name, info, root, comm, newcomm)

$(_doc_external(:MPI_Comm_connect))
"""
function MPI_Comm_connect(port_name, info, root, comm, newcomm)
    @mpichk @ccall libmpi.MPI_Comm_connect(port_name::Ptr{Cchar}, info::MPI_Info, root::Cint, comm::MPI_Comm, newcomm::Ptr{MPI_Comm})::Cint
end

"""
    MPI_Comm_disconnect(comm)

$(_doc_external(:MPI_Comm_disconnect))
"""
function MPI_Comm_disconnect(comm)
    @mpichk @ccall libmpi.MPI_Comm_disconnect(comm::Ptr{MPI_Comm})::Cint
end

"""
    MPI_Comm_get_parent(parent)

$(_doc_external(:MPI_Comm_get_parent))
"""
function MPI_Comm_get_parent(parent)
    @mpichk @ccall libmpi.MPI_Comm_get_parent(parent::Ptr{MPI_Comm})::Cint
end

"""
    MPI_Comm_join(fd, intercomm)

$(_doc_external(:MPI_Comm_join))
"""
function MPI_Comm_join(fd, intercomm)
    @mpichk @ccall libmpi.MPI_Comm_join(fd::Cint, intercomm::Ptr{MPI_Comm})::Cint
end

"""
    MPI_Comm_spawn(command, argv, maxprocs, info, root, comm, intercomm, array_of_errcodes)

$(_doc_external(:MPI_Comm_spawn))
"""
function MPI_Comm_spawn(command, argv, maxprocs, info, root, comm, intercomm, array_of_errcodes)
    @mpichk @ccall libmpi.MPI_Comm_spawn(command::Ptr{Cchar}, argv::Ptr{Ptr{Cchar}}, maxprocs::Cint, info::MPI_Info, root::Cint, comm::MPI_Comm, intercomm::Ptr{MPI_Comm}, array_of_errcodes::Ptr{Cint})::Cint
end

"""
    MPI_Comm_spawn_multiple(count, array_of_commands, array_of_argv, array_of_maxprocs, array_of_info, root, comm, intercomm, array_of_errcodes)

$(_doc_external(:MPI_Comm_spawn_multiple))
"""
function MPI_Comm_spawn_multiple(count, array_of_commands, array_of_argv, array_of_maxprocs, array_of_info, root, comm, intercomm, array_of_errcodes)
    @mpichk @ccall libmpi.MPI_Comm_spawn_multiple(count::Cint, array_of_commands::Ptr{Ptr{Cchar}}, array_of_argv::Ptr{Ptr{Ptr{Cchar}}}, array_of_maxprocs::Ptr{Cint}, array_of_info::Ptr{MPI_Info}, root::Cint, comm::MPI_Comm, intercomm::Ptr{MPI_Comm}, array_of_errcodes::Ptr{Cint})::Cint
end

"""
    MPI_Lookup_name(service_name, info, port_name)

$(_doc_external(:MPI_Lookup_name))
"""
function MPI_Lookup_name(service_name, info, port_name)
    @mpichk @ccall libmpi.MPI_Lookup_name(service_name::Ptr{Cchar}, info::MPI_Info, port_name::Ptr{Cchar})::Cint
end

"""
    MPI_Open_port(info, port_name)

$(_doc_external(:MPI_Open_port))
"""
function MPI_Open_port(info, port_name)
    @mpichk @ccall libmpi.MPI_Open_port(info::MPI_Info, port_name::Ptr{Cchar})::Cint
end

"""
    MPI_Publish_name(service_name, info, port_name)

$(_doc_external(:MPI_Publish_name))
"""
function MPI_Publish_name(service_name, info, port_name)
    @mpichk @ccall libmpi.MPI_Publish_name(service_name::Ptr{Cchar}, info::MPI_Info, port_name::Ptr{Cchar})::Cint
end

"""
    MPI_Unpublish_name(service_name, info, port_name)

$(_doc_external(:MPI_Unpublish_name))
"""
function MPI_Unpublish_name(service_name, info, port_name)
    @mpichk @ccall libmpi.MPI_Unpublish_name(service_name::Ptr{Cchar}, info::MPI_Info, port_name::Ptr{Cchar})::Cint
end

"""
    MPI_Wtick()

$(_doc_external(:MPI_Wtick))
"""
function MPI_Wtick()
    @mpichk @ccall libmpi.MPI_Wtick()::Cdouble
end

"""
    MPI_Wtime()

$(_doc_external(:MPI_Wtime))
"""
function MPI_Wtime()
    @mpichk @ccall libmpi.MPI_Wtime()::Cdouble
end

"""
    MPI_Cart_coords(comm, rank, maxdims, coords)

$(_doc_external(:MPI_Cart_coords))
"""
function MPI_Cart_coords(comm, rank, maxdims, coords)
    @mpichk @ccall libmpi.MPI_Cart_coords(comm::MPI_Comm, rank::Cint, maxdims::Cint, coords::Ptr{Cint})::Cint
end

"""
    MPI_Cart_create(comm_old, ndims, dims, periods, reorder, comm_cart)

$(_doc_external(:MPI_Cart_create))
"""
function MPI_Cart_create(comm_old, ndims, dims, periods, reorder, comm_cart)
    @mpichk @ccall libmpi.MPI_Cart_create(comm_old::MPI_Comm, ndims::Cint, dims::Ptr{Cint}, periods::Ptr{Cint}, reorder::Cint, comm_cart::Ptr{MPI_Comm})::Cint
end

"""
    MPI_Cart_get(comm, maxdims, dims, periods, coords)

$(_doc_external(:MPI_Cart_get))
"""
function MPI_Cart_get(comm, maxdims, dims, periods, coords)
    @mpichk @ccall libmpi.MPI_Cart_get(comm::MPI_Comm, maxdims::Cint, dims::Ptr{Cint}, periods::Ptr{Cint}, coords::Ptr{Cint})::Cint
end

"""
    MPI_Cart_map(comm, ndims, dims, periods, newrank)

$(_doc_external(:MPI_Cart_map))
"""
function MPI_Cart_map(comm, ndims, dims, periods, newrank)
    @mpichk @ccall libmpi.MPI_Cart_map(comm::MPI_Comm, ndims::Cint, dims::Ptr{Cint}, periods::Ptr{Cint}, newrank::Ptr{Cint})::Cint
end

"""
    MPI_Cart_rank(comm, coords, rank)

$(_doc_external(:MPI_Cart_rank))
"""
function MPI_Cart_rank(comm, coords, rank)
    @mpichk @ccall libmpi.MPI_Cart_rank(comm::MPI_Comm, coords::Ptr{Cint}, rank::Ptr{Cint})::Cint
end

"""
    MPI_Cart_shift(comm, direction, disp, rank_source, rank_dest)

$(_doc_external(:MPI_Cart_shift))
"""
function MPI_Cart_shift(comm, direction, disp, rank_source, rank_dest)
    @mpichk @ccall libmpi.MPI_Cart_shift(comm::MPI_Comm, direction::Cint, disp::Cint, rank_source::Ptr{Cint}, rank_dest::Ptr{Cint})::Cint
end

"""
    MPI_Cart_sub(comm, remain_dims, newcomm)

$(_doc_external(:MPI_Cart_sub))
"""
function MPI_Cart_sub(comm, remain_dims, newcomm)
    @mpichk @ccall libmpi.MPI_Cart_sub(comm::MPI_Comm, remain_dims::Ptr{Cint}, newcomm::Ptr{MPI_Comm})::Cint
end

"""
    MPI_Cartdim_get(comm, ndims)

$(_doc_external(:MPI_Cartdim_get))
"""
function MPI_Cartdim_get(comm, ndims)
    @mpichk @ccall libmpi.MPI_Cartdim_get(comm::MPI_Comm, ndims::Ptr{Cint})::Cint
end

"""
    MPI_Dims_create(nnodes, ndims, dims)

$(_doc_external(:MPI_Dims_create))
"""
function MPI_Dims_create(nnodes, ndims, dims)
    @mpichk @ccall libmpi.MPI_Dims_create(nnodes::Cint, ndims::Cint, dims::Ptr{Cint})::Cint
end

"""
    MPI_Dist_graph_create(comm_old, n, sources, degrees, destinations, weights, info, reorder, comm_dist_graph)

$(_doc_external(:MPI_Dist_graph_create))
"""
function MPI_Dist_graph_create(comm_old, n, sources, degrees, destinations, weights, info, reorder, comm_dist_graph)
    @mpichk @ccall libmpi.MPI_Dist_graph_create(comm_old::MPI_Comm, n::Cint, sources::Ptr{Cint}, degrees::Ptr{Cint}, destinations::Ptr{Cint}, weights::Ptr{Cint}, info::MPI_Info, reorder::Cint, comm_dist_graph::Ptr{MPI_Comm})::Cint
end

"""
    MPI_Dist_graph_create_adjacent(comm_old, indegree, sources, sourceweights, outdegree, destinations, destweights, info, reorder, comm_dist_graph)

$(_doc_external(:MPI_Dist_graph_create_adjacent))
"""
function MPI_Dist_graph_create_adjacent(comm_old, indegree, sources, sourceweights, outdegree, destinations, destweights, info, reorder, comm_dist_graph)
    @mpichk @ccall libmpi.MPI_Dist_graph_create_adjacent(comm_old::MPI_Comm, indegree::Cint, sources::Ptr{Cint}, sourceweights::Ptr{Cint}, outdegree::Cint, destinations::Ptr{Cint}, destweights::Ptr{Cint}, info::MPI_Info, reorder::Cint, comm_dist_graph::Ptr{MPI_Comm})::Cint
end

"""
    MPI_Dist_graph_neighbors(comm, maxindegree, sources, sourceweights, maxoutdegree, destinations, destweights)

$(_doc_external(:MPI_Dist_graph_neighbors))
"""
function MPI_Dist_graph_neighbors(comm, maxindegree, sources, sourceweights, maxoutdegree, destinations, destweights)
    @mpichk @ccall libmpi.MPI_Dist_graph_neighbors(comm::MPI_Comm, maxindegree::Cint, sources::Ptr{Cint}, sourceweights::Ptr{Cint}, maxoutdegree::Cint, destinations::Ptr{Cint}, destweights::Ptr{Cint})::Cint
end

"""
    MPI_Dist_graph_neighbors_count(comm, indegree, outdegree, weighted)

$(_doc_external(:MPI_Dist_graph_neighbors_count))
"""
function MPI_Dist_graph_neighbors_count(comm, indegree, outdegree, weighted)
    @mpichk @ccall libmpi.MPI_Dist_graph_neighbors_count(comm::MPI_Comm, indegree::Ptr{Cint}, outdegree::Ptr{Cint}, weighted::Ptr{Cint})::Cint
end

"""
    MPI_Graph_create(comm_old, nnodes, indx, edges, reorder, comm_graph)

$(_doc_external(:MPI_Graph_create))
"""
function MPI_Graph_create(comm_old, nnodes, indx, edges, reorder, comm_graph)
    @mpichk @ccall libmpi.MPI_Graph_create(comm_old::MPI_Comm, nnodes::Cint, indx::Ptr{Cint}, edges::Ptr{Cint}, reorder::Cint, comm_graph::Ptr{MPI_Comm})::Cint
end

"""
    MPI_Graph_get(comm, maxindex, maxedges, indx, edges)

$(_doc_external(:MPI_Graph_get))
"""
function MPI_Graph_get(comm, maxindex, maxedges, indx, edges)
    @mpichk @ccall libmpi.MPI_Graph_get(comm::MPI_Comm, maxindex::Cint, maxedges::Cint, indx::Ptr{Cint}, edges::Ptr{Cint})::Cint
end

"""
    MPI_Graph_map(comm, nnodes, indx, edges, newrank)

$(_doc_external(:MPI_Graph_map))
"""
function MPI_Graph_map(comm, nnodes, indx, edges, newrank)
    @mpichk @ccall libmpi.MPI_Graph_map(comm::MPI_Comm, nnodes::Cint, indx::Ptr{Cint}, edges::Ptr{Cint}, newrank::Ptr{Cint})::Cint
end

"""
    MPI_Graph_neighbors(comm, rank, maxneighbors, neighbors)

$(_doc_external(:MPI_Graph_neighbors))
"""
function MPI_Graph_neighbors(comm, rank, maxneighbors, neighbors)
    @mpichk @ccall libmpi.MPI_Graph_neighbors(comm::MPI_Comm, rank::Cint, maxneighbors::Cint, neighbors::Ptr{Cint})::Cint
end

"""
    MPI_Graph_neighbors_count(comm, rank, nneighbors)

$(_doc_external(:MPI_Graph_neighbors_count))
"""
function MPI_Graph_neighbors_count(comm, rank, nneighbors)
    @mpichk @ccall libmpi.MPI_Graph_neighbors_count(comm::MPI_Comm, rank::Cint, nneighbors::Ptr{Cint})::Cint
end

"""
    MPI_Graphdims_get(comm, nnodes, nedges)

$(_doc_external(:MPI_Graphdims_get))
"""
function MPI_Graphdims_get(comm, nnodes, nedges)
    @mpichk @ccall libmpi.MPI_Graphdims_get(comm::MPI_Comm, nnodes::Ptr{Cint}, nedges::Ptr{Cint})::Cint
end

"""
    MPI_Topo_test(comm, status)

$(_doc_external(:MPI_Topo_test))
"""
function MPI_Topo_test(comm, status)
    @mpichk @ccall libmpi.MPI_Topo_test(comm::MPI_Comm, status::Ptr{Cint})::Cint
end

"""
    MPI_Allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:MPI_Allgather_c))
"""
function MPI_Allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk @ccall libmpi.MPI_Allgather_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::MPI_Count, recvtype::MPI_Datatype, comm::MPI_Comm)::Cint
end

"""
    MPI_Allgather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:MPI_Allgather_init_c))
"""
function MPI_Allgather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk @ccall libmpi.MPI_Allgather_init_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::MPI_Count, recvtype::MPI_Datatype, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)

$(_doc_external(:MPI_Allgatherv_c))
"""
function MPI_Allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    @mpichk @ccall libmpi.MPI_Allgatherv_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{MPI_Count}, displs::Ptr{MPI_Aint}, recvtype::MPI_Datatype, comm::MPI_Comm)::Cint
end

"""
    MPI_Allgatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)

$(_doc_external(:MPI_Allgatherv_init_c))
"""
function MPI_Allgatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    @mpichk @ccall libmpi.MPI_Allgatherv_init_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{MPI_Count}, displs::Ptr{MPI_Aint}, recvtype::MPI_Datatype, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Allreduce_c(sendbuf, recvbuf, count, datatype, op, comm)

$(_doc_external(:MPI_Allreduce_c))
"""
function MPI_Allreduce_c(sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk @ccall libmpi.MPI_Allreduce_c(sendbuf::MPIPtr, recvbuf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm)::Cint
end

"""
    MPI_Allreduce_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)

$(_doc_external(:MPI_Allreduce_init_c))
"""
function MPI_Allreduce_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk @ccall libmpi.MPI_Allreduce_init_c(sendbuf::MPIPtr, recvbuf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:MPI_Alltoall_c))
"""
function MPI_Alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk @ccall libmpi.MPI_Alltoall_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::MPI_Count, recvtype::MPI_Datatype, comm::MPI_Comm)::Cint
end

"""
    MPI_Alltoall_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:MPI_Alltoall_init_c))
"""
function MPI_Alltoall_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk @ccall libmpi.MPI_Alltoall_init_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::MPI_Count, recvtype::MPI_Datatype, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)

$(_doc_external(:MPI_Alltoallv_c))
"""
function MPI_Alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    @mpichk @ccall libmpi.MPI_Alltoallv_c(sendbuf::MPIPtr, sendcounts::Ptr{MPI_Count}, sdispls::Ptr{MPI_Aint}, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{MPI_Count}, rdispls::Ptr{MPI_Aint}, recvtype::MPI_Datatype, comm::MPI_Comm)::Cint
end

"""
    MPI_Alltoallv_init_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)

$(_doc_external(:MPI_Alltoallv_init_c))
"""
function MPI_Alltoallv_init_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    @mpichk @ccall libmpi.MPI_Alltoallv_init_c(sendbuf::MPIPtr, sendcounts::Ptr{MPI_Count}, sdispls::Ptr{MPI_Aint}, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{MPI_Count}, rdispls::Ptr{MPI_Aint}, recvtype::MPI_Datatype, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)

$(_doc_external(:MPI_Alltoallw_c))
"""
function MPI_Alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    @mpichk @ccall libmpi.MPI_Alltoallw_c(sendbuf::MPIPtr, sendcounts::Ptr{MPI_Count}, sdispls::Ptr{MPI_Aint}, sendtypes::Ptr{MPI_Datatype}, recvbuf::MPIPtr, recvcounts::Ptr{MPI_Count}, rdispls::Ptr{MPI_Aint}, recvtypes::Ptr{MPI_Datatype}, comm::MPI_Comm)::Cint
end

"""
    MPI_Alltoallw_init_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)

$(_doc_external(:MPI_Alltoallw_init_c))
"""
function MPI_Alltoallw_init_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    @mpichk @ccall libmpi.MPI_Alltoallw_init_c(sendbuf::MPIPtr, sendcounts::Ptr{MPI_Count}, sdispls::Ptr{MPI_Aint}, sendtypes::Ptr{MPI_Datatype}, recvbuf::MPIPtr, recvcounts::Ptr{MPI_Count}, rdispls::Ptr{MPI_Aint}, recvtypes::Ptr{MPI_Datatype}, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Bcast_c(buffer, count, datatype, root, comm)

$(_doc_external(:MPI_Bcast_c))
"""
function MPI_Bcast_c(buffer, count, datatype, root, comm)
    @mpichk @ccall libmpi.MPI_Bcast_c(buffer::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, root::Cint, comm::MPI_Comm)::Cint
end

"""
    MPI_Bcast_init_c(buffer, count, datatype, root, comm, info, request)

$(_doc_external(:MPI_Bcast_init_c))
"""
function MPI_Bcast_init_c(buffer, count, datatype, root, comm, info, request)
    @mpichk @ccall libmpi.MPI_Bcast_init_c(buffer::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, root::Cint, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Exscan_c(sendbuf, recvbuf, count, datatype, op, comm)

$(_doc_external(:MPI_Exscan_c))
"""
function MPI_Exscan_c(sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk @ccall libmpi.MPI_Exscan_c(sendbuf::MPIPtr, recvbuf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm)::Cint
end

"""
    MPI_Exscan_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)

$(_doc_external(:MPI_Exscan_init_c))
"""
function MPI_Exscan_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk @ccall libmpi.MPI_Exscan_init_c(sendbuf::MPIPtr, recvbuf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Gather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)

$(_doc_external(:MPI_Gather_c))
"""
function MPI_Gather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk @ccall libmpi.MPI_Gather_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::MPI_Count, recvtype::MPI_Datatype, root::Cint, comm::MPI_Comm)::Cint
end

"""
    MPI_Gather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

$(_doc_external(:MPI_Gather_init_c))
"""
function MPI_Gather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk @ccall libmpi.MPI_Gather_init_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::MPI_Count, recvtype::MPI_Datatype, root::Cint, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Gatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)

$(_doc_external(:MPI_Gatherv_c))
"""
function MPI_Gatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm)
    @mpichk @ccall libmpi.MPI_Gatherv_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{MPI_Count}, displs::Ptr{MPI_Aint}, recvtype::MPI_Datatype, root::Cint, comm::MPI_Comm)::Cint
end

"""
    MPI_Gatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)

$(_doc_external(:MPI_Gatherv_init_c))
"""
function MPI_Gatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, info, request)
    @mpichk @ccall libmpi.MPI_Gatherv_init_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{MPI_Count}, displs::Ptr{MPI_Aint}, recvtype::MPI_Datatype, root::Cint, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Iallgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:MPI_Iallgather_c))
"""
function MPI_Iallgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk @ccall libmpi.MPI_Iallgather_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::MPI_Count, recvtype::MPI_Datatype, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Iallgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)

$(_doc_external(:MPI_Iallgatherv_c))
"""
function MPI_Iallgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    @mpichk @ccall libmpi.MPI_Iallgatherv_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{MPI_Count}, displs::Ptr{MPI_Aint}, recvtype::MPI_Datatype, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Iallreduce_c(sendbuf, recvbuf, count, datatype, op, comm, request)

$(_doc_external(:MPI_Iallreduce_c))
"""
function MPI_Iallreduce_c(sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk @ccall libmpi.MPI_Iallreduce_c(sendbuf::MPIPtr, recvbuf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Ialltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:MPI_Ialltoall_c))
"""
function MPI_Ialltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk @ccall libmpi.MPI_Ialltoall_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::MPI_Count, recvtype::MPI_Datatype, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Ialltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)

$(_doc_external(:MPI_Ialltoallv_c))
"""
function MPI_Ialltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    @mpichk @ccall libmpi.MPI_Ialltoallv_c(sendbuf::MPIPtr, sendcounts::Ptr{MPI_Count}, sdispls::Ptr{MPI_Aint}, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{MPI_Count}, rdispls::Ptr{MPI_Aint}, recvtype::MPI_Datatype, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Ialltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)

$(_doc_external(:MPI_Ialltoallw_c))
"""
function MPI_Ialltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    @mpichk @ccall libmpi.MPI_Ialltoallw_c(sendbuf::MPIPtr, sendcounts::Ptr{MPI_Count}, sdispls::Ptr{MPI_Aint}, sendtypes::Ptr{MPI_Datatype}, recvbuf::MPIPtr, recvcounts::Ptr{MPI_Count}, rdispls::Ptr{MPI_Aint}, recvtypes::Ptr{MPI_Datatype}, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Ibcast_c(buffer, count, datatype, root, comm, request)

$(_doc_external(:MPI_Ibcast_c))
"""
function MPI_Ibcast_c(buffer, count, datatype, root, comm, request)
    @mpichk @ccall libmpi.MPI_Ibcast_c(buffer::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, root::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Iexscan_c(sendbuf, recvbuf, count, datatype, op, comm, request)

$(_doc_external(:MPI_Iexscan_c))
"""
function MPI_Iexscan_c(sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk @ccall libmpi.MPI_Iexscan_c(sendbuf::MPIPtr, recvbuf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Igather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

$(_doc_external(:MPI_Igather_c))
"""
function MPI_Igather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk @ccall libmpi.MPI_Igather_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::MPI_Count, recvtype::MPI_Datatype, root::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Igatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)

$(_doc_external(:MPI_Igatherv_c))
"""
function MPI_Igatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, root, comm, request)
    @mpichk @ccall libmpi.MPI_Igatherv_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{MPI_Count}, displs::Ptr{MPI_Aint}, recvtype::MPI_Datatype, root::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Ineighbor_allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:MPI_Ineighbor_allgather_c))
"""
function MPI_Ineighbor_allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk @ccall libmpi.MPI_Ineighbor_allgather_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::MPI_Count, recvtype::MPI_Datatype, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Ineighbor_allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)

$(_doc_external(:MPI_Ineighbor_allgatherv_c))
"""
function MPI_Ineighbor_allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, request)
    @mpichk @ccall libmpi.MPI_Ineighbor_allgatherv_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{MPI_Count}, displs::Ptr{MPI_Aint}, recvtype::MPI_Datatype, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Ineighbor_alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)

$(_doc_external(:MPI_Ineighbor_alltoall_c))
"""
function MPI_Ineighbor_alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, request)
    @mpichk @ccall libmpi.MPI_Ineighbor_alltoall_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::MPI_Count, recvtype::MPI_Datatype, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Ineighbor_alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)

$(_doc_external(:MPI_Ineighbor_alltoallv_c))
"""
function MPI_Ineighbor_alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, request)
    @mpichk @ccall libmpi.MPI_Ineighbor_alltoallv_c(sendbuf::MPIPtr, sendcounts::Ptr{MPI_Count}, sdispls::Ptr{MPI_Aint}, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{MPI_Count}, rdispls::Ptr{MPI_Aint}, recvtype::MPI_Datatype, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Ineighbor_alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)

$(_doc_external(:MPI_Ineighbor_alltoallw_c))
"""
function MPI_Ineighbor_alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, request)
    @mpichk @ccall libmpi.MPI_Ineighbor_alltoallw_c(sendbuf::MPIPtr, sendcounts::Ptr{MPI_Count}, sdispls::Ptr{MPI_Aint}, sendtypes::Ptr{MPI_Datatype}, recvbuf::MPIPtr, recvcounts::Ptr{MPI_Count}, rdispls::Ptr{MPI_Aint}, recvtypes::Ptr{MPI_Datatype}, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Ireduce_c(sendbuf, recvbuf, count, datatype, op, root, comm, request)

$(_doc_external(:MPI_Ireduce_c))
"""
function MPI_Ireduce_c(sendbuf, recvbuf, count, datatype, op, root, comm, request)
    @mpichk @ccall libmpi.MPI_Ireduce_c(sendbuf::MPIPtr, recvbuf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, op::MPI_Op, root::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Ireduce_scatter_c(sendbuf, recvbuf, recvcounts, datatype, op, comm, request)

$(_doc_external(:MPI_Ireduce_scatter_c))
"""
function MPI_Ireduce_scatter_c(sendbuf, recvbuf, recvcounts, datatype, op, comm, request)
    @mpichk @ccall libmpi.MPI_Ireduce_scatter_c(sendbuf::MPIPtr, recvbuf::MPIPtr, recvcounts::Ptr{MPI_Count}, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Ireduce_scatter_block_c(sendbuf, recvbuf, recvcount, datatype, op, comm, request)

$(_doc_external(:MPI_Ireduce_scatter_block_c))
"""
function MPI_Ireduce_scatter_block_c(sendbuf, recvbuf, recvcount, datatype, op, comm, request)
    @mpichk @ccall libmpi.MPI_Ireduce_scatter_block_c(sendbuf::MPIPtr, recvbuf::MPIPtr, recvcount::MPI_Count, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Iscan_c(sendbuf, recvbuf, count, datatype, op, comm, request)

$(_doc_external(:MPI_Iscan_c))
"""
function MPI_Iscan_c(sendbuf, recvbuf, count, datatype, op, comm, request)
    @mpichk @ccall libmpi.MPI_Iscan_c(sendbuf::MPIPtr, recvbuf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Iscatter_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

$(_doc_external(:MPI_Iscatter_c))
"""
function MPI_Iscatter_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk @ccall libmpi.MPI_Iscatter_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::MPI_Count, recvtype::MPI_Datatype, root::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Iscatterv_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)

$(_doc_external(:MPI_Iscatterv_c))
"""
function MPI_Iscatterv_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, request)
    @mpichk @ccall libmpi.MPI_Iscatterv_c(sendbuf::MPIPtr, sendcounts::Ptr{MPI_Count}, displs::Ptr{MPI_Aint}, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::MPI_Count, recvtype::MPI_Datatype, root::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Neighbor_allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:MPI_Neighbor_allgather_c))
"""
function MPI_Neighbor_allgather_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk @ccall libmpi.MPI_Neighbor_allgather_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::MPI_Count, recvtype::MPI_Datatype, comm::MPI_Comm)::Cint
end

"""
    MPI_Neighbor_allgather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:MPI_Neighbor_allgather_init_c))
"""
function MPI_Neighbor_allgather_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk @ccall libmpi.MPI_Neighbor_allgather_init_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::MPI_Count, recvtype::MPI_Datatype, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Neighbor_allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)

$(_doc_external(:MPI_Neighbor_allgatherv_c))
"""
function MPI_Neighbor_allgatherv_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm)
    @mpichk @ccall libmpi.MPI_Neighbor_allgatherv_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{MPI_Count}, displs::Ptr{MPI_Aint}, recvtype::MPI_Datatype, comm::MPI_Comm)::Cint
end

"""
    MPI_Neighbor_allgatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)

$(_doc_external(:MPI_Neighbor_allgatherv_init_c))
"""
function MPI_Neighbor_allgatherv_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcounts, displs, recvtype, comm, info, request)
    @mpichk @ccall libmpi.MPI_Neighbor_allgatherv_init_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{MPI_Count}, displs::Ptr{MPI_Aint}, recvtype::MPI_Datatype, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Neighbor_alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)

$(_doc_external(:MPI_Neighbor_alltoall_c))
"""
function MPI_Neighbor_alltoall_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm)
    @mpichk @ccall libmpi.MPI_Neighbor_alltoall_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::MPI_Count, recvtype::MPI_Datatype, comm::MPI_Comm)::Cint
end

"""
    MPI_Neighbor_alltoall_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)

$(_doc_external(:MPI_Neighbor_alltoall_init_c))
"""
function MPI_Neighbor_alltoall_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm, info, request)
    @mpichk @ccall libmpi.MPI_Neighbor_alltoall_init_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::MPI_Count, recvtype::MPI_Datatype, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Neighbor_alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)

$(_doc_external(:MPI_Neighbor_alltoallv_c))
"""
function MPI_Neighbor_alltoallv_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm)
    @mpichk @ccall libmpi.MPI_Neighbor_alltoallv_c(sendbuf::MPIPtr, sendcounts::Ptr{MPI_Count}, sdispls::Ptr{MPI_Aint}, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{MPI_Count}, rdispls::Ptr{MPI_Aint}, recvtype::MPI_Datatype, comm::MPI_Comm)::Cint
end

"""
    MPI_Neighbor_alltoallv_init_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)

$(_doc_external(:MPI_Neighbor_alltoallv_init_c))
"""
function MPI_Neighbor_alltoallv_init_c(sendbuf, sendcounts, sdispls, sendtype, recvbuf, recvcounts, rdispls, recvtype, comm, info, request)
    @mpichk @ccall libmpi.MPI_Neighbor_alltoallv_init_c(sendbuf::MPIPtr, sendcounts::Ptr{MPI_Count}, sdispls::Ptr{MPI_Aint}, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcounts::Ptr{MPI_Count}, rdispls::Ptr{MPI_Aint}, recvtype::MPI_Datatype, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Neighbor_alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)

$(_doc_external(:MPI_Neighbor_alltoallw_c))
"""
function MPI_Neighbor_alltoallw_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm)
    @mpichk @ccall libmpi.MPI_Neighbor_alltoallw_c(sendbuf::MPIPtr, sendcounts::Ptr{MPI_Count}, sdispls::Ptr{MPI_Aint}, sendtypes::Ptr{MPI_Datatype}, recvbuf::MPIPtr, recvcounts::Ptr{MPI_Count}, rdispls::Ptr{MPI_Aint}, recvtypes::Ptr{MPI_Datatype}, comm::MPI_Comm)::Cint
end

"""
    MPI_Neighbor_alltoallw_init_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)

$(_doc_external(:MPI_Neighbor_alltoallw_init_c))
"""
function MPI_Neighbor_alltoallw_init_c(sendbuf, sendcounts, sdispls, sendtypes, recvbuf, recvcounts, rdispls, recvtypes, comm, info, request)
    @mpichk @ccall libmpi.MPI_Neighbor_alltoallw_init_c(sendbuf::MPIPtr, sendcounts::Ptr{MPI_Count}, sdispls::Ptr{MPI_Aint}, sendtypes::Ptr{MPI_Datatype}, recvbuf::MPIPtr, recvcounts::Ptr{MPI_Count}, rdispls::Ptr{MPI_Aint}, recvtypes::Ptr{MPI_Datatype}, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Reduce_c(sendbuf, recvbuf, count, datatype, op, root, comm)

$(_doc_external(:MPI_Reduce_c))
"""
function MPI_Reduce_c(sendbuf, recvbuf, count, datatype, op, root, comm)
    @mpichk @ccall libmpi.MPI_Reduce_c(sendbuf::MPIPtr, recvbuf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, op::MPI_Op, root::Cint, comm::MPI_Comm)::Cint
end

"""
    MPI_Reduce_init_c(sendbuf, recvbuf, count, datatype, op, root, comm, info, request)

$(_doc_external(:MPI_Reduce_init_c))
"""
function MPI_Reduce_init_c(sendbuf, recvbuf, count, datatype, op, root, comm, info, request)
    @mpichk @ccall libmpi.MPI_Reduce_init_c(sendbuf::MPIPtr, recvbuf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, op::MPI_Op, root::Cint, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Reduce_local_c(inbuf, inoutbuf, count, datatype, op)

$(_doc_external(:MPI_Reduce_local_c))
"""
function MPI_Reduce_local_c(inbuf, inoutbuf, count, datatype, op)
    @mpichk @ccall libmpi.MPI_Reduce_local_c(inbuf::MPIPtr, inoutbuf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, op::MPI_Op)::Cint
end

"""
    MPI_Reduce_scatter_c(sendbuf, recvbuf, recvcounts, datatype, op, comm)

$(_doc_external(:MPI_Reduce_scatter_c))
"""
function MPI_Reduce_scatter_c(sendbuf, recvbuf, recvcounts, datatype, op, comm)
    @mpichk @ccall libmpi.MPI_Reduce_scatter_c(sendbuf::MPIPtr, recvbuf::MPIPtr, recvcounts::Ptr{MPI_Count}, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm)::Cint
end

"""
    MPI_Reduce_scatter_block_c(sendbuf, recvbuf, recvcount, datatype, op, comm)

$(_doc_external(:MPI_Reduce_scatter_block_c))
"""
function MPI_Reduce_scatter_block_c(sendbuf, recvbuf, recvcount, datatype, op, comm)
    @mpichk @ccall libmpi.MPI_Reduce_scatter_block_c(sendbuf::MPIPtr, recvbuf::MPIPtr, recvcount::MPI_Count, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm)::Cint
end

"""
    MPI_Reduce_scatter_block_init_c(sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)

$(_doc_external(:MPI_Reduce_scatter_block_init_c))
"""
function MPI_Reduce_scatter_block_init_c(sendbuf, recvbuf, recvcount, datatype, op, comm, info, request)
    @mpichk @ccall libmpi.MPI_Reduce_scatter_block_init_c(sendbuf::MPIPtr, recvbuf::MPIPtr, recvcount::MPI_Count, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Reduce_scatter_init_c(sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)

$(_doc_external(:MPI_Reduce_scatter_init_c))
"""
function MPI_Reduce_scatter_init_c(sendbuf, recvbuf, recvcounts, datatype, op, comm, info, request)
    @mpichk @ccall libmpi.MPI_Reduce_scatter_init_c(sendbuf::MPIPtr, recvbuf::MPIPtr, recvcounts::Ptr{MPI_Count}, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Scan_c(sendbuf, recvbuf, count, datatype, op, comm)

$(_doc_external(:MPI_Scan_c))
"""
function MPI_Scan_c(sendbuf, recvbuf, count, datatype, op, comm)
    @mpichk @ccall libmpi.MPI_Scan_c(sendbuf::MPIPtr, recvbuf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm)::Cint
end

"""
    MPI_Scan_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)

$(_doc_external(:MPI_Scan_init_c))
"""
function MPI_Scan_init_c(sendbuf, recvbuf, count, datatype, op, comm, info, request)
    @mpichk @ccall libmpi.MPI_Scan_init_c(sendbuf::MPIPtr, recvbuf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, op::MPI_Op, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Scatter_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)

$(_doc_external(:MPI_Scatter_c))
"""
function MPI_Scatter_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk @ccall libmpi.MPI_Scatter_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::MPI_Count, recvtype::MPI_Datatype, root::Cint, comm::MPI_Comm)::Cint
end

"""
    MPI_Scatter_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

$(_doc_external(:MPI_Scatter_init_c))
"""
function MPI_Scatter_init_c(sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk @ccall libmpi.MPI_Scatter_init_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::MPI_Count, recvtype::MPI_Datatype, root::Cint, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Scatterv_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)

$(_doc_external(:MPI_Scatterv_c))
"""
function MPI_Scatterv_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm)
    @mpichk @ccall libmpi.MPI_Scatterv_c(sendbuf::MPIPtr, sendcounts::Ptr{MPI_Count}, displs::Ptr{MPI_Aint}, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::MPI_Count, recvtype::MPI_Datatype, root::Cint, comm::MPI_Comm)::Cint
end

"""
    MPI_Scatterv_init_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)

$(_doc_external(:MPI_Scatterv_init_c))
"""
function MPI_Scatterv_init_c(sendbuf, sendcounts, displs, sendtype, recvbuf, recvcount, recvtype, root, comm, info, request)
    @mpichk @ccall libmpi.MPI_Scatterv_init_c(sendbuf::MPIPtr, sendcounts::Ptr{MPI_Count}, displs::Ptr{MPI_Aint}, sendtype::MPI_Datatype, recvbuf::MPIPtr, recvcount::MPI_Count, recvtype::MPI_Datatype, root::Cint, comm::MPI_Comm, info::MPI_Info, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Get_count_c(status, datatype, count)

$(_doc_external(:MPI_Get_count_c))
"""
function MPI_Get_count_c(status, datatype, count)
    @mpichk @ccall libmpi.MPI_Get_count_c(status::Ptr{MPI_Status}, datatype::MPI_Datatype, count::Ptr{MPI_Count})::Cint
end

"""
    MPI_Get_elements_c(status, datatype, count)

$(_doc_external(:MPI_Get_elements_c))
"""
function MPI_Get_elements_c(status, datatype, count)
    @mpichk @ccall libmpi.MPI_Get_elements_c(status::Ptr{MPI_Status}, datatype::MPI_Datatype, count::Ptr{MPI_Count})::Cint
end

"""
    MPI_Pack_c(inbuf, incount, datatype, outbuf, outsize, position, comm)

$(_doc_external(:MPI_Pack_c))
"""
function MPI_Pack_c(inbuf, incount, datatype, outbuf, outsize, position, comm)
    @mpichk @ccall libmpi.MPI_Pack_c(inbuf::MPIPtr, incount::MPI_Count, datatype::MPI_Datatype, outbuf::MPIPtr, outsize::MPI_Count, position::Ptr{MPI_Count}, comm::MPI_Comm)::Cint
end

"""
    MPI_Pack_external_c(datarep, inbuf, incount, datatype, outbuf, outsize, position)

$(_doc_external(:MPI_Pack_external_c))
"""
function MPI_Pack_external_c(datarep, inbuf, incount, datatype, outbuf, outsize, position)
    @mpichk @ccall libmpi.MPI_Pack_external_c(datarep::Ptr{Cchar}, inbuf::MPIPtr, incount::MPI_Count, datatype::MPI_Datatype, outbuf::MPIPtr, outsize::MPI_Count, position::Ptr{MPI_Count})::Cint
end

"""
    MPI_Pack_external_size_c(datarep, incount, datatype, size)

$(_doc_external(:MPI_Pack_external_size_c))
"""
function MPI_Pack_external_size_c(datarep, incount, datatype, size)
    @mpichk @ccall libmpi.MPI_Pack_external_size_c(datarep::Ptr{Cchar}, incount::MPI_Count, datatype::MPI_Datatype, size::Ptr{MPI_Count})::Cint
end

"""
    MPI_Pack_size_c(incount, datatype, comm, size)

$(_doc_external(:MPI_Pack_size_c))
"""
function MPI_Pack_size_c(incount, datatype, comm, size)
    @mpichk @ccall libmpi.MPI_Pack_size_c(incount::MPI_Count, datatype::MPI_Datatype, comm::MPI_Comm, size::Ptr{MPI_Count})::Cint
end

"""
    MPI_Type_contiguous_c(count, oldtype, newtype)

$(_doc_external(:MPI_Type_contiguous_c))
"""
function MPI_Type_contiguous_c(count, oldtype, newtype)
    @mpichk @ccall libmpi.MPI_Type_contiguous_c(count::MPI_Count, oldtype::MPI_Datatype, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_create_darray_c(size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)

$(_doc_external(:MPI_Type_create_darray_c))
"""
function MPI_Type_create_darray_c(size, rank, ndims, array_of_gsizes, array_of_distribs, array_of_dargs, array_of_psizes, order, oldtype, newtype)
    @mpichk @ccall libmpi.MPI_Type_create_darray_c(size::Cint, rank::Cint, ndims::Cint, array_of_gsizes::Ptr{MPI_Count}, array_of_distribs::Ptr{Cint}, array_of_dargs::Ptr{Cint}, array_of_psizes::Ptr{Cint}, order::Cint, oldtype::MPI_Datatype, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_create_hindexed_c(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)

$(_doc_external(:MPI_Type_create_hindexed_c))
"""
function MPI_Type_create_hindexed_c(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    @mpichk @ccall libmpi.MPI_Type_create_hindexed_c(count::MPI_Count, array_of_blocklengths::Ptr{MPI_Count}, array_of_displacements::Ptr{MPI_Count}, oldtype::MPI_Datatype, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_create_hindexed_block_c(count, blocklength, array_of_displacements, oldtype, newtype)

$(_doc_external(:MPI_Type_create_hindexed_block_c))
"""
function MPI_Type_create_hindexed_block_c(count, blocklength, array_of_displacements, oldtype, newtype)
    @mpichk @ccall libmpi.MPI_Type_create_hindexed_block_c(count::MPI_Count, blocklength::MPI_Count, array_of_displacements::Ptr{MPI_Count}, oldtype::MPI_Datatype, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_create_hvector_c(count, blocklength, stride, oldtype, newtype)

$(_doc_external(:MPI_Type_create_hvector_c))
"""
function MPI_Type_create_hvector_c(count, blocklength, stride, oldtype, newtype)
    @mpichk @ccall libmpi.MPI_Type_create_hvector_c(count::MPI_Count, blocklength::MPI_Count, stride::MPI_Count, oldtype::MPI_Datatype, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_create_indexed_block_c(count, blocklength, array_of_displacements, oldtype, newtype)

$(_doc_external(:MPI_Type_create_indexed_block_c))
"""
function MPI_Type_create_indexed_block_c(count, blocklength, array_of_displacements, oldtype, newtype)
    @mpichk @ccall libmpi.MPI_Type_create_indexed_block_c(count::MPI_Count, blocklength::MPI_Count, array_of_displacements::Ptr{MPI_Count}, oldtype::MPI_Datatype, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_create_resized_c(oldtype, lb, extent, newtype)

$(_doc_external(:MPI_Type_create_resized_c))
"""
function MPI_Type_create_resized_c(oldtype, lb, extent, newtype)
    @mpichk @ccall libmpi.MPI_Type_create_resized_c(oldtype::MPI_Datatype, lb::MPI_Count, extent::MPI_Count, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_create_struct_c(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)

$(_doc_external(:MPI_Type_create_struct_c))
"""
function MPI_Type_create_struct_c(count, array_of_blocklengths, array_of_displacements, array_of_types, newtype)
    @mpichk @ccall libmpi.MPI_Type_create_struct_c(count::MPI_Count, array_of_blocklengths::Ptr{MPI_Count}, array_of_displacements::Ptr{MPI_Count}, array_of_types::Ptr{MPI_Datatype}, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_create_subarray_c(ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)

$(_doc_external(:MPI_Type_create_subarray_c))
"""
function MPI_Type_create_subarray_c(ndims, array_of_sizes, array_of_subsizes, array_of_starts, order, oldtype, newtype)
    @mpichk @ccall libmpi.MPI_Type_create_subarray_c(ndims::Cint, array_of_sizes::Ptr{MPI_Count}, array_of_subsizes::Ptr{MPI_Count}, array_of_starts::Ptr{MPI_Count}, order::Cint, oldtype::MPI_Datatype, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_get_contents_c(datatype, max_integers, max_addresses, max_large_counts, max_datatypes, array_of_integers, array_of_addresses, array_of_large_counts, array_of_datatypes)

$(_doc_external(:MPI_Type_get_contents_c))
"""
function MPI_Type_get_contents_c(datatype, max_integers, max_addresses, max_large_counts, max_datatypes, array_of_integers, array_of_addresses, array_of_large_counts, array_of_datatypes)
    @mpichk @ccall libmpi.MPI_Type_get_contents_c(datatype::MPI_Datatype, max_integers::MPI_Count, max_addresses::MPI_Count, max_large_counts::MPI_Count, max_datatypes::MPI_Count, array_of_integers::Ptr{Cint}, array_of_addresses::Ptr{MPI_Aint}, array_of_large_counts::Ptr{MPI_Count}, array_of_datatypes::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_get_envelope_c(datatype, num_integers, num_addresses, num_large_counts, num_datatypes, combiner)

$(_doc_external(:MPI_Type_get_envelope_c))
"""
function MPI_Type_get_envelope_c(datatype, num_integers, num_addresses, num_large_counts, num_datatypes, combiner)
    @mpichk @ccall libmpi.MPI_Type_get_envelope_c(datatype::MPI_Datatype, num_integers::Ptr{MPI_Count}, num_addresses::Ptr{MPI_Count}, num_large_counts::Ptr{MPI_Count}, num_datatypes::Ptr{MPI_Count}, combiner::Ptr{Cint})::Cint
end

"""
    MPI_Type_get_extent_c(datatype, lb, extent)

$(_doc_external(:MPI_Type_get_extent_c))
"""
function MPI_Type_get_extent_c(datatype, lb, extent)
    @mpichk @ccall libmpi.MPI_Type_get_extent_c(datatype::MPI_Datatype, lb::Ptr{MPI_Count}, extent::Ptr{MPI_Count})::Cint
end

"""
    MPI_Type_get_true_extent_c(datatype, true_lb, true_extent)

$(_doc_external(:MPI_Type_get_true_extent_c))
"""
function MPI_Type_get_true_extent_c(datatype, true_lb, true_extent)
    @mpichk @ccall libmpi.MPI_Type_get_true_extent_c(datatype::MPI_Datatype, true_lb::Ptr{MPI_Count}, true_extent::Ptr{MPI_Count})::Cint
end

"""
    MPI_Type_indexed_c(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)

$(_doc_external(:MPI_Type_indexed_c))
"""
function MPI_Type_indexed_c(count, array_of_blocklengths, array_of_displacements, oldtype, newtype)
    @mpichk @ccall libmpi.MPI_Type_indexed_c(count::MPI_Count, array_of_blocklengths::Ptr{MPI_Count}, array_of_displacements::Ptr{MPI_Count}, oldtype::MPI_Datatype, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Type_size_c(datatype, size)

$(_doc_external(:MPI_Type_size_c))
"""
function MPI_Type_size_c(datatype, size)
    @mpichk @ccall libmpi.MPI_Type_size_c(datatype::MPI_Datatype, size::Ptr{MPI_Count})::Cint
end

"""
    MPI_Type_vector_c(count, blocklength, stride, oldtype, newtype)

$(_doc_external(:MPI_Type_vector_c))
"""
function MPI_Type_vector_c(count, blocklength, stride, oldtype, newtype)
    @mpichk @ccall libmpi.MPI_Type_vector_c(count::MPI_Count, blocklength::MPI_Count, stride::MPI_Count, oldtype::MPI_Datatype, newtype::Ptr{MPI_Datatype})::Cint
end

"""
    MPI_Unpack_c(inbuf, insize, position, outbuf, outcount, datatype, comm)

$(_doc_external(:MPI_Unpack_c))
"""
function MPI_Unpack_c(inbuf, insize, position, outbuf, outcount, datatype, comm)
    @mpichk @ccall libmpi.MPI_Unpack_c(inbuf::MPIPtr, insize::MPI_Count, position::Ptr{MPI_Count}, outbuf::MPIPtr, outcount::MPI_Count, datatype::MPI_Datatype, comm::MPI_Comm)::Cint
end

"""
    MPI_Unpack_external_c(datarep, inbuf, insize, position, outbuf, outcount, datatype)

$(_doc_external(:MPI_Unpack_external_c))
"""
function MPI_Unpack_external_c(datarep, inbuf, insize, position, outbuf, outcount, datatype)
    @mpichk @ccall libmpi.MPI_Unpack_external_c(datarep::Ptr{Cchar}, inbuf::MPIPtr, insize::MPI_Count, position::Ptr{MPI_Count}, outbuf::MPIPtr, outcount::MPI_Count, datatype::MPI_Datatype)::Cint
end

"""
    MPI_Op_create_c(user_fn, commute, op)

$(_doc_external(:MPI_Op_create_c))
"""
function MPI_Op_create_c(user_fn, commute, op)
    @mpichk @ccall libmpi.MPI_Op_create_c(user_fn::MPIPtr, commute::Cint, op::Ptr{MPI_Op})::Cint
end

"""
    MPI_Bsend_c(buf, count, datatype, dest, tag, comm)

$(_doc_external(:MPI_Bsend_c))
"""
function MPI_Bsend_c(buf, count, datatype, dest, tag, comm)
    @mpichk @ccall libmpi.MPI_Bsend_c(buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, dest::Cint, tag::Cint, comm::MPI_Comm)::Cint
end

"""
    MPI_Bsend_init_c(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Bsend_init_c))
"""
function MPI_Bsend_init_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk @ccall libmpi.MPI_Bsend_init_c(buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, dest::Cint, tag::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Buffer_attach_c(buffer, size)

$(_doc_external(:MPI_Buffer_attach_c))
"""
function MPI_Buffer_attach_c(buffer, size)
    @mpichk @ccall libmpi.MPI_Buffer_attach_c(buffer::MPIPtr, size::MPI_Count)::Cint
end

"""
    MPI_Buffer_detach_c(buffer_addr, size)

$(_doc_external(:MPI_Buffer_detach_c))
"""
function MPI_Buffer_detach_c(buffer_addr, size)
    @mpichk @ccall libmpi.MPI_Buffer_detach_c(buffer_addr::MPIPtr, size::Ptr{MPI_Count})::Cint
end

"""
    MPI_Ibsend_c(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Ibsend_c))
"""
function MPI_Ibsend_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk @ccall libmpi.MPI_Ibsend_c(buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, dest::Cint, tag::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Imrecv_c(buf, count, datatype, message, request)

$(_doc_external(:MPI_Imrecv_c))
"""
function MPI_Imrecv_c(buf, count, datatype, message, request)
    @mpichk @ccall libmpi.MPI_Imrecv_c(buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, message::Ptr{MPI_Message}, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Irecv_c(buf, count, datatype, source, tag, comm, request)

$(_doc_external(:MPI_Irecv_c))
"""
function MPI_Irecv_c(buf, count, datatype, source, tag, comm, request)
    @mpichk @ccall libmpi.MPI_Irecv_c(buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, source::Cint, tag::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Irsend_c(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Irsend_c))
"""
function MPI_Irsend_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk @ccall libmpi.MPI_Irsend_c(buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, dest::Cint, tag::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Isend_c(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Isend_c))
"""
function MPI_Isend_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk @ccall libmpi.MPI_Isend_c(buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, dest::Cint, tag::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Isendrecv_c(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)

$(_doc_external(:MPI_Isendrecv_c))
"""
function MPI_Isendrecv_c(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, request)
    @mpichk @ccall libmpi.MPI_Isendrecv_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, dest::Cint, sendtag::Cint, recvbuf::MPIPtr, recvcount::MPI_Count, recvtype::MPI_Datatype, source::Cint, recvtag::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Isendrecv_replace_c(buf, count, datatype, dest, sendtag, source, recvtag, comm, request)

$(_doc_external(:MPI_Isendrecv_replace_c))
"""
function MPI_Isendrecv_replace_c(buf, count, datatype, dest, sendtag, source, recvtag, comm, request)
    @mpichk @ccall libmpi.MPI_Isendrecv_replace_c(buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, dest::Cint, sendtag::Cint, source::Cint, recvtag::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Issend_c(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Issend_c))
"""
function MPI_Issend_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk @ccall libmpi.MPI_Issend_c(buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, dest::Cint, tag::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Mrecv_c(buf, count, datatype, message, status)

$(_doc_external(:MPI_Mrecv_c))
"""
function MPI_Mrecv_c(buf, count, datatype, message, status)
    @mpichk @ccall libmpi.MPI_Mrecv_c(buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, message::Ptr{MPI_Message}, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_Recv_c(buf, count, datatype, source, tag, comm, status)

$(_doc_external(:MPI_Recv_c))
"""
function MPI_Recv_c(buf, count, datatype, source, tag, comm, status)
    @mpichk @ccall libmpi.MPI_Recv_c(buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, source::Cint, tag::Cint, comm::MPI_Comm, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_Recv_init_c(buf, count, datatype, source, tag, comm, request)

$(_doc_external(:MPI_Recv_init_c))
"""
function MPI_Recv_init_c(buf, count, datatype, source, tag, comm, request)
    @mpichk @ccall libmpi.MPI_Recv_init_c(buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, source::Cint, tag::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Rsend_c(buf, count, datatype, dest, tag, comm)

$(_doc_external(:MPI_Rsend_c))
"""
function MPI_Rsend_c(buf, count, datatype, dest, tag, comm)
    @mpichk @ccall libmpi.MPI_Rsend_c(buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, dest::Cint, tag::Cint, comm::MPI_Comm)::Cint
end

"""
    MPI_Rsend_init_c(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Rsend_init_c))
"""
function MPI_Rsend_init_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk @ccall libmpi.MPI_Rsend_init_c(buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, dest::Cint, tag::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Send_c(buf, count, datatype, dest, tag, comm)

$(_doc_external(:MPI_Send_c))
"""
function MPI_Send_c(buf, count, datatype, dest, tag, comm)
    @mpichk @ccall libmpi.MPI_Send_c(buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, dest::Cint, tag::Cint, comm::MPI_Comm)::Cint
end

"""
    MPI_Send_init_c(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Send_init_c))
"""
function MPI_Send_init_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk @ccall libmpi.MPI_Send_init_c(buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, dest::Cint, tag::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Sendrecv_c(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)

$(_doc_external(:MPI_Sendrecv_c))
"""
function MPI_Sendrecv_c(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, recvcount, recvtype, source, recvtag, comm, status)
    @mpichk @ccall libmpi.MPI_Sendrecv_c(sendbuf::MPIPtr, sendcount::MPI_Count, sendtype::MPI_Datatype, dest::Cint, sendtag::Cint, recvbuf::MPIPtr, recvcount::MPI_Count, recvtype::MPI_Datatype, source::Cint, recvtag::Cint, comm::MPI_Comm, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_Sendrecv_replace_c(buf, count, datatype, dest, sendtag, source, recvtag, comm, status)

$(_doc_external(:MPI_Sendrecv_replace_c))
"""
function MPI_Sendrecv_replace_c(buf, count, datatype, dest, sendtag, source, recvtag, comm, status)
    @mpichk @ccall libmpi.MPI_Sendrecv_replace_c(buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, dest::Cint, sendtag::Cint, source::Cint, recvtag::Cint, comm::MPI_Comm, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_Ssend_c(buf, count, datatype, dest, tag, comm)

$(_doc_external(:MPI_Ssend_c))
"""
function MPI_Ssend_c(buf, count, datatype, dest, tag, comm)
    @mpichk @ccall libmpi.MPI_Ssend_c(buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, dest::Cint, tag::Cint, comm::MPI_Comm)::Cint
end

"""
    MPI_Ssend_init_c(buf, count, datatype, dest, tag, comm, request)

$(_doc_external(:MPI_Ssend_init_c))
"""
function MPI_Ssend_init_c(buf, count, datatype, dest, tag, comm, request)
    @mpichk @ccall libmpi.MPI_Ssend_init_c(buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, dest::Cint, tag::Cint, comm::MPI_Comm, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Accumulate_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)

$(_doc_external(:MPI_Accumulate_c))
"""
function MPI_Accumulate_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    @mpichk @ccall libmpi.MPI_Accumulate_c(origin_addr::MPIPtr, origin_count::MPI_Count, origin_datatype::MPI_Datatype, target_rank::Cint, target_disp::MPI_Aint, target_count::MPI_Count, target_datatype::MPI_Datatype, op::MPI_Op, win::MPI_Win)::Cint
end

"""
    MPI_Get_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)

$(_doc_external(:MPI_Get_c))
"""
function MPI_Get_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    @mpichk @ccall libmpi.MPI_Get_c(origin_addr::MPIPtr, origin_count::MPI_Count, origin_datatype::MPI_Datatype, target_rank::Cint, target_disp::MPI_Aint, target_count::MPI_Count, target_datatype::MPI_Datatype, win::MPI_Win)::Cint
end

"""
    MPI_Get_accumulate_c(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)

$(_doc_external(:MPI_Get_accumulate_c))
"""
function MPI_Get_accumulate_c(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win)
    @mpichk @ccall libmpi.MPI_Get_accumulate_c(origin_addr::MPIPtr, origin_count::MPI_Count, origin_datatype::MPI_Datatype, result_addr::MPIPtr, result_count::MPI_Count, result_datatype::MPI_Datatype, target_rank::Cint, target_disp::MPI_Aint, target_count::MPI_Count, target_datatype::MPI_Datatype, op::MPI_Op, win::MPI_Win)::Cint
end

"""
    MPI_Put_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)

$(_doc_external(:MPI_Put_c))
"""
function MPI_Put_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win)
    @mpichk @ccall libmpi.MPI_Put_c(origin_addr::MPIPtr, origin_count::MPI_Count, origin_datatype::MPI_Datatype, target_rank::Cint, target_disp::MPI_Aint, target_count::MPI_Count, target_datatype::MPI_Datatype, win::MPI_Win)::Cint
end

"""
    MPI_Raccumulate_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)

$(_doc_external(:MPI_Raccumulate_c))
"""
function MPI_Raccumulate_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    @mpichk @ccall libmpi.MPI_Raccumulate_c(origin_addr::MPIPtr, origin_count::MPI_Count, origin_datatype::MPI_Datatype, target_rank::Cint, target_disp::MPI_Aint, target_count::MPI_Count, target_datatype::MPI_Datatype, op::MPI_Op, win::MPI_Win, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Rget_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)

$(_doc_external(:MPI_Rget_c))
"""
function MPI_Rget_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    @mpichk @ccall libmpi.MPI_Rget_c(origin_addr::MPIPtr, origin_count::MPI_Count, origin_datatype::MPI_Datatype, target_rank::Cint, target_disp::MPI_Aint, target_count::MPI_Count, target_datatype::MPI_Datatype, win::MPI_Win, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Rget_accumulate_c(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)

$(_doc_external(:MPI_Rget_accumulate_c))
"""
function MPI_Rget_accumulate_c(origin_addr, origin_count, origin_datatype, result_addr, result_count, result_datatype, target_rank, target_disp, target_count, target_datatype, op, win, request)
    @mpichk @ccall libmpi.MPI_Rget_accumulate_c(origin_addr::MPIPtr, origin_count::MPI_Count, origin_datatype::MPI_Datatype, result_addr::MPIPtr, result_count::MPI_Count, result_datatype::MPI_Datatype, target_rank::Cint, target_disp::MPI_Aint, target_count::MPI_Count, target_datatype::MPI_Datatype, op::MPI_Op, win::MPI_Win, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Rput_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)

$(_doc_external(:MPI_Rput_c))
"""
function MPI_Rput_c(origin_addr, origin_count, origin_datatype, target_rank, target_disp, target_count, target_datatype, win, request)
    @mpichk @ccall libmpi.MPI_Rput_c(origin_addr::MPIPtr, origin_count::MPI_Count, origin_datatype::MPI_Datatype, target_rank::Cint, target_disp::MPI_Aint, target_count::MPI_Count, target_datatype::MPI_Datatype, win::MPI_Win, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_Win_allocate_c(size, disp_unit, info, comm, baseptr, win)

$(_doc_external(:MPI_Win_allocate_c))
"""
function MPI_Win_allocate_c(size, disp_unit, info, comm, baseptr, win)
    @mpichk @ccall libmpi.MPI_Win_allocate_c(size::MPI_Aint, disp_unit::MPI_Aint, info::MPI_Info, comm::MPI_Comm, baseptr::MPIPtr, win::Ptr{MPI_Win})::Cint
end

"""
    MPI_Win_allocate_shared_c(size, disp_unit, info, comm, baseptr, win)

$(_doc_external(:MPI_Win_allocate_shared_c))
"""
function MPI_Win_allocate_shared_c(size, disp_unit, info, comm, baseptr, win)
    @mpichk @ccall libmpi.MPI_Win_allocate_shared_c(size::MPI_Aint, disp_unit::MPI_Aint, info::MPI_Info, comm::MPI_Comm, baseptr::MPIPtr, win::Ptr{MPI_Win})::Cint
end

"""
    MPI_Win_create_c(base, size, disp_unit, info, comm, win)

$(_doc_external(:MPI_Win_create_c))
"""
function MPI_Win_create_c(base, size, disp_unit, info, comm, win)
    @mpichk @ccall libmpi.MPI_Win_create_c(base::MPIPtr, size::MPI_Aint, disp_unit::MPI_Aint, info::MPI_Info, comm::MPI_Comm, win::Ptr{MPI_Win})::Cint
end

"""
    MPI_Win_shared_query_c(win, rank, size, disp_unit, baseptr)

$(_doc_external(:MPI_Win_shared_query_c))
"""
function MPI_Win_shared_query_c(win, rank, size, disp_unit, baseptr)
    @mpichk @ccall libmpi.MPI_Win_shared_query_c(win::MPI_Win, rank::Cint, size::Ptr{MPI_Aint}, disp_unit::Ptr{MPI_Aint}, baseptr::MPIPtr)::Cint
end

"""
    MPI_File_open(comm, filename, amode, info, fh)

$(_doc_external(:MPI_File_open))
"""
function MPI_File_open(comm, filename, amode, info, fh)
    @mpichk @ccall libmpi.MPI_File_open(comm::MPI_Comm, filename::Ptr{Cchar}, amode::Cint, info::MPI_Info, fh::Ptr{MPI_File})::Cint
end

"""
    MPI_File_close(fh)

$(_doc_external(:MPI_File_close))
"""
function MPI_File_close(fh)
    @mpichk @ccall libmpi.MPI_File_close(fh::Ptr{MPI_File})::Cint
end

"""
    MPI_File_delete(filename, info)

$(_doc_external(:MPI_File_delete))
"""
function MPI_File_delete(filename, info)
    @mpichk @ccall libmpi.MPI_File_delete(filename::Ptr{Cchar}, info::MPI_Info)::Cint
end

"""
    MPI_File_set_size(fh, size)

$(_doc_external(:MPI_File_set_size))
"""
function MPI_File_set_size(fh, size)
    @mpichk @ccall libmpi.MPI_File_set_size(fh::MPI_File, size::MPI_Offset)::Cint
end

"""
    MPI_File_preallocate(fh, size)

$(_doc_external(:MPI_File_preallocate))
"""
function MPI_File_preallocate(fh, size)
    @mpichk @ccall libmpi.MPI_File_preallocate(fh::MPI_File, size::MPI_Offset)::Cint
end

"""
    MPI_File_get_size(fh, size)

$(_doc_external(:MPI_File_get_size))
"""
function MPI_File_get_size(fh, size)
    @mpichk @ccall libmpi.MPI_File_get_size(fh::MPI_File, size::Ptr{MPI_Offset})::Cint
end

"""
    MPI_File_get_group(fh, group)

$(_doc_external(:MPI_File_get_group))
"""
function MPI_File_get_group(fh, group)
    @mpichk @ccall libmpi.MPI_File_get_group(fh::MPI_File, group::Ptr{MPI_Group})::Cint
end

"""
    MPI_File_get_amode(fh, amode)

$(_doc_external(:MPI_File_get_amode))
"""
function MPI_File_get_amode(fh, amode)
    @mpichk @ccall libmpi.MPI_File_get_amode(fh::MPI_File, amode::Ptr{Cint})::Cint
end

"""
    MPI_File_set_info(fh, info)

$(_doc_external(:MPI_File_set_info))
"""
function MPI_File_set_info(fh, info)
    @mpichk @ccall libmpi.MPI_File_set_info(fh::MPI_File, info::MPI_Info)::Cint
end

"""
    MPI_File_get_info(fh, info_used)

$(_doc_external(:MPI_File_get_info))
"""
function MPI_File_get_info(fh, info_used)
    @mpichk @ccall libmpi.MPI_File_get_info(fh::MPI_File, info_used::Ptr{MPI_Info})::Cint
end

"""
    MPI_File_set_view(fh, disp, etype, filetype, datarep, info)

$(_doc_external(:MPI_File_set_view))
"""
function MPI_File_set_view(fh, disp, etype, filetype, datarep, info)
    @mpichk @ccall libmpi.MPI_File_set_view(fh::MPI_File, disp::MPI_Offset, etype::MPI_Datatype, filetype::MPI_Datatype, datarep::Ptr{Cchar}, info::MPI_Info)::Cint
end

"""
    MPI_File_get_view(fh, disp, etype, filetype, datarep)

$(_doc_external(:MPI_File_get_view))
"""
function MPI_File_get_view(fh, disp, etype, filetype, datarep)
    @mpichk @ccall libmpi.MPI_File_get_view(fh::MPI_File, disp::Ptr{MPI_Offset}, etype::Ptr{MPI_Datatype}, filetype::Ptr{MPI_Datatype}, datarep::Ptr{Cchar})::Cint
end

"""
    MPI_File_read_at(fh, offset, buf, count, datatype, status)

$(_doc_external(:MPI_File_read_at))
"""
function MPI_File_read_at(fh, offset, buf, count, datatype, status)
    @mpichk @ccall libmpi.MPI_File_read_at(fh::MPI_File, offset::MPI_Offset, buf::MPIPtr, count::Cint, datatype::MPI_Datatype, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_read_at_all(fh, offset, buf, count, datatype, status)

$(_doc_external(:MPI_File_read_at_all))
"""
function MPI_File_read_at_all(fh, offset, buf, count, datatype, status)
    @mpichk @ccall libmpi.MPI_File_read_at_all(fh::MPI_File, offset::MPI_Offset, buf::MPIPtr, count::Cint, datatype::MPI_Datatype, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_write_at(fh, offset, buf, count, datatype, status)

$(_doc_external(:MPI_File_write_at))
"""
function MPI_File_write_at(fh, offset, buf, count, datatype, status)
    @mpichk @ccall libmpi.MPI_File_write_at(fh::MPI_File, offset::MPI_Offset, buf::MPIPtr, count::Cint, datatype::MPI_Datatype, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_write_at_all(fh, offset, buf, count, datatype, status)

$(_doc_external(:MPI_File_write_at_all))
"""
function MPI_File_write_at_all(fh, offset, buf, count, datatype, status)
    @mpichk @ccall libmpi.MPI_File_write_at_all(fh::MPI_File, offset::MPI_Offset, buf::MPIPtr, count::Cint, datatype::MPI_Datatype, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_iread_at(fh, offset, buf, count, datatype, request)

$(_doc_external(:MPI_File_iread_at))
"""
function MPI_File_iread_at(fh, offset, buf, count, datatype, request)
    @mpichk @ccall libmpi.MPI_File_iread_at(fh::MPI_File, offset::MPI_Offset, buf::MPIPtr, count::Cint, datatype::MPI_Datatype, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_File_iwrite_at(fh, offset, buf, count, datatype, request)

$(_doc_external(:MPI_File_iwrite_at))
"""
function MPI_File_iwrite_at(fh, offset, buf, count, datatype, request)
    @mpichk @ccall libmpi.MPI_File_iwrite_at(fh::MPI_File, offset::MPI_Offset, buf::MPIPtr, count::Cint, datatype::MPI_Datatype, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_File_read(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_read))
"""
function MPI_File_read(fh, buf, count, datatype, status)
    @mpichk @ccall libmpi.MPI_File_read(fh::MPI_File, buf::MPIPtr, count::Cint, datatype::MPI_Datatype, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_read_all(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_read_all))
"""
function MPI_File_read_all(fh, buf, count, datatype, status)
    @mpichk @ccall libmpi.MPI_File_read_all(fh::MPI_File, buf::MPIPtr, count::Cint, datatype::MPI_Datatype, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_write(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_write))
"""
function MPI_File_write(fh, buf, count, datatype, status)
    @mpichk @ccall libmpi.MPI_File_write(fh::MPI_File, buf::MPIPtr, count::Cint, datatype::MPI_Datatype, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_write_all(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_write_all))
"""
function MPI_File_write_all(fh, buf, count, datatype, status)
    @mpichk @ccall libmpi.MPI_File_write_all(fh::MPI_File, buf::MPIPtr, count::Cint, datatype::MPI_Datatype, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_iread(fh, buf, count, datatype, request)

$(_doc_external(:MPI_File_iread))
"""
function MPI_File_iread(fh, buf, count, datatype, request)
    @mpichk @ccall libmpi.MPI_File_iread(fh::MPI_File, buf::MPIPtr, count::Cint, datatype::MPI_Datatype, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_File_iwrite(fh, buf, count, datatype, request)

$(_doc_external(:MPI_File_iwrite))
"""
function MPI_File_iwrite(fh, buf, count, datatype, request)
    @mpichk @ccall libmpi.MPI_File_iwrite(fh::MPI_File, buf::MPIPtr, count::Cint, datatype::MPI_Datatype, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_File_seek(fh, offset, whence)

$(_doc_external(:MPI_File_seek))
"""
function MPI_File_seek(fh, offset, whence)
    @mpichk @ccall libmpi.MPI_File_seek(fh::MPI_File, offset::MPI_Offset, whence::Cint)::Cint
end

"""
    MPI_File_get_position(fh, offset)

$(_doc_external(:MPI_File_get_position))
"""
function MPI_File_get_position(fh, offset)
    @mpichk @ccall libmpi.MPI_File_get_position(fh::MPI_File, offset::Ptr{MPI_Offset})::Cint
end

"""
    MPI_File_get_byte_offset(fh, offset, disp)

$(_doc_external(:MPI_File_get_byte_offset))
"""
function MPI_File_get_byte_offset(fh, offset, disp)
    @mpichk @ccall libmpi.MPI_File_get_byte_offset(fh::MPI_File, offset::MPI_Offset, disp::Ptr{MPI_Offset})::Cint
end

"""
    MPI_File_read_shared(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_read_shared))
"""
function MPI_File_read_shared(fh, buf, count, datatype, status)
    @mpichk @ccall libmpi.MPI_File_read_shared(fh::MPI_File, buf::MPIPtr, count::Cint, datatype::MPI_Datatype, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_write_shared(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_write_shared))
"""
function MPI_File_write_shared(fh, buf, count, datatype, status)
    @mpichk @ccall libmpi.MPI_File_write_shared(fh::MPI_File, buf::MPIPtr, count::Cint, datatype::MPI_Datatype, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_iread_shared(fh, buf, count, datatype, request)

$(_doc_external(:MPI_File_iread_shared))
"""
function MPI_File_iread_shared(fh, buf, count, datatype, request)
    @mpichk @ccall libmpi.MPI_File_iread_shared(fh::MPI_File, buf::MPIPtr, count::Cint, datatype::MPI_Datatype, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_File_iwrite_shared(fh, buf, count, datatype, request)

$(_doc_external(:MPI_File_iwrite_shared))
"""
function MPI_File_iwrite_shared(fh, buf, count, datatype, request)
    @mpichk @ccall libmpi.MPI_File_iwrite_shared(fh::MPI_File, buf::MPIPtr, count::Cint, datatype::MPI_Datatype, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_File_read_ordered(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_read_ordered))
"""
function MPI_File_read_ordered(fh, buf, count, datatype, status)
    @mpichk @ccall libmpi.MPI_File_read_ordered(fh::MPI_File, buf::MPIPtr, count::Cint, datatype::MPI_Datatype, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_write_ordered(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_write_ordered))
"""
function MPI_File_write_ordered(fh, buf, count, datatype, status)
    @mpichk @ccall libmpi.MPI_File_write_ordered(fh::MPI_File, buf::MPIPtr, count::Cint, datatype::MPI_Datatype, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_seek_shared(fh, offset, whence)

$(_doc_external(:MPI_File_seek_shared))
"""
function MPI_File_seek_shared(fh, offset, whence)
    @mpichk @ccall libmpi.MPI_File_seek_shared(fh::MPI_File, offset::MPI_Offset, whence::Cint)::Cint
end

"""
    MPI_File_get_position_shared(fh, offset)

$(_doc_external(:MPI_File_get_position_shared))
"""
function MPI_File_get_position_shared(fh, offset)
    @mpichk @ccall libmpi.MPI_File_get_position_shared(fh::MPI_File, offset::Ptr{MPI_Offset})::Cint
end

"""
    MPI_File_read_at_all_begin(fh, offset, buf, count, datatype)

$(_doc_external(:MPI_File_read_at_all_begin))
"""
function MPI_File_read_at_all_begin(fh, offset, buf, count, datatype)
    @mpichk @ccall libmpi.MPI_File_read_at_all_begin(fh::MPI_File, offset::MPI_Offset, buf::MPIPtr, count::Cint, datatype::MPI_Datatype)::Cint
end

"""
    MPI_File_read_at_all_end(fh, buf, status)

$(_doc_external(:MPI_File_read_at_all_end))
"""
function MPI_File_read_at_all_end(fh, buf, status)
    @mpichk @ccall libmpi.MPI_File_read_at_all_end(fh::MPI_File, buf::MPIPtr, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_write_at_all_begin(fh, offset, buf, count, datatype)

$(_doc_external(:MPI_File_write_at_all_begin))
"""
function MPI_File_write_at_all_begin(fh, offset, buf, count, datatype)
    @mpichk @ccall libmpi.MPI_File_write_at_all_begin(fh::MPI_File, offset::MPI_Offset, buf::MPIPtr, count::Cint, datatype::MPI_Datatype)::Cint
end

"""
    MPI_File_write_at_all_end(fh, buf, status)

$(_doc_external(:MPI_File_write_at_all_end))
"""
function MPI_File_write_at_all_end(fh, buf, status)
    @mpichk @ccall libmpi.MPI_File_write_at_all_end(fh::MPI_File, buf::MPIPtr, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_read_all_begin(fh, buf, count, datatype)

$(_doc_external(:MPI_File_read_all_begin))
"""
function MPI_File_read_all_begin(fh, buf, count, datatype)
    @mpichk @ccall libmpi.MPI_File_read_all_begin(fh::MPI_File, buf::MPIPtr, count::Cint, datatype::MPI_Datatype)::Cint
end

"""
    MPI_File_read_all_end(fh, buf, status)

$(_doc_external(:MPI_File_read_all_end))
"""
function MPI_File_read_all_end(fh, buf, status)
    @mpichk @ccall libmpi.MPI_File_read_all_end(fh::MPI_File, buf::MPIPtr, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_write_all_begin(fh, buf, count, datatype)

$(_doc_external(:MPI_File_write_all_begin))
"""
function MPI_File_write_all_begin(fh, buf, count, datatype)
    @mpichk @ccall libmpi.MPI_File_write_all_begin(fh::MPI_File, buf::MPIPtr, count::Cint, datatype::MPI_Datatype)::Cint
end

"""
    MPI_File_write_all_end(fh, buf, status)

$(_doc_external(:MPI_File_write_all_end))
"""
function MPI_File_write_all_end(fh, buf, status)
    @mpichk @ccall libmpi.MPI_File_write_all_end(fh::MPI_File, buf::MPIPtr, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_read_ordered_begin(fh, buf, count, datatype)

$(_doc_external(:MPI_File_read_ordered_begin))
"""
function MPI_File_read_ordered_begin(fh, buf, count, datatype)
    @mpichk @ccall libmpi.MPI_File_read_ordered_begin(fh::MPI_File, buf::MPIPtr, count::Cint, datatype::MPI_Datatype)::Cint
end

"""
    MPI_File_read_ordered_end(fh, buf, status)

$(_doc_external(:MPI_File_read_ordered_end))
"""
function MPI_File_read_ordered_end(fh, buf, status)
    @mpichk @ccall libmpi.MPI_File_read_ordered_end(fh::MPI_File, buf::MPIPtr, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_write_ordered_begin(fh, buf, count, datatype)

$(_doc_external(:MPI_File_write_ordered_begin))
"""
function MPI_File_write_ordered_begin(fh, buf, count, datatype)
    @mpichk @ccall libmpi.MPI_File_write_ordered_begin(fh::MPI_File, buf::MPIPtr, count::Cint, datatype::MPI_Datatype)::Cint
end

"""
    MPI_File_write_ordered_end(fh, buf, status)

$(_doc_external(:MPI_File_write_ordered_end))
"""
function MPI_File_write_ordered_end(fh, buf, status)
    @mpichk @ccall libmpi.MPI_File_write_ordered_end(fh::MPI_File, buf::MPIPtr, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_get_type_extent(fh, datatype, extent)

$(_doc_external(:MPI_File_get_type_extent))
"""
function MPI_File_get_type_extent(fh, datatype, extent)
    @mpichk @ccall libmpi.MPI_File_get_type_extent(fh::MPI_File, datatype::MPI_Datatype, extent::Ptr{MPI_Aint})::Cint
end

"""
    MPI_Register_datarep(datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)

$(_doc_external(:MPI_Register_datarep))
"""
function MPI_Register_datarep(datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)
    @mpichk @ccall libmpi.MPI_Register_datarep(datarep::Ptr{Cchar}, read_conversion_fn::MPIPtr, write_conversion_fn::MPIPtr, dtype_file_extent_fn::MPIPtr, extra_state::MPIPtr)::Cint
end

"""
    MPI_File_set_atomicity(fh, flag)

$(_doc_external(:MPI_File_set_atomicity))
"""
function MPI_File_set_atomicity(fh, flag)
    @mpichk @ccall libmpi.MPI_File_set_atomicity(fh::MPI_File, flag::Cint)::Cint
end

"""
    MPI_File_get_atomicity(fh, flag)

$(_doc_external(:MPI_File_get_atomicity))
"""
function MPI_File_get_atomicity(fh, flag)
    @mpichk @ccall libmpi.MPI_File_get_atomicity(fh::MPI_File, flag::Ptr{Cint})::Cint
end

"""
    MPI_File_sync(fh)

$(_doc_external(:MPI_File_sync))
"""
function MPI_File_sync(fh)
    @mpichk @ccall libmpi.MPI_File_sync(fh::MPI_File)::Cint
end

"""
    MPI_File_iread_at_all(fh, offset, buf, count, datatype, request)

$(_doc_external(:MPI_File_iread_at_all))
"""
function MPI_File_iread_at_all(fh, offset, buf, count, datatype, request)
    @mpichk @ccall libmpi.MPI_File_iread_at_all(fh::MPI_File, offset::MPI_Offset, buf::MPIPtr, count::Cint, datatype::MPI_Datatype, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_File_iwrite_at_all(fh, offset, buf, count, datatype, request)

$(_doc_external(:MPI_File_iwrite_at_all))
"""
function MPI_File_iwrite_at_all(fh, offset, buf, count, datatype, request)
    @mpichk @ccall libmpi.MPI_File_iwrite_at_all(fh::MPI_File, offset::MPI_Offset, buf::MPIPtr, count::Cint, datatype::MPI_Datatype, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_File_iread_all(fh, buf, count, datatype, request)

$(_doc_external(:MPI_File_iread_all))
"""
function MPI_File_iread_all(fh, buf, count, datatype, request)
    @mpichk @ccall libmpi.MPI_File_iread_all(fh::MPI_File, buf::MPIPtr, count::Cint, datatype::MPI_Datatype, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_File_iwrite_all(fh, buf, count, datatype, request)

$(_doc_external(:MPI_File_iwrite_all))
"""
function MPI_File_iwrite_all(fh, buf, count, datatype, request)
    @mpichk @ccall libmpi.MPI_File_iwrite_all(fh::MPI_File, buf::MPIPtr, count::Cint, datatype::MPI_Datatype, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_File_read_c(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_read_c))
"""
function MPI_File_read_c(fh, buf, count, datatype, status)
    @mpichk @ccall libmpi.MPI_File_read_c(fh::MPI_File, buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_read_all_c(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_read_all_c))
"""
function MPI_File_read_all_c(fh, buf, count, datatype, status)
    @mpichk @ccall libmpi.MPI_File_read_all_c(fh::MPI_File, buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_read_all_begin_c(fh, buf, count, datatype)

$(_doc_external(:MPI_File_read_all_begin_c))
"""
function MPI_File_read_all_begin_c(fh, buf, count, datatype)
    @mpichk @ccall libmpi.MPI_File_read_all_begin_c(fh::MPI_File, buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype)::Cint
end

"""
    MPI_File_read_at_c(fh, offset, buf, count, datatype, status)

$(_doc_external(:MPI_File_read_at_c))
"""
function MPI_File_read_at_c(fh, offset, buf, count, datatype, status)
    @mpichk @ccall libmpi.MPI_File_read_at_c(fh::MPI_File, offset::MPI_Offset, buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_read_at_all_c(fh, offset, buf, count, datatype, status)

$(_doc_external(:MPI_File_read_at_all_c))
"""
function MPI_File_read_at_all_c(fh, offset, buf, count, datatype, status)
    @mpichk @ccall libmpi.MPI_File_read_at_all_c(fh::MPI_File, offset::MPI_Offset, buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_read_at_all_begin_c(fh, offset, buf, count, datatype)

$(_doc_external(:MPI_File_read_at_all_begin_c))
"""
function MPI_File_read_at_all_begin_c(fh, offset, buf, count, datatype)
    @mpichk @ccall libmpi.MPI_File_read_at_all_begin_c(fh::MPI_File, offset::MPI_Offset, buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype)::Cint
end

"""
    MPI_File_read_ordered_c(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_read_ordered_c))
"""
function MPI_File_read_ordered_c(fh, buf, count, datatype, status)
    @mpichk @ccall libmpi.MPI_File_read_ordered_c(fh::MPI_File, buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_read_ordered_begin_c(fh, buf, count, datatype)

$(_doc_external(:MPI_File_read_ordered_begin_c))
"""
function MPI_File_read_ordered_begin_c(fh, buf, count, datatype)
    @mpichk @ccall libmpi.MPI_File_read_ordered_begin_c(fh::MPI_File, buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype)::Cint
end

"""
    MPI_File_read_shared_c(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_read_shared_c))
"""
function MPI_File_read_shared_c(fh, buf, count, datatype, status)
    @mpichk @ccall libmpi.MPI_File_read_shared_c(fh::MPI_File, buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_write_c(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_write_c))
"""
function MPI_File_write_c(fh, buf, count, datatype, status)
    @mpichk @ccall libmpi.MPI_File_write_c(fh::MPI_File, buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_write_all_c(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_write_all_c))
"""
function MPI_File_write_all_c(fh, buf, count, datatype, status)
    @mpichk @ccall libmpi.MPI_File_write_all_c(fh::MPI_File, buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_write_all_begin_c(fh, buf, count, datatype)

$(_doc_external(:MPI_File_write_all_begin_c))
"""
function MPI_File_write_all_begin_c(fh, buf, count, datatype)
    @mpichk @ccall libmpi.MPI_File_write_all_begin_c(fh::MPI_File, buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype)::Cint
end

"""
    MPI_File_write_at_c(fh, offset, buf, count, datatype, status)

$(_doc_external(:MPI_File_write_at_c))
"""
function MPI_File_write_at_c(fh, offset, buf, count, datatype, status)
    @mpichk @ccall libmpi.MPI_File_write_at_c(fh::MPI_File, offset::MPI_Offset, buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_write_at_all_c(fh, offset, buf, count, datatype, status)

$(_doc_external(:MPI_File_write_at_all_c))
"""
function MPI_File_write_at_all_c(fh, offset, buf, count, datatype, status)
    @mpichk @ccall libmpi.MPI_File_write_at_all_c(fh::MPI_File, offset::MPI_Offset, buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_write_at_all_begin_c(fh, offset, buf, count, datatype)

$(_doc_external(:MPI_File_write_at_all_begin_c))
"""
function MPI_File_write_at_all_begin_c(fh, offset, buf, count, datatype)
    @mpichk @ccall libmpi.MPI_File_write_at_all_begin_c(fh::MPI_File, offset::MPI_Offset, buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype)::Cint
end

"""
    MPI_File_write_ordered_c(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_write_ordered_c))
"""
function MPI_File_write_ordered_c(fh, buf, count, datatype, status)
    @mpichk @ccall libmpi.MPI_File_write_ordered_c(fh::MPI_File, buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_write_ordered_begin_c(fh, buf, count, datatype)

$(_doc_external(:MPI_File_write_ordered_begin_c))
"""
function MPI_File_write_ordered_begin_c(fh, buf, count, datatype)
    @mpichk @ccall libmpi.MPI_File_write_ordered_begin_c(fh::MPI_File, buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype)::Cint
end

"""
    MPI_File_write_shared_c(fh, buf, count, datatype, status)

$(_doc_external(:MPI_File_write_shared_c))
"""
function MPI_File_write_shared_c(fh, buf, count, datatype, status)
    @mpichk @ccall libmpi.MPI_File_write_shared_c(fh::MPI_File, buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, status::Ptr{MPI_Status})::Cint
end

"""
    MPI_File_iread_c(fh, buf, count, datatype, request)

$(_doc_external(:MPI_File_iread_c))
"""
function MPI_File_iread_c(fh, buf, count, datatype, request)
    @mpichk @ccall libmpi.MPI_File_iread_c(fh::MPI_File, buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_File_iread_all_c(fh, buf, count, datatype, request)

$(_doc_external(:MPI_File_iread_all_c))
"""
function MPI_File_iread_all_c(fh, buf, count, datatype, request)
    @mpichk @ccall libmpi.MPI_File_iread_all_c(fh::MPI_File, buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_File_iread_at_c(fh, offset, buf, count, datatype, request)

$(_doc_external(:MPI_File_iread_at_c))
"""
function MPI_File_iread_at_c(fh, offset, buf, count, datatype, request)
    @mpichk @ccall libmpi.MPI_File_iread_at_c(fh::MPI_File, offset::MPI_Offset, buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_File_iread_at_all_c(fh, offset, buf, count, datatype, request)

$(_doc_external(:MPI_File_iread_at_all_c))
"""
function MPI_File_iread_at_all_c(fh, offset, buf, count, datatype, request)
    @mpichk @ccall libmpi.MPI_File_iread_at_all_c(fh::MPI_File, offset::MPI_Offset, buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_File_iread_shared_c(fh, buf, count, datatype, request)

$(_doc_external(:MPI_File_iread_shared_c))
"""
function MPI_File_iread_shared_c(fh, buf, count, datatype, request)
    @mpichk @ccall libmpi.MPI_File_iread_shared_c(fh::MPI_File, buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_File_iwrite_c(fh, buf, count, datatype, request)

$(_doc_external(:MPI_File_iwrite_c))
"""
function MPI_File_iwrite_c(fh, buf, count, datatype, request)
    @mpichk @ccall libmpi.MPI_File_iwrite_c(fh::MPI_File, buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_File_iwrite_all_c(fh, buf, count, datatype, request)

$(_doc_external(:MPI_File_iwrite_all_c))
"""
function MPI_File_iwrite_all_c(fh, buf, count, datatype, request)
    @mpichk @ccall libmpi.MPI_File_iwrite_all_c(fh::MPI_File, buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_File_iwrite_at_c(fh, offset, buf, count, datatype, request)

$(_doc_external(:MPI_File_iwrite_at_c))
"""
function MPI_File_iwrite_at_c(fh, offset, buf, count, datatype, request)
    @mpichk @ccall libmpi.MPI_File_iwrite_at_c(fh::MPI_File, offset::MPI_Offset, buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_File_iwrite_at_all_c(fh, offset, buf, count, datatype, request)

$(_doc_external(:MPI_File_iwrite_at_all_c))
"""
function MPI_File_iwrite_at_all_c(fh, offset, buf, count, datatype, request)
    @mpichk @ccall libmpi.MPI_File_iwrite_at_all_c(fh::MPI_File, offset::MPI_Offset, buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_File_iwrite_shared_c(fh, buf, count, datatype, request)

$(_doc_external(:MPI_File_iwrite_shared_c))
"""
function MPI_File_iwrite_shared_c(fh, buf, count, datatype, request)
    @mpichk @ccall libmpi.MPI_File_iwrite_shared_c(fh::MPI_File, buf::MPIPtr, count::MPI_Count, datatype::MPI_Datatype, request::Ptr{MPI_Request})::Cint
end

"""
    MPI_File_get_type_extent_c(fh, datatype, extent)

$(_doc_external(:MPI_File_get_type_extent_c))
"""
function MPI_File_get_type_extent_c(fh, datatype, extent)
    @mpichk @ccall libmpi.MPI_File_get_type_extent_c(fh::MPI_File, datatype::MPI_Datatype, extent::Ptr{MPI_Count})::Cint
end

"""
    MPI_Register_datarep_c(datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)

$(_doc_external(:MPI_Register_datarep_c))
"""
function MPI_Register_datarep_c(datarep, read_conversion_fn, write_conversion_fn, dtype_file_extent_fn, extra_state)
    @mpichk @ccall libmpi.MPI_Register_datarep_c(datarep::Ptr{Cchar}, read_conversion_fn::MPIPtr, write_conversion_fn::MPIPtr, dtype_file_extent_fn::MPIPtr, extra_state::MPIPtr)::Cint
end

"""
    MPI_File_f2c(file)

$(_doc_external(:MPI_File_f2c))
"""
function MPI_File_f2c(file)
    @mpichk @ccall libmpi.MPI_File_f2c(file::MPI_Fint)::MPI_File
end

"""
    MPI_File_c2f(file)

$(_doc_external(:MPI_File_c2f))
"""
function MPI_File_c2f(file)
    @mpichk @ccall libmpi.MPI_File_c2f(file::MPI_File)::MPI_Fint
end
