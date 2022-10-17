import Base: eltype


const SUCCESS = Cint(0)

@static if VERSION >= v"1.8"
    PROC_NULL::Cint = typemin(Cint)
    ANY_SOURCE::Cint = typemin(Cint)
    ANY_TAG::Cint = typemin(Cint)
end
add_load_time_hook!() do
    global PROC_NULL = API.MPI_PROC_NULL[]
    global ANY_SOURCE = API.MPI_ANY_SOURCE[]
    global ANY_TAG = API.MPI_ANY_TAG[]
end

"""
    MPI.PROC_NULL

A dummy value that can be used instead of a rank wherever a source or a
destination argument is required in a call. A send
"""
PROC_NULL

"""
    MPI.ANY_SOURCE

A wild card value for receive or probe operations that matches any source rank.
"""
ANY_SOURCE

"""
    MPI.ANY_TAG

A wild card value for receive or probe operations that matches any tag.
"""
ANY_TAG

"""
    MPI.Status

The status of an MPI receive communication. It has 3 accessible fields

- `source`: source of the received message
- `tag`: tag of the received message
- `error`: error code. This is only set if a function returns multiple statuses.

Additionally, the accessor function [`MPI.Get_count`](@ref) can be used to determine the
number of entries received.
"""
const Status = MPI_Status

const STATUS_ZERO = Status(map(zero,fieldtypes(Status))...)

function Base.getproperty(status::Status, name::Symbol)
    name ≡ :error && return status.MPI_ERROR
    name ≡ :source && return status.MPI_SOURCE
    name ≡ :tag && return status.MPI_TAG
    return getfield(status, name)
end
function Base.setproperty!(status::Status, name::Symbol, x)
    name ≡ :error && return (status.MPI_ERROR = x)
    name ≡ :source && return (status.MPI_SOURCE = x)
    name ≡ :tag && return (status.MPI_TAG = x)
    return setfield!(status, name, x)
end

# TODO: I don't think we need `SentinelPtr`; we should remove it
Base.cconvert(::Type{Ptr{Status}}, x::SentinelPtr) = x
Base.unsafe_convert(::Type{Ptr{Status}}, x::SentinelPtr) = reinterpret(Ptr{Status}, x)

# TODO: Deprecate these functions
Get_source(status::Status) = Int(status.source)
Get_tag(status::Status) = Int(status.tag)
Get_error(status::Status) = Int(status.error)

"""
    MPI.Request

An MPI Request object, representing a non-blocking communication. This also contains a
reference to the buffer used in the communication to ensure it isn't garbage-collected
during communication.

The status of a Request can be checked by the [`Wait`](@ref) and [`Test`](@ref) functions
or their multiple-request variants, which will deallocate the request once it is
determined to be complete. Alternatively, it will be deallocated at finalization, meaning
that it is safe to ignore the request objects if the status of the communication can be
checked by other means.

See also [`Cancel!`](@ref).
"""
mutable struct Request{T}
    val::MPI_Request
    buffer::T
end
Base.:(==)(a::Request, b::Request) = a.val == b.val
Base.cconvert(::Type{MPI_Request}, request::Request) = request
Base.unsafe_convert(::Type{MPI_Request}, request::Request) = request.val
Base.unsafe_convert(::Type{Ptr{MPI_Request}}, request::Request) = convert(Ptr{MPI_Request}, pointer_from_objref(request))

const REQUEST_NULL = Request(API.MPI_REQUEST_NULL[], nothing)
add_load_time_hook!(() -> REQUEST_NULL.val = API.MPI_REQUEST_NULL[])

@inline Request(data::T) where {T} = Request{T}(REQUEST_NULL.val, data)
isnull(req::Request) = req == REQUEST_NULL

function free(req::Request)
    if req != REQUEST_NULL && !MPI.Finalized()
        # int MPI_Request_free(MPI_Request *req)
        API.MPI_Request_free(req)
    end
    # req.buffer = nothing
    return nothing
end


"""
    status = Probe(src::Integer, tag::Integer, comm::Comm)

Blocks until there is a message that can be received matching `src`, `tag` and
`comm`. Returns the corresponding [`Status`](@ref) object.

# External links
$(_doc_external("MPI_Probe"))
"""
function Probe(src::Integer, tag::Integer, comm::Comm)
    stat_ref = Ref(STATUS_ZERO)
    API.MPI_Probe(src, tag, comm, stat_ref)
    stat_ref[]
end

