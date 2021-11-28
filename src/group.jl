@mpi_handle Group

const GROUP_NULL = _Group(MPI_GROUP_NULL)
const GROUP_EMPTY = _Group(MPI_GROUP_EMPTY)

Group() = Group(GROUP_NULL.val)

# int MPI_Group_range_excl(MPI_Group group, int n, int ranges[][3], MPI_Group *newgroup)
# int MPI_Group_range_incl(MPI_Group group, int n, int ranges[][3], MPI_Group *newgroup)
# int MPI_Group_translate_ranks(MPI_Group group1, int n, const int ranks1[], MPI_Group group2, int ranks2[])

function free(group::Group)
    if group.val != GROUP_NULL.val && !Finalized()
        @mpichk ccall((:MPI_Group_free, libmpi), Cint, (Ptr{MPI_Group},), group)
    end
    return nothing
end

"""
    Group_size(group::Group)

The number of processes involved in group.

# External links
$(_doc_external("MPI_Group_size"))
"""
function Group_size(group::Group)
    size = Ref{Cint}()
    @mpichk ccall((:MPI_Group_size, libmpi), Cint, (MPI_Group, Ptr{Cint}), group, size)
    Int(size[])
end

"""
    Group_rank(group::Group)

The rank of the process in the particular group.

Returns an integer in the range `0:MPI.Group_size()-1`.

# External links
$(_doc_external("MPI_Group_rank"))
"""
function Group_rank(group::Group)
    rank = Ref{Cint}()
    @mpichk ccall((:MPI_Group_rank, libmpi), Cint, (MPI_Group, Ptr{Cint}), group, rank)
    Int(rank[])
end

"""
    Comparison

An enum denoting the result of [`Comm_compare`](@ref):

 - `MPI.IDENT`: the objects are handles for the same object (identical groups and same contexts).

 - `MPI.CONGRUENT`: the underlying groups are identical in constituents and rank order; these communicators differ only by context.

 - `MPI.SIMILAR`: members of both objects are the same but the rank order differs.

 - `MPI.UNEQUAL`: otherwise
"""
mutable struct Comparison
    val::Cint
end
const IDENT     = Comparison(MPI_IDENT)
const CONGRUENT = Comparison(MPI_CONGRUENT)
const SIMILAR   = Comparison(MPI_SIMILAR)
const UNEQUAL   = Comparison(MPI_UNEQUAL)
add_load_time_hook!(() -> IDENT.val     = MPI_IDENT    )
add_load_time_hook!(() -> CONGRUENT.val = MPI_CONGRUENT)
add_load_time_hook!(() -> SIMILAR.val   = MPI_SIMILAR  )
add_load_time_hook!(() -> UNEQUAL.val   = MPI_UNEQUAL  )
Base.:(==)(tl1::Comparison, tl2::Comparison) = tl1.val == tl2.val

function Group_compare(group1::Group, group2::Group)
    result = Ref{Comparison}()
    @mpichk ccall((:MPI_Group_compare, libmpi), Cint,
        (MPI_Group, MPI_Group, Ptr{Comparison}), group1, group2, result)
    result[]
end

function Group_difference(group1::Group, group2::Group)
    newgroup = Group()
    @mpichk ccall((:MPI_Group_difference, libmpi), Cint,
        (MPI_Group, MPI_Group, Ptr{MPI_Group}), group1, group2, newgroup)
    finalizer(free, newgroup)
    return newgroup
end

function Group_intersection(group1::Group, group2::Group)
    newgroup = Group()
    @mpichk ccall((:MPI_Group_intersection, libmpi), Cint,
        (MPI_Group, MPI_Group, Ptr{MPI_Group}), group1, group2, newgroup)
    finalizer(free, newgroup)
    return newgroup
end

function Group_union(group1::Group, group2::Group)
    newgroup = Group()
    @mpichk ccall((:MPI_Group_union, libmpi), Cint,
        (MPI_Group, MPI_Group, Ptr{MPI_Group}), group1, group2, newgroup)
    finalizer(free, newgroup)
    return newgroup
end

function Group_excl(group::Group, ranks::Vector{Cint})
    newgroup = Group()
    @mpichk ccall((:MPI_Group_excl, libmpi), Cint,
        (MPI_Group, Cint, Ptr{Cint}, Ptr{MPI_Group}), group, length(ranks), ranks, newgroup)
    finalizer(free, newgroup)
    return newgroup
end

function Group_incl(group::Group, ranks::Vector{Cint})
    newgroup = Group()
    @mpichk ccall((:MPI_Group_incl, libmpi), Cint,
        (MPI_Group, Cint, Ptr{Cint}, Ptr{MPI_Group}), group, length(ranks), ranks, newgroup)
    finalizer(free, newgroup)
    return newgroup
end
