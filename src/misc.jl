"""
    Get_processor_name()

Return the name of the processor, as a `String`.

# External links
$(_doc_external("MPI_Get_processor_name"))
"""
function Get_processor_name()
    proc_name = Array{UInt8}(undef, Consts.MPI_MAX_PROCESSOR_NAME)
    name_len = Ref{Cint}(0)
    API.MPI_Get_processor_name(proc_name, name_len)
    @assert name_len[] <= Consts.MPI_MAX_PROCESSOR_NAME
    GC.@preserve proc_name unsafe_string(pointer(proc_name))
end
