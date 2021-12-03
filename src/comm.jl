"""
    MPI.Comm

An MPI Communicator object.
"""
mutable struct Comm
    val::MPI_Comm
end
Base.:(==)(a::Comm, b::Comm) = a.val == b.val
Base.cconvert(::Type{MPI_Comm}, comm::Comm) = comm.val
Base.unsafe_convert(::Type{Ptr{MPI_Comm}}, comm::Comm) = convert(Ptr{MPI_Comm}, pointer_from_objref(comm))

const COMM_NULL = Comm(MPI_COMM_NULL)
add_load_time_hook!(() -> COMM_NULL.val = MPI_COMM_NULL)

"""
    MPI.COMM_WORLD

A communicator containing all processes with which the local rank can communicate at
initialization. In a typical "static-process" model, this will be all processes.
"""
const COMM_WORLD = Comm(MPI_COMM_WORLD)
add_load_time_hook!(() -> COMM_WORLD.val = MPI_COMM_WORLD)

"""
    MPI.COMM_SELF

A communicator containing only the local process.
"""
const COMM_SELF = Comm(MPI_COMM_SELF)
add_load_time_hook!(() -> COMM_SELF.val = MPI_COMM_SELF)

Comm() = Comm(COMM_NULL.val)

# MPI_Comm_free is a collective call and cannot be just called from a finalizer
function free(comm::Comm)
    if comm != COMM_NULL && !Finalized()
        @mpichk ccall((:MPI_Comm_free, libmpi), Cint, (Ptr{MPI_Comm},), comm)
    end
    return nothing
end
# function free(comm::Comm)
#     # MPI_Comm_free is a collective call and cannot be just called
#     # from a finalizer
#     #TODO if comm != COMM_NULL && !Finalized()
#     #TODO     # Transfer the MPI handle to a copy, so that the original
#     #TODO     # `comm` object can be freed right away
#     #TODO     newcomm = Comm(comm.val)
#     #TODO     comm.val = COMM_NULL.val
#     #TODO     # Start an asynchronous task that waits for all processes in
#     #TODO     # the communicator to be done, and then calls `Comm_free`
#     #TODO     @async begin
#     #TODO         # With proper multi-threading this could be a regular
#     #TODO         # `Barrier` without spinning
#     #TODO         req = Ibarrier(newcomm)
#     #TODO         while !Test(req)
#     #TODO             yield()
#     #TODO             Finalized() && return
#     #TODO         end
#     #TODO         # This will set the handle in `newcomm` to
#     #TODO         # `MPI_COMM_NULL`, and its finalizer will thus be trivial
#     #TODO         Comm_free(newcomm)
#     #TODO     end
#     #TODO end
#     return nothing
# end


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
    #TODO finalizer(free, newgroup)
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
    #TODO finalizer(free, newgroup)
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
    #TODO finalizer(free, newcomm)
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
    #TODO finalizer(free, newcomm)
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
    #TODO finalizer(free, newcomm)
    newcomm
end

"""
    Comm_split(comm::Comm, color::Integer, key::Integer)

# External links
$(_doc_external("MPI_Comm_split"))
"""
function Comm_split(comm::Comm, color::Integer, key::Integer)
    newcomm = Comm()
    @mpichk ccall((:MPI_Comm_split, libmpi), Cint,
        (MPI_Comm, Cint, Cint, Ptr{MPI_Comm}), comm, color, key, newcomm)
    #TODO finalizer(free, newcomm)
    newcomm
end

"""
    Comm_split_type(comm::Comm, split_type::Integer, key::Integer; kwargs...)

# External links
$(_doc_external("MPI_Comm_split_type"))
"""
function Comm_split_type(comm::Comm,split_type::Integer,key::Integer; kwargs...)
    newcomm = Comm()
    @mpichk ccall((:MPI_Comm_split_type, libmpi), Cint,
          (MPI_Comm, Cint, Cint, MPI_Info, Ptr{MPI_Comm}),
          comm, split_type, key, Info(kwargs...), newcomm)
    #TODO finalizer(free, newcomm)
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
    #TODO finalizer(free, intercomm)
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
    #TODO finalizer(free, newcomm)
    return newcomm
end

"""
    universe_size()

The total number of available slots, or `nothing` if it is not defined. This is determined by the `MPI_UNIVERSE_SIZE` attribute of `COMM_WORLD`.

This is typically dependent on the MPI implementation: for MPICH-based implementations, this is specified by the `-usize` argument. OpenMPI defines a default value based on the number of processes available.
"""
function universe_size()
    flag = Ref{Cint}()
    result = Ref(Ptr{Cint}(C_NULL))
    # int MPI_Comm_get_attr(MPI_Comm comm, int comm_keyval, void *attribute_val, int *flag)
    @mpichk ccall((:MPI_Comm_get_attr, libmpi), Cint,
        (MPI_Comm, Cint, Ptr{Cvoid}, Ptr{Cint}), MPI.COMM_WORLD, MPI_UNIVERSE_SIZE, result, flag)
    if flag[] == 0
        return nothing
    end
    Int(unsafe_load(result[]))
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
