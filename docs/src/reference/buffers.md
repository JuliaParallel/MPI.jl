# Buffers

Buffers are used for sending and receiving data.

The element counts and displacements they carry are typed [`MPI.API.Count`](@ref) and
[`MPI.API.Displ`](@ref), which are `MPI_Count` and `MPI_Aint` where the MPI library
provides the MPI 4.0 large-count entry points and `Cint` otherwise. So against a library
implementing MPI 4.0 or later, messages of more than `typemax(Cint)` elements work
without any special handling; against an older one, constructing such a buffer raises an
`InexactError` rather than silently truncating the count.

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
