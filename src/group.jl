@mpi_handle Group

const GROUP_NULL = _Group(MPI_GROUP_NULL)
const GROUP_EMPTY = _Group(MPI_GROUP_EMPTY)

Group() = Group(GROUP_NULL.val)

function free(group::Group)
    if group.val != GROUP_NULL.val
        @mpichk ccall((:MPI_Comm_free, libmpi), Cint, (Ptr{MPI_Group},), group)
        refcount_dec()
    end
    return nothing
end

"""
    Group_rank(group::Group)

The rank of the process in the particular group.

Returns an integer in the range `0:MPI.Group_size()-1`.
"""
function Group_rank(group::Group)
    rank = Ref{Cint}()
    @mpichk ccall((:MPI_Group_rank, libmpi), Cint, (MPI_Group, Ptr{Cint}), group, rank)
    Int(rank[])
end

"""
    Group_size(group::Group)

The number of processes involved in group.
"""
function Group_size(group::Group)
    size = Ref{Cint}()
    @mpichk ccall((:MPI_Group_size, libmpi), Cint, (MPI_Group, Ptr{Cint}), group, size)
    Int(size[])
end

function Comm_create_group(comm::Comm, group::Group, tag::Integer)
    newcomm = Comm()
    @mpichk ccall((:MPI_Comm_create_group, libmpi), Cint,
        (MPI_Comm, MPI_Group, Cint, Ptr{MPI_Comm}), comm, group, tag, newcomm)
    refcount_inc()
    finalizer(free, newcomm)
    newcomm
end

function Comm_group(comm::Comm)
    newgroup = Group()
    @mpichk ccall((:MPI_Comm_group, libmpi), Cint,
        (MPI_Comm, Ptr{MPI_Group}), comm, newgroup)
    refcount_inc()
    finalizer(free, newgroup)
    newgroup
end

function Comm_remote_group(comm::Comm)
    newgroup = Group()
    @mpichk ccall((:MPI_Comm_remote_group, libmpi), Cint,
        (MPI_Comm, Ptr{MPI_Group}), comm, newgroup)
    refcount_inc()
    finalizer(free, newgroup)
    newgroup
end

function Group_compare(group1::Group, group2::Group)
    result = Ref{Cint}()
    @mpichk ccall((:MPI_Group_compare, libmpi), Cint,
        (MPI_Group, MPI_Group, Ptr{Cint}), group1, group2, result)
    Int(result[])
end

function Group_difference(group1::Group, group2::Group)
    newgroup = Group()
    @mpichk ccall((:MPI_Group_difference, libmpi), Cint,
        (MPI_Group, MPI_Group, Ptr{MPI_Group}), group1, group2, newgroup)
    return newgroup
end

function Group_intersection(group1::Group, group2::Group)
    newgroup = Group()
    @mpichk ccall((:MPI_Group_intersection, libmpi), Cint,
        (MPI_Group, MPI_Group, Ptr{MPI_Group}), group1, group2, newgroup)
    return newgroup
end

function Group_union(group1::Group, group2::Group)
    newgroup = Group()
    @mpichk ccall((:MPI_Group_union, libmpi), Cint,
        (MPI_Group, MPI_Group, Ptr{MPI_Group}), group1, group2, newgroup)
    return newgroup
end

function Group_excl(group::Group, ranks::Vector{Cint})
    newgroup = Group()
    @mpichk ccall((:MPI_Group_excl, libmpi), Cint,
        (MPI_Group, Cint, Ptr{Cint}, Ptr{MPI_Group}), group, length(ranks), ranks, newgroup)
    return newgroup
end

function Group_incl(group::Group, ranks::Vector{Cint})
    newgroup = Group()
    @mpichk ccall((:MPI_Group_incl, libmpi), Cint,
        (MPI_Group, Cint, Ptr{Cint}, Ptr{MPI_Group}), group, length(ranks), ranks, newgroup)
    return newgroup
end

# int MPI_Group_range_excl(MPI_Group group, int n, int ranges[][3], MPI_Group *newgroup)
# int MPI_Group_range_incl(MPI_Group group, int n, int ranges[][3], MPI_Group *newgroup)
# int MPI_Group_translate_ranks(MPI_Group group1, int n, const int ranks1[], MPI_Group group2, int ranks2[])