"""
    ismessage, (status|nothing) = Iprobe(src::Integer, tag::Integer, comm::Comm)

Checks if there is a message that can be received matching `src`, `tag` and `comm`. If so,
returns a tuple `true` and a [`Status`](@ref) object, otherwise returns a tuple `false, nothing`.

# External links
$(_doc_external("MPI_Iprobe"))
"""
function Iprobe(src::Integer, tag::Integer, comm::Comm)
    flag = Ref{Cint}()
    stat_ref = Ref(STATUS_ZERO)
    API.MPI_Iprobe(src, tag, comm, flag, stat_ref)
    flag[] == 0 && return false, nothing
    true, stat_ref[]
end

"""
    MPI.Get_count(status::Status, T)

The number of entries received. `T` should match the argument provided by the receive call that set the status variable.

If the number of entries received exceeds the limits of the count parameter, then it returns `MPI_UNDEFINED`.

# External links
$(_doc_external("MPI_Get_count"))
"""
function Get_count(stat::Status, datatype::Datatype)
    count = Ref{Cint}()
    API.MPI_Get_count(Ref(stat), datatype, count)
    Int(count[])
end
Get_count(stat::Status, ::Type{T}) where {T} = Get_count(stat, Datatype(T))


"""
    Wait(req::Request)
    status = Wait(req::Request, Status)

Block until the request `req` is complete and deallocated.

The `Status` argument returns the `Status` of the completed request.

# External links
$(_doc_external("MPI_Wait"))
"""
function Wait(req::Request, status::Union{Ref{Status}, Nothing}=nothing)
    # int MPI_Wait(MPI_Request *request, MPI_Status *status)
    API.MPI_Wait(req, something(status, API.MPI_STATUS_IGNORE[]))
    # only clear the buffer for non-persistent requests
    # isnull(req) && (req.buffer = nothing)
    return nothing
end
function Wait(req::Request, ::Type{Status})
    status = Ref(STATUS_ZERO)
    Wait(req, status)
    return status[]
end

"""
    flag = Test(req::Request)
    flag, status = Test(req::Request, Status)

Check if the request `req` is complete. If so, the request is deallocated and `flag = true` is returned. Otherwise `flag = false`.

The `Status` argument additionally returns the `Status` of the completed request.

# External links
$(_doc_external("MPI_Test"))
"""
function Test(req::Request, status::Union{Ref{Status}, Nothing}=nothing)
    flag = Ref{Cint}()
    # int MPI_Test(MPI_Request *request, int *flag, MPI_Status *status)
    API.MPI_Test(req, flag, something(status, API.MPI_STATUS_IGNORE[]))
    isnull(req) && (req.buffer = nothing)
    return flag[] != 0
end
function Test(req::Request, ::Type{Status})
    status = Ref(STATUS_ZERO)
    flag = Test(req, status)
    return flag, status[]
end


"""
    RequestSet(requests::Vector{Request})
    RequestSet() # create an empty RequestSet

A wrapper for an array of `Request`s that can be used to reduce intermediate memory
allocations in [`Waitall`](@ref), [`Testall`](@ref), [`Waitany`](@ref), [`Testany`](@ref),
[`Waitsome`](@ref) or [`Testsome`](@ref).
"""
struct RequestSet <: AbstractVector{Request}
    requests::Vector{Request}
    vals::Vector{MPI_Request}
end

function RequestSet(requests::Vector{Request})
    n = length(requests)
    vals = Vector{MPI_Request}(undef, n)
    for i = 1:n
        vals[i] = requests[i].val
    end
    return RequestSet(requests, vals)
end
RequestSet() = RequestSet(Request[])

Base.length(reqs::RequestSet) = length(reqs.requests)
Base.getindex(reqs::RequestSet, i::Integer) = reqs.requests[i]
function Base.setindex!(reqs::RequestSet, req::Request, i::Integer)
    reqs.vals[i] = req.val
    reqs.requests[i] = req
end

function Base.push!(reqs::RequestSet, req::Request)
    push!(reqs.vals, req.val)
    push!(reqs.requests, req)
end

function update!(reqs::RequestSet, i::Integer)
    req = reqs[i]
    req.val = reqs.vals[i]
    isnull(req) && (req.buffer = nothing)
end
update!(reqs::RequestSet) = foreach(i -> update!(reqs, i), 1:length(reqs))


