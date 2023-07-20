module Preloads

any(f::Function)::Function = Base.Fix1(Base.any, f)

using Preferences, Libdl

const preloads = @load_preference("preloads")
const preloads_env_switch = @load_preference("preloads_env_switch")


function is_loaded(name)
    if dllist() |> any(x->endswith(x, name))
        return true
    end
    return false
end

"""
    dlopen_preloads()

dlopen's all preloads specified in the preloads section of MPIPreferences
"""
function dlopen_preloads()
    if !isnothing(preloads)
        if isnothing(preloads_env_switch) || get(ENV, preloads_env_switch, "0") == "1"
            for preload in preloads
                if is_loaded(preload)
                    continue
                end

                try
                    dlopen(preload, RTLD_LAZY | RTLD_GLOBAL)
                catch error
                    @error """
                        $(preload) could not be loaded, see error message below.
                        Use `MPIPreferences` to reconfigure the package and then restart Julia.
                        """ error
                end
            end
        end
    end
end

end