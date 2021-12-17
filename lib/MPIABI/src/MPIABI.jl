module MPIABI

using Preferences

function known_abis()
    return (:MicrosoftMPI, :MPICH, :OpenMPI, :MPItrampoline)
end

# const abi = begin
#     _abi = @load_preference("abi", nothing)
#     if isnothing(_abi)
#        _abi = find_abi()
#        @set_preference!("abi" => _abi)
#     end
#     _abi
# end

const abi = @load_preference("abi", Sys.iswindows() ? :MicrosoftMPI : :MPICH)

function __init__()
    if Sys.iswindows()
        if abi != :MicrosoftMPI
            @error """
                The MPI ABI is not compatible with the current platform.
                Please set the MPI ABI to :MicrosoftMPI.
            """
        end
    end
end

function set_abi(abi)
    if abi ∉ known_abis()
        error("""
            The MPI ABI $abi is not supported.
            Please set the MPI ABI to one of the following:
            $(known_abis())
        """)
    end
    @set_preferences!("abi" => abi)
    @warn "The MPI abi has changed, you will need to restart Julia for the change to take effect" abi

    if VERSION <= v"1.6.5" || VERSION == v"1.7.0"
        @warn """
        Due to a bug in Julia (until 1.6.5 and 1.7.1), setting preferences in transitive dependencies
        is broken (https://github.com/JuliaPackaging/Preferences.jl/issues/24). As a workaround, we 
        will now add MPIABI as a direct dependency in your current project.
        """

        uuid = Preferences.get_uuid(@__MODULE__)
        project_toml, pkg_name = Preferences.find_first_project_with_uuid(uuid)

        if project_toml === nothing && pkg_name === nothing
            # If we couldn't find one, we're going to use `active_project()`
            project_toml = Base.active_project()

            # And we're going to need to add this UUID as an "extras" dependency:
            # We're going to assume you want to name this this dependency in the
            # same way as it's been loaded:
            pkg_uuid_matches = filter(d -> d.uuid == uuid, keys(Base.loaded_modules))
            if isempty(pkg_uuid_matches)
                error("Cannot set preferences of an unknown package that is not loaded!")
            end
            pkg_name = first(pkg_uuid_matches).name

            # Read in the project, add the deps, write it back out!
            project = Base.parsed_toml(project_toml)
            if !haskey(project, "deps")
                project["deps"] = Dict{String,Any}()
            end
            project["deps"][pkg_name] = string(uuid)
            open(project_toml, "w") do io
                TOML.print(io, project; sorted=true)
            end
        end
    end
    return abi
end

end # module