"""
    Waitall(reqs::AbstractVector{Request}[, statuses::Vector{Status}])
    statuses = Waitall(reqs::AbstractVector{Request}, Status)

Block until all active requests in the array `reqs` are complete.

The optional `statuses` or `Status` argument can be used to obtain the return `Status` of
each request.

# See also
- [`RequestSet`](@ref) can be used to minimize allocations

# External links
$(_doc_external("MPI_Waitall"))
"""
function Waitall(reqs::RequestSet, statuses::Union{AbstractVector{Status},Nothing}=nothing)
    n = length(reqs)
    n == 0 && return nothing
    @assert isnothing(statuses) || length(statuses) >= n
    # int MPI_Waitall(int count, MPI_Request array_of_requests[],
    #                 MPI_Status array_of_statuses[])
    API.MPI_Waitall(n, reqs.vals, something(statuses, API.MPI_STATUSES_IGNORE[]))
    update!(reqs)
    return nothing
end
function Waitall(reqs::RequestSet, ::Type{Status})
    statuses = Array{Status}(undef, length(reqs))
    Waitall(reqs, statuses)
    return statuses
end
Waitall(reqs::AbstractVector{Request}, args...) = Waitall(RequestSet(reqs), args...)


"""
    flag = Testall(reqs::AbstractVector{Request}[, statuses::Vector{Status}])
    flag, statuses = Testall(reqs::AbstractVector{Request}, Status)

Check if all active requests in the array `reqs` are complete. If so, the requests are
deallocated and `true` is returned. Otherwise no requests are modified, and `false` is
returned.

The optional `statuses` or `Status` argument can be used to obtain the return `Status` of
each request.

# See also
- [`RequestSet`](@ref) can be used to minimize allocations

# External links
$(_doc_external("MPI_Testall"))
"""
function Testall(reqs::RequestSet, statuses::Union{AbstractVector{Status},Nothing}=nothing)
    n = length(reqs)
    flag = Ref{Cint}()
    @assert isnothing(statuses) || length(statuses) >= n
    # int MPI_Testall(int count, MPI_Request array_of_requests[], int *flag,
    #                 MPI_Status array_of_statuses[])
    API.MPI_Testall(n, reqs.vals, flag, something(statuses, API.MPI_STATUSES_IGNORE[]))
    update!(reqs)
    return flag[] != 0
end
function Testall(reqs::RequestSet, ::Type{Status})
    statuses = Array{Status}(undef, length(reqs))
    flag = Testall(reqs, statuses)
    return flag, statuses
end
Testall(reqs::Vector{Request}, args...) = Testall(RequestSet(reqs), args...)

"""
    i = Waitany(reqs::AbstractVector{Request}[, status::Ref{Status}])
    i, status = Waitany(reqs::AbstractVector{Request}, Status)

Blocks until one of the requests in the array `reqs` is complete: if more than one is
complete, one is chosen arbitrarily. The request is deallocated and the (1-based) index
`i` of the completed request is returned.

If there are no active requests, then `i = nothing`.

The optional `status` argument can be used to obtain the return `Status` of the request.

# See also
- [`RequestSet`](@ref) can be used to minimize allocations

# External links
$(_doc_external("MPI_Waitany"))
"""
function Waitany(reqs::RequestSet, status::Union{Ref{Status}, Nothing}=nothing)
    ref_idx = Ref{Cint}()
    n = length(reqs)
    # int MPI_Waitany(int count, MPI_Request array_of_requests[], int *index,
    #                 MPI_Status *status)
    API.MPI_Waitany(n, reqs.vals, ref_idx, something(status, API.MPI_STATUS_IGNORE[]))
    idx = ref_idx[]
    idx == API.MPI_UNDEFINED[] && return nothing
    i = Int(idx) + 1
    update!(reqs, i)
    return i
end
function Waitany(reqs::RequestSet, ::Type{Status})
    status = Ref(STATUS_ZERO)
    i = Waitany(reqs, status)
    return i, status[]
end
Waitany(reqs::Vector{Request}, args...) = Waitany(RequestSet(reqs), args...)

"""
    flag, idx = Testany(reqs::AbstractVector{Request}[, status::Ref{Status}])
    flag, idx, status = Testany(reqs::AbstractVector{Request}, Status)

Checks if any one of the requests in the array `reqs` is complete.

If one or more requests are complete, then one is chosen arbitrarily, deallocated. `flag =
true` and its (1-based) index `idx` is returned.

If there are no completed requests, then `flag = false` and `idx = nothing` is returned.

If there are no active requests, `flag = true` and `idx = nothing`.

The optional `status` argument can be used to obtain the return `Status` of the request.

# See also
- [`RequestSet`](@ref) can be used to minimize allocations

# External links
$(_doc_external("MPI_Testany"))
"""
function Testany(reqs::RequestSet, status::Union{Ref{Status}, Nothing}=nothing)
    ref_idx = Ref{Cint}()
    rflag = Ref{Cint}()
    n = length(reqs)
    # int MPI_Testany(int count, MPI_Request array_of_requests[], int *index,
    #                 int *flag, MPI_Status *status)
    API.MPI_Testany(n, reqs.vals, ref_idx, rflag, something(status, API.MPI_STATUS_IGNORE[]))
    idx = ref_idx[]
    flag = rflag[] != 0
    idx == API.MPI_UNDEFINED[] && return flag, nothing
    i = Int(idx) + 1
    update!(reqs, i)
    return flag, i
