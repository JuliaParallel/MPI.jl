@mpi_handle Comm

const COMM_NULL = _Comm(MPI_COMM_NULL)

"""
    MPI.COMM_WORLD

A communicator containing all processes with which the local rank can communicate at
initialization. In a typical "static-process" model, this will be all processes.
"""
const COMM_WORLD = _Comm(MPI_COMM_WORLD)

"""
    MPI.COMM_SELF

A communicator containing only the local process.
"""
const COMM_SELF = _Comm(MPI_COMM_SELF)

Comm() = Comm(COMM_NULL.val)

function free(comm::Comm)
    if comm.val != COMM_NULL.val
        @mpichk ccall((:MPI_Comm_free, libmpi), Cint, (Ptr{MPI_Comm},), comm)
        refcount_dec()
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
    Comm_dup(comm::Comm)

# External links
$(_doc_external("MPI_Comm_dup"))
"""
function Comm_dup(comm::Comm)
    newcomm = Comm()
    @mpichk ccall((:MPI_Comm_dup, libmpi), Cint, (MPI_Comm, Ptr{MPI_Comm}), comm, newcomm)
    refcount_inc()
    finalizer(free, newcomm)
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
    refcount_inc()
    finalizer(free, newcomm)
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
    refcount_inc()
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
    refcount_inc()
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
    refcount_inc()
    finalizer(free, newcomm)
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
