# Buffers

Buffers are used for sending and receiving data.

The buffers' element counts and displacements have the types [`MPI.API.Count`](@ref) and
[`MPI.API.Displ`](@ref). These are `MPI_Count` and `MPI_Aint` if the MPI library
provides the MPI 4.0 large-count entry points, and are `Cint` otherwise. That is, with a library
implementing MPI 4.0 or later, messages of more than `typemax(Cint)` elements work
without any special handling; with an older one, constructing such a buffer raises an
`InexactError`. (The count is never silently truncated.)

MPI.jl provides the following buffer types:

```@docs
MPI.IN_PLACE
MPI.Buffer
MPI.Buffer_send
MPI.UBuffer
MPI.VBuffer
MPI.RBuffer
MPI.MPIPtr
```
