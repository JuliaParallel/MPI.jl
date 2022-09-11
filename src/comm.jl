"""
    MPI.Comm

An MPI Communicator object.
"""
mutable struct Comm
    val::MPI_Comm
end
Base.:(==)(a::Comm, b::Comm) = a.val == b.val
Base.cconvert(::Type{MPI_Comm}, comm::Comm) = comm
Base.unsafe_convert(::Type{MPI_Comm}, comm::Comm) = comm.val
Base.unsafe_convert(::Type{Ptr{MPI_Comm}}, comm::Comm) = convert(Ptr{MPI_Comm}, pointer_from_objref(comm))


const COMM_NULL = Comm(Consts.MPI_COMM_NULL[])
add_load_time_hook!(() -> COMM_NULL.val = Consts.MPI_COMM_NULL[])

"""
    MPI.COMM_WORLD

A communicator containing all processes with which the local rank can communicate at
initialization. In a typical "static-process" model, this will be all processes.
"""
const COMM_WORLD = Comm(Consts.MPI_COMM_WORLD[])
add_load_time_hook!(() -> COMM_WORLD.val = Consts.MPI_COMM_WORLD[])

"""
    MPI.COMM_SELF

A communicator containing only the local process.
"""
const COMM_SELF = Comm(Consts.MPI_COMM_SELF[])
add_load_time_hook!(() -> COMM_SELF.val = Consts.MPI_COMM_SELF[])

Comm() = Comm(COMM_NULL.val)

function free(comm::Comm)
    if comm != COMM_NULL && !Finalized()
        # int MPI_Comm_free(MPI_Comm *comm)
        @mpichk ccall((:MPI_Comm_free, libmpi), Cint, (Ptr{MPI_Comm},), comm)
    end
    return nothing
end


