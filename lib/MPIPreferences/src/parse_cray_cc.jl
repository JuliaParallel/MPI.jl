module CrayParser

import Base: filter, map, reduce
filter(f::Function)::Function = x -> filter(f, x)
map(f::Function)::Function    = x -> map(f, x)
reduce(f::Function)::Function = x -> reduce(f, x)

struct CrayPE
    libmpi::String
    libgtl::String
    cclibs::Vector{String}
    gtl_env_switch::String
    
    CrayPE(mpi_dl::T, gtl_dl::T, cclibs::Vector{T}) where T <:AbstractString = new(
        "lib" * mpi_dl * ".so", # Assuming Linux -- CrayPE is only avaialbe for linux anyway
        "lib" * gtl_dl * ".so",
        cclibs,
        "MPICH_GPU_SUPPORT_ENABLED"
    )
end

const libmpi_prefix = "mpi_"
const libgtl_prefix = "mpi_gtl_"

function cray_mpi(libs)
    x = libs |>
        filter(x-> startswith(x, libmpi_prefix)) |> 
        filter(x->!startswith(x, libgtl_prefix))
    @assert length(x) == 1
    return x[1]
end

function cray_gtl(libs)
    x = libs |>
        filter(x->startswith(x, libmpi_prefix)) |> 
        filter(x->startswith(x, libgtl_prefix))
    @assert length(x) == 1
    return x[1]
end

function other_libs(libs)
    x = libs |>
        filter(x->!startswith(x, libmpi_prefix)) |> 
        filter(x->!startswith(x, libgtl_prefix))
    return x
end

function analyze_cray_cc()
    cray_opts = readchomp(Cmd(["cc", "--cray-print-opts=all"]))

    ld_paths = SubString{String}[]
    libs = SubString{String}[]
    for opt in split(cray_opts, " ")        |>
               map(x->split(x, ","))        |>
               reduce(vcat)                 |>
               map(x->replace(x, "\n"=>""))
        if startswith(opt, "-L")
            push!(ld_paths, @view opt[3:end])
        end

        if startswith(opt, "-l")
            push!(libs, @view opt[3:end])
        end
    end

    CrayPE(cray_mpi(libs), cray_gtl(libs), other_libs(libs))
end

end