end
function Testany(reqs::RequestSet, ::Type{Status})
    status = Ref(STATUS_ZERO)
    flag, i = Testany(reqs, status)
    return flag, i, status[]
end
Testany(reqs::Vector{Request}, args...) = Testany(RequestSet(reqs), args...)

"""
    inds = Waitsome(reqs::AbstractVector{Request}[, statuses::Vector{Status}])

Block until at least one of the active requests in the array `reqs` is complete. The
completed requests are deallocated, and an array `inds` of their indices in `reqs` is returned.

If there are no active requests, then `inds = nothing`.

The optional `statuses` argument can be used to obtain the return `Status` of each
completed request.

# See also
- [`RequestSet`](@ref) can be used to minimize allocations

# External links
$(_doc_external("MPI_Waitsome"))
"""
function Waitsome(reqs::RequestSet, statuses::Union{AbstractVector{Status},Nothing}=nothing)
    ref_nout = Ref{Cint}()
    n = length(reqs)
    idxs = Vector{Cint}(undef, n)
    @assert isnothing(statuses) || length(statuses) >= n

    # int MPI_Waitsome(int incount, MPI_Request array_of_requests[],
    #                  int *outcount, int array_of_indices[],
    #                  MPI_Status array_of_statuses[])
    API.MPI_Waitsome(n, reqs.vals, ref_nout, idxs, something(statuses, API.MPI_STATUSES_IGNORE[]))
    nout = Int(ref_nout[])
    # This can happen if there were no valid requests
    nout == API.MPI_UNDEFINED[] && return nothing
    update!(reqs)
    return [Int(idxs[i]) + 1 for i = 1:nout]
end
function Waitsome(reqs::RequestSet, ::Type{Status})
    statuses = Array{Status}(undef, length(reqs))
    inds = Waitsome(reqs, statuses)
    resize!(statuses, isnothing(inds) ? 0 : length(inds))
    return inds, statuses
end
Waitsome(reqs::Vector{Request}, args...) = Waitsome(RequestSet(reqs), args...)

"""
    inds = Testsome(reqs::AbstractVector{Request}[, statuses::Vector{Status}])

Similar to [`Waitsome`](@ref) except that if no operations have completed it will return
an empty array.

If there are no active requests, then the function returns `nothing`.

The optional `statuses` argument can be used to obtain the return `Status` of each
completed request.

# See also
- [`RequestSet`](@ref) can be used to minimize allocations

# External links
$(_doc_external("MPI_Testsome"))
"""
function Testsome(reqs::RequestSet, statuses::Union{AbstractVector{Status},Nothing}=nothing)
    ref_nout = Ref{Cint}()
    n = length(reqs)
    idxs = Vector{Cint}(undef, n)
    @assert isnothing(statuses) || length(statuses) >= n

    # int MPI_Testsome(int incount, MPI_Request array_of_requests[],
    #                  int *outcount, int array_of_indices[],
    #                  MPI_Status array_of_statuses[])
    API.MPI_Testsome(n, reqs.vals, ref_nout, idxs, something(statuses, API.MPI_STATUSES_IGNORE[]))
    nout = Int(ref_nout[])
    # This can happen if there were no valid requests
    nout == API.MPI_UNDEFINED[] && return nothing
    update!(reqs)
    return [Int(idxs[i]) + 1 for i = 1:nout]
end
function Testsome(reqs::RequestSet, ::Type{Status})
    statuses = Array{Status}(undef, length(reqs))
    inds = Testsome(reqs, statuses)
    resize!(statuses, isnothing(inds) ? 0 : length(inds))
    return inds, statuses
end
Testsome(reqs::Vector{Request}, args...) = Testsome(RequestSet(reqs), args...)

"""
    Cancel!(req::Request)

Marks a pending [`Irecv!`](@ref) operation for cancellation (cancelling a [`Isend`](@ref),
while supported in some implementations, is deprecated as of MPI 3.1). Note that the
request is not deallocated, and can still be queried using the test or wait functions.

# External links
$(_doc_external("MPI_Cancel"))
"""
function Cancel!(req::Request)
    # int MPI_Cancel(MPI_Request *request)
    API.MPI_Cancel(req)
    nothing
end