"""
    Comm_rank(comm::Comm)

The rank of the process in the particular communicator's group.

Returns an integer in the range `0:MPI.Comm_size()-1`.

# See also
- [`MPI.Comm_size`](@ref).

# External links
$(_doc_external("MPI_Comm_rank"))
"""
function Comm_rank(comm::Comm)
    rank = Ref{Cint}()
    @mpichk ccall((:MPI_Comm_rank, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, rank)
    Int(rank[])
end

"""
    Comm_size(comm::Comm)

The number of processes involved in communicator.

# See also
- [`MPI.Comm_rank`](@ref).

# External links
$(_doc_external("MPI_Comm_size"))
"""
function Comm_size(comm::Comm)
    size = Ref{Cint}()
    @mpichk ccall((:MPI_Comm_size, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, size)
    Int(size[])
end

"""
    Comm_group(comm::Comm)

Accesses the group associated with given communicator.

# External links
$(_doc_external("MPI_Comm_group"))
"""
function Comm_group(comm::Comm)
    newgroup = Group()
    @mpichk ccall((:MPI_Comm_group, libmpi), Cint,
        (MPI_Comm, Ptr{MPI_Group}), comm, newgroup)
    finalizer(free, newgroup)
    newgroup
end

"""
    Comm_remote_group(comm::Comm)

Accesses the remote group associated with the given inter-communicator.

# External links
$(_doc_external("MPI_Comm_remote_group"))
"""
function Comm_remote_group(comm::Comm)
    newgroup = Group()
    @mpichk ccall((:MPI_Comm_remote_group, libmpi), Cint,
        (MPI_Comm, Ptr{MPI_Group}), comm, newgroup)
    finalizer(free, newgroup)
    newgroup
end

"""
    Comm_create(comm::Comm, group::Group)

Collectively creates a new communicator.

# See also
- [`MPI.Comm_create_group`](@ref) for the noncollective operation

# External links
$(_doc_external("MPI_Comm_create"))
"""
function Comm_create(comm::Comm, group::Group)
    newcomm = Comm()
    @mpichk ccall((:MPI_Comm_create, libmpi), Cint,
          (MPI_Comm, MPI_Group, Ptr{MPI_Comm}),
          comm, group, newcomm)
    finalizer(free, newcomm)
    newcomm
end

"""
    Comm_create_group(comm::Comm, group::Group, tag::Integer)

Noncollectively creates a new communicator.

# See also
- [`MPI.Comm_create`](@ref) for the noncollective operation

# External links
$(_doc_external("MPI_Comm_create_group"))
"""
function Comm_create_group(comm::Comm, group::Group, tag::Integer)
    newcomm = Comm()
    @mpichk ccall((:MPI_Comm_create_group, libmpi), Cint,
        (MPI_Comm, MPI_Group, Cint, Ptr{MPI_Comm}), comm, group, tag, newcomm)
    finalizer(free, newcomm)
    newcomm
end

"""
    Comm_dup(comm::Comm)

# External links
$(_doc_external("MPI_Comm_dup"))
"""
function Comm_dup(comm::Comm)
    newcomm = Comm()
    @mpichk ccall((:MPI_Comm_dup, libmpi), Cint, (MPI_Comm, Ptr{MPI_Comm}), comm, newcomm)
    finalizer(free, newcomm)
    newcomm
end

"""
    Comm_split(comm::Comm, color::Union{Integer,Nothing}, key::Integer)

Partition the communicator `comm`, one for each value of `color`, returning a
new communicator. Within each group, the processes are ranked in the order of
`key`, with ties broken by the order of `comm`.

`color` should be a non-negative integer, or `nothing`, in which case a null
communicator is returned for that rank.

# External links
$(_doc_external("MPI_Comm_split"))
"""
function Comm_split(comm::Comm, color::Union{Integer, Nothing}, key::Integer)
    if isnothing(color)
        color = Consts.MPI_UNDEFINED[]
    end
    newcomm = Comm()
    @mpichk ccall((:MPI_Comm_split, libmpi), Cint,
        (MPI_Comm, Cint, Cint, Ptr{MPI_Comm}), comm, color, key, newcomm)
    finalizer(free, newcomm)
    newcomm
end

mutable struct SplitType
    val::Cint
end
const COMM_TYPE_SHARED = SplitType(-1)
add_load_time_hook!(() -> COMM_TYPE_SHARED.val     = Consts.MPI_COMM_TYPE_SHARED[])


"""
    Comm_split_type(comm::Comm, split_type, key::Integer; kwargs...)

Partitions the communicator `comm` based on `split_type`, returning a new
communicator. Within each group, the processes are ranked in the order of
`key`, with ties broken by the order of `comm`.

Currently only one `split_type` is provided:

- `MPI.COMM_TYPE_SHARED`: splits the communicator into subcommunicators, each of
  which can create a shared memory region.

# External links
$(_doc_external("MPI_Comm_split_type"))
"""
function Comm_split_type(comm::Comm, split_type, key::Integer; kwargs...)
    if isnothing(split_type)
        split_type = Consts.MPI_UNDEFINED[]
    elseif split_type isa SplitType
        split_type = split_type.val
    end
    newcomm = Comm()
    @mpichk ccall((:MPI_Comm_split_type, libmpi), Cint,
          (MPI_Comm, Cint, Cint, MPI_Info, Ptr{MPI_Comm}),
          comm, split_type, key, Info(kwargs...), newcomm)
    finalizer(free, newcomm)
    newcomm
end

"""
    Comm_get_parent()

# External links
$(_doc_external("MPI_Comm_get_parent"))
"""
function Comm_get_parent()
    comm = Comm()
    @mpichk ccall((:MPI_Comm_get_parent, libmpi), Cint, (Ptr{MPI_Comm},), comm)
    comm
end

"""
    Comm_spawn(command, argv::Vector{String}, nprocs::Integer, comm::Comm[, errors::Vector{Cint}]; kwargs...)

# External links
$(_doc_external("MPI_Comm_spawn"))
"""
function Comm_spawn(command::String, argv::Vector{String}, nprocs::Integer,
                    comm::Comm, errors = Vector{Cint}(undef, nprocs); kwargs...)
    intercomm = Comm()
    # int MPI_Comm_spawn(const char *command, char *argv[], int maxprocs,
    #                    MPI_Info info, int root, MPI_Comm comm, MPI_Comm *intercomm,
    #                    int array_of_errcodes[])
    @mpichk ccall((:MPI_Comm_spawn, libmpi), Cint,
         (Cstring, Ptr{Ptr{Cchar}}, Cint, MPI_Info, Cint, MPI_Comm, Ptr{MPI_Comm}, Ptr{Cint}),
          command, argv, nprocs, Info(kwargs...), 0, comm, intercomm, errors)
    finalizer(free, intercomm)
    return intercomm
end

"""
    Intercomm_merge(intercomm::Comm, flag::Bool)

# External links
$(_doc_external("MPI_Intercomm_merge"))
"""
function Intercomm_merge(intercomm::Comm, flag::Bool)
    newcomm = Comm()
    @mpichk ccall((:MPI_Intercomm_merge, libmpi), Cint,
        (MPI_Comm, Cint, Ptr{MPI_Comm}), intercomm, Cint(flag), newcomm)
    finalizer(free, newcomm)
    return newcomm
end


function unsafe_get_attr(comm::Comm, keyval::Integer)
    flag = Ref{Cint}()
    result = Ref(C_NULL)
    # int MPI_Comm_get_attr(MPI_Comm comm, int comm_keyval, void *attribute_val, int *flag)
    @mpichk ccall((:MPI_Comm_get_attr, libmpi), Cint,
        (MPI_Comm, Cint, Ptr{Cvoid}, Ptr{Cint}), comm, keyval, result, flag)
    if flag[] == 0
        return nothing
    end
    return result[]
end


"""
    universe_size()

The total number of available slots, or `nothing` if it is not defined. This is determined by the `MPI_UNIVERSE_SIZE` attribute of `COMM_WORLD`.

This is typically dependent on the MPI implementation: for MPICH-based implementations, this is specified by the `-usize` argument. OpenMPI defines a default value based on the number of processes available.
"""
function universe_size()
    ptr = unsafe_get_attr(COMM_WORLD, Consts.MPI_UNIVERSE_SIZE[])
    isnothing(ptr) && return nothing
    return Int(unsafe_load(Ptr{Cint}(ptr)))
end

"""
    tag_ub()

The maximum value tag value for point-to-point operations.
"""
function tag_ub()
    ptr = something(unsafe_get_attr(COMM_WORLD, Consts.MPI_TAG_UB[]))
    return Int(unsafe_load(Ptr{Cint}(ptr)))
end


"""
    Comm_compare(comm1::Comm, comm2::Comm)::MPI.Comparison

Compare two communicators and their underlying groups, returning an element of the [`Comparison`](@ref) enum.

# External links
$(_doc_external("MPI_Comm_compare"))
"""
function Comm_compare(comm1::Comm, comm2::Comm)
    result = Ref{Cint}()
    @mpichk ccall((:MPI_Comm_compare, libmpi), Cint,
                  (MPI_Comm, MPI_Comm, Ptr{Cint}), comm1, comm2, result)
    return Comparison(result[])
end
