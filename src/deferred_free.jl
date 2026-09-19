"""
    MPI.deferred_free(obj)

Finalizer for MPI handle objects (communicators, groups, datatypes, operators, infos,
requests): instead of freeing the underlying MPI handle immediately, enqueue it to be
freed before the next MPI call.

Finalizers must not call MPI functions directly: a finalizer can run at any point of
the program where the garbage collector is invoked, including concurrently with an MPI
call made by another thread (which is permitted only when MPI was initialized with
[`MPI.THREAD_MULTIPLE`](@ref ThreadLevel)), or in the middle of an MPI call which runs
a Julia callback, such as a reduction with a user-defined operator (calling MPI
functions inside such callbacks is erroneous).

Use [`free`](@ref) to immediately free the handle instead.
"""
function deferred_free(obj)
    f = deferred_free_fn(obj)
    if f !== nothing && !API.defer_free!(f)
        # the queue lock is contended: re-register the finalizer to retry at the next
        # garbage collection
        finalizer(deferred_free, obj)
    end
    return nothing
end

"""
    MPI.deferred_free_fn(obj) -> Union{Function,Nothing}

Return a closure which frees the MPI handle underlying `obj` without referencing `obj`
itself, or `nothing` if there is nothing to free (e.g. the handle is null).  The
closure is called before a later MPI call, after `obj` has been garbage-collected, so
it must capture the raw handle value, not the object, and it must capture any other
object which has to be kept alive until the handle is freed (e.g. the communication
buffer of a request).
"""
function deferred_free_fn end
