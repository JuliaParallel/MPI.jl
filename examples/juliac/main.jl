module MPIC

# Compileable main function corresponding to `int main(int argc, char** argv)`
Base.@ccallable function main(argc::Cint, argv::Ptr{Ptr{UInt8}})::Cint
    # Load command line arguments. Note that the first argument is the
    # executable name so we skip it.
    args = Vector{String}(undef, argc - 1)
    for i in 2:argc
        argptr = unsafe_load(argv, i)
        arg = unsafe_string(argptr)
        args[i - 1] = arg
    end
    return 0
end

# Tell juliac about the main entrypoint
Base.Experimental.entrypoint(main, (Cint, Ptr{Ptr{UInt8}}))

end
