@mpi_handle Comm

const COMM_NULL = _Comm(MPI_COMM_NULL)
const COMM_WORLD = _Comm(MPI_COMM_WORLD)
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
    Comm_rank(comm:Comm)

The rank of the process in the particular communicator's group.

Returns an integer in the range `0:MPI.Comm_size()-1`.
"""
function Comm_rank(comm::Comm)
    rank = Ref{Cint}()
    @mpichk ccall((:MPI_Comm_rank, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, rank)
    Int(rank[])
end

"""
    Comm_size(comm:Comm)

The number of processes involved in communicator.
"""
function Comm_size(comm::Comm)
    size = Ref{Cint}()
    @mpichk ccall((:MPI_Comm_size, libmpi), Cint, (MPI_Comm, Ptr{Cint}), comm, size)
    Int(size[])
end

function Comm_dup(comm::Comm)
    newcomm = Comm()
    @mpichk ccall((:MPI_Comm_dup, libmpi), Cint, (MPI_Comm, Ptr{MPI_Comm}), comm, newcomm)
    refcount_inc()
    finalizer(free, newcomm)
    newcomm
end

function Comm_split(comm::Comm, color::Integer, key::Integer)
    newcomm = Comm()
    @mpichk ccall((:MPI_Comm_split, libmpi), Cint,
        (MPI_Comm, Cint, Cint, Ptr{MPI_Comm}), comm, color, key, newcomm)
    refcount_inc()
    finalizer(free, newcomm)
    newcomm
end

function Comm_split_type(comm::Comm,split_type::Integer,key::Integer; kwargs...)
    newcomm = Comm()
    @mpichk ccall((:MPI_Comm_split_type, libmpi), Cint,
          (MPI_Comm, Cint, Cint, MPI_Info, Ptr{MPI_Comm}),
          comm, split_type, key, Info(kwargs...), newcomm)
    refcount_inc()
    finalizer(free, newcomm)
    newcomm
end

function Comm_get_parent()
    comm = Comm()
    @mpichk ccall((:MPI_Comm_get_parent, libmpi), Cint, (Ptr{MPI_Comm},), comm)
    comm
end

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

function Intercomm_merge(intercomm::Comm, flag::Bool)
    newcomm = Comm()
    @mpichk ccall((:MPI_Intercomm_merge, libmpi), Cint,
        (MPI_Comm, Cint, Ptr{MPI_Comm}), intercomm, Cint(flag), newcomm)
    refcount_inc()
    finalizer(free, newcomm)
    return newcomm
end

function universe_size(comm::Comm)
    flag = Ref{Cint}()
    result = Ref(Ptr{Cvoid}(C_NULL))
    # int MPI_Comm_get_attr(MPI_Comm comm, int comm_keyval, void *attribute_val, int *flag)
    @mpichk ccall((:MPI_Comm_get_attr, libmpi), Cint,
        (MPI_Comm, Cint, Ptr{Cvoid}, Ptr{Cint}), comm, MPI_UNIVERSE_SIZE, result, flag)
    if flag[] == 0
        error("Attribute MPI_UNIVERSE_SIZE is not attached")
    end
    unsafe_load(reinterpret(Ptr{Cint}, result[]))
end
